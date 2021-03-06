# _*_ coding: utf-8 _*_
require 'anemone'
require 'nokogiri'
require 'kconv'

# クロールの起点
urls = ["http://www.amazon.co.jp/gp/bestsellers/books/", "http://www.amazon.co.jp/gp/bestsellers/digital-text/2275256051/"]

Anemone.crawl(urls, :depth_limit => 1, :skip_query_settings => true) do |anemone|
#Anemone.crawl(urls, :skip_query_settings => true) do |anemone|

  #巡回先の絞り込み
  anemone.focus_crawl do |page|
    page.links.keep_if{ |link|
      link.to_s.match( /\/gp\/bestsellers\/books|\/gp\/bestsellers\/digital-text/)
    }
  end

  #すべての候補ページのURLを表示する
  #anemone.on_every_page do |page|
  #  puts page.url
  #end

  #候補ページを絞り込む
  PATTERN = %r[466298\/+|466282\/+|2291657051\/+|2291905051\/+]
  anemone.on_pages_like(PATTERN) do |page|
    #文字コードをutf-8に返還後、Nokogiriでパースする
    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text

    #カテゴリ名の表示
    sub_category = doc.xpath("//*[@id=\"zg_listTitle\"]/span").text

    puts category+"/"+sub_category

    #詳細の取得
    items = doc.xpath("//div[@class=\"zg_itemRow\"]/div[1]/div[2]")
    items += doc.xpath("//div[@class=\"zg_itemRow\"]/div[2]/div[2]")

    items.each{|item|
      #順位
      puts item.xpath("div[1]/span[1]").text
      #書籍名
      puts item.xpath("div[\"zg_title\"]/a").text
      #ASIN
      puts item.xpath("div[\"zg_title\"]/a").attribute("href").text.match(%r{dp/(.+?)/})[1]
    }
  end
end