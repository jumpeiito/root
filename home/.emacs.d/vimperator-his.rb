#!/usr/bin/env ruby

require 'pp';
file = "/home/jumpei/.vimperator/info/default/history-command";

open(file).read().scan(/\{\"value.+?\}/).uniq.map { |x| x.split(/,/) }.each { |l|
  temp = l[0].split(/\":\"/)[1].tr("\"", "")
  puts temp.gsub(/.*open /, "") if temp =~ /open/ or temp =~ /http|file/
}

