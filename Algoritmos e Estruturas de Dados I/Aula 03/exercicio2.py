nome = input("Nome Completo: ")

space = False

for i in range(len(nome)):
    if nome[i].isspace() == True:
        space = True

if space == False:
    print("Ops... Por favor, digite o nome completo ")
else:
    partes = nome.split(" ")
    print(f"Nome completo: {nome}")
    print(f"Nome no crachá: {partes[0].upper()}")