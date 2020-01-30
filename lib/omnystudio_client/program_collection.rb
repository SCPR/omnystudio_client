require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class PodcastCollection

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= OmnyStudioClient
    end

    # @return an array of structs that represents a list of podcasts
    # @note It needs to be initialized with a network id
    # @see OmnyStudioClient#connection
    # @example Get a list of all podcasts
    #   omnystudio.podcasts.list #=> An array of structs representing a list of podcasts

    def list options={}
      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts",
        :method => :get
      })
    end
  end
end
