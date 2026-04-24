import csv
f1 = []

with open("winners.csv", mode="r") as arq:
  dados_csv = csv.DictReader(arq)
  for linha in dados_csv:
    f1.append(linha)

def titulo(texto):
  print()
  print(texto)
  print("-"*40)

def top():
    pilotos = {}

    for i in f1:
        piloto = i["Winner"]
        pilotos[piloto] = pilotos.get(piloto, 0) + 1

    ordenar = sorted(pilotos.items(), key=lambda pilotos: pilotos[1], reverse=True)

    for x, (nome, vitorias) in enumerate(ordenar[0:10], start=1):
        print(f"{x:2d} {nome:20s} {vitorias:4d}")

def equipes():
    equipes = {}

    for i in f1:
        equipe = i["Car"]
        equipes[equipe] = equipes.get(equipe, 0) + 1
    
    ordenar = sorted(equipes.items(), key=lambda equipes: equipes[1],)

    for x, (nome, vitorias) in enumerate(ordenar, start=1):
        if vitorias >= 10:
            print(f"{x:2d} {nome:27s} {vitorias:4d}")

def tempo():

    tempos = [x for x in f1 if x['Time'] != '' and len(x['Time']) == 11]
    tempos2 = sorted(tempos, key=lambda tempo: tempo['Time'], reverse=True)

    for x, i in enumerate(tempos2[0:10], start=1):
        print(f"{x:2d} {i['Time']:13s} {i['Winner']:24s} {i['Car']:27s} {i['Grand Prix']:20s} {i['Date']:10s}")

def piloto():
    nome = input("Digite um piloto: ")

    principal = {}

    analise = [x for x in f1 if x]

while True:
  titulo("Passageiros do Titanic: Exemplos de Análises")
  print("1. Top 10 pilotos com maior nª de vitórias")
  print("2. Equipes com 10 ou + vitórias na F1")
  print("3. 10 provas com vitórias com maior tempo")
  print("4. Analisar piloto")
  print("5. Finalizar")
  opcao = int(input("Opção: "))
  if opcao == 1:
    top()
  elif opcao == 2:
    equipes()
  elif opcao == 3:
    tempo()
  elif opcao == 4:
    piloto()
  else:
    break
