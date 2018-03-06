base62 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
# $0 is not part of ARGV in Crystal.
ARGV.each do |arg|
    num = arg.to_u64?(10)
    if num.nil?
        puts "#{arg} is not a positive integer."
    else
        loop do
            print base62[num % 62]
            break if (num /= 62) <= 0
        end
        puts
    end
end
