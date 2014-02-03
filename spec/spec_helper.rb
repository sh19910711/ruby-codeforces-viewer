require 'codeforces/viewer'

require 'fakefs/safe'
require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers
end

require 'webmock'
WebMock.disable_net_connect!

module SpecHelpers
  def self.read_file array_of_path
    File.read get_path(array_of_path)
  end

  def self.get_path array_of_path
    File.expand_path(File.join(File.dirname(__FILE__), File.join(array_of_path)))
  end
end

