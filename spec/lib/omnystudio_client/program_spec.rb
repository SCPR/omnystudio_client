require 'omnystudio_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe OmnyStudioClient::Program do
  describe "list" do
    before :each do
      @omnystudio = OmnyStudioClient.new()
      @programs = @omnystudio.programs
    end

    it "should only perform GET requests" do
      request_uri = "https://cms.omnystudio.fm/api/programs"
      VCR.use_cassette("program_list_result_01") do
        @programs.list
        expect(WebMock).to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end
end