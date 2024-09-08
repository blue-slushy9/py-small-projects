print("Did you ever hear the old story about the peasant who approached his king, who told the peasant that he would give him whatever he wanted? And then the peasant said that he simply wished to begin with one grain of rice, and then double it over every square on a chess board? This program is similar to that story, you begin by entering a number, and then the program doubles this number based on the number of days you enter. Please enter how many grains of rice you want to begin with now...")
rice = int(input())

print("Please enter over how many days you would like for your grains of rice to increase. The amount will double for every day that passes...")
days = int(input())

n = 1

while n < days:
	rice *= 2
	n = n + 1
print(f"At the end of {days} days, you will have {rice} grains of rice!")
