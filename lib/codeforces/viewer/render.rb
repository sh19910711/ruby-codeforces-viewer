require 'colorize'
require 'nokogiri'

module Codeforces
  module Viewer
    class Render
      def render_list_item(depth, doc, number = false)
        cnt = 0
        doc.children.each do |item|
          case item.name
          when "ol", "ul"
            item = render_list(depth, item)
          when "li"
            if number
              cnt += 1
              item.content = "#{" " * depth}#{cnt}. #{item.text}\n"
            else
              item.content = "#{" " * depth}* #{item.text}\n"
            end
          end
        end
        doc
      end

      def render_list(depth, doc)
        case doc.name
        when "ol"
          doc = render_list_item(depth + 2, doc, true)
        when "ul"
          doc = render_list_item(depth + 2, doc)
        end
        doc.content = "#{doc.text}\n"
        doc
      end

      def render_normal_tag(doc)
        case doc.name
        when "div", "pre"
          doc.content = "\n#{doc.content}\n"
        when "p"
          doc.content = "\n\n#{doc.content}\n\n"
        when "ol"
          doc = render_list(0, doc)
        when "br"
          doc.content = "\n"
        when "sup"
          doc.content = "^#{doc.content}"
        when "sub"
          doc.content = "[#{doc.content}]"
        when "img"
          doc.content = "\n!! Image File: #{doc["src"]}\n\n"
        end
        doc
      end

      def render_header_class(doc)
        case doc["class"]
        when "title", "section-title"
          doc.content = "# #{doc.text.strip}".colorize(:mode => :bold)
        when "tex-span", "tex-font-style-tt"
          doc.content = doc.text.strip.colorize(:mode => :bold)
        when "property-title"
          doc.content = doc.text.strip.colorize(:mode => :underline)
        end
        doc
      end

      def render_header(doc)
        doc = render_header_class(doc)
        if doc.children.length > 0
          doc.children.map {|item| render_header item }
        end
        doc = render_normal_tag(doc)
        doc
      end

      def render(doc)
        if doc.children.length > 0
          doc.children.map {|item| render item }
        end
        doc = render_normal_tag(doc)
        doc = render_header_class(doc)
        doc
      end

      def render_html(html)
        render(Nokogiri::HTML.fragment(html)).text
      end

      def render_input(input_id, doc)
        input_id = input_id.to_i
        if input_id == 0
          doc.xpath('./div[@class="input"]/pre').map {|item| render item }
        else
          [render(doc.xpath('./div[@class="input"]/pre')[input_id - 1])]
        end
      end

      def render_output(output_id, doc)
        output_id = output_id.to_i
        if output_id == 0
          doc.xpath('./div[@class="output"]/pre').map {|item| render item }
        else
          [render(doc.xpath('./div[@class="output"]/pre')[output_id - 1])]
        end
      end
    end
  end
end

