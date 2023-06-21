using ProyectoAroma.MasterForm;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProyectoAroma
{
    public partial class frmPrincipal : Form
    {
        public frmPrincipal()
        {
            InitializeComponent();
        }

        private void registrarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            add_producto oadd_Producto = new add_producto();
            oadd_Producto.MdiParent = this;
            oadd_Producto.Show();
        }

        private void listadoProductosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            master_product omaster_product = new master_product();
            omaster_product.MdiParent = this;
            omaster_product.Show();
        }

        private void tasasDeCambioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            add_tasacambio oadd_tasacambio = new add_tasacambio();
            oadd_tasacambio.MdiParent = this;
            oadd_tasacambio.Show();
        }
    }
}
