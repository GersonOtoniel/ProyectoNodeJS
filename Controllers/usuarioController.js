import { sequelize } from "../src/connect.js";

exports.insertarUsuario = async (req, res) => {
    const { rol_idrol, estados_idestados, correo_electronico, nombre_completo, password, telefono, fecha_nacimiento } = req.body;

    try {
        await sequelize.query(
            'EXEC InsertarUsuario @rol_idrol=:rol_idrol, @estados_idestados=:estados_idestados, @correo_electronico=:correo_electronico, @nombre_completo=:nombre_completo, @password=:password, @telefono=:telefono, @fecha_nacimiento=:fecha_nacimiento, @fecha_creacion=:GETDATE() ',
            {
                replacements: { rol_idrol, estados_idestados, correo_electronico, nombre_completo, password, telefono, fecha_nacimiento },
            }
        );
        res.status(201).json({ message: 'Usuario insertado correctamente' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.obtenerUsuarios = async (req, res) => {
    try {
        const usuarios = await sequelize.query('EXEC ObtenerUsuarios', { type: sequelize.QueryTypes.SELECT });
        res.status(200).json(usuarios);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};