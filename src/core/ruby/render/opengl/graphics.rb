require 'chunky_png'
require_relative '../../download/download_utils'

class Graphics
  include OpenGL, GLU, GLUT

  def initialize
    super
    @pixel_zoom_stack = []
  end

  # @param background_color [Color]
  def clear(background_color)
    unless background_color.nil?
      glClearColor(background_color.red, background_color.green, background_color.blue, 1.0)
      glClear(GL_COLOR_BUFFER_BIT)
    end
  end

  # @param text [String]
  # @param font [Font]
  # @param x [Numeric]
  # @param y [Numeric]
  def draw_string(text, font, x, y)
    raise text if font.nil?
    bitmap_font = to_bitmap_font(font)
    glRasterPos2f(x, y)
    text.each_byte do |c|
      glutBitmapCharacter(bitmap_font, c)
    end
  end

  # @param control_points [Array<Point>]
  def draw_curve(control_points)
    flat3d = []
    control_points.each do |cp|
      flat3d.push(cp.x)
      flat3d.push(cp.y)
      flat3d.push(0.0)
    end

    control_points_flattened_and_packed = flat3d.pack("f*")

    glMap1f(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, control_points.length, control_points_flattened_and_packed)
    glEnable(GL_MAP1_VERTEX_3)
    glBegin(GL_LINE_STRIP)
    resolution_of_curve = 48
    resolution_of_curve.times do |i|
      glEvalCoord1f(i.to_f / resolution_of_curve)
    end
    glEvalCoord1d(0.999999) # some graphics cards seem to drop the last point!
    glEvalCoord1d(1.0)
    glEnd()
  end

  # @param uri [String]
  def draw_image(uri)
    width, height, data = lookup_uri(uri)
    glRasterPos2f(0, 0)
    preserve_previous_and_set_pixel_zoom(1, -1)
    glDrawPixels(width, height, GL_RGB, GL_UNSIGNED_BYTE, data)
    restore_previous_pixel_zoom
  end

  # @param points [Array<Point>]
  def draw_convex_polygon(points)
    glBegin(GL_POLYGON)
    # glBegin(GL_TRIANGLE_FAN)
    points.each do |pt|
      glVertex2f(pt.x, pt.y)
    end
    glEnd()
  end

  def push_affine_transform
    glPushMatrix()
  end

  def pop_affine_transform
    glPopMatrix()
  end

  # @param x [Numeric]
  # @param y [Numeric]
  def apply_translation(x, y)
    glTranslatef(x, y, 0)
  end

  # @param theta_in_degrees [Numeric]
  def apply_rotation(theta_in_degrees)
    glRotatef(theta_in_degrees, 0, 0, 1)
  end

  # @param color [Color]
  def color=(color)
    glColor3f(color.red, color.green, color.blue) unless color.nil?
  end

  private

  @@image_uri_to_width_height_data_hash = {}

  def lookup_uri(uri)
    width, height, data = @@image_uri_to_width_height_data_hash[uri]
    if data.nil?
      path = DownloadUtils.download(uri)
      image = ChunkyPNG::Image.from_file(path)
      width = image.width
      height = image.height
      data = image.to_rgb_stream.each_byte.to_a.pack("C*")
      @@image_uri_to_width_height_data_hash[path] = [width, height, data]
    end
    [width, height, data]
  end

  def preserve_previous_and_set_pixel_zoom(x, y)
    prev_zoom_x = gl_get_float(GL_ZOOM_X)
    prev_zoom_y = gl_get_float(GL_ZOOM_Y)
    @pixel_zoom_stack.push([prev_zoom_x, prev_zoom_y])
    glPixelZoom(x, y)
  end

  def restore_previous_pixel_zoom
    prev_zoom_x, prev_zoom_y = @pixel_zoom_stack.pop
    glPixelZoom(prev_zoom_x, prev_zoom_y)
  end

  def to_bitmap_font(font)
    if font == Font::TIMES_ROMAN_10
      GLUT_BITMAP_TIMES_ROMAN_10
    elsif font == Font::TIMES_ROMAN_24
      GLUT_BITMAP_TIMES_ROMAN_24
    elsif font == Font::HELVETICA_10
      GLUT_BITMAP_HELVETICA_10
    elsif font == Font::HELVETICA_12
      GLUT_BITMAP_HELVETICA_12
    elsif font == Font::HELVETICA_18
      GLUT_BITMAP_HELVETICA_18
    else
      raise "#{font.class}"
    end
  end

  private

  def gl_get_float(p)
    data = packFloat(0.0)
    glGetFloatv(p, data)
    unpackFloat(data)
  end

  def packFloat(f)
    array = [f]
    array.pack('f')
  end

  def unpackFloat(data)
    array = data.unpack('f')
    array[0]
  end

end
