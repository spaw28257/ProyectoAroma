using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProyectoAroma.Models
{
    public class Productos
    {
        public int Id { get; set; }
        public string product { get; set; }
        public string category { get; set; }
        public double in_stock { get; set; }
        public string unit_measure { get; set; }
        public double price_usd { get; set; }
        public double rate { get; set; }
        public double price_bs { get; set; }
        public int min_purchase_unit { get; set; }
        public string observaciones { get; set; }
        public string enabled { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set; }
        public int unit_measure_id { get; set; }
        public int category_id { get; set; }





    }
}
