import  DataTypes from 'sequelize';
import sequelize from '../src/connect.js';

const OrdenDetalles = sequelize.define('OrdenDetalles', {
    idOrdenDetalles: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    Orden_idOrden: { type: DataTypes.INTEGER, allowNull: false },
    Productos_idProductos: { type: DataTypes.INTEGER, allowNull: false },
    cantidad: { type: DataTypes.INTEGER },
    precio: { type: DataTypes.FLOAT },
    subtotal: { type: DataTypes.FLOAT },
}, {
    timestamps: false,
    tableName: 'OrdenDetalles',
});

module.exports = OrdenDetalles;
