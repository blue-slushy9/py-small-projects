#This program takes a number as input and outputs whether that number is positive or negative. The program accepts integers as well as floats.

print("This program takes an integer or float as input and outputs whether it is positive or negative. Please enter your number now...")
num = float(input())

if num > 0:
    print("Positive")
elif num < 0:
    print("Negative")
else:
    print("The number is neither positive nor negative")
