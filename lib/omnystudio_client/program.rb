require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class Podcast

    # @return a OmnyStudioClient::Podcast instance
    # @note This is used to initialize the program id when creating a new Podcast instance
    # @example Create a new instance of OmnyStudioClient::Podcast
    #   OmnyStudioClient::Podcast.new("{program_id}") #=> #<OmnyStudioClient::Podcast @id="{program_id}">

    def initialize(id=nil)
      @id = id
    end

    # @return a OmnyStudioClient::Episode instance
    # @note This is used to call a new Episode instance with a given program id and clip_id
    # @example Call a new instance of OmnyStudioClient::Episode
    #   omnystudio.program("12345").clip("56789") #=> #<OmnyStudioClient::Episode @id="{clip_Id}" @program_id="{program_id}" >

    def clip(clip_id=nil)
      OmnyStudioClient::Episode.new(@id, clip_id)
    end

    # @return a OmnyStudioClient::EpisodeCollection instance
    # @note This is used to call a new Episodes instance with a given program id
    # @example Call a new instance of OmnyStudioClient::EpisodeCollection
    #   omnystudio.program("12345").clips #=> #<OmnyStudioClient::EpisodeCollection @program_id="{program_id}" >

    def clips
      OmnyStudioClient::EpisodeCollection.new(@id)
    end

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= OmnyStudioClient
    end

    # @return a struct that represents a program of a given program id
    # @note It needs to be initialized with an @id, otherwise it will return an ArgumentError
    # @see OmnyStudioClient#connection
    # @example Show a program
    #   omnystudio.program("12345").show
    #   #=> A struct representing program 12345

    def show options={}
      if !@id
        raise ArgumentError.new("The @id variable is required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/programs/#{@id}",
        :method => :get
      })
    end
  end
end
