import sys

print("1. Incluir Palavra")
print("2. Listar Palavras") 
print("3. Alterar Dica") 
print("4. Excluir Palavra") 
print("5. Listar Palavras em Ordem") 
print("6. Finalizar")

esc = int(input("Escolha a opção: "))

menu = True
palavras = []

def Voltar_menu():
    input("Pressione enter para voltar ao menu ")
    menu = True

def Incluir_Palavra():
    menu = False
    palavra = input("Escreva a palavra: ")
    palavras.append(palavra)
    print(f"A palavra {palavra} foi adicionado com sucesso")

def Listar_Palavras():
    print(palavras)

while menu == True:
    if esc == 1:
        Incluir_Palavra()
    elif esc == 2:
        Listar_Palavras()
    elif esc == 3:
        Alterar_Dica()
    elif esc == 4:
        Excluir_Palavra()
    elif esc == 5:
        Listar_Palavras_em_Ordem()
    else:
        sys.exit()  