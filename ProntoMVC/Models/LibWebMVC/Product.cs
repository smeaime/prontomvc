using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Northwind.Model
{
    public class Product
    {
        #region Properties
        public int Id { get; set; }

        public string Name { get; set; }

        public int SupplierId { get; set; }

        public Supplier Supplier { get; set; }

        public int CategoryId { get; set; }

        public Category Category { get; set; }

        public string QuantityPerUnit { get; set; }

        public decimal? UnitPrice { get; set; }

        public short? UnitsInStock { get; set; }
        #endregion
    }
}
