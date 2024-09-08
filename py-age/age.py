#This program takes name and birth year as input and outputs a greeting that includes the person's name and their approximate age (based only on their birth year, not their specific date of birth).

print("What is your name?")
name = input()

print("What is your birth year?")
birth_year = int(input())

age = 2023 - birth_year

print(f"Hello {name}, you are {age} years old in 2023!")
