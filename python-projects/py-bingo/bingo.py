print("Let's play some Bingo! You will enter a single number from 0 to 1000, and if this number is in our list you win the game! Please enter your number now...")
ticket = int(input())

winning_nums = [73, 102, 694, 912, 335, 884, 505]

if ticket in winning_nums:
	print("Bingo! You win!")
else:
	print("Sorry, try again")
