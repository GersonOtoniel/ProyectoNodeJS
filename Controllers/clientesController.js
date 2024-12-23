const { sequelize } = require("../src/connect.js");

exports.insertarCliente = async (req, res) => {
    const { razon_social, nombre_comercial, direccion_entrega, telefono, email } = req.body;

    try {
        await sequelize.query(
            'EXEC InsertarCliente @razon_social=:razon_social, @nombre_comercial=:nombre_comercial, @direccion_entrega=:direccion_entrega, @telefono=:telefono, @email=:email',
            {
                replacements: { razon_social, nombre_comercial, direccion_entrega, telefono, email },
            }
        );
        res.status(201).json({ message: 'Cliente insertado correctamente' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
