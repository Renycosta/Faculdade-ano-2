num = int(input("Número de Chinchilas: "))
ano = int(input("Anos da criação: "))

contador = 0
acumulador = num
for i in range(0, ano, +1):
    contador = contador + 1    
    print(f"{contador}° Ano: {acumulador} chinchilas ")
    acumulador = acumulador * 3