#This code adds the name of each animal typed in by the user to a list, and then prints the list

animals = []

print("Please type in the names of five animals")

for i in range(5):
    animals.append(input())

print()

print(f"Here are your animals in list format: {animals}")

print()

#This code returns how many times the user entered "dog"

dog = 0

for i in range(len(animals)):
    if animals[i] == "dog":
        dog = dog + 1
print(f"You entered dog {dog} time(s)")

print()

#Print out whether there is a "hedgehog" in the list

hedgehog = 0

for i in range(len(animals)):
    if animals[i] == "hedgehog":
        hedgehog = hedgehog + 1

print("First check for existence of hedgehog in list:")

if hedgehog >= 1:
    print("Hedgehog is in this list")
else:
    print("There is no hedgehog in this list")

print()

#This code also checks for the existence of hedgehog in the list

print("Second check for existence of hedgehog in list:")

if "hedgehog" in animals:
    print("Hedgehog is in this list")
else:
    print("There is no hedgehog in this list")
