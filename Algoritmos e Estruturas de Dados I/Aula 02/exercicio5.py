contador = 0
acumulador = 0
maior = 0

while True:
    num = int(input("Informe números ou 0 para sair: "))
    contador = contador + 1
    
    if num != 0:
        acumulador = acumulador + num
        if num >= maior:
            maior = num
        print(f"Número: {num}")
        continue
    else:
        break

print("----------------------------")
print(f"Números digitados: {contador-1}")
print(f"Soma dos Números: {acumulador}")
print(f"Maior Número: {maior}")