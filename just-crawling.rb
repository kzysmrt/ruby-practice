# _*_ coding: utf-8 _*_
require 'anemone'

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
    puts page.url
  end
end