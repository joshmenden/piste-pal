module PistePal
  class SeasonPass
    attr_accessor :days, :resorts, :runs, :vertical, :distance, :maximum_speed, :total_hours

    def self.purchase files
      new(files: files)
    end

    def days(timestamp_only: false)
      return @days if !timestamp_only
      return @days.map {|day| day.date }
    end

    private

    def initialize(files:)
      @days = []
      files.each do |f|
        @days.push(PistePal::DayPass.purchase(f))
      end

      @resorts = @days.map {|day| day.resort }.uniq
      @runs = @days.map {|day| day.runs.count }.reduce(0, :+)
      @vertical = {
        :value => @days.map {|day| day.vertical[:value] }.reduce(0, :+),
        :unit => @days.first.vertical[:unit]
      }
      @distance = {
        :value => @days.map {|day| day.distance[:value] }.reduce(0, :+),
        :unit => @days.first.distance[:unit]
      }

      @maximum_speed = generate_maximum_speed
      @total_hours = generate_total_hours
    end

    def generate_maximum_speed
      maximum_speed = nil
      @days.each do |day|
        maximum_speed = day.maximum_speed if maximum_speed.nil? || day.maximum_speed[:value] > maximum_speed[:value]
      end
      return maximum_speed
    end

    def generate_total_hours
      @days.map {|day| day.total_hours }.reduce(0, :+)
    end
  end
end

