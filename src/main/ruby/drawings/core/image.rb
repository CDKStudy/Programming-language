# __STUDENT_NAME__

require_relative '../../../../core/ruby/render/core/render'

class Image
end


if __FILE__ == $0
  uri = 'https://www.cse.wustl.edu/~cosgroved/courses/cse425s/timeless/ruby/ruby/resources/dan128.png'
  app = RenderClient.new(Image.new(uri))
  app.main_loop
end
