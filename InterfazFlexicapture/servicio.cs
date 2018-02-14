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



namespace ServicioMVC
{






    public class servi
    {


        private DemoProntoEntities db; //= new DemoProntoEntities(sCadenaConex());
        private ProntoMVC.Data.Models.Mantenimiento.ProntoMantenimientoEntities dbmant;



        public servi(string cadenaconexionDirectaFormatoEF)
        {
                        db = new DemoProntoEntities(cadenaconexionDirectaFormatoEF);
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


    }


}