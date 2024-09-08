print("This program takes a credit card type (e.g. Visa, Mastercard) as input and outputs whether that type of card is accepted at a vendor or not. Please enter your card type now...")
card = input()

if card == "Visa" or card == "Amex" or card == "American Express":
	print(f"Thank you, we accept {card} here")
else:
	print(f"Sorry, we don't accept {card} here")
