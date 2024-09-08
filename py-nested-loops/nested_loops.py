#This code creates a nested for loop
#Expected output (separate lines): 0, 0, 1, 2, 1, 0, 1, 2, 2, 0, 1, 2

for i in range(3):
    print(i)
    for k in range(3):
        print(k)

print()

#This code creates another nested for loop
#Expected output (separate lines): 0,0; 0,1; 0,2; 0,3; 1,0; 1,1; 1,2; 1,3

for i in range(2):
    for k in range(4):
        print(f"{i},{k}")

print()

#This code creates another nested for loop
#Expected output (separate lines): 1,0; 2,0; 2,1

for i in range(3):
    for k in range(i):
        print(f"{i},{k}")
