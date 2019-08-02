# PistePal

[![Gem Version](https://badge.fury.io/rb/piste_pal.svg)](https://badge.fury.io/rb/piste_pal)

Fill your time off the slopes thinking about them. This gem takes .gpx files from popular activity tracking apps and turns them into fun stats.

The code can be accessed at a high level by "purchasing" either Day Passes or Season Passes, but most of the functionality is modularized to allow you access to the stats you want.

It is tailored for .gpx files exported from the [Slopes](https://getslopes.com/) app for now.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'piste_pal'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piste_pal

## Usage

```ruby
require 'piste_pal'

# "Purchase" your day pass with a single .gpx data object

gpx_data = File.read('/path/to/gpx/file')
sundance = PistePal::DayPass.purchase(gpx_data)

sundance.resort                         # Sundance Mountain Resort
sundance.date                           # 2019-03-01 00:00:00 -0700
sundance.maximum_speed                  # {:value=>30.290415, :unit=>"mph"}
sundance.peak_altitude                  # {:value=>8261.18916855752, :unit=>"feet"}
sundance.vertical                       # {:value=>3797.6879430483204, :unit=>"feet"}
sundance.distance                       # {:value=>4.796952318157319, :unit=>"miles"}
sundance.tallest_run                    # {:value=>1282.958728718721, :unit=>"feet"}
sundance.longest_run                    # {:value=>1.9052295991405417, :unit=>"miles"}
sundance.runs                           # [[@trackpoint1, @trackpoint2, ...], [@trackpoint1, @trackpoint2, ...]]
sundance.lifts                          # [[@trackpoint1, @trackpoint2, ...], [@trackpoint1, @trackpoint2, ...]]

# Or, purchase a season pass with an array of .gpx data objects

season_data = []
season_data.push(File.read('/path/to/gpx/file1'))
season_data.push(File.read('/path/to/gpx/file2'))
season_data.push(File.read('/path/to/gpx/file3'))

season = PistePal::SeasonPass.purchase(season_data)

season.days                             # [<PistePal::DayPass>, <PistePal::DayPass>, ...]
season.days(timestamp_only: true)       # [2019-03-30 00:00:00 -0600, 2019-03-01 00:00:00 -0700, ...]
season.runs                             # 134
season.resorts                          # ["Sundance Resort", "Solitude Mountain Resort", "Park City Mountain Resort"]
season.vertical                         # {:value=>51900.38487275453, :unit=>"feet"}
season.distance                         # {:value=>52.35386405859661, :unit=>"miles"}
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/joshmenden/piste_pal). No PR is too small.

Some things that need cleaning up / fixing:

* Should probably write some tests...
* Cleaner, more comprehensive way to handle different measurement systems (Metric vs. Imperial). I have this half-baked in some places but it could use a lot of improvment.
* Save trackpoint nodes to object and only extract data when necessary -- that is, only calculate the maximum_velocity when that method is invoked
* Check compatibility with files exported from other Apps (right now it is mostly tailored towards the "Slopes" app)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
