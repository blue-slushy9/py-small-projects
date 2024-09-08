#This program takes a lower-case letter as input and outputs whether it is a consonant or vowel.

print("This program takes a lower-case letter as input and outputs whether it is a consonant or vowel. Please enter your letter now...")

letter = input()

if letter == "a" or letter == "e" or letter == "i" or letter == "o" or letter == "u" or letter == "y":
    print("Vowel")
else:
    print("Consonant")
