// <auto-generated />
// This file was generated by a T4 template.
// Don't change it directly as your change would get overwritten.  Instead, make changes
// to the .tt file (i.e. the T4 template) and save it to regenerate this file.

// Make sure the compiler doesn't complain about missing Xml comments and CLS compliance
#pragma warning disable 1591, 3008, 3009
#region T4MVC

using System;
using System.Diagnostics;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Web.Mvc.Html;
using System.Web.Routing;
using T4MVC;
namespace ProntoMVC.Controllers
{
    public partial class CuentaCorrienteController
    {
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public CuentaCorrienteController() { }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        protected CuentaCorrienteController(Dummy d) { }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        protected RedirectToRouteResult RedirectToAction(ActionResult result)
        {
            var callInfo = result.GetT4MVCResult();
            return RedirectToRoute(callInfo.RouteValueDictionary);
        }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        protected RedirectToRouteResult RedirectToAction(Task<ActionResult> taskResult)
        {
            return RedirectToAction(taskResult.Result);
        }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        protected RedirectToRouteResult RedirectToActionPermanent(ActionResult result)
        {
            var callInfo = result.GetT4MVCResult();
            return RedirectToRoutePermanent(callInfo.RouteValueDictionary);
        }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        protected RedirectToRouteResult RedirectToActionPermanent(Task<ActionResult> taskResult)
        {
            return RedirectToActionPermanent(taskResult.Result);
        }

        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ViewResult Details()
        {
            return new T4MVC_System_Web_Mvc_ViewResult(Area, Name, ActionNames.Details);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult Edit()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Edit);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult EditExterno()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.EditExterno);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult Delete()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Delete);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult DeleteConfirmed()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.DeleteConfirmed);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult Presupuestos()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Presupuestos);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult CuentaCorrienteAcreedorPendiente()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.CuentaCorrienteAcreedorPendiente);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.ActionResult DetPresupuestos()
        {
            return new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.DetPresupuestos);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.JsonResult DetPresupuestosSinFormato()
        {
            return new T4MVC_System_Web_Mvc_JsonResult(Area, Name, ActionNames.DetPresupuestosSinFormato);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.RedirectToRouteResult AddToEmpresa()
        {
            return new T4MVC_System_Web_Mvc_RedirectToRouteResult(Area, Name, ActionNames.AddToEmpresa);
        }
        [NonAction]
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public virtual System.Web.Mvc.RedirectToRouteResult RemoveFromEmpresa()
        {
            return new T4MVC_System_Web_Mvc_RedirectToRouteResult(Area, Name, ActionNames.RemoveFromEmpresa);
        }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public CuentaCorrienteController Actions { get { return MVC.CuentaCorriente; } }
        [GeneratedCode("T4MVC", "2.0")]
        public readonly string Area = "";
        [GeneratedCode("T4MVC", "2.0")]
        public readonly string Name = "CuentaCorriente";
        [GeneratedCode("T4MVC", "2.0")]
        public const string NameConst = "CuentaCorriente";

        static readonly ActionNamesClass s_actions = new ActionNamesClass();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionNamesClass ActionNames { get { return s_actions; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionNamesClass
        {
            public readonly string Index = "Index";
            public readonly string IndexExterno = "IndexExterno";
            public readonly string Details = "Details";
            public readonly string Create = "Create";
            public readonly string Edit = "Edit";
            public readonly string EditExterno = "EditExterno";
            public readonly string Delete = "Delete";
            public readonly string DeleteConfirmed = "Delete";
            public readonly string Presupuestos = "Presupuestos";
            public readonly string CuentaCorrienteAcreedorPendiente = "CuentaCorrienteAcreedorPendiente";
            public readonly string DetPresupuestos = "DetPresupuestos";
            public readonly string DetPresupuestosSinFormato = "DetPresupuestosSinFormato";
            public readonly string AddToEmpresa = "AddToEmpresa";
            public readonly string RemoveFromEmpresa = "RemoveFromEmpresa";
        }

        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionNameConstants
        {
            public const string Index = "Index";
            public const string IndexExterno = "IndexExterno";
            public const string Details = "Details";
            public const string Create = "Create";
            public const string Edit = "Edit";
            public const string EditExterno = "EditExterno";
            public const string Delete = "Delete";
            public const string DeleteConfirmed = "Delete";
            public const string Presupuestos = "Presupuestos";
            public const string CuentaCorrienteAcreedorPendiente = "CuentaCorrienteAcreedorPendiente";
            public const string DetPresupuestos = "DetPresupuestos";
            public const string DetPresupuestosSinFormato = "DetPresupuestosSinFormato";
            public const string AddToEmpresa = "AddToEmpresa";
            public const string RemoveFromEmpresa = "RemoveFromEmpresa";
        }


        static readonly ActionParamsClass_Details s_params_Details = new ActionParamsClass_Details();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_Details DetailsParams { get { return s_params_Details; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_Details
        {
            public readonly string id = "id";
        }
        static readonly ActionParamsClass_Edit s_params_Edit = new ActionParamsClass_Edit();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_Edit EditParams { get { return s_params_Edit; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_Edit
        {
            public readonly string id = "id";
            public readonly string presupuesto = "presupuesto";
        }
        static readonly ActionParamsClass_EditExterno s_params_EditExterno = new ActionParamsClass_EditExterno();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_EditExterno EditExternoParams { get { return s_params_EditExterno; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_EditExterno
        {
            public readonly string id = "id";
        }
        static readonly ActionParamsClass_Delete s_params_Delete = new ActionParamsClass_Delete();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_Delete DeleteParams { get { return s_params_Delete; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_Delete
        {
            public readonly string id = "id";
        }
        static readonly ActionParamsClass_DeleteConfirmed s_params_DeleteConfirmed = new ActionParamsClass_DeleteConfirmed();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_DeleteConfirmed DeleteConfirmedParams { get { return s_params_DeleteConfirmed; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_DeleteConfirmed
        {
            public readonly string id = "id";
        }
        static readonly ActionParamsClass_Presupuestos s_params_Presupuestos = new ActionParamsClass_Presupuestos();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_Presupuestos PresupuestosParams { get { return s_params_Presupuestos; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_Presupuestos
        {
            public readonly string sidx = "sidx";
            public readonly string sord = "sord";
            public readonly string page = "page";
            public readonly string rows = "rows";
            public readonly string _search = "_search";
            public readonly string searchField = "searchField";
            public readonly string searchOper = "searchOper";
            public readonly string searchString = "searchString";
            public readonly string FechaInicial = "FechaInicial";
            public readonly string FechaFinal = "FechaFinal";
        }
        static readonly ActionParamsClass_CuentaCorrienteAcreedorPendiente s_params_CuentaCorrienteAcreedorPendiente = new ActionParamsClass_CuentaCorrienteAcreedorPendiente();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_CuentaCorrienteAcreedorPendiente CuentaCorrienteAcreedorPendienteParams { get { return s_params_CuentaCorrienteAcreedorPendiente; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_CuentaCorrienteAcreedorPendiente
        {
            public readonly string sidx = "sidx";
            public readonly string sord = "sord";
            public readonly string page = "page";
            public readonly string rows = "rows";
            public readonly string _search = "_search";
            public readonly string searchField = "searchField";
            public readonly string searchOper = "searchOper";
            public readonly string searchString = "searchString";
            public readonly string FechaInicial = "FechaInicial";
            public readonly string FechaFinal = "FechaFinal";
        }
        static readonly ActionParamsClass_DetPresupuestos s_params_DetPresupuestos = new ActionParamsClass_DetPresupuestos();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_DetPresupuestos DetPresupuestosParams { get { return s_params_DetPresupuestos; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_DetPresupuestos
        {
            public readonly string sidx = "sidx";
            public readonly string sord = "sord";
            public readonly string page = "page";
            public readonly string rows = "rows";
            public readonly string IdPresupuesto = "IdPresupuesto";
        }
        static readonly ActionParamsClass_DetPresupuestosSinFormato s_params_DetPresupuestosSinFormato = new ActionParamsClass_DetPresupuestosSinFormato();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_DetPresupuestosSinFormato DetPresupuestosSinFormatoParams { get { return s_params_DetPresupuestosSinFormato; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_DetPresupuestosSinFormato
        {
            public readonly string IdPresupuesto = "IdPresupuesto";
        }
        static readonly ActionParamsClass_AddToEmpresa s_params_AddToEmpresa = new ActionParamsClass_AddToEmpresa();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_AddToEmpresa AddToEmpresaParams { get { return s_params_AddToEmpresa; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_AddToEmpresa
        {
            public readonly string id = "id";
            public readonly string empresa = "empresa";
        }
        static readonly ActionParamsClass_RemoveFromEmpresa s_params_RemoveFromEmpresa = new ActionParamsClass_RemoveFromEmpresa();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ActionParamsClass_RemoveFromEmpresa RemoveFromEmpresaParams { get { return s_params_RemoveFromEmpresa; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ActionParamsClass_RemoveFromEmpresa
        {
            public readonly string id = "id";
            public readonly string empresa = "empresa";
        }
        static readonly ViewsClass s_views = new ViewsClass();
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public ViewsClass Views { get { return s_views; } }
        [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
        public class ViewsClass
        {
            static readonly _ViewNamesClass s_ViewNames = new _ViewNamesClass();
            public _ViewNamesClass ViewNames { get { return s_ViewNames; } }
            public class _ViewNamesClass
            {
                public readonly string IndexExterno = "IndexExterno";
            }
            public readonly string IndexExterno = "~/Views/CuentaCorriente/IndexExterno.cshtml";
        }
    }

    [GeneratedCode("T4MVC", "2.0"), DebuggerNonUserCode]
    public partial class T4MVC_CuentaCorrienteController : ProntoMVC.Controllers.CuentaCorrienteController
    {
        public T4MVC_CuentaCorrienteController() : base(Dummy.Instance) { }

        [NonAction]
        partial void IndexOverride(T4MVC_System_Web_Mvc_ViewResult callInfo);

        [NonAction]
        public override System.Web.Mvc.ViewResult Index()
        {
            var callInfo = new T4MVC_System_Web_Mvc_ViewResult(Area, Name, ActionNames.Index);
            IndexOverride(callInfo);
            return callInfo;
        }

        [NonAction]
        partial void IndexExternoOverride(T4MVC_System_Web_Mvc_ViewResult callInfo);

        [NonAction]
        public override System.Web.Mvc.ViewResult IndexExterno()
        {
            var callInfo = new T4MVC_System_Web_Mvc_ViewResult(Area, Name, ActionNames.IndexExterno);
            IndexExternoOverride(callInfo);
            return callInfo;
        }

        [NonAction]
        partial void DetailsOverride(T4MVC_System_Web_Mvc_ViewResult callInfo, int id);

        [NonAction]
        public override System.Web.Mvc.ViewResult Details(int id)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ViewResult(Area, Name, ActionNames.Details);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            DetailsOverride(callInfo, id);
            return callInfo;
        }

        [NonAction]
        partial void CreateOverride(T4MVC_System_Web_Mvc_ActionResult callInfo);

        [NonAction]
        public override System.Web.Mvc.ActionResult Create()
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Create);
            CreateOverride(callInfo);
            return callInfo;
        }

        [NonAction]
        partial void EditOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, int id);

        [NonAction]
        public override System.Web.Mvc.ActionResult Edit(int id)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Edit);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            EditOverride(callInfo, id);
            return callInfo;
        }

        [NonAction]
        partial void EditExternoOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, int id);

        [NonAction]
        public override System.Web.Mvc.ActionResult EditExterno(int id)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.EditExterno);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            EditExternoOverride(callInfo, id);
            return callInfo;
        }

        [NonAction]
        partial void EditOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, ProntoMVC.Data.Models.Presupuesto presupuesto);

        [NonAction]
        public override System.Web.Mvc.ActionResult Edit(ProntoMVC.Data.Models.Presupuesto presupuesto)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Edit);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "presupuesto", presupuesto);
            EditOverride(callInfo, presupuesto);
            return callInfo;
        }

        [NonAction]
        partial void DeleteOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, int id);

        [NonAction]
        public override System.Web.Mvc.ActionResult Delete(int id)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Delete);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            DeleteOverride(callInfo, id);
            return callInfo;
        }

        [NonAction]
        partial void DeleteConfirmedOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, int id);

        [NonAction]
        public override System.Web.Mvc.ActionResult DeleteConfirmed(int id)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.DeleteConfirmed);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            DeleteConfirmedOverride(callInfo, id);
            return callInfo;
        }

        [NonAction]
        partial void PresupuestosOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal);

        [NonAction]
        public override System.Web.Mvc.ActionResult Presupuestos(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.Presupuestos);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sidx", sidx);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sord", sord);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "page", page);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "rows", rows);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "_search", _search);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchField", searchField);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchOper", searchOper);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchString", searchString);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "FechaInicial", FechaInicial);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "FechaFinal", FechaFinal);
            PresupuestosOverride(callInfo, sidx, sord, page, rows, _search, searchField, searchOper, searchString, FechaInicial, FechaFinal);
            return callInfo;
        }

        [NonAction]
        partial void CuentaCorrienteAcreedorPendienteOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal);

        [NonAction]
        public override System.Web.Mvc.ActionResult CuentaCorrienteAcreedorPendiente(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.CuentaCorrienteAcreedorPendiente);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sidx", sidx);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sord", sord);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "page", page);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "rows", rows);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "_search", _search);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchField", searchField);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchOper", searchOper);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "searchString", searchString);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "FechaInicial", FechaInicial);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "FechaFinal", FechaFinal);
            CuentaCorrienteAcreedorPendienteOverride(callInfo, sidx, sord, page, rows, _search, searchField, searchOper, searchString, FechaInicial, FechaFinal);
            return callInfo;
        }

        [NonAction]
        partial void DetPresupuestosOverride(T4MVC_System_Web_Mvc_ActionResult callInfo, string sidx, string sord, int? page, int? rows, int? IdPresupuesto);

        [NonAction]
        public override System.Web.Mvc.ActionResult DetPresupuestos(string sidx, string sord, int? page, int? rows, int? IdPresupuesto)
        {
            var callInfo = new T4MVC_System_Web_Mvc_ActionResult(Area, Name, ActionNames.DetPresupuestos);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sidx", sidx);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "sord", sord);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "page", page);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "rows", rows);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "IdPresupuesto", IdPresupuesto);
            DetPresupuestosOverride(callInfo, sidx, sord, page, rows, IdPresupuesto);
            return callInfo;
        }

        [NonAction]
        partial void DetPresupuestosSinFormatoOverride(T4MVC_System_Web_Mvc_JsonResult callInfo, int IdPresupuesto);

        [NonAction]
        public override System.Web.Mvc.JsonResult DetPresupuestosSinFormato(int IdPresupuesto)
        {
            var callInfo = new T4MVC_System_Web_Mvc_JsonResult(Area, Name, ActionNames.DetPresupuestosSinFormato);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "IdPresupuesto", IdPresupuesto);
            DetPresupuestosSinFormatoOverride(callInfo, IdPresupuesto);
            return callInfo;
        }

        [NonAction]
        partial void AddToEmpresaOverride(T4MVC_System_Web_Mvc_RedirectToRouteResult callInfo, System.Guid id, string empresa);

        [NonAction]
        public override System.Web.Mvc.RedirectToRouteResult AddToEmpresa(System.Guid id, string empresa)
        {
            var callInfo = new T4MVC_System_Web_Mvc_RedirectToRouteResult(Area, Name, ActionNames.AddToEmpresa);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "empresa", empresa);
            AddToEmpresaOverride(callInfo, id, empresa);
            return callInfo;
        }

        [NonAction]
        partial void RemoveFromEmpresaOverride(T4MVC_System_Web_Mvc_RedirectToRouteResult callInfo, System.Guid id, string empresa);

        [NonAction]
        public override System.Web.Mvc.RedirectToRouteResult RemoveFromEmpresa(System.Guid id, string empresa)
        {
            var callInfo = new T4MVC_System_Web_Mvc_RedirectToRouteResult(Area, Name, ActionNames.RemoveFromEmpresa);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "id", id);
            ModelUnbinderHelpers.AddRouteValues(callInfo.RouteValueDictionary, "empresa", empresa);
            RemoveFromEmpresaOverride(callInfo, id, empresa);
            return callInfo;
        }

    }
}

#endregion T4MVC
#pragma warning restore 1591, 3008, 3009
