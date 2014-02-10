module Codeforces
  module Viewer
    module Utils
      def self.get_problem_url contest_id, problem_id
        "http://codeforces.com/contest/#{contest_id}/problem/#{problem_id}"
      end
    end
  end
end
