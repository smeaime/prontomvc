Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data
Imports System.Diagnostics

Imports System.Linq
Imports System.IO
Imports System.Data.SqlClient
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Wordprocessing
Imports OpenXmlPowerTools

Imports OpenXML_Pronto


Imports ClaseMigrar.migrarFactura
Imports ClaseMigrar

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class FacturaManager
        Inherits ServicedComponent



        Shared Function SincroFacturacionAmaggi(ByVal SC As String, ByVal IdFactura As Long) As String

            'COLUMNA	CAMPO	TIPO	LONG	DESDE	HASTA	OBSERVACIONES
            '1	        Fecha de Descarga	S	8	1	8	Formato DDMMAAAA
            '2	        ";"	S	1	9	9	Separador
            '3	        Numero de Carta de Porte	N	14	10	23	
            '4	        ";"	S	1	24	24	Separador
            '5	        Peso Neto	N	10	25	34	
            '6	        ";"	S	1	35	35	Separador
            '7	        Importe	N	10	36	45	Formato 9.99
            '8	        ";"	S	1	46	46	Separador
            '9	        Numero da Factura	S	12	47	58	Formato 000000000000
            '10	        ";"	S	1	59	59	Separador
            '11	        Concepto	S	50	60	109	Ex. Furmigada

            Dim lista As Generic.List(Of CartasDePorte) = FacturaManager.CartasPorteImputadas(SC, IdFactura)


            Dim fac As Factura = FacturaManager.GetItem(SC, IdFactura, True)

            Const SEP = ","

            Dim o As String


            For Each cdp As CartasDePorte In lista

                o &= If(cdp.FechaDescarga, Date.Today).ToString("ddMMyyyy") & SEP
                o &= JustificadoDerecha(cdp.NumeroCartaDePorte, 14) & SEP
                o &= JustificadoDerecha(cdp.NetoFinal, 10) & SEP


                'como puedo averiguar la tarifa? -que sea el mismo articulo. Amaggi suele tener un solo renglon de items
                Dim itemfacturaimputado As FacturaItem = fac.Detalles.Where(Function(art) art.IdArticulo = cdp.IdArticulo).FirstOrDefault()


                o &= JustificadoDerecha(FF2((itemfacturaimputado.PrecioUnitarioTotal * If(cdp.NetoFinal, 0))), 10) & SEP



                o &= JustificadoDerecha(fac.PuntoVenta, 4, "0") + JustificadoDerecha(fac.Numero, 8, "0") & SEP



                o &= JustificadoIzquierda("Servicio de entregador", 50) ' concepto    C.FechaDescarga & ";" & vbCrLf

                o &= vbCrLf
            Next

            Return o

        End Function




        Public Shared Sub AnularFactura(ByVal SC As String, ByVal myFactura As Pronto.ERP.BO.Factura, ByVal IdAutorizaAnulacion As Long)




            'TODO: fer y edu me pidieron corregir esto!!!!
            'CtaCteDeudorManager..Fetch(idcomprobante,)
            'If CtaCteDeudorManager.importeoriginal <> CtaCteDeudorManager.Saldo Then
            '    'quizas tiene una nota de credito parcial asignada. no se puede anular así nomas
            '    ErrHandler.WriteAndRaiseError("La factura está parcialmente cancelada. No se puede anular")
            '    Exit Sub
            'End If


            If myFactura.Fecha <= ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.FechaUltimoCierre) Then
                '   es decir que la fecha de cierre contable actual lo que hace es no permitirte tocar nada de la contabilidad anterior a esa fecha
                ErrHandler.WriteAndRaiseError("La factura está parcialmente cancelada. No se puede anular")
                Exit Sub
            End If


            ClaseMigrar.AnularFacturaComPronto(SC, myFactura, IdAutorizaAnulacion)

            If Not InStr(myFactura.Observaciones, " -- NO LIBERAR CDPS -- ") > 0 Then
                'TODO: corregir para pasarle la session SESSIONPRONTO_Busqueda
                CartaPorteManagerAux.RefrescarAnulacionesyConsistenciaDeImputacionesEntreCDPyFacturasOnotasDeCredito(SC, "")
            End If
        End Sub

        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myFactura As Factura)
            With myFactura
                Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                'estos debieran ser READ only, no?
                .IdCodigoIva = ocli.IdCodigoIva
                .TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                .IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, .PuntoVenta, .TipoABC)
                .Numero = ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(SC, .IdCodigoIva, .PuntoVenta)
                '.Numero = ProximoNumeroFactura(SC, myFactura.IdPuntoVenta)
            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myFactura As Factura) As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            With myFactura
                Try


                    If True Then
                        'METODO NORMAL
                        Dim esNuevo As Boolean
                        If .Id = -1 Then esNuevo = True Else esNuevo = False

                        If esNuevo Then
                            RefrescarTalonario(SC, myFactura)
                            RecalcularTotales(SC, myFactura)
                        End If


                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////
                        'Incremento de número en capa de UI. Evitar.Fields("
                        'esto es lo que está mal. no tenés que aumentarlo si es una edicion! -pero si está idFactura=-1! sí, pero puedo ser una alta a partir de una copia
                        'cuando el usuario modifico manualmente el numero, o se está usando una copia de otro comprobante, por
                        'más que sea un alta, no tenés que incrementar el numerador... -En Pronto pasa lo mismo!



                        If esNuevo Then
                            Try
                                ClaseMigrar.AsignarNumeroATalonario(SC, .IdPuntoVenta, .Numero + 1)
                            Catch ex As Exception
                                'MsgBoxAjax(Me, "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.Message)
                                'Exit Function
                            End Try
                        End If

                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////



                        Dim FacturaId As Integer = Guardar_CodigoOriginalDeVB6(SC, myFactura) 'parte de capa de negocios, migrado de VB6  


                        'For Each myFacturaItem As FacturaItem In myFactura.Detalles
                        '    myFacturaItem.IdFactura = FacturaId
                        '    FacturaItemDB.Save(myFacturaItem)
                        'Next
                        .Id = FacturaId
                        'myTransactionScope.Complete()
                        'ContextUtil.SetComplete()
                        Return FacturaId
                    Else

                        'METODO COMPRONTO
                        If Not IsValid(SC, myFactura) Then Return -1
                        Dim oFacturaCOMPRONTO = ClaseMigrar.ConvertirPuntoNETFacturaAComPronto(SC, myFactura)
                        oFacturaCOMPRONTO.Guardar()

                        'actualizo manualmente campos nuevos
                        'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myOrdenCompra.Id, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "'" & myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores & "'")
                    End If


                Catch ex As Exception
                    'ContextUtil.SetAbort()
                    'Debug.Print(ex.Message)
                    ErrHandler.WriteError(ex)
                    Return -1
                Finally
                    'CType(myTransactionScope, IDisposable).Dispose()
                End Try

            End With


        End Function

        Private Shared Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef myFactura As Factura) 'As InterFazMTS.MisEstados

            Dim Resp 'As InterFazMTS.MisEstados
            Dim Datos As DataTable
            Dim DatosRem As DataSet
            Dim DatosCtaCte As New DataTable
            Dim DatosCtaCteNv As New DataTable
            Dim DatosCliente As ClienteNuevo
            Dim DetRem As DataSet
            Dim DatosAsiento As DataSet
            Dim DatosAsientoNv As DataSet
            Dim oRsParametros As DataSet
            Dim DatosDetAsiento As DataSet
            Dim DatosDetAsientoNv As DataSet
            Dim DatosAnt As DataSet
            Dim oFld As ADODB.Field
            Dim lErr As Long, sSource As String, sDesc, mvarAnulada As String
            Dim i As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
            Dim mvarIdCuenta As Long, ClaDet As Long
            Dim mImporteAnterior As Double, mTotalAnteriorDolar As Double
            Dim mvarCotizacionDolar As Double, mvarCotizacionMoneda As Double
            Dim mvarDebe As Double, mvarHaber As Double
            Dim mvarFecha As Date

            Try


                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''Pedazos que se mechan en la validacion de la gui del pronto original
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                With myFactura

                    If .Id > 0 Then

                        EntidadManager.Tarea("Facturas_ActualizarCampos", _
                                  .Id, .IdProvinciaDestino, .IdObra, .Observaciones, .Exportacion_FOB, _
                                        .Exportacion_PosicionAduana, .Exportacion_Despacho, _
                                        .Exportacion_Guia, _
                                        IIf(IsNull(.Exportacion_IdPaisDestino), 0, .Exportacion_IdPaisDestino), _
                                        .Exportacion_FechaEmbarque, .Exportacion_FechaOficializacion, _
                                       .IdIBCondicion, .IdIBCondicion2, .IdIBCondicion3, .NoIncluirEnCubos, .IdVendedor)


                        For Each o As FacturaItem In .Detalles
                            With o
                                If Not .Eliminado Then
                                    EntidadManager.Tarea("Facturas_ActualizarCamposDetalle", _
                                          .Id, IIf(IsNull(.OrigenDescripcion), 1, .OrigenDescripcion), .Observaciones)
                                End If
                            End With
                        Next


                        For Each o As FacturaProvinciasItem In .DetallesProvincias
                            With o
                                If Not .Eliminado Then

                                    If .Id > 0 Then
                                        EntidadManager.Tarea("DetFacturasProvincias_M", _
                                          .Id, myFactura.Id, .IdProvinciaDestino, .Porcentaje)
                                    Else
                                        EntidadManager.Tarea("DetFacturasProvincias_A", _
                                          .Id, myFactura.Id, .IdProvinciaDestino, .Porcentaje)
                                    End If
                                Else
                                    EntidadManager.Tarea("DetFacturasProvincias_E", .Id)
                                End If
                            End With
                        Next


                    End If


                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    facturaelectronica()
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////



                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'COMIENZO del MTS.Guardar
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'On Error GoTo Mal


                    .CotizacionMoneda = IIf(.CotizacionMoneda = 0, 1, .CotizacionMoneda)
                    .CotizacionDolar = IIf(.CotizacionDolar = 0, 1, .CotizacionDolar)

                    mvarIdentificador = .Id
                    mvarCotizacionMoneda = .CotizacionMoneda
                    mvarCotizacionDolar = .CotizacionDolar
                    mvarAnulada = .Anulada



                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'ENCABEZADO
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    'entidadmanager.Tarea("Log_InsertarRegistro", Array("FA", mvarIdentificador, 0, Now, 0, "COMIENZO CABECERA"))
                    'Resp = iCompMTS_GuardarPorRef("Facturas", Factura)
                    'entidadmanager.Tarea("Log_InsertarRegistro", Array("FA", mvarIdentificador, 0, Now, 0, "FIN CABECERA"))

                    '   Set DatosRem = entidadmanager.LeerUno("Remitos", Factura.IdRemito)
                    '   If DatosRem.RecordCount > 0 Then
                    '      DatosRem.Facturado = "SI"
                    '      DatosRem.Update
                    '      Resp = iCompMTS_GuardarPorRef("Remitos", DatosRem)
                    '   End If

                    If Not IsNull(myFactura.ContabilizarAFechaVencimiento) And _
                          myFactura.ContabilizarAFechaVencimiento = "SI" Then
                        mvarFecha = myFactura.FechaVencimiento 'vencimiento
                    Else
                        mvarFecha = myFactura.Fecha
                    End If
                End With

                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                'Detalle
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////

                For Each o As FacturaItem In myFactura.Detalles
                    With o
                        .IdFactura = myFactura.Id
                        .NumeroFactura = myFactura.Numero
                        .TipoABC = myFactura.TipoFactura
                        .PuntoVenta = myFactura.PuntoVenta


                    End With
                Next


                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''DetallesProvincias (sin logica)
                ''DetallesRemitos
                ''DetallesOrdenesCompra grabado normal (directo a MTS)
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////

                ''poner a los 3: .IdFactura = Factura.Fields(0).Value  'EDU ojo con esto, tiene que ir obligatorio a dataAccess para recuperar el id

                Guardar_CodigoOriginalDeVB6 = FacturaDB.Save(SC, myFactura)
                myFactura.Id = Guardar_CodigoOriginalDeVB6

                'despues de grabar, ya no puedo hacer un throw. 

                ''poner a este detalle .IdFactura = Factura.Fields(0).Value
                Try
                    EntidadManager.Tarea(SC, "OrdenesCompra_ActualizarEstadoDetalles", 0, myFactura.Id, 0)
                Catch ex As Exception

                End Try


                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                'CUENTA CORRIENTE 
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////

                'EDU cómo guardar el asiento. dataset suelto en lugar de un objeto

                mImporteAnterior = 0
                mTotalAnteriorDolar = 0
                DatosCtaCteNv = CtaCteDeudorManager.TraerMetadata(SC)

                Dim a As DataRow = DatosCtaCteNv.NewRow
                With a
                    If mvarIdentificador <= 0 Then
                        mImporteAnterior = iisNull(.Item("ImporteTotal"), 0)
                        mTotalAnteriorDolar = iisNull(.Item("ImporteTotalDolar"), 0)
                    End If

                    .Item("IdCliente") = myFactura.IdCliente
                    .Item("NumeroComprobante") = myFactura.Numero
                    .Item("Fecha") = iisValidSqlDate(mvarFecha, DBNull.Value)
                    .Item("IdTipoComp") = 1
                    .Item("FechaVencimiento") = iisValidSqlDate(myFactura.FechaVencimiento, DBNull.Value)
                    .Item("IdComprobante") = myFactura.Id
                    .Item("Cotizacion") = myFactura.CotizacionDolar
                    .Item("IdMoneda") = myFactura.IdMoneda
                    .Item("CotizacionMoneda") = myFactura.CotizacionMoneda
                    If mvarAnulada = "SI" Then
                        .Item("ImporteTotal") = 0
                        .Item("Saldo") = 0
                        .Item("ImporteTotalDolar") = 0
                        .Item("SaldoDolar") = 0
                    Else
                        .Item("ImporteTotal") = Math.Round(myFactura.Total * mvarCotizacionMoneda, 2)
                        .Item("Saldo") = Math.Round(myFactura.Total * mvarCotizacionMoneda, 2) - mImporteAnterior
                        .Item("ImporteTotalDolar") = myFactura.Total * mvarCotizacionMoneda / mvarCotizacionDolar
                        .Item("SaldoDolar") = (myFactura.Total * mvarCotizacionMoneda / mvarCotizacionDolar) - mTotalAnteriorDolar
                    End If
                End With
                DatosCtaCteNv.Rows.Add(a)

                Resp = CtaCteDeudorManager.Insert(SC, DatosCtaCteNv)

                '////////////////////////////
                'lo vuelvo a traer... (TO DO: no esta funcionando)
                '////////////////////////////
                DatosCtaCteNv = CtaCteDeudorManager.TraerMetadata(SC, Resp)
                a = DatosCtaCteNv.Rows(0)
                a.Item("IdImputacion") = Resp
                Resp = CtaCteDeudorManager.Update(SC, DatosCtaCteNv)

                '////////////////////////////
                'cambio el saldo del cliente
                '////////////////////////////
                If myFactura.IdCliente > 0 Then
                    DatosCliente = ClienteManager.GetItem(SC, myFactura.IdCliente)
                    If IsNull(DatosCliente.Saldo) Then
                        DatosCliente.Saldo = 0
                    End If
                    If mvarAnulada = "SI" Then
                        DatosCliente.Saldo = DatosCliente.Saldo - mImporteAnterior
                    Else
                        DatosCliente.Saldo = DatosCliente.Saldo - mImporteAnterior + _
                                                Math.Round(myFactura.Total * mvarCotizacionMoneda, 2)
                    End If

                    Try
                        Resp = ClienteManager.Save(SC, DatosCliente)
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try
                End If





                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                '' SUBDIARIO, REGISTRO CONTABLE -qué diferencia hay con el GuardarRegistroContable()?
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////

                '////////////////////////////
                'Borra la registracion contable anterior si la factura fue modificada
                '////////////////////////////
                If mvarIdentificador > 0 Or mvarAnulada = "SI" Then
                    'DatosAnt = entidadmanager.TraerFiltrado("Subdiarios", "_PorIdComprobante", Array(mvarIdentificador, 1))
                    With DatosAnt.Tables(0)
                        For Each dr As DataRow In .Rows
                            ICompMTSManager.Eliminar(SC, "Subdiarios", dr.Item(0))
                        Next
                    End With

                End If


                '////////////////////////////
                'Si es nuevo:
                '////////////////////////////
                If mvarIdentificador <= 0 Then
                    mvarDebe = 0
                    mvarHaber = 0

                    Dim RegContable As DataTable = RecordSet_2_DataTable(RegistroContable(SC, myFactura))

                    With RegContable

                        For Each dr As DataRow In .Rows

                            With dr
                                If Not IsNull(.Item("Debe")) Then
                                    .Item("Debe") = Math.Round(.Item("Debe") * mvarCotizacionMoneda, 2)
                                    mvarDebe = mvarDebe + .Item("Debe")
                                End If
                                If Not IsNull(.Item("Haber")) Then
                                    .Item("Haber") = Math.Round(.Item("Haber") * mvarCotizacionMoneda, 2)
                                    mvarHaber = mvarHaber + .Item("Haber")
                                End If
                            End With
                        Next


                        If .Rows.Count > 0 Then
                            If mvarDebe - mvarHaber <> 0 Then
                                If Not IsNull(.Rows(0).Item("Debe")) Then
                                    .Rows(0).Item("Debe") = .Rows(0).Item("Debe") - Math.Round(mvarDebe - mvarHaber, 2)
                                Else
                                    .Rows(0).Item("Haber") = .Rows(0).Item("Haber") + Math.Round(mvarDebe - mvarHaber, 2)
                                End If
                            End If
                        End If



                        Datos = .Copy
                        For Each dr As DataRow In Datos.Rows
                            dr.Item(0) = DBNull.Value
                            dr.Item("IdComprobante") = myFactura.Id

                            dr.Item("FechaComprobante") = fechaNETtoSQL(myFactura.Fecha)
                            dr.Item("FechaImportacionTransmision") = fechaNETtoSQL(myFactura.FechaImportacionTransmision)





                        Next

                        'llamo al insert, pero no intenta updatear, porque hice modificaciones al dataset. RESOLVER
                        '-Está tirando errores porque hay registros sin IdCuenta
                        '-No solo eso. Pinta que hay IdCuenta que no existen
                        Try
                            Resp = ICompMTSManager.Insert(SC, Entidades.Subdiarios, Datos)
                        Catch ex As Exception

                        End Try



                    End With
                End If






                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ' ''Recupero de gastos (SACADO DEL FINAL DEL CMDCLICK EN LA FRMFACTURA) 
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////

                'EDU esto esta solo en la gui
                RecuperoDeGastos()




                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////
                ''//////////////////////////////////////////////////////////////////////////////////////


            Catch ex As Exception
                ErrHandler.WriteAndRaiseError(ex)
            End Try



            ''Salir:
            ''            Guardar = Resp
            ''            entidadmanager = Nothing
            ''            oCont = Nothing

            ''            Detalles = Nothing
            ''            RegistroContable = Nothing
            ''            DetallesRemitos = Nothing
            ''            DetallesOrdenesCompra = Nothing

            ''            On Error GoTo 0
            ''            If lErr Then
            ''                Err.Raise(lErr, sSource, sDesc)
            ''            End If
            ''            Exit Function

            ''Mal:
            ''            If Not oCont Is Nothing Then
            ''                With oCont
            ''                    If .IsInTransaction Then .SetAbort()
            ''                End With
            ''            End If
            ''            With Err()
            ''                lErr = .Number
            ''                sSource = .Source
            ''                sDesc = .Description
            ''            End With
            ''            entidadmanager.Tarea("Log_InsertarRegistro", Array("MTSFA", Factura.Fields(0).Value, 0, Now, 0, _
            ''                  "Error " & Err.Number & Err.Description & ", " & Err.Source, _
            ''                  "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
            ''            Resume Salir

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As FacturaList
            Return FacturaDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As FacturaList
            Dim FacturaList As Pronto.ERP.BO.FacturaList = FacturaDB.GetListByEmployee(SC, IdSolicito)
            If FacturaList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        FacturaList.Sort(AddressOf Pronto.ERP.BO.FacturaList.CompareFecha)
                    Case "Obra"
                        FacturaList.Sort(AddressOf Pronto.ERP.BO.FacturaList.CompareObra)
                    Case "Sector"
                        FacturaList.Sort(AddressOf Pronto.ERP.BO.FacturaList.CompareSector)
                    Case Else 'Ordena por id
                        FacturaList.Sort(AddressOf Pronto.ERP.BO.FacturaList.CompareId)
                End Select
            End If
            Return FacturaList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return FacturaDB.GetList_fm(SC)
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataTable



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wFacturas_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "wFacturas_TT")
                'ds = GeneralDB.TraerDatos(SC, "Facturas_TT")
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdFactura").ColumnName = "Id"
                .Columns("Factura").ColumnName = "Numero"
                '.Columns("FechaFactura").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Dim dt As DataTable = ds.Tables(0)
            dt.DefaultView.Sort = "Id DESC"
            Return dt.DefaultView.Table
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientes(ByVal SC As String) As System.Data.DataSet
            Return GetListTX(SC, "_Pendientes1", "P")
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wFacturas_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Facturas_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox


            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wFacturas_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Facturas_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, Optional ByVal getFacturaDetalles As Boolean = False) As Factura

            '            NombreCliente()
            '            codigocliente()
            'direccion=
            '                    Localidad=
            '                    cuit
            '            condicionIVA()


            '

            Dim myFactura As Pronto.ERP.BO.Factura
            myFactura = FacturaDB.GetItem(SC, id)
            If Not (myFactura Is Nothing) AndAlso getFacturaDetalles Then
                myFactura.Detalles = FacturaItemDB.GetList(SC, id)

                Debug.Print(myFactura.IdCliente)
                myFactura.Cliente = ClienteManager.GetItem(SC, myFactura.IdCliente)
                myFactura.CondicionVentaDescripcion = NombreCondicionVenta_y_Compra(SC, myFactura.IdCondicionVenta)
                myFactura.CondicionIVADescripcion = NombreCondicionIVA(SC, myFactura.IdCodigoIva)

                If myFactura.detalles IsNot Nothing Then
                    For Each i As FacturaItem In myFactura.Detalles
                        i.Articulo = NombreArticulo(SC, i.IdArticulo)
                        i.Unidad = NombreUnidad(SC, i.IdUnidad)

                        i.ImporteTotalItem = i.PrecioUnitarioTotal * i.Cantidad
                        ' Eval("Precio")*Eval("Cantidad")
                    Next
                End If

            End If
            Return myFactura
        End Function








        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As FacturaItemList
            Return FacturaItemDB.GetList(SC, id)
        End Function



        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myFactura As Factura) As Boolean
            Return FacturaDB.Delete(SC, myFactura.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return FacturaDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        'Public Shared Function Anular(ByVal SC As String, ByVal IdFactura As Integer) As Integer
        '    'AnularFactura()
        '    Return FacturaDB.Anular(SC, IdFactura)

        'End Function





        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return FacturaDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Shared Sub VerificarProvinciasDestino()

            'Dim oRs As adodb.Recordset
            'Dim mVacio As Boolean
            'Dim mIdCliente As Long
            'Dim mIdProvincia As Integer

            'oRs = origen.DetFacturasProvincias.Registros
            'mVacio = True
            'With oRs
            '    If .Fields.Count > 0 Then
            '        If .RecordCount > 0 Then
            '            .MoveFirst()
            '            Do While Not .EOF
            '                If Not .Fields("Eliminado").Value Then
            '                    mVacio = False
            '                    Exit Do
            '                End If
            '                .MoveNext()
            '            Loop
            '        End If
            '    End If
            'End With
            'oRs = Nothing

            'If mVacio Then
            '    mIdCliente = 0
            '    mIdProvincia = 0
            '    If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then
            '        mIdCliente = origen.Registro.Fields("IdCliente").Value
            '    End If
            '    oRs = Aplicacion.Clientes.TraerFiltrado("_PorId", mIdCliente)
            '    If oRs.RecordCount > 0 Then
            '        mIdProvincia = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            '    End If
            '    oRs.Close()

            '    With origen.DetFacturasProvincias.Item(-1)
            '        With .Registro
            '            .Fields("IdProvinciaDestino").Value = mIdProvincia
            '            .Fields("Porcentaje").Value = 100
            '        End With
            '        .Modificado = True
            '    End With
            'End If

            'oRs = Nothing

        End Sub

        Public Shared Function IsValid(ByVal SC As String, ByRef myFactura As Factura, Optional ByRef ms As String = "") As Boolean

            Dim eliminados As Integer
            'verifico el detalle
            For Each det As FacturaItem In myFactura.Detalles
                If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If

                '.TipoDesignacion = "CMP" 'esto hay que cambiarlo, no?
                'If .TipoDesignacion = "" Then .TipoDesignacion = "S/D" 'esto hay que cambiarlo, no?
                If det.Cumplido <> "SI" And det.Cumplido <> "AN" Then det.Cumplido = "NO"
                '.Cumplido = IIf(.Cumplido = "SI", "SI", "NO") ' y qué pasa si es "AN"?

                If det.Eliminado Then eliminados = eliminados + 1
            Next

            If myFactura.Detalles.Count = eliminados Or myFactura.Detalles.Count = 0 Then
                ms = "La factura debe tener items"
                Return False
            End If


            With myFactura

                'If .Fecha <= ProntoVariableGlobal("gblFechaUltimoCierre") Then 'And Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
                '    ms = "La fecha no puede ser anterior al ultimo cierre : " & ProntoVariableGlobal("gblFechaUltimoCierre")
                '    Return False
                'End If

                If ClaseMigrar.EstadoEntidad(SC, "Clientes", .IdCliente) = "INACTIVO" Then
                    ms = "Cliente inhabilitado"
                    Return False
                End If


                If .SubTotal < 0 Then
                    ms = "La suma de los items facturados debe ser positiva"
                    Return False
                End If

                If .Cotizacion <= 0 Then
                    ms = "La cotizacion debe ser mayor a cero"
                    Return False
                End If

                If .IdObra <= 0 Then
                    ms = "Debe elegir una obra"
                    Return False
                End If

                If .IBrutos <> 0 And .NumeroCertificadoPercepcionIIBB = 0 Then
                    ms = "Debe ingresar el numero de certificado de percepcion IIBB"
                    Return False
                End If

                'If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
                '    oRs = Aplicacion.Facturas.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
                '    If oRs.RecordCount > 0 Then
                '        If oRs.Fields("FechaFactura").Value > DTFields(0).Value Then
                '            MsgBox("La fecha de la ultima factura es " & oRs.Fields("FechaFactura").Value & ", modifiquela", vbExclamation)
                '            oRs.Close()
                '            oRs = Nothing
                '            Exit Function
                '        End If
                '    End If
                '    oRs.Close()
                '    oRs = Nothing
                'End If


                Dim mResul As Boolean
                Dim oRs As DataSet
                Dim oRs1 As DataSet


                '////////////////////////////////////////
                '////////////////////////////////////////
                'valido el CAI
                '////////////////////////////////////////
                '////////////////////////////////////////
                'Try
                '    Dim mvarCAI As String, mvarCAI_v As String, mvarFechaCAI_v As String
                '    Dim mvarFechaCAI As Date
                '    oRs = EntidadManager.GetItem(SC, "PuntosVenta", 1)
                '    Select Case ProntoVariableGlobal("mvarTipoABC")
                '        Case "A"
                '            mvarCAI_v = "NumeroCAI_F_A"
                '            mvarFechaCAI_v = "FechaCAI_F_A"
                '        Case "B"
                '            mvarCAI_v = "NumeroCAI_F_B"
                '            mvarFechaCAI_v = "FechaCAI_F_B"
                '        Case "E"
                '            mvarCAI_v = "NumeroCAI_F_E"
                '            mvarFechaCAI_v = "FechaCAI_F_E"
                '    End Select
                '    mvarCAI = ""
                '    mvarFechaCAI = DateSerial(2000, 1, 1)
                '    If Len(mvarCAI_v) > 0 Then
                '        If Not IsNull(oRs.Fields(mvarCAI_v).Value) Then mvarCAI = oRs.Fields(mvarCAI_v).Value
                '        If Not IsNull(oRs.Fields(mvarFechaCAI_v).Value) Then mvarFechaCAI = oRs.Fields(mvarFechaCAI_v).Value
                '    End If
                '    'mWS = IIf(IsNull(oRs.Fields("WebService").Value), "", oRs.Fields("WebService").Value)
                '    'mModoTest = IIf(IsNull(oRs.Fields("WebServiceModoTest").Value), "", oRs.Fields("WebServiceModoTest").Value)
                '    oRs.Close()
                '    oRs = Nothing

                'Catch ex As Exception

                'End Try

                'If .Fecha > mvarFechaCAI Then
                '    ms = "El CAI vencio el " & mvarFechaCAI & ", no puede grabar el comprobante. Edite el punto de venta."
                '    Return False
                'End If


                '////////////////////////////////////////
                '////////////////////////////////////////
                '////////////////////////////////////////


                VerificarProvinciasDestino()


                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                'VALIDACION DE FACTURA ELECTRONICA
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                ValidarFacturaElectronica()



                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////

                oRs = FacturaManager.GetListTX(SC, "_PorNumeroComprobante", .TipoFactura, .IdPuntoVenta, .Numero)
                If oRs.Tables(0).Rows.Count > 0 Then
                    ms = "Ya existe esta factura!"
                    Return False
                End If


            End With





            Return True
        End Function

        Shared Function ValidarFacturaElectronica() As Boolean

        End Function


        Shared Function TestDelCordobes()
            Dim lResultado


            Dim glbPathPlantillas = AppDomain.CurrentDomain.BaseDirectory + "Documentos"
            Dim mWS = "WSFE1", mvarTipoABC = "A", glbArchivoAFIP = "Autotrol23082011"
            Dim glbCuit = "30-50491371-2"
            Dim mFecha = "20100931"



            Dim fe As New WSAFIPFE.Factura
            If fe.iniciar(WSAFIPFE.Factura.modoFiscal.Test, Replace(glbCuit, "-", ""), glbPathPlantillas & "\" & glbArchivoAFIP & ".pfx", "") Then
                If fe.f1ObtenerTicketAcceso() Then
                    fe.F1CabeceraCantReg = 1
                    fe.F1CabeceraPtoVta = 4
                    fe.F1CabeceraCbteTipo = 1

                    fe.f1Indice = 0
                    fe.F1DetalleConcepto = 1
                    fe.F1DetalleDocTipo = 80
                    fe.F1DetalleDocNro = "20111111112"
                    fe.F1DetalleCbteDesde = 1
                    fe.F1DetalleCbteHasta = 1
                    fe.F1DetalleCbteFch = "20101018"
                    fe.F1DetalleImpTotal = 184.05
                    fe.F1DetalleImpTotalConc = 0
                    fe.F1DetalleImpNeto = 150
                    fe.F1DetalleImpOpEx = 0
                    fe.F1DetalleImpTrib = 7.8
                    fe.F1DetalleImpIva = 26.25
                    fe.F1DetalleFchServDesde = "20101018"
                    fe.F1DetalleFchServHasta = "20101018"
                    fe.F1DetalleFchVtoPago = "20101018"
                    fe.F1DetalleMonId = "PES"
                    fe.F1DetalleMonCotiz = 1

                    fe.F1DetalleTributoItemCantidad = 1
                    fe.f1IndiceItem = 0
                    fe.F1DetalleTributoId = 3
                    fe.F1DetalleTributoDesc = "Impuesto Municipal Matanza"
                    fe.F1DetalleTributoBaseImp = 150
                    fe.F1DetalleTributoAlic = 5.2
                    fe.F1DetalleTributoImporte = 7.8

                    fe.F1DetalleIvaItemCantidad = 2
                    fe.f1IndiceItem = 0
                    fe.F1DetalleIvaId = 5
                    fe.F1DetalleIvaBaseImp = 100
                    fe.F1DetalleIvaImporte = 21

                    fe.f1IndiceItem = 1
                    fe.F1DetalleIvaId = 4
                    fe.F1DetalleIvaBaseImp = 50
                    fe.F1DetalleIvaImporte = 5.25


                    fe.F1DetalleCbtesAsocItemCantidad = 0
                    fe.F1DetalleOpcionalItemCantidad = 0

                    fe.ArchivoXMLRecibido = "c:\recibido.xml"
                    fe.ArchivoXMLEnviado = "c:\enviado.xml"

                    lResultado = fe.F1CAESolicitar()

                    If lResultado Then
                        MsgBox("resultado método: verdadero")
                    Else
                        MsgBox("resultado método: falso")
                    End If
                    MsgBox("resultado global AFIP: " + fe.F1RespuestaResultado)
                    MsgBox("es reproceso? " + fe.F1RespuestaReProceso)
                    MsgBox("registros procesados por AFIP: " + Str(fe.F1RespuestaCantidadReg))
                    MsgBox("error genérico global:" + fe.f1ErrorMsg1)
                    If fe.F1RespuestaCantidadReg > 0 Then
                        fe.f1Indice = 0
                        MsgBox("resultado detallado comprobante: " + fe.F1RespuestaDetalleResultado)
                        MsgBox("cae comprobante: " + fe.F1RespuestaDetalleCae)
                        MsgBox("número comprobante:" + fe.F1RespuestaDetalleCbteDesdeS)
                        MsgBox("error detallado comprobante: " + fe.F1RespuestaDetalleObservacionMsg1)
                    End If
                Else
                    MsgBox(fe.UltimoMensajeError)
                End If
            Else
                MsgBox(fe.UltimoMensajeError)
            End If
        End Function





        Private Shared Sub RecuperoDeGastos()
            'If mvarId < 0 And Check3.Value = 1 Then
            '    'NC Deudores
            '    Dim oPar 
            '    oPar = Aplicacion.Parametros.Item(1)
            '    With oPar
            '        With .Registro
            '            mvarNumero = IIf(IsNull(.Fields("ProximaNotaCreditoInterna").Value), 1, .Fields("ProximaNotaCreditoInterna").Value)
            '            .Fields("ProximaNotaCreditoInterna").Value = mvarNumero + 1
            '            mIdCuentaIvaCompras = 0
            '            For i = 1 To 10
            '                If .Fields("IVAComprasPorcentaje" & i).Value = mvarP_IVA1_Tomado Then
            '                    mIdCuentaIvaCompras = .Fields("IdCuentaIvaCompras" & i).Value
            '                    Exit For
            '                End If
            '            Next
            '        End With
            '        .Guardar()
            '    End With
            '    oPar = Nothing

            '    Dim oNC 
            '    oNC = Aplicacion.NotasCredito.Item(-1)
            '    With oNC
            '        With .Registro
            '            .Fields("NumeroNotaCredito").Value = mvarNumero
            '            .Fields("IdCliente").Value = dcfields(0).BoundText
            '            .Fields("FechaNotaCredito").Value = DTFields(0).Value
            '            .Fields("TipoABC").Value = mvarTipoABC
            '            .Fields("PuntoVenta").Value = 0
            '            .Fields("ImporteTotal").Value = mvarTotalFactura
            '            .Fields("ImporteIva1").Value = mvarIVA1
            '            .Fields("ImporteIva2").Value = mvarIVA2
            '            .Fields("CtaCte").Value = "SI"
            '            .Fields("IdVendedor").Value = origen.Registro.Fields("IdVendedor").Value
            '            .Fields("RetencionIBrutos1").Value = mvarIBrutos
            '            .Fields("PorcentajeIBrutos1").Value = mvarPorcentajeIBrutos
            '            .Fields("RetencionIBrutos2").Value = mvarIBrutos2
            '            .Fields("PorcentajeIBrutos2").Value = mvarPorcentajeIBrutos2
            '            .Fields("IdCodigoIva").Value = mvarTipoIVA
            '            .Fields("PorcentajeIva1").Value = mvarP_IVA1_Tomado
            '            .Fields("PorcentajeIva2").Value = Val(txtPorcentajeIva2.Text)
            '            .Fields("Observaciones").Value = "Recupero gastos"
            '            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            '            .Fields("IdMoneda").Value = dcfields(3).BoundText
            '            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            '            .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
            '            .Fields("ConvenioMultilateral").Value = mvarMultilateral
            '            .Fields("OtrasPercepciones1").Value = Val(txtTotal(6).Text)
            '            .Fields("OtrasPercepciones1Desc").Value = mvarOtrasPercepciones1Desc
            '            .Fields("OtrasPercepciones2").Value = Val(txtTotal(7).Text)
            '            .Fields("OtrasPercepciones2Desc").Value = mvarOtrasPercepciones2Desc
            '            .Fields("IdProvinciaDestino").Value = origen.Registro.Fields("IdProvinciaDestino").Value
            '            .Fields("IdIBCondicion").Value = origen.Registro.Fields("IdIBCondicion").Value
            '            .Fields("IdPuntoVenta").Value = 0
            '            .Fields("NumeroCAI").Value = 0
            '            If IsNumeric(dcfields(2).BoundText) Then
            '                .Fields("IdObra").Value = dcfields(2).BoundText
            '            End If
            '            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            '            .Fields("FechaIngreso").Value = Now
            '            .Fields("IdIBCondicion2").Value = origen.Registro.Fields("IdIBCondicion2").Value
            '            .Fields("OtrasPercepciones3").Value = Val(txtTotal(10).Text)
            '            .Fields("OtrasPercepciones3Desc").Value = mvarOtrasPercepciones3Desc
            '            .Fields("NoIncluirEnCubos").Value = "SI"
            '            .Fields("PercepcionIVA").Value = mvarPercepcionIVA
            '            .Fields("PorcentajePercepcionIVA").Value = mvarPorcentajePercepcionIVA
            '            .Fields("IdFacturaVenta_RecuperoGastos").Value = origen.Registro.Fields(0).Value
            '        End With

            '        oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
            '        mIdConceptoRecuperoGastos = IIf(IsNull(oRs.Fields("IdConceptoRecuperoGastos").Value), 0, oRs.Fields("IdConceptoRecuperoGastos").Value)
            '        oRs.Close()

            '        With .DetNotasCredito.Item(-1)
            '            With .Registro
            '                .Fields("IdConcepto").Value = mIdConceptoRecuperoGastos
            '                .Fields("Importe").Value = mvarSubTotal
            '                .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminado
            '                If Val(txtPorcentajeIva1.Text) <> 0 Then
            '                    .Fields("Gravado").Value = "SI"
            '                End If
            '            End With
            '            .Modificado = True
            '        End With

            '        mIdCtaCte = 0
            '        mImporteTotalPesos = 0
            '        mImporteTotalDolar = 0
            '        oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(origen.Registro.Fields(0).Value, 1))
            '        If oRs.RecordCount > 0 Then
            '            mIdCtaCte = oRs.Fields(0).Value
            '            mImporteTotalPesos = oRs.Fields("ImporteTotal").Value
            '            mImporteTotalDolar = oRs.Fields("ImporteTotalDolar").Value
            '        End If
            '        oRs.Close()

            '        With .DetNotasCreditoImp.Item(-1)
            '            With .Registro
            '                .Fields("IdImputacion").Value = mIdCtaCte
            '                .Fields("Importe").Value = mvarTotalFactura
            '            End With
            '            .Modificado = True
            '        End With
            '        .Guardar()
            '    End With

            '    oRs = Aplicacion.CtasCtesD.TraerFiltrado("_BuscarComprobante", Array(oNC.Registro.Fields(0).Value, 4))
            '    mIdCtaCteNC = 0
            '    If oRs.RecordCount > 0 Then mIdCtaCteNC = oRs.Fields(0).Value
            '    oRs.Close()

            '    oNC = Nothing

            '    Aplicacion.Tarea("CtasCtesD_ReimputarComprobante", _
            '          Array(mIdCtaCteNC, mImporteTotalPesos, mImporteTotalDolar, mIdCtaCte, mImporteTotalPesos, mImporteTotalDolar))

            '    'NC Proveedores
            '    oRs = Aplicacion.Proveedores.TraerFiltrado("_PorCuit", txtCuit.Text)
            '    mIdProveedor = 0
            '    mIdProvinciaDestino = 0
            '    If oRs.RecordCount > 0 Then
            '        mIdProveedor = oRs.Fields(0).Value
            '        mIdProvinciaDestino = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
            '    End If
            '    oRs.Close()

            '    oRs = Aplicacion.Conceptos.TraerFiltrado("_PorIdConDatos", mIdConceptoRecuperoGastos)
            '    mIdCuenta = 0
            '    mCodigo = 0
            '    If oRs.RecordCount > 0 Then
            '        mIdCuenta = IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value)
            '        mCodigo = IIf(IsNull(oRs.Fields("Codigo").Value), 0, oRs.Fields("Codigo").Value)
            '    End If
            '    oRs.Close()

            '    Dim oCP 
            '    oCP = Aplicacion.ComprobantesProveedores.Item(-1)
            '    With oCP
            '        With .Registro
            '            .Fields("IdProveedor").Value = mIdProveedor
            '            .Fields("IdTipoComprobante").Value = 13
            '            .Fields("FechaComprobante").Value = DTFields(0).Value
            '            .Fields("Letra").Value = mvarTipoABC
            '            .Fields("NumeroComprobante1").Value = 0
            '            .Fields("NumeroComprobante2").Value = mvarNumero
            '            .Fields("FechaRecepcion").Value = DTFields(0).Value
            '            .Fields("FechaVencimiento").Value = DTFields(0).Value
            '            .Fields("TotalBruto").Value = mvarTotalFactura - (mvarIVA1 + mvarIVA2)
            '            .Fields("TotalIva1").Value = mvarIVA1
            '            .Fields("TotalIva2").Value = mvarIVA2
            '            .Fields("TotalComprobante").Value = mvarTotalFactura
            '            .Fields("Observaciones").Value = "Recupero de gastos"
            '            If IsNumeric(dcfields(2).BoundText) Then
            '                .Fields("IdObra").Value = dcfields(2).BoundText
            '            End If
            '            .Fields("IdMoneda").Value = dcfields(3).BoundText
            '            .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text
            '            .Fields("CotizacionDolar").Value = txtCotizacionDolar.Text
            '            .Fields("TotalIvaNoDiscriminado").Value = mvarIVANoDiscriminado
            '            .Fields("AjusteIVA").Value = 0
            '            .Fields("BienesOServicios").Value = "B"
            '            .Fields("Confirmado").Value = "SI"
            '            .Fields("NumeroCAI").Value = 0
            '            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            '            .Fields("FechaIngreso").Value = Now
            '            .Fields("IdCodigoIva").Value = mvarTipoIVA
            '            .Fields("CotizacionEuro").Value = Cotizacion(DTFields(0).Value, glbIdMonedaEuro)
            '            .Fields("IdFacturaVenta_RecuperoGastos").Value = origen.Registro.Fields(0).Value
            '        End With
            '        With .DetComprobantesProveedores.Item(-1)
            '            With .Registro
            '                .Fields("IdCuenta").Value = mIdCuenta
            '                .Fields("CodigoCuenta").Value = mCodigo
            '                .Fields("Importe").Value = mvarTotalFactura - (mvarIVA1 + mvarIVA2)
            '                If (mvarIVA1 + mvarIVA2) <> 0 Then
            '                    .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras
            '                    .Fields("IVAComprasPorcentaje1").Value = mvarP_IVA1_Tomado
            '                    .Fields("ImporteIVA1").Value = (mvarIVA1 + mvarIVA2)
            '                    .Fields("AplicarIVA1").Value = "SI"
            '                Else
            '                    .Fields("IVAComprasPorcentaje1").Value = 0
            '                    .Fields("ImporteIVA1").Value = 0
            '                    .Fields("AplicarIVA1").Value = "NO"
            '                End If
            '                .Fields("IVAComprasPorcentaje2").Value = 0
            '                .Fields("ImporteIVA2").Value = 0
            '                .Fields("AplicarIVA2").Value = "NO"
            '                .Fields("IVAComprasPorcentaje3").Value = 0
            '                .Fields("ImporteIVA3").Value = 0
            '                .Fields("AplicarIVA3").Value = "NO"
            '                .Fields("IVAComprasPorcentaje4").Value = 0
            '                .Fields("ImporteIVA4").Value = 0
            '                .Fields("AplicarIVA4").Value = "NO"
            '                .Fields("IVAComprasPorcentaje5").Value = 0
            '                .Fields("ImporteIVA5").Value = 0
            '                .Fields("AplicarIVA5").Value = "NO"
            '                .Fields("IVAComprasPorcentaje6").Value = 0
            '                .Fields("ImporteIVA6").Value = 0
            '                .Fields("AplicarIVA6").Value = "NO"
            '                .Fields("IVAComprasPorcentaje7").Value = 0
            '                .Fields("ImporteIVA7").Value = 0
            '                .Fields("AplicarIVA7").Value = "NO"
            '                .Fields("IVAComprasPorcentaje8").Value = 0
            '                .Fields("ImporteIVA8").Value = 0
            '                .Fields("AplicarIVA8").Value = "NO"
            '                .Fields("IVAComprasPorcentaje9").Value = 0
            '                .Fields("ImporteIVA9").Value = 0
            '                .Fields("AplicarIVA9").Value = "NO"
            '                .Fields("IVAComprasPorcentaje10").Value = 0
            '                .Fields("ImporteIVA10").Value = 0
            '                .Fields("AplicarIVA10").Value = "NO"
            '                .Fields("IdProvinciaDestino1").Value = mIdProvinciaDestino
            '                .Fields("PorcentajeProvinciaDestino1").Value = 100
            '            End With
            '            .Modificado = True
            '        End With
            '        .Guardar()
            '    End With
            '    oCP = Nothing
            'End If


        End Sub

        Private Shared Function RegistroContable(ByVal SC As String, ByVal myFactura As Factura) As ADODB.Recordset

            Dim oSrv As ICompMTSManager
            Dim oRsParam As DataRow 'adodb.Recordset
            Dim oRs As DataRow
            Dim oRsAux As ADODB.Recordset
            Dim oRsCont As ADODB.Recordset
            Dim oRsDet As ADODB.Recordset
            Dim oRsDetBD As DataTable
            Dim oFld As ADODB.Field
            Dim mvarEjercicio As Long, mvarCuentaVentas As Long, mvarCuentaCliente As Long
            Dim mvarCuentaBonificaciones As Long, mvarCuentaIvaInscripto As Long
            Dim mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
            Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
            Dim mvarCuentaReventas As Long, mvarCuentaVentasTitulo As Long
            Dim mvarCuentaIvaInscripto1 As Long, mvarCuentaPercepcionIIBB As Long
            Dim mvarCuentaOtrasPercepciones1 As Long, mvarCuentaOtrasPercepciones2 As Long
            Dim mvarCuentaOtrasPercepciones3 As Long, mvarCuentaPercepcionesIVA As Long
            Dim mvarCuentaIvaVenta(4, 2) As Long
            Dim i As Integer, mvarIdMonedaPesos As Integer
            Dim mvarIvaNoDiscriminado As Double, mvarSubtotal As Double
            Dim mvarNetoGravadoItem As Double, mvarNetoGravadoItemSuma As Double
            Dim mvarEsta As Boolean
            Dim mvarFecha As Date

            '/////////////////////////////////
            'parametros
            '/////////////////////////////////

            'oRs = DataTable_To_Recordset(DataRow_To_DataTable(ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)))
            oRsParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            mvarEjercicio = iisNull(oRsParam.Item("EjercicioActual"), 0)
            mvarCuentaVentas = iisNull(oRsParam.Item("IdCuentaVentas"), 0)
            mvarCuentaVentasTitulo = iisNull(oRsParam.Item("IdCuentaVentasTitulo"), 0)
            mvarCuentaBonificaciones = iisNull(oRsParam.Item("IdCuentaBonificaciones"), 0)
            mvarCuentaIvaInscripto = iisNull(oRsParam.Item("IdCuentaIvaInscripto"), 0)
            mvarCuentaIvaNoInscripto = iisNull(oRsParam.Item("IdCuentaIvaNoInscripto"), 0)
            mvarCuentaIvaSinDiscriminar = iisNull(oRsParam.Item("IdCuentaIvaSinDiscriminar"), 0)
            mvarCuentaRetencionIBrutosBsAs = iisNull(oRsParam.Item("IdCuentaRetencionIBrutosBsAs"), 0)
            mvarCuentaRetencionIBrutosCap = iisNull(oRsParam.Item("IdCuentaRetencionIBrutosCap"), 0)
            mvarCuentaReventas = iisNull(oRsParam.Item("IdCuentaReventas"), 0)
            mvarCuentaOtrasPercepciones1 = iisNull(oRsParam.Item("IdCuentaOtrasPercepciones1"), 0)
            mvarCuentaOtrasPercepciones2 = iisNull(oRsParam.Item("IdCuentaOtrasPercepciones2"), 0)
            mvarCuentaOtrasPercepciones3 = iisNull(oRsParam.Item("IdCuentaOtrasPercepciones3"), 0)
            mvarCuentaPercepcionesIVA = iisNull(oRsParam.Item("IdCuentaPercepcionesIVA"), 0)
            mvarCuentaCliente = iisNull(oRsParam.Item("IdCuentaDeudoresVarios"), 0)
            mvarIdMonedaPesos = iisNull(oRsParam.Item("IdMoneda"), 0)

            For i = 1 To 4
                If Not IsNull(oRsParam.Item("IdCuentaIvaVentas" & i)) Then
                    mvarCuentaIvaVenta(i, 0) = oRsParam.Item("IdCuentaIvaVentas" & i)
                    mvarCuentaIvaVenta(i, 1) = oRsParam.Item("IVAVentasPorcentaje" & i)
                Else
                    mvarCuentaIvaVenta(i, 0) = 0
                    mvarCuentaIvaVenta(i, 1) = -1
                End If
            Next


            '/////////////////////////////////
            'verifico moneda del cliente
            '/////////////////////////////////

            If myFactura.IdCliente > 0 Then
                Dim oCli = ClienteManager.GetItem(SC, myFactura.IdCliente) ' oSrv.LeerUno("Clientes", myFactura.IdCliente)
                mvarCuentaCliente = oCli.IdCuenta
                If myFactura.IdMoneda <> mvarIdMonedaPesos And oCli.idcuentaMonedaExt <> 0 Then
                    mvarCuentaCliente = oCli.idcuentaMonedaExt
                End If
            End If



            '/////////////////////////////////
            '/////////////////////////////////
            '/////////////////////////////////
            'comienzo del armado del subdiario
            '/////////////////////////////////
            '/////////////////////////////////
            '/////////////////////////////////

            'oRs = EntidadManager.GetListTX(SC, "Subdiarios", "_Estructura").Tables(0)
            oRsCont = DataTable_To_Recordset(EntidadManager.GetListTX(SC, "Subdiarios", "TX_Estructura").Tables(0))


            If Not IsNull(myFactura.ContabilizarAFechaVencimiento) And _
                  myFactura.ContabilizarAFechaVencimiento = "SI" Then
                mvarFecha = myFactura.FechaVencimiento
            Else
                mvarFecha = myFactura.FechaFactura
            End If
            mvarSubtotal = (myFactura.Total - myFactura.ImporteIva1 - _
                            myFactura.ImporteIva2 - myFactura.RetencionIBrutos1 - _
                            myFactura.RetencionIBrutos2 - myFactura.RetencionIBrutos3 - _
                            myFactura.OtrasPercepciones1 - _
                            myFactura.OtrasPercepciones2 - _
                            myFactura.OtrasPercepciones3 - _
                            myFactura.PercepcionIVA + _
                            myFactura.ImporteBonificacion)

            mvarNetoGravadoItemSuma = 0

            With oRsCont
                .AddNew()
                .Fields("Ejercicio").Value = mvarEjercicio
                .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                .Fields("IdCuenta").Value = mvarCuentaCliente
                .Fields("IdTipoComprobante").Value = 1
                .Fields("NumeroComprobante").Value = myFactura.Numero
                .Fields("FechaComprobante").Value = mvarFecha
                .Fields("IdComprobante").Value = myFactura.Id
                .Fields("Debe").Value = myFactura.Total
                .Fields("IdMoneda").Value = myFactura.IdMoneda
                .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                .Update()
            End With


            If Not IsNull(myFactura.ImporteBonificacion) Then
                If myFactura.ImporteBonificacion <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaBonificaciones
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Debe").Value = myFactura.ImporteBonificacion
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.ImporteIva1) Then
                If myFactura.ImporteIva1 <> 0 Then
                    mvarCuentaIvaInscripto1 = mvarCuentaIvaInscripto
                    For i = 1 To 4
                        If myFactura.PorcentajeIva1 = mvarCuentaIvaVenta(i, 1) Then
                            mvarCuentaIvaInscripto1 = mvarCuentaIvaVenta(i, 0)
                            Exit For
                        End If
                    Next
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaIvaInscripto1
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.ImporteIva1
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            mvarIvaNoDiscriminado = 0
            If Not IsNull(myFactura.IVANoDiscriminado) Then
                If myFactura.IVANoDiscriminado <> 0 Then
                    mvarIvaNoDiscriminado = myFactura.IVANoDiscriminado
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = mvarIvaNoDiscriminado
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.ImporteIva2) Then
                If myFactura.ImporteIva2 <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.ImporteIva2
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.RetencionIBrutos1) Then
                If myFactura.RetencionIBrutos1 <> 0 Then
                    oRs = oSrv.LeerUno(SC, Entidades.IBCondiciones, myFactura.IdIBCondicion).Rows(0)
                    mvarCuentaPercepcionIIBB = iisNull(oRs.Item("IdCuentaPercepcionIIBB"), 0)
                    If Not IsNull(oRs.Item("IdProvincia").Value) Then
                        oRsAux = oSrv.LeerUno(SC, Entidades.Provincias, oRs.Item("IdProvincia"))
                        If oRsAux.RecordCount > 0 Then
                            If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos").Value
                            End If
                            If myFactura.ConvenioMultilateral = "SI" And _
                                  Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                            End If
                        End If

                    End If

                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaPercepcionIIBB
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.RetencionIBrutos1
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.RetencionIBrutos2) Then
                If myFactura.RetencionIBrutos2 <> 0 Then
                    oRs = oSrv.LeerUno(SC, Entidades.IBCondiciones, myFactura.IdIBCondicion2).Rows(0)
                    mvarCuentaPercepcionIIBB = iisNull(oRs.Item("IdCuentaPercepcionIIBB"), 0)
                    If Not IsNull(oRs.Item("IdProvincia").Value) Then
                        oRsAux = oSrv.LeerUno(SC, Entidades.Provincias, oRs.Item("IdProvincia"))
                        If oRsAux.RecordCount > 0 Then
                            If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos").Value
                            End If
                            If myFactura.ConvenioMultilateral = "SI" And _
                                  Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                            End If
                        End If
                        oRsAux.Close()
                    End If

                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaPercepcionIIBB
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.RetencionIBrutos2
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.RetencionIBrutos3) Then
                If myFactura.RetencionIBrutos3 <> 0 Then
                    oRs = oSrv.LeerUno(SC, Entidades.IBCondiciones, myFactura.IdIBCondicion3).Rows(0)
                    mvarCuentaPercepcionIIBB = iisNull(oRs.Item("IdCuentaPercepcionIIBB"), 0)
                    If Not IsNull(oRs.Item("IdProvincia")) Then
                        oRsAux = oSrv.LeerUno("Provincias", oRs.Item("IdProvincia"))
                        If oRsAux.RecordCount > 0 Then
                            If Not IsNull(oRsAux.Fields("IdCuentaPercepcionIBrutos").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIBrutos").Value
                            End If
                            If myFactura.ConvenioMultilateral = "SI" And _
                                  Not IsNull(oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value) Then
                                mvarCuentaPercepcionIIBB = oRsAux.Fields("IdCuentaPercepcionIIBBConvenio").Value
                            End If
                        End If
                        oRsAux.Close()
                    End If

                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaPercepcionIIBB
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.RetencionIBrutos3
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.OtrasPercepciones1) Then
                If myFactura.OtrasPercepciones1 <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaOtrasPercepciones1
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.OtrasPercepciones1
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.OtrasPercepciones2) Then
                If myFactura.OtrasPercepciones2 <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaOtrasPercepciones2
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.OtrasPercepciones2
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.OtrasPercepciones3) Then
                If myFactura.OtrasPercepciones3 <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaOtrasPercepciones3
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.OtrasPercepciones3
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(myFactura.PercepcionIVA) Then
                If myFactura.PercepcionIVA <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaPercepcionesIVA
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        .Fields("Haber").Value = myFactura.PercepcionIVA
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With
                End If
            End If

            For Each iFac As FacturaItem In myFactura.Detalles
                With iFac
                    If Not .Eliminado Then
                        oRs = EntidadManager.GetListTX(SC, "Articulos", "TX_DatosConCuenta", .IdArticulo).Tables(0).Rows(0)
                        'qué hago con los que no tienen cuenta???
                        If IsDBNull(oRs.Item("IdCuenta")) Then Continue For 'RESOLVER: esto no es así en pronto


                        mvarNetoGravadoItem = Math.Round(.Cantidad * _
                                                .Precio * _
                                                (1 - .Bonificacion) / 100, 2)
                        If mvarIvaNoDiscriminado > 0 Then
                            mvarNetoGravadoItem = Math.Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
                            mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
                        End If
                        With oRsCont
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                            .Fields("IdCuenta").Value = oRs.Item("IdCuenta")
                            .Fields("IdTipoComprobante").Value = 1
                            .Fields("NumeroComprobante").Value = myFactura.Numero
                            .Fields("FechaComprobante").Value = mvarFecha
                            .Fields("IdComprobante").Value = myFactura.Id
                            If mvarNetoGravadoItem >= 0 Then
                                .Fields("Haber").Value = mvarNetoGravadoItem
                            Else
                                .Fields("Debe").Value = mvarNetoGravadoItem * -1
                            End If
                            .Fields("IdMoneda").Value = myFactura.IdMoneda
                            .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                            .Update()
                        End With

                    End If
                End With
            Next


            '////////////////////////////////
            'verifica que no se encuentre en el original
            '////////////////////////////////

            oRsDetBD = EntidadManager.GetListTX(SC, "DetFacturas", "TX_PorIdCabecera", myFactura.Id).Tables(0)
            For Each drDB As DataRow In oRsDetBD.Rows

                mvarEsta = False
                For Each iFac As FacturaItem In myFactura.Detalles
                    If drDB.Item(0) = iFac.Id Then
                        If Not iFac.Eliminado Then
                            mvarEsta = True
                            Exit For
                        End If
                    End If
                Next


                If Not mvarEsta Then
                    oRs = EntidadManager.TraerFiltrado(SC, enumSPs.Articulos_TX_DatosConCuenta, drDB.Item("IdArticulo").Value).Rows(0)
                    'qué hago con los que no tienen cuenta???
                    If IsDBNull(oRs.Item("IdCuenta")) Then Continue For 'RESOLVER: esto no es así en pronto

                    mvarNetoGravadoItem = Math.Round(drDB.Item("Cantidad").Value * _
                                            IIf(IsNull(drDB.Item("PrecioUnitario").Value), 0, drDB.Item("PrecioUnitario").Value) * _
                                            (1 - IIf(IsNull(drDB.Item("Bonificacion").Value), 0, drDB.Item("Bonificacion").Value) / 100), 2)
                    If mvarIvaNoDiscriminado > 0 Then
                        mvarNetoGravadoItem = Math.Round(mvarNetoGravadoItem * (mvarSubtotal - mvarIvaNoDiscriminado) / mvarSubtotal, 2)
                        mvarNetoGravadoItemSuma = mvarNetoGravadoItemSuma + mvarNetoGravadoItem
                    End If
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaVentasTitulo
                        .Fields("IdCuenta").Value = oRs.Item("IdCuenta").Value
                        .Fields("IdTipoComprobante").Value = 1
                        .Fields("NumeroComprobante").Value = myFactura.Numero
                        .Fields("FechaComprobante").Value = mvarFecha
                        .Fields("IdComprobante").Value = myFactura.Id
                        If mvarNetoGravadoItem >= 0 Then
                            .Fields("Haber").Value = mvarNetoGravadoItem
                        Else
                            .Fields("Debe").Value = mvarNetoGravadoItem * -1
                        End If
                        .Fields("IdMoneda").Value = myFactura.IdMoneda
                        .Fields("CotizacionMoneda").Value = myFactura.CotizacionMoneda
                        .Update()
                    End With

                End If


            Next

            '////////////////////////////////
            '////////////////////////////////
            '////////////////////////////////



            If mvarIvaNoDiscriminado > 0 Then
                If Math.Round(mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado, 2) <> mvarSubtotal Then
                    With oRsCont
                        .Fields("Haber").Value = .Fields("Haber").Value + (mvarSubtotal - (mvarNetoGravadoItemSuma + mvarIvaNoDiscriminado))
                        .Update()
                    End With
                End If
            End If



            RegistroContable = oRsCont

            oRs = Nothing
            oRsAux = Nothing
            oRsCont = Nothing
            oSrv = Nothing

        End Function


        Public Function GuardarRegistroContable(ByVal SC As String, ByVal RegContable As DataTable, ByVal myFactura As Factura) 'As InterFazMTS.MisEstados
            '/////////////////////////////////////////////////
            '/////////////////////////////////////////////////
            'Esta funcion es llamada en el proceso de frmProcesar.GeneracionContable()
            '/////////////////////////////////////////////////
            '/////////////////////////////////////////////////
            '/////////////////////////////////////////////////

            Dim oCont 'As ObjectContext
            Dim oDet 'As iCompMTS
            Dim Resp 'As InterFazMTS.MisEstados
            Dim oRsComprobante As ADODB.Recordset
            Dim Datos As DataTable
            Dim DatosAsiento As ADODB.Recordset
            Dim DatosAsientoNv As ADODB.Recordset
            Dim oRsParametros As ADODB.Recordset
            Dim DatosDetAsiento As ADODB.Recordset
            Dim DatosDetAsientoNv As ADODB.Recordset
            Dim oFld As ADODB.Field
            Dim lErr As Long, sSource As String, sDesc As String
            Dim i As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
            Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

            On Error GoTo Mal

            'oCont = GetObjectContext

            oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto


            mvarCotizacionMoneda = 0
            mvarDebe = 0
            mvarHaber = 0



            With RegContable

                'oRsComprobante = oDet.LeerUno("Facturas", .Fields("IdComprobante").Value)
                'mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value


                For Each dr As DataRow In .Rows

                    With dr
                        If Not IsNull(.Item("Debe")) Then
                            .Item("Debe") = Math.Round(.Item("Debe") * mvarCotizacionMoneda, 2)
                            mvarDebe = mvarDebe + .Item("Debe")
                        End If
                        If Not IsNull(.Item("Haber")) Then
                            .Item("Haber") = Math.Round(.Item("Haber") * mvarCotizacionMoneda, 2)
                            mvarHaber = mvarHaber + .Item("Haber")
                        End If
                    End With
                Next


                If .Rows.Count > 0 Then
                    If mvarDebe - mvarHaber <> 0 Then
                        If Not IsNull(.Rows(0).Item("Debe")) Then
                            .Rows(0).Item("Debe") = .Rows(0).Item("Debe") - Math.Round(mvarDebe - mvarHaber, 2)
                        Else
                            .Rows(0).Item("Haber") = .Rows(0).Item("Haber") + Math.Round(mvarDebe - mvarHaber, 2)
                        End If
                    End If
                End If



                Datos = .Copy
                For Each dr As DataRow In Datos.Rows
                    dr.Item(0) = -1
                    dr.Item("IdComprobante") = myFactura.Id
                    Resp = ICompMTSManager.Insert(SC, Entidades.Subdiarios, Datos)
                Next


            End With

            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetComplete()
                End With
            End If

Salir:
            GuardarRegistroContable = Resp
            oDet = Nothing
            oCont = Nothing
            On Error GoTo 0
            If lErr Then
                Err.Raise(lErr, sSource, sDesc)
            End If
            Exit Function

Mal:
            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetAbort()
                End With
            End If
            With Err()
                lErr = .Number
                sSource = .Source
                sDesc = .Description
            End With
            Resume Salir

        End Function







        Public Shared Function ProximoNumeroFactura(ByVal SC As String, ByVal IdPuntoVenta As Integer) As Long

            Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
            Return oPto.Item("ProximoNumero")

        End Function

        Public Shared Function ProximoNumeroFactura(ByVal SC As String, ByVal IdCliente As Integer, ByVal NumeroDePuntoVenta As Integer) As Long

            Try
                'averiguo la letra
                Dim Letra = LetraSegunTipoIVA(ClienteManager.GetItem(SC, IdCliente).IdCodigoIva)

                'averiguo el id del talonario 
                Dim IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, NumeroDePuntoVenta, Letra)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Return -1
            End Try

        End Function

        ''' <summary>
        ''' 'Le tenes que pasar el número de punto de venta, no el ID de punto de venta, ojito!!!!!
        ''' </summary>
        ''' <param name="SC"></param>
        ''' <param name="IdCodigoIva"></param>
        ''' <param name="NumeroDePuntoVenta"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Shared Function ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(ByVal SC As String, ByVal IdCodigoIva As Integer, ByVal NumeroDePuntoVenta As Integer) As Long
            'es el número de punto de venta, no el ID, ojito!!!!!

            Try
                'averiguo la letra
                Dim Letra = LetraSegunTipoIVA(IdCodigoIva)

                'averiguo el id del talonario 
                Dim IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, NumeroDePuntoVenta, Letra)

                If IdPuntoVenta <= 0 Then Return -1

                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Return -1
            End Try

        End Function






        Public Shared Sub RecalcularTotales(ByVal SC As String, ByRef myFactura As Factura)


            Dim mvarSubTotal, mvarIVA1 As Single




            With myFactura

                If .IdCliente <= 0 Then
                    Err.Raise(345, , "Para calcular la factura se necesita el IdCliente")
                End If

                Dim oRs As ADODB.Recordset
                Dim oL As FacturaItem 'As ListItem
                Dim i As Integer, mIdProvinciaIIBB As Integer
                Dim mNumeroCertificadoPercepcionIIBB As Long
                Dim t0 As Double, t1 As Double, t2 As Double, t3 As Double, mParteDolar As Double
                Dim mPartePesos As Double, mBonificacion As Double, mKilos As Double
                Dim mPrecioUnitario As Double, mCantidad As Double, mTopeIIBB As Double
                Dim mFecha1 As Date

                t0 = 0
                t1 = 0
                t2 = 0
                t3 = 0
                'Dim mvarSubTotal = 0
                Dim mvarIBrutos = 0
                Dim mvarIBrutos2 = 0
                Dim mvarIBrutos3 = 0
                Dim mvarPorcentajeIBrutos = 0
                Dim mvarPorcentajeIBrutos2 = 0
                Dim mvarPorcentajeIBrutos3 = 0
                Dim mvar_IBrutos_Cap = 0
                Dim mvar_IBrutos_BsAs = 0
                Dim mvar_IBrutos_BsAsM = 0
                Dim mvarMultilateral = "NO"
                'Dim mvarIVA1 = 0
                Dim mvarIVA2 = 0
                Dim mvarTotalFactura As Double = 0
                Dim mvarParteDolares = 0
                Dim mvarPartePesos = 0
                Dim mvarImporteBonificacion = 0
                Dim mvarNetoGravado = 0
                Dim mvarPorcentajeBonificacion = 0
                Dim mvarIVANoDiscriminado = 0
                Dim mvarPercepcionIVA = 0
                Dim mvarDecimales = 2

                Dim mvarLocalidad
                Dim mvarZona
                Dim mvarProvincia
                Dim mvarTipoIVA
                Dim mvarCondicionVenta
                Dim mvarIBCondicion
                Dim mvarIdIBCondicion
                Dim mvarIdIBCondicion2
                Dim mvarIdIBCondicion3
                Dim mvarEsAgenteRetencionIVA
                Dim mvarPorcentajePercepcionIVA
                Dim mvarBaseMinimaParaPercepcionIVA
                Dim mAlicuotaDirecta
                Dim mFechaInicioVigenciaIBDirecto
                Dim mFechaFinVigenciaIBDirecto

                Dim oCli As ClienteNuevo = ClienteManager.GetItem(SC, .IdCliente)

                For Each oL In .Detalles
                    With oL
                        If Not .Eliminado Then
                            mPrecioUnitario = .Precio
                            mCantidad = .Cantidad
                            mBonificacion = .PorcentajeBonificacion 'IIf(IsNull(.Registro.Fields("Bonificacion").Value), 0, .Registro.Fields("Bonificacion").Value)

                            'EDU: que son estos t
                            t0 = t0 '+ Val(oL.ListSubItems(2))
                            t1 = t1 '+ Val(oL.ListSubItems(3))
                            t2 = t2 + mCantidad
                            t3 = t3 + Math.Round(mCantidad * mPrecioUnitario * (1 - mBonificacion / 100) + 0.0001, 2)
                            'Debug.PrintMath.round(mCantidad * mPrecioUnitario * (1 - mBonificacion / 100) + 0.0001, 2)
                        End If
                    End With
                Next




                With oCli
                    mvarLocalidad = .IdLocalidad
                    mvarZona = 0
                    mvarProvincia = .IdProvincia
                    mvarTipoIVA = .IdCodigoIva
                    mvarCondicionVenta = .IdCondicionVenta
                    mvarIBCondicion = .IBCondicion
                    mvarIdIBCondicion = .IdIBCondicionPorDefecto
                    mvarIdIBCondicion2 = .IdIBCondicionPorDefecto2
                    mvarIdIBCondicion3 = .IdIBCondicionPorDefecto3
                    mvarEsAgenteRetencionIVA = .esAgenteRetencionIVA
                    mvarPorcentajePercepcionIVA = .PorcentajePercepcionIVA
                    mvarBaseMinimaParaPercepcionIVA = iisNull(.BaseMinimaParaPercepcionIVA, 0)
                    mAlicuotaDirecta = .PorcentajeIBDirecto
                    mFechaInicioVigenciaIBDirecto = .FechaInicioVigenciaIBDirecto
                    mFechaFinVigenciaIBDirecto = .FechaFinVigenciaIBDirecto
                End With



                mvarSubTotal = t3

                If .Id > 0 Then
                    'FACTURA EXISTENTE

                    mvarTotalFactura = .Total
                    mvarIVA1 = .ImporteIva1
                    mvarIVA2 = .ImporteIva2
                    mvarIVANoDiscriminado = .IVANoDiscriminado
                    mvarIBrutos = .RetencionIBrutos1
                    mvarPorcentajeIBrutos = .PorcentajeIBrutos1
                    mvarIBrutos2 = .RetencionIBrutos2
                    mvarPorcentajeIBrutos2 = .PorcentajeIBrutos2
                    mvarMultilateral = .ConvenioMultilateral
                    mvarIBrutos3 = .RetencionIBrutos3
                    mvarPorcentajeIBrutos3 = .PorcentajeIBrutos3
                    mvarParteDolares = .ImporteParteEnDolares
                    mvarPartePesos = .ImporteParteEnPesos
                    mvarImporteBonificacion = .ImporteBonificacion
                    mvarPorcentajeBonificacion = .PorcentajeBonificacion
                    mvarPercepcionIVA = .PercepcionIVA
                Else

                    'FACTURA NUEVA



                    mvarImporteBonificacion = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                    mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion



                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'TIPO DE IVA
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////


                    Try
                        mvarTipoIVA = oCli.IdCodigoIva
                    Catch ex As Exception

                    End Try


                    'If Session("glbIdCodigoIva") = 1 Then
                    Select Case mvarTipoIVA
                        Case 1
                            mvarIVA1 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva1) / 100, mvarDecimales)
                            mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales)
                            .TipoFactura = "A"
                        Case 2
                            mvarIVA1 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva1) / 100, mvarDecimales)
                            mvarIVA2 = Math.Round(mvarNetoGravado * Val(.PorcentajeIva2) / 100, mvarDecimales)
                            mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales) + _
                            Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva2) / 100, mvarDecimales)
                            'TipoFactura = "A"
                        Case 3
                            'TipoFactura = "E"
                        Case 8
                            'TipoFactura = "B"
                        Case 9
                            'mvarTipoABC = "A"
                        Case Else
                            mvarIVANoDiscriminado = Math.Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(.PorcentajeIva1) / 100))), mvarDecimales)
                            'mvarTipoABC = "B"
                    End Select
                    'Else
                    '    TipoFactura = "C"
                    'End If

                    .TipoFactura = LetraSegunTipoIVA(mvarTipoIVA)



                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'INGRESOS BRUTOS CATEGORIA 1
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////


                    Dim NumeroCertificadoPercepcionIIBB = DBNull.Value
                    Dim dr As DataRow

                    If .IdIBCondicion Then
                        dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion)



                        mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
                        mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
                        mFecha1 = IIf(IsNull(dr.Item("FechaVigencia")), Today, dr.Item("FechaVigencia"))

                        If iisNull(dr.Item("IdProvinciaReal"), iisNull(dr.Item("IdProvincia"), 0)) = 2 And _
                               .Fecha >= mFechaInicioVigenciaIBDirecto And _
                               .Fecha <= mFechaFinVigenciaIBDirecto Then
                            'mAlicuotaDirecta <> 0 And

                            mvarPorcentajeIBrutos = mAlicuotaDirecta
                        Else
                            If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)



                        If mvarIBrutos <> 0 Then
                            'dr = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)

                            Try
                                mNumeroCertificadoPercepcionIIBB = _
                                      IIf(IsNull(dr.Item("ProximoNumeroCertificadoPercepcionIIBB")), 1, _
                                          dr.Item("ProximoNumeroCertificadoPercepcionIIBB"))
                            Catch ex As Exception

                            End Try

                            'origen.Registro.item("NumeroCertificadoPercepcionIIBB") = mNumeroCertificadoPercepcionIIBB
                        End If
                        dr = Nothing
                    End If

                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'INGRESOS BRUTOS CATEGORIA 2
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If .IdIBCondicion2 Then
                        dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion2)


                        mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
                        mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
                        If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
                              .Fecha >= mFechaInicioVigenciaIBDirecto And _
                              .Fecha <= mFechaFinVigenciaIBDirecto Then
                            'mAlicuotaDirecta <> 0 And
                            mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                        Else
                            If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos2 = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)



                    End If


                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'INGRESOS BRUTOS CATEGORIA 3
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If .IdIBCondicion3 Then
                        dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion3)


                        mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
                        mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
                        If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
                              .Fecha >= mFechaInicioVigenciaIBDirecto And _
                              .Fecha <= mFechaFinVigenciaIBDirecto Then
                            'mAlicuotaDirecta <> 0 And
                            mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                        Else
                            If mvarNetoGravado > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos3 = Math.Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)


                    End If

                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'PERCEPCIONES (si no es AGENTE de RETENCION)
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If Not mvarEsAgenteRetencionIVA And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
                        mvarPercepcionIVA = Math.Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
                    End If





                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'TOTAL FINAL
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    mvarTotalFactura = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 _
                                    + mvarIBrutos3 + mvarPercepcionIVA + _
                                    .OtrasPercepciones1 + .OtrasPercepciones2 + .OtrasPercepciones3


                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'FIN DE CALCULO PARA FACTURA NUEVA
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                End If


                'txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
                'txtTotal(9).Text = Format(mvarImporteBonificacion, "#,##0.00")
                'txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
                'txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
                'txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
                'txtTotal(8).Text = Format(mvarTotalFactura, "#,##0.00")


                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                '.TotalBonifEnItems = 0
                .ImporteIva1 = 0


                For Each det As FacturaItem In .Detalles
                    With det

                        If .Eliminado Then Continue For
                        '////////////////////////
                        'codigo comentado: así lo hacía antes de mover todo al manager
                        'Dim temp As Decimal
                        'txtSubtotal.Text = StringToDecimal(txtSubtotal.Text) + det.Cantidad * det.Precio
                        'temp = (det.Cantidad * det.Precio * ((100 + det.PorcentajeIVA) / 100) * ((100 + det.PorcentajeBonificacion) / 100))
                        'temp = temp + txtTotal.Text 'StringToDecimal(txtTotal.Text)
                        'Debug.Print(temp)
                        'txtTotal.Text = temp
                        '////////////////////////


                        '////////////////////////
                        'Cálculo del item
                        Dim mImporte = Val(.Precio) * Val(.Cantidad)
                        '.ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        '.ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        '.ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                        '////////////////////////


                        '////////////////////////
                        'Sumador de totales
                        myFactura.SubTotal += mImporte
                        'myPresupuesto.TotalBonifEnItems += .ImporteBonificacion
                        'mvarIVA1 += .ImporteIVA
                        '////////////////////////
                    End With
                Next


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto

                .RetencionIBrutos1 = mvarIBrutos
                .RetencionIBrutos2 = mvarIBrutos2
                .RetencionIBrutos3 = mvarIBrutos3

                .PercepcionIVA = mvarPercepcionIVA
                .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .IVANoDiscriminado = mvarIVANoDiscriminado
                .ImporteIva1 = mvarIVA1
                .Total = mvarTotalFactura ' .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With
        End Sub



        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdFactura As Long) As Integer

            Dim oRs As ADODB.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetFacturas", "TX_Req", IdFactura))

            If oRs.RecordCount = 0 Then
                UltItem = 0
            Else
                oRs.MoveLast()
                UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
            End If

            oRs.Close()

            'oRs = Me.Registros

            If oRs.Fields.Count > 0 Then
                If oRs.RecordCount > 0 Then
                    oRs.MoveFirst()
                    While Not oRs.EOF
                        If Not oRs.Fields("Eliminado").Value Then
                            If oRs.Fields("NumeroItem").Value > UltItem Then
                                UltItem = oRs.Fields("NumeroItem").Value
                            End If
                        End If
                        oRs.MoveNext()
                    End While
                End If
            End If

            oRs = Nothing

            UltimoItemDetalle = UltItem + 1

        End Function

        Public Shared Function UltimoItemDetalle(ByVal myFactura As Factura) As Integer

            For Each i As FacturaItem In myFactura.Detalles
                If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function

        Shared Function UltimoId(ByVal sc As String) As Long
            Return EntidadManager.ExecDinamico(sc, "SELECT TOP 1 idFactura from Facturas order by idFactura desc").Rows(0).Item("IdFactura")
        End Function



        Public Shared Function GetItemPorNumero(ByVal SC As String, ByVal Letra As String, ByVal PuntoVenta As Integer, ByVal Numero As Long) As Factura

            Dim dr As DataRow = GetStoreProcedureTop1(SC, enumSPs.Facturas_TX_PorNumeroComprobante, Letra, PuntoVenta, Numero)

            If Not IsNothing(dr) Then
                Dim myfactura As Factura
                myfactura = FacturaDB.GetItem(SC, dr.Item("IdFactura"))
                Return myfactura
            Else
                Return Nothing
            End If

        End Function


        Shared Function ValidarCAI_FacturaA(ByVal sc As String, ByVal puntoVenta As Integer) As Boolean
            Dim fechaVenceCAI As Date = EntidadManager.ExecDinamico(sc, "SELECT FechaCAI_F_A FROM PuntosVenta WHERE " & "PuntoVenta=" & puntoVenta & " AND Letra='" & "A" & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura).Rows(0).Item(0)

            Return fechaVenceCAI >= Today
        End Function




        Shared Function CartasPorteImputadas(ByVal SC As String, ByVal IdFactura As Long) As Generic.List(Of CartasDePorte)
            Return CartaPorteManagerAux.CartasPorteImputadas(SC, IdFactura)
        End Function

    End Class






End Namespace









