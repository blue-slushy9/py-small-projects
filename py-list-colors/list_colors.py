#A: this code prints a list of colors

list_colors = ["Red", "Green", "Blue", "Black", "White", "Yellow"]
print(list_colors)

#B: this code uses the aforementioned list, but only prints out the elements Red, White, and Blue

print(list_colors[0])
print(list_colors[4])
print(list_colors[2])

#C: this code changes "Black" to "Purple", and "White" to "Orange" in list_colors; then it prints out the new list

list_colors[3] = "Purple"
list_colors[4] = "Orange"

print(list_colors)

#D: this code adds "Black" and "White" back into list_colors, but they will now be at the end of the list; then it prints out the new list

list_colors.append("Black")
list_colors.append("White")
print(list_colors)

#E: this code removes the elements at index 0, 2, and 6; then it prints the updated list

list_colors.pop(6)
list_colors.pop(2)
list_colors.pop(0)
print(list_colors)

#F: this code prints out how many colors are left in this list, in the format "There are 'x' colors left in the list"

print(f"There are {len(list_colors)} colors left in the list")
