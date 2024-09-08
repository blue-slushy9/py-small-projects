#Create a list of numbers and print it in list format

nums = [-3, 4, 8, 7, -2, 1]
print(nums)

print()

#Print out each number in the list on its own line

for num in nums:
    print(num)

print()

#Print out the positive numbers in the list only

for num in nums:
    if num > 0:
        print(num)

print()

#Print out the sum of the numbers in the list

sum = 0
for num in nums:
    sum = sum + num
print(sum)

print()

#Print the largest number in the list

largest = nums[0]
for num in nums:
    if num > largest:
        largest = num
print(largest)
