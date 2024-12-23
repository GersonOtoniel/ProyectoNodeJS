import Sequelize from "@sequelize/core";
import { MsSqlDialect } from "@sequelize/mssql";


export const sequelize = new Sequelize({
    dialect: MsSqlDialect,
    server: 'localhost',
    port: 1433,
    database: 'GDA00386OTGersonGonzalez',
    trustServerCertificate: true,
    encrypt: false,
    authentication: {
        type: 'default',
        options: {
            userName: 'Gerson',
            password: '2018039886039886',
        }
    }
  });
