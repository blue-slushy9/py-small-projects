#This program takes an integer as input, then it outputs whether it is even or odd.

print("This program takes an integer as input, then it outputs whether it is even or odd. Please enter an integer (whole number) now...")
num = int(input())

if num % 2 == 0:
	print("Even")
if num % 2 != 0:
	print("Odd")
