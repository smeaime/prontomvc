using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;

using System.ServiceProcess;

using FCEngine;

using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using ProntoMVC.Data.Models;
using ProntoMVC.Data;

using ExtensionMethods;

using Pronto.ERP.Bll;

using Microsoft.VisualBasic;

using Excel = Microsoft.Office.Interop.Excel;

using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;


using BitMiracle.LibTiff.Classic;

using System.Configuration;

using System.Reflection;

using System.Data.Objects;

using OfficeOpenXml; //EPPLUS, no confundir con el OOXML
using System.Data;

using System.ServiceModel;


using OpenQA.Selenium.Firefox;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium.Support.Extensions;
using OpenQA.Selenium.PhantomJS;
using OpenQA.Selenium.Chrome;


using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;
//using GeoJSON.Net.Geometry;
using System.Text.RegularExpressions;

using System.Net;
//using Microsoft.AspNet.SignalR.Client;

using System.Data.Entity.SqlServer;

using System.Transactions;


using System.Data.Entity;


namespace ServicioMVC
{






    public class servi : IDisposable
    {


        private DemoProntoEntities db; //= new DemoProntoEntities(sCadenaConex());
        private ProntoMVC.Data.Models.Mantenimiento.ProntoMantenimientoEntities dbmant;



        public servi(string cadenaconexionDirectaFormatoEF)
        {
            db = new DemoProntoEntities(cadenaconexionDirectaFormatoEF);
        }







        private bool _disposed;


        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    db.Dispose();
                    dbmant.Dispose();
                    // Dispose other managed resources.
                }
                //release unmanaged resources.
            }
            _disposed = true;
        }









        /*

        public servi(string cadenaconexionBdlmaster, string nombreempresa) //2 constructores
        {


            //MiniProfiler profiler = MiniProfiler.Current;




            //ROOT = ConfigurationManager.AppSettings["UrlDominio"]; // ConfigurationManager.AppSettings["Root"] ["UrlDominio"];
            asignacadena();

            //string us = oStaticMembershipService.GetUser().ProviderUserKey.ToString();

            string sConexBDLMaster = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(cadenaconexion);
            System.Data.DataTable dt = EntidadManager.ExecDinamico(sConexBDLMaster,
                                                     "SELECT * FROM BASES " +
                                                     "join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD " +
                                                     "where UserId='" + us + "'");

            //List<SelectListItem> baselistado = new List<SelectListItem>();
            //foreach (DataRow r in dt.Rows)
            //{
            //    baselistado.Add(new SelectListItem { Text = r["Descripcion"] as string, Value = "" });
            //}

            //ViewBag.Bases = baselistado;
        }








        public string SCsql()
        {
            var d = new dsEncrypt();
            d.KeyString = "EDS";

            string s = Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService);
            return d.Encrypt(s);


        }




        private void asignacadena(string nombreEmpresa)
        {
            string sc;

            Guid uguid = (Guid)new Guid();


            try
            {


                //if (!System.Diagnostics.Debugger.IsAttached) //si uso esto, anda hacer "Debug test", pero no "Run test".

                if (this.Session["Usuario"].NullSafeToString() == "")
                    uguid = (Guid)oStaticMembershipService.GetUser().ProviderUserKey;
                else
                    uguid = new Guid("1804B573-0439-4EA0-B631-712684B54473");
                // administrador    1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9
                // supervisor       1804B573-0439-4EA0-B631-712684B54473

            }
            catch (Exception)
            {
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!
                // ofrecer un logoff!!!!!!!!!!


                if (false)
                {
                    throw new Exception("Falla la conexion a la bdlmaster para verficar el membership .net");
                }
                else
                {
                    // es porque está mal logeado o porque no se conecta a la bdlmaster?

                    FormsAuthentication.SignOut();
                    Session.Abandon();
                    FormsAuthentication.RedirectToLoginPage();
                    return;
                }
            }




            try
            {
                sc = Generales.sCadenaConex(nombreEmpresa, oStaticMembershipService);
            }
            catch (Exception)
            {
                //return;
                throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + nombreEmpresa + "]");
            }

            if (sc == null)
            {

                // estás perdiendo la sesion por lo del web.config?????
                // http://stackoverflow.com/questions/10629882/asp-net-mvc-session-is-null

                ////////////////////////////////////////////////////////////////////////////////////////////////
                // MAL MAL!!!!!!!!!
                // http://stackoverflow.com/questions/7705802/httpcontext-current-session-is-null-in-mvc-3-appplication
                // Why are you using HttpContext.Current in an ASP.NET MVC application? Never use it. That's evil even 
                // in classic ASP.NET webforms applications but in ASP.NET MVC it's a disaster that takes all the fun out of this nice web framework
                ////////////////////////////////////////////////////////////////////////////////////////////////

                // FormsAuthentication.SignOut();

                try
                {
                    if (oStaticMembershipService.GetUser() == null)
                    {
                        FormsAuthentication.SignOut();
                        Session.Abandon();

                        //// clear authentication cookie
                        //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                        //cookie1.Expires = DateTime.Now.AddYears(-1);
                        //Response.Cookies.Add(cookie1);

                        //// clear session cookie 
                        //HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                        //cookie2.Expires = DateTime.Now.AddYears(-1);
                        //Response.Cookies.Add(cookie2);

                        FormsAuthentication.RedirectToLoginPage();
                        return;
                    }
                }
                catch (System.Data.SqlClient.SqlException x)
                {
                    throw;
                }
                catch (Exception)
                {

                    throw;
                }

                //if (false)
                //{
                // return RedirectToAction("ElegirBase", "Account");

                if (this.Session["BasePronto"] == null)
                {
                    // de alguna manera lo tengo que redirigir a la eleccion de la base, pero desde acá no puedo hacer 
                    // un redirect. 

                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // http://stackoverflow.com/questions/8225930/redirect-from-controller-initialize-not-working
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // EN este ejemplo lo usan tambien para controlar la empresa conectada!!!!!
                    // http://stackoverflow.com/questions/4793452/mvc-redirect-inside-the-constructor
                    //return;
                    //throw new Exception("No hay base elegida");
                }


                var n = new AccountController();

                if ((n.BuscarUltimaBaseAccedida(oStaticMembershipService) ?? "") != "")
                {
                    this.Session["BasePronto"] = n.BuscarUltimaBaseAccedida(oStaticMembershipService);
                    // return Redirect(returnUrl);

                    string sss2 = this.Session["BasePronto"].ToString();
                    sc = Generales.sCadenaConex(sss2, oStaticMembershipService);
                    if (sc == null)
                    {
                        // throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
                        this.Session["BasePronto"] = Generales.BaseDefault((Guid)oStaticMembershipService.GetUser().ProviderUserKey);
                    }
                }
                else
                {

                    this.Session["BasePronto"] = Generales.BaseDefault((Guid)oStaticMembershipService.GetUser().ProviderUserKey);
                }

                string sss = this.Session["BasePronto"].ToString();
                sc = Generales.sCadenaConex(sss, oStaticMembershipService);
                //    return RedirectToAction("Index", "Home");
                if (sc == null) throw new Exception("Falta la cadena de conexion a la base Pronto (nombre de base: [" + sss + "]");
            }


            db = new DemoProntoEntities(sc);



            if (false) // desactivé la creacion de dbmant porque desde el studio me está poniendo lenta la cosa creo
            {


                try
                {
                    dbmant = new ProntoMVC.Data.Models.Mantenimiento.ProntoMantenimientoEntities(Generales.sCadenaConexMant(db, this.Session["BasePronto"].ToString()));
                    //dbmant = new  ProntoMantenimientoEntities(Generales.sCadenaConexMant(this.Session["BasePronto"].ToString()));

                }
                catch (Exception e)
                {

                    ErrHandler.WriteError(e);
                }
            }



            SC = sc;


            if (db == null)
            {
                if (System.Diagnostics.Debugger.IsAttached)
                {
                    System.Diagnostics.Debugger.Break();
                }
                else
                {
                    throw new Exception("error en creacion del context. " + sc);

                }
            }

        }


        */




        public string Grabar_Proveedor(Proveedor Proveedor, int IdUsuario)
        {



            if (Proveedor.IdProveedor > 0)
            {
                Proveedor.IdUsuarioModifico = IdUsuario;
                Proveedor.FechaModifico = DateTime.Now;
            }
            else
            {
                Proveedor.IdUsuarioIngreso = IdUsuario;
                Proveedor.FechaIngreso = DateTime.Now;
            }

            if (Proveedor.IdProveedor > 0)
            {
                var EntidadOriginal = db.Proveedores.Where(p => p.IdProveedor == Proveedor.IdProveedor).Include(p => p.DetalleProveedoresContactos).Include(p => p.DetalleProveedoresRubros).SingleOrDefault();
                var EntidadEntry = db.Entry(EntidadOriginal);
                EntidadEntry.CurrentValues.SetValues(Proveedor);

                foreach (var d in Proveedor.DetalleProveedoresContactos)
                {
                    var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresContactos.Where(c => c.IdDetalleProveedor == d.IdDetalleProveedor && d.IdDetalleProveedor > 0).SingleOrDefault();
                    if (DetalleEntidadOriginal != null)
                    {
                        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                        DetalleEntidadEntry.CurrentValues.SetValues(d);
                    }
                    else
                    {
                        EntidadOriginal.DetalleProveedoresContactos.Add(d);
                    }
                }
                foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresContactos.Where(c => c.IdDetalleProveedor != 0).ToList())
                {
                    if (!Proveedor.DetalleProveedoresContactos.Any(c => c.IdDetalleProveedor == DetalleEntidadOriginal.IdDetalleProveedor))
                    {
                        EntidadOriginal.DetalleProveedoresContactos.Remove(DetalleEntidadOriginal);
                        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                    }
                }

                foreach (var d in Proveedor.DetalleProveedoresRubros)
                {
                    var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresRubros.Where(c => c.IdDetalleProveedorRubros == d.IdDetalleProveedorRubros && d.IdDetalleProveedorRubros > 0).SingleOrDefault();
                    if (DetalleEntidadOriginal != null)
                    {
                        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                        DetalleEntidadEntry.CurrentValues.SetValues(d);
                    }
                    else
                    {
                        EntidadOriginal.DetalleProveedoresRubros.Add(d);
                    }
                }
                foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresRubros.Where(c => c.IdDetalleProveedorRubros != 0).ToList())
                {
                    if (!Proveedor.DetalleProveedoresRubros.Any(c => c.IdDetalleProveedorRubros == DetalleEntidadOriginal.IdDetalleProveedorRubros))
                    {
                        EntidadOriginal.DetalleProveedoresRubros.Remove(DetalleEntidadOriginal);
                        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                    }
                }

                foreach (var d in Proveedor.DetalleProveedoresIBs)
                {
                    var DetalleEntidadOriginal = EntidadOriginal.DetalleProveedoresIBs.Where(c => c.IdDetalleProveedorIB == d.IdDetalleProveedorIB && d.IdDetalleProveedorIB > 0).SingleOrDefault();
                    if (DetalleEntidadOriginal != null)
                    {
                        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                        DetalleEntidadEntry.CurrentValues.SetValues(d);
                    }
                    else
                    {
                        EntidadOriginal.DetalleProveedoresIBs.Add(d);
                    }
                }
                foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleProveedoresIBs.Where(c => c.IdDetalleProveedorIB != 0).ToList())
                {
                    if (!Proveedor.DetalleProveedoresIBs.Any(c => c.IdDetalleProveedorIB == DetalleEntidadOriginal.IdDetalleProveedorIB))
                    {
                        EntidadOriginal.DetalleProveedoresIBs.Remove(DetalleEntidadOriginal);
                        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                    }
                }

                db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
            }
            else
            {
                db.Proveedores.Add(Proveedor);
            }
            db.SaveChanges();



            return "";



        }




        public string Grabar_ComprobanteProveedor(ComprobanteProveedor ComprobanteProveedor, int IdUsuario)
        {





            decimal mCotizacionMoneda = 0;
            decimal mCotizacionDolar = 0;
            decimal mCotizacionEuro = 0;
            decimal mCotizacionMonedaAnterior = 0;
            decimal mTotalComprobante = 0;
            decimal mTotalIvaNoDiscriminado = 0;
            decimal mIvaNoDiscriminadoItem = 0;
            decimal mTotalAnterior = 0;
            decimal mTotalAnteriorDolar = 0;
            decimal mTotalAnteriorEuro = 0;
            decimal mTotal = 0;
            decimal mTotalDolar = 0;
            decimal mTotalEuro = 0;
            decimal mCoef = 1;
            decimal mImporte = 0;
            decimal mImporteIva = 0;
            decimal mAjusteIVA = 0;

            Int32 mIdComprobanteProveedor = 0;
            Int32 mIdTipoComprobante = 0;
            Int32 mIdTipoComprobanteAnterior = 0;
            Int32 mIdProveedor = 0;
            Int32 mNumero = 0;
            Int32 mIdCtaCte = 0;
            Int32 mIdCuentaProveedor = 0;
            Int32 mIdCuentaComprasTitulo = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mIdCuentaBonificaciones = 0;
            Int32 mIdCuenta = 0;
            Int32 mIdCuentaReintegros = 0;
            Int32 mIdImputacion = 0;


            string mWebService = "";
            string mSubdiarios_ResumirRegistros = "";

            bool mGrabarRegistrosEnCuentaCorriente = true;

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdCuentaProveedor = parametros.IdCuentaAcreedoresVarios ?? 0;
            mIdCuentaComprasTitulo = parametros.IdCuentaComprasTitulo ?? 0;
            mIdMonedaPesos = parametros.IdMoneda ?? 0;
            mIdCuentaBonificaciones = parametros.IdCuentaBonificaciones ?? 0;
            mSubdiarios_ResumirRegistros = parametros.Subdiarios_ResumirRegistros ?? "";
            mIdCuentaReintegros = parametros.IdCuentaReintegros ?? 0;



            using (TransactionScope scope = new TransactionScope())
            {
                mIdComprobanteProveedor = ComprobanteProveedor.IdComprobanteProveedor;
                mIdTipoComprobante = ComprobanteProveedor.IdTipoComprobante ?? 0;
                mIdTipoComprobanteAnterior = mIdTipoComprobante;
                mIdProveedor = ComprobanteProveedor.IdProveedor ?? 0;
                mCotizacionMoneda = ComprobanteProveedor.CotizacionMoneda ?? 1;
                mCotizacionDolar = ComprobanteProveedor.CotizacionDolar ?? 0;
                mCotizacionEuro = ComprobanteProveedor.CotizacionEuro ?? 0;
                mTotalComprobante = (ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda;
                mTotalIvaNoDiscriminado = (ComprobanteProveedor.TotalIvaNoDiscriminado ?? 0) * mCotizacionMoneda;
                mAjusteIVA = (ComprobanteProveedor.AjusteIVA ?? 0) * mCotizacionMoneda;

                mTotal = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda, 2);
                if (mCotizacionDolar != 0) { mTotalDolar = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda / mCotizacionDolar, 2); }
                if (mCotizacionEuro != 0) { mTotalEuro = decimal.Round((ComprobanteProveedor.TotalComprobante ?? 0) * mCotizacionMoneda / mCotizacionEuro, 2); }

                var TiposComprobantes = db.TiposComprobantes.Where(c => c.IdTipoComprobante == mIdTipoComprobante).SingleOrDefault();
                if (TiposComprobantes != null)
                {
                    mCoef = TiposComprobantes.Coeficiente ?? mCoef;
                }

                if (mIdComprobanteProveedor <= 0)
                {
                    ComprobanteProveedor.IdUsuarioIngreso = IdUsuario;
                    ComprobanteProveedor.FechaIngreso = DateTime.Now;
                    ComprobanteProveedor.TotalIva1 = ComprobanteProveedor.TotalIva1 ?? 0;
                }
                else
                {
                    ComprobanteProveedor.IdUsuarioIngreso = IdUsuario;
                    ComprobanteProveedor.FechaIngreso = DateTime.Now;

                    ComprobanteProveedor ComprobanteProveedorAnterior = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == mIdComprobanteProveedor).SingleOrDefault();
                    if (ComprobanteProveedorAnterior != null)
                    {
                        mIdTipoComprobanteAnterior = ComprobanteProveedorAnterior.IdTipoComprobante ?? mIdTipoComprobante;
                    }
                }



                if (mIdProveedor > 0)
                {
                    var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
                    if (Proveedores != null)
                    {
                        if ((Proveedores.RegistrarMovimientosEnCuentaCorriente ?? "SI") == "NO") { mGrabarRegistrosEnCuentaCorriente = false; }
                    }
                }
                else
                {
                    mGrabarRegistrosEnCuentaCorriente = false;
                }



                if (mIdComprobanteProveedor > 0)
                {
                    var EntidadOriginal = db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == mIdComprobanteProveedor).SingleOrDefault();

                    var EntidadoEntry = db.Entry(EntidadOriginal);
                    EntidadoEntry.CurrentValues.SetValues(ComprobanteProveedor);

                    //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                    foreach (var d in ComprobanteProveedor.DetalleComprobantesProveedores)
                    {
                        var DetalleEntidadOriginal = EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor == d.IdDetalleComprobanteProveedor && d.IdDetalleComprobanteProveedor > 0).SingleOrDefault();
                        if (DetalleEntidadOriginal != null)
                        {
                            var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                            DetalleEntidadEntry.CurrentValues.SetValues(d);
                        }
                        else
                        {
                            EntidadOriginal.DetalleComprobantesProveedores.Add(d);
                        }
                    }
                    foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleComprobantesProveedores.Where(c => c.IdDetalleComprobanteProveedor != 0).ToList())
                    {
                        if (!ComprobanteProveedor.DetalleComprobantesProveedores.Any(c => c.IdDetalleComprobanteProveedor == DetalleEntidadOriginal.IdDetalleComprobanteProveedor))
                        {
                            EntidadOriginal.DetalleComprobantesProveedores.Remove(DetalleEntidadOriginal);
                            db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                        }
                    }

                    ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                    db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == ComprobanteProveedor.IdPuntoVenta).SingleOrDefault();
                    if (PuntoVenta != null)
                    {
                        mNumero = PuntoVenta.ProximoNumero ?? 1;
                        ComprobanteProveedor.NumeroReferencia = mNumero;

                        PuntoVenta.ProximoNumero = mNumero + 1;
                        db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                    }

                    db.ComprobantesProveedor.Add(ComprobanteProveedor);
                    db.SaveChanges();
                }

                ////////////////////////////////////////////// IMPUTACION //////////////////////////////////////////////
                // si es modificacion y tenia imputado algo
                //If mvarIdentificador > 0 Then
                //   Set DatosAnt = oDet.LeerUno("ComprobantesProveedores", mvarIdentificador)
                //   If DatosAnt.RecordCount > 0 Then
                //      mvarCotizacionAnt = IIf(IsNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
                //      mTotalAnterior = DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt
                //      If Not IsNull(DatosAnt.Fields("IdProveedor").Value) Then
                //         mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
                //      End If
                //      If Not IsNull(DatosAnt.Fields("IdTipoComprobante").Value) Then
                //         mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value
                //      End If
                //      Set Datos = oDet.LeerUno("TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value)
                //      If Datos.RecordCount > 0 Then
                //         mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value
                //      End If
                //      mvarIdOrdenPagoAnterior = IIf(IsNull(DatosAnt.Fields("IdOrdenPago").Value), 0, DatosAnt.Fields("IdOrdenPago").Value)
                //      Datos.Close
                //      Set Datos = Nothing

                //      If Not IsNull(DatosAnt.Fields("IdComprobanteImputado").Value) Then
                //         mvarAuxL1 = 11
                //         Set oRsAux = oDet.LeerUno("ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value)
                //         If oRsAux.RecordCount > 0 Then
                //            mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
                //         End If
                //         oRsAux.Close

                //         Set DatosCtaCteNv = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value))
                //         If DatosCtaCteNv.RecordCount > 0 Then
                //            Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                //            TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                //            TotEu = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                //                     IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

                //            Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesA", "_BuscarComprobante", Array(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1))
                //            If DatosCtaCte.RecordCount > 0 Then
                //                  DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                //                  DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                //                  DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                //                  Resp = oDet.Guardar("CtasCtesA", DatosCtaCte)
                //            End If
                //            DatosCtaCte.Close
                //            Set DatosCtaCte = Nothing

                //            oDet.Eliminar "CtasCtesA", DatosCtaCteNv.Fields(0).Value
                //         End If
                //         DatosCtaCteNv.Close
                //         Set DatosCtaCteNv = Nothing
                //      End If
                //   End If
                //   DatosAnt.Close
                //   Set DatosAnt = Nothing
                //End If


                if (mIdProveedor > 0 && mGrabarRegistrosEnCuentaCorriente)
                {
                    if (mIdComprobanteProveedor > 0)
                    {
                        CuentasCorrientesAcreedor CtaCteAnterior = db.CuentasCorrientesAcreedores.Where(c => c.IdComprobante == mIdComprobanteProveedor && c.IdTipoComp == mIdTipoComprobanteAnterior).FirstOrDefault();
                        if (CtaCteAnterior != null)
                        {
                            mTotalAnterior = (CtaCteAnterior.ImporteTotal ?? 0) - (CtaCteAnterior.Saldo ?? 0);
                            mTotalAnteriorDolar = (CtaCteAnterior.ImporteTotalDolar ?? 0) - (CtaCteAnterior.SaldoDolar ?? 0);
                            mTotalAnteriorEuro = (CtaCteAnterior.ImporteTotalEuro ?? 0) - (CtaCteAnterior.SaldoEuro ?? 0);
                        }
                    }

                    CuentasCorrientesAcreedor CtaCte = db.CuentasCorrientesAcreedores.Where(c => c.IdComprobante == mIdComprobanteProveedor && c.IdTipoComp == mIdTipoComprobante).FirstOrDefault();
                    if (CtaCte == null)
                    {
                        CtaCte = new CuentasCorrientesAcreedor();
                        mIdCtaCte = 0;
                        mIdImputacion = 0;
                    }
                    else
                    {
                        mIdCtaCte = CtaCte.IdCtaCte;
                        mIdImputacion = CtaCte.IdImputacion ?? 0;
                    }

                    CtaCte.IdTipoComp = mIdTipoComprobante;
                    CtaCte.IdComprobante = mIdComprobanteProveedor;
                    CtaCte.IdProveedor = ComprobanteProveedor.IdProveedor;
                    CtaCte.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                    CtaCte.Fecha = ComprobanteProveedor.FechaRecepcion;
                    CtaCte.FechaVencimiento = ComprobanteProveedor.FechaVencimiento;
                    CtaCte.CotizacionDolar = ComprobanteProveedor.CotizacionDolar;
                    CtaCte.CotizacionEuro = ComprobanteProveedor.CotizacionEuro;
                    CtaCte.CotizacionMoneda = ComprobanteProveedor.CotizacionMoneda;
                    //CtaCte.IdComprobante = ComprobanteProveedor.IdOrdenPago;
                    CtaCte.ImporteTotal = mTotal;
                    CtaCte.Saldo = mTotal - mTotalAnterior;
                    CtaCte.ImporteTotalDolar = mTotalDolar;
                    CtaCte.SaldoDolar = mTotalDolar - mTotalAnteriorDolar;
                    CtaCte.ImporteTotalEuro = mTotalEuro;
                    CtaCte.SaldoEuro = mTotalEuro - mTotalAnteriorEuro;
                    CtaCte.IdMoneda = ComprobanteProveedor.IdMoneda;

                    if (mIdCtaCte <= 0) { db.CuentasCorrientesAcreedores.Add(CtaCte); }
                    else { db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified; }

                    db.SaveChanges();
                    mIdCtaCte = CtaCte.IdCtaCte;

                    if (mIdImputacion == 0)
                    {
                        CtaCte = db.CuentasCorrientesAcreedores.Where(c => c.IdCtaCte == mIdCtaCte).SingleOrDefault();
                        if (CtaCte != null)
                        {
                            CtaCte.IdImputacion = mIdCtaCte;
                            db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                    }
                }

                ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                if (mIdComprobanteProveedor > 0)
                {
                    var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdComprobanteProveedor).ToList();
                    if (Subdiarios != null) { foreach (Subdiario s1 in Subdiarios) { db.Entry(s1).State = System.Data.Entity.EntityState.Deleted; } }
                    db.SaveChanges();
                }

                Subdiario s;

                Proveedor Proveedor = db.Proveedores.Where(c => c.IdProveedor == mIdProveedor).SingleOrDefault();
                if (Proveedor != null) { mIdCuentaProveedor = Proveedor.IdCuenta ?? mIdCuentaProveedor; }
                else { mIdCuentaProveedor = ComprobanteProveedor.IdCuenta ?? (ComprobanteProveedor.IdCuentaOtros ?? 0); }

                if (mIdCuentaProveedor > 0)
                {
                    s = new Subdiario();
                    s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                    s.IdCuenta = mIdCuentaProveedor;
                    s.IdTipoComprobante = mIdTipoComprobante;
                    s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                    s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                    s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                    if (mCoef == 1) { s.Haber = mTotalComprobante; }
                    else { s.Debe = mTotalComprobante; }
                    s.IdMoneda = mIdMonedaPesos;
                    s.CotizacionMoneda = 1;

                    db.Subdiarios.Add(s);
                }

                mImporte = (ComprobanteProveedor.TotalBonificacion ?? 0) * mCotizacionMoneda;
                if (mImporte != 0 && mIdCuentaBonificaciones > 0)
                {
                    s = new Subdiario();
                    s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                    s.IdCuenta = mIdCuentaBonificaciones;
                    s.IdTipoComprobante = mIdTipoComprobante;
                    s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                    s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                    s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                    if (mCoef == 1) { s.Haber = mImporte; }
                    else { s.Debe = mImporte; }
                    s.IdMoneda = mIdMonedaPesos;
                    s.CotizacionMoneda = 1;

                    db.Subdiarios.Add(s);
                }

                foreach (var d in ComprobanteProveedor.DetalleComprobantesProveedores)
                {
                    mImporte = (d.Importe ?? 0) * mCotizacionMoneda;
                    mImporteIva = (d.ImporteIVA1 ?? 0) * mCotizacionMoneda;

                    if ((ComprobanteProveedor.Letra ?? "") == "A" || (ComprobanteProveedor.Letra ?? "") == "M") { }
                    else { mIvaNoDiscriminadoItem = mIvaNoDiscriminadoItem + mImporteIva; }

                    if (mAjusteIVA != 0)
                    {
                        mImporteIva = mImporteIva + mAjusteIVA;
                        mAjusteIVA = 0;
                    }

                    mIdCuenta = d.IdCuentaIvaCompras1 ?? 0;
                    if (mIdCuenta > 0 && mImporteIva != 0)
                    {
                        s = new Subdiario();
                        s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                        s.IdCuenta = mIdCuenta;
                        s.IdTipoComprobante = mIdTipoComprobante;
                        s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                        s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                        s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                        if (mCoef == 1)
                        {
                            if (mImporteIva >= 0) { s.Debe = mImporteIva; } else { s.Haber = mImporteIva * -1; };
                        }
                        else
                        {
                            if (mImporteIva >= 0) { s.Haber = mImporteIva; } else { s.Debe = mImporteIva * -1; };
                        }
                        s.IdMoneda = mIdMonedaPesos;
                        s.CotizacionMoneda = 1;
                        if (mSubdiarios_ResumirRegistros != "SI") { s.IdDetalleComprobante = d.IdDetalleComprobanteProveedor; }

                        db.Subdiarios.Add(s);
                    }

                    mIdCuenta = d.IdCuenta ?? 0;
                    mImporte = mImporte - mIvaNoDiscriminadoItem;
                    if (mIdCuenta > 0 && mImporte != 0)
                    {
                        s = new Subdiario();
                        s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                        s.IdCuenta = mIdCuenta;
                        s.IdTipoComprobante = mIdTipoComprobante;
                        s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                        s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                        s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                        if (mCoef == 1)
                        {
                            if (mImporte >= 0) { s.Debe = mImporte; } else { s.Haber = mImporte * -1; };
                        }
                        else
                        {
                            if (mImporte >= 0) { s.Haber = mImporte; } else { s.Debe = mImporte * -1; };
                        }
                        s.IdMoneda = mIdMonedaPesos;
                        s.CotizacionMoneda = 1;
                        if (mSubdiarios_ResumirRegistros != "SI") { s.IdDetalleComprobante = d.IdDetalleComprobanteProveedor; }

                        db.Subdiarios.Add(s);
                    }
                }

                mIdCuenta = ComprobanteProveedor.ReintegroIdCuenta ?? 0;
                mImporte = (ComprobanteProveedor.ReintegroImporte ?? 0) * mCotizacionMoneda;
                if (mIdCuentaReintegros > 0 && mIdCuenta > 0 && mImporte != 0)
                {
                    s = new Subdiario();
                    s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                    s.IdCuenta = mIdCuentaReintegros;
                    s.IdTipoComprobante = mIdTipoComprobante;
                    s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                    s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                    s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                    if (mCoef == 1) { s.Haber = mImporte; }
                    else { s.Debe = mImporte; }
                    s.IdMoneda = mIdMonedaPesos;
                    s.CotizacionMoneda = 1;

                    db.Subdiarios.Add(s);

                    s = new Subdiario();
                    s.IdCuentaSubdiario = mIdCuentaComprasTitulo;
                    s.IdCuenta = mIdCuenta;
                    s.IdTipoComprobante = mIdTipoComprobante;
                    s.NumeroComprobante = ComprobanteProveedor.NumeroReferencia;
                    s.FechaComprobante = ComprobanteProveedor.FechaRecepcion;
                    s.IdComprobante = ComprobanteProveedor.IdComprobanteProveedor;
                    if (mCoef == 1) { s.Debe = mImporte; }
                    else { s.Haber = mImporte; }
                    s.IdMoneda = mIdMonedaPesos;
                    s.CotizacionMoneda = 1;

                    db.Subdiarios.Add(s);
                }

                db.SaveChanges();

                //////////////////////////////////////////////////////////
                db.Tree_TX_Actualizar("ComprobantesPrvPorMes", ComprobanteProveedor.IdComprobanteProveedor, "ComprobanteProveedor");

                //////////////////////////////////////////////////////////
                scope.Complete();
                scope.Dispose();
                //////////////////////////////////////////////////////////
            }


            return "";

        }






        public string ImprimirConPlantillaEXE(int id, string SC, string DirApp, string plantilla, string sArchivoSalida, out string mensajeError) //, string Tipo = "")
        {
            //devuelve pdf si se le pasa un sArchivoSalida con extension pdf


            string SCsinEncriptar = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC);

            System.IO.FileInfo MyFile2 = new System.IO.FileInfo(plantilla);//busca si ya existe el archivo a generar y en ese caso lo borra

            //if (!MyFile2.Exists)
            //{
            //    plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            //}

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(sArchivoSalida);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            //'How to Wait for a Shelled Process to Finish
            //'Get the name of the system folder.
            var sysFolder = Environment.GetFolderPath(Environment.SpecialFolder.System);
            //'Create a new ProcessStartInfo structure.
            var pInfo = new ProcessStartInfo();
            //'Set the file name member of pinfo to Eula.txt in the system folder.
            pInfo.FileName = DirApp + @"bin\Plantillas.exe";

            /*
            // -SC=Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=.SistemaPronto.;Initial catalog=Pronto;Data Source=serversql3\TESTING;Connect Timeout=45
            // en lugar de este formato, yo mandaba:
            // -SC=Data Source=sqlmvc;Initial catalog=Pronto_Vialagro;User ID=sa; Password=.SistemaPronto.;Connect Timeout=500
                LO QUE NO LE GUSTA ES QUE LE FALTE EL "PROVIDER="
             */
            //SCsinEncriptar = @"Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password=.SistemaPronto.;Initial catalog=Pronto;Data Source=serversql3\TESTING;Connect Timeout=45";

            if (!SCsinEncriptar.ToLower().Contains("provider="))
            {
                SCsinEncriptar += ";Provider=SQLOLEDB.1";
            }





            //if (Tipo == "PDF")
            //{
            //    output = DirApp + "Documentos\\" + "archivo.pdf";
            //    nombrearchivo = "requerimiento.pdf";
            //}




            pInfo.Arguments = @"-Plantilla=" + plantilla + " -SC=" + SCsinEncriptar + @" -Id=" + id + " -FileOut=" + sArchivoSalida;


            ErrHandler2.WriteError(pInfo.FileName + " " + pInfo.Arguments);



            //'Start the process.
            pInfo.UseShellExecute = false;
            Process p = Process.Start(pInfo);
            //'Wait for the process window to complete loading.
            p.WaitForInputIdle();
            //'Wait for the process to exit.
            p.WaitForExit();


            //'Continue with the code.
            //MessageBox.Show("Code continuing...");

            int CodigoSalida = p.ExitCode;


            switch (CodigoSalida)
            {

                // If mPlantilla = "" Then CodigoSalida = -103
                // If mStringConexion = "" Then CodigoSalida = -104
                // If mvarId = 0 Then CodigoSalida = -105
                // If mArchivo = "" Then CodigoSalida = -106
                //If CodigoSalida<> 0 Then GoTo Salida

                case 0:
                    mensajeError = "";
                    break;

                case -103:
                    mensajeError = "Falta la plantilla";
                    break;

                case -104:
                    mensajeError = "Falta la cadena de conexión";
                    break;

                case -105:
                    mensajeError = "Falta el Id del comprobante";
                    break;

                case -106:
                    mensajeError = "Falta el nombre del archivo de salida";
                    break;

                default:
                    mensajeError = "Error inesperado";
                    break;

            }





            return sArchivoSalida;
        }










        public static void ImportacionComprobantesFondoFijo2(DataTable dt, string SC, string mArchivo, DateTime mFechaRecepcion, int mNumeroReferencia, int mIdPuntoVenta)
        {

            /*
            
            // /////////////////////////////////////////////////////////////////
            // /////////////////////////////////////////////////////////////////
            //         'parametros de entrada
            //         'mArchivo = .FileBrowser1(0).text
            //         'mFechaRecepcion = .DTFields(0).Value
            //         'mNumeroReferencia = Val(.Text1.text)
            //         'If IsNumeric(.dcfields(0).BoundText) Then mIdPuntoVenta = .dcfields(0).BoundText
            // globales que tomaba esta funcion. mover a globales del servicio
            DateTime gblFechaUltimoCierre;
            int glbIdMonedaDolar;
            int glbIdUsuario;
            bool glbPuntoVentaEnNumeroInternoCP;
            // /////////////////////////////////////////////////////////////////
            // /////////////////////////////////////////////////////////////////
            object oAp;
            //  As ComPronto.Aplicacion
            object oCP = new ProntoMVC.Data.Models.ComprobanteProveedor();
            object oPr;
            //  As ComPronto.Proveedor
            object oPar;
            //  As ComPronto.Parametro
            object oOP;
            // As ComPronto.OrdenPago
            object oRsAux1;
            // As ADOR.Recordset
            object oRsAux2;
            // As ADOR.Recordset
            object oForm;
            // As Form
            Excel.Application oEx;
            bool mOk;
            bool mConProblemas;
            bool mTomarCuentaDePresupuesto;
            string mComprobante;
            string mCuit;
            string mLetra;
            string mBienesOServicios;
            string mObservaciones;
            string mRazonSocial;
            string mIncrementarReferencia;
            string mCondicionCompra;
            string mCodProv;
            string mNumeroCAI;
            string mFecha1;
            string mError;
            string mCodObra;
            string mInformacionAuxiliar;
            string mCuitDefault;
            string mCodigoCuentaGasto;
            string mTipo;
            string mItemPresupuestoObrasNodo;
            string mMensaje;
            string mActividad;
            string mCuitPlanilla;
            string mPuntosVentaAsociados;
            string mNumeroCAE;
            DateTime mFechaFactura;
            DateTime mFechaVencimientoCAI;
            int mIdMonedaPesos;
            int mIdTipoComprobanteFacturaCompra;
            int mIdUnidadPorUnidad;
            int fl;
            int mContador;
            int mIdCuentaIvaCompras1;
            int i;
            int mIdUO;
            int mvarProvincia;
            int mIdTipoComprobante;
            int mIdCodigoIva;
            int mvarIBCondicion;
            int mvarIdIBCondicion;
            int mvarIGCondicion;
            int mvarIdTipoRetencionGanancia;
            int mvarPosicionCuentaIva;
            long mIdProveedor;
            long mNumeroComprobante1;
            long mNumeroComprobante2;
            long mCodigoCuenta;
            long mCodigoCuentaFF;
            long mNumeroOP;
            long mIdOrdenPago;
            long mAux1;
            long mAux2;
            long mNumeroRendicion;
            long mIdCuenta;
            long mIdCuenta1;
            long mIdObra;
            long mCodigoCuenta1;
            long mIdCuentaFF;
            long mIdCuentaGasto;
            long mIdPresupuestoObrasNodo;
            long mIdRubroContable;
            long mIdActividad;
            float mvarCotizacionDolar;
            float mPorcentajeIVA;
            double mTotalItem;
            double mIVA1;
            double mGravado;
            double mNoGravado;
            double mTotalBruto;
            double mTotalIva1;
            double mTotalComprobante;
            double mTotalPercepcion;
            double mTotalAjusteIVA;
            double mAjusteIVA;
            double mBruto;
            double mPercepcion;
            double mCantidad;
            long[,] mIdCuentaIvaCompras;
            float[,] mIVAComprasPorcentaje;
            object mAux;



            // On Error GoTo Mal
            mPuntosVentaAsociados = "";
            if (glbPuntoVentaEnNumeroInternoCP)
            {
                oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Empleados_TX_PorId, glbIdUsuario);
                if ((oRsAux1.RecordCount > 0))
                {
                    mPuntosVentaAsociados = (IsNull(oRsAux1.PuntosVentaAsociados) ? "" : oRsAux1.PuntosVentaAsociados);
                }

                oRsAux1.Close;
                if ((mPuntosVentaAsociados.Length == 0))
                {
                    throw new Exception("No tiene asignados puntos de venta para incorporar a los comprobantes importados");
                }

            }

            // oForm = New frmPathPresto
            // With oForm
            //     .Id = 14
            //     .Show vbModal
            //       mOk = .Ok
            //     If mOk Then
            //         mArchivo = .FileBrowser1(0).text
            //         mFechaRecepcion = .DTFields(0).Value
            //         mNumeroReferencia = Val(.Text1.text)
            //         If IsNumeric(.dcfields(0).BoundText) Then mIdPuntoVenta = .dcfields(0).BoundText
            //     End If
            // End With
            // Unload oForm
            //    oForm = Nothing
            // If Not mOk Then Exit Sub
            // If glbPuntoVentaEnNumeroInternoCP And mIdPuntoVenta = 0 Then
            //     MsgBox "Debe elegir un punto de venta", vbExclamation
            //     Return
            // End If
            // oAp = Aplicacion
            mIncrementarReferencia = EntidadManager.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes", SC, -1);
            mCondicionCompra = EntidadManager.BuscarClaveINI("Condicion de compra default para fondos fijos", SC, -1);
            mFecha1 = EntidadManager.BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo", SC, -1);
            mCuitDefault = EntidadManager.BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos", SC, -1);
            ParametrosOriginalesRenglon p;
            // oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
            mIdMonedaPesos = p.p(ParametroManager.ePmOrg.IdMoneda);
            mIdTipoComprobanteFacturaCompra = oRsAux1.IdTipoComprobanteFacturaCompra;
            mIdUnidadPorUnidad = (IsNull(oRsAux1.IdUnidadPorUnidad) ? 0 : oRsAux1.IdUnidadPorUnidad);
            gblFechaUltimoCierre = (IsNull(oRsAux1.FechaUltimoCierre) ? DateSerial(1980, 1, 1) : oRsAux1.FechaUltimoCierre);
            // For i = 1 To 10
            //     If Not IsNull(oRsAux1.IdCuentaIvaCompras" & i).Value) Then
            //         mIdCuentaIvaCompras(i) = oRsAux1.IdCuentaIvaCompras" & i).Value Then '
            //         mIVAComprasPorcentaje(i) = oRsAux1.IVAComprasPorcentaje" & i).Value
            //     Else
            //         mIdCuentaIvaCompras(i) = 0
            //         mIVAComprasPorcentaje(i) = 0
            //     End If
            // Next
            // oRsAux1.Close
            mTomarCuentaDePresupuesto = false;
            if ((!IsNull(mAux)
                        && (mAux == "SI")))
            {
                mTomarCuentaDePresupuesto = true;
            }

            fl = 7;
            mContador = 0;
            mNumeroRendicion = 0;
            mIdCuentaFF = 0;
            string oForm_Label1;


            ServicioMVC.servi s = new ServicioMVC.servi(SC);

            while (true)
            {
                if (((dt.Rows[fl].Item[2].Trim().Length > 0)
                            || ((dt.Rows[fl].Item[3].Trim().Length > 0)
                            || ((dt.Rows[fl].Item[4].Trim().Length > 0)
                            || ((dt.Rows[fl].Item[5].Trim().Length > 0)
                            || ((dt.Rows[fl].Item[9].Trim().Length > 0)
                            || (dt.Rows[fl].Item[10].Trim().Length > 0)))))))
                {
                    mConProblemas = false;
                    if (((mNumeroRendicion == 0)
                                && IsNumeric(dt.Rows[2].Item[16])))
                    {
                        mNumeroRendicion = dt.Rows[2].Item[16];
                    }

                    mContador = (mContador + 1);
                    // oForm.Label2 = "Comprobante  " & dt.Rows(fl).Item(8)
                    // oForm.Label3 = "" & mContador
                    // DoEvents
                    mTipo = dt.Rows[fl].Item[4];
                    if ((dt.Rows[fl].Item[5].Length > 0))
                    {
                        oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mIdTipoComprobante " + dt.Rows[fl].Item[5]))));
                        mIdTipoComprobante = dt.Rows[fl].Item[5];
                    }
                    else
                    {
                        mIdTipoComprobante = mIdTipoComprobanteFacturaCompra;
                    }

                    mLetra = dt.Rows[fl].Item[6].Trim();
                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mNumeroComprobante1 " + dt.Rows[fl].Item[7]))));
                    mNumeroComprobante1 = dt.Rows[fl].Item[7];
                    if ((mNumeroComprobante1 > 9999))
                    {
                        mError = (mError + ("\r\n" + ("Fila "
                                    + (fl + "  - El punto de venta no puede tener mas de 4 digitos."))));
                        fl = (fl + 1);
                        // TODO: Continue Do... Warning!!! not translated
                        //  GoTo FinLoop
                    }

                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mNumeroComprobante2 " + dt.Rows[fl].Item[8]))));
                    mNumeroComprobante2 = dt.Rows[fl].Item[8];
                    if ((mNumeroComprobante2 > 99999999))
                    {
                        mError = (mError + ("\r\n" + ("Fila "
                                    + (fl + "  - El numero de comprobante no puede tener mas de 8 digitos."))));
                        fl = (fl + 1);
                        // TODO: Continue Do... Warning!!! not translated
                        //  GoTo FinLoop
                    }

                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mRazonSocial " + dt.Rows[fl].Item[9]))));
                    mRazonSocial = dt.Rows[fl].Item[9].Substring(0, 50);
                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mCuit " + dt.Rows[fl].Item[10]))));
                    mCuitPlanilla = dt.Rows[fl].Item[10];
                    mCuit = mCuitPlanilla;
                    if ((mCuit.Length != 13))
                    {
                        if ((mCuit.Length == 11))
                        {
                            //  mCuit = VBA.mId(mCuit, 1, 2) & "-" & VBA.mId(mCuit, 3, 8) & "-" & VBA.mId(mCuit, 11, 1)
                        }
                        else
                        {
                            mCuit = "";
                        }

                    }

                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mFechaFactura " + dt.Rows[fl].Item[3]))));
                    mFechaFactura = DateTime.Parse(dt.Rows[fl].Item[3]);
                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mNumeroCAI " + dt.Rows[fl].Item[18]))));
                    mNumeroCAI = dt.Rows[fl].Item[18];
                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mFechaVencimientoCAI " + dt.Rows[fl].Item[19]))));
                    if (IsDate(dt.Rows[fl].Item[19]))
                    {
                        mFechaVencimientoCAI = DateTime.Parse(dt.Rows[fl].Item[19]);
                    }
                    else
                    {
                        MinValue;
                    }

                    if ((mFecha1 == "SI"))
                    {
                        mFechaRecepcion = mFechaFactura;
                    }

                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mCodObra " + dt.Rows[fl].Item[2]))));
                    mCodObra = dt.Rows[fl].Item[2].Trim();
                    mActividad = dt.Rows[fl].Item[23].Trim();
                    oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mNumeroCAE " + dt.Rows[fl].Item[24]))));
                    mNumeroCAE = dt.Rows[fl].Item[24];
                    if ((mIdCuentaFF == 0))
                    {
                        if ((dt.Rows[2].Item[10].Length == 0))
                        {
                            throw new Exception("Debe definir la cuenta del fondo fijo");
                        }

                        oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mCodigoCuentaFF " + dt.Rows[2].Item[10]))));
                        mCodigoCuentaFF = double.Parse(dt.Rows[2].Item[10]);
                        oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Cuentas_TX_PorCodigo, mCodigoCuentaFF);
                        if ((oRsAux1.RecordCount > 0))
                        {
                            mIdCuentaFF = oRsAux1.Fields(0).Value;
                        }
                        else
                        {
                            mError = (mError + ("\r\n"
                                        + (mTipo + (" "
                                        + (mLetra + ("-"
                                        + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                        + (mNumeroComprobante2.ToString.PadLeft(8, "0") + ", cuenta de fondo fijo inexistente")))))))));
                            fl = (fl + 1);
                            // TODO: Continue Do... Warning!!! not translated
                            //  GoTo FinLoop
                        }

                        oRsAux1.Close;
                    }

                    mIdObra = 0;
                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "Obras_TX_PorNumero", mCodObra);
                    if ((oRsAux1.RecordCount > 0))
                    {
                        mIdObra = oRsAux1.IdObra;
                    }
                    else
                    {
                        mError = (mError + ("\r\n"
                                    + (mTipo + (" "
                                    + (mLetra + ("-"
                                    + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                    + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                    + (fl + ("  - Obra "
                                    + (mCodObra + " inexistente")))))))))))));
                        fl = (fl + 1);
                        // TODO: Continue Do... Warning!!! not translated
                        //  GoTo FinLoop
                    }

                    oRsAux1.Close;
                    if ((mFechaRecepcion > gblFechaUltimoCierre))
                    {
                        if ((mCuit.Length == 0))
                        {
                            mCuit = mCuitDefault;
                        }

                        if ((mCuit.Length == 0))
                        {
                            //                        comentado
                        }
                        else if (!FuncionesGenericasCSharp.CUITValido(mCuit))
                        {
                            mError = (mError + ("\r\n"
                                        + (mTipo + (" "
                                        + (mLetra + ("-"
                                        + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                        + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                        + (fl + ("  - Cuit invalido  " + mCuit))))))))))));
                            fl = (fl + 1);
                            // TODO: Continue Do... Warning!!! not translated
                            //  GoTo FinLoop
                        }

                        mIdActividad = 0;
                        if ((mActividad.Length > 0))
                        {
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, "ActividadesProveedores_TX_PorDescripcion", mActividad);
                            if ((oRsAux1.RecordCount > 0))
                            {
                                mIdActividad = oRsAux1.Fields(0).Value;
                            }

                            oRsAux1.Close;
                        }

                        mIdProveedor = 0;
                        if ((mCuit.Length > 0))
                        {
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Proveedores_TX_PorCuit, mCuit);
                        }
                        else
                        {
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, "Proveedores_TX_PorNombre", mRazonSocial);
                        }

                        if ((oRsAux1.RecordCount > 0))
                        {
                            mIdProveedor = oRsAux1.Fields(0).Value;
                            mvarProvincia = (IsNull(oRsAux1.IdProvincia) ? 0 : oRsAux1.IdProvincia);
                            mvarIBCondicion = (IsNull(oRsAux1.IBCondicion) ? 0 : oRsAux1.IBCondicion);
                            mvarIdIBCondicion = (IsNull(oRsAux1.IdIBCondicionPorDefecto) ? 0 : oRsAux1.IdIBCondicionPorDefecto);
                            mvarIGCondicion = (IsNull(oRsAux1.IGCondicion) ? 0 : oRsAux1.IGCondicion);
                            mvarIdTipoRetencionGanancia = (IsNull(oRsAux1.IdTipoRetencionGanancia) ? 0 : oRsAux1.IdTipoRetencionGanancia);
                            mBienesOServicios = (IsNull(oRsAux1.BienesOServicios) ? "B" : oRsAux1.BienesOServicios);
                            mIdCodigoIva = (IsNull(oRsAux1.IdCodigoIva) ? 0 : oRsAux1.IdCodigoIva);
                            if (((mIdActividad > 0)
                                        && (mIdActividad != (IsNull(oRsAux1.IdActividad) ? 0 : oRsAux1.IdActividad))))
                            {
                                oPr = oAp.Proveedores.Item[-1];
                                // With...
                                oPr.Guardar;
                                oPr = null;
                            }

                        }
                        else
                        {
                            if ((mCuit.Length > 0))
                            {
                                if ((mLetra == "C"))
                                {
                                    mIdCodigoIva = 6;
                                }
                                else
                                {
                                    mIdCodigoIva = 1;
                                }

                            }
                            else
                            {
                                mIdCodigoIva = 5;
                            }

                            oPr = oAp.Proveedores.Item[-1];
                            // With...
                            if ((mIdCodigoIva != 0))
                            {

                            }

                            mRazonSocial.Substring(0, 50).CUIT = 1;
                            "NO".RazonSocial = 1;
                            oPr.Registro.Confirmado = 1;
                            IdCodigoIva = mIdCodigoIva;
                            if (IsNumeric(mCondicionCompra))
                            {

                            }

                            IdCondicionCompra = int.Parse(mCondicionCompra);
                            if ((mIdActividad != 0))
                            {

                            }

                            IdActividad = mIdActividad;
                            oPr.Guardar;
                            mIdProveedor = oPr.Registro.Fields(0).Value;
                            oPr = null;
                            mvarProvincia = 0;
                            mvarIBCondicion = 0;
                            mvarIdIBCondicion = 0;
                            mvarIGCondicion = 0;
                            mvarIdTipoRetencionGanancia = 0;
                            mBienesOServicios = "B";
                        }

                        oRsAux1.Close;
                        oRsAux1 = EntidadManager.TraerFiltrado(SC, "ComprobantesProveedores_TX_PorNumeroComprobante", mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante);
                        if ((oRsAux1.RecordCount == 0))
                        {
                            mvarCotizacionDolar = Cotizacion(SC, mFechaFactura, glbIdMonedaDolar);
                            if ((mvarCotizacionDolar == 0))
                            {
                                mConProblemas = true;
                            }

                            oCP = oAp.ComprobantesProveedores.Item[-1];
                            // With...
                            if ((mFechaFactura > mFechaRecepcion))
                            {
                                FechaRecepcion = mFechaFactura;
                                mIdTipoComprobante.IdObra = mFechaFactura;
                                oCP.IdTipoComprobante = mFechaFactura;
                            }
                            else
                            {
                                FechaRecepcion = mFechaRecepcion;
                            }

                            mNumeroComprobante2.NumeroRendicionFF = mNumeroRendicion;
                            mNumeroComprobante1.NumeroComprobante2 = mNumeroRendicion;
                            mLetra.NumeroComprobante1 = mNumeroRendicion;
                            null.Letra = mNumeroRendicion;
                            mIdCuentaFF.IdOrdenPago = mNumeroRendicion;
                            null.IdCuenta = mNumeroRendicion;
                            mIdProveedor.IdProveedor = mNumeroRendicion;
                            mvarCotizacionDolar.IdProveedorEventual = mNumeroRendicion;
                            1.CotizacionDolar = mNumeroRendicion;
                            mIdMonedaPesos.CotizacionMoneda = mNumeroRendicion;
                            mFechaFactura.IdMoneda = mNumeroRendicion;
                            mFechaFactura.FechaAsignacionPresupuesto = mNumeroRendicion;
                            FechaVencimiento = mNumeroRendicion;
                            if ((((mvarIBCondicion == 2)
                                        || (mvarIBCondicion == 3))
                                        && (mvarIdIBCondicion != 0)))
                            {
                                IdIBCondicion = mvarIdIBCondicion;
                            }
                            else
                            {
                                IdIBCondicion = null;
                            }

                            if ((((mvarIGCondicion == 2)
                                        || (mvarIGCondicion == 3))
                                        && (mvarIdTipoRetencionGanancia != 0)))
                            {
                                IdTipoRetencionGanancia = mvarIdTipoRetencionGanancia;
                            }
                            else
                            {
                                IdTipoRetencionGanancia = null;
                            }

                            null.NumeroCAI = mNumeroCAI;
                            mvarProvincia.BienesOServicios = mNumeroCAI;
                            IdProvinciaDestino = mNumeroCAI;
                            MinValue;
                            FechaVencimientoCAI = mFechaVencimientoCAI;
                            FechaVencimientoCAI = null;
                            "O".InformacionAuxiliar = mInformacionAuxiliar;
                            DestinoPago = mInformacionAuxiliar;
                            if ((mIdCodigoIva != 0))
                            {

                            }

                            mIdCodigoIva.CircuitoFirmasCompleto = "SI";
                            IdCodigoIva = "SI";
                            if ((mIdPuntoVenta != 0))
                            {

                            }

                            IdPuntoVenta = mIdPuntoVenta;
                            if ((mNumeroCAE.Length > 0))
                            {

                            }

                            NumeroCAE = mNumeroCAE;
                        }

                        mTotalBruto = 0;
                        mTotalIva1 = 0;
                        mTotalPercepcion = 0;
                        mTotalComprobante = 0;
                        mTotalAjusteIVA = 0;
                        mAjusteIVA = 0;
                        while (((dt.Rows[fl].Item[2].Trim().Length > 0)
                                    && ((mLetra == dt.Rows[fl].Item[6].Trim())
                                    && ((mNumeroComprobante1 == dt.Rows[fl].Item[7])
                                    && ((mNumeroComprobante2 == dt.Rows[fl].Item[8])
                                    && ((mCuit == dt.Rows[fl].Item[10])
                                    || ((mCuitPlanilla == dt.Rows[fl].Item[10])
                                    || (mCuit == mCuitDefault))))))))
                        {
                            mCodigoCuentaGasto = dt.Rows[fl].Item[22];
                            mItemPresupuestoObrasNodo = dt.Rows[fl].Item[24].Trim();
                            mCantidad = double.Parse(dt.Rows[fl].Item[25]);
                            mIdCuentaGasto = 0;
                            mIdCuenta = 0;
                            mCodigoCuenta = 0;
                            mIdRubroContable = 0;
                            if ((mCodigoCuentaGasto.Length > 0))
                            {
                                oRsAux1 = EntidadManager.TraerFiltrado(SC, "CuentasGastos_TX_PorCodigo2", mCodigoCuentaGasto);
                                if ((oRsAux1.RecordCount > 0))
                                {
                                    mIdCuentaGasto = oRsAux1.IdCuentaGasto;
                                    oRsAux1.Close;
                                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorObraCuentaGasto", mIdObra, mIdCuentaGasto);
                                    if ((oRsAux1.RecordCount > 0))
                                    {
                                        mIdCuenta = oRsAux1.IdCuenta;
                                        mCodigoCuenta = oRsAux1.Codigo;
                                        mIdRubroContable = (IsNull(oRsAux1.IdRubroForminanciero) ? 0 : oRsAux1.IdRubroForminanciero);
                                        if (((mIdRubroContable == 0)
                                                    && !IsNull(oRsAux1.CodigoRubroContable)))
                                        {
                                            oRsAux2 = EntidadManager.TraerFiltrado(SC, "RubrosContables_TX_PorCodigo", oRsAux1.CodigoRubroContable, mIdObra, "SI");
                                            if ((oRsAux2.RecordCount > 0))
                                            {
                                                mIdRubroContable = oRsAux2.Fields(0).Value;
                                            }

                                            oRsAux2.Close;
                                        }

                                    }
                                    else if (!mTomarCuentaDePresupuesto)
                                    {
                                        mError = (mError + ("\r\n"
                                                    + (mTipo + (" "
                                                    + (mLetra + ("-"
                                                    + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                                    + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                                    + (fl + ("  - Cuenta de gasto codigo "
                                                    + (mCodigoCuentaGasto + " inexistente")))))))))))));
                                        fl = (fl + 1);
                                        // TODO: Continue Do... Warning!!! not translated
                                        //  GoTo FinLoop
                                    }

                                }
                                else
                                {
                                    oRsAux1.Close;
                                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorCodigo", mCodigoCuentaGasto);
                                    if ((oRsAux1.RecordCount > 0))
                                    {
                                        mIdCuenta = oRsAux1.IdCuenta;
                                        mCodigoCuenta = oRsAux1.Codigo;
                                        mIdRubroContable = (IsNull(oRsAux1.IdRubroForminanciero) ? 0 : oRsAux1.IdRubroForminanciero);
                                        if (((mIdRubroContable == 0)
                                                    && !IsNull(oRsAux1.CodigoRubroContable)))
                                        {
                                            oRsAux2 = EntidadManager.TraerFiltrado(SC, "RubrosContables_TX_PorCodigo", oRsAux1.CodigoRubroContable, mIdObra, "SI");
                                            if ((oRsAux2.RecordCount > 0))
                                            {
                                                mIdRubroContable = oRsAux2.Fields(0).Value;
                                            }

                                            oRsAux2.Close;
                                        }

                                    }
                                    else if (!mTomarCuentaDePresupuesto)
                                    {
                                        mError = (mError + ("\r\n"
                                                    + (mTipo + (" "
                                                    + (mLetra + ("-"
                                                    + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                                    + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                                    + (fl + "  - Cuenta contable inexistente")))))))))));
                                        fl = (fl + 1);
                                        // TODO: Continue Do... Warning!!! not translated
                                        //  GoTo FinLoop
                                    }

                                }

                                oRsAux1.Close;
                            }

                            mIdPresupuestoObrasNodo = 0;
                            if ((mItemPresupuestoObrasNodo.Length > 0))
                            {
                                oRsAux1 = EntidadManager.TraerFiltrado(SC, "PresupuestoObrasNodos_TX_PorItem", mItemPresupuestoObrasNodo, mIdObra);
                                if ((oRsAux1.RecordCount == 1))
                                {
                                    mIdPresupuestoObrasNodo = oRsAux1.IdPresupuestoObrasNodo;
                                    if (((IsNull(oRsAux1.IdCuenta) ? 0 : oRsAux1.IdCuenta) > 0))
                                    {
                                        mIdCuenta = (IsNull(oRsAux1.IdCuenta) ? 0 : oRsAux1.IdCuenta);
                                    }

                                }

                                oRsAux1.Close;
                            }

                            oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorId", mIdCuenta);
                            if ((oRsAux1.RecordCount > 0))
                            {
                                if ((((IsNull(oRsAux1.ImputarAPresupuestoDeObra) ? "NO" : oRsAux1.ImputarAPresupuestoDeObra) == "NO")
                                            && !mTomarCuentaDePresupuesto))
                                {
                                    mIdPresupuestoObrasNodo = 0;
                                }

                                mCodigoCuenta = oRsAux1.Codigo;
                                if (((IsNull(oRsAux1.IdRubroForminanciero) ? 0 : oRsAux1.IdRubroForminanciero) > 0))
                                {
                                    mIdRubroContable = oRsAux1.IdRubroForminanciero;
                                }

                            }
                            else
                            {
                                mError = (mError + ("\r\n"
                                            + (mTipo + (" "
                                            + (mLetra + ("-"
                                            + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                            + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                            + (fl + "  - Cuenta contable inexistente")))))))))));
                                fl = (fl + 1);
                                // TODO: Continue Do... Warning!!! not translated
                                //  GoTo FinLoop
                            }

                            oRsAux1.Close;
                            oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mBruto " + dt.Rows[fl].Item[13]))));
                            mBruto = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows[fl].Item[13])));
                            oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mIva1 " + dt.Rows[fl].Item[14]))));
                            mIVA1 = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows[fl].Item[14])), 4);
                            oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mPercepcion " + dt.Rows[fl].Item[15]))));
                            mPercepcion = Math.Abs(Convert.ToDouble(double.Parse(dt.Rows[fl].Item[15])));
                            oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mTotalItem " + dt.Rows[fl].Item[16]))));
                            mTotalItem = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows[fl].Item[16])), 2);
                            mObservaciones = ("Rendicion  "
                                        + (mNumeroRendicion + ("\r\n"
                                        + (dt.Rows[fl].Item[20] + "\r\n"))));
                            mTotalBruto = (mTotalBruto + mBruto);
                            mTotalIva1 = (mTotalIva1 + mIVA1);
                            mTotalPercepcion = (mTotalPercepcion + mPercepcion);
                            mTotalComprobante = (mTotalComprobante + mTotalItem);
                            mTotalAjusteIVA = (mTotalAjusteIVA + mAjusteIVA);
                            mPorcentajeIVA = 0;
                            oForm_Label1 = (mMensaje + ("\r\n" + ("\r\n" + ("mPorcentajeIVA " + dt.Rows[fl].Item[11]))));
                            if (((mIVA1 != 0)
                                        && (mBruto != 0)))
                            {
                                mPorcentajeIVA = dt.Rows[fl].Item[11];
                            }

                            mIdCuentaIvaCompras1 = 0;
                            mvarPosicionCuentaIva = 1;
                            if ((mPorcentajeIVA != 0))
                            {
                                for (i = 1; (i <= 10); i++)
                                {
                                    if ((mIVAComprasPorcentaje[i] == mPorcentajeIVA))
                                    {
                                        mIdCuentaIvaCompras1 = mIdCuentaIvaCompras[i];
                                        mvarPosicionCuentaIva = i;
                                        break;
                                    }

                                }

                            }

                            if (((mIVA1 != 0)
                                        && (mIdCuentaIvaCompras1 == 0)))
                            {
                                mError = (mError + ("\r\n"
                                            + (mTipo + (" "
                                            + (mLetra + ("-"
                                            + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                            + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                            + (fl + ("  - No se encontro el porcentaje de iva " + mPorcentajeIVA))))))))))));
                                fl = (fl + 1);
                                // TODO: Continue Do... Warning!!! not translated
                                //  GoTo FinLoop
                            }

                            object oCPdet = new ProntoMVC.Data.Models.DetalleComprobantesProveedore();
                            oCP.DetalleComprobantesProveedores.Add(oCPdet);
                            // With...
                            if ((mIdCuentaIvaCompras1 != 0))
                            {
                                CallByName(oCPdet, ("IdCuentaIvaCompras" + mvarPosicionCuentaIva), CallType.Set, mIdCuentaIvaCompras1);
                                "NO".IdCuentaIvaCompras10 = 0;
                                0.AplicarIVA9 = 0;
                                0.ImporteIVA9 = 0;
                                null.IVAComprasPorcentaje9 = 0;
                                "NO".IdCuentaIvaCompras9 = 0;
                                0.AplicarIVA8 = 0;
                                0.ImporteIVA8 = 0;
                                null.IVAComprasPorcentaje8 = 0;
                                "NO".IdCuentaIvaCompras8 = 0;
                                0.AplicarIVA7 = 0;
                                0.ImporteIVA7 = 0;
                                null.IVAComprasPorcentaje7 = 0;
                                "NO".IdCuentaIvaCompras7 = 0;
                                0.AplicarIVA6 = 0;
                                0.ImporteIVA6 = 0;
                                null.IVAComprasPorcentaje6 = 0;
                                "NO".IdCuentaIvaCompras6 = 0;
                                0.AplicarIVA5 = 0;
                                0.ImporteIVA5 = 0;
                                null.IVAComprasPorcentaje5 = 0;
                                "NO".IdCuentaIvaCompras5 = 0;
                                0.AplicarIVA4 = 0;
                                0.ImporteIVA4 = 0;
                                null.IVAComprasPorcentaje4 = 0;
                                "NO".IdCuentaIvaCompras4 = 0;
                                0.AplicarIVA3 = 0;
                                0.ImporteIVA3 = 0;
                                null.IVAComprasPorcentaje3 = 0;
                                "NO".IdCuentaIvaCompras3 = 0;
                                0.AplicarIVA2 = 0;
                                0.ImporteIVA2 = 0;
                                null.IVAComprasPorcentaje2 = 0;
                                "NO".IdCuentaIvaCompras2 = 0;
                                0.AplicarIVA1 = 0;
                                0.ImporteIVA1 = 0;
                                null.IVAComprasPorcentaje1 = 0;
                                mBruto.IdCuentaIvaCompras1 = 0;
                                mCodigoCuenta.Importe = 0;
                                mIdCuenta.CodigoCuenta = 0;
                                mIdCuentaGasto.IdCuenta = 0;
                                mIdObra.IdCuentaGasto = 0;
                                oCPdet.IdObra = 0;
                                CallByName(oCPdet, ("IVAComprasPorcentaje" + mvarPosicionCuentaIva), CallType.Set, mPorcentajeIVA);
                                CallByName(oCPdet, ("ImporteIVA" + mvarPosicionCuentaIva), CallType.Set, Math.Round(mIVA1, 2));
                                CallByName(oCPdet, ("AplicarIVA" + mvarPosicionCuentaIva), CallType.Set, "SI");
                            }

                            0.AplicarIVA10 = "NO";
                            ImporteIVA10 = "NO";
                            if ((mIdPresupuestoObrasNodo != 0))
                            {

                            }

                            IdPresupuestoObrasNodo = mIdPresupuestoObrasNodo;
                            if ((mIdRubroContable > 0))
                            {

                            }

                            mIdRubroContable.Cantidad = mCantidad;
                            IdRubroContable = mCantidad;
                            fl = (fl + 1);
                        }

                        // With...
                        if ((mIncrementarReferencia != "SI"))
                        {

                        }

                        0.AjusteIVA = mObservaciones;
                        0.TotalIvaNoDiscriminado = mObservaciones;
                        mTotalComprobante.PorcentajeBonificacion = mObservaciones;
                        0.TotalComprobante = mObservaciones;
                        0.TotalBonificacion = mObservaciones;
                        mTotalIva1.TotalIva2 = mObservaciones;
                        mTotalBruto.TotalIva1 = mObservaciones;
                        "NO".TotalBruto = mObservaciones;
                        mNumeroReferencia.Confirmado = mObservaciones;
                        oCP.NumeroReferencia = mObservaciones;
                        AutoincrementarNumeroReferencia = "NO";
                        s.Grabar_ComprobanteProveedor(oCP, IdUsuario);
                        mNumeroReferencia = (mNumeroReferencia + 1);
                    }
                    else
                    {
                        fl = (fl + 1);
                    }

                }
                else
                {
                    mError = (mError + ("\r\n"
                                + (mTipo + (" "
                                + (mLetra + ("-"
                                + (mNumeroComprobante1.ToString.PadLeft(4, "0") + ("-"
                                + (mNumeroComprobante2.ToString.PadLeft(8, "0") + (", fila "
                                + (fl + ("  - Fecha es anterior al ultimo cierre contable : " + mComprobante))))))))))));
                    fl = (fl + 1);
                }

                break; //Warning!!! Review that break works as 'Exit Do' as it could be in a nested instruction like switch
                Using;
            }


    */

        }

    }


}