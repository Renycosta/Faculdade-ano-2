import { prisma } from "../../lib/prisma"
import { Router } from "express"

const router = Router()

router.get("/", async (req, res) => {
    try {
        const notebooks = await prisma.notebooks.findMany()
        res.status(200).json(notebooks)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const { modelo, marca, processador, preco, quantidade = null } = req.body

    if (!modelo || !marca || !processador || !preco) {
        res.status(400).json({ erro: "Informe modelo, marca, processador, preco" })
        return
    }

    try {
        const notebooks = await prisma.notebooks.create({
            data: { modelo, marca, processador, preco, quantidade }
        })
        res.status(201).json(notebooks)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const { modelo, marca, processador, preco, quantidade } = req.body

    if (!modelo || !marca || !processador || !preco || !quantidade) {
        res.status(400).json({ erro: "Informe modelo, marca, processador, preco e quantidade" })
        return
    }

    try {
        const notebooks = await prisma.notebooks.update({
            where: { id: Number(id) },
            data: { modelo, marca, processador, preco, quantidade }
        })
        res.status(200).json(notebooks)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão da notebooks
    try {
        const notebooks = await prisma.notebooks.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(notebooks)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.get("/mmp", async (req, res) => {
    try {
        const mmp = await prisma.notebooks.findMany({
            orderBy: [
                {
                    preco:"asc",
                }
            ],
            select: {
                marca: true,
                modelo: true,
                preco: true
            }
        })
        res.status(200).json(mmp)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.get("/media", async (req, res) => {
    try {
        const media = await prisma.notebooks.aggregate({
            _avg: {
                preco: true,
            },
        })
        const conta = await prisma.notebooks.count()
        const resposta = {
            media: media._avg.preco,
            conta: conta
        }

        res.status(200).json(resposta)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.get("/filtro", async (req, res) => {
    const {marca, preco} = req.query
    
    try {
        const resultado = await prisma.notebooks.findMany({
            where:{
                marca: String(marca),
                preco: {
                    lte: (Number(preco))
                }
            }
        })
        res.status(200).json(resultado)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

export default router