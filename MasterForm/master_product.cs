using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ProyectoAroma.Models;
using ProyectoAroma.Ado;
using ProyectoAroma.MasterForm;

namespace ProyectoAroma
{
    public partial class master_product : Form
    {
        public master_product()
        {
            InitializeComponent();
        }

        private void master_product_Load(object sender, EventArgs e)
        {
            ListarProductos();
        }

        private void ListarProductos()
        {
            try
            {
                DbMasterProduct dbMasterProduct = new DbMasterProduct();
                List<Productos> lstProductos = dbMasterProduct.ListMasterProduct();
                dgvMasterProduct.DataSource = lstProductos;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            add_producto add_Producto = new add_producto();
            add_Producto.ShowDialog();
        }

        private void dgvMasterProduct_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {

        }

        private void dgvMasterProduct_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex > -1)
            {
                Productos oProductos = new Productos();

                for (int x = 0; x <= dgvMasterProduct.RowCount - 1; x++)
                {
                    if (dgvMasterProduct.Rows[x].Selected == true)
                    {
                        oProductos.Id = Convert.ToInt32(dgvMasterProduct.Rows[x].Cells["id"].Value);
                        oProductos.product = dgvMasterProduct.Rows[x].Cells["product"].Value.ToString();
                        oProductos.category_id = Convert.ToInt32(dgvMasterProduct.Rows[x].Cells["IdCategoria"].Value);
                        oProductos.price_usd = Convert.ToDouble(dgvMasterProduct.Rows[x].Cells["price"].Value);
                        oProductos.in_stock = Convert.ToDouble(dgvMasterProduct.Rows[x].Cells["in_stock"].Value);
                        oProductos.unit_measure_id = Convert.ToInt32(dgvMasterProduct.Rows[x].Cells["IdUnidadMedida"].Value);
                        oProductos.min_purchase_unit = Convert.ToInt32(dgvMasterProduct.Rows[x].Cells["CantidadReposicion"].Value);
                        oProductos.enabled = dgvMasterProduct.Rows[x].Cells["Habilitado"].Value.ToString();
                        edit_producto oedit_Producto = new edit_producto(oProductos);
                        oedit_Producto.ShowDialog();
                        break;
                    }
                }
                ListarProductos();
            }
        }
    }
}
