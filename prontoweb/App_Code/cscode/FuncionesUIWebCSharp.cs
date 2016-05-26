using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Reflection;
using System.Data;
using System.IO;


using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
//using DocumentFormat.OpenXml.Wordprocessing;


using System.Xml.Linq;

/// <summary>
/// Summary description for Class1
/// </summary>

namespace ProntoCSharp
{
    public class FuncionesUIWebCSharp
    {
      



        public static void FacturaElectronica(List<int> lotefacturas)
        {


        //    asdasd
        }

       
        //public void Logica_FacturaElectronica (Pronto.ERP.BO.Factura o)
        //{
        //    //https://sites.google.com/site/facturaelectronicax/documentacion-wsfev1/wsfev1/wsfev1-modo-en-lote

        //    // http://stackoverflow.com/questions/13719579/equivalent-code-of-createobject-in-c-sharp

        //    WSAFIPFE.Factura FE;

        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    int puntoventa = 1;
        //    bool mResul;
        //    string glbCuit;


        //    string mCodigoMoneda, glbIdMonedaEuro, glbidmonedadolar;
        //    bool glbDebugFacturaElectronica = true;
        //    string glbIdMonedaPesos, dtfields, mFecha, mModoTest, dcfields, ors, mncm, mnumeroitem, mDescripcion = "";
        //    long mIdentificador;
        //    string ors1, txtCuit, aplicacion, mCAE;
        //    string mUnidadesCodigoAFIP;
        //    int mCantidadItem;
        //    string compronto, vbDefault;
        //    string mVarImprime;
        //    int mTipoComprobante;
        //    string mDomicilio, mCodigoMoneda1, mCuitPais, txtCotizacionMoneda;
        //    double mvarTotalFactura = 0, mvarSubTotal = 0, mvarImporteBonificacion = 0;
        //    string rchFacturaElectronica, origen;
        //    string mvarPorcentajeIbrutos, mvarPorcentajeIbrutos2, mvarPorcentajeIbrutos3;
        //    string txtTotal;
        //    string mPaisDestino, mCliente;
        //    string combo1, mWS, mvarTipoABC, glbArchivoAFIP;
        //    string mCAEManual = "NO";
        //    string glbPathPlantillas;

        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////
        //    ///////////////////////////////////////////////////////////////////////////////////////////////

        //    ////////////////////////////////////
        //    glbPathPlantillas = AppDomain.CurrentDomain.BaseDirectory + "Documentos";
        //    mWS = "WSFE1";
        //    mvarTipoABC = o.TipoABC;
        //    glbArchivoAFIP = "Autotrol23082011";
        //    glbCuit = "30-50491371-2";
        //    mFecha = String.Format("{0:yyyymmdd}", o.FechaFactura);     // "20100931";
        //    mModoTest = "SI";
        //    ///////////////////////////////////





        //    //if (false)
        //    //{

        //    //    Pronto.ERP.Bll.EntidadManager.facturaelectronica();
        //    //}
        //    //else if (false)
        //    //{
        //    //    Type ExcelType = Type.GetTypeFromProgID("WSAFIPFE.Factura");
        //    //    dynamic ExcelInst = Activator.CreateInstance(ExcelType);
        //    //}
        //    //Dim FEx As WSAFIPFE.Factura


        //    //            https://sites.google.com/site/facturaelectronicax/Home
        //    //WSFE (factura electrónica nacional, proveedores del estado e importadores). (probable baja del WSFE en 2011, ver nota WSFEv1)
        //    //WSFEv1 (factura electrónica nacional CAE, reemplazo del WSFE. Y CAE anticipado RG 2485).
        //    //WSBFE y WSBFEv1 (factura electrónica nacional para emisión de bonos fiscales  y bienes de capital).
        //    //WSSEG (factura electrónica para seguros de caución).
        //    //WSFEX y WSFEXv1 (factura electrónica tipo E para exportadores o exportación).
        //    //WSMTXCA (factura electrónica nacional CAE y CAE anticipado. Con codificación de productos Matrix AFIP).
        //    //WSCTG (código de trazabilidad de granos).
        //    //WSCTGv1 (y WSCTGv1.1) (código de trazabilidad de granos versión 1y 1.1 simil página interactiva de AFIP).
        //    //WSAA (autorización y acceso, es administrado automáticamente por la interfaz).


        //    FE = new WSAFIPFE.Factura();
        //    WSAFIPFE.Factura FEx = new WSAFIPFE.Factura();






        //    if (mWS == "WSFE" && (mvarTipoABC == "A" || mvarTipoABC == "B"))  ///  WSFE (factura electrónica nacional, proveedores del estado e importadores). (probable baja del WSFE en 2011, ver nota WSFEv1)
        //    {
        //        //If Len(Trim(glbArchivoAFIP)) = 0 Then
        //        //   Me.MousePointer = vbDefault
        //        //   MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
        //        //   Exit Sub
        //        //End If

        //        //mCodigoMoneda = 0
        //        //Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
        //        //If oRs.RecordCount > 0 Then
        //        //   If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
        //        //      If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then mCodigoMoneda = oRs.Fields("CodigoAFIP").Value
        //        //   End If
        //        //End If
        //        //oRs.Close
        //        //If mCodigoMoneda = 0 Then
        //        //   If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
        //        //   If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda = 2
        //        //   If dcfields(3).BoundText = glbIdMonedaEuro Then mCodigoMoneda = 60
        //        //End If

        //        //FE = CreateObject("WSAFIPFE.Factura")

        //        // 'fer me comento que el recibe el crt y manualmente con unas magias lo convierte a pfx
        //        //'cuando le dije que el tango se hace cargo, me pidio que lo discuta con edu, porque quizas así él se ahorra el tramite medio extraño
        //        //'en cuanto al .lic, parece que el pronto (o la biblioteca) lo va a buscar si es que no esta presente

        //        mResul = FE.ActivarLicenciaSiNoExiste(glbCuit.Replace("-", ""), glbPathPlantillas + "\\FE_" + glbCuit.Replace("-", "") + ".lic", "pronto.wsfex@gmail.com", "bdlconsultores");
        //        //if (glbDebugFacturaElectronica) {
        //        //MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError
        //        //}

        //        // mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")


        //        // Mensaje del cordobés Camuso: http://facturaelectronicax.blogspot.com.ar/2011/03/errores-de-conexion-en-factura.html
        //        //                Además, por un cambio en los servidores de AFIP (tanto producción como homologación) algunos windows dejaron de reconocer a los servidores de AFIP como auténticos, causando el error:
        //        //"No se pudo establecer una relación de confianza" o
        //        //"Could not establish trust relationship" o
        //        //"el certificado no fue generado por un AC de confienza"
        //        // https://sites.google.com/site/facturaelectronicax/Home/version-full/como-usar/certificado-digital/certificados-resumen/certificado-de-confianza-afip

        //        if (mModoTest == "SI")
        //        {
        //            //Pronto.ERP.Bll.FacturaManager.TestDelCordobes();
        //            mResul = FE.iniciar(WSAFIPFE.Factura.modoFiscal.Test, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", "");
        //        }
        //        else
        //        {
        //            if (true) // (Len(Dir(glbPathPlantillas + "\SCFE9.lic")) > 0)  
        //            {
        //                // 'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
        //                var x = WSAFIPFE.Factura.modoFiscal.Fiscal;
        //                mResul = FE.iniciar(x, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", glbPathPlantillas + "\\FE_" + glbCuit.Replace("-", "") + ".lic");
        //            }
        //            else
        //            {
        //                mResul = FE.iniciar(WSAFIPFE.Factura.modoFiscal.Fiscal, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", "");
        //            }
        //        }

        //        if (mResul) mResul = FE.ObtenerTicketAcceso();

        //        // mResul = FE.f1ObtenerTicketAcceso();

        //        //With FE
        //        if (glbDebugFacturaElectronica)
        //        {
        //            Console.Write(FE.UltimoMensajeError);
        //            //      MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //            //      mResul = .Dummy
        //            //      MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        }

        //        if (mResul)
        //        {
        //            FE.FECabeceraCantReg = 1;
        //            FE.FECabeceraPresta_serv = 1;
        //            FE.indice = 0;
        //            FE.FEDetalleFecha_vence_pago = mFecha;
        //            FE.FEDetalleFecha_serv_desde = mFecha;
        //            FE.FEDetalleFecha_serv_hasta = mFecha;
        //            FE.FEDetalleFecha_vence_pago = mFecha;
        //            FE.FEDetalleImp_neto = mvarSubTotal - mvarImporteBonificacion;
        //            FE.FEDetalleImp_total = mvarTotalFactura;
        //            FE.FEDetalleFecha_cbte = mFecha;
        //            FE.FEDetalleNro_doc = o.Cliente.Cuit;
        //            FE.FEDetalleTipo_doc = WSAFIPFE.Factura.TipoDocumento.CUIT; // 80

        //            if (glbDebugFacturaElectronica)
        //            {
        //                FE.ArchivoXMLEnviado = "C:\\XMLEnviado.xml";
        //                FE.ArchivoXMLRecibido = "C:\\XMLRecibido.xml";
        //            }

        //            Random random = new Random();
        //            int maxValue = 100000000;
        //            mIdentificador = random.Next(maxValue);



        //            if (mvarTipoABC == "A")
        //            {
        //                mResul = FE.Registrar(puntoventa, WSAFIPFE.Factura.TipoComprobante.FacturaA, mIdentificador.ToString());
        //                //         'mResul = .RegistrarConNumero(dcfields(10).Text, 1, "" & mIdentificador, txtNumeroFactura.Text)
        //            }
        //            else
        //            {
        //                mResul = FE.Registrar(puntoventa, WSAFIPFE.Factura.TipoComprobante.FacturaB, mIdentificador.ToString());
        //            }

        //            if (glbDebugFacturaElectronica)
        //            {
        //                Console.Write(FE.UltimoMensajeError);
        //                //         MsgBox "Registrar : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError & " - Motivo : " & .FERespuestaMotivo
        //                //         rchFacturaElectronica.Text = "Request : " & FE.XMLRequest & vbCrLf & vbCrLf & "Response : " & FE.XMLResponse
        //            }

        //            if (mResul)
        //            {
        //                mCAE = FE.FERespuestaDetalleCae;
        //                //string chr10="";
        //                //        mDescripcion = chr10 + "CAE: " + FE.FERespuestaDetalleCae + chr10 + "MOTIVO " + .FERespuestaDetalleMotivo +
        //                //                        chr10 + "PROCESO " + FE.FERespuestaReproceso + chr10 + "NUMERO: " + Str(FE.FERespuestaDetalleCbt_desde);


        //                // o.CAE = mCAE;
        //                //          o.IdIdentificacionCAE = mIdentificador;
        //                //                o.FechaVencimientoORechazoCAE= FE.FERespuestaDetalleFecha_vto;
        //                //                                   o.Observaciones+= chr10 + mDescripcion;

        //            }
        //            else
        //            {
        //                Console.Write(FE.UltimoMensajeError);

        //                //         Me.MousePointer = vbDefault
        //                //         MsgBox "Error al obtener CAE : " + .UltimoMensajeError, vbExclamation
        //                //         Exit Sub
        //            }
        //        }
        //        else
        //        {
        //            Console.Write(FE.UltimoMensajeError);

        //            //      Me.MousePointer = vbDefault
        //            //      MsgBox "Error al obtener CAE : " + .UltimoMensajeError, vbExclamation
        //            //      Exit Sub
        //        }

        //        FE = null;
        //    }
        //    else if (mWS == "WSFE1" && (mvarTipoABC == "A" || mvarTipoABC == "B"))
        //    {
        //        //If Len(Trim(glbArchivoAFIP)) = 0 Then
        //        //   Me.MousePointer = vbDefault
        //        //   MsgBox "No ha definido el archivo con el certificado AFIP, ingrese a los datos de la empresa y registrelo", vbInformation
        //        //   Exit Sub
        //        //End If

        //        //mCodigoMoneda = 0
        //        //Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
        //        //If oRs.RecordCount > 0 Then
        //        //   If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
        //        //      If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
        //        //         mCodigoMoneda = oRs.Fields("CodigoAFIP").Value
        //        //      End If
        //        //   End If
        //        //End If
        //        //oRs.Close
        //        //If mCodigoMoneda = 0 Then
        //        //   If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda = 1
        //        //   If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda = 2
        //        //   If dcfields(3).BoundText = glbIdMonedaEuro Then mCodigoMoneda = 60
        //        //End If

        //        //Set FE = CreateObject("WSAFIPFE.Factura")

        //        //mResul = FE.ActivarLicenciaSiNoExiste(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
        //        //If glbDebugFacturaElectronica Then
        //        //   MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FE.UltimoMensajeError
        //        //End If



        //        if (mModoTest == "SI")
        //        {
        //            mResul = FE.iniciar(WSAFIPFE.Factura.modoFiscal.Test, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", glbPathPlantillas + "\\FE_" + glbCuit.Replace("-", "") + ".lic");
        //            //https://sites.google.com/site/facturaelectronicax/documentacion-wsfev1
        //            //https://sites.google.com/site/facturaelectronicax/como-empezar/planilla-excel-interactiva


        //        }
        //        else
        //        {
        //            if (glbPathPlantillas.Contains("TestProject")) glbPathPlantillas = "E:\\Backup\\BDL\\ProntoWeb\\ProntoMVC\\ProntoMVC\\Documentos";
        //            mResul = FE.iniciar(WSAFIPFE.Factura.modoFiscal.Fiscal, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", glbPathPlantillas + "\\FE_" + glbCuit.Replace("-", "") + ".lic");
        //        }

        //        //mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")
        //        //If mModoTest = "SI" Then
        //        //   mResul = FE.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
        //        //Else
        //        //   mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FE_" & Replace(glbCuit, "-", "") & ".lic")
        //        //End If

        //        if (mResul) mResul = FE.f1ObtenerTicketAcceso();//esto en modo test tambien debería devolver true  https://sites.google.com/site/facturaelectronicax/documentacion-wsfev1/wsfev1/wsfev1-ejemplos/ejemplo-wsfev1-visual-basic-net-para-cae

        //        //If mResul Then mResul = FE.f1ObtenerTicketAcceso()
        //        //With FE
        //        //   If glbDebugFacturaElectronica Then
        //        //      MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        //      mResul = .f1Dummy
        //        //      MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        //   End If

        //        if (glbDebugFacturaElectronica)
        //        {
        //            Console.Write(FE.UltimoMensajeError);
        //            //      MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //            //      mResul = .Dummy
        //            //      MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        }

        //        if (mResul)
        //        {

        //            try
        //            {



        //                FE.F1CabeceraCantReg = 1;
        //                FE.F1CabeceraPtoVta = (int)o.PuntoVenta;
        //                if (mvarTipoABC == "A")
        //                {
        //                    FE.F1CabeceraCbteTipo = 1;
        //                }
        //                else
        //                {
        //                    FE.F1CabeceraCbteTipo = 6;
        //                }





        //                FE.f1Indice = 0;
        //                FE.F1DetalleConcepto = 3;
        //                FE.F1DetalleDocTipo = 80;
        //                FE.F1DetalleDocNro = db.Clientes.Find(o.IdCliente).Cuit.Replace("-", ""); // o.Cliente.Cuit;
        //                FE.F1DetalleCbteDesde = o.NumeroFactura ?? 0;
        //                FE.F1DetalleCbteHasta = o.NumeroFactura ?? 0;
        //                FE.F1DetalleCbteFch = mFecha;
        //                FE.F1DetalleImpTotal = Math.Round(mvarTotalFactura, 2);
        //                FE.F1DetalleImpTotalConc = 0;
        //                //FE.F1DetalleImpNeto = Math.Round(mvarSubTotal - mvarIVANoDiscriminado, 2);
        //                FE.F1DetalleImpOpEx = 0;
        //                //FE.F1DetalleImpTrib = Math.Round(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text) + Val(txtTotal(11).Text), 2);
        //                // FE.F1DetalleImpIva = mvarIVA1 + mvarIVANoDiscriminado;
        //                FE.F1DetalleFchServDesde = mFecha;
        //                FE.F1DetalleFchServHasta = mFecha;
        //                FE.F1DetalleFchVtoPago = mFecha;
        //                // FE.F1DetalleMonIdS = mCodigoMoneda1;
        //                FE.F1DetalleMonCotiz = (double)(o.CotizacionMoneda ?? 0);


        //                FE.F1DetalleCbtesAsocItemCantidad = 0;
        //                FE.F1DetalleOpcionalItemCantidad = 0;

        //            }
        //            catch (Exception ex)
        //            {

        //                throw;
        //            }


        //            mResul = FE.F1CAESolicitar();

        //            if (mResul)
        //            {
        //                mCAE = FE.F1RespuestaDetalleCae;

        //                if (mCAE.Trim().Length == 0)
        //                {
        //                    var s = "Error al obtener CAE : " + FE.UltimoMensajeError + " - Ultimo numero " + FE.F1CompUltimoAutorizado(FE.F1CabeceraPtoVta, FE.F1CabeceraCbteTipo);
        //                    throw new Exception(s);
        //                    //return; // s;
        //                }
        //                var mNumeroFacturaElectronica = FE.F1RespuestaDetalleCbteDesdeS;
        //                o.CAE = mCAE;
        //                o.IdIdentificacionCAE = 0;
        //                o.FechaVencimientoORechazoCAE = Convert.ToDateTime(FE.F1RespuestaDetalleCAEFchVto);
        //                //                             Aplicacion.Tarea "LogComprobantesElectronicos_InsertarRegistro", Array("FA", mvarTipoABC, Val(dcfields(10).Text), mNumeroFacturaElectronica, mIdentificador, _
        //                //                       LeerArchivoSecuencial1(glbPathTemp & "\XMLEnviado.xml"), LeerArchivoSecuencial1(glbPathTemp & "\XMLRecibido.xml"))
        //            }
        //        }
        //        else
        //        {
        //            //      Me.MousePointer = vbDefault
        //            //      MsgBox "Error al obtener CAE : " + .UltimoMensajeError, vbExclamation
        //            //      Exit Sub
        //            //   End If
        //        }
        //        //End With
        //        FE = null;

        //    }
        //    else if (mWS == "WSBFE" && (mvarTipoABC == "A" || mvarTipoABC == "B"))   /// WSBFE y WSBFEv1 (factura electrónica nacional para emisión de bonos fiscales  y bienes de capital).
        //    {
        //     //   Logica_FacturaElectronica_BonosFiscales();
        //    }
        //    else if (mWS.Length > 0 && mvarTipoABC == "E")
        //    {
        //        mTipoComprobante = 19;

        //        //mCodigoMoneda1 = ""
        //        //Set oRs = Aplicacion.Monedas.TraerFiltrado("_PorId", dcfields(3).BoundText)
        //        //If oRs.RecordCount > 0 Then
        //        //   If Not IsNull(oRs.Fields("CodigoAFIP").Value) Then
        //        //      If IsNumeric(oRs.Fields("CodigoAFIP").Value) Then
        //        //         mCodigoMoneda1 = oRs.Fields("CodigoAFIP").Value
        //        //      End If
        //        //   End If
        //        //End If
        //        //oRs.Close
        //        //If Len(mCodigoMoneda1) = 0 Then
        //        //   If dcfields(3).BoundText = glbIdMonedaPesos Then mCodigoMoneda1 = "PES"
        //        //   If dcfields(3).BoundText = glbIdMonedaDolar Then mCodigoMoneda1 = "DOL"
        //        //End If

        //        //Set oRs = Aplicacion.Clientes.TraerFiltrado("_PorIdConDatos", dcfields(0).BoundText)
        //        //If oRs.RecordCount > 0 Then
        //        //   mPaisDestino = oRs.Fields("PaisCodigo2").Value
        //        //   mCuitPais = oRs.Fields("CuitPais").Value
        //        //   mCliente = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
        //        //   mDomicilio = IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value & " ") & _
        //        //               IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value & " ") & _
        //        //               IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value & " ") & _
        //        //               IIf(IsNull(oRs.Fields("Pais").Value), "", oRs.Fields("Pais").Value)
        //        //End If
        //        //oRs.Close
        //        //Set oRs = Nothing


        //        //mFecha = "" & Year(DTFields(0).Value) & Format(Month(DTFields(0).Value), "00") & Format(Day(DTFields(0).Value), "00")

        //        //mResul = FEx.ActivarLicencia(Replace(glbCuit, "-", ""), glbPathPlantillas & "\FEX_" & Replace(glbCuit, "-", "") & ".lic", "pronto.wsfex@gmail.com", "bdlconsultores")
        //        //If glbDebugFacturaElectronica Then
        //        //   MsgBox "ActivarLicencia : " & glbPathPlantillas & "\FEX_" & Replace(glbCuit, "-", "") & ".lic" & " - UltimoMensajeError : " & FEx.UltimoMensajeError
        //        //End If


        //        if (mModoTest == "SI")
        //        {
        //            //Pronto.ERP.Bll.FacturaManager.TestDelCordobes();
        //            mResul = FEx.iniciar(WSAFIPFE.Factura.modoFiscal.Test, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", "");
        //        }
        //        else
        //        {
        //            if (true) // (Len(Dir(glbPathPlantillas + "\SCFE9.lic")) > 0)  
        //            {
        //                // 'mResul = FE.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\SCFE9.lic")
        //                var x = WSAFIPFE.Factura.modoFiscal.Fiscal;
        //                mResul = FEx.iniciar(x, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", glbPathPlantillas + "\\FE_" + glbCuit.Replace("-", "") + ".lic");
        //            }
        //            else
        //            {
        //                mResul = FEx.iniciar(WSAFIPFE.Factura.modoFiscal.Fiscal, glbCuit.Replace("-", ""), glbPathPlantillas + "\\" + glbArchivoAFIP + ".pfx", "");
        //            }
        //        }

        //        //If mModoTest = "SI" Then
        //        //   mResul = FEx.iniciar(0, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
        //        //Else
        //        //   If Len(Dir(glbPathPlantillas & "\SCFE9.lic")) > 0 Then
        //        //      mResul = FEx.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", glbPathPlantillas & "\FEX_" & Replace(glbCuit, "-", "") & ".lic")
        //        //   Else
        //        //      mResul = FEx.iniciar(1, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "")
        //        //   End If
        //        //End If
        //        //If glbDebugFacturaElectronica Then MsgBox "Iniciar : " & mResul & " - UltimoMensajeError : " & FEx.UltimoMensajeError
        //        //If mResul Then mResul = FEx.xObtenerTicketAcceso()
        //        //With FEx
        //        //   If glbDebugFacturaElectronica Then
        //        //      MsgBox "ObtenerTicketAcceso : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        //      mResul = .Dummy
        //        //      MsgBox "Dummy : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError
        //        //   End If



        //        if (mResul)
        //        {
        //            FEx.xPunto_vta = 1;// dcfields(10).Text;
        //            FEx.xFecha_cbte = mFecha;
        //            FEx.xtipo_expo = 1;// Combo1(0).ListIndex + 1;
        //            FEx.xDst_cmp = 1; //mPaisDestino;
        //            //'                     .xPermiso_existente = "S"
        //            FEx.xPermisoNoInformar = 1;
        //            FEx.xCliente = "ss"; // mCliente;
        //            FEx.xCuit_pais_clienteS = "4444"; // mCuitPais;
        //            FEx.xDomicilio_cliente = "1"; //  mDomicilio;
        //            FEx.xId_impositivo = "";
        //            FEx.xMoneda_id = "1"; // mCodigoMoneda1;
        //            FEx.xMoneda_ctz = 1; // Val(txtCotizacionMoneda.Text);
        //            FEx.xObs_comerciales = "";
        //            FEx.xImp_total = mvarTotalFactura;
        //            FEx.xForma_pago = "1"; // dcfields(1).Text
        //            FEx.xIncoTerms = "CIF";
        //            FEx.xIncoTerms_ds = "";
        //            FEx.xIdioma_cbte = "1";

        //            mCantidadItem = o.DetalleFacturas.Count();
        //            FEx.xItemCantidad = mCantidadItem;
        //            var mNumeroItem = 0;
        //            foreach (DetalleFactura det in o.DetalleFacturas)
        //            {

        //                //If Len(mUnidadesCodigoAFIP) = 0 Then mUnidadesCodigoAFIP = "7"

        //                FEx.xIndiceItem = mNumeroItem;
        //                FEx.xITEMPro_codigo = "1"; // mNCM;
        //                FEx.xITEMPro_ds = mDescripcion;
        //                FEx.xITEMPro_qty = (double)det.Cantidad; // oRs.Fields("Cantidad").Value;
        //                FEx.xITEMPro_umed = 1; // mUnidadesCodigoAFIP;
        //                FEx.xITEMPro_precio_uni = 1; //oRs.Fields("PrecioUnitario").Value;
        //                FEx.xITEMPro_precio_item = (double)det.Cantidad * (double)det.PrecioUnitario;
        //                //Round(IIf(IsNull(oRs.Fields("Cantidad").Value), 0, oRs.Fields("Cantidad").Value) * _
        //                //                IIf(IsNull(oRs.Fields("PrecioUnitario").Value), 0, oRs.Fields("PrecioUnitario").Value) * _
        //                //                (1 - (IIf(IsNull(oRs.Fields("Bonificacion").Value), 0, oRs.Fields("Bonificacion").Value) / 100)), 2)
        //                mNumeroItem = mNumeroItem + 1;
        //            }

        //            Random random = new Random();
        //            int maxValue = 100000000;
        //            mIdentificador = random.Next(maxValue);

        //            mResul = FEx.xRegistrar(puntoventa, mTipoComprobante, mIdentificador.ToString());
        //            //              If glbDebugFacturaElectronica Then MsgBox "Registrar : " & mResul & " - UltimoMensajeError : " & .UltimoMensajeError

        //            //              If mResul Then
        //            //                 mCAE = .xRespuestaCAE
        //            //                 mDescripcion = Chr(10) + "CAE: " + .xRespuestaCAE + Chr(10) + "REPROCESO " + .xRespuestaReproceso + _
        //            //                                Chr(10) + "Evento " + .xEventMsg + Chr(10) + "Observacion: " + .xRespuestaMotivos_obs
        //            //                 With origen.Registro
        //            //                    .Fields("CAE").Value = mCAE
        //            //                    .Fields("IdIdentificacionCAE").Value = mIdentificador
        //            //                    If IsDate(mId(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 1, 4)) Then
        //            //                       .Fields("FechaVencimientoORechazoCAE").Value = CDate(mId(FEx.xRespuestaFch_venc_cae, 7, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 5, 2) & "/" & mId(FEx.xRespuestaFch_venc_cae, 1, 4))
        //            //                    End If
        //            //                 End With
        //            //              Else

        //        }

        //    }




        //    if (o.IdFactura <= 0)
        //    {

        //        if (mCAEManual == "SI")
        //        {
        //            /*
        //           mCAE = ""
        //              .Caption = "Ingresar numero de CAE"
        //                 .Caption = "Fecha vto. CAE :"
        //              If .Ok Then
        //                 mCAE = Val(.Text1.Text)
        //                 mvarFechaVencimientoCAE = .DTFields(0).Value
        //              End If
        //           With origen.Registro
        //              .Fields("CAE").Value = mCAE
        //              .Fields("FechaVencimientoORechazoCAE").Value = mvarFechaVencimientoCAE
        //           End With
        //        End If */
        //        }






        //    }
        //}






        // http://stackoverflow.com/questions/7980459/can-i-combine-the-visual-basic-project-web-site-pages-in-visual-c-sharp-project
        // http://stackoverflow.com/questions/7980459/can-i-combine-the-visual-basic-project-web-site-pages-in-visual-c-sharp-project
        // http://stackoverflow.com/questions/7980459/can-i-combine-the-visual-basic-project-web-site-pages-in-visual-c-sharp-project


        //    public FuncionesUIWebCSharp()
        //   {
        //
        // 
        //
        // }

        //http://ltuttini.blogspot.com.ar/2012/02/gridview-mantener-checkbox-durante-la.html
        //http://ltuttini.blogspot.com.ar/2012/02/gridview-mantener-checkbox-durante-la.html
        //http://ltuttini.blogspot.com.ar/2012/02/gridview-mantener-checkbox-durante-la.html
        //http://ltuttini.blogspot.com.ar/2012/02/gridview-mantener-checkbox-durante-la.html



        // es un asunto guardar la lista entera de marcadas si son muchas. Te tienta a guardar las que NO estan marcadas, y así...


        public static void MarcarTodas(GridView grid)
        {
            //con esto no safas, porque al pasarte la grilla, solo te estan pasando las filas que se ven en pantalla, y no todo el datasource
            //checkedProd = (from item in grid.Rows.Cast<GridViewRow>()
            //               let check = (CheckBox)item.FindControl("CheckBox1")
            //               where check.Checked
            //               select Convert.ToInt32(grid.DataKeys[item.RowIndex].Value)).ToList();
        }

        public static void MarcarLista(GridView grid, List<int> lista)
        {

            HttpContext.Current.Session["ProdSelection" + grid.ID] = lista;

            //lista.ForEach(x => ((CheckBox)x.FindControl("CheckBox1")).Checked = false);
        }


        public static List<int> TraerLista(GridView grid)
        {
            KeepSelection(grid); //por si todavía no la actualizó

            List<int> checkedProd = HttpContext.Current.Session["ProdSelection" + grid.ID] as List<int>;

            return checkedProd;
        }


        public static string TraerListaEnStringConComas(GridView grid)
        {
            // http://stackoverflow.com/questions/44942/cast-listint-to-liststring-in-net-2-0

            List<int> checkedProd = TraerLista(grid);
            List<string> l2 = checkedProd.ConvertAll<string>(x => x.ToString());
            l2.Add("-999");
            string s = string.Join(",", l2.ToArray());

            return s;
        }


        public static void KeepSelection(GridView grid)
        {

            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging



            //
            // se obtienen los id de producto checkeados de la pagina actual
            //
            List<int> checkedProd;
            try
            {
                checkedProd = (from item in grid.Rows.Cast<GridViewRow>()
                               let check = (CheckBox)item.FindControl("CheckBox1")
                               where check.Checked
                               select Convert.ToInt32(grid.DataKeys[item.RowIndex].Value is DBNull ? -999 : grid.DataKeys[item.RowIndex].Value)).ToList();
            }
            catch
            {
                //  verificar que la grilla tenga DataKeys
                // Si usas mas de un DataKeyName, tenes q guardar la matriz (grid.DataKeys[x].Values en lugar de Value)
                throw;
            }

            //
            // se recupera de session la lista de seleccionados previamente
            //
            List<int> productsIdSel = HttpContext.Current.Session["ProdSelection" + grid.ID] as List<int>;

            if (productsIdSel == null)
                productsIdSel = new List<int>();

            //
            // se cruzan todos los registros de la pagina actual del gridview con la lista de seleccionados,
            // si algun item de esa pagina fue marcado previamente no se devuelve
            //
            productsIdSel = (from item in productsIdSel
                             join item2 in grid.Rows.Cast<GridViewRow>()
                                on item equals Convert.ToInt32(grid.DataKeys[item2.RowIndex].Value is DBNull ? -999 : grid.DataKeys[item2.RowIndex].Value) into g
                             where !g.Any()
                             select item).ToList();

            //
            // se agregan los seleccionados
            //
            productsIdSel.AddRange(checkedProd);

            HttpContext.Current.Session["ProdSelection" + grid.ID] = productsIdSel;

        }


        public static void KeepUnselection(GridView grid)
        {

            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging
            //llamarla en el evento PageIndexChanging



            //
            // se obtienen los id de producto checkeados de la pagina actual
            //
            List<int> checkedProd;
            try
            {
                checkedProd = (from item in grid.Rows.Cast<GridViewRow>()
                               let check = (CheckBox)item.FindControl("CheckBox1")
                               where !check.Checked
                               select Convert.ToInt32(grid.DataKeys[item.RowIndex].Value)).ToList();
            }
            catch
            {
                //  verificar que la grilla tenga DataKeys
                // Si usas mas de un DataKeyName, tenes q guardar la matriz (grid.DataKeys[x].Values en lugar de Value)
                throw;
            }

            //
            // se recupera de session la lista de seleccionados previamente
            //
            List<int> productsIdSel = HttpContext.Current.Session["ProdSelection" + grid.ID] as List<int>;

            if (productsIdSel == null)
                productsIdSel = new List<int>();

            //
            // se cruzan todos los registros de la pagina actual del gridview con la lista de seleccionados,
            // si algun item de esa pagina fue marcado previamente no se devuelve
            //
            productsIdSel = (from item in productsIdSel
                             join item2 in grid.Rows.Cast<GridViewRow>()
                                on item equals Convert.ToInt32(grid.DataKeys[item2.RowIndex].Value is DBNull ? -999 : grid.DataKeys[item2.RowIndex].Value) into g
                             where !g.Any()
                             select item).ToList();

            //
            // se agregan los seleccionados
            //
            productsIdSel.AddRange(checkedProd);

            HttpContext.Current.Session["ProdSelection" + grid.ID] = productsIdSel;




        }


        //LLAMARLAS ASÍ:

        // En el IndexChanging o en el click de tu boton de avance de pagina, llamas a KeepSelection (en definitiva, justo antes del rebind)

        //Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        //    KeepSelection(sender)
        //    GridView1.PageIndex = e.NewPageIndex
        //    Rebind()
        //End Sub


        //Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        //    RestoreSelection(sender)
        //End Sub





        public static void RestoreSelection(GridView grid)
        {

            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged


            List<int> productsIdSel = HttpContext.Current.Session["ProdSelection" + grid.ID] as List<int>;

            if (productsIdSel == null)
                return;

            //
            // se comparan los registros de la pagina del grid con los recuperados de la Session
            // los coincidentes se devuelven para ser seleccionados
            //
            List<GridViewRow> result = (from item in grid.Rows.Cast<GridViewRow>()
                                        join item2 in productsIdSel
                                        on Convert.ToInt32(grid.DataKeys[item.RowIndex].Value is DBNull ? -888 : grid.DataKeys[item.RowIndex].Value) equals item2 into g
                                        where g.Any()
                                        select item).ToList();



            //
            // se recorre cada item para marcarlo
            //
            result.ForEach(x => ((CheckBox)x.FindControl("CheckBox1")).Checked = true);

        }




        public static void RestoreUnselection(GridView grid)
        {

            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged
            //llamarla en el evento PageIndexChanged


            List<int> productsIdSel = HttpContext.Current.Session["ProdSelection" + grid.ID] as List<int>;

            if (productsIdSel == null)
                return;

            //
            // se comparan los registros de la pagina del grid con los recuperados de la Session
            // los coincidentes se devuelven para ser seleccionados
            //
            List<GridViewRow> result = (from item in grid.Rows.Cast<GridViewRow>()
                                        join item2 in productsIdSel
                                        on Convert.ToInt32(grid.DataKeys[item.RowIndex].Value is DBNull ? -888 : grid.DataKeys[item.RowIndex].Value) equals item2 into g
                                        where g.Any()
                                        select item).ToList();



            //
            // se recorre cada item para marcarlo
            //
            //foreach r in grid.Rows
            //{

            //}


            result.ForEach(x => ((CheckBox)x.FindControl("CheckBox1")).Checked = false);

        }




        //public class FuncionesUIWebCSharpViewState
        //{

        //   // Listing 1: ViewState Machine Hash Disabled

        //machine.config or web.config: <pages enableViewStateMac='false' />
        //page level directive:         <%@Page enableViewStateMac='false' %>
        //page level script code:       Page.EnableViewStateMac = false;
        //Listing 2: ViewState Encryption is Enabled

        //machine.config: <machineKey validation='3DES' validationKey='*' />
        //where the validationKey must be the same across a web-farm setup
        //also requires the enableViewStateMac property setting to be true
        //Listing 3: ViewState Saved in Session State

        //protected override object LoadPageStateFromPersistenceMedium()
        //{
        //    return Session["ViewState"]; 


        //}

        //protected override void SavePageStateToPersistenceMedium(object viewState)
        //{
        //    Session["ViewState"] = viewState;
        //    // Bug requires Hidden Form Field __VIEWSTATE
        //    RegisterHiddenField("__VIEWSTATE", "");
        //}
        ////Listing 4: ViewState Saved in Custom Store

        //protected override object LoadPageStateFromPersistenceMedium()
        //{
        //    LosFormatter format = new LosFormatter();
        //    return format.Deserialize(YourDataStore["ViewState"]);
        //}

        //protected override void SavePageStateToPersistenceMedium(object viewState)
        //{
        //    LosFormatter format = new LosFormatter();
        //    StringWriter writer = new StringWriter();
        //    format.Serialize(writer, viewState);
        //    YourDataStore["ViewState"] = writer.ToString();
        //}



        //protected override void SavePageStateToPersistenceMedium(object viewState)
        //{
        //    // Call Base Method to Not Change Normal Process
        //    base.SavePageStateToPersistenceMedium(viewState);
        //    // Retrieve ViewState and Write Out to Page
        //    LosFormatter format = new LosFormatter();
        //    StringWriter writer = new StringWriter();
        //    format.Serialize(writer, viewState);
        //    string vsRaw = writer.ToString();
        //    Response.Write("ViewState Raw: " + Server.HtmlEncode(vsRaw));
        //    // Decode ViewState and Write Out to Page
        //    byte[] buffer = Convert.FromBase64String(vsRaw);
        //    string vsText = Encoding.ASCII.GetString(buffer);
        //    Response.Write("ViewState Text: " + Server.HtmlEncode(vsText));
        //    // Parse ViewState -- Turn On Page Tracing
        //    ParseViewState(viewState, 0);
        //}

        //private void ParseViewState(object vs, int level)
        //{
        //    if (vs == null)
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "null");
        //    }
        //    else if (vs.GetType() == typeof(System.Web.UI.Triplet))
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "Triplet");
        //        ParseViewState((Triplet)vs, level);
        //    }
        //    else if (vs.GetType() == typeof(System.Web.UI.Pair))
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "Pair");
        //        ParseViewState((Pair)vs, level);
        //    }
        //    else if (vs.GetType() == typeof(System.Collections.ArrayList))
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "ArrayList");
        //        ParseViewState((IEnumerable)vs, level);
        //    }
        //    else if (vs.GetType().IsArray)
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "Array");
        //        ParseViewState((IEnumerable)vs, level);
        //    }
        //    else if (vs.GetType() == typeof(System.String))
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + "'" + vs.ToString() + "'");
        //    }
        //    else if (vs.GetType().IsPrimitive)
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + vs.ToString());
        //    }
        //    else
        //    {
        //        Trace.Warn(level.ToString(), Spaces(level) + vs.GetType().ToString());
        //    }
        //}

        //private void ParseViewState(Triplet vs, int level)
        //{
        //    ParseViewState(vs.First, level + 1);
        //    ParseViewState(vs.Second, level + 1);
        //    ParseViewState(vs.Third, level + 1);
        //}

        //private void ParseViewState(Pair vs, int level)
        //{
        //    ParseViewState(vs.First, level + 1);
        //    ParseViewState(vs.Second, level + 1);
        //}

        //private void ParseViewState(IEnumerable vs, int level)
        //{
        //    foreach (object item in vs)
        //    {
        //        ParseViewState(item, level + 1);
        //    }
        //}

        //private string Spaces(int count)
        //{
        //    string spaces = "";
        //    for (int index = 0; index < count; index++)
        //    {
        //        spaces += "   ";
        //    }
        //    return spaces;
        //}

        //

        // http://stackoverflow.com/questions/2169157/linq-to-dataset-handling-null-values

        //public static DataTable ToDataTable2<T>(this IEnumerable<T> items) { 
        //    DataTable table = new DataTable(typeof(T).Name);
        //    PropertyInfo[] props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance); 

        //    foreach (var prop in props) {
        //        Type propType = prop.PropertyType;

        //        // Is it a nullable type? Get the underlying type
        //        if (propType.IsGenericType && propType.GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
        //            propType = new System.ComponentModel.NullableConverter(propType).UnderlyingType; 

        //        table.Columns.Add(prop.Name, propType);
        //    } 

        //    foreach (var item in items) { 
        //        var values = new object[props.Length]; 
        //        for (var i = 0; i < props.Length; i++)
        //            values[i] = props[i].GetValue(item, null);  

        //        table.Rows.Add(values); 
        //    }

        //    return table;
        //}







    }

}

namespace ProntoCSharp2
{
    //public class FuncionesUIWebCSharp2
    //{
    //    public static DataSet ToDataSet<T>(this IList<T> list)
    //    {
    //        Type elementType = typeof(T);
    //        DataSet ds = new DataSet();
    //        DataTable t = new DataTable();
    //        ds.Tables.Add(t);

    //        //add a column to table for each public property on T
    //        foreach (var propInfo in elementType.GetProperties())
    //        {
    //            Type ColType = Nullable.GetUnderlyingType(propInfo.PropertyType) ?? propInfo.PropertyType;

    //            t.Columns.Add(propInfo.Name, ColType);
    //        }

    //        //go through each property on T and add each value to the table
    //        foreach (T item in list)
    //        {
    //            DataRow row = t.NewRow();

    //            foreach (var propInfo in elementType.GetProperties())
    //            {
    //                row[propInfo.Name] = propInfo.GetValue(item, null) ?? DBNull.Value;
    //            }

    //            t.Rows.Add(row);
    //        }

    //        return ds;
    //    }
    //}



}