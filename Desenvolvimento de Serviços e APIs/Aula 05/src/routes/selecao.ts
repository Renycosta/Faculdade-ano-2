import { prisma } from "../../lib/prisma"
import { Router } from "express"
import { z } from "zod"
import { Continentes } from "../../generated/prisma/enums";

const router = Router()

const selecaoSchema = z.object({ 
    id: z.int(), 
    pais: z.string(), 
    continente: z.enum(Continentes),
    numCopas: z.int().nullable().optional(),
});

router.get("/sel", async (req, res) => {
    try {
        const selecoes = await prisma.selecao.findMany()
        res.status(200).json(selecoes)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/sel", async (req, res) => {

    const { pais, continente, numCopas, jogadores, treinador } = req.body

    const valida = selecaoSchema.safeParse(req.body) 
    if (!valida.success) { 
        res.status(400).json({ erro: valida.error }) 
        return 
    }

    try {
        const selecao = await prisma.selecao.create({
            data: { pais, continente, numCopas, jogadores, treinador }
        })
        res.status(201).json(selecao)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/sel:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const { pais, continente, numCopas, jogadores, treinador } = req.body

    const valida = selecaoSchema.safeParse(req.body) 
    if (!valida.success) { 
        res.status(400).json({ erro: valida.error }) 
        return 
    }

    try {
        const selecao = await prisma.selecao.update({
            where: { id: Number(id) },
            data: { pais, continente, numCopas, jogadores, treinador }
        })
        res.status(200).json(selecao)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/sel:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão da selecao
    try {
        const selecao = await prisma.selecao.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(selecao)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

export default router