# stat_service.rb
require 'csv'


class StatsService

	attr_accessor :path_and_file, :csv, :target_players, :from_year, :to_year
	AT_BAT = 'AB'
	HITS = 'H'

	def initialize(path_and_file:, from_year:, to_year:)
		@path_and_file = path_and_file		
		@from_year = from_year.to_i
		@to_year = to_year.to_i
		@csv 	= CSV::read(path_and_file, {:headers => true, :col_sep => ','})
		notify_user(display_string: "#{csv.count} records...")
	end

	def most_improved_batting_average()
 		batting_average = improved_batting_average()
		notify_user(display_string: "MOST IMPROVED BATTING AVERAGE: #{batting_average}")
		batting_average
	end


private

	def improved_batting_average()
		names = target_players.uniq {|j| j['playerID']  }
		stats = batting_average_stats(names: names)
		max_improved = stats.map { |bs| bs[:improvement]  }.max
		improved_player = stats.select {|m| m  if m[:improvement] == max_improved  }
		improved_player.first[:name] ? improved_player.first[:name] : 'None found' 	
	end

	def batting_average_stats(names:)
		stats = Array.new
		names.each do |name| 
			year_pair = target_players.find_all { |r| r['playerID'] == name['playerID'] }			
			next if !meets_at_bat_count? year_pair

			start_year_avg = year_average(collection: year_pair, year: from_year )
			end_year_avg = year_average(collection: year_pair, year: to_year )
			improvement = end_year_avg - start_year_avg

			stats << {name: name['playerID'], first: start_year_avg, last: end_year_avg, improvement: improvement}
		end
		stats
	end

	def year_average(collection:, year:)
		year_stats = collection.select { |y| y['yearID'] == year.to_s  }
		avg = year_stats.first[HITS].to_f / year_stats.first[AT_BAT].to_f
	end


	def meets_at_bat_count? (year_pair) 
		return false unless 	year_pair.count == 2
		end_year = year_pair.select { |end_year| end_year['yearID'] == to_year.to_s  }
		start_year = year_pair.select { |start_year| start_year['yearID'] == from_year.to_s  }
		return false if start_year.count != 1 && end_year.count != 1
		true
	end

	def target_players()
		@target_players ||= begin
			rows = csv.map {|row| row.to_hash }
			rows.select { |r| r['AB'].to_i >= 200  && r['yearID'].to_i.between?(from_year,to_year)}
		end
	end

	def notify_user(display_string:)
		puts ">>> #{display_string}"
	end

end 
