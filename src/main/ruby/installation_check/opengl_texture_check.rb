require 'opengl'
require 'chunky_png'
require_relative '../../../core/ruby/download/download_utils'
require_relative '../../../core/ruby/render/core/render'

class OpenGLTextureCheck
  include OpenGL

  def initialize(sub_path)
    if File.exist?(sub_path)
      path = sub_path
    else
      begin
        path = File.join(__dir__, sub_path)
      rescue
        path = sub_path
      end
    end
    unless File.exist?(path)
      path = DownloadUtils.download("https://www.cse.wustl.edu/~dennis.cosgrove/courses/cse425s/timeless/ruby/resources/" + sub_path)
    end
    @image = ChunkyPNG::Image.from_file(path)
    @data = @image.to_rgb_stream.each_byte.to_a.pack("C*")
  end

  def render(g)
    glRasterPos2f(-0.5,0.5)
    glPixelZoom(1,-1)
    glDrawPixels(@image.width, @image.height, GL_RGB, GL_UNSIGNED_BYTE, @data)
  end
end

if __FILE__ == $0
  app = RenderClient.new(OpenGLTextureCheck.new('ruby_logo.png'), title: 'OpenGL Texture Check')
  app.main_loop
end