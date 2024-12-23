import express from 'express'
import insertarProducto from '../Controllers/productosController.js'

const router = express.Router();

router.post('/productos', insertarProducto);

module.exports = router;