import  DataTypes from 'sequelize';
import sequelize from '../src/connect.js';

const Orden = sequelize.define('Orden', {
    idOrden: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    usuarios_idusuarios: { type: DataTypes.INTEGER, allowNull: false },
    estados_idestados: { type: DataTypes.INTEGER, allowNull: false },
    fecha_creacion: { type: DataTypes.DATE },
    nombre_completo: { type: DataTypes.STRING },
    direccion: { type: DataTypes.STRING },
    telefono: { type: DataTypes.STRING },
    correo_electronico: { type: DataTypes.STRING },
    fecha_entrega: { type: DataTypes.DATE },
    total_orden: { type: DataTypes.FLOAT },
    Clientes_idClientes: { type: DataTypes.INTEGER, allowNull: false },
}, {
    timestamps: false,
    tableName: 'Orden',
});

module.exports = Orden;
