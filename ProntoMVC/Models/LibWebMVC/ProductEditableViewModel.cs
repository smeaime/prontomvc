using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using Lib.Web.Mvc.JQuery.JqGrid.DataAnnotations;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.ComponentModel.DataAnnotations;
using Northwind.Model;
using Lib.Web.Mvc.JQuery.JqGrid.Constants;
using System.Web.Mvc;

namespace jqGrid.Models
{
    [ModelBinder(typeof(ProductEditableViewModelBinder))]
    public class ProductEditableViewModel
    {
        #region Properties
        [JqGridColumnEditable(false)]
        public int Id { get; set; }

        [JqGridColumnEditable(true, EditType = JqGridColumnEditTypes.Text)]
        [StringLength(40)]
        [Required]
        public string Name { get; set; }

        [ScaffoldColumn(false)]
        [Required]
        public int SupplierId { get; set; }

        [JqGridColumnSortable(true, Index = "SupplierId")]
        [JqGridColumnEditable(true, "Suppliers", "Home", EditType = JqGridColumnEditTypes.Select)]
        [JqGridColumnFormatter("$.supplierFormatter")]
        [Required]
        public string Supplier { get; set; }

        [ScaffoldColumn(false)]
        [Required]
        public int CategoryId { get; set; }

        [JqGridColumnEditable(true, "Categories", "Home", EditType = JqGridColumnEditTypes.Select)]
        [Required]
        public string Category { get; set; }

        [DisplayName("Quantity Per Unit")]
        [JqGridColumnEditable(true, EditType = JqGridColumnEditTypes.Text)]
        [StringLength(20)]
        [Required]
        public string QuantityPerUnit { get; set; }

        [DisplayName("Unit Price")]
        [JqGridColumnFormatter(JqGridColumnPredefinedFormatters.Currency, DecimalPlaces = 2, DecimalSeparator = ".", Prefix = "$")]
        [JqGridColumnEditable(true, EditType = JqGridColumnEditTypes.Text)]
        [Range(0, Int32.MaxValue)]
        [Required]
        public decimal? UnitPrice { get; set; }

        [DisplayName("Units In Stock")]
        [JqGridColumnFormatter("$.unitsInStockFormatter", UnFormatter = "$.unitsInStockUnFormatter")]
        [JqGridColumnEditable(true)]
        [Range(0, 32767)]
        [Required]
        public short? UnitsInStock { get; set; }
        #endregion

        #region Constructor
        public ProductEditableViewModel()
        { }

        public ProductEditableViewModel(Product product)
        {
            this.Id = product.Id;
            this.Name = product.Name;
            this.SupplierId = product.SupplierId;
            this.Supplier = String.Format("[{0}] {1}", product.SupplierId, product.Supplier.Name);
            this.CategoryId = product.CategoryId;
            this.Category = product.Category.Name;
            this.QuantityPerUnit = product.QuantityPerUnit;
            this.UnitPrice = product.UnitPrice;
            this.UnitsInStock = product.UnitsInStock;
        }
        #endregion
    }
}