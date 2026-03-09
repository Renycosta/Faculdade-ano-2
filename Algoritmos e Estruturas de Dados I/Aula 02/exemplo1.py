nome = input("Nome do aluno: ")
idade = int(input("Idade: "))
salario = float(input("Salário R$: "))

print("\n--------- Dados do aluno ---------")
print(f"Nome: {nome}")
print(f"Idade: {idade} anos")
print(f"Salário R$: {salario:9.2f}")

if idade >= 40 and salario >= 5000:
    print("Acima de 40 e ganhando bem!")

if nome == "ana" or nome == "Pedro":
    print("Bonito nome...")

if idade >= 18:
    print("Você é maior de idade")
    bonus = 500
else:
    print("Você é menor de idade")
    bonus = 300

print(f"Você recebeu um bônus de R$ {bonus:3.2f}")