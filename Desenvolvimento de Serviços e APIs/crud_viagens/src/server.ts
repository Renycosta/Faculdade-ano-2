import express from 'express'
const app = express()
const port = 3000

import routesViagens from "./routes/viagens"

app.use(express.json())

app.use("/viagens", routesViagens)

app.get('/', (req, res) => {
  res.send('API: Cadastro de Viagens')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
