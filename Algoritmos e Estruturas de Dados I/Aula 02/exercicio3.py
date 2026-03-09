produto = input("Produto: ")
num = int(input("N° de etiquetas: "))

contador = 0
for i in range(0, num):
    contador = contador + 1
    if contador/2 == round(contador/2):
        print(produto, end="\n")
    else:
        print(produto, end=" ")