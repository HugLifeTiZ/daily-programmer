class String
    # Hamming distance.
    def distance (from b)
        retval = 0_u8
        each_char_with_index do |c, i|
            if c != b[i]; retval += 1 end
        end
        retval
    end
end

ARGV.each do |file|
    center = ""; shortest = UInt8::MAX;
    # We don't need the number at the start.
    lines = File.each_line(file).skip(1).to_a
    if lines.size == 0; next end
    lines.each do |line|
        distances = lines.map{|b| line.distance(b)}.sum
        if distances < shortest
            center = line; shortest = distances;
        end
    end
    puts center
end
