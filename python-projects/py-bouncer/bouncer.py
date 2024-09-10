print("This program takes name and age as input, and then outputs whether the person would be allowed into a 21+ club or not. Please enter your name now...")
name = input()
print("Please enter your age now...")
age = int(input())

if age >= 21:
	print(f"Welcome {name}!")
else:
	print(f"Sorry {name}, come back when you're 21")

