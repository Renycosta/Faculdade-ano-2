import random   # Para números aleatórios
import time     # Para controle do tempo

figuras = "🍒🍇🍊"
# print(figura[0])
# print(figura[1])
# print(figura[2])
jogo = ""

nome = input("Nome do Apostador: ")
valor = int(input("Valor da Aposta R$: "))

input ("Pressioner Enter para iniciar...")

print("Suas Apostas: ", end="")

for i in range(3):
    # Gera um número aleatório entre 0 e 2

    num = random.randint(0, 2)
    print(figuras[num], end="", flush=True)
    time.sleep(1)
    jogo = jogo + figuras[num]

print()
if jogo[0] == jogo[1] and jogo[0] == jogo[2]:
    premio = valor * 3
    print(f"Parabéns {nome}! Você ganhou R${premio} 🍾🍾🍾")
elif jogo[0] == jogo[1] or jogo[0] == jogo[2] or jogo[1] == jogo[2]:
    print(f"Quase... {nome}! Tente novamente")
else:
    print(f"Bah {nome}... Não foi desta vez... Não desanime")