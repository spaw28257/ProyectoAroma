using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace ProyectoAroma.Configuracion
{
    class SQLClient : Setting
    {
        public SQLClient()
        {
            Oparameters = new List<SqlParameter>();
        }

        public List<SqlParameter> Oparameters { get; set; }

        public SqlConnection SqlConnection()
        {
            try
            {
                //base de datos mentex
                SqlConnection SQLCon = new SqlConnection();
                SQLCon.ConnectionString = ConfigurationSetting.db_aroma;
                
                SQLCon.Open();

                return SQLCon;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        internal DataTable ExecuteStoredProcedureWithOutputParameter(string v1, CommandType storedProcedure, out bool v2, bool v3)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Retorna un listado desde una consulta de SQL en un DataTable
        /// </summary>
        /// <param name="Name"></param>
        /// <param name="CommandType"></param>
        /// <param name="OutParameter"></param>
        /// <returns></returns>
        public DataTable ExecuteStoredProcedureWithOutputParameter(string Name, CommandType CommandType)
        {
            //int Timeout
            DataTable dtData = new DataTable();
            SqlConnection SqlConexion = SqlConnection();

            try
            {
                List<SqlParameter> parameters = Oparameters;
                SqlCommand SQLComand = new SqlCommand();
                SQLComand.CommandText = Name;
                SQLComand.CommandTimeout = ConfigurationSetting.Timeout;
                SQLComand.CommandType = CommandType;
                SQLComand.Connection = SqlConexion;
                SQLComand.Parameters.AddRange(parameters.ToArray());
                //SQLComand.ExecuteNonQuery();
                SqlDataAdapter SQLDataAdapter = new SqlDataAdapter(SQLComand);
                SQLDataAdapter.Fill(dtData);
                return dtData;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                SqlConexion.Close();
                SqlConexion.Dispose();
            }
        }

        /// <summary>
        /// Retorna retorna un entero 0 si el procedimiento almacenado se ejecuto de foma correcta
        /// </summary>
        /// <param name="Name"></param>
        /// <param name="CommandType"></param>
        /// <param name="OutParameter"></param>
        /// <returns></returns>
        public int ExecuteStoredProcedureWithOutputParameter2(string Name, CommandType CommandType)
        {
            //int Timeout
            int Resultado;
            SqlConnection SqlConexion = SqlConnection();

            try
            {
                List<SqlParameter> parameters = Oparameters;
                SqlCommand SQLComand = new SqlCommand();
                SQLComand.CommandText = Name;
                SQLComand.CommandTimeout = ConfigurationSetting.Timeout;
                SQLComand.CommandType = CommandType;
                SQLComand.Connection = SqlConexion;
                SQLComand.Parameters.AddRange(parameters.ToArray());
                Resultado = SQLComand.ExecuteNonQuery();
                return Resultado;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                SqlConexion.Close();
                SqlConexion.Dispose();
            }
        }
    }
}
