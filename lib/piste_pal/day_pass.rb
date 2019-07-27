require 'open-uri'
require 'nokogiri'
require 'daru'
require_relative 'data_point'
require 'byebug'


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
