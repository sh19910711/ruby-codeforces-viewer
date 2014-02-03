require 'spec_helper'

describe Codeforces::Viewer::Viewer do
  before do
    @viewer = Codeforces::Viewer::Viewer.new
  end

  before do
    FakeFS.deactivate!
    dummy_response_365A = SpecHelpers.read_file ['mock', 'problem_text_365A.html']
    dummy_response_350A = SpecHelpers.read_file ['mock', 'problem_text_350A.html']
    FakeFS.activate!
    WebMock.stub_request(:get, /http:\/\/codeforces\.com\/contest\/[0-9]*?\/problem/).to_return(
      :body => dummy_response_365A,
    )
    WebMock.stub_request(:get, /http:\/\/codeforces\.com\/contest\/350\/problem\/A/).to_return(
      :body => dummy_response_350A,
    )
  end

  context :get_problem_text do
    it do
      ret = @viewer.fetch_problem_text '350', 'A'
      # TODO: improve here
    end
  end

  context :get_round_info do
    it do
      url = Codeforces::Viewer::Utils.get_problem_url '350', 'A'
      body = Net::HTTP.get URI.parse url
      doc = Nokogiri::HTML(body)
      expect(@viewer.get_round_info('350', doc)).to eq 'Codeforces Round #203 (Div. 2)'
    end
    it do
      url = Codeforces::Viewer::Utils.get_problem_url '365', 'A'
      body = Net::HTTP.get URI.parse url
      doc = Nokogiri::HTML(body)
      expect(@viewer.get_round_info('365', doc)).to eq 'Codeforces Round #213 (Div. 2)'
    end
  end
end

