#Create a list of numbers and then print out the elements in order from greatest to smallest

numbers = [3,4,-3,8,-1,-4,7]
print(numbers)

print()

big_to_small = []
big_num = numbers[0]

for i in range(len(numbers)):
    big_num = numbers[0]
    for n in numbers:
        if n > big_num:
            big_num = n
    big_to_small.append(big_num)
    numbers.remove(big_num)

for x in big_to_small:
    print(x)
