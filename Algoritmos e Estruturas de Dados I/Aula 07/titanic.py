import csv

# lista dos passageiros (lista de dicionarios)
titanic = []

# lê os dados do arquivo e insere na lista
with open("train.csv") as arq:
    dados_csv = csv.DictReader(arq)
    for linha in dados_csv:
        titanic.append(linha)

# print(titanic[0])
# print(titanic[0]['Name'])

def titulo(texto, traco="-"):
    print()
    print(texto.upper())
    print(traco*40)

def dados_sexo():
    titulo("Passageiros por Sexo e Sobreviventes")
    masc = 0
    v_masc = 0
    m_masc = 0
    fem = 0
    v_fem = 0
    m_fem = 0
    for i in range(len(titanic)):
        if titanic[i]['Sex'] == "male":
            masc += 1
            if titanic[i]['Survived'] == "1":
                v_masc += 1
            else:
                m_masc += 1
        else:
            fem += 1
            if titanic[i]['Survived'] == "1":
                v_fem += 1
            else:
                m_fem += 1

    print(f'Masculino: {masc}')
    print(f'Sobreviventes: {v_masc}')
    print(f'Mortos: {m_masc}')
    print('\n')
    print(f'Feminino: {fem}')
    print(f'Sobreviventes: {v_fem}')
    print(f'Mortos: {m_fem}')

def med():
    soma = 0
    contador = 0
    for i in range(len(titanic)):
        if titanic[i]['Age'] == "":
            continue
        else:
            soma += int(float(titanic[i]['Age']))
            contador += 1
        
                
    print(soma / contador)

while True:
    titulo("Passageiros do titanic", "=")
    print("1. Dados por sexo e sobreviventes")
    print("2. Media de Idade e mais idosos (Top 10)")
    print("3. Dados por classe e sobreviventes")
    print("4. Finalizar")
    opcao = int(input("Opção: "))
    if opcao == 1:
        dados_sexo()
    elif opcao == 2:
        med()
    else:
        break