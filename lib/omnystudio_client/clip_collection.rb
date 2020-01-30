require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class EpisodeCollection

    # @return a OmnyStudioClient::EpisodeCollection instance
    # @note This is used to initialize the program id and clip id when creating a new Episode instance
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

    # @return an array of structs that represent a list of clips for a given program
    # @note If a @program_id is not given, it raises an error
    # @see OmnyStudioClient#connection
    # @example List a program's clips
    #   omnystudio.program("12345").clips.list
    #   #=> An array of structs representing a list of clips for a given program

    def list options={}
      if !@program_id
        raise ArgumentError.new("The @program_id variable is required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/programs/#{@program_id}/clips",
        :method => :get
      })
    end

    # @return an array of structs that represents the search results by clip
    # @see OmnyStudioClient#connection
    # @example Search for an clip with externalId 'show_clip-12345'
    #   omnystudio.clip.search({
    #     externalId: 'show_clip-1245'
    #   })
    #   #=> An array of one struct representing 'show_clip-12345'

    def search params={}
      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/search/clips",
        :method => :get,
        :params => params
      })
    end
  end
end