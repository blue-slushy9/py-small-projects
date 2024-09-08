print("This program takes an integer or float as input and outputs whether that level of humidity is normal or not. Please enter your number now...")
humidity = float(input())

if humidity >= 40 and humidity <= 60:
	print("Humidity levels are normal")
else:
	print("This is not normal humidity")
