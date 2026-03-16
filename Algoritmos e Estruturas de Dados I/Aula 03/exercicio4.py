palavra = input("Palavra: ")

inversa = ""

for i in range(len(palavra), 0, -1):
    inversa = inversa + palavra[i-1]

if inversa == palavra:
    print(f"{palavra} é Palíndrome")
else:
    print(f"{palavra} não é Palíndrome")