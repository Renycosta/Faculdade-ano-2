import express from 'express'
const app = express()
const port = 3000

import routesCandidatas from "./routes/candidatas"
import routesClientes from "./routes/clientes"
import routesVotos from "./routes/votos"

app.use(express.json())

app.use("/candidatas", routesCandidatas)
app.use("/clientes", routesClientes)
app.use("/votos", routesVotos)

app.get('/', (req, res) => {
  res.send('API: Cadastro e Pesquisa de Candidatas, Clientes e votos')
})

app.listen(port, () => {
  console.log(`Servidor Rodando na Porta: ${port}`)
})
