require 'omnystudio_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe OmnyStudioClient::Episode do
  describe "create" do
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @podcast = @omnystudio.podcast('STUB_PODCAST_ID')
    end

    it "should return an ArgumentError if lacking any of the required options: program_id, body, body[:title], body[:pubdate]" do
      podcast_without_id = @omnystudio.podcast
      podcast_with_id = @podcast

      expect { podcast_without_id.episode.create }.to raise_error(ArgumentError)
      expect { podcast_with_id.episode.create }.to raise_error(ArgumentError)
      expect { podcast_with_id.episode.create({}) }.to raise_error(ArgumentError)
      expect { podcast_with_id.episode.create({ title: "example_title" }) }.to raise_error(ArgumentError)
      expect { podcast_with_id.episode.create({ pubdate: "2020-06-01T14:54:02.690Z" }) }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("create_result_01") do
        @podcast.episode.create({
          title: "This is a test title",
          pubdate: "2020-06-01T14:54:02.690Z"
        })

        expect(WebMock).to have_requested(:post, request_uri)
          .with(body: "{\"title\":\"This is a test title\",\"pubdate\":\"2020-06-01T14:54:02.690Z\"}")
      end
    end

    it "should only perform POST requests" do
      VCR.use_cassette("create_result_01") do
        @podcast.episode.create({
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
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes/STUB_EPISODE_ID"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @podcast = @omnystudio.podcast('STUB_PODCAST_ID')
    end

    it "should return an ArgumentError if no program_id or episode_id is given" do
      podcast_without_id = @omnystudio.podcast

      expect { podcast_without_id.episode.delete }.to raise_error(ArgumentError)
    end

    it "should only perform DELETE requests" do
      VCR.use_cassette("delete_result_01") do
        @podcast.episode("STUB_EPISODE_ID").delete

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
      @episodes = @omnystudio.episodes
    end

    it "should only perform GET requests" do
      request_uri = "https://cms.omnystudio.fm/api/search/episodes"
      VCR.use_cassette("search_result_01") do
        @episodes.search
        expect(WebMock).to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end

  describe "update" do
    request_uri = "https://cms.omnystudio.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes/STUB_EPISODE_ID"

    before :each do
      @omnystudio = OmnyStudioClient.new({ network_id: "STUB_NETWORK_ID" })
      @podcast = @omnystudio.podcast('STUB_PODCAST_ID')
    end

    it "should return an ArgumentError if no program_id or episode_id is given" do
      expect { @podcast.episode.update }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("update_result_01") do
        @podcast.episode("STUB_EPISODE_ID").update({
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
        @podcast.episode("STUB_EPISODE_ID").update

        expect(WebMock).to have_requested(:put, request_uri)
          .with(body: "{}")
      end
    end

    it "should only perform PUT requests" do
      VCR.use_cassette("update_result_01") do
        @podcast.episode("STUB_EPISODE_ID").update

        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end
end