import { prisma } from "../../lib/prisma"
import { Router } from "express"
import { includes, z } from "zod"

const router = Router()

export const jogadorSchema = z.object({
    
})

router.get("/", async (req, res) => {
    try {
        const jogadores = await prisma.jogador.findMany({
            include: { selecao: true}
        })

        const jogadores2 = jogadores.map(jogador => ({
            id: jogador.id,
            nome: jogador.nome,
            posicao: jogador.posicao,
            dataNasc: jogador.dataNasc,
            numCamisa: jogador.numCamisa,
            selecao: jogador.selecao.pais,
            treinador: jogador.selecao.treinador
        }))

        res.status(200).json(jogadores2)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const valida = jogadorSchema.safeParse(req.body)

    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { nome, posicao, selecaoId, dataNasc, numCamisa } = valida.data

    try {
        const jogador = await prisma.jogador.create({
            data: { nome, posicao, selecaoId, dataNasc, numCamisa }
        })
        res.status(201).json(jogador)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const valida = jogadorSchema.safeParse(req.body)
    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { nome, posicao, selecaoId, dataNasc, numCamisa } = valida.data

    try {
        const jogador = await prisma.jogador.update({
            where: { id: Number(id) },
            data: { nome, posicao, selecaoId, dataNasc, numCamisa }
        })
        res.status(200).json(jogador)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão do jogador
    try {
        const jogador = await prisma.jogador.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(jogador)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.get('/:id', async (req, res) => {
    const id = Number(req.params.id)
    if (Number.isNaN(id)) {
        res.status(400).json({ erro: 'Código inválido' })
        return
    }

    try {
        const jogador = await prisma.jogador.findUnique({
            where: { id }
        })

        if (!jogador) {
            res.status(404).json({ erro: 'Jogador não cadastrado' })
            return
        }

        res.status(200).json(jogador)
    } catch (error) {
        console.log(error)
        res.status(500).json({ erro: 'Erro interno do servidor' })
    }
})

export default router