import express from 'express'
const app = express()
const port = 3000

import routesSelecoes from "./routes/selecao"
import routesJogadores from "./routes/jogador"

app.use(express.json())

app.use("/selecao", routesSelecoes)
app.use("/jogador", routesJogadores)

app.get('/sel', (req, res) => {
  res.send('API: Cadastro de Selecao')
})

app.get('/jog', (req, res) => {
  res.send('API: Cadastro de Jogador')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
