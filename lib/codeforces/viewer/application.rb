require_relative 'version'
require_relative 'viewer'
require 'optparse'

module Codeforces
  module Viewer
    class Application
      attr_accessor :option

      def initialize
        @option = {
          :contest_id  => nil,
          :problem_id  => nil,
          :input_only  => false,
          :output_only => false,
          :cache       => true,
        }
      end

      def parse_options(argv)
        OptionParser.new do |option_parser|
          option_parser.banner = "Usage: codeforces_viewer -c {contest-id} -p {problem-id} [options]"
          option_parser.separator ""
          option_parser.version = Codeforces::Viewer::VERSION

          # contest id
          option_parser.on('-c contest-id', '--contest-id contest-id', 'specify codeforces contest id (e.g. 100, 99)', String) {|contest_id| @option[:contest_id] = contest_id }

          # problem_id
          option_parser.on('-p problem-id', '--problem-id problem-id', 'specify codeforces problem id (e.g. A, B)', String) {|problem_id| @option[:problem_id] = problem_id }
          
          option_parser.separator ""

          # show input only
          option_parser.on('-i input-no', '--input input-no', 'specify sample input id (0 is all)', Integer) {|flag| @option[:input_only] = flag }
          
          # show output only
          option_parser.on('-o input-no', '--output input-no', 'specify sample output id (0 is all)', Integer) {|flag| @option[:output_only] = flag }
          
          option_parser.separator ""

          # no cache
          option_parser.on('--no-cache', 'no cache html files') {|flag| @option[:cache] = flag }

          option_parser.separator ""

          # parse
          option_parser.parse! argv
        end

        # check
        if @option[:contest_id].nil? || @option[:contest_id] == ""
          abort "Error: contest id must be specified"
        end
        if @option[:problem_id].nil? || @option[:problem_id] == ""
          abort "Error: problem id must be specified"
        end
      end

      def show
        viewer = Codeforces::Viewer::Viewer.new @option
        viewer.show
      end
    end
  end
end

