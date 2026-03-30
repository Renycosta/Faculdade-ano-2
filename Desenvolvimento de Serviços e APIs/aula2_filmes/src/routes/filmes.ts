import { prisma } from "../../lib/prisma"
import { Router } from "express"

const router = Router()

router.get("/", async (req, res) => {
    try {
        const filmes = await prisma.filme.findMany()
        res.status(200).json(filmes)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const { titulo, genero, duracao, ano, sinopse = null } = req.body

    if (!titulo || !genero || !duracao || !ano) {
        res.status(400).json({ erro: "Informe todos os dados" })
        return
    }

    try {
        const filme = await prisma.filme.create({
            data: { titulo, genero, duracao, ano, sinopse }
        })
        res.status(201).json(filme)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // recebe as variáveis vindas no corpo da requisição
    const { titulo, genero, duracao, ano, sinopse } = req.body

    // verifica se os campos obrigatórios foram passados
    if (!titulo || !genero || !duracao || !ano) {
        res.status(400).json({ erro: "Informe todos os dados" })
        return
    }

    try {
        const filme = await prisma.filme.update({
            where: { id: Number(id) },
            data: { titulo, genero, duracao, ano, sinopse }
        })
        res.status(200).json(filme)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão do filme
    try {
        const filme = await prisma.filme.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(filme)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

export default router