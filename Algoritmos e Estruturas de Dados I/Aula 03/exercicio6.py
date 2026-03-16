import random  

input("Clique ENTER para jogar: ")

primeira = True
ponto = ""

while True:
    dados = random.randint(1, 6) + random.randint(1, 6)
    if primeira == True:
        if dados == 7 or dados == 11:
            print(f"Parabéns você tirou um {dados} 'natural', você ganhou")
            break
        elif dados == 2 or dados == 3 or dados == 12:
            print(f"Você tirou um {dados} 'craps', você perdeu")
            break
        else:
            primeira = False
            ponto = dados
            print(f"O seu ponto é {dados}")
            input("Clique ENTER para continuar: ")
            continue
    else:
        if dados == ponto:
            print(f"Parabéns você tirou um {dados}, você ganhou")
            break
        elif dados == 7:
            print(f"Você tirou um {dados}, você perdeu")
            break
        else:
            print(f"{dados}, não foi dessa vez")
            input("Clique ENTER para continuar: ")
            continue