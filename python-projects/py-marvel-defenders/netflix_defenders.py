# Create a dictionary of the Netflix Defenders heroes and how many seasons each of their shows had

defenders = {"Daredevil":3,"Jessica Jones":3,"Iron Fist":2,"Luke Cage":2,"The Punisher":2}

# Print out each Defender on a separate line

for hero in defenders:
    print(hero)
print()

# Print out how many seasons each hero had of their own show in proper full-sentence format

for hero in defenders:
    print(f"{hero} had {defenders[hero]} seasons of their own show.")
