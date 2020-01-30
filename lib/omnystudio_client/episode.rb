require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class Episode

    # @return a OmnyStudioClient::Episode instance
    # @note This is used to initialize the podcast id and episode id when creating a new Episode instance
    # @example Initialize a new instance of OmnyStudioClient::Episode
    #   OmnyStudioClient::Episode.new("{program_id}", "{episode_id}") #=> #<OmnyStudioClient::Episode @id="{episode_id}", @program_id="{program_id}">

    def initialize(program_id=nil, id=nil)
      @id = id
      @program_id = program_id
    end

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id configuration
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= OmnyStudioClient
    end

    # @return a struct that represents the episode that was created
    # @note If a @program_id, options[:title], and options[:pubdate] aren't given, it raises an error.
    # @see OmnyStudioClient#connection
    # @example Create an episode
    #   omnystudio.podcast("12345").episode.create({
    #     title: "title",
    #     pubdate: "2020-06-01T14:54:02.690Z"
    #   })
    #   #=> A struct representing episode '12345' with title, "title", and scheduled to publish at June 1st, 2020

    def create options={}
      if !@program_id || !options || !options[:title] || !options[:pubdate]
        raise ArgumentError.new("@program_id, options[:title], and options[:pubdate] variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@program_id}/episodes",
        :method => :post,
        :body => options
      })
    end

    # @return a struct with a message that the episode was successfully/unsuccessfully deleted
    # @note If neither a @program_id and @episode_id are given, it raises an error
    # @see OmnyStudioClient#connection
    # @example Delete an episode
    #   omnystudio.podcast("12345").episode("56789").delete
    #   #=> A struct with a property "success" of type "string"

    def delete options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@program_id}/episodes/#{@id}",
        :method => :delete
      })
    end

    # @return a struct that represents an episode of a given podcast id and episode id
    # @see OmnyStudioClient#connection
    # @example Show an episode
    #   omnystudio.podcast("12345").episode("56789").show
    #   #=> A struct representing episode 56789

    def show options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@program_id}/episodes/#{@id}",
        :method => :get
      })
    end

    # @return a struct that represents the episode that was updated
    # @note If neither a @program_id and @episode_id are given, it raises an error
    # @see OmnyStudioClient#connection
    # @example Update an episode's preCount
    #   omnystudio.podcast("12345").episode("56789").update({
    #     preCount: 2
    #   })
    #   #=> A struct representing episode '56789' with preCount 2

    def update options={}
      if !@program_id || !@id
        raise ArgumentError.new("Both @program_id and @id variables are required.")
      end

      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@program_id}/episodes/#{@id}",
        :method => :put,
        :body => options
      })
    end
  end
end