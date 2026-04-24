import { prisma } from "../../lib/prisma"
import { Router } from "express"
import { email, z } from "zod"

const router = Router()

const alunoSchema = z.object({
    nome: z.string()
      .min(3, 'Nome deve possuir no mínimo com 3 caracteres')
      .max(40, 'Nome deve ter no máximo 40 caracteres'),
    turma: z.string()
      .min(2, 'Turma deve possuir no mínimo 2 caracteres')
      .max(20, 'Turma deve ter no máximo 3 caracteres'),
    responsavel: z.string()
      .min(3, 'Resposavel deve possuir no mínimo com 3 caracteres')
      .max(40, 'Resposavel deve ter no máximo 40 caracteres'),
    email: z.email(),
    obs: z.string().optional()
})

router.get("/", async (req, res) => {
    try {
        const alunos = await prisma.aluno.findMany({})
        res.status(200).json(alunos)
    } catch (error) {
        res.status(500).json({ erro: "Erro no servidor" })
    }
})

router.post("/", async (req, res) => {
    const valida = alunoSchema.safeParse(req.body)
    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { nome, turma, responsavel, email, obs = "" } = valida.data

    try {
        const aluno = await prisma.aluno.create({
            data: { nome, turma, responsavel, email, obs }
        })
        res.status(201).json(aluno)
    } catch (error) {
        res.status(500).json({ error })
    }
})

router.put("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    const valida = alunoSchema.safeParse(req.body)
    if (!valida.success) {
        res.status(400).json({ erro: valida.error })
        return
    }

    // Desestrutura os dados validados
    const { nome, turma, responsavel, email, obs } = valida.data

    try {
        const aluno = await prisma.aluno.update({
            where: { id: Number(id) },
            data: { nome, turma, responsavel, email, obs }
        })
        res.status(200).json(aluno)
    } catch (error) {
        res.status(500).json({ erro: error })
    }
})

router.delete("/:id", async (req, res) => {
    // recebe o id passado como parâmetro
    const { id } = req.params

    // realiza a exclusão da seleção
    try {
        const aluno = await prisma.aluno.delete({
            where: { id: Number(id) }
        })
        res.status(200).json(aluno)
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
        const aluno = await prisma.aluno.findUnique({ 
            where: { id } 
        })

        if (!aluno) {
            res.status(404).json({ erro: 'aluno não cadastrada' })
            return
        }

        res.status(200).json(aluno)
    } catch (error) {
        console.log(error)
        res.status(500).json({ erro: 'Erro interno do servidor' })
    }
})

export default router