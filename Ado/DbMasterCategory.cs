using ProyectoAroma.Configuracion;
using ProyectoAroma.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ProyectoAroma.Ado
{
    public class DbMasterCategory
    {
        public DbMasterCategory()
        {
        }

        public List<Categorias> ListCategoria()
        {
            List<Categorias> lstCategoria = new List<Categorias>();

            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@pcode_error", SqlDbType.NVarChar, 12),
                new SqlParameter("@pmessages", SqlDbType.NVarChar, 250),
            });

            Sqlprovider.Oparameters[0].Direction = ParameterDirection.Output;
            Sqlprovider.Oparameters[1].Direction = ParameterDirection.Output;

            DataTable DtRegistros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter("zsp_ListCategory", CommandType.StoredProcedure);

            int TotalRegistros = DtRegistros.Rows.Count;

            if (TotalRegistros > 0)
            {
                for (int i = 0; i < TotalRegistros; i++)
                {
                    Categorias oCategorias = new Categorias()
                    {
                        category_id = Convert.ToInt32(DtRegistros.Rows[i]["category_id"]),
                        category = DtRegistros.Rows[i]["category"].ToString(),
                        enabled = DtRegistros.Rows[i]["enabled"].ToString(),
                        created_date = Convert.ToDateTime(DtRegistros.Rows[i]["created_date"]),
                        updated_date = Convert.ToDateTime(DtRegistros.Rows[i]["updated_date"]),
                    };

                    lstCategoria.Add(oCategorias);
                }
            }

            return lstCategoria;
        }
    }
}
