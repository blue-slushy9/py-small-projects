print("Let's play a game! I'm thinking of a few different numbers between 0 and 100. If you can guess one of these numbers, you win the game! You will get five attempts before you lose the game.")

n = 0

while True:
    print("Please enter your number now...")
    num = int(input())

    if num == 9 or num == 89 or num == 37:
        print("You win!")
        break

    elif n == 4:
        print("You lose!")
        break

    else:
        print("Try again.")
        n = n + 1
