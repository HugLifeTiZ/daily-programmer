ARGV.each do |arg|
    stack = arg.split(" ").map(&.to_u8?).compact
    flips = [stack.join(" ")]  # Looks redundant, but trims non-uints.
    
    (0...stack.size).reverse_each do |i|
        max = i
        (0...i).each {|j| if stack[j] > stack[max]; max = j end}
        if max != i
            if max != 0
                # Crystal lets you do this nifty thing for slices.
                stack[0..max] = stack[0..max].reverse
                flips << stack.join(" ")
            end
            stack[0..i] = stack[0..i].reverse
            flips << stack.join(" ")
        end
    end
    
    puts("#{flips.size - 1} flip(s):\n#{flips.join(" -> \n")}")
end
