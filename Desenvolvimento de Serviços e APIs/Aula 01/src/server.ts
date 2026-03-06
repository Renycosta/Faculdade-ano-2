import express from "express" 

import alunosRoutes from "./routes/alunos"

const app = express() 
const PORT = 3000 

app.use(express.json())
app.use("/alunos", alunosRoutes) 

app.get("/", (req, res) => { 
    res.json({ message: "API funcionando!" }) 
}) 

app.get("/banana", (req, res) => { 
    res.send("Banana") 
}) 

app.listen(PORT, () => { 
    console.log(`Servidor rodando na porta ${PORT}`) 
})