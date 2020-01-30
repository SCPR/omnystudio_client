require 'omnystudio_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe OmnyStudioClient::Clip do
  describe "create" do
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/programs/STUB_PROGRAM_ID/clips"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @program = @omnystudio.program('STUB_PROGRAM_ID')
    end

    it "should return an ArgumentError if lacking any of the required options: program_id, body, body[:title], body[:pubdate]" do
      program_without_id = @omnystudio.program
      program_with_id = @program

      expect { program_without_id.clip.create }.to raise_error(ArgumentError)
      expect { program_with_id.clip.create }.to raise_error(ArgumentError)
      expect { program_with_id.clip.create({}) }.to raise_error(ArgumentError)
      expect { program_with_id.clip.create({ title: "example_title" }) }.to raise_error(ArgumentError)
      expect { program_with_id.clip.create({ pubdate: "2020-06-01T14:54:02.690Z" }) }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("create_result_01") do
        @program.clip.create({
          title: "This is a test title",
          pubdate: "2020-06-01T14:54:02.690Z"
        })

        expect(WebMock).to have_requested(:post, request_uri)
          .with(body: "{\"title\":\"This is a test title\",\"pubdate\":\"2020-06-01T14:54:02.690Z\"}")
      end
    end

    it "should only perform POST requests" do
      VCR.use_cassette("create_result_01") do
        @program.clip.create({
          title: "This is a test title",
          pubdate: "2020-06-01T14:54:02.690Z"
        })

        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end

  describe "delete" do
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/programs/STUB_PROGRAM_ID/clips/STUB_CLIP_ID"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @program = @omnystudio.program('STUB_PROGRAM_ID')
    end

    it "should return an ArgumentError if no program_id or clip_id is given" do
      program_without_id = @omnystudio.program

      expect { program_without_id.clip.delete }.to raise_error(ArgumentError)
    end

    it "should only perform DELETE requests" do
      VCR.use_cassette("delete_result_01") do
        @program.clip("STUB_CLIP_ID").delete

        expect(WebMock).to have_requested(:delete, request_uri)
        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
      end
    end
  end

  describe "search" do
    before :each do
      @omnystudio = OmnyStudioClient.new
      @clips = @omnystudio.clips
    end

    it "should only perform GET requests" do
      request_uri = "https://cms.omnystudio.fm/api/search/clips"
      VCR.use_cassette("search_result_01") do
        @clips.search
        expect(WebMock).to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end

  describe "update" do
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/programs/STUB_PROGRAM_ID/clips/STUB_CLIP_ID"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @program = @omnystudio.program('STUB_PROGRAM_ID')
    end

    it "should return an ArgumentError if no program_id or clip_id is given" do
      expect { @program.clip.update }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("update_result_01") do
        @program.clip("STUB_CLIP_ID").update({
          preCount: 1,
          postCount: 2,
          insertionPoints: ["10.1", "15.23", "18"]
        })

        expect(WebMock).to have_requested(:put, request_uri)
          .with(body: "{\"preCount\":1,\"postCount\":2,\"insertionPoints\":[\"10.1\",\"15.23\",\"18\"]}")
      end
    end

    it "should pass an empty body if not given in options" do
      VCR.use_cassette("update_result_02") do
        @program.clip("STUB_CLIP_ID").update

        expect(WebMock).to have_requested(:put, request_uri)
          .with(body: "{}")
      end
    end

    it "should only perform PUT requests" do
      VCR.use_cassette("update_result_01") do
        @program.clip("STUB_CLIP_ID").update

        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end
end