require "ostruct"
require "json"
require "rest-client"

module OmnyStudioClient

  # @author Jay Arella
  class ProgramCollection

    # @return a OmnyStudioClient
    # @note This is used as a way to access top level attributes

    def config
      @config ||= OmnyStudioClient
    end

    # @return an array of structs that represents a list of programs
    # @see OmnyStudioClient#connection
    # @example Get a list of all programs
    #   omnystudio.programs.list #=> An array of structs representing a list of programs

    def list options={}
      OmnyStudioClient.connection({
        :url => "#{config.api_base_url}/programs",
        :method => :get
      })
    end
  end
end
