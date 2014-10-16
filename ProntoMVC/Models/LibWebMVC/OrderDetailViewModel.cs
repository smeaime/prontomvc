using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using Northwind.Model;
using System.ComponentModel;
using Lib.Web.Mvc.JQuery.JqGrid.DataAnnotations;
using Lib.Web.Mvc.JQuery.JqGrid;

namespace jqGrid.Models
{
    public class OrderDetailViewModel
    {
        #region Properties
        [JqGridColumnLayout(Width = 200)]
        public string Product { get; set; }

        [DisplayName("Unit Price")]
        [JqGridColumnLayout(Width = 100)]
        public decimal UnitPrice { get; set; }

        [JqGridColumnLayout(Width = 100)]
        public short Quantity { get; set; }

        [JqGridColumnLayout(Width = 100)]
        public float Discount { get; set; }
        #endregion

        #region Constructor
        public OrderDetailViewModel(ProntoMVC.Data.Models.DetalleCliente orderDetail)
        {
            Product = orderDetail.Puesto; // .Product.Name;
            //UnitPrice = orderDetail.UnitPrice;
            //Quantity = orderDetail.Quantity;
            //Discount = orderDetail.Discount;
        }
        #endregion
    }
}