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
    public partial class add_tasacambio : Form
    {
        public add_tasacambio()
        {
            InitializeComponent();
        }

        private void add_tasacambio_Load(object sender, EventArgs e)
        {
            ListarTasaCambio();
        }

        private void btnRegistrarTasa_Click(object sender, EventArgs e)
        {
            AddEditTasaCambio();
        }

        /// <summary>
        /// Listar las tasa de cambio registradas
        /// </summary>
        private void ListarTasaCambio()
        {
            try
            {
                DbTasaCambio oDbTasaCambio = new DbTasaCambio();
                List<TasaCambio> lstTasaCambio = oDbTasaCambio.ListTasaCambio();
                gdvTasaCambio.DataSource = lstTasaCambio;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        /// <summary>
        /// Registrar o Actualizar la tasa de cambio
        /// </summary>
        private void AddEditTasaCambio()
        {
            try
            {
                double rate = Convert.ToDouble(nudTasaCambio.Value.ToString().Replace(".", ""));
                DateTime rate_date = dtpFecha.Value;

                DbTasaCambio oDbTasaCambio = new DbTasaCambio();
                TasaCambio oTasaCambio = new TasaCambio();

                oTasaCambio.rate = rate;
                oTasaCambio.rate_date = rate_date;

                if (oDbTasaCambio.AddEditTasaCambio(oTasaCambio) > 0)
                {
                    MessageBox.Show("La tasa de cambio se registro con exito", "Información", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    ListarTasaCambio();
                }
                else
                {
                    MessageBox.Show("La tasa de cambio no se logro registrar", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
