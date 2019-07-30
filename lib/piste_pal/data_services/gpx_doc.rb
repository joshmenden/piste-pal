require 'nokogiri'
module PistePal
  module DataServices
    class GpxDoc
      # include Singleton
      attr_accessor :doc

      def self.set_instance(file_content)
        @instance = new(file_content)
      end
      def self.instance
        @instance || nil
      end

      private
      def initialize file_content
        # TODO: Support Nokogiri reading from http website instead of file path
        @doc = Nokogiri::XML(file_content) do |config|
          config.strict.noblanks
        end
      end
    end
  end
end
