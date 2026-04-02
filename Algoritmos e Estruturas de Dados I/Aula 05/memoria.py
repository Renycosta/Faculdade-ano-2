import random
import time
import os

temp = "🐂🐂🐼🐼🐫🐫🐯🐯🦜🦜🐧🐧🐢🐢🐠🐠"
figuras = list(temp)

print("="*40)
print("Jogo da Memória")
print("="*40)

# Matriz dos animais sorteados (jogo) e das apostas (corretas)
jogo = []
apostas = []

def preenche_matriz():
    for i in range(4):
        jogo.append([])
        apostas.append([])
        for _ in range(4):
            num = random.randint(0, len(figuras)-1)
            jogo[i].append(figuras[num])
            apostas[i].append("🟥")
            figuras.pop(num)

preenche_matriz()
print(jogo)
print(apostas)

def mostra_tabuleiro():
    os.system("cls")
    print("   1   2   3   4")
    for i in range(4):
        print(f"{i+1}", end="")
        for j in range(4):
            print(f" {jogo[i][j]} ", end="")
        print("\n")
    print("Memorize a posição dos bichos...")
    time.sleep(2)

    print("Contagem Regressiva: ", end="")
    for i in range(10, 0, -1):
        print(i, end=" ", flush=True)
        time.sleep(1)

    os.system("cls")

mostra_tabuleiro()

def mostra_apostas():
    os.system("cls")
    print("   1   2   3   4")
    for i in range(4):
        print(f"{i+1}", end="")
        for j in range(4):
            print(f" {apostas[i][j]} ", end="")
        print("\n")

mostra_apostas()

def faz_apostas(num):
    while True:
        mostra_apostas()
        posicao = input(f"{num}ª Coordenado (linha e coluna): ")
        if len(posicao) != 2:
            print("informe uma dezena(12, 24, 31...)")
            time.sleep(2)
            continue
        x = int(posicao[0])-1
        y = int(posicao[1])-1
        try:
            if apostas[x][y] == "🟥":
                apostas[x][y] = jogo[x][y]
                break
            else:
                print("Coordenada já apostada... Escolha outra")
                time.sleep(2)
        except IndexError:
            print("Coordenada inválida... Repita")
            time.sleep(2)
    return x, y

def verifica_tabuleiro():
    faltam = 0
    for i in range(4):
        for j in range(4):
            if apostas[i][j] == "🟥":
                faltam += 1
    return faltam

while True:
    x1, y1 = faz_apostas(1)
    x2, y2 = faz_apostas(2)
    mostra_apostas()

    if apostas[x1][y1] == apostas[x2][y2]:
        print("Parabéns! Você acertou")
        print(f"Faltam {contador/2} bichos para serem descobertos")
        time.sleep(2)
        contador = verifica_tabuleiro()
        if contador == 0:
            print("Show você venceu")
            break
    else:
        print("Errou... Tente novamente")
        time.sleep(2)
        apostas[x1][y1] = "🟥"
        apostas[x2][y2] = "🟥"

        continuar = input("Continuar (S/N): ").upper
        if continuar == "N":
            break