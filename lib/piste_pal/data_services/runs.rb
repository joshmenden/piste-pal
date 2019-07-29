module PistePal
  module DataServices
    class Runs
      def self.call(trackpoints:)
        new(trackpoints: trackpoints).call
      end

      def call
        aggregate_runs
      end

      private

      def initialize(trackpoints:)
        @trackpoints = trackpoints
      end

      def aggregate_runs
        groupings = []
        current_group = [] 
        total_points = @trackpoints.count - 1
        descending = true

        for i in 1..total_points do
          if i == 1
            current_group.push(@trackpoints[i - 1])
            current_group.push(@trackpoints[i])
            if @trackpoints[i].elevation < @trackpoints[i - 1].elevation
              descending = true
            elsif @trackpoints[i].elevation > @trackpoints[i - 1].elevation
              descending = false
            # else they are equal, and it doesn't matter what direction we choose to start
            end
            next
          end

          if @trackpoints[i].elevation < @trackpoints[i - 1].elevation
            if !descending
              groupings.push(current_group)
              current_group = []
              descending = true
            end
          elsif @trackpoints[i].elevation > @trackpoints[i - 1].elevation
            if descending
              groupings.push(current_group)
              current_group = []
              descending = false
            end
          end

          current_group.push(@trackpoints[i])

          if i == total_points
            groupings.push(current_group)
          end

        end

        groupings.each do |group|
          puts "\n\nNew Group:\n"
          group.each do |point|
            puts point.elevation
          end
        end
        groupings

      end
    end
  end
end



