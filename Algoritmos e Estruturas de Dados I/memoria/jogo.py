import random
import time
import os
from colorama import init, Fore

# Inicializa colorama
init(autoreset=True)

temp = "🦣🦣🐪🐪🐯🐯🦓🦓🐢🐢🐋🐋🦜🦜🐧🐧"
figuras = list(temp)   # converte a string para lista

print("="*40)
print("Jogo da Memória")
print("="*40)

jogador = input("\nNome do Jogador: ")
pontos = 0

# matriz dos bichos sorteados (jogo) e das apostas (corretas)
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
# print(jogo)            
# print(apostas)

def mostra_tabuleiro():
    os.system("cls")       # limpa a tela
    print("   1   2   3   4")
    for i in range(4):
        print(i+1, end="")
        for j in range(4):
            print(f" {jogo[i][j]} ", end="")
        print("\n")
    print("Memorize a posição dos bichos no tabuleiro...")
    time.sleep(2)
    
    print("Contagem Regressiva: ", end="")
    for i in range(10, 0, -1):
        print(i, end=" ", flush=True)
        time.sleep(1)
        
mostra_tabuleiro()        

def mostra_apostas():
    os.system("cls")       # limpa a tela
    print("   1   2   3   4")
    for i in range(4):
        print(i+1, end="")
        for j in range(4):
            print(f" {apostas[i][j]} ", end="")
        print("\n")
        
        
def faz_aposta(num):
    while True:
        mostra_apostas()
        posicao = input(f"{num}ª Coordenada (linha e coluna): ")        
        if len(posicao) != 2:
            print("Informe uma dezena (12, 23, 31, ...)")
            time.sleep(2)
            continue
        x = int(posicao[0])-1
        y = int(posicao[1])-1
        try:
            if apostas[x][y] == "🟥":
                apostas[x][y] = jogo[x][y]
                break
            else:
                print("Coordenada já apostada. Tente outra")
                time.sleep(2)
        except IndexError:
            print("Coordenada inválida. Repita")    
            time.sleep(2)
    return x, y        

def verifica_tabuleiro():
    faltam = 0
    for i in range(4):
        for j in range(4):
            if apostas[i][j] == "🟥":
                faltam += 1
    return faltam

tempo_inicial = time.time()
########################## Programa Principal ######################
while True:
    x1, y1 = faz_aposta(1)
    x2, y2 = faz_aposta(2)
    mostra_apostas()
    
    if apostas[x1][y1] == apostas[x2][y2]:
        print("Você acertou 😀") 
        pontos += 10
        contador = verifica_tabuleiro()
        if contador == 0:
            print("Parabéns! Você venceu! 🎉🎉")
            break
        else:    
            print(f"Falta Descobrir: {contador//2} bicho(s)")
        time.sleep(2)
    else:
        print("Você Errou 🥺")
        pontos -= 5
        time.sleep(2)
        apostas[x1][y1] = "🟥"
        apostas[x2][y2] = "🟥"
        continuar = input("Continuar (S/N): ").upper()
        if continuar == "N":        
            break

tempo_final = time.time()
duracao = int(tempo_final - tempo_inicial)

print(f"\n\nJogador: {jogador}")    
print(f"Total de Pontos: {pontos}")
print(f"Duração do Jogo: {duracao} segundos")

#----- Rotina para salvar os dados no arquivo ranking.txt
dados = []
if os.path.isfile("ranking.txt"):
    with open("ranking.txt", "r") as arq:
        dados = arq.readlines()

dados.append(f"{jogador};{pontos};{duracao}\n")

# with open("ranking.txt", "w") as arq:
#     for dado in dados:
#         arq.write(dado)

# modo "a+"" cria o arquivo se não existir
with open("ranking.txt", "a+") as arq:
    arq.write(f"{jogador};{pontos};{duracao}\n")

# ---- Rotina para classificar (Ranking)
ranking = sorted(dados, key=lambda x: (int(x.split(';')[1]), int(x.split(';')[2])*-1), reverse=True)

print()
print("="*43)
print(Fore.YELLOW + "---------< RANKING DOS JOGADORES >---------")
print("="*43)
print(Fore.CYAN + "Nº Nome do Jogador.........: Pontos Tempo.:")
        
posicao = 0        
for linha in ranking:
    partes = linha.split(";")    
    posicao += 1
    if partes[0] == jogador and int(partes[1]) == pontos and int(partes[2]) == duracao:    
        print(Fore.RED + f"{posicao:2d} {partes[0]:25s}   {int(partes[1]):2d}   {int(partes[2]):3d} seg")
    else:
        print(f"{posicao:2d} {partes[0]:25s}   {int(partes[1]):2d}   {int(partes[2]):3d} seg")