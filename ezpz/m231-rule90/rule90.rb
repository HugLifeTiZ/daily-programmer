#!/usr/bin/ruby
line = ARGV[0].split("").map{|item| item == "1"}
25.times do
    puts line.map{|item| item ? "x" : " "}.join
    line = line.map.with_index do |_, i|
         (i == 0 ? false : line[i - 1]) !=
         (i == line.length - 1 ? false : line[i + 1])
    end
end
