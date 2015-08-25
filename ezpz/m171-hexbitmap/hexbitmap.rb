#!/usr/bin/env ruby
# encoding: UTF-8
ARGV.map{|item|
    ("1"+item).to_i(16).to_s(2).split("")[1..-1].reduce("") {|prev, current|
        prev + (current == "1" ? "█" : "░")
    }
}.each{|row| puts row}
