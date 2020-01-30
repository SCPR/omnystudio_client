require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class EpisodeCollection

    # @return a OmnyStudioClient::EpisodeCollection instance
    # @note This is used to initialize the podcast id and episode id when creating a new Episode instance
    # @example Initialize a new instance of OmnyStudioClient::EpisodeCollection
    #   OmnyStudioClient::EpisodeCollection.new("{program_id}") #=> #<OmnyStudioClient::EpisodeCollection @id=nil, @program_id="{program_id}">

    def initialize(program_id=nil)
      @program_id = program_id
    end

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id configuration
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= OmnyStudioClient
    end

    # @return an array of structs that represent a list of episodes for a given podcast
    # @note If a @program_id is not given, it raises an error
    # @see OmnyStudioClient#connection
    # @example List a podcast's episodes
    #   omnystudio.podcast("12345").episodes.list
    #   #=> An array of structs representing a list of episodes for a given podcast

    def list options={}
      if !@program_id
        raise ArgumentError.new("The @program_id variable is required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@program_id}/episodes",
        :method => :get
      })
    end

    # @return an array of structs that represents the search results by episode
    # @see OmnyStudioClient#connection
    # @example Search for an episode with externalId 'show_episode-12345'
    #   omnystudio.episode.search({
    #     externalId: 'show_episode-1245'
    #   })
    #   #=> An array of one struct representing 'show_episode-12345'

    def search params={}
      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/search/episodes",
        :method => :get,
        :params => params
      })
    end
  end
end