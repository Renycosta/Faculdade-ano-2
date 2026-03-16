import { prisma } from "../../lib/prisma";
import { Router } from "express";

const router = Router()

router.get("/", async(req, res) => {
    const filmes = await prisma.filme.findMany()
    res.status(200).json(filmes)
})

router.post("/", async(req, res) => {
    const { titulo, genero, ano, duracao, sinopse } = req.body

    const filme = await prisma.filme.create({
        data: {titulo, genero, ano, duracao, sinopse}
    })

    res.status(201).json(filme)
})

export default router