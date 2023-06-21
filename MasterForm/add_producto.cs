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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Window;

namespace ProyectoAroma.MasterForm
{
    public partial class add_producto : Form
    {
        public add_producto()
        {
            InitializeComponent();
        }

        private void add_producto_Load(object sender, EventArgs e)
        {
            LlenarCategoria();
            LlenarUnidadesMedidas();
        }

        private void btnRegistrarProducto_Click(object sender, EventArgs e)
        {
            RegistrarProducto();
        }

        /// <summary>
        /// LLenar Categoria 
        /// </summary>
        private void LlenarCategoria()
        {
            try 
            {
                DbMasterCategory oDbMasterCategory = new DbMasterCategory();
                List<Categorias> lstCategorias = oDbMasterCategory.ListCategoria();
                cboCategoria.DataSource = lstCategorias;
                cboCategoria.DisplayMember = "category";
                cboCategoria.ValueMember = "category_id";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        /// <summary>
        /// Llenar Unidades de Medidas
        /// </summary>
        private void LlenarUnidadesMedidas()
        {
            try
            {
                DbUnidadesMedidas oDbUnidadesMedidas = new DbUnidadesMedidas();
                List<UnidadMedidas> lstUnidadMedidas = oDbUnidadesMedidas.ListUnidadesMedidas();
                cboUnidad.DataSource = lstUnidadMedidas;
                cboUnidad.DisplayMember = "unit_measure";
                cboUnidad.ValueMember = "unit_measure_id";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        /// <summary>
        /// Registrar los datos del Producto
        /// </summary>
        private void RegistrarProducto()
        {
            try
            {
                string vProducto = txtProducto.Text;
                int vUnidad_id = Convert.ToInt32(cboUnidad.SelectedValue);
                int vCategoria_id = Convert.ToInt32(cboCategoria.SelectedValue);
                double vEn_stock = Convert.ToDouble(nudInventario.Value.ToString().Replace(".", ""));
                double vPrecio = Convert.ToDouble(txtPrecio.Value.ToString().Replace(".", ""));
                int vReposicion = Convert.ToInt32(nudReposicion.Value.ToString().Replace(".", ""));
                string vHabilitar = "S";
                string vMensaje = string.Empty;

                if (chkHabilitar.Checked)
                    vHabilitar = "S";
                else
                    vHabilitar = "N";

                if (string.IsNullOrEmpty(vProducto))
                {
                    vMensaje = "Debe especificar el producto";
                }
                else if (vEn_stock <= 0)
                {
                    vMensaje = "Debe especificar la cantidad en inventario";
                }
                else if (vPrecio <= 0)
                {
                    vMensaje = "Debe especificar el precio del producto";
                }
                else if (vReposicion <= 0)
                {
                    vMensaje = "Debe especificar la cantidad minima de inventario para reponer el producto";
                }
                else
                {
                    vMensaje = string.Empty;
                }

                if (vMensaje.Length > 0)
                {
                    MessageBox.Show(vMensaje, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    DbMasterProduct oDbMasterProduct = new DbMasterProduct();
                    Productos oProductos = new Productos();
                    oProductos.product = vProducto;
                    oProductos.unit_measure_id = vUnidad_id;
                    oProductos.category_id = vCategoria_id;
                    oProductos.in_stock = vEn_stock;
                    oProductos.price_usd = vPrecio;
                    oProductos.min_purchase_unit = vReposicion;
                    oProductos.enabled = vHabilitar;

                    if (oDbMasterProduct.AddProduct(oProductos) > 0)
                    {
                        MessageBox.Show("El Producto se Registro con Exito", "Información", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("El Producto no se logro registrar", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
