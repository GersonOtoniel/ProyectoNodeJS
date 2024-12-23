import { sequelize } from "../src/connect.js";
import multer from "multer";
const upload = multer()

exports.insertarProducto = async (req, res) => {
    const { CategoriaProductos_idCategoriaProductos, usuarios_idusuarios, nombre, marca, codigo, stock, estados_idestados, precio } = req.body;

    const foto = req.file ? req.file.buffer : null;
    
    try {
        await sequelize.query(
            'EXEC InsertarProducto @CategoriaProductos_idCategoriaProductos=:CategoriaProductos_idCategoriaProductos, @usuarios_idusuarios=:usuarios_idusuarios, @nombre=:nombre, @marca=:marca, @codigo=:codigo, @stock=:stock, @estados_idestados=:estados_idestados, @precio=:precio, @foto=:foto',
            {
                replacements: { CategoriaProductos_idCategoriaProductos, usuarios_idusuarios, nombre, marca, codigo, stock, estados_idestados, precio, foto },
            }
        );
        res.status(201).json({ message: 'Producto insertado correctamente' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.obtenerProductos = async (req, res) => {
    try {
        const productos = await sequelize.query('EXEC ObtenerProductos', { type: sequelize.QueryTypes.SELECT });
        res.status(200).json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};