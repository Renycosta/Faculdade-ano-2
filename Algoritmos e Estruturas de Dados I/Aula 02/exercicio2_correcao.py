import sys
num = int(input("Número: "))

if num <= 0:
    print("Erro... Informe um número inteiro")
    sys.exit()  # Sai do programa

print("Divisores do Número: 1", end="")

soma = 1

# // Divisão de inteiros (ex. 5/2 => 2.5 e 5//2 => 2)
for i in range (1, num//2+1):
    if num % i == 0:
        print (f", {i}", end="")
        soma = soma + i

print()
print(f"Soma dos Divisores: {soma}")

if num == soma:
    print(f"{num} é um número perfeito")
else:
    print(f"{num} não é um número perfeito")