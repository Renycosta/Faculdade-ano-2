import random
import time
import sys

naipes = "♠♥♦♣"
extras = "JQKA"

# Baralho deve ter todas as cartas a serem sorteadas 
baralho = []

# def: função definida pelo usuário 
def monta_baralho():
    # monta baralho do 2 ao 10, com todos os naipes
    for i in range(2, 11):
        for naipe in naipes:
            baralho.append(str(i)+naipe) #"2♠️", "2@..."

    # Adiciona os simbolos extras JQKA com os naipes
    for extra in extras:
        for naipe in naipes:
            baralho.append(extra+naipe)

monta_baralho()

def verifica_pontos(carta):
    if len(carta) == 3:     #Só pode ser 10♠, 10♥
        num = 10
    elif carta[0].isdigit():    # Se é digito numérico
        num = int(carta[0])
    elif carta[0] == "A":   #Simbolos: A vale 11
        num = 11
    else:   #Outros simbolos valem 10
        num ='10'
    return num

pontos_jogador = 0      # Acumula pontos do jogador
contador = 0
# Geração das cartas para o Apostador
while True:
    # Gera umm número aleátorio entre 0 e tamanho do baralho -1
    num = random.randint(0, len(baralho)-1)
    # pop: Remove um elemento da lista(vetor)
    carta = baralho.pop(num)

    contador += 1
    print(f"Sua {contador}ª Carta é: {carta}")
    time.sleep(2)

    pontos_jogador += int(verifica_pontos(carta))

    if pontos_jogador >= 21:
        break

    if contador >= 2:
        outra = input("Deseja outra carta (S/N)").upper()
        if outra == "N":
            break

print()
print("*"*40)
print(f"Total de Pontos do Jogador: {pontos_jogador}")
print("*"*40)
print()

if pontos_jogador > 21:
    print("Bah... Você perdeu! Tente outra vez")
    sys.exit()      #Sai do programa

#############################################################

pontos_pc = 0      # Acumula pontos do pc
contador = 0
# Geração das cartas para o Computador
while True:
    # Gera umm número aleátorio entre 0 e tamanho do baralho -1
    num = random.randint(0, len(baralho)-1)
    # pop: Remove um elemento da lista(vetor)
    carta = baralho.pop(num)

    contador += 1
    print(f"A {contador}ª Carta do computador é: {carta}")
    time.sleep(2)

    pontos_pc += int(verifica_pontos(carta))

    if pontos_pc >= 21 or pontos_pc >= pontos_jogador:
        break

print()
print("*"*40)
print(f"Total de Pontos do Computador: {pontos_pc}")
print("*"*40)

print()
if pontos_pc > 21:
    print("Parabéns! Você venceu!")
elif pontos_pc == pontos_jogador:
    print("Oh... Deu empate")
else:
    print("Bah... Você perdeu")