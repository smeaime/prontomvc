using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;
//using Trirand.Web.Mvc;

namespace ProntoMVC.Controllers
{
    public partial class TransportistaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Transportistas = db.Transportistas
                .OrderBy(s => s.RazonSocial)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Transportistas.Count() / pageSize);

            return View(Transportistas);
        }

        // GET: 
        public virtual ActionResult Create()
        {
            return View();
        }

        // POST: 
        [HttpPost]
        public virtual ActionResult Create(ProntoMVC.Data.Models.Transportista Transportista)
        {
            if (ModelState.IsValid)
            {
                db.Transportistas.Add(Transportista);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(Transportista);
        }

        // GET: 
        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.Transportistas)) throw new Exception("No tenés permisos");
            ProntoMVC.Data.Models.Transportista Transportista;

            if (id == -1)
            {
                Transportista = new ProntoMVC.Data.Models.Transportista();
            }
            else
            {
                Transportista = db.Transportistas.Find(id);
            }
            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", Transportista.IdProvincia);
            ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", Transportista.IdCodigoIva);
            ViewBag.IdProveedor = new SelectList(db.Proveedores, "IdProveedor", "RazonSocial", Transportista.IdProveedor);
            return View(Transportista);
        }

        // POST: 
        [HttpPost]
        public virtual ActionResult Edit(ProntoMVC.Data.Models.Transportista Transportista)
        {
            if (!PuedeLeer(enumNodos.Transportistas)) throw new Exception("No tenés permisos");
            try
            {
                if (ModelState.IsValid)
                {
                    if (Transportista.IdTransportista <= 0)
                    {
                        db.Transportistas.Add(Transportista);
                        db.SaveChanges();
                    }
                    else
                    {
                        db.Entry(Transportista).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                else
                {
                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));
                    ViewBag.Errores = mensajes;
                    return View(Transportista);
                }
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();

                        ModelState.AddModelError(error.PropertyName, error.ErrorMessage); //http://msdn.microsoft.com/en-us/library/dd410404(v=vs.90).aspx
                    }
                }
                //CargarViewBag(Transportista);
                return View(Transportista);
            }

            catch (Exception ex)
            {
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
        }

        // GET: 
        public virtual ActionResult Delete(int id)
        {
            ProntoMVC.Data.Models.Transportista Transportista = db.Transportistas.Find(id);
            return View(Transportista);
        }

        // POST: 
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            ProntoMVC.Data.Models.Transportista Transportista = db.Transportistas.Find(id);
            db.Transportistas.Remove(Transportista);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Tabla = db.Transportistas.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "nombre":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Tabla2 = (from a in Tabla
                          select new
                          {
                              Id = a.IdTransportista,
                          }).Where(campo).ToList();

            int totalRecords = Tabla2.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Tabla
                        join b in db.Provincias on a.IdProvincia equals b.IdProvincia into ab from b in ab.DefaultIfEmpty()
                        select new { 
                                    a.IdTransportista, 
                                    a.RazonSocial, 
                                    a.Codigo, 
                                    a.Direccion, 
                                    Localidad = a.Localidade.Nombre, 
                                    a.CodigoPostal, 
                                    a.Telefono, 
                                    a.Email, 
                                    a.Cuit, 
                                    provincia = b != null ? b.Nombre : null 
                        }
                        ).Where(campo).OrderBy(sidx + " " + sord)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTransportista.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdTransportista}) +">Editar</>  -  <a href="+ Url.Action("Delete",new {id = a.IdTransportista}) +">Eliminar</>",
                                a.IdTransportista.ToString(),
                                a.RazonSocial,
                                a.Codigo.ToString(),
                                a.Direccion,
                                a.Localidad,
                                a.CodigoPostal,
                                a.provincia,
                                a.Telefono,
                                a.Email,
                                a.Cuit
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetLocalidadesAutocomplete(string term)
        {
            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Localidades
                                 where (item.Nombre.StartsWith(term))
                                 orderby item.Nombre
                                 select new
                                 {
                                     id = item.IdLocalidad,
                                     value = item.Nombre,  
                                     title = item.Nombre + " " + item.CodigoPostal, 
                                     idprovincia = item.IdProvincia
                                 }).Take(20).ToList();
            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
