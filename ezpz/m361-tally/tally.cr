ARGV.each_with_index do |arg, i|
    scores = Hash(Char, Int32).new(0)
    arg.chars.each do |chr|
        if chr.ascii_uppercase?; scores[chr.downcase] -= 1
        else scores[chr] += 1 end
    end
    puts scores.keys.sort{|a, b|
        res = scores[b] <=> scores[a]; res.zero? ? a <=> b : res
    }.map{|k| "#{k}: #{scores[k]}"}.join(", ")
end
