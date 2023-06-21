using ProyectoAroma.Configuracion;
using ProyectoAroma.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ProyectoAroma.Ado
{
    public class DbUnidadesMedidas
    {
        public DbUnidadesMedidas()
        {
        }

        public List<UnidadMedidas> ListUnidadesMedidas()
        {
            List<UnidadMedidas> lstUnidadMedidas = new List<UnidadMedidas>();

            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@pcode_error", SqlDbType.NVarChar, 12),
                new SqlParameter("@pmessages", SqlDbType.NVarChar, 250),
            });

            Sqlprovider.Oparameters[0].Direction = ParameterDirection.Output;
            Sqlprovider.Oparameters[1].Direction = ParameterDirection.Output;

            DataTable DtRegistros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter("zsp_ListUnitMeasure", CommandType.StoredProcedure);

            int TotalRegistros = DtRegistros.Rows.Count;

            if (TotalRegistros > 0)
            {
                for (int i = 0; i < TotalRegistros; i++)
                {
                    UnidadMedidas oUnidadMedidas = new UnidadMedidas()
                    {
                        unit_measure_id = Convert.ToInt32(DtRegistros.Rows[i]["unit_measure_id"]),
                        unit_measure = DtRegistros.Rows[i]["unit_measure"].ToString(),
                        enabled = DtRegistros.Rows[i]["Enable"].ToString(),
                        created_date = Convert.ToDateTime(DtRegistros.Rows[i]["created_date"]),
                        updated_date = Convert.ToDateTime(DtRegistros.Rows[i]["updated_date"])
                    };

                    lstUnidadMedidas.Add(oUnidadMedidas);
                }
            }

            return lstUnidadMedidas;
        }
    }
}
