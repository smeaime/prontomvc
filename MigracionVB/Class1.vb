
Option Explicit On

Option Infer On

Imports System.Data.OleDb

Imports System.Reflection
Imports System
Imports System.Web
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports System.Data.Linq 'lo necesita el CompileQuery?
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.DataSetExtensions
Imports Microsoft.Reporting.WebForms
Imports System.IO

Imports System.Data.SqlClient

Imports ProntoMVC.Data

Imports System.Web.Security
Imports System.Security

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

Imports ClaseMigrar.SQLdinamico

Imports System.Drawing
'Namespace Pronto.ERP.Bll

Imports System.Collections.Generic


Imports System.Data.Entity.SqlServer

Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools
Imports DocumentFormat.OpenXml.Drawing.Wordprocessing

Imports System.Web.UI.WebControls

Imports Word = Microsoft.Office.Interop.Word
Imports Excel = Microsoft.Office.Interop.Excel

Imports ProntoMVC.Data.Models


Imports System.Net
'Imports System.Configuration
'Imports System.Web.Security

Imports Inlite.ClearImageNet


Imports CartaDePorteManager
Imports CDPMailFiltrosManager2

Imports LogicaImportador.FormatosDeExcel





Public Class Class1


    Public Shared Function ImportacionComprobantesFondoFijo2(dt As DataTable, SC As String, mArchivo As String, mFechaRecepcion As Date, mNumeroReferencia As Integer, mIdPuntoVenta As Integer) As String


        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '        'parametros de entrada
        '        'mArchivo = .FileBrowser1(0).text
        '        'mFechaRecepcion = .DTFields(0).Value
        '        'mNumeroReferencia = Val(.Text1.text)
        '        'If IsNumeric(.dcfields(0).BoundText) Then mIdPuntoVenta = .dcfields(0).BoundText


        'globales que tomaba esta funcion. mover a globales del servicio
        Dim gblFechaUltimoCierre As Date
        Dim glbIdMonedaDolar As Integer
        Dim glbIdUsuario As Integer
        Dim glbPuntoVentaEnNumeroInternoCP As Boolean
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////



        'Dim oAp ' As ComPronto.Aplicacion
        Dim oCP As ProntoMVC.Data.Models.ComprobanteProveedor
        'Dim oPr ' As ComPronto.Proveedor
        'Dim oPar ' As ComPronto.Parametro
        'Dim oOP 'As ComPronto.OrdenPago
        Dim oRsAux1 As DataTable
        Dim oRsAux2 As DataTable 'As ADOR.Recordset
        'Dim oForm 'As Form
        'Dim oEx As Excel.Application

        Dim mOk As Boolean, mConProblemas As Boolean, mTomarCuentaDePresupuesto As Boolean
        Dim mComprobante As String, mCuit As String, mLetra As String, mBienesOServicios As String, mObservaciones As String, mRazonSocial As String
        Dim mIncrementarReferencia As String, mCondicionCompra As String, mCodProv As String, mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
        Dim mInformacionAuxiliar As String, mCuitDefault As String, mCodigoCuentaGasto As String, mTipo As String, mItemPresupuestoObrasNodo As String, mMensaje As String
        Dim mActividad As String, mCuitPlanilla As String, mPuntosVentaAsociados As String, mNumeroCAE As String
        Dim mFechaFactura As Date, mFechaVencimientoCAI As Date
        Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer, mIdUnidadPorUnidad As Integer, fl As Integer, mContador As Integer, mIdCuentaIvaCompras1 As Integer
        Dim i As Integer, mIdUO As Integer, mvarProvincia As Integer, mIdTipoComprobante As Integer, mIdCodigoIva As Integer, mvarIBCondicion As Integer, mvarIdIBCondicion As Integer
        Dim mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer, mvarPosicionCuentaIva As Integer
        Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long, mCodigoCuenta As Long, mCodigoCuentaFF As Long, mNumeroOP As Long
        Dim mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long, mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long, mCodigoCuenta1 As Long, mIdCuentaFF As Long
        Dim mIdCuentaGasto As Long, mIdPresupuestoObrasNodo As Long, mIdRubroContable As Long, mIdActividad As Long
        Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
        Dim mTotalItem As Double, mIVA1 As Double, mGravado As Double, mNoGravado As Double, mTotalBruto As Double, mTotalIva1 As Double, mTotalComprobante As Double, mTotalPercepcion As Double
        Dim mTotalAjusteIVA As Double, mAjusteIVA As Double, mBruto As Double, mPercepcion As Double, mCantidad As Double
        Dim mIdCuentaIvaCompras(10) As Long
        Dim mIVAComprasPorcentaje(10) As Single
        Dim mAux





        'On Error GoTo Mal

        mPuntosVentaAsociados = ""
        If glbPuntoVentaEnNumeroInternoCP Then
            oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Empleados_TX_PorId, glbIdUsuario)
            If oRsAux1.Rows.Count > 0 Then mPuntosVentaAsociados = IIf(IsNull(oRsAux1.Rows(0).Item("PuntosVentaAsociados")), "", oRsAux1.Rows(0).Item(".PuntosVentaAsociados"))
            oRsAux1 = Nothing
            If Len(mPuntosVentaAsociados) = 0 Then
                Throw New Exception("No tiene asignados puntos de venta para incorporar a los comprobantes importados")
            End If
        End If



        'oForm = New frmPathPresto
        'With oForm
        '    .Id = 14
        '    .Show vbModal
        '      mOk = .Ok
        '    If mOk Then
        '        mArchivo = .FileBrowser1(0).text
        '        mFechaRecepcion = .DTFields(0).Value
        '        mNumeroReferencia = Val(.Text1.text)
        '        If IsNumeric(.dcfields(0).BoundText) Then mIdPuntoVenta = .dcfields(0).BoundText
        '    End If
        'End With
        'Unload oForm
        '   oForm = Nothing




        'If Not mOk Then Exit Sub

        'If glbPuntoVentaEnNumeroInternoCP And mIdPuntoVenta = 0 Then
        '    MsgBox "Debe elegir un punto de venta", vbExclamation
        '    Return
        'End If

        'oAp = Aplicacion

        mIncrementarReferencia = EntidadManager.BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes", SC, -1)
        mCondicionCompra = EntidadManager.BuscarClaveINI("Condicion de compra default para fondos fijos", SC, -1)
        mFecha1 = EntidadManager.BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo", SC, -1)
        mCuitDefault = EntidadManager.BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos", SC, -1)

        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)
        'oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
        mIdMonedaPesos = p.p(ParametroManager.ePmOrg.IdMoneda)
        mIdTipoComprobanteFacturaCompra = p.p(ParametroManager.ePmOrg.IdTipoComprobanteFacturaCompra)
        mIdUnidadPorUnidad = IIf(IsNull(p.p(ParametroManager.ePmOrg.IdUnidadPorUnidad)), 0, p.p(ParametroManager.ePmOrg.IdUnidadPorUnidad))
        gblFechaUltimoCierre = IIf(IsNull(p.p(ParametroManager.ePmOrg.FechaUltimoCierre)), DateSerial(1980, 1, 1), p.p(ParametroManager.ePmOrg.FechaUltimoCierre))

        'For i = 1 To 10
        '    If Not IsNull(oRsAux1.IdCuentaIvaCompras" & i).Value) Then
        '        mIdCuentaIvaCompras(i) = oRsAux1.IdCuentaIvaCompras" & i).Value Then '
        '        mIVAComprasPorcentaje(i) = oRsAux1.IVAComprasPorcentaje" & i).Value
        '    Else
        '        mIdCuentaIvaCompras(i) = 0
        '        mIVAComprasPorcentaje(i) = 0
        '    End If
        'Next
        'oRsAux1=nothing

        mTomarCuentaDePresupuesto = False
        mAux = ParametroManager.TraerValorParametro2(SC, "TomarCuentaDePresupuestoEnComprobantesProveedores")
        If Not IsNull(mAux) And mAux = "SI" Then mTomarCuentaDePresupuesto = True






        fl = 7
        mContador = 0
        mNumeroRendicion = 0
        mIdCuentaFF = 0



        Dim oForm_Label1 As String



        Using s As New ServicioMVC.servi(SC)

            Do While True


                If Len(Trim(dt.Rows(fl).Item(2))) > 0 Or Len(Trim(dt.Rows(fl).Item(3))) > 0 Or Len(Trim(dt.Rows(fl).Item(4))) > 0 Or
                         Len(Trim(dt.Rows(fl).Item(5))) > 0 Or Len(Trim(dt.Rows(fl).Item(9))) > 0 Or Len(Trim(dt.Rows(fl).Item(10))) > 0 Then
                    mConProblemas = False

                    If mNumeroRendicion = 0 And IsNumeric(dt.Rows(2).Item(16)) Then mNumeroRendicion = dt.Rows(2).Item(16)
                    mContador = mContador + 1

                    'oForm.Label2 = "Comprobante  " & dt.Rows(fl).Item(8)
                    'oForm.Label3 = "" & mContador
                    'DoEvents

                    mTipo = dt.Rows(fl).Item(4)
                    If Len(dt.Rows(fl).Item(5)) > 0 Then
                        oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mIdTipoComprobante " & dt.Rows(fl).Item(5)
                        mIdTipoComprobante = dt.Rows(fl).Item(5)
                    Else
                        mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
                    End If
                    mLetra = Trim(dt.Rows(fl).Item(6))
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mNumeroComprobante1 " & dt.Rows(fl).Item(7)
                    mNumeroComprobante1 = dt.Rows(fl).Item(7)
                    If mNumeroComprobante1 > 9999 Then
                        mError = mError & vbCrLf & "Fila " & fl & "  - El punto de venta no puede tener mas de 4 digitos."
                        fl = fl + 1
                        Continue Do ' GoTo FinLoop
                    End If
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mNumeroComprobante2 " & dt.Rows(fl).Item(8)
                    mNumeroComprobante2 = dt.Rows(fl).Item(8)
                    If mNumeroComprobante2 > 99999999 Then
                        mError = mError & vbCrLf & "Fila " & fl & "  - El numero de comprobante no puede tener mas de 8 digitos."
                        fl = fl + 1
                        Continue Do ' GoTo FinLoop
                    End If
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mRazonSocial " & dt.Rows(fl).Item(9)
                    mRazonSocial = Mid(dt.Rows(fl).Item(9), 1, 50)
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mCuit " & dt.Rows(fl).Item(10)
                    mCuitPlanilla = dt.Rows(fl).Item(10)
                    mCuit = mCuitPlanilla
                    If Len(mCuit) <> 13 Then
                        If Len(mCuit) = 11 Then
                            ' mCuit = VBA.mId(mCuit, 1, 2) & "-" & VBA.mId(mCuit, 3, 8) & "-" & VBA.mId(mCuit, 11, 1)
                        Else
                            mCuit = ""
                        End If
                    End If
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mFechaFactura " & dt.Rows(fl).Item(3)
                    mFechaFactura = CDate(dt.Rows(fl).Item(3))
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mNumeroCAI " & dt.Rows(fl).Item(18)
                    mNumeroCAI = dt.Rows(fl).Item(18)
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mFechaVencimientoCAI " & dt.Rows(fl).Item(19)
                    If IsDate(dt.Rows(fl).Item(19)) Then
                        mFechaVencimientoCAI = CDate(dt.Rows(fl).Item(19))
                    Else
                        mFechaVencimientoCAI = Date.MinValue
                    End If
                    If mFecha1 = "SI" Then mFechaRecepcion = mFechaFactura
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mCodObra " & dt.Rows(fl).Item(2)
                    mCodObra = Trim(dt.Rows(fl).Item(2))

                    mActividad = Trim(dt.Rows(fl).Item(23))
                    oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mNumeroCAE " & dt.Rows(fl).Item(24)
                    mNumeroCAE = dt.Rows(fl).Item(24)

                    If mIdCuentaFF = 0 Then
                        If Len(dt.Rows(2).Item(10)) = 0 Then
                            Throw New Exception("Debe definir la cuenta del fondo fijo")
                        End If
                        oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mCodigoCuentaFF " & dt.Rows(2).Item(10)
                        mCodigoCuentaFF = Val(dt.Rows(2).Item(10))
                        oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Cuentas_TX_PorCodigo, mCodigoCuentaFF)
                        If oRsAux1.Rows.Count > 0 Then
                                mIdCuentaFF = oRsAux1.Rows(0).Item(0).Value
                            Else
                            mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") & "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", cuenta de fondo fijo inexistente"
                            fl = fl + 1
                            Continue Do ' GoTo FinLoop
                        End If
                        oRsAux1 = Nothing
                    End If

                    mIdObra = 0
                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "Obras_TX_PorNumero", mCodObra)
                    If oRsAux1.Rows.Count > 0 Then
                            mIdObra = oRsAux1.Rows(0).Item("IdObra")
                        Else
                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") & "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Obra " & mCodObra & " inexistente"
                        fl = fl + 1
                        Continue Do ' GoTo FinLoop
                    End If
                    oRsAux1 = Nothing

                    If mFechaRecepcion > gblFechaUltimoCierre Then
                        If Len(mCuit) = 0 Then mCuit = mCuitDefault
                        If Len(mCuit) = 0 Then
                            '                       comentado
                        Else
                            If Not FuncionesGenericasCSharp.CUITValido(mCuit) Then
                                mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") & "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Cuit invalido  " & mCuit
                                fl = fl + 1
                                Continue Do ' GoTo FinLoop
                            End If
                        End If

                        mIdActividad = 0
                        If Len(mActividad) > 0 Then
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, "ActividadesProveedores_TX_PorDescripcion", mActividad)
                            If oRsAux1.Rows.Count > 0 Then mIdActividad = oRsAux1.Rows(0).Item(0).Value
                            oRsAux1 = Nothing
                        End If

                        mIdProveedor = 0
                        If Len(mCuit) > 0 Then
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, enumSPs.Proveedores_TX_PorCuit, mCuit)
                        Else
                            oRsAux1 = EntidadManager.TraerFiltrado(SC, "Proveedores_TX_PorNombre", mRazonSocial)
                        End If
                        If oRsAux1.Rows.Count > 0 Then
                            mIdProveedor = oRsAux1.Rows(0).Item(0).Value
                            mvarProvincia = If(oRsAux1.Rows(0).Item("IdProvincia"), 0)
                            mvarIBCondicion = If(oRsAux1.Rows(0).Item("IBCondicion"), 0)
                            mvarIdIBCondicion = If(oRsAux1.Rows(0).Item("IdIBCondicionPorDefecto"), 0)
                            mvarIGCondicion = If(oRsAux1.Rows(0).Item("IGCondicion"), 0)
                            mvarIdTipoRetencionGanancia = If(oRsAux1.Rows(0).Item("IdTipoRetencionGanancia"), 0)
                            mBienesOServicios = If(oRsAux1.Rows(0).Item(".BienesOServicios"), "B")
                            mIdCodigoIva = If(oRsAux1.Rows(0).Item("IdCodigoIva"), 0)
                            If mIdActividad > 0 And mIdActividad <> If(oRsAux1.Rows(0).Item(".IdActividad"), 0) Then



                                Dim oPr = New ProntoMVC.Data.Models.Proveedor()
                                With oPr
                                    .IdActividad = mIdActividad
                                End With
                                s.Grabar_Proveedor(oPr, glbIdUsuario) '                            oPr.Guardar
                                oPr = Nothing




                            End If
                        Else
                            If Len(mCuit) > 0 Then
                                If mLetra = "C" Then
                                    mIdCodigoIva = 6
                                Else
                                    mIdCodigoIva = 1
                                End If
                            Else
                                mIdCodigoIva = 5
                            End If


                            Dim oPr = New ProntoMVC.Data.Models.Proveedor() '= oAp.Proveedores.Item(-1)
                            With oPr
                                .Confirmado = "NO"
                                .RazonSocial = Mid(mRazonSocial, 1, 50)
                                .Cuit = mCuit
                                .EnviarEmail = 1
                                If mIdCodigoIva <> 0 Then .IdCodigoIva = mIdCodigoIva
                                If IsNumeric(mCondicionCompra) Then .IdCondicionCompra = CInt(mCondicionCompra)
                                If mIdActividad <> 0 Then .IdActividad = mIdActividad
                            End With
                            s.Grabar_Proveedor(oPr, glbIdUsuario) '                            oPr.Guardar
                            mIdProveedor = oPr.IdProveedor
                            oPr = Nothing



                            mvarProvincia = 0
                            mvarIBCondicion = 0
                            mvarIdIBCondicion = 0
                            mvarIGCondicion = 0
                            mvarIdTipoRetencionGanancia = 0
                            mBienesOServicios = "B"
                        End If
                        oRsAux1 = Nothing



                        oRsAux1 = EntidadManager.TraerFiltrado(SC, "ComprobantesProveedores_TX_PorNumeroComprobante", mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante)
                        If oRsAux1.Rows.Count = 0 Then
                            mvarCotizacionDolar = Cotizacion(SC, mFechaFactura, glbIdMonedaDolar)
                            If mvarCotizacionDolar = 0 Then mConProblemas = True




                            oCP = New ProntoMVC.Data.Models.ComprobanteProveedor                   'oCP = oAp.ComprobantesProveedores.Item(-1)
                            With oCP

                                .IdTipoComprobante = mIdTipoComprobante
                                .IdObra = mIdObra
                                .FechaComprobante = mFechaFactura
                                If mFechaFactura > mFechaRecepcion Then
                                    .FechaRecepcion = mFechaFactura
                                Else
                                    .FechaRecepcion = mFechaRecepcion
                                End If
                                .FechaVencimiento = mFechaFactura
                                .FechaAsignacionPresupuesto = mFechaFactura
                                .IdMoneda = mIdMonedaPesos
                                .CotizacionMoneda = 1
                                .CotizacionDolar = mvarCotizacionDolar
                                .IdProveedorEventual = mIdProveedor
                                .IdProveedor = Nothing
                                .IdCuenta = mIdCuentaFF
                                .IdOrdenPago = Nothing
                                .Letra = mLetra
                                .NumeroComprobante1 = mNumeroComprobante1
                                .NumeroComprobante2 = mNumeroComprobante2
                                .NumeroRendicionFF = mNumeroRendicion
                                If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                                    .IdIBCondicion = mvarIdIBCondicion
                                Else
                                    .IdIBCondicion = Nothing
                                End If
                                If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                                    .IdTipoRetencionGanancia = mvarIdTipoRetencionGanancia
                                Else
                                    .IdTipoRetencionGanancia = Nothing
                                End If
                                .IdProvinciaDestino = mvarProvincia
                                .BienesOServicios = Nothing
                                .NumeroCAI = mNumeroCAI
                                If mFechaVencimientoCAI <> Date.MinValue Then
                                    .FechaVencimientoCAI = mFechaVencimientoCAI
                                Else
                                    .FechaVencimientoCAI = Nothing
                                End If
                                .DestinoPago = "O"
                                .InformacionAuxiliar = mInformacionAuxiliar
                                If mIdCodigoIva <> 0 Then .IdCodigoIva = mIdCodigoIva
                                .CircuitoFirmasCompleto = "SI"
                                If mIdPuntoVenta <> 0 Then .IdPuntoVenta = mIdPuntoVenta
                                If Len(mNumeroCAE) > 0 Then .NumeroCAE = mNumeroCAE
                            End With








                            mTotalBruto = 0
                            mTotalIva1 = 0
                            mTotalPercepcion = 0
                            mTotalComprobante = 0
                            mTotalAjusteIVA = 0
                            mAjusteIVA = 0

                            Do While Len(Trim(dt.Rows(fl).Item(2))) > 0 And mLetra = Trim(dt.Rows(fl).Item(6)) And mNumeroComprobante1 = dt.Rows(fl).Item(7) And mNumeroComprobante2 = dt.Rows(fl).Item(8) And
                                  (mCuit = dt.Rows(fl).Item(10) Or mCuitPlanilla = dt.Rows(fl).Item(10) Or mCuit = mCuitDefault)
                                mCodigoCuentaGasto = dt.Rows(fl).Item(22)
                                mItemPresupuestoObrasNodo = Trim(dt.Rows(fl).Item(24))
                                mCantidad = Val(dt.Rows(fl).Item(25))

                                mIdCuentaGasto = 0
                                mIdCuenta = 0
                                mCodigoCuenta = 0
                                mIdRubroContable = 0
                                If Len(mCodigoCuentaGasto) > 0 Then
                                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "CuentasGastos_TX_PorCodigo2", mCodigoCuentaGasto)
                                    If oRsAux1.Rows.Count > 0 Then
                                        mIdCuentaGasto = oRsAux1.Rows(0).Item("IdCuentaGasto")
                                        oRsAux1 = Nothing
                                        oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorObraCuentaGasto", mIdObra, mIdCuentaGasto)
                                        If oRsAux1.Rows.Count > 0 Then
                                            mIdCuenta = oRsAux1.Rows(0).Item("IdCuenta")
                                            mCodigoCuenta = oRsAux1.Rows(0).Item("Codigo")
                                            mIdRubroContable = If(oRsAux1.Rows(0).Item("IdRubroForminanciero"), 0)
                                            If mIdRubroContable = 0 And Not IsNull(oRsAux1.Rows(0).Item("CodigoRubroContable")) Then
                                                oRsAux2 = EntidadManager.TraerFiltrado(SC, "RubrosContables_TX_PorCodigo", oRsAux1.Rows(0).Item("CodigoRubroContable"), mIdObra, "SI")
                                                If oRsAux2.Rows.Count > 0 Then mIdRubroContable = oRsAux2.Rows(0).Item(0).Value
                                                oRsAux2 = Nothing
                                            End If
                                        Else
                                            If Not mTomarCuentaDePresupuesto Then
                                                mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") &
                                                        "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Cuenta de gasto codigo " & mCodigoCuentaGasto & " inexistente"
                                                fl = fl + 1
                                                Continue Do ' GoTo FinLoop
                                            End If
                                        End If
                                    Else
                                        oRsAux1 = Nothing
                                        oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorCodigo", mCodigoCuentaGasto)
                                        If oRsAux1.Rows.Count > 0 Then
                                            mIdCuenta = oRsAux1.Rows(0).Item("IdCuenta")
                                            mCodigoCuenta = oRsAux1.Rows(0).Item("Codigo")
                                            mIdRubroContable = If(oRsAux1.Rows(0).Item(".IdRubroForminanciero"), 0)
                                            If mIdRubroContable = 0 And Not IsNull(oRsAux1.Rows(0).Item("CodigoRubroContable")) Then
                                                oRsAux2 = EntidadManager.TraerFiltrado(SC, "RubrosContables_TX_PorCodigo", oRsAux1.Rows(0).Item("CodigoRubroContable"), mIdObra, "SI")
                                                If oRsAux2.Rows.Count > 0 Then mIdRubroContable = oRsAux2.Rows(0).Item(0).Value
                                                oRsAux2 = Nothing
                                            End If
                                        Else
                                            If Not mTomarCuentaDePresupuesto Then
                                                mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") &
                                                     "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Cuenta contable inexistente"
                                                fl = fl + 1
                                                Continue Do ' GoTo FinLoop
                                            End If
                                        End If
                                    End If
                                    oRsAux1 = Nothing
                                End If

                                mIdPresupuestoObrasNodo = 0
                                If Len(mItemPresupuestoObrasNodo) > 0 Then
                                    oRsAux1 = EntidadManager.TraerFiltrado(SC, "PresupuestoObrasNodos_TX_PorItem", mItemPresupuestoObrasNodo, mIdObra)
                                    If oRsAux1.Rows.Count = 1 Then
                                        mIdPresupuestoObrasNodo = oRsAux1.Rows(0).Item("IdPresupuestoObrasNodo")
                                        If If(oRsAux1.Rows(0).Item("IdCuenta"), 0) > 0 Then
                                            mIdCuenta = If(oRsAux1.Rows(0).Item("IdCuenta"), 0)
                                        End If
                                    End If
                                    oRsAux1 = Nothing
                                End If

                                oRsAux1 = EntidadManager.TraerFiltrado(SC, "Cuentas_TX_PorId", mIdCuenta)
                                If oRsAux1.Rows.Count > 0 Then
                                    If If(oRsAux1.Rows(0).Item("ImputarAPresupuestoDeObra"), "NO") = "NO" And Not mTomarCuentaDePresupuesto Then
                                        mIdPresupuestoObrasNodo = 0
                                    End If
                                    mCodigoCuenta = oRsAux1.Rows(0).Item("Codigo")
                                    If If(oRsAux1.Rows(0).Item("IdRubroForminanciero"), 0) > 0 Then
                                        mIdRubroContable = oRsAux1.Rows(0).Item("IdRubroForminanciero")
                                    End If
                                Else
                                    mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") & "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Cuenta contable inexistente"
                                    fl = fl + 1
                                    Continue Do ' GoTo FinLoop
                                End If
                                oRsAux1 = Nothing

                                oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mBruto " & dt.Rows(fl).Item(13)
                                mBruto = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows(fl).Item(13))))
                                oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mIva1 " & dt.Rows(fl).Item(14)
                                mIVA1 = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows(fl).Item(14))), 4)
                                oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mPercepcion " & dt.Rows(fl).Item(15)
                                mPercepcion = Math.Abs(Convert.ToDouble(CDbl(dt.Rows(fl).Item(15))))
                                oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mTotalItem " & dt.Rows(fl).Item(16)
                                mTotalItem = Math.Round(Math.Abs(Convert.ToDouble(dt.Rows(fl).Item(16))), 2)
                                mObservaciones = "Rendicion  " & mNumeroRendicion & vbCrLf & dt.Rows(fl).Item(20) & vbCrLf

                                mTotalBruto = mTotalBruto + mBruto
                                mTotalIva1 = mTotalIva1 + mIVA1
                                mTotalPercepcion = mTotalPercepcion + mPercepcion
                                mTotalComprobante = mTotalComprobante + mTotalItem
                                mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                                mPorcentajeIVA = 0
                                oForm_Label1 = mMensaje & vbCrLf & vbCrLf & "mPorcentajeIVA " & dt.Rows(fl).Item(11)
                                If mIVA1 <> 0 And mBruto <> 0 Then mPorcentajeIVA = dt.Rows(fl).Item(11)

                                mIdCuentaIvaCompras1 = 0
                                mvarPosicionCuentaIva = 1
                                If mPorcentajeIVA <> 0 Then
                                    For i = 1 To 10
                                        If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
                                            mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
                                            mvarPosicionCuentaIva = i
                                            Exit For
                                        End If
                                    Next
                                End If
                                If mIVA1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
                                    mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") & "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - No se encontro el porcentaje de iva " & mPorcentajeIVA
                                    fl = fl + 1
                                    Continue Do ' GoTo FinLoop
                                End If






                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////
                                '//////////////////////////////////////////////////////////////////////////


                                Dim oCPdet = New ProntoMVC.Data.Models.DetalleComprobantesProveedore
                                oCP.DetalleComprobantesProveedores.Add(oCPdet)
                                With oCPdet

                                    .IdObra = mIdObra
                                    .IdCuentaGasto = mIdCuentaGasto
                                    .IdCuenta = mIdCuenta
                                    .CodigoCuenta = mCodigoCuenta
                                    .Importe = mBruto
                                    .IdCuentaIvaCompras1 = Nothing
                                    .IVAComprasPorcentaje1 = 0
                                    .ImporteIVA1 = 0
                                    .AplicarIVA1 = "NO"
                                    .IdCuentaIvaCompras2 = Nothing
                                    .IVAComprasPorcentaje2 = 0
                                    .ImporteIVA2 = 0
                                    .AplicarIVA2 = "NO"
                                    .IdCuentaIvaCompras3 = Nothing
                                    .IVAComprasPorcentaje3 = 0
                                    .ImporteIVA3 = 0
                                    .AplicarIVA3 = "NO"
                                    .IdCuentaIvaCompras4 = Nothing
                                    .IVAComprasPorcentaje4 = 0
                                    .ImporteIVA4 = 0
                                    .AplicarIVA4 = "NO"
                                    .IdCuentaIvaCompras5 = Nothing
                                    .IVAComprasPorcentaje5 = 0
                                    .ImporteIVA5 = 0
                                    .AplicarIVA5 = "NO"
                                    .IdCuentaIvaCompras6 = Nothing
                                    .IVAComprasPorcentaje6 = 0
                                    .ImporteIVA6 = 0
                                    .AplicarIVA6 = "NO"
                                    .IdCuentaIvaCompras7 = Nothing
                                    .IVAComprasPorcentaje7 = 0
                                    .ImporteIVA7 = 0
                                    .AplicarIVA7 = "NO"
                                    .IdCuentaIvaCompras8 = Nothing
                                    .IVAComprasPorcentaje8 = 0
                                    .ImporteIVA8 = 0
                                    .AplicarIVA8 = "NO"
                                    .IdCuentaIvaCompras9 = Nothing
                                    .IVAComprasPorcentaje9 = 0
                                    .ImporteIVA9 = 0
                                    .AplicarIVA9 = "NO"
                                    .IdCuentaIvaCompras10 = Nothing
                                    .IVAComprasPorcentaje10 = 0


                                    If mIdCuentaIvaCompras1 <> 0 Then

                                        CallByName(oCPdet, "IdCuentaIvaCompras" & mvarPosicionCuentaIva, CallType.Set, mIdCuentaIvaCompras1)
                                        CallByName(oCPdet, "IVAComprasPorcentaje" & mvarPosicionCuentaIva, CallType.Set, mPorcentajeIVA)
                                        CallByName(oCPdet, "ImporteIVA" & mvarPosicionCuentaIva, CallType.Set, Math.Round(mIVA1, 2))
                                        CallByName(oCPdet, "AplicarIVA" & mvarPosicionCuentaIva, CallType.Set, "SI")
                                    End If


                                    .ImporteIVA10 = 0
                                    .AplicarIVA10 = "NO"
                                    If mIdPresupuestoObrasNodo <> 0 Then .IdPresupuestoObrasNodo = mIdPresupuestoObrasNodo
                                    If mIdRubroContable > 0 Then .IdRubroContable = mIdRubroContable
                                    .Cantidad = mCantidad
                                End With




                                fl = fl + 1
                            Loop

                            With oCP
                                .NumeroReferencia = mNumeroReferencia
                                .Confirmado = "NO"
                                .TotalBruto = mTotalBruto
                                .TotalIva1 = mTotalIva1
                                .TotalIva2 = 0
                                .TotalBonificacion = 0
                                .TotalComprobante = mTotalComprobante
                                .PorcentajeBonificacion = 0
                                .TotalIvaNoDiscriminado = 0
                                .AjusteIVA = mTotalAjusteIVA
                                .Observaciones = mObservaciones
                                If mIncrementarReferencia <> "SI" Then .AutoincrementarNumeroReferencia = "NO"
                            End With

                            s.Grabar_ComprobanteProveedor(oCP, glbIdUsuario)

                            '//////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////





                            mNumeroReferencia = mNumeroReferencia + 1
                        Else
                            fl = fl + 1
                        End If
                    Else
                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & mNumeroComprobante1.ToString.PadLeft(4, "0") &
                                  "-" & mNumeroComprobante2.ToString.PadLeft(8, "0") & ", fila " & fl & "  - Fecha es anterior al ultimo cierre contable : " & mComprobante
                        fl = fl + 1
                    End If
                Else
                    Exit Do
                End If
                'FinLoop:




            Loop


        End Using










    End Function




End Class
