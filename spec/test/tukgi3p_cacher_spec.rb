require 'spec_helper'

describe Codeforces::Viewer::Cacher do
  before do
    @cacher = Codeforces::Viewer::Cacher.new true, ".cache"
  end

  context :cache do
    before do
      WebMock.stub_request(:get, /^http:\/\/foo\/bar$/).to_return(
        :body => 'this is test',
      )
    end

    it "enable cache: http://foo/bar" do
      url = "http://foo/bar"
      ret = @cacher.get_url url
      expect(ret).to eq File.read ".cache/#{Digest::MD5.hexdigest(url)}"
    end

    it "disable cache: http://foo/bar" do
      @cacher = Codeforces::Viewer::Cacher.new false
      url = "http://foo/bar"
      ret = @cacher.get_url url
      expect { File.read(".cache/#{Digest::MD5.hexdigest(url)}") }.to raise_error
    end
  end
end

