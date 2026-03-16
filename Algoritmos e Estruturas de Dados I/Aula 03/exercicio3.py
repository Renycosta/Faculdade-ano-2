palavra = input("Palavra: ")

ini = palavra[0]
des = ""

for i in range(len(palavra)):
    if palavra[i] == ini:
        des = des + ini
    else:
        des = des + "_"

print(f"Descubra: {des}")