require 'omnystudio_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe OmnyStudioClient do
  describe "OmnyStudio.config" do
    it "should equal OmnyStudioClient if OmnyStudioClient is set up" do
      @omnystudio = OmnyStudioClient.new({
        network_id: "STUB_NETWORK_ID",
        organization_id: "STUB_ORGANIZATION_ID",
        token: "STUB_TOKEN"
      })

      expect(@omnystudio.episodes.config.token).to eq "STUB_TOKEN"
      expect(@omnystudio.episodes.config.network_id).to eq "STUB_NETWORK_ID"
      expect(@omnystudio.episodes.config.organization_id).to eq "STUB_ORGANIZATION_ID"
      expect(@omnystudio.podcasts.config.token).to eq "STUB_TOKEN"
      expect(@omnystudio.podcasts.config.network_id).to eq "STUB_NETWORK_ID"
      expect(@omnystudio.podcasts.config.organization_id).to eq "STUB_ORGANIZATION_ID"
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
          url: "https://cms.omnystudio.fm/api/search/episodes",
          method: :get,
          params: {
            published: true
          }
        })
        expect(WebMock).to have_requested(:get, "https://cms.omnystudio.fm/api/search/episodes?published=true").once
      end

    end
  end
end