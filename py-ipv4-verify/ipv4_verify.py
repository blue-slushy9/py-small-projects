print("This program takes an IPv4 address as input and tells you whether it is a valid IPv4 address or not. Please enter your IPv4 address now...")
IP = input()

bytes = IP.split(".")

'''
# This code is unnecessary, replaced it with "n = int(n)" in below loop

int_bytes = []

for byte in bytes:
    byte = int(byte)
    int_bytes.append(byte)
'''

correct_bytes = 0

for n in bytes:
    n = int(n)
    if n >= 0 and n <= 255:
         correct_bytes = correct_bytes + 1

# This "len(range(correct_bytes))" thing is clunky, replace with "if correct_bytes == 4:"   
# REMOVED: if len(range(correct_bytes)) == 4:
# Also add "if IP.count(".") == 3" to ensure correct IPv4 format

if IP.count(".") == 3 and correct_bytes == 4:
    print("This is a valid IP address.")
else:    
    print("This is not a valid IP address.")

