require 'rails_helper'

RSpec.describe Request do
  let!(:url) { 'https://test-url.com' }
  let!(:request_params) { { method: :get, body: {}, headers: {} } }

  describe 'build_request method' do
    let!(:expected_params) do
      { :method=>:get, :headers=>{}, :body=>{}, :ssl_verifypeer=>false, :ssl_verifyhost=>0,
        :accept_encoding=>"gzip", :timeout=>60, :connecttimeout=>40, :forbid_reuse=>true }
    end

    it 'builds Typhoeus request with correct params' do
      expect(Typhoeus::Request).to receive(:new).with(url, expected_params)
      result = Request.build(url, request_params)
    end
  end
end
