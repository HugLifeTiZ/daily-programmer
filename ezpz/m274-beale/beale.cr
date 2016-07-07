LETTERS = File.read("doi.txt").split.map{|w| w[0]}
puts STDIN.gets('\0').to_s.delete("^0-9 ").split.map{|n|
    LETTERS[n.to_i - 1 % LETTERS.size]
}.join
