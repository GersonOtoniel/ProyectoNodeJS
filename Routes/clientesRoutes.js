import express from 'express'
import { insertarCliente } from '../Controllers/clientesController';

const router = express.Router();

router.post('/clientes', insertarCliente);
router.post('/orden')

module.exports = router;
