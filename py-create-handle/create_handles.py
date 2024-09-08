# Create an online handle that is based on a user's favorite color and favorite food. The handle will not use the entire words, but instead only utilize the first three letters of the color, the first five letters of the food, and the first digit of their favorite number. Also, the handle should be in all caps.

print("Please enter your favorite color now...")
color = input()
print("Please enter your favorite food now...")
food = input()
print("Please enter your favorite number now...")
num = input()
print()

handle = ((color[:3] + food[:5] + num[0]).upper())

print(f"Henceforth, thou shalt be known as {handle}.")
