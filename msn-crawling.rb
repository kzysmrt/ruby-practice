# _*_ coding: utf-8 _*_
require 'anemone'
require 'nokogiri'
require 'kconv'

# �N���[���̋N�_
urls = ["http://www.msn.com/ja-jp/news/techandscience"]

Anemone.crawl(urls, :depth_limit => 1, :skip_query_settings => true) do |anemone|


  #�����̍i�荞��
  #anemone.focus_crawl do |page|
  #  page.links.keep_if{ |link|
  #    link.to_s.match( /techandscience/)
  #  }
  #end

  #���ׂĂ̌��y�[�W��URL��\������
  #anemone.on_every_page do |page|
  #  puts page.url
  #end



  PATTERN = %r[/techandscience]

  #xPath��chrome�̃c�[�����g���Ď擾

  anemone.on_pages_like(PATTERN) do |page|
    doc = Nokogiri::HTML.parse(page.body.toutf8)
    
    items = doc.xpath("//*[@id=\"main\"]")
    items.each{ |item|
      puts item.xpath("div[\"full-width\"]/h2")
    }
  end
=begin
  #���y�[�W���i�荞��
  PATTERN = %r[466298\/+|466282\/+|2291657051\/+|2291905051\/+]
  anemone.on_pages_like(PATTERN) do |page|
    #�����R�[�h��utf-8�ɕԊҌ�ANokogiri�Ńp�[�X����
    doc = Nokogiri::HTML.parse(page.body.toutf8)

    category = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text

    #�J�e�S�����̕\��
    sub_category = doc.xpath("//*[@id=\"zg_listTitle\"]/span").text

    puts category+"/"+sub_category

    #�ڍׂ̎擾
    items = doc.xpath("//div[@class=\"zg_itemRow\"]/div[1]/div[2]")
    items += doc.xpath("//div[@class=\"zg_itemRow\"]/div[2]/div[2]")

    items.each{|item|
      #����
      puts item.xpath("div[1]/span[1]").text
      #���Ж�
      puts item.xpath("div[\"zg_title\"]/a").text
      #ASIN
      puts item.xpath("div[\"zg_title\"]/a").attribute("href").text.match(%r{dp/(.+?)/})[1]
    }
  end
=end

end