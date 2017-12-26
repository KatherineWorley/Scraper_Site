class Job < ApplicationRecord
	include HTTParty
	include Nokogiri

	belongs_to :category

	attr_reader :category_parser

	def self.scraper(cat_type=nil)
		url = "https://miami.craigslist.org/search/sof"
		if cat_type.present?
			@options = { query: {
					employment_type: Job.category_parser(cat_type)
				} 
			}
		end	
		response = HTTParty.get(url, (@options.presence || {}))
		dom = Nokogiri::HTML(response.body)
		return dom.css("a.hdrlnk")
	end

	private
		def self.category_parser(cat_type)
			case cat_type
			when "Full-Time"
				return 1
			when "Part-Time"
				return 2
			when "Contract"
				return 3
			when "Employee's Choice"
				return 4
			else
				return 1
			end
		end
end
