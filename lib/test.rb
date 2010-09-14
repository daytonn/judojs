require 'digest/md5'

file = File.open("test.txt").readlines.join('')
md5 = Digest::MD5.hexdigest(file)
puts md5