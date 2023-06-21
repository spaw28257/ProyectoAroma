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

namespace ProyectoAroma.MasterForm
{
    public partial class edit_producto : Form
    {
        Productos oProductosx;

        public edit_producto(Productos oProductos)
        {
            InitializeComponent();
            oProductosx = oProductos;
        }

        private void edit_producto_Load(object sender, EventArgs e)
        {
            LlenarCategoria();
            LlenarUnidadesMedidas();

            txtItem.Text = oProductosx.Id.ToString();
            txtProducto.Text = oProductosx.product;
            cboCategoria.SelectedValue = oProductosx.category_id;
            txtPrecio.Value = Convert.ToDecimal(oProductosx.price_usd);
            txtInventario.Value = Convert.ToDecimal(oProductosx.in_stock);
            cboUnidad.SelectedValue = oProductosx.unit_measure_id;
            txtReposicion.Value = Convert.ToInt32(oProductosx.min_purchase_unit);

            if (oProductosx.enabled == "Sí")
                chkHabilitar.Checked = true;
            else
                chkHabilitar.Checked = false;
        }

        private void btnModificar_Click(object sender, EventArgs e)
        {
            EditarProducto();
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            this.Close();
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
        /// Editar los datos del Producto
        /// </summary>
        private void EditarProducto()
        {
            try
            {
                int Item = Convert.ToInt32(txtItem.Text);
                string vProducto = txtProducto.Text;
                int vUnidad_id = Convert.ToInt32(cboUnidad.SelectedValue);
                int vCategoria_id = Convert.ToInt32(cboCategoria.SelectedValue);
                double vEn_stock = Convert.ToDouble(txtInventario.Value.ToString().Replace(".", ""));
                double vPrecio = Convert.ToDouble(txtPrecio.Value.ToString().Replace(".", ""));
                int vReposicion = Convert.ToInt32(txtReposicion.Value.ToString().Replace(".", ""));
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
                    oProductos.Id = Item;
                    oProductos.product = vProducto;
                    oProductos.unit_measure_id = vUnidad_id;
                    oProductos.category_id = vCategoria_id;
                    oProductos.in_stock = vEn_stock;
                    oProductos.price_usd = vPrecio;
                    oProductos.min_purchase_unit = vReposicion;
                    oProductos.enabled = vHabilitar;

                    if (oDbMasterProduct.EditProduct(oProductos) > 0)
                    {
                        MessageBox.Show("El Producto se Actualizo con Exito", "Información", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("El Producto no se logro Actualizar", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
