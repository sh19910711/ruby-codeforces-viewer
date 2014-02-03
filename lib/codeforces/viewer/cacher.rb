require_relative 'constants'

require 'digest/md5'
require 'fileutils'
require 'net/http'
require 'uri'

module Codeforces
  module Viewer
    class Cacher
      attr_accessor :option

      def initialize(enabled = true, cache_dir = DEFAULT_CACHE_DIR)
        @option = {}
        @option[:enabled] = enabled
        if @option[:enabled]
          @option[:cache_dir] = File.expand_path cache_dir
          FileUtils.mkdir_p @option[:cache_dir]
        end
      end

      def get_url(url)
        file_path = "#{@option[:cache_dir]}/#{Digest::MD5.hexdigest url}"
        if @option[:enabled] && File.exists?(file_path)
          File.read file_path
        else
          body = Net::HTTP.get URI.parse url
          if @option[:enabled]
            FileUtils.touch file_path
            File.write file_path, body
          end
          body
        end
      end
    end
  end
end

