# Create two lists consisting of integers, then print them

list1 = [5,9,11,-4,101,-73,203]
list2 = [-92,67,364,-255,-2,8,0]

print(f"List1: {list1}")
print(f"List2: {list2}")
print()

# Create a list, list3, that is the sum of the elements of matching indexes from list1 and list2

list3 = []

for n in range(len(list1)):
    sum = list1[n] + list2[n]
    list3.append(sum)
print("Now add the elements of matching indexes...")
print(f"List3: {list3}")
