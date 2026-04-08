import random
import time
from colorama import init, Fore

# Inicializa o colorama
init(autoreset=True)

print(Fore.BLUE + "=== JOGO DESCUBRA A PALAVRA ===")
nome = input(Fore.MAGENTA + "Nome do jogador: ")

tempo_inicial = time.time()

palavras = []
dicas = []
erros = 0
max_erros = 6
pontos = 0

def carregar_palavras():
    try:
        with open("palavras.txt", "r", encoding="utf-8") as arq:
            dados = arq.readlines()
            for linhas in dados:
                partes = linhas.split(";")
                palavras.append(partes[0].upper())
                dicas.append(partes[1])
    except FileExistsError:
        print(Fore.RED + "Arquivo palavra.txt não encontrado")
        exit(1)     # 1: Indica saida por erro de execução

carregar_palavras()

num = random.randint(0, len(palavras)-1)

palavra = palavras[num]
dica = dicas[num]

letras_usadas = [palavra[0]]
palavra_escondida = ["_"] * len(palavra)

for i in range(0, len(palavra)):
    if palavra[i] == palavra[0]:
        palavra_escondida[i] = palavra[0]

carinhas = [
    "😀😀😀😀😀",
    "💀😀😀😀😀",
    "💀💀😀😀😀",
    "💀💀💀😀😀",
    "💀💀💀💀😀",
    "💀💀💀💀💀",
]

def pontos_val():
    global pontos
    val = 100
    if erros > 0:
        for i in range(0, erros):
            val = val - 20
    pontos = pontos + val

def mostrar_status():
    print(Fore.YELLOW + f"Status: {carinhas[erros]}")
    print(Fore.GREEN + f"Palavra: {' '.join(palavra_escondida)}")
    print(Fore.MAGENTA + f"Erros: {erros}/{max_erros}")

while True: 
    # Verifica se ganhou (palavra_escondida == palavra)
    if "".join(palavra_escondida) == palavra:
        print(Fore.GREEN + f"Parabéns {nome}! Você venceu")
        pontos_val()
        break

    if erros == max_erros:
        print(Fore.RED + f"Bah, {nome}. Perdeu! palavra era {palavra}")
        pontos_val()
        break

    mostrar_status()

    letra = input("\nletra ou * para ver dica (custa 1 vida): ").upper()

    if letra == "*":
        if "*" in letras_usadas:
            print(Fore.RED + "Dica já usada")
        else:
            print(Fore.YELLOW + f"Dica: {dica}")
            erros += 1
            pontos = pontos - 10
            letras_usadas.append("*")
        continue

    if letra in letras_usadas:
        print(Fore.RED + "Letra já usada")
        continue

    letras_usadas.append(letra)

    if letra in palavra:
        print(Fore.GREEN + f"Letra '{letra}' encontrada!")
        pontos = pontos + 10
        for i in range(len(palavra)):
            if palavra[i] == letra:
                palavra_escondida[i] = letra
    else:
        erros += 1
        pontos = pontos - 10
        print(Fore.RED + f"Letra '{letra}' não existe na palavra")

tempo_final = time.time()
duracao = tempo_final - tempo_inicial
print(Fore.YELLOW + f"Jogo durou: {duracao:.2f} segundos")
print(Fore.YELLOW + f"{pontos}")