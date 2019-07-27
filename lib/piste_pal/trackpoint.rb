module PistePal
  class Trackpoint
    attr_accessor :lat, :long, :elevation, :time, :hdop, :vdop, :speed

    def initialize(lat: nil, long: nil, elevation: nil, time: nil, hdop: nil, vdop: nil, speed: nil)
      @lat = lat
      @long = long
      @elevation = elevation
      @time = time
      @hdop = hdop
      @vdop = vdop
      @speed = speed
    end
  end
end
