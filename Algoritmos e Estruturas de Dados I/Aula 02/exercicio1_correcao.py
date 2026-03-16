pessoas = int(input("N° Pessoas: "))
peixes = int(input("N° Peixes: "))

if peixes <= pessoas:
    valor = pessoas
else:
    extras = peixes - pessoas
    valor = (pessoas * 20) + (extras * 12)

print(f"Valor a pagar R$ {valor:.2f}")