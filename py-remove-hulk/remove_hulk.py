# Create a list of Marvel heroes

heroes = ["Iron Man","Hulk","Spider-Man","Ant-Man","Hulk","Vision","Dr. Strange","Thor","Hulk","Captain America"]
print(f"Heroes: {heroes}")
print()

print("Hulk always smashes things, plus he has duplicate entries in heroes, so let's just remove him from the list (don't tell him though)...")
print()

while "Hulk" in heroes:
    heroes.remove("Hulk")
print(heroes)
