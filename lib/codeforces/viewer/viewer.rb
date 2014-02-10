require_relative 'version'
require_relative 'render'
require_relative 'cacher'
require_relative 'utils'

require 'nokogiri'

module Codeforces
  module Viewer
    class Viewer
      def initialize(option = {})
        @option = option
        @render = Codeforces::Viewer::Render.new
        @cacher = Codeforces::Viewer::Cacher.new @option[:cache]
      end

      # fetch problem text
      def fetch_problem_text(contest_id, problem_id)
        url = Codeforces::Viewer::Utils.get_problem_url(contest_id, problem_id)
        body = @cacher.get_url url
        doc = Nokogiri::HTML(body)
        problem_statement = doc.xpath('//div[@class="problem-statement"]')

        div_list = problem_statement.xpath('./div')

        res = {}
        res[:round]       = get_round_info(contest_id, doc)
        res[:info]        = get_problem_info(div_list[0])
        res[:body]        = @render.render(div_list[1]).text
        res[:input]       = @render.render(div_list[2]).text
        res[:output]      = @render.render(div_list[3]).text
        res[:sample_test] = @render.render(div_list[4]).text
        if div_list.length >= 6
          res[:note] = @render.render(div_list[5]).text
        else
          res[:note] = ""
        end
        res
      end

      def fetch_input(input_id, contest_id, problem_id)
        url = Codeforces::Viewer::Utils.get_problem_url(contest_id, problem_id)
        body = @cacher.get_url url
        doc = Nokogiri::HTML(body)
        @render.render_input(input_id, doc.xpath('//div[@class="sample-test"]')).map {|item| item.text.strip + "\n" }.join
      end

      def fetch_output(output_id, contest_id, problem_id)
        url = Codeforces::Viewer::Utils.get_problem_url(contest_id, problem_id)
        body = @cacher.get_url url
        doc = Nokogiri::HTML(body)
        @render.render_output(output_id, doc.xpath('//div[@class="sample-test"]')).map {|item| item.text.strip + "\n" }.join
      end

      def get_round_info(contest_id, doc)
        doc.xpath("//table//a[@href='/contest/#{contest_id}']").text.strip
      end

      # get title and other info
      def get_problem_info(doc)
        res = {
          :title        => @render.render_header(doc.xpath('//div[@class="title"]')[0]).text,
          :time_limit   => @render.render_header(doc.xpath('//div[@class="time-limit"]')[0]).text,
          :memory_limit => @render.render_header(doc.xpath('//div[@class="memory-limit"]')[0]).text,
          :input_file   => @render.render_header(doc.xpath('//div[@class="input-file"]')[0]).text,
          :output_file  => @render.render_header(doc.xpath('//div[@class="output-file"]')[0]).text,
        }
        res
      end

      def show()
        contest_id = @option[:contest_id]
        problem_id = @option[:problem_id]


        if @option[:input_only]
          puts fetch_input(@option[:input_only], contest_id, problem_id)
        elsif @option[:output_only]
          puts fetch_output(@option[:output_only], contest_id, problem_id)
        else
          ret = fetch_problem_text contest_id, problem_id
          puts "# #{ret[:round]}"
          puts "URL: #{Codeforces::Viewer::Utils.get_problem_url(contest_id, problem_id)}"
          print ret[:info][:title]
          print ret[:info][:time_limit]
          print ret[:info][:memory_limit]
          print ret[:info][:input_file]
          print ret[:info][:output_file]
          puts ""
          puts ""
          puts "   * * * * *"
          puts ""
          puts ret[:body]
          puts ""
          puts "   * * * * *"
          puts ""
          puts ret[:input]
          puts ret[:output]
          puts ""
          puts "   * * * * *"
          puts ""
          puts ret[:sample_test]
          puts ""
          puts "   * * * * *"
          puts ""
          puts ret[:note]
        end
      end
    end
  end
end

