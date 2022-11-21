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

    def my_reject(&blk)
        reject_array = []

        self.my_each do |ele|
            reject_array << ele if !blk.call(ele)
        end
        reject_array
    end

    def my_any?(&blk)
        self.my_each do |ele|
            return true if blk.call(ele)
        end
        false
    end

    def my_all?(&blk)
        self.my_each do |ele|
            return false if !blk.call(ele)
        end
        true
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

p "reject"
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

p "any?"
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true