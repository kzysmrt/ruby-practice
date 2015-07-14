# -*- coding utf-8 -*-
require 'nokogiri'
require 'open-uri'

url = 'http://www.amazon.co.jp/gp/rss/bestsellers/books/466298/'
xml = Nokogiri::XML(open(url).read)

puts xml.xpath('/rss/channel/title').text #textがないと<title></title>をそのままURLエンコーディングして表示

item_temp = xml.xpath('//channel')
puts item_temp.xpath('//channel/pubDate').text

# xpath('//xxxx')とやれば、そのタグより下を配列？に入れられる
# xpath('xxx')とやると、現在の位置（配列に入っている最上位のタグ？）の直下にあるその名前のタグ情報をとってくる

item_nodes = xml.xpath('//item')
item_nodes.each do |item|
    puts item.xpath('title').text

    #ASIN
    puts item.xpath('link').text.match(%r{dp/(.+?)/})[1]

    #上の階層をとってこれるか
    puts item.xpath('/rss/channel/title').text
    #現在のタグの位置より上のノードをとってこれる（ポインタのイメージのほうがよさそう）
end
# コンピュータ・IT売れ筋ランキング
# http://www.amazon.co.jp/gp/rss/bestsellers/books/466298/ref=zg_bs_466298_rsslink
