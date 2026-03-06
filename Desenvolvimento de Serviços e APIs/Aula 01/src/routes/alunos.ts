import { Router } from "express";

const router = Router()

const alunos = [
    {
        id: 1,
        nome: "Ana Santos",
        curso: "ADS"
    },
    {
        id: 2,
        nome: "Ricardo Nóbrega",
        curso: "Redes"
    },
    {
        id: 3,
        nome: "Patrícia de Mattos",
        curso: "ADS"
    },
]

router.get("/", (req, res) => {
    res.status(200).json(alunos)
})

router.post("/", (req, res) => {
    const {nome, curso} = req.body

    alunos.push(
        {
            id: alunos.length + 1,
            nome,
            curso
        }
    )

    res.status(201).json({
        msg: "Aluno inserido com sucesso", 
        id: alunos.length
    })
})

export default router