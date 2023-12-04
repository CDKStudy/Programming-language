require_relative 'snapshot_generator'
require_relative '../download/download_utils.rb'
require 'chunky_png'

class Row
  attr_reader :instance, :eval_exception
  attr_accessor :diff_report, :is_filtered_out

  def initialize(pair)
    @pair = pair
    begin
      @instance = eval(eval_text)
      @eval_exception = nil
    rescue => exception
      @eval_exception = exception
      @instance = nil
    end
    @diff_report = nil
    @is_filtered_out = false
  end

  def eval_text
    @pair.eval_text.strip
  end

  def filename
    "#{image_sub_path}.png"
  end

  def passes_filter?
    if ARGV.count > 0
      ARGV.each do |arg|
        if image_sub_path.include?(arg)
          return true
        end
      end
    else
      return true
    end
    return false
  end

  def image_sub_path
    @pair.image_sub_path
  end
end

class TestSnapshotsWebPageGenerator
  def initialize(info, html_page_filename, title, expected_sub_path, is_diff_desired: true, snapshot_generator: SnapshotGenerator.new(), is_complete: true)
    @is_diff_desired = is_diff_desired
    @snapshot_generator = snapshot_generator
    @rows = info.eval_text_image_sub_path_pairs(is_complete: is_complete).map { |pair| Row.new(pair) }
    @html_page_filename = html_page_filename
    @title = title + if ARGV.count > 0
                       ";    ARGV=#{ARGV}"
                     else
                       ""
                     end
    @expected_sub_path = expected_sub_path
  end

  def generate(&block)
    generate_pngs(&block)
    generate_diffs(&block)
    generate_html(&block)
  end

  def teardown
    @snapshot_generator.teardown
  end

  private

  def is_desired(row, &block)
    if block_given?
      if row.eval_exception.nil?
        yield [row.instance, row.eval_text]
      else
        false
      end
    else
      true
    end
  end

  def generate_pngs(&block)
    @rows.each do |row|
      if is_desired(row, &block)
        if File.exist?(actual_filename(row))
          FileUtils.remove(actual_filename(row))
        end
        if row.passes_filter?
          raise row.filename if File.exist?(row.filename)
          begin
            puts
            puts "generating image for:"
            puts row.eval_text

            png = @snapshot_generator.generate_png(row.instance)

            is_normal_condition = true
            if is_normal_condition
              prefix = "actual"
            else
              prefix = "expected"
            end

            png_path = "#{prefix}_#{row.filename}"
            puts "saving #{png_path}"
            save_png(png, png_path)
            puts "complete."
          rescue StandardError => e
            puts e
          end
        end
      end
    end
  end

  def png_from_uri(uri)
    begin
      download = DownloadUtils.download(uri)
      blob = download.read
      ChunkyPNG::Image.from_blob(blob)
    rescue StandardError => e
      is_raise_desired = false
      if is_raise_desired
        raise e
      else
        puts "FAILURE: png_from_uri #{uri}"
        puts e.message
        puts e.backtrace.inspect
        nil
      end
    end
  end

  def expected_url_prefix
    "https://www.cse.wustl.edu/~cosgroved/courses/cse425s/spring22/ruby/render/#{@expected_sub_path}"
  end

  def expected_url(filename)
    "#{expected_url_prefix}/expected_#{filename}"
  end

  def actual_filename(row)
    "actual_#{row.filename}"
  end

  def diff_filename(row)
    "diff_#{row.filename}"
  end

  def generate_diffs(&block)
    if @is_diff_desired
      require_relative 'image_diff'
      @rows.each do |row|
        if is_desired(row, &block)
          if File.exist?(diff_filename(row))
            FileUtils.remove(diff_filename(row))
          end
          if row.passes_filter?
            actual_path = File.join(generated_directory_name, actual_filename(row))
            puts

            puts "diffing image #{actual_path}"
            if File.exist?(actual_path)
              actual = ChunkyPNG::Image.from_file(actual_path)
            else
              actual = nil
            end
            uri = expected_url(row.filename)
            expected = png_from_uri(uri)
            # raise uri if expected.nil?
            if expected.nil?
              row.diff_report = "<strong>no expected image</strong>"
            else
              if actual.nil?
                row.diff_report = "<strong>no actual image</strong>"
              else
                diff = ImageDiff.create_diff_image(expected, actual)
                save_png(diff, diff_filename(row))
                n_exact = ImageDiff.diff_pixel_count_exact(expected, actual)
                if n_exact == 0
                  row.diff_report = "identical"
                else
                  n_allow_neighbors = ImageDiff.diff_pixel_count_allow_neighbors(expected, actual)
                  if n_allow_neighbors == 0
                    row.diff_report = "close enough: all pixels pass if you also check neighbors"
                  else
                    total = expected.width * expected.height
                    row.diff_report = "<strong>#{n_exact}</strong>/#{total} pixels are different"
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def generate_html(&block)
    is_erb_desired = false
    create_generated_directory_if_necessary
    html_path = File.join(generated_directory_name, @html_page_filename)
    File.open(html_path, 'w') do |file|
      if is_erb_desired
        require 'erb'
        template = %{
<html>
  <head>
    <title><%= @title %></title>
  </head>
  <body>
    <h1><%= @title %></h1>
    <table>
      <tr><th>Expected</th><th>Actual</th><th>Diff</th><th>Report</th><tr>
      <% @rows.each do |row| %>
        <tr><td><img src="<%= expected_url_prefix + "/" + row.filename %>"></td><td><img src="<%= row.filename %>"></td><td><img src="diff_<%= row.filename %>"></td><td><%= row.diff_report %></td></tr>
      <% end %>
    </table>
  </body>
</html>
}
        erb = ERB.new(template)
        s = erb.result(binding)

      else
        is_template_desired = @is_diff_desired
        if is_template_desired
          template = %{<!DOCTYPE html>
<html>
<!--
https://www.w3schools.com/howto/howto_js_tabs.asp
-->
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {font-family: Arial;}

        /* Style the tab */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

        /* Style the buttons inside the tab */
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current tablink class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-top: none;
        }
    </style>
    <title>__TITLE__</title>
</head>
<body>
<h1>__TITLE__</h1>
<div class="tab">
    <button class="tablinks" onclick="openTab(event, 'All')" id="defaultOpen">All</button>
    <button class="tablinks" onclick="openTab(event, 'ErrorsOnly')">__ERROR_TAB_TEXT__</button>
</div>

<div id="All" class="tabcontent">
    __ALL__
</div>

<div id="ErrorsOnly" class="tabcontent">
    __ERRORS_ONLY__
</div>

<script>
    function openTab(evt, tabName) {
        var i, talbcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    document.getElementById("defaultOpen").click();
</script>

</body>
</html>}
          s = template.gsub("__TITLE__", @title)
          s = s.gsub("__ALL__", generate_sub_text(true, &block))
          s = s.gsub("__ERRORS_ONLY__", generate_sub_text(false, &block))
          error_count = 0
          @rows.each do |row|
            if is_desired(row, &block)
              if row_error?(row)
                error_count += 1
              end
            end
          end
          case error_count
          when 0
            error_tab_text = "No Errors"
          when 1
            error_tab_text = "1 Error"
          else
            error_tab_text = "#{error_count} Errors"
          end
          s = s.gsub("__ERROR_TAB_TEXT__", error_tab_text)
        else
          s = "<html>\n"
          s += "<head>\n"
          s += "<title>"
          s += @title
          s += "</title>\n"
          s += "</head>\n"
          s += "<body>\n"
          s += "<h1>"
          s += @title
          s += "</h1>\n"
          s += generate_sub_text(true, &block)
          s += "</body>\n"
          s += "</html>"
        end
        file.write(s)
      end
    end
    require 'opener'
    Opener.spawn(html_path)
  end

  private

  def row_error?(row)
    row.diff_report.nil? or not (row.diff_report == "identical" or row.diff_report.start_with?("close enough"))
  end

  def generate_row(is_all, row)
    s = ""
    if is_all or row_error?(row)
      if row.passes_filter?
        s += '<br/>'
      end
      s += "<h3>#{row.image_sub_path}"
      if not row.passes_filter?
        s += ' (filtered out)'
      end
      s += "</h3>"
      if row.passes_filter?
        s += '<pre>'
        text = row.eval_text.gsub(";\n", "<br/>")
        text = text.gsub(";", "<br/>")
        s += text
        s += '</pre>'

        s += "<table>\n"
        s += "<tr>"
        s += "<th>"
        s += "Expected"
        s += "</th>"
        s += "<th>"
        s += "Actual"
        s += "</th>"
        if @is_diff_desired
          s += "<th>"
          s += "Diff"
          s += "</th>"
          s += "<th>"
          s += "Report"
          s += "</th>"
        end
        s += "</tr>\n"
        s += '<tr>'
        s += "</tr>"
        s += "<tr>"
        s += "<td>"
        s += "<img src=\"#{expected_url(row.filename)}\"</img><br>"
        s += "</td>"
        s += "<td>"
        s += "<img src=\"#{actual_filename(row)}\"</img><br>"
        s += "</td>"
        if @is_diff_desired
          s += "<td>"
          s += "<img src=\"#{diff_filename(row)}\"</img><br>"
          s += "</td>"
          s += "<td>"
          s += "#{row.diff_report}"
          s += "</td>"
        end
        s += "</tr>\n"
        s += "</table>\n"
      end
    end
    s
  end

  def generate_sub_text(is_all, &block)
    s = ""
    @rows.each do |row|
      if is_desired(row, &block)
        s += generate_row(is_all, row)
      else
        unless row.eval_exception.nil?
          s += "<h3>#{row.image_sub_path}</h3>"
          s += '<pre>'
          text = row.eval_text.gsub(";\n", "<br/>")
          text = text.gsub(";", "<br/>")
          s += text
          s += '</pre>'
          e = row.eval_exception
          s += "<details>"
          # credit: https://stackoverflow.com/questions/13311694/how-to-format-ruby-exception-with-backtrace-into-a-string
          summary_text = "#{e.backtrace.first}: #{e.message} (#{e.class})"
          summary_text.strip!
          s += "<summary><tt>#{summary_text}</tt></summary>"
          s += "<pre>"
          e.backtrace.drop(1).each do |x|
            s += "\t"
            s += x
            s += "\n"
          end
          s += "</pre>"
          s += "</details>"
        end
      end
    end
    s
  end

  def create_generated_directory_if_necessary
    FileUtils.mkdir_p generated_directory_name
    gitignore_path = File.join(generated_directory_name, ".gitignore")
    unless File.exist?(gitignore_path)
      File.write(gitignore_path, '*')
    end
  end

  def generated_directory_name
    "generated"
  end

  def save_png(png, file_name)
    create_generated_directory_if_necessary
    png.save(File.join(generated_directory_name, file_name))
  end
end
