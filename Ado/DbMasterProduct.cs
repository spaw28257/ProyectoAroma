using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using ProyectoAroma.Configuracion;
using ProyectoAroma.Models;

namespace ProyectoAroma.Ado
{
    public class DbMasterProduct
    {
        public DbMasterProduct() { }

        public List<Productos> ListMasterProduct()
        {
            List<Productos> lstProductos = new List<Productos>();

            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@pcode_error", SqlDbType.NVarChar, 12),
                new SqlParameter("@pmessages", SqlDbType.NVarChar, 250),
            });

            Sqlprovider.Oparameters[0].Direction = ParameterDirection.Output;
            Sqlprovider.Oparameters[1].Direction = ParameterDirection.Output;

            DataTable DtRegistros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter("zsp_ListInventoryProducts", CommandType.StoredProcedure);

            int TotalRegistros = DtRegistros.Rows.Count;

            if (TotalRegistros > 0)
            {
                for (int i = 0; i < TotalRegistros; i++)
                {
                    Productos oProductos = new Productos
                    {
                        Id = Convert.ToInt32(DtRegistros.Rows[i]["Item"]),
                        product = DtRegistros.Rows[i]["Producto"].ToString(),
                        category = DtRegistros.Rows[i]["Categoria"].ToString(),
                        in_stock = Convert.ToDouble(DtRegistros.Rows[i]["EnInventario"]),
                        unit_measure = DtRegistros.Rows[i]["Unidad"].ToString(),
                        price_usd = Convert.ToDouble(DtRegistros.Rows[i]["Precio"]),
                        rate = Convert.ToDouble(DtRegistros.Rows[i]["rate"]),
                        price_bs = Convert.ToDouble(DtRegistros.Rows[i]["precio_bs"]),
                        min_purchase_unit = Convert.ToInt32(DtRegistros.Rows[i]["CantidadReposicion"]),
                        observaciones = DtRegistros.Rows[i]["Observaciones"].ToString(),
                        enabled = DtRegistros.Rows[i]["Habilitado"].ToString(),
                        created_date = Convert.ToDateTime(DtRegistros.Rows[i]["FechaRegistro"]),
                        updated_date = Convert.ToDateTime(DtRegistros.Rows[i]["FechaModificacion"]),
                        unit_measure_id = Convert.ToInt32(DtRegistros.Rows[i]["IdUnidadMedida"]),
                        category_id = Convert.ToInt32(DtRegistros.Rows[i]["IdCategoria"]),
                    };

                    lstProductos.Add(oProductos);
                }
            }

            return lstProductos;
        }

        /// <summary>
        /// Registrar Productos
        /// </summary>
        /// <param name="oProductos"></param>
        /// <returns></returns>
        public int AddProduct(Productos oProductos)
        {
            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@product", oProductos.product),
                new SqlParameter("@unit_measure_id", oProductos.unit_measure_id),
                new SqlParameter("@category_id", oProductos.category_id),
                new SqlParameter("@in_stock", oProductos.in_stock),
                new SqlParameter("@price", oProductos.price_usd),
                new SqlParameter("@min_purchase_unit", oProductos.min_purchase_unit),
                new SqlParameter("@enabled", oProductos.enabled)
            });

            int Registros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter2("zsp_AddProduct", CommandType.StoredProcedure);

            return Registros;
        }

        /// <summary>
        /// Modificar Producto
        /// </summary>
        /// <param name="oProductos"></param>
        /// <returns></returns>
        public int EditProduct(Productos oProductos)
        {
            SQLClient Sqlprovider = new SQLClient();
            Sqlprovider.Oparameters.AddRange(new SqlParameter[] {
                new SqlParameter("@id", oProductos.Id),
                new SqlParameter("@product", oProductos.product),
                new SqlParameter("@unit_measure_id", oProductos.unit_measure_id),
                new SqlParameter("@category_id", oProductos.category_id),
                new SqlParameter("@in_stock", oProductos.in_stock),
                new SqlParameter("@price", oProductos.price_usd),
                new SqlParameter("@min_purchase_unit", oProductos.min_purchase_unit),
                new SqlParameter("@enabled", oProductos.enabled)
            });

            int Registros = Sqlprovider.ExecuteStoredProcedureWithOutputParameter2("zsp_EditProduct", CommandType.StoredProcedure);

            return Registros;
        }
    }
}
