import express from 'express'
const app = express()
const port = 3000

import routesFilmes from './routes/filmes'

app.use(express.json())

app.use("/filmes", routesFilmes)

app.get('/', (req, res) => {
  res.send('API: Cadastro de filmes')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
