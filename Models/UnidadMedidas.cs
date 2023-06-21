using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProyectoAroma.Models
{
    public class UnidadMedidas
    {
        public int unit_measure_id { get; set; }
        public string unit_measure { get; set; }
        public string enabled { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
    }
}
