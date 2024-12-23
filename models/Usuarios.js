import  DataTypes from 'sequelize';
import sequelize from '../src/connect.js';

const Usuarios = sequelize.define('Usuarios', {
    idUsuarios: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre_usuario: { type: DataTypes.STRING, allowNull: false },
    contrasena: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING },
}, {
    timestamps: false,
    tableName: 'Usuarios',
});

module.exports = Usuarios;