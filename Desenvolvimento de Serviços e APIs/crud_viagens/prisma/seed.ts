import { prisma } from "../lib/prisma";
import { type Prisma } from "../generated/prisma/client"

const viagens: Prisma.ViagemCreateInput[]  = [
    {
        destino: "Festival de Balonismo de Torres",
        transporte: "Terrestre",
        dataSaida: "2026-04-30T06:00:00Z",
        dataRetorno: "2026-05-01T23:00:00Z",
        preco: 2500
    }
]

async function main() {
    try {
        await prisma.viagem.createMany({ data: viagens })
        console.log(`${viagens.length} Viagens Cadastradas...`)
    } catch (error) {
        console.error("Erro nas Inclusões (Seeds):", error);
        throw error;
    } finally {
        await prisma.$disconnect();
    }
}

await main()
