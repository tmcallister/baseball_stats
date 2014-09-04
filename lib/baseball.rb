# baseball.rb
puts 'Baseball Statistics'
require "./stats_service"
 
unless ARGV.length == 3
  	puts "Requires 3 arguments."
  	puts "Usage: ruby baseball.rb path_and_file from_year to_year"
		puts "Example: ruby baseball.rb '../spec/data/batting_smale_sample.csv' 2009 2010"
  exit
end

path_and_file = ARGV[0]
from_year = ARGV[1].to_i
to_year = ARGV[2].to_i

unless from_year < to_year
	puts "'from year' must be less than 'to year'"
	exit
end

unless to_year == from_year + 1
	puts "from and to years must be adjacent."
	exit
end


stats_service = StatsService.new(path_and_file: path_and_file , from_year: from_year, to_year: to_year)
stats_service.most_improved_batting_average
