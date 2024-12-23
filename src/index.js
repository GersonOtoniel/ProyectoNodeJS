import express from 'express'
import { sequelize } from './connect.js'
import clientes from '../Routes/clientesRoutes.js'
import usuarios from '../Routes/usuariosRoutes.js'
import productos from '../Routes/productosRoutes.js'

const app = express()
app.use(express.json())
app.use('/api', clientes)
app.use('/api', usuarios)
app.use('/api', productos)


sequelize.authenticate()
    .then(() => {
        console.log("Conexión exitosa con la base de datos.");
    })
    .catch((error) => {
        console.error("Error al conectar con la base de datos:", error);
    });
    

app.listen('3000', ()=>{
    console.log('escuchando en el puerto 3000')
})