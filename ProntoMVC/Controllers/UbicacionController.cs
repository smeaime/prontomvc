using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Text;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using ProntoMVC.Data.Models; 
using ProntoMVC.Models;
using Pronto.ERP.Bll;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;//using DocumentFormat.OpenXml.Spreadsheet;
using OpenXmlPowerTools;
using ClosedXML.Excel;

namespace ProntoMVC.Controllers
{
    public partial class UbicacionController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            //var Pedidos = db.Pedidos.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ActionResult GetUbicaciones()
        {
            Dictionary<int, string> ubicaciones = new Dictionary<int, string>();
            foreach (Ubicacion u in db.Ubicaciones.OrderBy(x => x.Descripcion).ToList())
                ubicaciones.Add(u.IdUbicacion, u.Descripcion);

            return PartialView("Select", ubicaciones);
        }
    }
}
