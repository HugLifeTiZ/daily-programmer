if ARGV.size < 3
    STDERR.puts("Usage: #{PROGRAM_NAME} operation key message")
    exit(1)
end

key, message = ARGV[1], ARGV[2..-1].join
dir = ARGV[0] == "decode" ? -1 : 1

# Crystal doesn't let you just use a char as a number. Since we have
# to convert them anyways, we might as well just store them as offsets.
key = key.chars.map {|c| c.ord - 'a'.ord}
message = message.chars.map {|c| c.ord - 'a'.ord}

puts message.map_with_index {|chr, i| 
    ((chr + key[i % key.size] * dir) % 26 + 'a'.ord).chr
}.join
