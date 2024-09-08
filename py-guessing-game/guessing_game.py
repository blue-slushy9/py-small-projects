#This program takes a number as input and outputs whether the number that was entered matches any of the numbers that were pre-selected as the answers to the guessing game.

print("Let's play a game! I'm thinking of a few different numbers between 0 and 100. If you can guess one of these numbers, you win the game! You will get only one guess for every time you run this program. Please enter your number now...")
num = int(input())

if num == 9 or num == 89 or num == 37:
    print("You win!")
else:
    print("Try again.")
