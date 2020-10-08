require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)

    array_list_of_email = []

    array_list_first_last_name = []

    first_name = Array.new(5, "first_name")
    last_name = Array.new(5, "last_name")
    email = Array.new(5, "email")

    array_first_name = []
    array_last_name = []
    
    regroup_first_name = {}
    regroup_last_name = {}
    regroup_email = {}
    
    puts townhall_url.length

    5.times do |i|
        page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/#{townhall_url[i]}")) 
        first_email_test = page.xpath('/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a')
        array_list_of_email << first_email_test.text

        s_m_first_last_name = page.xpath('//div[2]/h1').text.split(' ')[1]
        array_first_name << s_m_first_last_name

        s_m_first_last_name = page.xpath('//div[2]/h1').text.split(' ')[2..3]
        array_last_name << s_m_first_last_name

    end

    regroup_first_name = first_name.zip(array_first_name)
    regroup_last_name = last_name.zip(array_last_name)
    regroup_email = email.zip(array_list_of_email)


    print regroup_first_name
    print regroup_last_name
    print regroup_email
  
end

def get_townhall_urls

    array_link = []
    page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))

    page.xpath('//tr/td/a').each do |link|
        array_link << link["href"][1..-1] 
    end
    return array_link
end

get_townhall_email(get_townhall_urls)