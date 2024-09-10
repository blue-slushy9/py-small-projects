# Create a single string of movie names, separated by commas

movies = "It,Empire Strikes Back,Gladiator,Jaws,Midsommar,Sixth Sense"
print(f"Movies: {movies}")
print()

# Use the split function to break up the movies and add them to a list individually

split_movies = movies.split(",")

print("Print out the movie names separately...")
print()

for movie in split_movies:
    print(movie)
