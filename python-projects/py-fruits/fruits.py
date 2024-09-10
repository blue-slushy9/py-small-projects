print("This program takes an integer from 0-7 as input and outputs what type of fruit in a fruit stand it corresponds to. Please enter your number now...")

fruits = ["apple", "cherry", "banana", "kiwi", "lemon", "pear", "peach", "avocado"]

num = int(input())

if num < 0 or num > 7:
	print("None of our fruits correspond to that number")
else:
	print(f"That {fruits[num]} will be $1 please")
