#This program takes an integer or float as input and outputs whether the number in Celsius degrees is at or below the boiling point of water.

print("This program takes an integer or float as input and outputs whether the number in Celsius degrees is at or below the boiling point of water. Please enter your number now...")
temp = float(input())

if temp >= 100:
   print("Boiling")
else:
   print("Not boiling")
