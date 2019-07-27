require 'nokogiri'
module PistePal
  module DataServices
    class GpxDoc
      # include Singleton
      attr_accessor :doc

      def self.set_instance(file_source)
        @instance = new(file_source)
      end
      def self.instance
        @instance || nil
      end

      private
      def initialize file_source
        # TODO: Support Nokogiri reading from http website instead of file path
        @doc = Nokogiri::XML(File.open(file_source)) do |config|
          config.strict.noblanks
        end
      end
    end
  end
end
