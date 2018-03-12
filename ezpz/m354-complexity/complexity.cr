ARGV.each do |arg| 
    if ! (target = arg.to_u64?).nil?
        smallest = UInt64::MAX
        (1..Math.sqrt(target).ceil).each do |i|
            if target % i == 0
                smallest = Math.min(target / i + i, smallest)
            end
        end
        puts smallest
    end
end
