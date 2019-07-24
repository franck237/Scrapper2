require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

class Email
#definition de la méthode
	def get_mairie_email(mairie_url)
		page_1 = Nokogiri::HTML(open("#{mairie_url}"))
		#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
		#puts page.class   # => Nokogiri::HTML::Document
		
		#téléchargement de l'ensemble des symboles
		full_email_mairie = page_1.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')

		email_mairie = full_email_mairie.text
		return email_mairie
	end


	def get_url_data
		page_2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		#("https://www.annuaire-des-mairies.com/95/avernes.html"))   
		#puts page.class   # => Nokogiri::HTML::Document
			
			#téléchargement de l'ensemble des symboles
		half_url = page_2.xpath('//a[contains(@href, "./95/")]')
	 end 




	def get_mairie_urls(half_url)
		slice_url = half_url.map { |link| link['href'] }
		slice_url.each do |i|
			i.slice!(0) 
		end
		
		mairie_url = slice_url.map { |j| "http://annuaire-des-mairies.com#{j}"}
		return mairie_url
	end


	def city(half_url)	
		ville = half_url.map { |string| string.text  }
		#puts name_mairie
		return ville
	end



	def mailing_list(mairie_url,town)
		email_list = []

		mairie_url.each do |i|
		email_mairie = get_mairie_email(i)
		email_list << email_mairie
		end

		annuaire = []
		ville.each do |j|
		result = { j => email_list[ville.index(j)]}
		annuaire << result	
		end
		puts annuaire
	end


	def perform		
		half_url = get_url_data

		town_hall_url = get_townhall_urls(half_url)

		town = city(half_url)


		annuaire = mailing_list(town_hall_url,town)
	end
end



