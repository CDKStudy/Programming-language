# Dekang Cao

require_relative '../../../../core/ruby/render/core/render'

class Image
  def initialize(path)
    @image_path = path
  end

  def render(g)
    g.draw_image(@image_path)
  end
end


if __FILE__ == $0
  uri = 'https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/ruby/resources/dan128.png'
  app = RenderClient.new(Image.new(uri))
  app.main_loop
end
