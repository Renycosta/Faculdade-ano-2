import { prisma } from "../../lib/prisma"
import { Router } from "express"
import { z } from "zod"

const router = Router()

const selecaoSchema = z.object({
    pais: z.string()
        .min(3, 'País deve possuir no mínimo 3 caracteres')
        .max(40, 'País deve ter no máximo 40 caracteres'),
    continente: z.string()
        .min(4, 'Continente deve possuir no mínimo 4 caracteres')
        .max(20, 'Continente deve ter no máximo 20 caracteres'),
    numCopas: z.number().int().min(0).optional(),
    treinador: z.string().max(40, 'Treinador deve ter no máximo 40 caracteres'),
})

router.get("/", async (req, res) => {
    try {
        const selecoes = await prisma.selecao.findMany({
            include: { jogadores: true }
        })
        res.status(200).json(selecoes)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const valida = selecaoSchema.safeParse(req.body)
    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { pais, continente, numCopas, treinador } = valida.data

    try {
        const selecao = await prisma.selecao.create({
            data: { pais, continente, numCopas, treinador }
        })
        res.status(201).json(selecao)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const valida = selecaoSchema.safeParse(req.body)
    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { pais, continente, numCopas, treinador } = valida.data

    try {
        const selecao = await prisma.selecao.update({
            where: { id: Number(id) },
            data: { pais, continente, numCopas, treinador }
        })
        res.status(200).json(selecao)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão da seleção
    try {
        const selecao = await prisma.selecao.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(selecao)
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
        const selecao = await prisma.selecao.findUnique({ 
            where: { id } 
        })

        if (!selecao) {
            res.status(404).json({ erro: 'seleção não cadastrada' })
            return
        }

        res.status(200).json(selecao)
    } catch (error) {
        console.log(error)
        res.status(500).json({ erro: 'Erro interno do servidor' })
    }
})

export default router