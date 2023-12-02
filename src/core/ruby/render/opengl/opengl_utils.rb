require 'opengl'
require 'glu'
require 'glut'
require 'glfw'
require 'os'

class OpenGLUtils
  @@glut_is_initialized = false

  def self.setup
    # https://github.com/vaiorabbit/ruby-opengl
    OpenGL.load_lib()
    GLU.load_lib()
    if OS.windows?
      require_relative '../../../../core/ruby/download/download_utils'
      require_relative '../../../../core/ruby/zip/zip_utils'

      course_downloads_directory = DownloadUtils.downloads_directory
      FileUtils.mkdir_p course_downloads_directory
      download_glut_lib_path = File.join(course_downloads_directory, "freeglut", "bin", "x64", "freeglut.dll")
      unless File.exist?(download_glut_lib_path)
        uri = 'https://www.transmissionzero.co.uk/files/software/development/GLUT/freeglut-MinGW.zip'
        zip_file_path = File.join(course_downloads_directory, File.basename(uri))
        DownloadUtils.download_to_file(uri, zip_file_path)

        ZipUtils.unzip(zip_file_path, course_downloads_directory)

        unless File.exist?(download_glut_lib_path)
          raise download_glut_lib_path
        end
      end

      GLUT.load_lib(download_glut_lib_path)
    else
      GLUT.load_lib()
    end

    if OS.windows?
      download_glfw_lib_path = File.join(course_downloads_directory, 'glfw-3.3.2.bin.WIN64/lib-mingw-w64/glfw3.dll')
      unless File.exist?(download_glfw_lib_path)
        uri = 'https://github.com/glfw/glfw/releases/download/3.3.2/glfw-3.3.2.bin.WIN64.zip'
        zip_file_path = File.join(course_downloads_directory, File.basename(uri))
        DownloadUtils.download_to_file(uri, zip_file_path)

        ZipUtils.unzip(zip_file_path, course_downloads_directory)

        unless File.exist?(download_glfw_lib_path)
          raise download_glfw_lib_path
        end
      end

      GLFW.load_lib(download_glfw_lib_path)
    elsif OS.mac?
      require_relative 'glfw_utility'
      glfw_util = GlfwUtility.new
      downloaded_and_extracted_glfw_lib_path = glfw_util.path_to_downloaded_and_extracted_dynamic_library
      if downloaded_and_extracted_glfw_lib_path.nil?
        pattern = "{/usr/local,/opt/homebrew}/Cellar/glfw/3.*.*/lib/libglfw.dylib"
        files = Dir.glob(pattern)
        if files.length == 0
          # brew libglfw not found. Fall back to system library search path.
          GLFW.load_lib()
        else
          homebrew_lib_path = files[0]
          if files.length > 1
            puts "found multiple glfws, selecting: #{homebrew_lib_path}"
          end
          GLFW.load_lib(homebrew_lib_path)
        end
      else
        # puts "using: #{downloaded_and_extracted_glfw_lib_path}"
        GLFW.load_lib(downloaded_and_extracted_glfw_lib_path)
      end
    else
      GLFW.load_lib()
    end

    GLFW.glfwInit()

    unless OS.mac?
      unless @@glut_is_initialized
        argcp = [1].pack('I')
        argv = [""].pack('p')
        GLUT.glutInit(argcp, argv)
        @@glut_is_initialized = true
      end
    end

    if OS.mac?
      GLFW.glfwWindowHint(GLFW::GLFW_COCOA_RETINA_FRAMEBUFFER, GLFW::GLFW_FALSE)
    end

  end

  def self.teardown
    GLFW.glfwTerminate()
  end
end
