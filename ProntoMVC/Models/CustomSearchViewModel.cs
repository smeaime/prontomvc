using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace jqGrid.Models
{
    public class CustomSearchViewModel
    {
        public string Codigo { get; set; }

        public string Descripcion { get; set; }

        public int? IdUnidad { get; set; }

        public string GetFilterExpression()
        {
            StringBuilder filterExpressionBuilder = new StringBuilder();
            if (!String.IsNullOrWhiteSpace(Codigo))
                filterExpressionBuilder.Append(String.Format("Codigo = {0} AND ", Codigo));
            if (!String.IsNullOrWhiteSpace(Descripcion))
                filterExpressionBuilder.Append(String.Format("Descripcion = \"{0}\" AND ", Descripcion));
            if (IdUnidad.HasValue)
                filterExpressionBuilder.Append(String.Format("IdUnidad = {0} AND ", IdUnidad));
            if (filterExpressionBuilder.Length > 0)
                filterExpressionBuilder.Remove(filterExpressionBuilder.Length - 5, 5);
            return filterExpressionBuilder.ToString();
        }
    }
}