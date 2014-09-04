
Baseball
==============
Calculates and outputs most improved batting average 
baseball.rb is run from command line. See usage below.

Setup
==============
To run rspec, install rspec gem
baseball is written using Ruby 2.


Usage
==============
Provide a comma delimited csv file in the following format:
playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS

Column header key:
AB – at-bats
H – hits
2B – doubles
3B – triples
HR – home runs RBI – runs batted in

Usage: ruby baseball.rb path_and_file from_year to_year"
Example: ruby baseball.rb '../spec/data/batting_smale_sample.csv' 2009 2010"


Limitations
==============
Players may have year records for 2 or more leagues. At the moment, these players are not considered in the current implementation. 
