import { prisma } from "../../lib/prisma"
import { Router } from "express"
import { z } from "zod"
import { Posicao } from "../../generated/prisma/enums"

const router = Router()

const jogadorSchema = z.object({
    id: z.int(), 
    nome: z.string(), 
    posicao: z.enum(Posicao),
    dataNasc: z.date(),
    numCmisa: z.int(),
    selecaoId: z.int()
})

router.get("/", async (req, res) => {
    try {
        const viagens = await prisma.viagem.findMany()
        res.status(200).json(viagens)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const { destino, transporte, preco, dataSaida, 
            dataRetorno, roteiro = null } = req.body

    if (!destino || !transporte || !preco || !dataSaida || !dataRetorno) {
        res.status(400).json({ erro: "Informe destino, transporte, preco, dataSaida e dataRetorno" })
        return
    }

    try {
        const viagem = await prisma.viagem.create({
            data: { destino, transporte, preco, dataSaida, 
                    dataRetorno, roteiro }
        })
        res.status(201).json(viagem)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const { destino, transporte, preco, dataSaida, 
            dataRetorno, roteiro } = req.body

    if (!destino || !transporte || !preco || !dataSaida || !dataRetorno || !roteiro) {
        res.status(400).json({ erro: "Informe destino, transporte, preco, dataSaida, dataRetorno e roteiro" })
        return
    }

    try {
        const viagem = await prisma.viagem.update({
            where: { id: Number(id) },
            data: { destino, transporte, preco, dataSaida, dataRetorno, roteiro }
        })
        res.status(200).json(viagem)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão da viagem
    try {
        const viagem = await prisma.viagem.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(viagem)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

export default router