require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class Program

    # @return a OmnyStudioClient::Program instance
    # @note This is used to initialize the program id when creating a new Program instance
    # @example Create a new instance of OmnyStudioClient::Program
    #   OmnyStudioClient::Program.new("{program_id}") #=> #<OmnyStudioClient::Program @id="{program_id}">

    def initialize(id=nil)
      @id = id
    end

    # @return a OmnyStudioClient::Clip instance
    # @note This is used to call a new Clip instance with a given program id and clip_id
    # @example Call a new instance of OmnyStudioClient::Clip
    #   omnystudio.program("12345").clip("56789") #=> #<OmnyStudioClient::Clip @id="{clip_Id}" @program_id="{program_id}" >

    def clip(clip_id=nil)
      OmnyStudioClient::Clip.new(@id, clip_id)
    end

    # @return a OmnyStudioClient::ClipCollection instance
    # @note This is used to call a new Clips instance with a given program id
    # @example Call a new instance of OmnyStudioClient::ClipCollection
    #   omnystudio.program("12345").clips #=> #<OmnyStudioClient::ClipCollection @program_id="{program_id}" >

    def clips
      OmnyStudioClient::ClipCollection.new(@id)
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
