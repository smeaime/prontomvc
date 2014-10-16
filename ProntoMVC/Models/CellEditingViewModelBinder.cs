using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;

namespace jqGrid.Models
{
    public class CellEditingViewModelBinder : DefaultModelBinder
    {
        public override object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            CellEditingViewModel model = new CellEditingViewModel();

            model.Id = Convert.ToInt32(controllerContext.HttpContext.Request.Params["id"]);

            if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("Descripcion"))
            {
                model.PropertyName = "Descripcion";
                model.PropertyValue = controllerContext.HttpContext.Request.Params["Descripcion"];
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("Codigo"))
            {
                model.PropertyName = "Codigo";
                model.PropertyValue = controllerContext.HttpContext.Request.Params["Codigo"];
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("Unidad"))
            {
                model.PropertyName = "IdUnidad";
                model.PropertyValue = Convert.ToInt32(controllerContext.HttpContext.Request.Params["Unidad"]);
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("Category"))
            {
                model.PropertyName = "CategoryID";
                model.PropertyValue = Convert.ToInt32(controllerContext.HttpContext.Request.Params["Category"]);
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("QuantityPerUnit"))
            {
                model.PropertyName = "QuantityPerUnit";
                model.PropertyValue = controllerContext.HttpContext.Request.Params["QuantityPerUnit"];
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("UnitPrice"))
            {
                model.PropertyName = "UnitPrice";
                model.PropertyValue = Convert.ToDecimal(controllerContext.HttpContext.Request.Params["UnitPrice"].Replace(".", CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator));
            }
            else if (controllerContext.HttpContext.Request.Params.AllKeys.Contains("UnitsInStock"))
            {
                model.PropertyName = "UnitsInStock";
                model.PropertyValue = Convert.ToInt16(controllerContext.HttpContext.Request.Params["UnitsInStock"]);
            }

            return model;
        }
    }
}