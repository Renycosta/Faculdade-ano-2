num = int(input("Número: "))

total = 0
con = 0

print(f"Divisores do {num}")

for i in range(0, num):
    con = con + 1
    conta = num / con

    if conta == round(conta) and conta != num:
        print(conta)
        total = (total + conta)

print(f"Soma dos divisores: {total}")

if total == num:
    print(f"Portanto, {num} é um número perfeito")
else:
    print(f"{num} não é um número perfeito")