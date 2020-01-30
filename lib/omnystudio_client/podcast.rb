require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class Podcast

    # @return a OmnyStudioClient::Podcast instance
    # @note This is used to initialize the podcast id when creating a new Podcast instance
    # @example Create a new instance of OmnyStudioClient::Podcast
    #   OmnyStudioClient::Podcast.new("{program_id}") #=> #<OmnyStudioClient::Podcast @id="{program_id}">

    def initialize(id=nil)
      @id = id
    end

    # @return a OmnyStudioClient::Episode instance
    # @note This is used to call a new Episode instance with a given podcast id and episode_id
    # @example Call a new instance of OmnyStudioClient::Episode
    #   omnystudio.podcast("12345").episode("56789") #=> #<OmnyStudioClient::Episode @id="{episode_Id}" @program_id="{program_id}" >

    def episode(episode_id=nil)
      OmnyStudioClient::Episode.new(@id, episode_id)
    end

    # @return a OmnyStudioClient::EpisodeCollection instance
    # @note This is used to call a new Episodes instance with a given podcast id
    # @example Call a new instance of OmnyStudioClient::EpisodeCollection
    #   omnystudio.podcast("12345").episodes #=> #<OmnyStudioClient::EpisodeCollection @program_id="{program_id}" >

    def episodes
      OmnyStudioClient::EpisodeCollection.new(@id)
    end

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= OmnyStudioClient
    end

    # @return a struct that represents a podcast of a given podcast id
    # @note It needs to be initialized with an @id, otherwise it will return an ArgumentError
    # @see OmnyStudioClient#connection
    # @example Show a podcast
    #   omnystudio.podcast("12345").show
    #   #=> A struct representing podcast 12345

    def show options={}
      if !@id
        raise ArgumentError.new("The @id variable is required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@id}",
        :method => :get
      })
    end
  end
end
