require 'omnystudio_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe OmnyStudioClient do
  describe "OmnyStudio.config" do
    it "should equal OmnyStudioClient if OmnyStudioClient is set up" do
      @omnystudio = OmnyStudioClient.new({
        token: "STUB_TOKEN"
      })

      expect(@omnystudio.clips.config.token).to eq "STUB_TOKEN"
      expect(@omnystudio.programs.config.token).to eq "STUB_TOKEN"
    end
  end

  describe "OmnyStudio.default_headers" do
    it "should apply a token from configuration" do
      @omnystudio = OmnyStudioClient.new({ token: "STUB_TOKEN" })
      expect(@omnystudio.default_headers[:authorization]).to include "STUB_TOKEN"
    end
  end

  describe "OmnyStudio.connection" do
    before :each do
      @omnystudio = OmnyStudioClient.new
    end

    it "should add params to request_headers if they exist" do
      VCR.use_cassette("connection_result_01") do
        @omnystudio.connection({
          url: "https://cms.omnystudio.fm/api/search/clips",
          method: :get,
          params: {
            published: true
          }
        })
        expect(WebMock).to have_requested(:get, "https://cms.omnystudio.fm/api/search/clips?published=true").once
      end

    end
  end
end