ARGV.each{|arg|
    puts ("1" + arg).to_i(16).to_s(2)[1..-1].gsub{|c| c == '1' ? '█' : '░'}
}
