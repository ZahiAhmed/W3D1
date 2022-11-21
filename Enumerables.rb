class Array
    def my_each(&blk)
        i = 0
        until i == length
            blk.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&blk)
        select_array = []
        self.my_each do |ele|
            select_array << ele if blk.call(ele) 
        end
        select_array
    end
end

# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
    puts num
   end.my_each do |num|
    puts num
   end
   # => 1
       2
       3
       1
       2
       3
   
   p return_value  # => [1, 2, 3]

   p "select"
   a = [1, 2, 3]
   p a.my_select { |num| num > 1 } # => [2, 3]
   p a.my_select { |num| num == 4 } # => []