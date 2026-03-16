senha = input("Digite sua senha: ")

num = False
lower = False
upper = False

for i in range(len(senha)):
    if senha[i].isdigit() == True:
        num = True
    if senha[i].isupper() == True:
        upper = True
    if senha[i].islower() == True:
        lower = True

if num and lower and upper:
    if len(senha) >= 8 and len(senha) <= 12:
        print("Senha válida")
    else:
        print("Senha inválida")    
else:
    print("Senha inválida")
