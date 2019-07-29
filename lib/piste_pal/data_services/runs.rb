module PistePal
  module DataServices
    class Runs

      MINIMUM_DEVIATION = 5

      def self.call(trackpoints:)
        new(trackpoints: trackpoints).call
      end

      def call
        runs_and_lifts
      end

      private

      def initialize(trackpoints:)
        @trackpoints = trackpoints
      end

      def runs_and_lifts
        group_runs_and_lifts(aggregate_runs_by_direction)
      end

      def group_runs_and_lifts groupings
        runs = []
        lifts = []
        total_groups_count = groupings.count - 1

        previous_group = nil

        for i in 1..total_groups_count do
          previous_group = groupings[i - 1] if i == 1

          if groupings[i][:trackpoints].count > MINIMUM_DEVIATION
            if groupings[i][:direction] == previous_group[:direction]
              previous_group[:trackpoints].concat(groupings[i][:trackpoints])
            else
              if previous_group[:direction] == "ascending"
                lifts.push(previous_group)
              else
                runs.push(previous_group)
              end
              previous_group = groupings[i]
            end
          elsif groupings[i][:trackpoints].count <= MINIMUM_DEVIATION
            previous_group[:trackpoints].concat(groupings[i][:trackpoints])
          end

          if i == total_groups_count
            if previous_group[:direction] == "ascending"
              lifts.push(previous_group)
            else
              runs.push(previous_group)
            end
          end
        end

        # Not a perfect system, but for now let's delete the runs that have bad data
        runs = runs.delete_if {|run| run[:trackpoints].first.elevation < run[:trackpoints].last.elevation}

        [runs, lifts]        
      end

      def aggregate_runs_by_direction
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
              groupings.push({ direction: descending ? "descending" : "ascending", trackpoints: current_group })
              current_group = []
              descending = true
            end
          elsif @trackpoints[i].elevation > @trackpoints[i - 1].elevation
            if descending
              groupings.push({ direction: descending ? "descending" : "ascending", trackpoints: current_group })
              current_group = []
              descending = false
            end
          end

          current_group.push(@trackpoints[i])

          if i == total_points
            groupings.push({ direction: descending ? "descending" : "ascending", trackpoints: current_group })
          end

        end
        #
        # groupings.each do |group|
        #   puts "\n\nNew Group:\nDirection: #{group[:direction]}\n"
        #   group[:trackpoints].each do |point|
        #     puts point.elevation
        #   end
        # end
        groupings
      end
    end
  end
end



