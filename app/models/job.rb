class Job < ApplicationRecord
	include HTTParty
	include Nokogiri

	belongs_to :category

	def self.scraper
		url = "https://miami.craigslist.org/search/sof"
		response = HTTParty.get url
		dom = Nokogiri::HTML(response.body)
		return dom.css("a.hdrlnk")
	end
end
