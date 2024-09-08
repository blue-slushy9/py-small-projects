#This program takes the light color of a stop light as input and outputs what action the driver should perform based on the color.

print("Please enter the light color of the stop light now...")
light_color = input()

if light_color == "Green" or light_color == "green":
    print("Go")
elif light_color == "Yellow" or light_color == "yellow":
    print("Slow down")
elif light_color == "Red" or light_color == "red":
    print("Stop")
else:
    print("Invalid light color")
