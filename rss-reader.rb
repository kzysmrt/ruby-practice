# -*- coding utf-8 -*-
require 'nokogiri'
require 'open-uri'

url = 'http://www.amazon.co.jp/gp/rss/bestsellers/books/466298/'
xml = Nokogiri::XML(open(url).read)

puts xml.xpath('/rss/channel/title').text #text���Ȃ���<title></title>�����̂܂�URL�G���R�[�f�B���O���ĕ\��

item_temp = xml.xpath('//channel')
puts item_temp.xpath('//channel/pubDate').text

# xpath('//xxxx')�Ƃ��΁A���̃^�O��艺��z��H�ɓ������
# xpath('xxx')�Ƃ��ƁA���݂̈ʒu�i�z��ɓ����Ă���ŏ�ʂ̃^�O�H�j�̒����ɂ��邻�̖��O�̃^�O�����Ƃ��Ă���

item_nodes = xml.xpath('//item')
item_nodes.each do |item|
    puts item.xpath('title').text

    #ASIN
    puts item.xpath('link').text.match(%r{dp/(.+?)/})[1]

    #��̊K�w���Ƃ��Ă���邩
    puts item.xpath('/rss/channel/title').text
    #���݂̃^�O�̈ʒu����̃m�[�h���Ƃ��Ă����i�|�C���^�̃C���[�W�̂ق����悳�����j
end
# �R���s���[�^�EIT����؃����L���O
# http://www.amazon.co.jp/gp/rss/bestsellers/books/466298/ref=zg_bs_466298_rsslink
