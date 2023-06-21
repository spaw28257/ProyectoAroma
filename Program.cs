using ProyectoAroma.Configuracion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;

namespace ProyectoAroma
{
    internal static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Setting.ConfigurationSetting = new ConfigurationSetting
            {
                //string de conexión para sql server
                db_aroma = ConfigurationManager.AppSettings["db_aroma"],
            };

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmPrincipal());
        }
    }
}
