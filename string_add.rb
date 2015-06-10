# _*_ coding: utf-8 _*_
r = "ruby"
puts  r + "ist"
puts r

r << "dest"
puts r

p r[3]
p r[4..5]

print "encoding: "
p r.encoding
p "length: " + r.length.to_s
p "bytesize: " + r.bytesize.to_s
