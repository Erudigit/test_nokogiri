require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_symbol
    array_symbol = []

    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")) 

    page.xpath('//td[3]').each do |link|
        array_symbol << link.content
    end

    puts array_symbol

    return array_symbol  
end

def get_currencies 
    array_currencies = []

    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")) 

    page.xpath('//td[5]').each do |link|
        array_currencies << link.content.delete('$,').to_f
    end
    return array_currencies
end

def create_hash(array_symbol, array_currencies)
    array_of_my_hash = []

    my_hash_symbol_currencies = Hash[array_symbol.zip array_currencies]
    
    array_symbol.each_with_index do |x, y|    #/ on associe pour chaque item de symbols_array un item de prices_array
        array_of_my_hash << {x => (array_currencies)[y]} #/ on sauvegarde sous forme d'hash dans le tableau
    end
    
    puts array_of_my_hash
end

get_symbol