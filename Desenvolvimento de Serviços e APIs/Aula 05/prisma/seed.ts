import { prisma } from "../lib/prisma";
import { type Prisma } from "../generated/prisma/client"

const selecoes: Prisma.SelecaoCreateInput[]  = [
    {
        pais: "Brasil", 
        continente: "America",
        numCopas: 5,
        treinador: "Dorival Júnior"
    },
    { 
        pais: "França", 
        continente: "Europa", 
        numCopas: 2,
        treinador: "Didier Deschamps"
    },
    { 
        pais: "Japão", 
        continente: "Asia", 
        numCopas: 0,
        treinador: "Didier Deschamps"
    },
    { 
        pais: "Marrocos", 
        continente: "Africa", 
        numCopas: 0,
        treinador: "Didier Deschamps"
    },
]

const jogadores: Prisma.JogadorUncheckedCreateInput[]  = [
    { 
        nome: "Neymar Jr", 
        posicao: "Atacante", 
        numCamisa: 10, 
        dataNasc: new Date("1992-02-05"), 
        selecaoId: 1
    },
    { 
        nome: "Marquinhos", 
        posicao: "Zagueiro", 
        numCamisa: 4, 
        dataNasc: new Date("1994-05-14"), 
        selecaoId: 1 
    },
    { 
        nome: "Kylian Mbappé", 
        posicao: "Atacante", 
        numCamisa: 10, 
        dataNasc: new Date("1998-12-20"), 
        selecaoId: 2 
    },
    { 
        nome: "Mike Maignan", 
        posicao: "Goleiro", 
        numCamisa: 1, 
        dataNasc: new Date("1995-07-03"), 
        selecaoId: 2
    },
]

async function main() {
    try {
        await prisma.selecao.createMany({ data: selecoes })
        await prisma.jogador.createMany({ data: jogadores })
        console.log(`${selecoes.length} Seleçao Cadastrado...`)
        console.log(`${jogadores.length} Jogador Cadastrado...`)
    } catch (error) {
        console.error("Erro nas Inclusões (Seeds):", error);
        throw error;
    } finally {
        await prisma.$disconnect();
    }
}

await main()
