#This code creates a list that contains a few different lists

main_list = [["A", "B", "C"], [0, 1, 2, 3], [True, False]]

#Print main_list in list format

print(main_list)

#Print sub-list at index 0

print(main_list[0])

#Print the second element of the first sub-list

print(main_list[0][1])

#Print "True" from the third sub-list

print(main_list[2][0])

#Add the integer 4 to the second sub-list, then print the new sub-list

main_list[1].append(4)
print(main_list[1])

#Print out each letter in the first sub-list, one letter per line

#This code loops through the sub-list elements

for letter in main_list[0]:
    print(letter)

#This code loops through the list indexes

for i in range(len(main_list[0])):
    print(main_list[0][i])

#Print out each individual element across every sub-list in main_list

#This code loops through the elements

for sub_list in main_list:
    for element in sub_list:
        print(element)

#This code loops through the indexes

for i in range(len(main_list)):
    for k in range(len(main_list[i])):
        print(main_list[i][k])

#Here is a new list to manipulate

new_list = [["A", [7, 9], 3.2], ["C", True, 4.1]]

#Print out 4.1

print(new_list[1][2])

#Print out "A"

print(new_list[0][0])

#Print out 9

print(new_list[0][1][1])
