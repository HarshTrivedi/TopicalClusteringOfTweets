# encoding: utf-8

require 'csv'
require 'awesome_print'

tweets_array = CSV.parse(File.read('coarse_combined_data.csv').force_encoding('UTF-8').encode('UTF-16', :invalid => :replace, :replace => '').encode('UTF-8'))


term_frequency_hash = Hash.new(0)
tweets_array.each do|tweet_element| 
	tweet_element[1] = tweet_element[1].downcase.gsub(/;/,"") 
	tweet_element[1].split(" ").each{|term| term_frequency_hash[term] += 1} 
end

CSV.open('coarse_combined_data_V0.csv', 'w') do |csv_object|
	tweets_array.to_a.each do |row_array|
		csv_object << row_array
	end
end


ap term_frequency_hash

tweets_array.each do|tweet_element| 
	tweet_element[1].split(" ").each{|term| tweet_element[1].slice!(term) if term_frequency_hash[term] < 5 } 
end

CSV.open('coarse_combined_data_V1.csv', 'w') do |csv_object|
tweets_array.to_a.each do |row_array|
csv_object << row_array
end
end



tweets_array.each do|tweet_element| 
	tweet_element[1].split(" ").each{|term| tweet_element[1].slice!(term) if (  (not term.gsub(/[^1-9a-zA-Z_@#-]/).to_a.empty?) and (term.gsub(/https?:/).to_a.empty?)  ) } 
end

CSV.open('coarse_combined_data_V2.csv', 'w') do |csv_object|
	tweets_array.to_a.each do |row_array|
	csv_object << row_array
	end
end


tweets_array.each do|tweet_element| 
	tweet_element[1].split(" ").each{|term| tweet_element[1].gsub!(/#{term}/ , "<LINK>") if(not term.gsub(/https?:/).to_a.empty?)  } 
	tweet_element[1].split(" ").each{|term| tweet_element[1].gsub!(/#{term}/ , "<USERNAME") if(not term.gsub(/@.+/).to_a.empty?)  } 
end

CSV.open('coarse_combined_data_V3.csv', 'w') do |csv_object|
	tweets_array.to_a.each do |row_array|
	csv_object << row_array
	end
end
