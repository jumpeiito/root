#!/usr/bin/ruby1.9 -Ku

str = ARGV[0]
str.scan(/^h*t*t*p:.+?jpe*g/).each { |x| puts x }
