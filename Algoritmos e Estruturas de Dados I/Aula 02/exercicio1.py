pessoas = int(input("Nº Pessoas: "))
peixes = int(input("Nº Peixes: "))

val = pessoas * 20

if peixes > pessoas:
    peival = (peixes - pessoas) * 12
else: 
    peival = 0

total = val + peival

print(f"Pagar R$: {total}.00")
