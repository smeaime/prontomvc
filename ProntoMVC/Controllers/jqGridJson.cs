using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ProntoMVC.Controllers
{
    class jqGridJson
    {
        public int total { get; set; }
        public int page { get; set; }
        public int records { get; set; }
        public jqGridRowJson[] rows { get; set; }
        // public  userdata;
    }
}
