using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
// using Northwind.Model;
using System.ComponentModel;

namespace jqGrid.Models
{
    public class OrderViewModel
    {
        #region Properties
        public int Id { get; set; }

        public string Customer { get; set; }

        public string Employee { get; set; }

        public string Date { get; set; }

        [DisplayName("Required Date")]
        public string RequiredDate { get; set; }

        [DisplayName("Shipped Date")]
        public string ShippedDate { get; set; }

        [DisplayName("Ship Country")]
        public string ShipCountry { get; set; }
        #endregion

        #region Constructor
        public OrderViewModel(ProntoMVC.Data.Models.Cliente order)
        {
            Id = order.IdCliente;
            //Customer = order.Customer.Name;
            //Employee = String.Format("{0} {1}", order.Employee.FirstName, order.Employee.LastName);
            //Date = order.Date.ToString();
            //RequiredDate = order.RequiredDate.ToString();
            //ShippedDate = order.ShippedDate.ToString();
            //ShipCountry = order.ShipCountry;
        }
        #endregion
    }
}