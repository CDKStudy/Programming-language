class GlfwUtility
  def download_and_extract
    require_relative '../../download/download_utils'
    require_relative '../../zip/zip_utils'
    zip_file_path = DownloadUtils.download_if_necessary(url)
    ZipUtils.unzip(zip_file_path, DownloadUtils.downloads_directory)
    path = path_to_dynamic_library
    if File.exist?(path)
      puts "#{path} exists"
    else
      raise path
    end
  end

  def path_to_downloaded_and_extracted_dynamic_library
    path = path_to_dynamic_library
    if File.exist?(path)
      path
    else
      nil
    end
  end

  private def path_to_dynamic_library
    File.join(DownloadUtils.downloads_directory, basename, 'lib-universal', 'libglfw.3.dylib')
  end

  private def url
    "https://github.com/glfw/glfw/releases/download/3.3.8/#{basename}.zip"
  end

  private def basename
    'glfw-3.3.8.bin.MACOS'
  end
end
