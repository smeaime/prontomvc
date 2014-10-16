using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Northwind.Repositories;
using Northwind.Repositories.Entity;
using System.Globalization;

namespace jqGrid.Models
{
    public class ProductEditableViewModelBinder : DefaultModelBinder
    {
        #region Fields
        ISuppliersRepository _suppliersRepository;
        ICategoriesRepository _categoriesRepository;
        #endregion

        #region Constructor
        public ProductEditableViewModelBinder()
            : this(new SuppliersRepository(), new CategoriesRepository())
        {
        }

        public ProductEditableViewModelBinder(ISuppliersRepository suppliersRepository, ICategoriesRepository categoriesRepository)
        {
            _suppliersRepository = suppliersRepository;
            _categoriesRepository = categoriesRepository;
        }
        #endregion

        #region Methods
        public override object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        {
            ProductEditableViewModel model = new ProductEditableViewModel();

            if (controllerContext.HttpContext.Request.Params["id"] != "_empty")
                model.Id = Convert.ToInt32(controllerContext.HttpContext.Request.Params["id"]);
            else
                model.Id = -1;
            model.Name = controllerContext.HttpContext.Request.Params["Name"];
            model.SupplierId = Convert.ToInt32(controllerContext.HttpContext.Request.Params["Supplier"]);
            model.Supplier = _suppliersRepository.FindByKey(model.SupplierId).Name;
            model.CategoryId = Convert.ToInt32(controllerContext.HttpContext.Request.Params["Category"]);
            model.Category = _categoriesRepository.FindByKey(model.CategoryId).Name;
            model.QuantityPerUnit = controllerContext.HttpContext.Request.Params["QuantityPerUnit"];
            model.UnitPrice = Convert.ToDecimal(controllerContext.HttpContext.Request.Params["UnitPrice"].Replace(".", CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator));
            model.UnitsInStock = Convert.ToInt16(controllerContext.HttpContext.Request.Params["UnitsInStock"]);
            
            return model;
        }
        #endregion
    }
}