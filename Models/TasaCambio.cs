using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProyectoAroma.Models
{
    public class TasaCambio
    {
        public int rate_id { get; set; }
        public double rate { get; set; }
        public DateTime rate_date { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
    }
}
