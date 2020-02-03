require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class Clip

    # @return a OmnyStudioClient::Clip instance
    # @note This is used to initialize the program id and clip id when creating a new Clip instance
    # @example Initialize a new instance of OmnyStudioClient::Clip
    #   OmnyStudioClient::Clip.new("{program_id}", "{clip_id}") #=> #<OmnyStudioClient::Clip @id="{clip_id}", @program_id="{program_id}">

    def initialize(program_id=nil, id=nil)
      @id = id
      @program_id = program_id
    end

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes

    def config
      @config ||= OmnyStudioClient
    end

    # @return a struct that represents the clip that was created
    # @note If a @program_id, options[:title], and options[:pubdate] aren't given, it raises an error.
    # @see OmnyStudioClient#connection
    # @example Create an clip
    #   omnystudio.program("12345").clip.create({
    #     Title: "title",
    #     PublishedUtc: "2020-06-01T14:54:02.690Z"
    #   })
    #   #=> A struct representing clip '12345' with Title, "title", and scheduled to publish at June 1st, 2020

    def create options={}
      if !@program_id
        raise ArgumentError.new("@program_id is required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/programs/#{@program_id}/clips",
        :method => :post,
        :body => options
      })
    end

    # @return a struct with a message that the clip was successfully/unsuccessfully deleted
    # @note If neither a @program_id and @clip_id are given, it raises an error
    # @see OmnyStudioClient#connection
    # @example Delete an clip
    #   omnystudio.program("12345").clip("56789").delete
    #   #=> A struct with a property "success" of type "string"

    def delete options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/programs/#{@program_id}/clips/#{@id}",
        :method => :delete
      })
    end

    # @return a struct that represents an clip of a given program id and clip id
    # @see OmnyStudioClient#connection
    # @example Show an clip
    #   omnystudio.program("12345").clip("56789").show
    #   #=> A struct representing clip 56789

    def show options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/programs/#{@program_id}/clips/#{@id}",
        :method => :get
      })
    end

    # @return a struct that represents the clip that was updated
    # @note If neither a @program_id and @clip_id are given, it raises an error
    # @see OmnyStudioClient#connection
    # @example Update a clip's MidRolls
    #   omnystudio.program("12345").clip("56789").update({
    #     Monetization: {
    #       MidRolls: ["00:00:59"]
    #     }
    #   })
    #   #=> A struct representing clip '56789' with at midroll at 59 seconds.

    def update options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/programs/#{@program_id}/clips/#{@id}",
        :method => :put,
        :body => options
      })
    end
  end
end