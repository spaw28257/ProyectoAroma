using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProyectoAroma.Configuracion
{
    class ConfigurationSetting
    {
        /// <summary>
        /// Descripción: Se especifica la cadena de conexión a la base de datos SQL SERVER
        /// </summary>
        public string db_aroma { get; set; }

        public int Timeout { get; set; }
    }
}
