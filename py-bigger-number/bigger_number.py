#This program takes two different numbers (integer or float) as input and outputs the one that is bigger.

print("This program takes two different numbers as input and outputs the one that is bigger. Please enter your first number now...")
num1 = float(input())
print("Please enter your second number now...")
num2 = float(input())

if num1 > num2:
	print(f"The bigger number is {num1}")
elif num2 > num1:
	print(f"The bigger number is {num2}")
else:
	print("Neither number is bigger")
