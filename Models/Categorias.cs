using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProyectoAroma.Models
{
    public class Categorias
    {
        public int category_id { get; set; }
        public string category { get; set; }
        public string enabled { get; set; }
        public DateTime created_date { get; set; }
        public DateTime updated_date { get; set;}
    }
}
