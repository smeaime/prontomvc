using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProntoMVC.Models
{
    public class Tablas
    {
        public class Tree
        {
            public string IdItem { get; set; }
            public string Clave { get; set; }
            public string Descripcion { get; set; }
            public string ParentId { get; set; }
            public int Orden { get; set; }
            public string Parametros { get; set; }
            public string Link { get; set; }
            public string Imagen { get; set; }
            public string EsPadre { get; set; }
            
            public int nivel { get; set; }
            
        }

        public class Auxiliar
        {
            public int AuxL1 { get; set; }
            public int AuxL2 { get; set; }
            public int AuxL3 { get; set; }
            public int AuxL4 { get; set; }
            public int AuxL5 { get; set; }
            public string AuxS1 { get; set; }
            public string AuxS2 { get; set; }
            public string AuxS3 { get; set; }
            public string AuxS4 { get; set; }
            public string AuxS5 { get; set; }
        }
    }
}