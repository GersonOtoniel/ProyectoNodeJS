import  DataTypes from 'sequelize';
import sequelize from '../src/connect.js';

const Clientes = sequelize.define('Clientes', {
    idClientes: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    razon_social: { type: DataTypes.STRING, allowNull: false },
    nombre_comercial: { type: DataTypes.STRING },
    direccion_entrega: { type: DataTypes.STRING },
    telefono: { type: DataTypes.STRING },
    email: { type: DataTypes.STRING },
}, {
    timestamps: false,
    tableName: 'Clientes',
});

module.exports = Clientes;
