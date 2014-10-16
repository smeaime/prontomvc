Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Diagnostics
Imports System.Collections.Generic
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager
Imports Microsoft.VisualBasic
Imports System.Collections

Imports adodb.ObjectStateEnum

Namespace Pronto.ERP.Bll




    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ComprobanteProveedorManager



        Inherits ServicedComponent

        'Implements IProntoManager



        Public Shared Sub RefrescarDesnormalizados(ByVal SC As String, ByRef cp As ComprobanteProveedor)
            For Each i As ComprobanteProveedorItem In cp.Detalles
                RefrescarDesnormalizadosItem(SC, i)
            Next
        End Sub

        Public Shared Sub RefrescarDesnormalizadosItem(ByVal SC As String, ByRef i As ComprobanteProveedorItem)
            With i
                '.CodigoCuenta=Cuenta(SC, .IdCuenta)
                .Articulo = NombreArticulo(SC, .IdArticulo)
                .RubroContable = NombreRubroContable(SC, .IdRubroContable)
                .Cuenta = NombreCuenta(SC, .IdCuenta, .CodigoCuenta)


                Dim ors1 As DataRow
                If .IdDetalleRecepcion > 0 Then
                    ors1 = GetStoreProcedureTop1(SC, enumSPs.Recepciones_TX_DatosPorIdDetalleRecepcion, .IdDetalleRecepcion)
                    'txtDetNumeroRecepcion.Text = iisNull(ors1.Item("NumeroRecepcionAlmacen"))
                    'txtDetNumeroRequerimiento.Text = iisNull(ors1.Item("NumeroRequerimiento"))
                    'txtDetNumeroRequerimientoItem.Text = iisNull(ors1.Item("ItemRM"))
                    .NumeroPedido = iisNull(ors1.Item("NumeroPedido"))
                    'txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
                    .PedidoItem = iisNull(ors1.Item("ItemPedido"))
                ElseIf .IdDetallePedido > 0 Then
                    ors1 = GetStoreProcedureTop1(SC, enumSPs.Pedidos_TX_DatosPorIdDetalle, .IdDetallePedido)
                    'txtDetNumeroPedido.Text = iisNull(ors1.Item("NumeroPedido"))
                    'txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
                    'txtDetNumeroPedidoItem.Text = iisNull(ors1.Item("IP"))
                ElseIf .IdPedido > 0 Then
                    ors1 = GetStoreProcedureTop1(SC, enumSPs.Pedidos_TX_PorId, .IdPedido)
                    .NumeroPedido = iisNull(ors1.Item("NumeroPedido"))
                    'txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
                End If
            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_FondosFijos(ByVal SC As String, Optional ByVal IdObra As Integer = -1, Optional ByVal TipoFiltro As String = "", Optional ByVal IdCuentaFF As Integer = -1, Optional ByVal Rendicion As Integer = -1, Optional ByVal dtDesde As Date = Nothing, Optional ByVal dtHasta As Date = Nothing) As DataView

            'Dim Lista As ComprobanteProveedorList = ComprobanteProveedorDB.GetList_FondosFijos(SC, IdObra)

            Dim dt = GetStoreProcedure(SC, enumSPs.wComprobantesProveedores_TXFecha, iisValidSqlDate(dtDesde, #1/1/1900#), iisValidSqlDate(dtHasta, Today), -1)
            Dim dt2 As New DataTable


            dt2 = dt.Clone


            'metodo 1: borro sobre la lista original
            Dim lstBorrar As New List(Of Integer)

            'metodo 2: hago una segunda lista sobre la que copio los objetos filtrados
            Dim Lista2 As New ComprobanteProveedorList

            Try

                For Each dr As DataRow In dt.Rows
                    With dr
                        If IIf(IdObra = -1, True, iisNull(.Item("IdObra"), 0) = IdObra) _
                            And IIf(IdCuentaFF = -1, True, iisNull(.Item("IdCuenta"), 0) = IdCuentaFF) _
                            And IIf(Rendicion = -1 Or Rendicion = 0, True, iisNull(.Item("NumeroRendicionFF"), 0) = Rendicion) Then

                            Select Case TipoFiltro
                                Case "", "AConfirmarEnObra"
                                    If iisNull(.Item("ConfirmadoPorWeb"), "NO") = "NO" And iisNull(.Item("Confirmado"), "NO") = "NO" Then
                                        'Lista.Remove(cp)  'http://www.velocityreviews.com/forums/t104020-how-can-i-delete-a-item-in-foreach-loop.html

                                        'metodo 1 
                                        'lstBorrar.Add(Lista.IndexOf(cp))

                                        'metodo 2
                                        dt2.ImportRow(dr)
                                    End If
                                Case "AConfirmarEnCentral"
                                    If iisNull(.Item("ConfirmadoPorWeb"), "NO") = "SI" And iisNull(.Item("Confirmado"), "NO") = "NO" Then
                                        'lstBorrar.Add(Lista.IndexOf(cp))
                                        dt2.ImportRow(dr)
                                    End If
                                Case "Confirmados"
                                    If iisNull(.Item("Confirmado"), "NO") = "SI" Then
                                        'lstBorrar.Add(Lista.IndexOf(cp))
                                        dt2.ImportRow(dr)
                                    End If
                                Case Else
                                    Err.Raise(222222222)
                            End Select

                        End If
                    End With
                Next

            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Debug.Print(ex.Message)
            End Try

            ''metodo 1: 'borrar marcha atras porque si no cambia el indice!!!!
            'For Each i As Integer In New ReverseIterator(lstBorrar)
            '    Lista.RemoveAt(i) 'al final se trula y se excede del indice
            'Next

            'Return Lista



            Try
                With dt2
                    .Columns("IdComprobanteProveedor").ColumnName = "Id"
                    '.Columns("ComprobantePrv").ColumnName = "Numero"
                    '.Columns("FechaComprobantePrv").ColumnName = "Fecha"
                End With


                dt2.DefaultView.Sort = "Id DESC"
                'Return dt.DefaultView.Table

            Catch ex As Exception
                Return Nothing
            End Try


            Return dt2.DefaultView


        End Function


        Class ReverseIterator
            Implements IEnumerable

            ' a low-overhead ArrayList to store references
            Dim items As New ArrayList()

            Sub New(ByVal collection As IEnumerable)
                ' load all the items in the ArrayList, but in reverse order
                Dim o As Object
                For Each o In collection
                    items.Insert(0, o)
                Next
            End Sub

            Public Function GetEnumerator() As System.Collections.IEnumerator _
                Implements System.Collections.IEnumerable.GetEnumerator
                ' return the enumerator of the inner ArrayList
                Return items.GetEnumerator()
            End Function
        End Class






























        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myComprobantePrv As ComprobanteProveedor, Optional ByVal sError As String = "") As Integer 'Implements IProntoManager.Save
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            'Try




            Dim esNuevo As Boolean
            If myComprobantePrv.Id = -1 Then esNuevo = True Else esNuevo = False

            If esNuevo Then
                'RefrescarTalonario(SC, myComprobantePrv)
                myComprobantePrv.NumeroReferencia = ParametroManager.ParametroOriginal(SC, ParametroManager.ePmOrg.ProximoComprobanteProveedorReferencia)
            End If


            Dim ComprobantePrvId As Integer = ComprobanteProveedorDB.Save(SC, myComprobantePrv)



            'For Each myComprobantePrvItem As ComprobanteProveedorItem In myComprobantePrv.Detalles
            '    myComprobantePrvItem.IdComprobantePrv = ComprobantePrvId
            '    ComprobantePrvItemDB.Save(myComprobantePrvItem)
            'Next


            'Guardar_CodigoOriginalDeVB6(SC, myComprobantePrv)

            If esNuevo Then
                If ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximoComprobanteProveedorReferencia, myComprobantePrv.NumeroReferencia + 1) = -1 Then
                End If
            End If

            myComprobantePrv.Id = ComprobantePrvId




            'myTransactionScope.Complete()
            'ContextUtil.SetComplete()
            Return ComprobantePrvId




            'Catch ex As Exception
            '    'ContextUtil.SetAbort()
            '    ErrHandler.WriteError(ex)
            '    'Debug.Print(ex.Message)
            '    Return -1
            'Finally
            '    'CType(myTransactionScope, IDisposable).Dispose()
            'End Try
        End Function

        Private Shared Function GuardarNoConfirmados(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As ICompMTSManager.MisEstados

            Dim oCont 'As ObjectContext
            Dim oDet As ICompMTSManager
            Dim Resp As ICompMTSManager.MisEstados
            Dim lErr As Long, sSource As String, sDesc As String
            Dim Datos As adodb.Recordset
            Dim i As Integer
            Dim oFld As adodb.Field

            On Error GoTo Mal

            'oCont = GetObjectContext

            oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            Resp = oDet.GuardarPorRef(sc, "ComprobantesProveedores", oCP)

            'With Detalles

            '    If .State <> adStateClosed Then

            '        If Not .EOF Then
            '            .Update()
            '            .MoveFirst()
            '        End If

            '        Do While Not .EOF

            '            .Fields("IdComprobanteProveedor").Value = ComprobanteProveedor.Fields(0).Value
            '            .Update()

            '            If .Fields("Eliminado").Value Then
            '                oDet.Eliminar(sc, "DetComprobantesProveedores", .Fields(0).Value)
            '            Else
            '                Datos =
            '                For i = 0 To .Fields.Count - 2
            '                    With .Fields(i)
            '                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
            '                        Datos.Fields(.Name).Precision = .Precision
            '                        Datos.Fields(.Name).NumericScale = .NumericScale
            '                    End With
            '                Next
            '                Datos.Open()
            '                Datos.AddNew()
            '                For i = 0 To .Fields.Count - 2
            '                    With .Fields(i)
            '                        Datos.Fields(i).Value = .Value
            '                    End With
            '                Next
            '                Datos.Update()
            '                Resp = oDet.Guardar(sc, "DetComprobantesProveedores", Datos)
            '                Datos.Close()
            '                Datos = Nothing
            '            End If

            '            .MoveNext()

            '        Loop

            '    End If

            'End With

            'If Not oCont Is Nothing Then
            '    With oCont
            '        If .IsInTransaction Then .SetComplete()
            '    End With
            'End If

Salir:
            GuardarNoConfirmados = Resp
            oDet = Nothing
            oCont = Nothing
            On Error GoTo 0
            'If lErr Then
            '    Err.Raise(lErr, sSource, sDesc)
            'End If
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


        Private Shared Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As ICompMTSManager.MisEstados
            '            'todo esto estaba en el mts



            Dim RegistroContable As adodb.Recordset = ComprobanteProveedorManager.RecalcularRegistroContable(SC, oCP)

            If Not IsNull(oCP.Confirmado) And _
                  oCP.Confirmado = "NO" Then
                Guardar_CodigoOriginalDeVB6 = GuardarNoConfirmados(SC, oCP)
                Exit Function
            End If




            Dim oCont 'As ObjectContext
            Dim oDet As New ICompMTSManager
            Dim Resp As ICompMTSManager.MisEstados
            Dim Datos As adodb.Recordset
            Dim DatosCtaCte As adodb.Recordset
            Dim DatosCtaCteNv As adodb.Recordset
            Dim DatosProveedor As adodb.Recordset
            Dim DetRem As adodb.Recordset
            Dim DatosAnt As adodb.Recordset
            Dim DatosAsiento As adodb.Recordset
            Dim DatosAsientoNv As adodb.Recordset
            Dim oRsParametros As adodb.Recordset
            Dim DatosDetAsiento As adodb.Recordset
            Dim DatosDetAsientoNv As adodb.Recordset
            Dim oRsValores As adodb.Recordset
            Dim oRsAux As adodb.Recordset
            Dim oFld As adodb.Field
            Dim lErr As Long, sSource As String, sDesc As String
            Dim i As Integer, mvarCoeficiente As Integer, mvarCoeficienteAnt As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
            Dim mvarIdCuenta As Long, mIdValor As Long, mvarIdProveedorAnterior As Long
            Dim mvarIdTipoComprobanteAnterior As Long, mvarIdBanco As Long, mvarIdCaja As Long
            Dim mvarIdOrdenPagoActual As Long, mvarIdOrdenPagoAnterior As Long, mvarAuxL1 As Long
            Dim mvarIdDetalleComprobanteProveedor As Long, mvarIdDetalleComprobanteProveedorAnt As Long
            Dim mvarNumeroReferencia As Long, mvarIdTipoCuentaGrupoIVA As Long
            Dim mTotalAnterior As Double, mvarCotizacionAnt As Double, mvarCotizacionDolar As Double
            Dim mvarCotizacionMoneda As Double, mTotalAnteriorDolar As Double, mvarDebe As Double
            Dim mvarHaber As Double, mvarCotizacionEuro As Double, mTotalAnteriorEuro As Double
            Dim Tot As Double, TotDol As Double, TotEu As Double, Sdo As Double, SdoDol As Double, SdoEu As Double
            Dim mvarBorrarEnValores As Boolean, mvarSubdiarios_ResumirRegistros As Boolean
            Dim mvarOk As Boolean, mvarProcesar As Boolean



            '        On Error GoTo Mal


            mvarIdentificador = oCP.Id
            mvarCotizacionMoneda = IIf(IsNull(oCP.CotizacionMoneda), 0, oCP.CotizacionMoneda)
            mvarCotizacionDolar = IIf(IsNull(oCP.CotizacionDolar), 0, oCP.CotizacionDolar)
            mvarCotizacionEuro = IIf(IsNull(oCP.CotizacionEuro), 0, oCP.CotizacionEuro)
            mvarIdOrdenPagoActual = IIf(IsNull(oCP.IdOrdenPago), 0, oCP.IdOrdenPago)
            mvarNumeroReferencia = IIf(IsNull(oCP.NumeroReferencia), 0, oCP.NumeroReferencia)

            Dim oParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            If IsNull(oParam.Item("Subdiarios_ResumirRegistros")) Or _
                  oParam.Item("Subdiarios_ResumirRegistros") = "SI" Then
                mvarSubdiarios_ResumirRegistros = True
            Else
                mvarSubdiarios_ResumirRegistros = False
            End If
            mvarIdTipoCuentaGrupoIVA = iisNull(oParam.Item("IdTipoCuentaGrupoIVA"), 0)


            mvarCoeficiente = 1
            Datos = oDet.LeerUno(SC, "TiposComprobante", oCP.IdTipoComprobante)
            If Datos.RecordCount > 0 Then
                mvarCoeficiente = Datos.Fields("Coeficiente").Value
            End If
            Datos.Close()
            Datos = Nothing
            mvarCoeficienteAnt = mvarCoeficiente

            If Not IsNull(oCP.IdDiferenciaCambio) Then
                oDet.Tarea(SC, "DiferenciasCambio_MarcarComoGenerada", _
                      ArrayVB6(oCP.IdDiferenciaCambio, _
                            oCP.IdTipoComprobante, oCP.Id))
            End If

            mTotalAnterior = 0
            mvarIdProveedorAnterior = 0
            mvarIdTipoComprobanteAnterior = 0
            mvarIdOrdenPagoAnterior = 0
            If mvarIdentificador > 0 Then
                DatosAnt = oDet.LeerUno(SC, "ComprobantesProveedores", mvarIdentificador)
                If DatosAnt.RecordCount > 0 Then
                    mvarCotizacionAnt = IIf(IsNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
                    mTotalAnterior = DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt
                    If Not IsNull(DatosAnt.Fields("IdProveedor").Value) Then
                        mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
                    End If
                    If Not IsNull(DatosAnt.Fields("IdTipoComprobante").Value) Then
                        mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value
                    End If
                    Datos = oDet.LeerUno(SC, "TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value)
                    If Datos.RecordCount > 0 Then
                        mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value
                    End If
                    mvarIdOrdenPagoAnterior = IIf(IsNull(DatosAnt.Fields("IdOrdenPago").Value), 0, DatosAnt.Fields("IdOrdenPago").Value)
                    Datos.Close()
                    Datos = Nothing

                    If Not IsNull(DatosAnt.Fields("IdComprobanteImputado").Value) Then
                        mvarAuxL1 = 11
                        oRsAux = oDet.LeerUno(SC, "ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value)
                        If oRsAux.RecordCount > 0 Then
                            mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
                        End If
                        oRsAux.Close()

                        DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
                                 ArrayVB6(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value))
                        If DatosCtaCteNv.RecordCount > 0 Then
                            Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                            TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                            TotEu = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                                     IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

                            DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
                                     ArrayVB6(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1))
                            If DatosCtaCte.RecordCount > 0 Then
                                DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                                DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                                DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
                            End If
                            DatosCtaCte.Close()
                            DatosCtaCte = Nothing

                            oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)
                        End If
                        DatosCtaCteNv.Close()
                        DatosCtaCteNv = Nothing
                    End If
                End If
                DatosAnt.Close()
                DatosAnt = Nothing
            End If

            'Resp = oDet.GuardarPorRef(SC, "ComprobantesProveedores", oCP)

            'Datos = oDet.LeerUno(SC, "ComprobantesProveedores", oCP.Id)
            'If Datos.RecordCount > 0 Then
            '    mvarNumeroReferencia = IIf(IsNull(Datos.Fields("NumeroReferencia").Value), 0, Datos.Fields("NumeroReferencia").Value)
            'End If
            'Datos.Close()

            If mvarIdOrdenPagoActual <> 0 Or mvarIdOrdenPagoAnterior <> 0 Then
                oDet.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", ArrayVB6(mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior))
            End If

            If mvarIdProveedorAnterior <> 0 Then
                DatosProveedor = oDet.LeerUno(SC, "Proveedores", mvarIdProveedorAnterior)
                If IsNull(DatosProveedor.Fields("Saldo").Value) Then
                    DatosProveedor.Fields("Saldo").Value = 0
                End If
                DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value + (mTotalAnterior * mvarCoeficienteAnt)
                Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
                DatosProveedor.Close()
                DatosProveedor = Nothing
            End If

            If oCP.IdProveedor > 0 Then
                Dim oPrv = ProveedorManager.GetItem(SC, oCP.IdProveedor)
                oPrv.Saldo = oPrv.Saldo - (oCP.TotalComprobante * mvarCoeficiente * mvarCotizacionMoneda)
                ProveedorManager.Save(SC, oPrv)

                'DatosProveedor = oDet.LeerUno(SC, "Proveedores", oCP.IdProveedor)
                'If IsNull(DatosProveedor.Fields("Saldo").Value) Then
                '    DatosProveedor.Fields("Saldo").Value = 0
                'End If
                'DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value - (oCP.TotalComprobante * mvarCoeficiente * mvarCotizacionMoneda)
                'Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
                'DatosProveedor.Close()
                'DatosProveedor = Nothing
            End If

            'Borra la registracion contable anterior si el comprobante fue modificado
            If mvarIdentificador > 0 Then
                DatosAnt = oDet.TraerFiltrado(SC, "Subdiarios", "_PorIdComprobante", ArrayVB6(mvarIdentificador, mvarIdTipoComprobanteAnterior))
                With DatosAnt
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        Do While Not .EOF
                            oDet.Eliminar(SC, "Subdiarios", .Fields(0).Value)
                            .MoveNext()
                        Loop
                    End If
                    .Close()
                End With
                '      Set DatosAnt = oDet.TraerFiltrado(sc,"DetComprobantesProveedores", "_PorIdCabecera", mvarIdentificador)
                '      With DatosAnt
                '         If .RecordCount > 0 Then
                '            .MoveFirst
                '            Do While Not .EOF
                '               oDet.Tarea "Valores_BorrarPorIdDetalleComprobanteProveedor", .Fields(0).Value
                '               .MoveNext
                '            Loop
                '         End If
                '         .Close
                '      End With
                DatosAnt = Nothing
            End If



            For Each item As ComprobanteProveedorItem In oCP.Detalles
                With item


                    If .Eliminado Then
                        oDet.Eliminar(SC, "DetComprobantesProveedores", .Id)
                        oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", .Id)
                    Else

                        mvarIdDetalleComprobanteProveedorAnt = .Id
                        'Resp = oDet.Guardar(SC, "DetComprobantesProveedores", item)


                        If Not mvarSubdiarios_ResumirRegistros And RegistroContable.RecordCount > 0 Then
                            RegistroContable.MoveFirst()
                            Do While Not RegistroContable.EOF
                                If RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedorAnt And _
                                      mvarIdDetalleComprobanteProveedorAnt <> mvarIdDetalleComprobanteProveedor Then
                                    RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedor
                                    RegistroContable.Update()
                                End If
                                RegistroContable.MoveNext()
                            Loop
                            RegistroContable.MoveFirst()
                        End If

                        mvarBorrarEnValores = True
                        oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaCajaBanco", .IdCuenta)
                        If oRsAux.RecordCount > 0 Then
                            If Not IsNull(oRsAux.Fields("EsCajaBanco").Value) And _
                                  (oRsAux.Fields("EsCajaBanco").Value = "BA" Or _
                                   oRsAux.Fields("EsCajaBanco").Value = "CA") Then

                                mvarIdCaja = IIf(IsNull(oRsAux.Fields("IdCaja").Value), 0, oRsAux.Fields("IdCaja").Value)
                                oRsAux.Close()

                                mIdValor = -1
                                oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleComprobanteProveedor", mvarIdDetalleComprobanteProveedor)
                                If oRsValores.RecordCount > 0 Then
                                    mIdValor = oRsValores.Fields(0).Value
                                End If
                                oRsValores.Close()
                                oRsValores = Nothing

                                mvarIdBanco = 0
                                If Not IsNull(.IdCuentaBancaria) Then
                                    oRsAux = oDet.TraerFiltrado(SC, "CuentasBancarias", "_PorId", .IdCuentaBancaria)
                                    If oRsAux.RecordCount > 0 Then
                                        mvarIdBanco = oRsAux.Fields("IdBanco").Value
                                    End If
                                    oRsAux.Close()
                                End If

                                If mvarIdBanco <> 0 Or mvarIdCaja <> 0 Then
                                    oRsValores = CopiarRs(oDet.TraerFiltrado(SC, "Valores", "_Struc"))
                                    With oRsValores
                                        .Fields("IdTipoValor").Value = 32
                                        .Fields("NumeroValor").Value = 0
                                        .Fields("NumeroInterno").Value = 0
                                        .Fields("FechaValor").Value = oCP.FechaRecepcion
                                        .Fields("IdCuentaBancaria").Value = item.IdCuentaBancaria
                                        If mvarIdBanco <> 0 Then .Fields("IdBanco").Value = mvarIdBanco
                                        If mvarIdCaja <> 0 Then .Fields("IdCaja").Value = mvarIdCaja
                                        .Fields("Importe").Value = item.Importe
                                        .Fields("NumeroComprobante").Value = mvarNumeroReferencia
                                        .Fields("FechaComprobante").Value = oCP.FechaComprobante
                                        If Not IsNull(oCP.IdProveedor) Then
                                            .Fields("IdProveedor").Value = oCP.IdProveedor
                                        End If
                                        .Fields("IdTipoComprobante").Value = oCP.IdTipoComprobante
                                        .Fields("IdDetalleComprobanteProveedor").Value = mvarIdDetalleComprobanteProveedor
                                        .Fields("IdMoneda").Value = oCP.IdMoneda
                                        .Fields("CotizacionMoneda").Value = oCP.CotizacionMoneda
                                        .Fields(0).Value = mIdValor
                                    End With
                                    Resp = oDet.Guardar(SC, "Valores", oRsValores)
                                    oRsValores.Close()
                                    oRsValores = Nothing
                                    mvarBorrarEnValores = False
                                End If
                            End If
                        Else
                            oRsAux.Close()
                        End If
                        oRsAux = Nothing

                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
                            oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", .Id)
                        End If
                    End If
                End With
            Next



            If Not IsNull(oCP.IdProveedor) Then
                mTotalAnterior = 0
                mTotalAnteriorDolar = 0
                mTotalAnteriorEuro = 0
                If mvarIdentificador > 0 Then
                    DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", ArrayVB6(oCP.Id, mvarIdTipoComprobanteAnterior))
                    If DatosCtaCteNv.RecordCount > 0 Then
                        mTotalAnterior = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                        mTotalAnteriorDolar = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                        mTotalAnteriorEuro = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                                             IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)
                    Else
                        DatosCtaCteNv.Close()
                        DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
                        DatosCtaCteNv = CopiarRs(DatosCtaCte)
                        DatosCtaCteNv.Fields(0).Value = -1
                    End If
                Else
                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
                    DatosCtaCteNv = CopiarRs(DatosCtaCte)
                    DatosCtaCteNv.Fields(0).Value = -1
                End If
                With DatosCtaCteNv
                    Tot = Math.Round(oCP.TotalComprobante * mvarCotizacionMoneda, 2)
                    TotDol = 0
                    If mvarCotizacionDolar <> 0 Then
                        TotDol = Math.Round(oCP.TotalComprobante * _
                              IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionDolar, 2)
                    End If
                    TotEu = 0
                    If mvarCotizacionEuro <> 0 Then
                        TotEu = Math.Round(oCP.TotalComprobante * _
                              IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionEuro, 2)
                    End If

                    .Fields("IdProveedor").Value = oCP.IdProveedor
                    .Fields("NumeroComprobante").Value = mvarNumeroReferencia
                    .Fields("Fecha").Value = oCP.FechaRecepcion
                    .Fields("IdTipoComp").Value = oCP.IdTipoComprobante
                    .Fields("IdComprobante").Value = oCP.Id
                    .Fields("FechaVencimiento").Value = oCP.FechaVencimiento
                    .Fields("ImporteTotal").Value = Tot
                    .Fields("Saldo").Value = Tot - mTotalAnterior
                    .Fields("CotizacionDolar").Value = mvarCotizacionDolar
                    .Fields("ImporteTotalDolar").Value = TotDol
                    .Fields("SaldoDolar").Value = TotDol - mTotalAnteriorDolar
                    .Fields("CotizacionEuro").Value = mvarCotizacionEuro
                    .Fields("ImporteTotalEuro").Value = TotEu
                    .Fields("SaldoEuro").Value = TotEu - mTotalAnteriorEuro
                    .Fields("IdMoneda").Value = oCP.IdMoneda
                    .Fields("CotizacionMoneda").Value = oCP.CotizacionMoneda

                    If Not IsNull(oCP.IdComprobanteImputado) Then
                        Sdo = 0
                        SdoDol = 0
                        SdoEu = 0
                        mvarAuxL1 = 11
                        oRsAux = oDet.LeerUno(SC, "ComprobantesProveedores", oCP.IdComprobanteImputado)
                        If oRsAux.RecordCount > 0 Then
                            mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
                        End If
                        oRsAux.Close()
                        oRsAux = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
                                 ArrayVB6(oCP.IdComprobanteImputado, mvarAuxL1))
                        If oRsAux.RecordCount > 0 Then
                            Sdo = oRsAux.Fields("Saldo").Value
                            SdoDol = IIf(IsNull(oRsAux.Fields("SaldoDolar").Value), 0, oRsAux.Fields("SaldoDolar").Value)
                            SdoEu = IIf(IsNull(oRsAux.Fields("SaldoEuro").Value), 0, oRsAux.Fields("SaldoEuro").Value)

                            If IsNull(oCP.Dolarizada) Or oCP.Dolarizada = "NO" Then
                                TotDol = 0
                                If IIf(IsNull(oRsAux.Fields("CotizacionDolar").Value), 0, oRsAux.Fields("CotizacionDolar").Value) <> 0 Then
                                    TotDol = Math.Round(Math.Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionDolar").Value, 2)
                                End If
                                .Fields("CotizacionDolar").Value = oRsAux.Fields("CotizacionDolar").Value
                                .Fields("ImporteTotalDolar").Value = TotDol
                                .Fields("SaldoDolar").Value = TotDol
                            End If
                            TotEu = 0
                            If IIf(IsNull(oRsAux.Fields("CotizacionEuro").Value), 0, oRsAux.Fields("CotizacionEuro").Value) <> 0 Then
                                TotEu = Math.Round(Math.Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionEuro").Value, 2)
                            End If
                            .Fields("CotizacionEuro").Value = oRsAux.Fields("CotizacionEuro").Value
                            .Fields("ImporteTotalEuro").Value = TotEu
                            .Fields("SaldoEuro").Value = TotEu
                            If Tot > Sdo Then
                                Tot = Math.Round(Tot - Sdo, 2)
                                oRsAux.Fields("Saldo").Value = 0
                                .Fields("Saldo").Value = Tot
                            Else
                                Sdo = Math.Round(Sdo - Tot, 2)
                                oRsAux.Fields("Saldo").Value = Sdo
                                .Fields("Saldo").Value = 0
                            End If
                            If TotDol > SdoDol Then
                                TotDol = Math.Round(TotDol - SdoDol, 2)
                                oRsAux.Fields("SaldoDolar").Value = 0
                                .Fields("SaldoDolar").Value = TotDol
                            Else
                                SdoDol = Math.Round(SdoDol - TotDol, 2)
                                oRsAux.Fields("SaldoDolar").Value = SdoDol
                                .Fields("SaldoDolar").Value = 0
                            End If
                            If TotEu > SdoEu Then
                                TotEu = Math.Round(TotEu - SdoEu, 2)
                                oRsAux.Fields("SaldoEuro").Value = 0
                                .Fields("SaldoEuro").Value = TotEu
                            Else
                                SdoEu = Math.Round(SdoEu - TotEu, 2)
                                oRsAux.Fields("SaldoEuro").Value = SdoEu
                                .Fields("SaldoEuro").Value = 0
                            End If
                            .Fields("IdImputacion").Value = oRsAux.Fields("IdImputacion").Value
                            Resp = oDet.Guardar(SC, "CtasCtesA", oRsAux)
                        End If
                        oRsAux.Close()
                    End If
                End With

                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
                If IsNull(DatosCtaCteNv.Fields("IdImputacion").Value) Then
                    DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
                    Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
                End If
                DatosCtaCteNv.Close()
                DatosCtaCteNv = Nothing
                DatosCtaCte = Nothing
            Else
                If mvarIdentificador > 0 Then
                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", ArrayVB6(oCP.Id, mvarIdTipoComprobanteAnterior))
                    If DatosCtaCte.RecordCount > 0 Then
                        oDet.Eliminar(SC, "CtasCtesA", DatosCtaCte.Fields(0).Value)
                    End If
                    DatosCtaCte.Close()
                    DatosCtaCte = Nothing
                End If
            End If

            mvarDebe = 0
            mvarHaber = 0

            With RegistroContable
                If .State <> adStateClosed Then
                    If .RecordCount > 0 Then
                        .Update()
                        .MoveFirst()
                    End If
                    Do While Not .EOF
                        If Not IsNull(.Fields("Debe").Value) Then
                            .Fields("Debe").Value = Math.Round(.Fields("Debe").Value * mvarCotizacionMoneda, 2)
                            .Update()
                            mvarDebe = mvarDebe + .Fields("Debe").Value
                        End If
                        If Not IsNull(.Fields("Haber").Value) Then
                            .Fields("Haber").Value = Math.Round(.Fields("Haber").Value * mvarCotizacionMoneda, 2)
                            .Update()
                            mvarHaber = mvarHaber + .Fields("Haber").Value
                        End If
                        .MoveNext()
                    Loop
                    If .RecordCount > 0 Then
                        If mvarDebe - mvarHaber <> 0 Then
                            mvarOk = False
                            .MoveFirst()
                            Do While Not .EOF
                                If Not IsNull(.Fields("Debe").Value) Then
                                    mvarProcesar = True
                                    oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaParaAjusteSubdiario", .Fields("IdCuenta").Value)
                                    If oRsAux.Fields(0).Value = 0 Then mvarProcesar = False
                                    oRsAux.Close()
                                    Datos = Nothing
                                    If mvarProcesar Then
                                        .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
                                        mvarOk = True
                                        Exit Do
                                    End If
                                End If
                                .MoveNext()
                            Loop
                            If Not mvarOk Then
                                .MoveLast()
                                If Not IsNull(.Fields("Debe").Value) Then
                                    .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
                                Else
                                    .Fields("Haber").Value = .Fields("Haber").Value + Math.Round(mvarDebe - mvarHaber, 2)
                                End If
                            End If
                        End If
                        .MoveFirst()
                    End If
                    Do While Not .EOF
                        Datos = CreateObject("adodb.Recordset")
                        For i = 0 To .Fields.Count - 1
                            With .Fields(i)
                                Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                                Datos.Fields(.Name).Precision = .Precision
                                Datos.Fields(.Name).NumericScale = .NumericScale
                            End With
                        Next
                        Datos.Open()
                        Datos.AddNew()
                        For i = 0 To .Fields.Count - 1
                            With .Fields(i)
                                Datos.Fields(i).Value = .Value
                            End With
                        Next
                        Datos.Fields("IdComprobante").Value = oCP.Id
                        Datos.Fields("NumeroComprobante").Value = mvarNumeroReferencia
                        Datos.Update()
                        Resp = oDet.Guardar(SC, "Subdiarios", Datos)
                        Datos.Close()
                        Datos = Nothing
                        .MoveNext()
                    Loop
                End If
            End With

            'With oCP.DetallesProvincias
            '    If .State <> adStateClosed Then
            '        If Not .EOF Then
            '            .Update()
            '            .MoveFirst()
            '        End If

            '        Do While Not .EOF
            '            .Fields("IdComprobanteProveedor").Value = oCP.Id
            '            .Update()
            '            If .Fields("Eliminado").Value Then
            '                oDet.Eliminar(SC, "DetComprobantesProveedoresPrv", .Fields(0).Value)
            '            Else
            '                Datos = CreateObject("adodb.Recordset")
            '                For i = 0 To .Fields.Count - 2
            '                    With .Fields(i)
            '                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
            '                        Datos.Fields(.Name).Precision = .Precision
            '                        Datos.Fields(.Name).NumericScale = .NumericScale
            '                    End With
            '                Next
            '                Datos.Open()
            '                Datos.AddNew()
            '                For i = 0 To .Fields.Count - 2
            '                    With .Fields(i)
            '                        Datos.Fields(i).Value = .Value
            '                    End With
            '                Next
            '                Datos.Update()
            '                Resp = oDet.Guardar(SC, "DetComprobantesProveedoresPrv", Datos)
            '                Datos.Close()
            '                Datos = Nothing
            '            End If
            '            .MoveNext()
            '        Loop
            '    End If
            'End With

            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetComplete()
                End With
            End If

Salir:
            Guardar_CodigoOriginalDeVB6 = Resp
            oDet = Nothing
            oCont = Nothing
            oRsAux = Nothing
            On Error GoTo 0
            'If lErr Then
            '    Err.Raise(lErr, sSource, sDesc)
            'End If
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
            'oDet.Tarea("Log_InsertarRegistro", ArrayVB6("MTSCP", oCP.Id, 0, Now, 0, _
            '      "Error " & Err.Number & Err.Description & ", " & Err.Source, _
            '      "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
            Resume Salir


        End Function
        




        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ComprobanteProveedorList
            Return ComprobanteProveedorDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedor
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            'For Each item As ComprobanteProveedorItem In GetCopyOfItem.Detalles
            '    item.Id = -1
            'Next
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As ComprobanteProveedorList
            'Dim ComprobantePrvList As Pronto.ERP.BO.ComprobantePrvList = ComprobanteProveedorDB.GetListByEmployee(SC, IdSolicito)
            'If ComprobantePrvList IsNot Nothing Then
            '    Select Case orderBy
            '        'Case "Fecha"
            '        '    ComprobantePrvList.Sort(AddressOf Pronto.ERP.BO.ComprobantePrvList.CompareFecha)
            '        'Case "Obra"
            '        '    ComprobantePrvList.Sort(AddressOf Pronto.ERP.BO.ComprobantePrvList.CompareObra)
            '        'Case "Sector"
            '        '    ComprobantePrvList.Sort(AddressOf Pronto.ERP.BO.ComprobantePrvList.CompareSector)
            '        'Case Else 'Ordena por id
            '        '    ComprobantePrvList.Sort(AddressOf Pronto.ERP.BO.ComprobantePrvList.CompareId)
            '    End Select
            'End If
            'Return ComprobantePrvList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ComprobanteProveedorDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String, ByVal dtDesde As Date, ByVal dtHasta As Date) As DataView 'As DataTable



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            'Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With



            Dim dt = GetStoreProcedure(SC, enumSPs.ComprobantesProveedores_TXFecha, dtDesde, dtHasta, -1)


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With dt
                .Columns("IdComprobanteProveedor").ColumnName = "Id"
                '.Columns("ComprobantePrv").ColumnName = "Numero"
                '.Columns("FechaComprobantePrv").ColumnName = "Fecha"
            End With


            dt.DefaultView.Sort = "Id DESC"
            'Return dt.DefaultView.Table
            Return dt.DefaultView
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
                ds = GeneralDB.TraerDatos(SC, "wComprobantePrvs_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "ComprobantePrvs_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wComprobantePrvs_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "ComprobantePrvs_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function




















        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedor
            Return GetItem(SC, id, False)
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getComprobanteProveedorDetalles As Boolean) As ComprobanteProveedor
            Dim myComprobanteProveedor As ComprobanteProveedor
            myComprobanteProveedor = ComprobanteProveedorDB.GetItem(SC, id)
            If Not (myComprobanteProveedor Is Nothing) AndAlso getComprobanteProveedorDetalles Then
                Dim x As ComprobanteProveedorItemList = ComprobanteProveedorItemDB.GetList(SC, id)

                myComprobanteProveedor.DetallesProvincias = ComprobanteProveedorProvinciasItemDB.GetList(SC, id)


                TraerDatosDesnormalizados(SC, myComprobanteProveedor)

                If Not IsNothing(x) Then
                    For Each i As ComprobanteProveedorItem In x
                        If i.CuentaGastoDescripcion = "" Then

                            ' a diferencia de los detalles comunes, que se vinculan directamente con una tabla,
                            ' acá me tengo que traer la IdCuentaGasto a partir de la IdCuenta
                            Dim ds As System.Data.DataSet
                            Try
                                ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", i.IdCuenta) 'traigo los datos de la cuenta
                                ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "CuentasGastos", "TX_PorId", ds.Tables(0).Rows(0).Item("IdCuentaGasto"))
                                i.IdCuentaGasto = ds.Tables(0).Rows(0).Item("IdCuentaGasto")
                                i.CuentaGastoDescripcion = ds.Tables(0).Rows(0).Item("Descripcion")
                            Catch ex As Exception

                            End Try
                        End If
                    Next
                End If

                myComprobanteProveedor.Detalles = x
            End If
            Return myComprobanteProveedor
        End Function



        Private Shared Sub TraerDatosDesnormalizados(ByVal SC As String, ByRef myComprobantePrv As ComprobanteProveedor)
            'traigo las descripciones de los items
            'If Not IsNothing(myComprobantePrv.DetallesImputaciones) Then
            '    For Each i As ComprobanteProveedorItem In myComprobantePrv.DetallesImputaciones
            '        If i.IdImputacion > 0 Then
            '            Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
            '            i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
            '            i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
            '        Else
            '            i.TipoComprobanteImputado = "PA" 'pagoanticipado
            '        End If
            '    Next
            'End If

            'If Not IsNothing(myComprobantePrv.DetallesCuentas) Then
            '    For Each i As ComprobanteProveedorCuentasItem In myComprobantePrv.DetallesCuentas
            '        i.DescripcionCuenta = EntidadManager.NombreCuenta(SC, i.IdCuenta)
            '    Next
            'End If

            'If Not IsNothing(myComprobantePrv.DetallesValores) Then
            '    For Each i As ComprobanteProveedorValoresItem In myComprobantePrv.DetallesValores
            '        i.Tipo = EntidadManager.NombreValorTipo(SC, i.IdTipoValor)
            '    Next
            'End If

            'If Not IsNothing(myComprobantePrv.DetallesRubrosContables) Then
            '    For Each i As ComprobanteProveedorRubrosContablesItem In myComprobantePrv.DetallesRubrosContables
            '        i.DescripcionRubroContable = EntidadManager.NombreRubroContable(SC, i.IdRubroContable)
            '    Next
            'End If

        End Sub



        '<DataObjectMethod(DataObjectMethodType.Select, True)> _
        'Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorItemList
        'Dim list As ComprobanteProveedorItemList = ComprobantePrvItemDB.GetList(SC, id)
        'For Each i As ComprobanteProveedorItem In list
        '    If i.IdImputacion > 0 Then
        '        Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
        '        i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
        '        i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
        '    End If
        'Next
        'Return list
        'End Function





        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorItemList

            Dim x As ComprobanteProveedorItemList = ComprobanteProveedorItemDB.GetList(SC, id)
            For Each i As ComprobanteProveedorItem In x
                If i.CuentaGastoDescripcion = "" Then

                    ' a diferencia de los detalles comunes, que se vinculan directamente con una tabla,
                    ' acá me tengo que traer la IdCuentaGasto a partir de la IdCuenta
                    Dim ds As System.Data.DataSet
                    Try
                        ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", i.IdCuenta) 'traigo los datos de la cuenta
                        ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "CuentasGastos", "TX_PorId", ds.Tables(0).Rows(0).Item("IdCuentaGasto"))
                        i.IdCuentaGasto = ds.Tables(0).Rows(0).Item("IdCuentaGasto")
                        i.CuentaGastoDescripcion = ds.Tables(0).Rows(0).Item("Descripcion")
                    Catch ex As Exception

                    End Try
                End If
            Next

            Return x
        End Function



        'Public Shared Function ConvertirComProntoComprobantePrvAPuntoNET(ByVal oComprobantePrv 'As ComPronto.ComprobantePrv ) As Pronto.ERP.BO.ComprobantePrv
        '    'Dim oDest As New Pronto.ERP.BO.ComprobantePrv

        '    ''///////////////////////////
        '    ''///////////////////////////
        '    ''ENCABEZADO
        '    'With oComprobantePrv.Registro

        '    '    oDest.Id = oComprobantePrv.Id

        '    '    'oDest.Fecha = .Fields("FechaComprobantePrv").Value
        '    '    oDest.IdCliente = .Fields("IdCliente").Value

        '    '    'oDest.TipoFactura = .Fields("TipoABC").Value

        '    '    oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
        '    '    'oDest.Numero = .Fields("NumeroComprobantePrv").Value


        '    '    'oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
        '    '    'oDest.Total = .Fields("ImporteTotal").Value
        '    '    oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
        '    '    'oDest.IdCodigoIVA = iisNull(.Fields("Idcodigoiva").Value, 0)

        '    '    oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

        '    '    'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
        '    '    'oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
        '    '    'oDest.ImporteTotal = .Fields("ImporteTotal").Value
        '    'End With



        '    ''///////////////////////////
        '    ''///////////////////////////
        '    ''DETALLE
        '    'Dim rsDet As adodb.Recordset = oComprobantePrv.DetComprobantePrvs.TraerTodos

        '    'With rsDet
        '    '    If Not .EOF Then .MoveFirst()

        '    '    Do While Not .EOF

        '    '        Dim oDetComprobantePrv 'As ComPronto.DetComprobantePrv  = oComprobantePrv.DetComprobantePrvs.Item(rsDet.Fields("IdDetalleComprobantePrv"))

        '    '        Dim item As New ComprobantePrvItem


        '    '        With oDetComprobantePrv.Registro

        '    '            'item.IdConcepto = .Fields("IdConcepto").Value
        '    '            'item.Concepto = rsDet.Fields(3).Value
        '    '            item.ImporteTotalItem = .Fields("Importe").Value
        '    '            'item.gravado = .Fields("Gravado").Value
        '    '            'item.Precio = .Fields("IvaNoDiscriminado").Value
        '    '            'item.Precio = .Fields("PrecioUnitarioTotal").Value

        '    '        End With

        '    '        oDest.DetallesImputaciones.Add(item)
        '    '        .MoveNext()
        '    '    Loop

        '    'End With


        '    'Return oDest
        'End Function



        '<DataObjectMethod(DataObjectMethodType.Select, False)> _
        'Public Shared Function GetItemComPronto(ByVal SC As String, ByVal id As Integer, ByVal getComprobantePrvDetalles As Boolean) As ComprobanteProveedor
        '    Dim myComprobantePrv As ComprobanteProveedor
        '    'myComprobantePrv = ComprobanteProveedorDB.GetItem(SC, id)
        '    myComprobantePrv = New ComprobantePrv

        '    Dim Aplicacion = CrearAppCompronto(SC)
        '    'myComprobantePrv.__COMPRONTO_ComprobantePrv = Aplicacion.ComprobantePrvs.Item(id)

        '    myComprobantePrv = ConvertirComProntoComprobantePrvAPuntoNET(Aplicacion.ComprobantePrvs.Item(id))
        '    Return myComprobantePrv
        'End Function






        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myComprobantePrv As ComprobanteProveedor) As Boolean
            Return ComprobanteProveedorDB.Delete(SC, myComprobantePrv.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            'Return ComprobanteProveedorDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal Id As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
            Dim myComprobantePrv As Pronto.ERP.BO.ComprobanteProveedor = GetItem(SC, Id, True)

            With myComprobantePrv
                '.MotivoAnulacion = motivo
                '.FechaAnulacion = Today
                '.UsuarioAnulacion = IdUsuario
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                '.Cumplido = "AN"
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = IdUsuario

                'For Each i As ComprobanteProveedorItem In .DetallesImputaciones
                '    With i
                '        '.Cumplido = "AN"
                '        '.EnviarEmail = 1
                '    End With
                'Next






                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'TO DO: No encontré el campo CAE en la nota de debito
                'If iisNull(.CAE, "") <> "" Then
                '    Return "No puede anular un comprobante electronico (CAE)"
                'End If



                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                ''reviso si hay facturas que esten imputadas al remito que se quiere anular
                'Dim dr As DataRow
                'Try
                '    dr = EntidadManager.GetStoreProcedureTop1(SC, "CtasCtesD_TX_BuscarComprobante", Id, EntidadManager.IdTipoComprobante.ComprobantePrv)
                'Catch ex As Exception

                'End Try

                'If Not IsNothing(dr) Then
                '    If dr.Item("ImporteTotal") <> dr.Item("Saldo") Then
                '        Return "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse"
                '    End If
                'End If

                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////







                'If ExistenAnticiposAplicados() Then
                '    MsgBox("El ComprobantePrv contiene anticipos que en cuenta corriente han sido aplicados." & vbCrLf & _
                '          "No puede anular este ComprobantePrv", vbInformation)
                '    Exit Function
                'End If

                'Dim oRs As adodb.Recordset
                'Dim mError As String
                'oRs = Aplicacion.ComprobantePrvs.TraerFiltrado("_PorEstadoValores", mvarId)
                'mError = ""
                'If oRs.RecordCount > 0 Then
                '    mError = "El ComprobantePrv no puede anularse porque tiene valores ingresados "
                '    Do While Not oRs.EOF
                '        If oRs.Fields("Estado").Value = "E" Then
                '            mError = mError & "endosados "
                '        ElseIf oRs.Fields("Estado").Value = "D" Then
                '            mError = mError & "depositados "
                '        End If
                '        oRs.MoveNext()
                '    Loop
                'End If



                '.Anulado = EnumPRONTO_SiNo.SI '  "SI" ?????


                Save(SC, myComprobantePrv)
            End With


        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            'Return ComprobanteProveedorDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function






        Public Shared Function IsValid(ByVal SC As String, ByRef myComprobantePrv As ComprobanteProveedor, Optional ByRef ms As String = "") As Boolean

            With myComprobantePrv

                RecalcularTotales(myComprobantePrv)


                Dim eliminados As Integer
                'verifico el detalle
                For Each det As ComprobanteProveedorItem In .Detalles
                    If det.IdCuenta = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1

                Next

                If eliminados = .Detalles.Count Or .Detalles.Count = 0 Then
                    ms = "La lista de items no puede estar vacía"
                    Return False
                End If


                'For Each det As ComprobanteProveedorProvinciasItem In .DetallesProvincias

                '    If det.IdCuenta = 0 Then 'verifico que no pase un renglon en blanco
                '        det.Eliminado = True
                '    End If
                '    'If det.Eliminado Then eliminados = eliminados + 1
                'Next



                'For Each det As ComprobanteProveedorValoresItem In .DetallesValores
                '    If det.IdTipoValor = 0 And det.IdCaja = 0 Then 'verifico que no pase un renglon en blanco
                '        det.Eliminado = True
                '    End If
                '    'If det.Eliminado Then eliminados = eliminados + 1

                'Next

                'For Each det As ComprobanteProveedorRubrosContablesItem In .DetallesRubrosContables
                '    If det.IdRubroContable = 0 Then 'verifico que no pase un renglon en blanco
                '        det.Eliminado = True
                '    End If
                '    'If det.Eliminado Then eliminados = eliminados + 1

                'Next

                '          If DTFields(0).Value <= gblFechaUltimoCierre And _
                'Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
                '              MsgBox("La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation)
                '              Exit Function
                '          End If

                '          If Not IsNumeric(txtNumeroComprobantePrv.Text) Or Len(txtNumeroComprobantePrv.Text) = 0 Then
                '              MsgBox("No ingreso el numero de ComprobantePrv", vbCritical)
                '              Exit Function
                '          End If

                '          If Not IsNumeric(dcfields(10).BoundText) Or Len(dcfields(10).Text) = 0 Then
                '              MsgBox("No ha ingresado el punto de venta", vbCritical)
                '              Exit Function
                '          End If



                'If .Tipo = ComprobantePrv.tipoComprobantePrv.CC And (.DetallesImputaciones.Count = eliminados Or .DetallesImputaciones.Count = 0) Then
                '    ms = "La lista de items no puede estar vacía"
                '    Return False
                'End If

                'If Val(.NumeroComprobantePrv) = 0 Then
                '    ms = "Debe ingresar el numero de orden de compra del cliente"
                '    Return False
                'End If

                'If .TotalDiferencia <> 0 And Not .Tipo = ComprobantePrv.tipoComprobantePrv.OT Then
                '    ms = "El ComprobantePrv no cierra, ajuste los valores e intente nuevamente"
                '    Return False
                'End If

                '          If Val(Replace(txtTotal(1).Text, ",", "")) <> Val(Replace(txtTotal(2).Text, ",", "")) Then
                '              MsgBox("No balancea el registro contable", vbInformation)
                '              Exit Function
                '          End If

                '          If Lista.ListItems.Count = 0 And Not Option2.Value Then
                '              MsgBox("No se puede almacenar un ComprobantePrv sin detalles")
                '              Exit Function
                '          End If

                '          If Len(txtCotizacionMoneda.Text) = 0 Then
                '              MsgBox("No ingreso el valor de conversion a pesos", vbInformation)
                '              Exit Function
                '          End If

                '          If Val(txtCotizacionMoneda.Text) <= 0 Then
                '              MsgBox("La cotizacion debe ser mayor a cero", vbInformation)
                '              Exit Function
                '          End If

                '          If mvarCotizacion = 0 Then
                '              MsgBox("No hay cotizacion dolar al " & DTFields(0).Value, vbInformation)
                '              Exit Function
                '          End If

                '          If txtNumeroCertificadoRetencionGanancias.Visible Then
                '              If Len(txtNumeroCertificadoRetencionGanancias.Text) > 0 And Not IsNumeric(dcfields1(3).BoundText) Then
                '                  MsgBox("Debe indicar el tipo de retencion ganancias")
                '                  Exit Function
                '              End If
                '          End If

                '          If Option2.Value And Len(Combo1(0).Text) = 0 Then
                '              MsgBox("Debe indicar el tipo de operacion", vbInformation)
                '              Exit Function
                '          End If

                '          If mvarId > 0 Then
                '              If ExistenAnticiposAplicados() Then
                '                  MsgBox("Hay anticipos que en cuenta corriente tienen aplicado el saldo" & vbCrLf & _
                '                        "No puede modificar este ComprobantePrv", vbInformation)
                '                  Exit Function
                '              End If
                '          End If

                '          If mvarControlarRubrosContablesEnOP = "SI" Then
                '              If mvarTotalValores <> mvarTotalRubrosContables And _
                '                    (Not Combo1(0).Visible Or (Combo1(0).Visible And Combo1(0).ListIndex = 1)) Then
                '                  MsgBox("El total de rubros contables asignados debe ser igual al total de valores", vbExclamation)
                '                  Exit Function
                '              End If
                '          End If

                '          If Option1.Value Then
                '              If EstadoEntidad("Clientes", origen.Registro.Fields("IdCliente").Value) = "INACTIVO" Then
                '                  MsgBox("Cliente inhabilitado", vbExclamation)
                '                  Exit Function
                '              End If
                '          End If

                '          If ListaCta.ListItems.Count = 0 Then
                '              MsgBox("No hay registro contable, revise la definicion de cuentas utilizadas en este ComprobantePrv.", vbExclamation)
                '              Exit Function
                '          End If

                '          If Not (mvarId <= 0 And mNumeroComprobantePrvPagoAutomatico = "SI") Then
                '              oRs = Aplicacion.ComprobantePrvs.TraerFiltrado("Cod", Array(dcfields(10).Text, Val(txtNumeroComprobantePrv.Text)))
                '              If oRs.RecordCount > 0 Then
                '                  If oRs.Fields("IdComprobantePrv").Value <> mvarId Then
                '                      MsgBox("Numero de ComprobantePrv existente ( " & oRs.Fields("FechaComprobantePrv").Value & " )", vbCritical)
                '                      oRs.Close()
                '                      oRs = Nothing
                '                      Exit Function
                '                  End If
                '              End If
                '              oRs.Close()
                '          End If

                '          oRs = origen.DetComprobantePrvsCuentas.TodosLosRegistros
                '          If oRs.Fields.Count > 0 Then
                '              If oRs.RecordCount > 0 Then
                '                  oRs.MoveFirst()
                '                  Do While Not oRs.EOF
                '                      If Not oRs.Fields("Eliminado").Value Then
                '                          If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) = 0 Then
                '                              oRs = Nothing
                '                              MsgBox("Hay cuentas contables no definidas, no puede registrar el ComprobantePrv", vbExclamation)
                '                              Exit Function
                '                          End If
                '                      End If
                '                      oRs.MoveNext()
                '                  Loop
                '              End If
                '          End If
                '          oRs = Nothing

                '          Dim dc As DataCombo
                '          Dim dtp As DTPicker
                '          Dim est As EnumAcciones
                '          Dim i As Integer
                '          Dim mAux1 As String

                '          If mvarId > 0 Then
                '              oRs = Aplicacion.ComprobantePrvs.TraerFiltrado("_ValoresEnConciliacionesPorIdComprobantePrv", mvarId)
                '              If oRs.RecordCount > 0 Then
                '                  mAux1 = ""
                '                  oRs.MoveFirst()
                '                  Do While Not oRs.EOF
                '                      mAux1 = mAux1 & IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value) & " "
                '                      oRs.MoveNext()
                '                  Loop
                '                  MsgBox("Cuidado, hay valores en este ComprobantePrv que estan en" & vbCrLf & _
                '                        "la(s) conciliacion(es) : " & mAux1 & vbCrLf & _
                '                        "tome las precauciones del caso." & vbCrLf & _
                '                        "El mensaje es solo informativo.", vbExclamation)
                '              End If
                '              oRs.Close()
                '          End If

                '          oRs = Nothing

                '          With origen.Registro
                '              .Fields("NumeroComprobantePrv").Value = Val(txtNumeroComprobantePrv.Text)
                '              .Fields("PuntoVenta").Value = IIf(Len(dcfields(10).Text) > 0, Val(dcfields(10).Text), 1)
                '              .Fields("Cotizacion").Value = mvarCotizacion
                '              If IsNull(.Fields("Efectivo").Value) Then
                '                  .Fields("Efectivo").Value = 0
                '              End If
                '              If IsNull(.Fields("Valores").Value) Then
                '                  .Fields("Valores").Value = 0
                '              End If
                '              If IsNull(.Fields("Documentos").Value) Then
                '                  .Fields("Documentos").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionGanancias").Value) Then
                '                  .Fields("RetencionGanancias").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionIBrutos").Value) Then
                '                  .Fields("RetencionIBrutos").Value = 0
                '              End If
                '              If IsNull(.Fields("RetencionIVA").Value) Then
                '                  .Fields("RetencionIVA").Value = 0
                '              End If
                '              If IsNull(.Fields("GastosGenerales").Value) Then
                '                  .Fields("GastosGenerales").Value = 0
                '              End If

                '              If Check1.Value = 1 Then
                '                  .Fields("Dolarizada").Value = "SI"
                '              Else
                '                  .Fields("Dolarizada").Value = "NO"
                '              End If

                '              For Each dtp In DTFields
                '                  .Fields(dtp.DataField).Value = dtp.Value
                '              Next

                '              For Each dc In dcfields
                '                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 3 And _
                '                        dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 8 And dc.Index <> 10 And _
                '                        dc.Visible Then
                '                      MsgBox("Falta completar el campo " & dc.Tag, vbCritical)
                '                      Exit Function
                '                  End If
                '                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
                '              Next

                '              If Option1.Value Then
                '                  .Fields("Tipo").Value = "CC"
                '              Else
                '                  .Fields("Tipo").Value = "OT"
                '              End If

                '              If Check3.Value = 1 Then
                '                  .Fields("AsientoManual").Value = "SI"
                '              Else
                '                  .Fields("AsientoManual").Value = "NO"
                '              End If

                '              .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text

                '              If mvarId < 0 Then
                '                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
                '                  .Fields("FechaIngreso").Value = Now
                '              Else
                '                  .Fields("IdUsuarioModifico").Value = glbIdUsuario
                '                  .Fields("FechaModifico").Value = Now
                '              End If

                '              .Fields("Observaciones").Value = rchObservaciones.Text

                '              If Option2.Value Then
                '                  .Fields("TipoOperacionOtros").Value = Combo1(0).ListIndex
                '              Else
                '                  .Fields("TipoOperacionOtros").Value = Null
                '              End If

                '              .Fields("CuitOpcional").Value = Null
                '              If CUIT1.Visible Then .Fields("CuitOpcional").Value = CUIT1.Text
                '          End With

                '          If mvarId < 0 Then
                '              Dim mvarNumero As Long
                '              Dim oPar 'As ComPronto.Parametro 

                '              mvarNumero = origen.Registro.Fields("NumeroComprobantePrv").Value

                '              oPar = Aplicacion.Parametros.Item(1)
                '              With oPar.Registro
                '                  If IsNull(.Fields("NumeroComprobantePrvPagoAutomatico").Value) Or .Fields("NumeroComprobantePrvPagoAutomatico").Value = "SI" Then
                '                  Else
                '                      oPar = Nothing
                '                      oRs = Aplicacion.ComprobantePrvs.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(dcfields(10).BoundText, mvarNumero))
                '                      If oRs.RecordCount > 0 Then
                '                          oRs.Close()
                '                          MsgBox("El ComprobantePrv ya existe, verifique el numero")
                '                          Exit Function
                '                      End If
                '                      oRs.Close()
                '                  End If
                '              End With
                '              oPar = Nothing
                '          End If

            End With



            Return True
        End Function





        ''' <summary>
        ''' ' OJO: es el numero, no el ID del punto de venta. El ComprobantePrv es letra X, no necesita el IdCodigoIVA
        ''' </summary>
        ''' <param name="SC"></param>
        ''' <param name="NumeroDePuntoVenta"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Shared Function ProximoNumeroComprobantePrvPorNumeroDePuntoVenta(ByVal SC As String, ByVal NumeroDePuntoVenta As Integer) As Long

            Try
                ' la letra del ComprobantePrv de pago es X

                'averiguo el id del talonario 
                Dim IdPuntoVenta = IdPuntoVentaComprobanteComprobantePrvSegunSubnumero(SC, NumeroDePuntoVenta)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Return -1
            End Try

        End Function

        Shared Function IdPuntoVentaComprobanteComprobantePrvSegunSubnumero(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.ComprobantePrv)
            Return mvarPuntoVenta
        End Function

        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

            Dim oRs As adodb.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetComprobantePrvs", "TX_Req", IdComprobantePrv))

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

        Public Shared Function UltimoItemDetalle(ByVal myComprobantePrv As ComprobanteProveedor) As Integer

            'For Each i As ComprobanteProveedorItem In myComprobantePrv.DetallesImputaciones
            'If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            'Next

        End Function


        Public Shared Sub RefrescaTalonarioIVA(ByRef myComprobantePrv As ComprobanteProveedor)
            'myComprobantePrv.letra=

            ' If glbIdCodigoIva = 1 Then
            '     Select Case mvarTipoIVA
            '         Case 1
            '             mvarTipoABC = "A"
            '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            '         Case 2
            '             mvarTipoABC = "A"
            '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
            '             mvarIVA2 = Round(TSumaGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
            '         Case 3
            '             mvarTipoABC = "E"
            '         Case 8
            '             mvarTipoABC = "B"
            '         Case 9
            '             mvarTipoABC = "A"
            '         Case Else
            '             mvarTipoABC = "B"
            '     End Select
            ' Else
            '     mvarTipoABC = "C"
            ' End If

            'If .ctacte = 2 Then
            '    txtNumeroComprobantePrv2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaComprobantePrvInterna")
            'Else
            '    txtNumeroComprobantePrv2.Text = ComprobanteProveedorManager.ProximoNumeroComprobantePrvPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.Text) 'ParametroOriginal(SC, "ProximoFactura")
            'End If
        End Sub





        Public Function GuardarRegistroContable(ByVal RegistroContable As adodb.Recordset)

            Dim oCont ' As ObjectContext
            Dim oDet 'As iCompMTS
            Dim Resp 'As InterFazMTS.MisEstados
            Dim oRsComprobante As adodb.Recordset
            Dim Datos As adodb.Recordset
            Dim DatosAsiento As adodb.Recordset
            Dim DatosAsientoNv As adodb.Recordset
            Dim oRsParametros As adodb.Recordset
            Dim DatosDetAsiento As adodb.Recordset
            Dim DatosDetAsientoNv As adodb.Recordset
            Dim oFld As adodb.Field
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

            'With RegistroContable
            '    If .State <> adStateClosed Then
            '        If .RecordCount > 0 Then
            '            .Update()
            '            .MoveFirst()
            '            oRsComprobante = oDet.LeerUno(sc,"ComprobantePrvs", RegistroContable.Fields("IdComprobante").Value)
            '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
            '            oRsComprobante.Close()
            '            oRsComprobante = Nothing
            '        End If
            '        Do While Not .EOF
            '            If Not IsNull(.Fields("Debe").Value) Then
            '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
            '                .Update()
            '                mvarDebe = mvarDebe + .Fields("Debe").Value
            '            End If
            '            If Not IsNull(.Fields("Haber").Value) Then
            '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
            '                .Update()
            '                mvarHaber = mvarHaber + .Fields("Haber").Value
            '            End If
            '            .MoveNext()
            '        Loop
            '        If .RecordCount > 0 Then
            '            .MoveFirst()
            '            If mvarDebe - mvarHaber <> 0 Then
            '                If Not IsNull(.Fields("Debe").Value) Then
            '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
            '                Else
            '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
            '                End If
            '            End If
            '        End If
            '        Do While Not .EOF
            '            Datos =
            '            For i = 0 To .Fields.Count - 1
            '                With .Fields(i)
            '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
            '                    Datos.Fields(.Name).Precision = .Precision
            '                    Datos.Fields(.Name).NumericScale = .NumericScale
            '                End With
            '            Next
            '            Datos.Open()
            '            Datos.AddNew()
            '            For i = 0 To .Fields.Count - 1
            '                With .Fields(i)
            '                    Datos.Fields(i).Value = .Value
            '                End With
            '            Next
            '            Datos.Update()
            '            Resp = oDet.Guardar("Subdiarios", Datos)
            '            Datos.Close()
            '            Datos = Nothing
            '            .MoveNext()
            '        Loop
            '    End If
            'End With

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

        Private Shared Sub RecalcularRegistroContable_SubRecalculoAutomatico(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor, ByRef oRsCont As DataTable, _
                                        ByVal mvarCliente As Long, ByVal mvarCuentaClienteMonedaLocal As Long, _
                                        ByVal mvarCuentaClienteMonedaExtranjera As Long, _
                                        ByVal mvarEjercicio As Long, ByVal mvarCuentaCajaTitulo As Long, ByVal mvarCuentaCliente As Long)


            Dim oSrv 'As InterFazMTS.iCompMTS
            Dim oRs As DataRow
            Dim oRsDetCtas As adodb.Recordset
            Dim oRsAux As adodb.Recordset
            Dim oFld As adodb.Field
            Dim mvarCuentaCaja As Long
            Dim mvarCuentaValores As Long, mvarCuentaRetencionIva As Long
            Dim mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
            Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
            Dim mvarCuentaReventas As Long, mvarCuentaDescuentos As Long
            Dim mvarCuentaDescuentosyRetenciones As Long, mvarCuenta As Long
            Dim mvarCuentaValoresTitulo As Long
            Dim mvarCuentaDescuentosyRetencionesTitulo As Long
            Dim mvarTotalValores As Double
            Dim mvarAux1 As Double, mvarAux2 As Double
            Dim mvarDetalleValor As String
            Dim mvarEsta As Boolean
            Dim mvarIdMonedaPesos As Integer
            Dim mvarTotalMonedaLocal As Double, mvarTotalMonedaExtranjera As Double

            oSrv = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

















        End Sub

        Public Shared Function RecalcularRegistroContable(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As adodb.Recordset

            Dim oRsCont As adodb.Recordset
            Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
            Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
            Dim mvarCliente As Double
            Dim mvarCuentaCliente As Long

            IsValid(SC, oCP) 'para marcar los vacios

            mvarCuentaClienteMonedaLocal = 0
            mvarCuentaClienteMonedaExtranjera = 0
            mvarCliente = 0




            Dim oSrv As New ICompMTSManager
            Dim oRs As adodb.Recordset
            Dim oRsDet As adodb.Recordset
            Dim oRsDetBD As adodb.Recordset
            Dim oFld As adodb.Field
            Dim mvarCuentaCompras As Long, mvarCuentaProveedor As Long
            Dim mvarCuentaBonificaciones As Long, mvarCuentaIvaInscripto As Long
            Dim mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
            Dim mvarCuentaComprasTitulo As Long, mvarIdCuenta As Long
            Dim mvarCuentaReintegros As Long
            Dim mvarTotalCompra As Double, mvarImporte As Double, mvarDecimales As Integer
            Dim mvarPorcentajeIVA As Double, mvarIVA1 As Double, mvarAjusteIVA As Double
            Dim mvarTotalIVANoDiscriminado As Double, mvarDebe As Double, mvarHaber As Double
            Dim mIdTipoComprobante As Integer, mCoef As Integer, i As Integer
            Dim mvarEsta As Boolean, mvarSubdiarios_ResumirRegistros As Boolean

            'oSrv = 

            mIdTipoComprobante = oCP.IdTipoComprobante
            oRs = oSrv.LeerUno(SC, "TiposComprobante", mIdTipoComprobante)
            mCoef = oRs.Fields("Coeficiente").Value
            oRs.Close()

            'oRs = oSrv.LeerUno(SC, "Parametros", 1)
            Dim oParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

            mvarEjercicio = oParam.Item("EjercicioActual")
            mvarCuentaCompras = oParam.Item("IdCuentaCompras")
            mvarCuentaComprasTitulo = oParam.Item("IdCuentaComprasTitulo")
            mvarCuentaBonificaciones = oParam.Item("IdCuentaBonificaciones")
            mvarCuentaIvaInscripto = oParam.Item("IdCuentaIvaCompras")
            mvarCuentaIvaNoInscripto = oParam.Item("IdCuentaIvaCompras")
            mvarCuentaIvaSinDiscriminar = oParam.Item("IdCuentaIvaSinDiscriminar")
            mvarDecimales = oParam.Item("Decimales")
            mvarCuentaProveedor = iisNull(oParam.Item("IdCuentaAcreedoresVarios"), 0)
            If IsNull(oParam.Item("Subdiarios_ResumirRegistros")) Or _
                  oParam.Item("Subdiarios_ResumirRegistros") = "SI" Then
                mvarSubdiarios_ResumirRegistros = True
            Else
                mvarSubdiarios_ResumirRegistros = False
            End If
            mvarCuentaReintegros = iisNull(oParam.Item("IdCuentaReintegros"), 0)


            If oCP.IdProveedor > 0 Then
                oRs = oSrv.LeerUno(SC, "Proveedores", oCP.IdProveedor)
                If Not IsNull(oRs.Fields("IdCuenta").Value) Then
                    mvarCuentaProveedor = oRs.Fields("IdCuenta").Value
                End If
                oRs.Close()
            ElseIf oCP.IdCuenta > 0 Then
                mvarCuentaProveedor = oCP.IdCuenta
            ElseIf oCP.IdCuentaOtros > 0 Then
                mvarCuentaProveedor = oCP.IdCuentaOtros
            End If

            mvarAjusteIVA = IIf(IsNull(oCP.AjusteIVA), 0, oCP.AjusteIVA)

            oRsCont = CreateObject("adodb.Recordset")
            oRs = oSrv.TraerFiltrado(SC, "Subdiarios", "_Estructura")

            With oRs
                For Each oFld In .Fields
                    With oFld
                        oRsCont.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                        oRsCont.Fields.Item(.Name).Precision = .Precision
                        oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
                    End With
                Next
                oRsCont.Open()
            End With
            oRs.Close()

            If Not IsNull(oCP.Confirmado) And _
                  oCP.Confirmado = "NO" Then
                GoTo Salida
            End If

            With oRsCont
                .AddNew()
                .Fields("Ejercicio").Value = mvarEjercicio
                .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                .Fields("IdCuenta").Value = mvarCuentaProveedor
                .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                .Fields("IdComprobante").Value = oCP.Id
                If mCoef = 1 Then
                    .Fields("Haber").Value = oCP.TotalComprobante
                Else
                    .Fields("Debe").Value = oCP.TotalComprobante
                End If
                .Update()
            End With

            If oCP.TotalBonificacion <> 0 Then
                With oRsCont
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                    .Fields("IdCuenta").Value = mvarCuentaBonificaciones
                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                    .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                    .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                    .Fields("IdComprobante").Value = oCP.Id
                    If mCoef = 1 Then
                        .Fields("Haber").Value = oCP.TotalBonificacion
                    Else
                        .Fields("Debe").Value = oCP.TotalBonificacion
                    End If
                    .Update()
                End With
            End If

            '   If Not IsNull(oCP.TotalIva1) Then
            '      If oCP.TotalIva1 <> 0 Then
            '         With oRsCont
            '            .AddNew
            '            .Fields("Ejercicio").Value = mvarEjercicio
            '            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            '            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
            '            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            '            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
            '            .Fields("FechaComprobante").Value = oCP.FechaComprobante
            '            .Fields("IdComprobante").Value = oCP.Id
            '            If mCoef = 1 Then
            '               .Fields("Debe").Value = oCP.TotalIva1
            '            Else
            '               .Fields("Haber").Value = oCP.TotalIva1
            '            End If
            '            .Update
            '         End With
            '      End If
            '   End If

            '   If Not IsNull(oCP.TotalIva2) Then
            '      If oCP.TotalIva2 <> 0 Then
            '         With oRsCont
            '            .AddNew
            '            .Fields("Ejercicio").Value = mvarEjercicio
            '            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
            '            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
            '            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
            '            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
            '            .Fields("FechaComprobante").Value = oCP.FechaComprobante
            '            .Fields("IdComprobante").Value = oCP.Id
            '            If mCoef = 1 Then
            '               .Fields("Debe").Value = oCP.TotalIva2
            '            Else
            '               .Fields("Haber").Value = oCP.TotalIva2
            '            End If
            '            .Update
            '         End With
            '      End If
            '   End If

            For Each iDet As ComprobanteProveedorItem In oCP.Detalles

                If Not iDet.Eliminado Then
                    With oRsCont

                        mvarTotalIVANoDiscriminado = 0

                        For i = 1 To 10
                            If CallByName(iDet, "AplicarIVA" & i, CallType.Get) = "SI" Then
                                mvarImporte = iDet.Importe
                                mvarPorcentajeIVA = iisNull(CallByName(iDet, "IVAComprasPorcentaje" & i, CallType.Get), 0)
                                If oCP.Letra = "A" Or oCP.Letra = "M" Then
                                    mvarIVA1 = Math.Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
                                Else
                                    mvarIVA1 = Math.Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
                                    mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
                                End If
                                If mvarAjusteIVA <> 0 Then
                                    mvarIVA1 = mvarIVA1 + mvarAjusteIVA
                                    mvarAjusteIVA = 0
                                    oCP.PorcentajeIVAAplicacionAjuste = mvarPorcentajeIVA
                                    'Registro.Update()
                                End If
                                mvarDebe = 0
                                mvarHaber = 0
                                If mCoef = 1 Then
                                    If mvarIVA1 >= 0 Then
                                        mvarDebe = mvarIVA1
                                    Else
                                        mvarHaber = mvarIVA1 * -1
                                    End If
                                Else
                                    If mvarIVA1 >= 0 Then
                                        mvarHaber = mvarIVA1
                                    Else
                                        mvarDebe = mvarIVA1 * -1
                                    End If
                                End If
                                mvarEsta = False
                                If .RecordCount > 0 Then
                                    .MoveFirst()
                                    Do While Not .EOF
                                        If .Fields("IdCuenta").Value = CallByName(iDet, "IdCuentaIvaCompras" & i, CallType.Get) And _
                                              ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
                                                 (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
                                            mvarEsta = True
                                            Exit Do
                                        End If
                                        .MoveNext()
                                    Loop
                                End If
                                If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew()
                                .Fields("Ejercicio").Value = mvarEjercicio
                                .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                                .Fields("IdCuenta").Value = CallByName(iDet, "IdCuentaIvaCompras" & i, CallType.Get)
                                .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                                .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                                .Fields("IdComprobante").Value = oCP.Id
                                If mvarDebe <> 0 Then
                                    .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
                                Else
                                    .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
                                End If
                                If Not mvarSubdiarios_ResumirRegistros Then
                                    .Fields("IdDetalleComprobante").Value = iDet.Id
                                End If
                                .Update()
                            End If
                        Next

                        mvarDebe = 0
                        mvarHaber = 0
                        If mCoef = 1 Then
                            mvarDebe = iDet.Importe - mvarTotalIVANoDiscriminado
                        Else
                            mvarHaber = iDet.Importe - mvarTotalIVANoDiscriminado
                        End If
                        mvarIdCuenta = mvarCuentaCompras
                        If Not IsNull(iDet.IdCuenta) Then
                            mvarIdCuenta = iDet.IdCuenta
                        End If
                        mvarEsta = False
                        If .RecordCount > 0 Then
                            .MoveFirst()
                            Do While Not .EOF
                                If .Fields("IdCuenta").Value = mvarIdCuenta And _
                                      ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
                                         (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
                                    mvarEsta = True
                                    Exit Do
                                End If
                                .MoveNext()
                            Loop
                        End If
                        If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                        .Fields("IdCuenta").Value = mvarIdCuenta
                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                        .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                        .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                        .Fields("IdComprobante").Value = oCP.Id
                        If mvarDebe <> 0 Then
                            If mvarDebe > 0 Then
                                .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
                            Else
                                .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + (mvarDebe * -1)
                            End If
                        Else
                            If mvarHaber > 0 Then
                                .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
                            Else
                                .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + (mvarHaber * -1)
                            End If
                        End If
                        If Not mvarSubdiarios_ResumirRegistros Then
                            .Fields("IdDetalleComprobante").Value = iDet.Id
                        End If
                        .Update()


                    End With
                End If
            Next

            oRsDetBD = oSrv.TraerFiltrado(SC, "DetComprobantesProveedores", "_PorIdCabecera", oCP.Id)
            With oRsDetBD
                If .RecordCount > 0 Then
                    .MoveFirst()
                    Do While Not .EOF
                        mvarEsta = False


                        For Each iDet As ComprobanteProveedorItem In oCP.Detalles
                            If .Fields(0).Value = iDet.Id Then
                                mvarEsta = True
                                Exit Do
                            End If
                        Next

                        If Not mvarEsta Then
                            With oRsCont
                                .AddNew()
                                .Fields("Ejercicio").Value = mvarEjercicio
                                .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                                If Not IsNull(oRsDetBD.Fields("IdCuenta").Value) Then
                                    .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuenta").Value
                                Else
                                    .Fields("IdCuenta").Value = mvarCuentaCompras
                                End If
                                .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                                .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                                .Fields("IdComprobante").Value = oCP.Id
                                If mCoef = 1 Then
                                    .Fields("Debe").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                                Else
                                    .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
                                End If
                                If Not mvarSubdiarios_ResumirRegistros Then
                                    .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
                                End If
                                .Update()

                                mvarTotalIVANoDiscriminado = 0

                                For i = 1 To 10
                                    If oRsDetBD.Fields("AplicarIVA" & i).Value = "SI" Then
                                        mvarImporte = oRsDetBD.Fields("Importe").Value
                                        mvarPorcentajeIVA = IIf(IsNull(oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value)
                                        If oCP.Letra = "A" Or oCP.Letra = "M" Then
                                            mvarIVA1 = Math.Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
                                        Else
                                            mvarIVA1 = Math.Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
                                            mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
                                        End If
                                        If mvarAjusteIVA <> 0 Then
                                            mvarIVA1 = mvarIVA1 + mvarAjusteIVA
                                            mvarAjusteIVA = 0
                                            oCP.PorcentajeIVAAplicacionAjuste = mvarPorcentajeIVA
                                            'Registro.Update()
                                        End If
                                        .AddNew()
                                        .Fields("Ejercicio").Value = mvarEjercicio
                                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                                        .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuentaIvaCompras" & i).Value
                                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                                        .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                                        .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                                        .Fields("IdComprobante").Value = oCP.Id
                                        If mCoef = 1 Then
                                            If mvarIVA1 >= 0 Then
                                                .Fields("Debe").Value = mvarIVA1
                                            Else
                                                .Fields("Haber").Value = mvarIVA1 * -1
                                            End If
                                        Else
                                            If mvarIVA1 >= 0 Then
                                                .Fields("Haber").Value = mvarIVA1
                                            Else
                                                .Fields("Debe").Value = mvarIVA1 * -1
                                            End If
                                        End If
                                        If Not mvarSubdiarios_ResumirRegistros Then
                                            .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
                                        End If
                                        .Update()
                                    End If
                                Next

                            End With
                        End If
                        .MoveNext()
                    Loop
                End If
                .Close()
            End With
            oRsDetBD = Nothing


            If oCP.ReintegroIdCuenta > 0 Then
                If oCP.ReintegroImporte <> 0 Then
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                        .Fields("IdCuenta").Value = mvarCuentaReintegros
                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                        .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                        .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                        .Fields("IdComprobante").Value = oCP.Id
                        If mCoef = 1 Then
                            .Fields("Haber").Value = oCP.ReintegroImporte
                        Else
                            .Fields("Debe").Value = oCP.ReintegroImporte
                        End If
                        .Update()
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
                        .Fields("IdCuenta").Value = oCP.ReintegroIdCuenta
                        .Fields("IdTipoComprobante").Value = mIdTipoComprobante
                        .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
                        .Fields("FechaComprobante").Value = oCP.FechaRecepcion
                        .Fields("IdComprobante").Value = oCP.Id
                        If mCoef = 1 Then
                            .Fields("Debe").Value = oCP.ReintegroImporte
                        Else
                            .Fields("Haber").Value = oCP.ReintegroImporte
                        End If
                        .Update()
                    End With
                End If
            End If

            '   mvarDebe = 0
            '   mvarHaber = 0
            '   With oRsCont
            '      If .RecordCount > 0 Then
            '         .MoveFirst
            '         Do While Not .EOF
            '            If Not IsNull(.Fields("Debe").Value) Then
            '               mvarDebe = mvarDebe + .Fields("Debe").Value
            '            End If
            '            If Not IsNull(.Fields("Haber").Value) Then
            '               mvarHaber = mvarHaber + .Fields("Haber").Value
            '            End If
            '            .MoveNext
            '         Loop
            '         If mvarDebe - mvarHaber <> 0 Then
            '            .MoveFirst
            '            Do While Not .EOF
            '               If Not IsNull(.Fields("Debe").Value) And _
            '                     .Fields("Debe").Value > 0 And mCoef = -1 Then
            '                  .Fields("Debe").Value = .Fields("Debe").Value + (mvarDebe - mvarHaber)
            '                  .Update
            '                  Exit Do
            '               End If
            '               If Not IsNull(.Fields("Haber").Value) And _
            '                     .Fields("Haber").Value > 0 And mCoef = 1 Then
            '                  .Fields("Haber").Value = .Fields("Haber").Value + (mvarDebe - mvarHaber)
            '                  .Update
            '                  Exit Do
            '               End If
            '               .MoveNext
            '            Loop
            '         End If
            '         .MoveFirst
            '      End If
            '   End With

Salida:

            RecalcularRegistroContable = oRsCont

            oRsDet = Nothing
            oRs = Nothing
            oRsCont = Nothing
            oSrv = Nothing



        End Function














        Public Shared Sub RecalcularTotales(ByRef myComprobantePrv As ComprobanteProveedor)


            Dim oRs As adodb.Recordset

            Dim i As Integer
            Dim mImporte As Double, mPorcentajeIVA As Double

            Dim mvarSubTotal, mvarIVA1, mvarIVA2 As Single
            Dim mvarIVANoDiscriminado, mvarTotalComprobanteProveedor, mvarAjusteIVA As Single

            With myComprobantePrv

                mvarSubTotal = 0
                mvarIVANoDiscriminado = 0
                mvarIVA1 = 0
                If .Letra <> "A" And .Letra <> "M" Then mvarIVA1 = 0
                mvarIVA2 = 0
                mvarTotalComprobanteProveedor = 0
                mvarAjusteIVA = 0

                For Each oL As ComprobanteProveedorItem In .Detalles
                    With oL
                        If Not .Eliminado Then
                            '            mvarSubTotal = mvarSubTotal + Val(oL.ListSubItems(3))
                            '            If Val(oL.ListSubItems(2)) <> 0 And (Not mSenialIVA Or Len(txtTotal(1).Text) = 0) Then
                            '               mvarIVA1 = mvarIVA1 + Round(Val(oL.ListSubItems(3)) * Val(oL.ListSubItems(2)) / 100, mvarDecimales)
                            '               mSenialIVA = False
                            '            End If

                            mImporte = .Importe
                            mvarSubTotal = mvarSubTotal + mImporte
                            For i = 1 To 10

                                If CallByName(oL, ("AplicarIVA" & i), CallType.Get) = "SI" Then
                                    mPorcentajeIVA = CallByName(oL, ("IVAComprasPorcentaje" & i), CallType.Get)
                                    If myComprobantePrv.Letra = "A" Or myComprobantePrv.Letra = "M" Then
                                        mvarIVA1 = mvarIVA1 + Math.Round(mImporte * mPorcentajeIVA / 100, 2)
                                    Else
                                        mvarIVANoDiscriminado = mvarIVANoDiscriminado + Math.Round(mImporte - (mImporte / (1 + (mPorcentajeIVA / 100))), 2)
                                    End If
                                End If
                            Next
                        End If
                    End With
                Next

                mvarAjusteIVA = .AjusteIVA
                mvarTotalComprobanteProveedor = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarAjusteIVA


                .TotalBruto = mvarSubTotal
                .TotalIva1 = mvarIVA1
                .TotalIva2 = mvarIVA2
                .TotalComprobante = mvarTotalComprobanteProveedor





            End With
        End Sub



        Public Shared Sub AgregarImputacionSinAplicacionOPagoAnticipado(ByRef myComprobantePrv As ComprobanteProveedor)

            With myComprobantePrv
                'If mvarId > 0 Then
                '    MsgBox("No puede modificar una nota de credito ya registrada!", vbCritical)
                '    Exit Sub
                'End If

                'If Len(Trim(dcfields(0).BoundText)) = 0 Then
                '    MsgBox("Falta completar el campo cliente", vbCritical)
                '    Exit Sub
                'End If

                'If Len(Trim(txtNumeroNotaCredito.Text)) = 0 Then
                '    MsgBox("Falta completar el campo numero de nota de credito", vbCritical)
                '    Exit Sub
                'End If


                Dim oRs As adodb.Recordset
                Dim mvarDif As Double

                'RecalcularTotales(myComprobantePrv)
                'mvarDif = Math.Round(.TotalValores - .TotalImputaciones, 2)

                'If mvarDif > 0 Then
                '    Dim mItemImp As ComprobanteProveedorItem = New ComprobantePrvItem
                '    mItemImp.Id = -1
                '    mItemImp.Nuevo = True
                '    mItemImp.IdImputacion = -1
                '    mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "PA"
                '    mItemImp.Importe = mvarDif
                '    mvarDif = 0
                '    .DetallesImputaciones.Add(mItemImp)
                'End If

                RecalcularTotales(myComprobantePrv)
            End With
        End Sub


        Public Shared Function FaltanteDePagar(ByRef myComprobantePrv As ComprobanteProveedor) As Double

            'With myComprobantePrv
            '    Dim mvarDif As Double

            '    RecalcularTotales(myComprobantePrv)
            '    mvarDif = Math.Round(.TotalImputaciones - .TotalValores, 2)
            '    If mvarDif < 0 Then mvarDif = 0
            '    Return mvarDif

            'End With
        End Function












    End Class





End Namespace