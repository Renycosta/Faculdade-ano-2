import express from 'express'
const app = express()
const port = 3000

import routesNotebooks from "./routes/notebooks"

app.use(express.json())

app.use("/notebooks", routesNotebooks)

app.get('/', (req, res) => {
  res.send('API: Cadastro e Pesquisa de Notebooks')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
