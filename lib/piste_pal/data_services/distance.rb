require 'vincenty'
module PistePal
  module DataServices
    class Distance
      def self.call(trackpoints:)
        new(trackpoints: trackpoints).call
      end

      def call
        distance = 0
        @trackpoints.each do |trackpoints|
          distance += calculate_distance trackpoints
        end
        distance
      end

      private

      def initialize(trackpoints:)
        @trackpoints = trackpoints
      end

      def calculate_distance trackpoints
        distance = 0
        total_points = trackpoints.count - 1

        point_a = nil
        point_b = nil

        for i in 0..total_points do
          if i == 0
            point_a = { latitude: trackpoints[i].lat, longitude: trackpoints[i].lon }
            next
          end

          point_b = { latitude: trackpoints[i].lat, longitude: trackpoints[i].lon }
          distance += Vincenty.distance_between_points(point_a, point_b)
          point_a = point_b
        end

        distance
      end
    end
  end
end


