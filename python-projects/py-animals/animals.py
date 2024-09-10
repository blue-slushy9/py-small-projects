#This program takes a few different words and a number as input and outputs a funny sentence that includes the information that was entered.

print("What is your favorite food?")
food = input()

print("What is your favorite animal? Please only type in the singular form of the name of the animal.")
animal = input()

print("What is your favorite number?")
number = int(input())

print(f"Here are {number} {animal}s eating {food}!")
