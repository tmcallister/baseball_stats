# stats_service_spec.rb

require 'stats_service'

describe StatsService do
    
  let(:file) { 'spec/data/batting_small_sample.csv' }
  let(:stats_service) { StatsService.new(path_and_file: file, from_year: 2010, to_year: 2011)}

  it '#most_improved_batting_average' do 
    most_improved = stats_service.most_improved_batting_average
    expect(most_improved).to eq ('johnske05')
  end

end

