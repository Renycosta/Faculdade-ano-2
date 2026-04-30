import csv
visitantes = []

with open("Japao.csv", mode="r") as arq:
  dados_csv = csv.DictReader(arq)
  for linha in dados_csv:
    visitantes.append(linha)

def titulo(texto):
  print()
  print(texto)
  print("-"*40)

def num_paises():
  titulo("N° de Países Analisados")

  paises = {}
  for i in visitantes:
    pais = i["Country"]
    paises[pais] = paises.get(pais, 0) + 1
  print(len(paises))

  # utilizando o set
  paises2 = set()
  for visitante in visitantes:
    paises2.add(visitante['Country'])
  print(len(paises2))

  # list compreension
  paises3 = len(set([x['Country'] for x in visitantes]))
  print(paises3)

def top10_paises():
  titulo("Top 10 Países")

  paises = {}

  for i in visitantes:
    pais = i['Country']
    visi = int(i['Visitor'])
    paises[pais] = paises.get(pais, 0) + visi
  
  ordenar = sorted(paises.items(), key=lambda paises: paises[1], reverse=True)

  print("Nº País..........................: Nº Visitantes:")
  print("-------------------------------------------------")

  for x, (pais, visi) in enumerate(ordenar[0:10], start=1):
    print(f"{x:2d} {pais:30s} {visi:13d}")

def acima_100_mil():
  titulo("+100mil por mês")

  paises = set()
  for i in visitantes:
    if int(i['Visitor']) >= 100000:
      paises.add(i['Country'])
  
  print(paises)

def Top10_ano():
  titulo("+100mil por mês")

  ano = int(input('Digite o ano: '))

  paises = {}

  for i in visitantes:
    pais = i['Country']
    visi = int(i['Visitor'])
    if int(i['Year']) == ano: 
      paises[pais] = paises.get(pais, 0) + visi
  
  ordenar = sorted(paises.items(), key=lambda paises: paises[1], reverse=True)

  for x, (pais, visi) in enumerate(ordenar[0:10], start=1):
    print(f"{x:2d} {pais:20s} {visi:4d}")

while True:
  titulo("Visitantes do Japão: Exemplos de Análises")
  print("1. N° de Países Analisados")
  print("2. Top 10 Países")
  print("3. +100mil por mês")
  print("4. Top 10 Países por ano")
  print("5. Finalizar")
  opcao = int(input("Opção: "))
  if opcao == 1:
    num_paises()
  elif opcao == 2:
    top10_paises()
  elif opcao == 3:
    acima_100_mil()
  elif opcao == 4:
    Top10_ano()
  else:
    break
