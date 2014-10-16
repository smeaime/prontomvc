using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace jqGrid.Models
{
    [ModelBinder(typeof(CellEditingViewModelBinder))]
    public class CellEditingViewModel
    {
        #region Properties
        public int Id { get; set; }

        public string PropertyName { get; set; }

        public object PropertyValue { get; set; }
        #endregion
    }
}