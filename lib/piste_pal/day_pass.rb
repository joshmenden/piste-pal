require 'open-uri'
require 'byebug'
require 'nokogiri'
module PistePal
  class DayPass
    def self.purchase file_source
      if file_source.include?("http")
      else
        doc = Nokogiri::XML(File.open(file_source)) do |config|
          config.strict.noblanks
        end
        byebug
        puts "Success parse"
      end
    end
  end
end
