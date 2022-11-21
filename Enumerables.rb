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

    def my_flatten
        return [self] if !self.kind_of?(Array)
        flatten = []
        self.each do |ele|
            if ele.kind_of?(Array)
                flatten += ele.my_flatten
            else
                flatten << ele
            end
        end
        flatten
    end

    def my_zip(*args)
        my_arr = Array.new(self.length) { Array.new(args.length + 1) }
        temp_arr = [self] + args
        
        temp_arr.each_with_index do |arr, i|
            if i < my_arr[0].length 
                arr.each_with_index { |ele, j| my_arr[j][i] = ele if j < my_arr.length }
            end 
        end
        my_arr
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

p "flatten"
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

p "zip"
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]