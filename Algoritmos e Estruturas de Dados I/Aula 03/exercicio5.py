email = input("E-mail: ")

if email.find("@" ".") == -1 and email.find(" ") == -1:
    print("E-mail em formato inválido.")
else:
    print("Ok! E-mail em formato válido.")