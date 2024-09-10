print("This program takes three numbers (integer or float) as input and outputs the biggest. Please enter your first number now...")
num1 = float(input())
print("Please enter your second number now...")
num2 = float(input())
print("Please enter your third number now...")
num3 = float(input())

if num1 >= num2 and num1 >= num3:
    print(f"The biggest number is {num1}")
elif num2 >= num1 and num2 >= num3:
    print(f"The biggest number is {num2}")
elif num3 >= num1 and num3 >= num2:
    print(f"The biggest number is {num3}")
