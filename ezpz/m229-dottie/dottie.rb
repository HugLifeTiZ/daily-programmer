#!/usr/bin/env ruby
def fixed_point (x)
    iters = 0
    while true
        iters += 1
        y = yield(x)
        if x == y or iters == 999 then break else x = y end
    end
    puts "Reached fixed point #{x} in #{iters} iterations."
end

fixed_point(ARGV[0].to_f) {|x| Math.cos(x)}
fixed_point(2)            {|x| x - Math.tan(x)}
fixed_point(ARGV[1].to_f) {|x| 1 + 1 / x}
fixed_point(ARGV[2].to_f) {|x| 4 * x * 1 - x}
