using ProyectoAroma.Configuracion;
using ProyectoAroma.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ProyectoAroma.Ado
{
    public class DbTasaCambio
    {
        public DbTasaCambio()
        {
        }

        /// <summary>
        /// Listar las tasas de cambios
        /// </summary>
        /// <returns></returns>
        public List<TasaCambio> ListTasaCambio()
        {
            List<TasaCambio> lstTasaCambio = new List<TasaCambio>();

            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@pcode_error", SqlDbType.NVarChar, 12),
                new SqlParameter("@pmessages", SqlDbType.NVarChar, 250),
            });

            Sqlprovider.Oparameters[0].Direction = ParameterDirection.Output;
            Sqlprovider.Oparameters[1].Direction = ParameterDirection.Output;

            DataTable DtRegistros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter("zsp_ListRate", CommandType.StoredProcedure);

            int TotalRegistros = DtRegistros.Rows.Count;

            if (TotalRegistros > 0)
            {
                for (int i = 0; i < TotalRegistros; i++)
                {
                    TasaCambio oTasaCambio = new TasaCambio()
                    {
                        rate_id = Convert.ToInt32(DtRegistros.Rows[i]["rate_id"]),
                        rate = Convert.ToDouble(DtRegistros.Rows[i]["rate"]),
                        rate_date = Convert.ToDateTime(DtRegistros.Rows[i]["rate_date"]),
                        created_date = Convert.ToDateTime(DtRegistros.Rows[i]["created_date"]),
                        updated_date = Convert.ToDateTime(DtRegistros.Rows[i]["updated_date"])
                    };

                    lstTasaCambio.Add(oTasaCambio);
                }
            }

            return lstTasaCambio;
        }

        /// <summary>
        /// Registrar o Actualizar las tasas de cambios
        /// </summary>
        /// <param name="oTasaCambio"></param>
        /// <returns></returns>
        public int AddEditTasaCambio(TasaCambio oTasaCambio)
        {
            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@rate", oTasaCambio.rate),
                new SqlParameter("@rate_date", oTasaCambio.rate_date),
            });

            int Registros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter2("zsp_AddEditTasaCambio", CommandType.StoredProcedure);

            return Registros;
        }
    }
}
