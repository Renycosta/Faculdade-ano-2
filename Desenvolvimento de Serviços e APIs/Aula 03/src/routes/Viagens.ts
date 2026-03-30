import { prisma } from "../../lib/prisma"
import { Router } from "express"

const router = Router()

router.get("/", async (req, res) => {
    try {
        const viagens = await prisma.viagem.findMany()
        res.status(200).json(viagens)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const { Destino, Transporte, Preco, dataSaida, dataRetorno, roteiro = null } = req.body

    if (!Destino || !Transporte || !Preco || !dataSaida || !dataRetorno) {
        res.status(400).json({ erro: "Informe todos os dados" })
        return
    }

    try {
        const viagem = await prisma.viagem.create({
            data: { Destino, Transporte, Preco, dataSaida, dataRetorno, roteiro }
        })
        res.status(201).json(viagem)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // recebe as variáveis vindas no corpo da requisição
    const { Destino, Transporte, Preco, dataSaida, dataRetorno, roteiro } = req.body

    // verifica se os campos obrigatórios foram passados
    if (!Destino || !Transporte || !Preco || !dataSaida || !dataRetorno) {
        res.status(400).json({ erro: "Informe todos os dados" })
        return
    }

    try {
        const viagem = await prisma.viagem.update({
            where: { id: Number(id) },
            data: { Destino, Transporte, Preco, dataSaida, dataRetorno, roteiro }
        })
        res.status(200).json(viagem)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão do viagem
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