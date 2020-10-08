require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)

    array_list_of_email = []

    townhall_url.length.times do |i|
        page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/#{townhall_url[i]}")) 
        first_email_test = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
        array_list_of_email << first_email_test
    end

    puts array_list_of_email
  
end

def get_townhall_urls

    array_link = []
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

    page.xpath('//p/a[@class="lientxt"]').each do |link|
        array_link << link["href"][1..-1]
 
    end
    return array_link
end

get_townhall_email(get_townhall_urls)