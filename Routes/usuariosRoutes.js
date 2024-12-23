import express from 'express'
import { insertarUsuario } from '../Controllers/usuarioController';

const router = express.Router();

router.post('/usuarios', insertarUsuario);
//router.get('/usuarios', obtenerUsuarios);

module.exports = router;