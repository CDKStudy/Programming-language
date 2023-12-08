# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'
require_relative 'transform'
class Image < Transform
  def initialize(path, x: 0, y: 0)
    super(x, y)
    @image_path = path
  end

  private

  def untransformed_render(g)
    g.draw_image(@image_path)
  end
  def untransformed_bounds
    raise StandardError.new("not yet implemented")
  end
end


if __FILE__ == $0
  uri = 'https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/ruby/resources/dan128.png'
  app = RenderClient.new(Image.new(uri))
  app.main_loop
end
