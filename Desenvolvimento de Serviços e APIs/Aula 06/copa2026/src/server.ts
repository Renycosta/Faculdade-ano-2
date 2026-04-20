import express from 'express'
const app = express()
const port = 3000

import routesSelecoes from "./routes/selecoes"
import routesJogadores from "./routes/jogadores"

app.use(express.json())

app.use("/selecoes", routesSelecoes)
app.use("/jogadores", routesJogadores)

app.get('/', (req, res) => {
  res.send('API: Cadastro e Pesquisa de Seleções e Jogadores da Copa 2026')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
