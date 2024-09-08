#This program takes a percent value as input, then it outputs the letter grade that corresponds to that percent value.

print("This program takes a percent value as input, then it outputs the letter grade that corresponds to that percentage. Please enter your percent value now (just the number, no % sign); it can be an integer or float...")
percent = float(input())

if percent >= 100:
	print("A+")
elif percent >= 90:
	print("A")
elif percent >= 80:
	print("B")
elif percent >= 70:
	print("C")
elif percent >= 60:
	print("D")
else:
	print("F")
