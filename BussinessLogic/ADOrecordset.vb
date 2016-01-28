Imports Pronto.ERP.BO
Imports Excel = Microsoft.Office.Interop.Excel
Imports Microsoft.Office.Interop.Excel

Imports Word = Microsoft.Office.Interop.Word

Imports Microsoft.Office.Interop.Word.WdUnits
Imports Microsoft.Office.Interop.Word.WdGoToItem



Imports ADODB.DataTypeEnum
Imports ADODB.ExecuteOptionEnum
Imports ADODB.LockTypeEnum

Imports ClaseMigrar.Office
Imports ClaseMigrar
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager

'Public Module MigrarGenerales
'    Public Function CircuitoFirmasCompleto(ByVal SC As String, ByVal Comprobante As EnumFormularios, _
'                                        ByVal IdComprobante As Long, _
'                                        Optional ByVal Importe As Double = Nothing) As Boolean




'        Return True


'        Dim oRsAut1 As ADODB.Recordset
'        Dim oRsAut2 As ADODB.Recordset
'        Dim mCompleto As Boolean
'        Dim mCantidadFirmas As Integer
'        Dim i As Integer
'        Dim mFirmas() As Boolean

'        mCompleto = False


'        oRsAut1 = EntidadManager.GetListTX(SC, "Autorizaciones", "TX_CantidadAutorizaciones", Comprobante, Importe)

'        If oRsAut1.RecordCount > 0 Then

'            mCantidadFirmas = oRsAut1.RecordCount
'            ReDim mFirmas(mCantidadFirmas)
'            For i = 1 To mCantidadFirmas
'                mFirmas(i) = False
'            Next

'            oRsAut2 = EntidadManager.GetListTX(SC, "AutorizacionesPorComprobante", "TX_AutorizacionesPorComprobante", Comprobante, IdComprobante)

'            With oRsAut2
'                If .RecordCount > 0 Then
'                    .MoveFirst()
'                    Do While Not .EOF
'                        oRsAut1.MoveFirst()
'                        Do While Not oRsAut1.EOF
'                            If oRsAut1.Fields(0).Value = .Fields("OrdenAutorizacion").Value Then
'                                mFirmas(oRsAut1.AbsolutePosition) = True
'                                Exit Do
'                            End If
'                            oRsAut1.MoveNext()
'                        Loop
'                        .MoveNext()
'                    Loop
'                End If
'                oRsAut2.Close()
'            End With

'            CircuitoFirmasCompleto = True

'            If Comprobante = EnumFormularios.RecepcionMateriales Then
'                oRsAut2 = GetStoreProcedure(SC, enumSPs.Requerimientos_TX_PorId, IdComprobante)
'                If oRsAut2.RecordCount > 0 Then
'                    If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
'                        oRsAut2.Close()
'                        GoTo Salida
'                    End If
'                    oRsAut2.Close()
'                End If
'            ElseIf Comprobante = EnumFormularios.NotaPedido Then
'                'oRsAut2 = PedidoManager.GetListTX(SC, "_PorId", IdComprobante)
'                oRsAut2 = EntidadManager.GetListTX(SC, "Pedidos", "_PorId", IdComprobante)

'                If oRsAut2.RecordCount > 0 Then
'                    If IIf(IsNull(oRsAut2.Fields("CircuitoFirmasCompleto").Value), "NO", oRsAut2.Fields("CircuitoFirmasCompleto").Value) = "SI" Then
'                        oRsAut2.Close()
'                        GoTo Salida
'                    End If
'                    oRsAut2.Close()
'                End If
'            End If

'            For i = 1 To mCantidadFirmas
'                If Not mFirmas(i) Then
'                    CircuitoFirmasCompleto = False
'                    Exit For
'                End If
'            Next

'        Else

'            CircuitoFirmasCompleto = True

'        End If

'Salida:
'        oRsAut1.Close()

'        oRsAut1 = Nothing
'        oRsAut2 = Nothing

'    End Function
'End Module

'Public Module MigrarComprobantesProveedores

'    Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetComprobantePrvs", "TX_Req", IdComprobantePrv))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function

'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetComprobantePrvs", "TX_Req", IdComprobantePrv))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'    Public Function GuardarNoConfirmados(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As ICompMTSManager.MisEstados

'        Dim oCont 'As ObjectContext
'        Dim oDet As ICompMTSManager
'        Dim Resp As ICompMTSManager.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim Datos As ADODB.Recordset
'        Dim i As Integer
'        Dim oFld As ADODB.Field

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        Resp = oDet.GuardarPorRef(SC, "ComprobantesProveedores", oCP)

'        'With Detalles

'        '    If .State <> adStateClosed Then

'        '        If Not .EOF Then
'        '            .Update()
'        '            .MoveFirst()
'        '        End If

'        '        Do While Not .EOF

'        '            .Fields("IdComprobanteProveedor").Value = ComprobanteProveedor.Fields(0).Value
'        '            .Update()

'        '            If .Fields("Eliminado").Value Then
'        '                oDet.Eliminar(sc, "DetComprobantesProveedores", .Fields(0).Value)
'        '            Else
'        '                Datos = CreateObject("adodb.Recordset")
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'        '                        Datos.Fields(.Name).Precision = .Precision
'        '                        Datos.Fields(.Name).NumericScale = .NumericScale
'        '                    End With
'        '                Next
'        '                Datos.Open()
'        '                Datos.AddNew()
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields(i).Value = .Value
'        '                    End With
'        '                Next
'        '                Datos.Update()
'        '                Resp = oDet.Guardar(sc, "DetComprobantesProveedores", Datos)
'        '                Datos.Close()
'        '                Datos = Nothing
'        '            End If

'        '            .MoveNext()

'        '        Loop

'        '    End If

'        'End With

'        'If Not oCont Is Nothing Then
'        '    With oCont
'        '        If .IsInTransaction Then .SetComplete()
'        '    End With
'        'End If

'Salir:
'        GuardarNoConfirmados = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        'If lErr Then
'        '    Err.Raise(lErr, sSource, sDesc)
'        'End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function


'    Public Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor)
'        '            'todo esto estaba en el mts



'        Dim oCont 'As ObjectContext
'        Dim oDet As ICompMTSManager
'        Dim Resp ' As InterFazMTS.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim Datos As DataTable
'        Dim DatosAnt As DataTable
'        Dim DatosCtaCte As DataTable
'        Dim DatosCtaCteNv As DataTable
'        Dim DatosCliente As Cliente
'        Dim oRsValores As DataTable
'        Dim oRsValoresNv As DataTable
'        Dim oRsComp As DataTable
'        Dim DatosAsiento As DataTable
'        Dim DatosAsientoNv As DataTable
'        Dim oRsParametros As DataRow
'        Dim DatosDetAsiento As DataTable
'        Dim DatosDetAsientoNv As DataTable
'        Dim oRsAux As DataTable
'        Dim oFld As ADODB.Field
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
'        Dim mIdDetalleComprobantePrv As Long, mIdValor As Long, mvarIdCuenta As Long
'        Dim mIdDetalleComprobantePrvValores As Long, mvarIdMonedaPesos As Long
'        Dim mvarIdDetalleComprobantePrvCuentas As Long, mvarIdBanco As Long
'        Dim Tot As Decimal, TotDol As Decimal, Sdo As Decimal, SdoDol As Decimal
'        Dim mPagadoParteEnDolares As Double, mDeudores As Double, mvarCotizacion As Double
'        Dim mvarCotizacionMoneda As Double, mvarCotizacionMonedaAnt As Double
'        Dim mvarDebe As Double, mvarHaber As Double
'        Dim mvarProcesa As Boolean, mvarLlevarAPesosEnValores As Boolean
'        Dim mvarBorrarEnValores As Boolean, mvarAnulada As Boolean
'        Dim mvarEsCajaBanco As String



'    End Function

'    Public Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As ICompMTSManager.MisEstados
'        '            'todo esto estaba en el mts



'        Dim RegistroContable As ADODB.Recordset = ComprobanteProveedorManager.RecalcularRegistroContable(SC, oCP)

'        If Not IsNull(oCP.Confirmado) And _
'              oCP.Confirmado = "NO" Then
'            Guardar_CodigoOriginalDeVB6 = GuardarNoConfirmados(SC, oCP)
'            Exit Function
'        End If




'        Dim oCont 'As ObjectContext
'        Dim oDet As New ICompMTSManager
'        Dim Resp As ICompMTSManager.MisEstados
'        Dim Datos As ADODB.Recordset
'        Dim DatosCtaCte As ADODB.Recordset
'        Dim DatosCtaCteNv As ADODB.Recordset
'        Dim DatosProveedor As ADODB.Recordset
'        Dim DetRem As ADODB.Recordset
'        Dim DatosAnt As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oRsValores As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer, mvarCoeficiente As Integer, mvarCoeficienteAnt As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
'        Dim mvarIdCuenta As Long, mIdValor As Long, mvarIdProveedorAnterior As Long
'        Dim mvarIdTipoComprobanteAnterior As Long, mvarIdBanco As Long, mvarIdCaja As Long
'        Dim mvarIdOrdenPagoActual As Long, mvarIdOrdenPagoAnterior As Long, mvarAuxL1 As Long
'        Dim mvarIdDetalleComprobanteProveedor As Long, mvarIdDetalleComprobanteProveedorAnt As Long
'        Dim mvarNumeroReferencia As Long, mvarIdTipoCuentaGrupoIVA As Long
'        Dim mTotalAnterior As Double, mvarCotizacionAnt As Double, mvarCotizacionDolar As Double
'        Dim mvarCotizacionMoneda As Double, mTotalAnteriorDolar As Double, mvarDebe As Double
'        Dim mvarHaber As Double, mvarCotizacionEuro As Double, mTotalAnteriorEuro As Double
'        Dim Tot As Double, TotDol As Double, TotEu As Double, Sdo As Double, SdoDol As Double, SdoEu As Double
'        Dim mvarBorrarEnValores As Boolean, mvarSubdiarios_ResumirRegistros As Boolean
'        Dim mvarOk As Boolean, mvarProcesar As Boolean



'        '        On Error GoTo Mal


'        mvarIdentificador = oCP.Id
'        mvarCotizacionMoneda = IIf(IsNull(oCP.CotizacionMoneda), 0, oCP.CotizacionMoneda)
'        mvarCotizacionDolar = IIf(IsNull(oCP.CotizacionDolar), 0, oCP.CotizacionDolar)
'        mvarCotizacionEuro = IIf(IsNull(oCP.CotizacionEuro), 0, oCP.CotizacionEuro)
'        mvarIdOrdenPagoActual = IIf(IsNull(oCP.IdOrdenPago), 0, oCP.IdOrdenPago)
'        mvarNumeroReferencia = IIf(IsNull(oCP.NumeroReferencia), 0, oCP.NumeroReferencia)

'        Dim oParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
'        If IsNull(oParam.Item("Subdiarios_ResumirRegistros")) Or _
'              oParam.Item("Subdiarios_ResumirRegistros") = "SI" Then
'            mvarSubdiarios_ResumirRegistros = True
'        Else
'            mvarSubdiarios_ResumirRegistros = False
'        End If
'        mvarIdTipoCuentaGrupoIVA = iisNull(oParam.Item("IdTipoCuentaGrupoIVA"), 0)


'        mvarCoeficiente = 1
'        Datos = oDet.LeerUno(SC, "TiposComprobante", oCP.IdTipoComprobante)
'        If Datos.RecordCount > 0 Then
'            mvarCoeficiente = Datos.Fields("Coeficiente").Value
'        End If
'        Datos.Close()
'        Datos = Nothing
'        mvarCoeficienteAnt = mvarCoeficiente

'        If Not IsNull(oCP.IdDiferenciaCambio) Then
'            oDet.Tarea(SC, "DiferenciasCambio_MarcarComoGenerada", _
'                  ArrayVB6(oCP.IdDiferenciaCambio, _
'                        oCP.IdTipoComprobante, oCP.Id))
'        End If

'        mTotalAnterior = 0
'        mvarIdProveedorAnterior = 0
'        mvarIdTipoComprobanteAnterior = 0
'        mvarIdOrdenPagoAnterior = 0
'        If mvarIdentificador > 0 Then
'            DatosAnt = oDet.LeerUno(SC, "ComprobantesProveedores", mvarIdentificador)
'            If DatosAnt.RecordCount > 0 Then
'                mvarCotizacionAnt = IIf(IsNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
'                mTotalAnterior = DatosAnt.Fields("TotalComprobante").Value * mvarCotizacionAnt
'                If Not IsNull(DatosAnt.Fields("IdProveedor").Value) Then
'                    mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
'                End If
'                If Not IsNull(DatosAnt.Fields("IdTipoComprobante").Value) Then
'                    mvarIdTipoComprobanteAnterior = DatosAnt.Fields("IdTipoComprobante").Value
'                End If
'                Datos = oDet.LeerUno(SC, "TiposComprobante", DatosAnt.Fields("IdTipoComprobante").Value)
'                If Datos.RecordCount > 0 Then
'                    mvarCoeficienteAnt = Datos.Fields("Coeficiente").Value
'                End If
'                mvarIdOrdenPagoAnterior = IIf(IsNull(DatosAnt.Fields("IdOrdenPago").Value), 0, DatosAnt.Fields("IdOrdenPago").Value)
'                Datos.Close()
'                Datos = Nothing

'                If Not IsNull(DatosAnt.Fields("IdComprobanteImputado").Value) Then
'                    mvarAuxL1 = 11
'                    oRsAux = oDet.LeerUno(SC, "ComprobantesProveedores", DatosAnt.Fields("IdComprobanteImputado").Value)
'                    If oRsAux.RecordCount > 0 Then
'                        mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
'                    End If
'                    oRsAux.Close()

'                    DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
'                             ArrayVB6(mvarIdentificador, DatosAnt.Fields("IdTipoComprobante").Value))
'                    If DatosCtaCteNv.RecordCount > 0 Then
'                        Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
'                        TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
'                        TotEu = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
'                                 IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

'                        DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
'                                 ArrayVB6(DatosAnt.Fields("IdComprobanteImputado").Value, mvarAuxL1))
'                        If DatosCtaCte.RecordCount > 0 Then
'                            DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
'                            DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
'                            DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
'                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
'                        End If
'                        DatosCtaCte.Close()
'                        DatosCtaCte = Nothing

'                        oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)
'                    End If
'                    DatosCtaCteNv.Close()
'                    DatosCtaCteNv = Nothing
'                End If
'            End If
'            DatosAnt.Close()
'            DatosAnt = Nothing
'        End If

'        'Resp = oDet.GuardarPorRef(SC, "ComprobantesProveedores", oCP)

'        'Datos = oDet.LeerUno(SC, "ComprobantesProveedores", oCP.Id)
'        'If Datos.RecordCount > 0 Then
'        '    mvarNumeroReferencia = IIf(IsNull(Datos.Fields("NumeroReferencia").Value), 0, Datos.Fields("NumeroReferencia").Value)
'        'End If
'        'Datos.Close()

'        If mvarIdOrdenPagoActual <> 0 Or mvarIdOrdenPagoAnterior <> 0 Then
'            oDet.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", ArrayVB6(mvarIdOrdenPagoActual, mvarIdOrdenPagoAnterior))
'        End If

'        If mvarIdProveedorAnterior <> 0 Then
'            DatosProveedor = oDet.LeerUno(SC, "Proveedores", mvarIdProveedorAnterior)
'            If IsNull(DatosProveedor.Fields("Saldo").Value) Then
'                DatosProveedor.Fields("Saldo").Value = 0
'            End If
'            DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value + (mTotalAnterior * mvarCoeficienteAnt)
'            Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
'            DatosProveedor.Close()
'            DatosProveedor = Nothing
'        End If

'        If oCP.IdProveedor > 0 Then
'            Dim oPrv = ProveedorManager.GetItem(SC, oCP.IdProveedor)
'            oPrv.Saldo = oPrv.Saldo - (oCP.TotalComprobante * mvarCoeficiente * mvarCotizacionMoneda)
'            ProveedorManager.Save(SC, oPrv)

'            'DatosProveedor = oDet.LeerUno(SC, "Proveedores", oCP.IdProveedor)
'            'If IsNull(DatosProveedor.Fields("Saldo").Value) Then
'            '    DatosProveedor.Fields("Saldo").Value = 0
'            'End If
'            'DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value - (oCP.TotalComprobante * mvarCoeficiente * mvarCotizacionMoneda)
'            'Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
'            'DatosProveedor.Close()
'            'DatosProveedor = Nothing
'        End If

'        'Borra la registracion contable anterior si el comprobante fue modificado
'        If mvarIdentificador > 0 Then
'            DatosAnt = oDet.TraerFiltrado(SC, "Subdiarios", "_PorIdComprobante", ArrayVB6(mvarIdentificador, mvarIdTipoComprobanteAnterior))
'            With DatosAnt
'                If .RecordCount > 0 Then
'                    .MoveFirst()
'                    Do While Not .EOF
'                        oDet.Eliminar(SC, "Subdiarios", .Fields(0).Value)
'                        .MoveNext()
'                    Loop
'                End If
'                .Close()
'            End With
'            '      Set DatosAnt = oDet.TraerFiltrado(sc,"DetComprobantesProveedores", "_PorIdCabecera", mvarIdentificador)
'            '      With DatosAnt
'            '         If .RecordCount > 0 Then
'            '            .MoveFirst
'            '            Do While Not .EOF
'            '               oDet.Tarea "Valores_BorrarPorIdDetalleComprobanteProveedor", .Fields(0).Value
'            '               .MoveNext
'            '            Loop
'            '         End If
'            '         .Close
'            '      End With
'            DatosAnt = Nothing
'        End If



'        For Each item As ComprobanteProveedorItem In oCP.Detalles
'            With item


'                If .Eliminado Then
'                    oDet.Eliminar(SC, "DetComprobantesProveedores", .Id)
'                    oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", .Id)
'                Else

'                    mvarIdDetalleComprobanteProveedorAnt = .Id
'                    'Resp = oDet.Guardar(SC, "DetComprobantesProveedores", item)


'                    If Not mvarSubdiarios_ResumirRegistros And RegistroContable.RecordCount > 0 Then
'                        RegistroContable.MoveFirst()
'                        Do While Not RegistroContable.EOF
'                            If RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedorAnt And _
'                                  mvarIdDetalleComprobanteProveedorAnt <> mvarIdDetalleComprobanteProveedor Then
'                                RegistroContable.Fields("IdDetalleComprobante").Value = mvarIdDetalleComprobanteProveedor
'                                RegistroContable.Update()
'                            End If
'                            RegistroContable.MoveNext()
'                        Loop
'                        RegistroContable.MoveFirst()
'                    End If

'                    mvarBorrarEnValores = True
'                    oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaCajaBanco", .IdCuenta)
'                    If oRsAux.RecordCount > 0 Then
'                        If Not IsNull(oRsAux.Fields("EsCajaBanco").Value) And _
'                              (oRsAux.Fields("EsCajaBanco").Value = "BA" Or _
'                               oRsAux.Fields("EsCajaBanco").Value = "CA") Then

'                            mvarIdCaja = IIf(IsNull(oRsAux.Fields("IdCaja").Value), 0, oRsAux.Fields("IdCaja").Value)
'                            oRsAux.Close()

'                            mIdValor = -1
'                            oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleComprobanteProveedor", mvarIdDetalleComprobanteProveedor)
'                            If oRsValores.RecordCount > 0 Then
'                                mIdValor = oRsValores.Fields(0).Value
'                            End If
'                            oRsValores.Close()
'                            oRsValores = Nothing

'                            mvarIdBanco = 0
'                            If Not IsNull(.IdCuentaBancaria) Then
'                                oRsAux = oDet.TraerFiltrado(SC, "CuentasBancarias", "_PorId", .IdCuentaBancaria)
'                                If oRsAux.RecordCount > 0 Then
'                                    mvarIdBanco = oRsAux.Fields("IdBanco").Value
'                                End If
'                                oRsAux.Close()
'                            End If

'                            If mvarIdBanco <> 0 Or mvarIdCaja <> 0 Then
'                                oRsValores = CopiarRs(oDet.TraerFiltrado(SC, "Valores", "_Struc"))
'                                With oRsValores
'                                    .Fields("IdTipoValor").Value = 32
'                                    .Fields("NumeroValor").Value = 0
'                                    .Fields("NumeroInterno").Value = 0
'                                    .Fields("FechaValor").Value = oCP.FechaRecepcion
'                                    .Fields("IdCuentaBancaria").Value = item.IdCuentaBancaria
'                                    If mvarIdBanco <> 0 Then .Fields("IdBanco").Value = mvarIdBanco
'                                    If mvarIdCaja <> 0 Then .Fields("IdCaja").Value = mvarIdCaja
'                                    .Fields("Importe").Value = item.Importe
'                                    .Fields("NumeroComprobante").Value = mvarNumeroReferencia
'                                    .Fields("FechaComprobante").Value = oCP.FechaComprobante
'                                    If Not IsNull(oCP.IdProveedor) Then
'                                        .Fields("IdProveedor").Value = oCP.IdProveedor
'                                    End If
'                                    .Fields("IdTipoComprobante").Value = oCP.IdTipoComprobante
'                                    .Fields("IdDetalleComprobanteProveedor").Value = mvarIdDetalleComprobanteProveedor
'                                    .Fields("IdMoneda").Value = oCP.IdMoneda
'                                    .Fields("CotizacionMoneda").Value = oCP.CotizacionMoneda
'                                    .Fields(0).Value = mIdValor
'                                End With
'                                Resp = oDet.Guardar(SC, "Valores", oRsValores)
'                                oRsValores.Close()
'                                oRsValores = Nothing
'                                mvarBorrarEnValores = False
'                            End If
'                        End If
'                    Else
'                        oRsAux.Close()
'                    End If
'                    oRsAux = Nothing

'                    If mvarIdentificador > 0 And mvarBorrarEnValores Then
'                        oDet.Tarea("Valores_BorrarPorIdDetalleComprobanteProveedor", .Id)
'                    End If
'                End If
'            End With
'        Next



'        If Not IsNull(oCP.IdProveedor) Then
'            mTotalAnterior = 0
'            mTotalAnteriorDolar = 0
'            mTotalAnteriorEuro = 0
'            If mvarIdentificador > 0 Then
'                DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", ArrayVB6(oCP.Id, mvarIdTipoComprobanteAnterior))
'                If DatosCtaCteNv.RecordCount > 0 Then
'                    mTotalAnterior = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
'                    mTotalAnteriorDolar = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
'                    mTotalAnteriorEuro = IIf(IsNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
'                                         IIf(IsNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)
'                Else
'                    DatosCtaCteNv.Close()
'                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
'                    DatosCtaCteNv = CopiarRs(DatosCtaCte)
'                    DatosCtaCteNv.Fields(0).Value = -1
'                End If
'            Else
'                DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
'                DatosCtaCteNv = CopiarRs(DatosCtaCte)
'                DatosCtaCteNv.Fields(0).Value = -1
'            End If
'            With DatosCtaCteNv
'                Tot = Math.Round(oCP.TotalComprobante * mvarCotizacionMoneda, 2)
'                TotDol = 0
'                If mvarCotizacionDolar <> 0 Then
'                    TotDol = Math.Round(oCP.TotalComprobante * _
'                          IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionDolar, 2)
'                End If
'                TotEu = 0
'                If mvarCotizacionEuro <> 0 Then
'                    TotEu = Math.Round(oCP.TotalComprobante * _
'                          IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda) / mvarCotizacionEuro, 2)
'                End If

'                .Fields("IdProveedor").Value = oCP.IdProveedor
'                .Fields("NumeroComprobante").Value = mvarNumeroReferencia
'                .Fields("Fecha").Value = oCP.FechaRecepcion
'                .Fields("IdTipoComp").Value = oCP.IdTipoComprobante
'                .Fields("IdComprobante").Value = oCP.Id
'                .Fields("FechaVencimiento").Value = oCP.FechaVencimiento
'                .Fields("ImporteTotal").Value = Tot
'                .Fields("Saldo").Value = Tot - mTotalAnterior
'                .Fields("CotizacionDolar").Value = mvarCotizacionDolar
'                .Fields("ImporteTotalDolar").Value = TotDol
'                .Fields("SaldoDolar").Value = TotDol - mTotalAnteriorDolar
'                .Fields("CotizacionEuro").Value = mvarCotizacionEuro
'                .Fields("ImporteTotalEuro").Value = TotEu
'                .Fields("SaldoEuro").Value = TotEu - mTotalAnteriorEuro
'                .Fields("IdMoneda").Value = oCP.IdMoneda
'                .Fields("CotizacionMoneda").Value = oCP.CotizacionMoneda

'                If Not IsNull(oCP.IdComprobanteImputado) Then
'                    Sdo = 0
'                    SdoDol = 0
'                    SdoEu = 0
'                    mvarAuxL1 = 11
'                    oRsAux = oDet.LeerUno(SC, "ComprobantesProveedores", oCP.IdComprobanteImputado)
'                    If oRsAux.RecordCount > 0 Then
'                        mvarAuxL1 = oRsAux.Fields("IdTipoComprobante").Value
'                    End If
'                    oRsAux.Close()
'                    oRsAux = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", _
'                             ArrayVB6(oCP.IdComprobanteImputado, mvarAuxL1))
'                    If oRsAux.RecordCount > 0 Then
'                        Sdo = oRsAux.Fields("Saldo").Value
'                        SdoDol = IIf(IsNull(oRsAux.Fields("SaldoDolar").Value), 0, oRsAux.Fields("SaldoDolar").Value)
'                        SdoEu = IIf(IsNull(oRsAux.Fields("SaldoEuro").Value), 0, oRsAux.Fields("SaldoEuro").Value)

'                        If IsNull(oCP.Dolarizada) Or oCP.Dolarizada = "NO" Then
'                            TotDol = 0
'                            If IIf(IsNull(oRsAux.Fields("CotizacionDolar").Value), 0, oRsAux.Fields("CotizacionDolar").Value) <> 0 Then
'                                TotDol = Math.Round(Math.Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionDolar").Value, 2)
'                            End If
'                            .Fields("CotizacionDolar").Value = oRsAux.Fields("CotizacionDolar").Value
'                            .Fields("ImporteTotalDolar").Value = TotDol
'                            .Fields("SaldoDolar").Value = TotDol
'                        End If
'                        TotEu = 0
'                        If IIf(IsNull(oRsAux.Fields("CotizacionEuro").Value), 0, oRsAux.Fields("CotizacionEuro").Value) <> 0 Then
'                            TotEu = Math.Round(Math.Abs(Tot * IIf((mvarCotizacionMoneda = 0), 1, mvarCotizacionMoneda)) / oRsAux.Fields("CotizacionEuro").Value, 2)
'                        End If
'                        .Fields("CotizacionEuro").Value = oRsAux.Fields("CotizacionEuro").Value
'                        .Fields("ImporteTotalEuro").Value = TotEu
'                        .Fields("SaldoEuro").Value = TotEu
'                        If Tot > Sdo Then
'                            Tot = Math.Round(Tot - Sdo, 2)
'                            oRsAux.Fields("Saldo").Value = 0
'                            .Fields("Saldo").Value = Tot
'                        Else
'                            Sdo = Math.Round(Sdo - Tot, 2)
'                            oRsAux.Fields("Saldo").Value = Sdo
'                            .Fields("Saldo").Value = 0
'                        End If
'                        If TotDol > SdoDol Then
'                            TotDol = Math.Round(TotDol - SdoDol, 2)
'                            oRsAux.Fields("SaldoDolar").Value = 0
'                            .Fields("SaldoDolar").Value = TotDol
'                        Else
'                            SdoDol = Math.Round(SdoDol - TotDol, 2)
'                            oRsAux.Fields("SaldoDolar").Value = SdoDol
'                            .Fields("SaldoDolar").Value = 0
'                        End If
'                        If TotEu > SdoEu Then
'                            TotEu = Math.Round(TotEu - SdoEu, 2)
'                            oRsAux.Fields("SaldoEuro").Value = 0
'                            .Fields("SaldoEuro").Value = TotEu
'                        Else
'                            SdoEu = Math.Round(SdoEu - TotEu, 2)
'                            oRsAux.Fields("SaldoEuro").Value = SdoEu
'                            .Fields("SaldoEuro").Value = 0
'                        End If
'                        .Fields("IdImputacion").Value = oRsAux.Fields("IdImputacion").Value
'                        Resp = oDet.Guardar(SC, "CtasCtesA", oRsAux)
'                    End If
'                    oRsAux.Close()
'                End If
'            End With

'            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
'            If IsNull(DatosCtaCteNv.Fields("IdImputacion").Value) Then
'                DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
'                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
'            End If
'            DatosCtaCteNv.Close()
'            DatosCtaCteNv = Nothing
'            DatosCtaCte = Nothing
'        Else
'            If mvarIdentificador > 0 Then
'                DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_BuscarComprobante", ArrayVB6(oCP.Id, mvarIdTipoComprobanteAnterior))
'                If DatosCtaCte.RecordCount > 0 Then
'                    oDet.Eliminar(SC, "CtasCtesA", DatosCtaCte.Fields(0).Value)
'                End If
'                DatosCtaCte.Close()
'                DatosCtaCte = Nothing
'            End If
'        End If

'        mvarDebe = 0
'        mvarHaber = 0

'        With RegistroContable
'            If .State <> adStateClosed Then
'                If .RecordCount > 0 Then
'                    .Update()
'                    .MoveFirst()
'                End If
'                Do While Not .EOF
'                    If Not IsNull(.Fields("Debe").Value) Then
'                        .Fields("Debe").Value = Math.Round(.Fields("Debe").Value * mvarCotizacionMoneda, 2)
'                        .Update()
'                        mvarDebe = mvarDebe + .Fields("Debe").Value
'                    End If
'                    If Not IsNull(.Fields("Haber").Value) Then
'                        .Fields("Haber").Value = Math.Round(.Fields("Haber").Value * mvarCotizacionMoneda, 2)
'                        .Update()
'                        mvarHaber = mvarHaber + .Fields("Haber").Value
'                    End If
'                    .MoveNext()
'                Loop
'                If .RecordCount > 0 Then
'                    If mvarDebe - mvarHaber <> 0 Then
'                        mvarOk = False
'                        .MoveFirst()
'                        Do While Not .EOF
'                            If Not IsNull(.Fields("Debe").Value) Then
'                                mvarProcesar = True
'                                oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaParaAjusteSubdiario", .Fields("IdCuenta").Value)
'                                If oRsAux.Fields(0).Value = 0 Then mvarProcesar = False
'                                oRsAux.Close()
'                                Datos = Nothing
'                                If mvarProcesar Then
'                                    .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
'                                    mvarOk = True
'                                    Exit Do
'                                End If
'                            End If
'                            .MoveNext()
'                        Loop
'                        If Not mvarOk Then
'                            .MoveLast()
'                            If Not IsNull(.Fields("Debe").Value) Then
'                                .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
'                            Else
'                                .Fields("Haber").Value = .Fields("Haber").Value + Math.Round(mvarDebe - mvarHaber, 2)
'                            End If
'                        End If
'                    End If
'                    .MoveFirst()
'                End If
'                Do While Not .EOF
'                    Datos = CreateObject("adodb.Recordset")
'                    For i = 0 To .Fields.Count - 1
'                        With .Fields(i)
'                            Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'                            Datos.Fields(.Name).Precision = .Precision
'                            Datos.Fields(.Name).NumericScale = .NumericScale
'                        End With
'                    Next
'                    Datos.Open()
'                    Datos.AddNew()
'                    For i = 0 To .Fields.Count - 1
'                        With .Fields(i)
'                            Datos.Fields(i).Value = .Value
'                        End With
'                    Next
'                    Datos.Fields("IdComprobante").Value = oCP.Id
'                    Datos.Fields("NumeroComprobante").Value = mvarNumeroReferencia
'                    Datos.Update()
'                    Resp = oDet.Guardar(SC, "Subdiarios", Datos)
'                    Datos.Close()
'                    Datos = Nothing
'                    .MoveNext()
'                Loop
'            End If
'        End With

'        'With oCP.DetallesProvincias
'        '    If .State <> adStateClosed Then
'        '        If Not .EOF Then
'        '            .Update()
'        '            .MoveFirst()
'        '        End If

'        '        Do While Not .EOF
'        '            .Fields("IdComprobanteProveedor").Value = oCP.Id
'        '            .Update()
'        '            If .Fields("Eliminado").Value Then
'        '                oDet.Eliminar(SC, "DetComprobantesProveedoresPrv", .Fields(0).Value)
'        '            Else
'        '                Datos = CreateObject("adodb.Recordset")
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'        '                        Datos.Fields(.Name).Precision = .Precision
'        '                        Datos.Fields(.Name).NumericScale = .NumericScale
'        '                    End With
'        '                Next
'        '                Datos.Open()
'        '                Datos.AddNew()
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields(i).Value = .Value
'        '                    End With
'        '                Next
'        '                Datos.Update()
'        '                Resp = oDet.Guardar(SC, "DetComprobantesProveedoresPrv", Datos)
'        '                Datos.Close()
'        '                Datos = Nothing
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        Guardar_CodigoOriginalDeVB6 = Resp
'        oDet = Nothing
'        oCont = Nothing
'        oRsAux = Nothing
'        On Error GoTo 0
'        'If lErr Then
'        '    Err.Raise(lErr, sSource, sDesc)
'        'End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        'oDet.Tarea("Log_InsertarRegistro", ArrayVB6("MTSCP", oCP.Id, 0, Now, 0, _
'        '      "Error " & Err.Number & Err.Description & ", " & Err.Source, _
'        '      "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
'        Resume Salir


'    End Function


'    Public Function GuardarRegistroContable(ByVal RegistroContable As ADODB.Recordset)

'        Dim oCont ' As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim oRsComprobante As ADODB.Recordset
'        Dim Datos As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
'        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarCotizacionMoneda = 0
'        mvarDebe = 0
'        mvarHaber = 0

'        'With RegistroContable
'        '    If .State <> adStateClosed Then
'        '        If .RecordCount > 0 Then
'        '            .Update()
'        '            .MoveFirst()
'        '            oRsComprobante = oDet.LeerUno(sc,"ComprobantePrvs", RegistroContable.Fields("IdComprobante").Value)
'        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
'        '            oRsComprobante.Close()
'        '            oRsComprobante = Nothing
'        '        End If
'        '        Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '        If .RecordCount > 0 Then
'        '            .MoveFirst()
'        '            If mvarDebe - mvarHaber <> 0 Then
'        '                If Not IsNull(.Fields("Debe").Value) Then
'        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
'        '                Else
'        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
'        '                End If
'        '            End If
'        '        End If
'        '        Do While Not .EOF
'        '            Datos = CreateObject("adodb.Recordset")
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'        '                    Datos.Fields(.Name).Precision = .Precision
'        '                    Datos.Fields(.Name).NumericScale = .NumericScale
'        '                End With
'        '            Next
'        '            Datos.Open()
'        '            Datos.AddNew()
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields(i).Value = .Value
'        '                End With
'        '            Next
'        '            Datos.Update()
'        '            Resp = oDet.Guardar("Subdiarios", Datos)
'        '            Datos.Close()
'        '            Datos = Nothing
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        GuardarRegistroContable = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function

'    Public Sub RecalcularRegistroContable_SubRecalculoAutomatico(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor, ByRef oRsCont As DataTable, _
'                                    ByVal mvarCliente As Long, ByVal mvarCuentaClienteMonedaLocal As Long, _
'                                    ByVal mvarCuentaClienteMonedaExtranjera As Long, _
'                                    ByVal mvarEjercicio As Long, ByVal mvarCuentaCajaTitulo As Long, ByVal mvarCuentaCliente As Long)


'        Dim oSrv 'As InterFazMTS.iCompMTS
'        Dim oRs As DataRow
'        Dim oRsDetCtas As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim mvarCuentaCaja As Long
'        Dim mvarCuentaValores As Long, mvarCuentaRetencionIva As Long
'        Dim mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
'        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
'        Dim mvarCuentaReventas As Long, mvarCuentaDescuentos As Long
'        Dim mvarCuentaDescuentosyRetenciones As Long, mvarCuenta As Long
'        Dim mvarCuentaValoresTitulo As Long
'        Dim mvarCuentaDescuentosyRetencionesTitulo As Long
'        Dim mvarTotalValores As Double
'        Dim mvarAux1 As Double, mvarAux2 As Double
'        Dim mvarDetalleValor As String
'        Dim mvarEsta As Boolean
'        Dim mvarIdMonedaPesos As Integer
'        Dim mvarTotalMonedaLocal As Double, mvarTotalMonedaExtranjera As Double

'        oSrv = CreateObject("MTSPronto.General")

'        oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

















'    End Sub



'    Public Sub RecalcularTotales(ByRef myComprobantePrv As ComprobanteProveedor)


'        Dim oRs As ADODB.Recordset

'        Dim i As Integer
'        Dim mImporte As Double, mPorcentajeIVA As Double

'        Dim mvarSubTotal, mvarIVA1, mvarIVA2 As Single
'        Dim mvarIVANoDiscriminado, mvarTotalComprobanteProveedor, mvarAjusteIVA As Single

'        With myComprobantePrv

'            mvarSubTotal = 0
'            mvarIVANoDiscriminado = 0
'            mvarIVA1 = 0
'            If .Letra <> "A" And .Letra <> "M" Then mvarIVA1 = 0
'            mvarIVA2 = 0
'            mvarTotalComprobanteProveedor = 0
'            mvarAjusteIVA = 0

'            For Each oL As ComprobanteProveedorItem In .Detalles
'                With oL
'                    If Not .Eliminado Then
'                        '            mvarSubTotal = mvarSubTotal + Val(oL.ListSubItems(3))
'                        '            If Val(oL.ListSubItems(2)) <> 0 And (Not mSenialIVA Or Len(txtTotal(1).Text) = 0) Then
'                        '               mvarIVA1 = mvarIVA1 + Round(Val(oL.ListSubItems(3)) * Val(oL.ListSubItems(2)) / 100, mvarDecimales)
'                        '               mSenialIVA = False
'                        '            End If

'                        mImporte = .Importe
'                        mvarSubTotal = mvarSubTotal + mImporte
'                        For i = 1 To 10

'                            If CallByName(oL, ("AplicarIVA" & i), CallType.Get) = "SI" Then
'                                mPorcentajeIVA = CallByName(oL, ("IVAComprasPorcentaje" & i), CallType.Get)
'                                If myComprobantePrv.Letra = "A" Or myComprobantePrv.Letra = "M" Then
'                                    mvarIVA1 = mvarIVA1 + Math.Round(mImporte * mPorcentajeIVA / 100, 2)
'                                Else
'                                    mvarIVANoDiscriminado = mvarIVANoDiscriminado + Math.Round(mImporte - (mImporte / (1 + (mPorcentajeIVA / 100))), 2)
'                                End If
'                            End If
'                        Next
'                    End If
'                End With
'            Next

'            mvarAjusteIVA = .AjusteIVA
'            mvarTotalComprobanteProveedor = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarAjusteIVA


'            .TotalBruto = mvarSubTotal
'            .TotalIva1 = mvarIVA1
'            .TotalIva2 = mvarIVA2
'            .TotalComprobante = mvarTotalComprobanteProveedor





'        End With
'    End Sub



'    Public Function GuardarRegistroContable(ByVal RegistroContable As ADODB.Recordset)

'        Dim oCont ' As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim oRsComprobante As ADODB.Recordset
'        Dim Datos As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
'        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarCotizacionMoneda = 0
'        mvarDebe = 0
'        mvarHaber = 0

'        'With RegistroContable
'        '    If .State <> adStateClosed Then
'        '        If .RecordCount > 0 Then
'        '            .Update()
'        '            .MoveFirst()
'        '            oRsComprobante = oDet.LeerUno("ComprobantePrvs", RegistroContable.Fields("IdComprobante").Value)
'        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
'        '            oRsComprobante.Close()
'        '            oRsComprobante = Nothing
'        '        End If
'        '        Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '        If .RecordCount > 0 Then
'        '            .MoveFirst()
'        '            If mvarDebe - mvarHaber <> 0 Then
'        '                If Not IsNull(.Fields("Debe").Value) Then
'        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
'        '                Else
'        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
'        '                End If
'        '            End If
'        '        End If
'        '        Do While Not .EOF
'        '            Datos = CreateObject("adodb.Recordset")
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'        '                    Datos.Fields(.Name).Precision = .Precision
'        '                    Datos.Fields(.Name).NumericScale = .NumericScale
'        '                End With
'        '            Next
'        '            Datos.Open()
'        '            Datos.AddNew()
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields(i).Value = .Value
'        '                End With
'        '            Next
'        '            Datos.Update()
'        '            Resp = oDet.Guardar("Subdiarios", Datos)
'        '            Datos.Close()
'        '            Datos = Nothing
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        GuardarRegistroContable = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function


'    Public Function RecalcularRegistroContableRecordset(ByVal SC As String, ByRef oCP As ComprobanteProveedor) As ADODB.Recordset

'        Dim oRsCont As ADODB.Recordset
'        Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
'        Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
'        Dim mvarCliente As Double
'        Dim mvarCuentaCliente As Long

'        IsValid(SC, oCP) 'para marcar los vacios

'        mvarCuentaClienteMonedaLocal = 0
'        mvarCuentaClienteMonedaExtranjera = 0
'        mvarCliente = 0




'        Dim oSrv As New ICompMTSManager
'        Dim oRs As ADODB.Recordset
'        Dim oRsDet As ADODB.Recordset
'        Dim oRsDetBD As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim mvarCuentaCompras As Long, mvarCuentaProveedor As Long
'        Dim mvarCuentaBonificaciones As Long, mvarCuentaIvaInscripto As Long
'        Dim mvarCuentaIvaNoInscripto As Long, mvarCuentaIvaSinDiscriminar As Long
'        Dim mvarCuentaComprasTitulo As Long, mvarIdCuenta As Long
'        Dim mvarCuentaReintegros As Long
'        Dim mvarTotalCompra As Double, mvarImporte As Double, mvarDecimales As Integer
'        Dim mvarPorcentajeIVA As Double, mvarIVA1 As Double, mvarAjusteIVA As Double
'        Dim mvarTotalIVANoDiscriminado As Double, mvarDebe As Double, mvarHaber As Double
'        Dim mIdTipoComprobante As Integer, mCoef As Integer, i As Integer
'        Dim mvarEsta As Boolean, mvarSubdiarios_ResumirRegistros As Boolean

'        'oSrv = CreateObject("MTSPronto.General")

'        mIdTipoComprobante = oCP.IdTipoComprobante
'        oRs = oSrv.LeerUno(SC, "TiposComprobante", mIdTipoComprobante)
'        mCoef = oRs.Fields("Coeficiente").Value
'        oRs.Close()

'        'oRs = oSrv.LeerUno(SC, "Parametros", 1)
'        Dim oParam = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

'        mvarEjercicio = oParam.Item("EjercicioActual")
'        mvarCuentaCompras = oParam.Item("IdCuentaCompras")
'        mvarCuentaComprasTitulo = oParam.Item("IdCuentaComprasTitulo")
'        mvarCuentaBonificaciones = oParam.Item("IdCuentaBonificaciones")
'        mvarCuentaIvaInscripto = oParam.Item("IdCuentaIvaCompras")
'        mvarCuentaIvaNoInscripto = oParam.Item("IdCuentaIvaCompras")
'        mvarCuentaIvaSinDiscriminar = oParam.Item("IdCuentaIvaSinDiscriminar")
'        mvarDecimales = oParam.Item("Decimales")
'        mvarCuentaProveedor = iisNull(oParam.Item("IdCuentaAcreedoresVarios"), 0)
'        If IsNull(oParam.Item("Subdiarios_ResumirRegistros")) Or _
'              oParam.Item("Subdiarios_ResumirRegistros") = "SI" Then
'            mvarSubdiarios_ResumirRegistros = True
'        Else
'            mvarSubdiarios_ResumirRegistros = False
'        End If
'        mvarCuentaReintegros = iisNull(oParam.Item("IdCuentaReintegros"), 0)


'        If oCP.IdProveedor > 0 Then
'            oRs = oSrv.LeerUno(SC, "Proveedores", oCP.IdProveedor)
'            If Not IsNull(oRs.Fields("IdCuenta").Value) Then
'                mvarCuentaProveedor = oRs.Fields("IdCuenta").Value
'            End If
'            oRs.Close()
'        ElseIf oCP.IdCuenta > 0 Then
'            mvarCuentaProveedor = oCP.IdCuenta
'        ElseIf oCP.IdCuentaOtros > 0 Then
'            mvarCuentaProveedor = oCP.IdCuentaOtros
'        End If

'        mvarAjusteIVA = IIf(IsNull(oCP.AjusteIVA), 0, oCP.AjusteIVA)

'        oRsCont = CreateObject("adodb.Recordset")
'        oRs = oSrv.TraerFiltrado(SC, "Subdiarios", "_Estructura")

'        With oRs
'            For Each oFld In .Fields
'                With oFld
'                    oRsCont.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'                    oRsCont.Fields.Item(.Name).Precision = .Precision
'                    oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
'                End With
'            Next
'            oRsCont.Open()
'        End With
'        oRs.Close()

'        If Not IsNull(oCP.Confirmado) And _
'              oCP.Confirmado = "NO" Then
'            GoTo Salida
'        End If

'        With oRsCont
'            .AddNew()
'            .Fields("Ejercicio").Value = mvarEjercicio
'            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'            .Fields("IdCuenta").Value = mvarCuentaProveedor
'            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'            .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'            .Fields("IdComprobante").Value = oCP.Id
'            If mCoef = 1 Then
'                .Fields("Haber").Value = oCP.TotalComprobante
'            Else
'                .Fields("Debe").Value = oCP.TotalComprobante
'            End If
'            .Update()
'        End With

'        If oCP.TotalBonificacion <> 0 Then
'            With oRsCont
'                .AddNew()
'                .Fields("Ejercicio").Value = mvarEjercicio
'                .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                .Fields("IdCuenta").Value = mvarCuentaBonificaciones
'                .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                .Fields("IdComprobante").Value = oCP.Id
'                If mCoef = 1 Then
'                    .Fields("Haber").Value = oCP.TotalBonificacion
'                Else
'                    .Fields("Debe").Value = oCP.TotalBonificacion
'                End If
'                .Update()
'            End With
'        End If

'        '   If Not IsNull(oCP.TotalIva1) Then
'        '      If oCP.TotalIva1 <> 0 Then
'        '         With oRsCont
'        '            .AddNew
'        '            .Fields("Ejercicio").Value = mvarEjercicio
'        '            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'        '            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
'        '            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'        '            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'        '            .Fields("FechaComprobante").Value = oCP.FechaComprobante
'        '            .Fields("IdComprobante").Value = oCP.Id
'        '            If mCoef = 1 Then
'        '               .Fields("Debe").Value = oCP.TotalIva1
'        '            Else
'        '               .Fields("Haber").Value = oCP.TotalIva1
'        '            End If
'        '            .Update
'        '         End With
'        '      End If
'        '   End If

'        '   If Not IsNull(oCP.TotalIva2) Then
'        '      If oCP.TotalIva2 <> 0 Then
'        '         With oRsCont
'        '            .AddNew
'        '            .Fields("Ejercicio").Value = mvarEjercicio
'        '            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'        '            .Fields("IdCuenta").Value = mvarCuentaIvaInscripto
'        '            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'        '            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'        '            .Fields("FechaComprobante").Value = oCP.FechaComprobante
'        '            .Fields("IdComprobante").Value = oCP.Id
'        '            If mCoef = 1 Then
'        '               .Fields("Debe").Value = oCP.TotalIva2
'        '            Else
'        '               .Fields("Haber").Value = oCP.TotalIva2
'        '            End If
'        '            .Update
'        '         End With
'        '      End If
'        '   End If

'        For Each iDet As ComprobanteProveedorItem In oCP.Detalles

'            If Not iDet.Eliminado Then
'                With oRsCont

'                    mvarTotalIVANoDiscriminado = 0

'                    For i = 1 To 10
'                        If CallByName(iDet, "AplicarIVA" & i, CallType.Get) = "SI" Then
'                            mvarImporte = iDet.Importe
'                            mvarPorcentajeIVA = iisNull(CallByName(iDet, "IVAComprasPorcentaje" & i, CallType.Get), 0)
'                            If oCP.Letra = "A" Or oCP.Letra = "M" Then
'                                mvarIVA1 = Math.Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
'                            Else
'                                mvarIVA1 = Math.Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
'                                mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
'                            End If
'                            If mvarAjusteIVA <> 0 Then
'                                mvarIVA1 = mvarIVA1 + mvarAjusteIVA
'                                mvarAjusteIVA = 0
'                                oCP.PorcentajeIVAAplicacionAjuste = mvarPorcentajeIVA
'                                'Registro.Update()
'                            End If
'                            mvarDebe = 0
'                            mvarHaber = 0
'                            If mCoef = 1 Then
'                                If mvarIVA1 >= 0 Then
'                                    mvarDebe = mvarIVA1
'                                Else
'                                    mvarHaber = mvarIVA1 * -1
'                                End If
'                            Else
'                                If mvarIVA1 >= 0 Then
'                                    mvarHaber = mvarIVA1
'                                Else
'                                    mvarDebe = mvarIVA1 * -1
'                                End If
'                            End If
'                            mvarEsta = False
'                            If .RecordCount > 0 Then
'                                .MoveFirst()
'                                Do While Not .EOF
'                                    If .Fields("IdCuenta").Value = CallByName(iDet, "IdCuentaIvaCompras" & i, CallType.Get) And _
'                                          ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
'                                             (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
'                                        mvarEsta = True
'                                        Exit Do
'                                    End If
'                                    .MoveNext()
'                                Loop
'                            End If
'                            If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                            .Fields("IdCuenta").Value = CallByName(iDet, "IdCuentaIvaCompras" & i, CallType.Get)
'                            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                            .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                            .Fields("IdComprobante").Value = oCP.Id
'                            If mvarDebe <> 0 Then
'                                .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
'                            Else
'                                .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
'                            End If
'                            If Not mvarSubdiarios_ResumirRegistros Then
'                                .Fields("IdDetalleComprobante").Value = iDet.Id
'                            End If
'                            .Update()
'                        End If
'                    Next

'                    mvarDebe = 0
'                    mvarHaber = 0
'                    If mCoef = 1 Then
'                        mvarDebe = iDet.Importe - mvarTotalIVANoDiscriminado
'                    Else
'                        mvarHaber = iDet.Importe - mvarTotalIVANoDiscriminado
'                    End If
'                    mvarIdCuenta = mvarCuentaCompras
'                    If Not IsNull(iDet.IdCuenta) Then
'                        mvarIdCuenta = iDet.IdCuenta
'                    End If
'                    mvarEsta = False
'                    If .RecordCount > 0 Then
'                        .MoveFirst()
'                        Do While Not .EOF
'                            If .Fields("IdCuenta").Value = mvarIdCuenta And _
'                                  ((mvarDebe <> 0 And Not IsNull(.Fields("Debe").Value)) Or _
'                                     (mvarHaber <> 0 And Not IsNull(.Fields("Haber").Value))) Then
'                                mvarEsta = True
'                                Exit Do
'                            End If
'                            .MoveNext()
'                        Loop
'                    End If
'                    If Not mvarEsta Or Not mvarSubdiarios_ResumirRegistros Then .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                    .Fields("IdCuenta").Value = mvarIdCuenta
'                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                    .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                    .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                    .Fields("IdComprobante").Value = oCP.Id
'                    If mvarDebe <> 0 Then
'                        If mvarDebe > 0 Then
'                            .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + mvarDebe
'                        Else
'                            .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + (mvarDebe * -1)
'                        End If
'                    Else
'                        If mvarHaber > 0 Then
'                            .Fields("Haber").Value = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value) + mvarHaber
'                        Else
'                            .Fields("Debe").Value = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value) + (mvarHaber * -1)
'                        End If
'                    End If
'                    If Not mvarSubdiarios_ResumirRegistros Then
'                        .Fields("IdDetalleComprobante").Value = iDet.Id
'                    End If
'                    .Update()


'                End With
'            End If
'        Next

'        oRsDetBD = oSrv.TraerFiltrado(SC, "DetComprobantesProveedores", "_PorIdCabecera", oCP.Id)
'        With oRsDetBD
'            If .RecordCount > 0 Then
'                .MoveFirst()
'                Do While Not .EOF
'                    mvarEsta = False


'                    For Each iDet As ComprobanteProveedorItem In oCP.Detalles
'                        If .Fields(0).Value = iDet.Id Then
'                            mvarEsta = True
'                            Exit Do
'                        End If
'                    Next

'                    If Not mvarEsta Then
'                        With oRsCont
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                            If Not IsNull(oRsDetBD.Fields("IdCuenta").Value) Then
'                                .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuenta").Value
'                            Else
'                                .Fields("IdCuenta").Value = mvarCuentaCompras
'                            End If
'                            .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                            .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                            .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                            .Fields("IdComprobante").Value = oCP.Id
'                            If mCoef = 1 Then
'                                .Fields("Debe").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
'                            Else
'                                .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value - mvarTotalIVANoDiscriminado
'                            End If
'                            If Not mvarSubdiarios_ResumirRegistros Then
'                                .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
'                            End If
'                            .Update()

'                            mvarTotalIVANoDiscriminado = 0

'                            For i = 1 To 10
'                                If oRsDetBD.Fields("AplicarIVA" & i).Value = "SI" Then
'                                    mvarImporte = oRsDetBD.Fields("Importe").Value
'                                    mvarPorcentajeIVA = IIf(IsNull(oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value), 0, oRsDetBD.Fields("IVAComprasPorcentaje" & i).Value)
'                                    If oCP.Letra = "A" Or oCP.Letra = "M" Then
'                                        mvarIVA1 = Math.Round(mvarImporte * mvarPorcentajeIVA / 100, mvarDecimales)
'                                    Else
'                                        mvarIVA1 = Math.Round((mvarImporte / (1 + (mvarPorcentajeIVA / 100))) * (mvarPorcentajeIVA / 100), mvarDecimales)
'                                        mvarTotalIVANoDiscriminado = mvarTotalIVANoDiscriminado + mvarIVA1
'                                    End If
'                                    If mvarAjusteIVA <> 0 Then
'                                        mvarIVA1 = mvarIVA1 + mvarAjusteIVA
'                                        mvarAjusteIVA = 0
'                                        oCP.PorcentajeIVAAplicacionAjuste = mvarPorcentajeIVA
'                                        'Registro.Update()
'                                    End If
'                                    .AddNew()
'                                    .Fields("Ejercicio").Value = mvarEjercicio
'                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                                    .Fields("IdCuenta").Value = oRsDetBD.Fields("IdCuentaIvaCompras" & i).Value
'                                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                                    .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                                    .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                                    .Fields("IdComprobante").Value = oCP.Id
'                                    If mCoef = 1 Then
'                                        If mvarIVA1 >= 0 Then
'                                            .Fields("Debe").Value = mvarIVA1
'                                        Else
'                                            .Fields("Haber").Value = mvarIVA1 * -1
'                                        End If
'                                    Else
'                                        If mvarIVA1 >= 0 Then
'                                            .Fields("Haber").Value = mvarIVA1
'                                        Else
'                                            .Fields("Debe").Value = mvarIVA1 * -1
'                                        End If
'                                    End If
'                                    If Not mvarSubdiarios_ResumirRegistros Then
'                                        .Fields("IdDetalleComprobante").Value = oRsDetBD.Fields(0).Value
'                                    End If
'                                    .Update()
'                                End If
'                            Next

'                        End With
'                    End If
'                    .MoveNext()
'                Loop
'            End If
'            .Close()
'        End With
'        oRsDetBD = Nothing


'        If oCP.ReintegroIdCuenta > 0 Then
'            If oCP.ReintegroImporte <> 0 Then
'                With oRsCont
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                    .Fields("IdCuenta").Value = mvarCuentaReintegros
'                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                    .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                    .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                    .Fields("IdComprobante").Value = oCP.Id
'                    If mCoef = 1 Then
'                        .Fields("Haber").Value = oCP.ReintegroImporte
'                    Else
'                        .Fields("Debe").Value = oCP.ReintegroImporte
'                    End If
'                    .Update()
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaComprasTitulo
'                    .Fields("IdCuenta").Value = oCP.ReintegroIdCuenta
'                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                    .Fields("NumeroComprobante").Value = oCP.NumeroReferencia
'                    .Fields("FechaComprobante").Value = oCP.FechaRecepcion
'                    .Fields("IdComprobante").Value = oCP.Id
'                    If mCoef = 1 Then
'                        .Fields("Debe").Value = oCP.ReintegroImporte
'                    Else
'                        .Fields("Haber").Value = oCP.ReintegroImporte
'                    End If
'                    .Update()
'                End With
'            End If
'        End If

'        '   mvarDebe = 0
'        '   mvarHaber = 0
'        '   With oRsCont
'        '      If .RecordCount > 0 Then
'        '         .MoveFirst
'        '         Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '               mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '               mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext
'        '         Loop
'        '         If mvarDebe - mvarHaber <> 0 Then
'        '            .MoveFirst
'        '            Do While Not .EOF
'        '               If Not IsNull(.Fields("Debe").Value) And _
'        '                     .Fields("Debe").Value > 0 And mCoef = -1 Then
'        '                  .Fields("Debe").Value = .Fields("Debe").Value + (mvarDebe - mvarHaber)
'        '                  .Update
'        '                  Exit Do
'        '               End If
'        '               If Not IsNull(.Fields("Haber").Value) And _
'        '                     .Fields("Haber").Value > 0 And mCoef = 1 Then
'        '                  .Fields("Haber").Value = .Fields("Haber").Value + (mvarDebe - mvarHaber)
'        '                  .Update
'        '                  Exit Do
'        '               End If
'        '               .MoveNext
'        '            Loop
'        '         End If
'        '         .MoveFirst
'        '      End If
'        '   End With

'Salida:

'        RecalcularRegistroContable = oRsCont

'        oRsDet = Nothing
'        oRs = Nothing
'        oRsCont = Nothing
'        oSrv = Nothing



'    End Function
'    Public Function RecalcularRegistroContableDatatable(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor) As DataTable

'        Dim oRsCont As DataTable
'        Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
'        Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
'        Dim mvarCliente As Double
'        Dim mvarCuentaCliente As Long

'        IsValid(SC, ComprobantePrv) 'para marcar los vacios

'        mvarCuentaClienteMonedaLocal = 0
'        mvarCuentaClienteMonedaExtranjera = 0
'        mvarCliente = 0


'        Return oRsCont


'    End Function





'End Module




'Public Module MigrarRecibo

'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdRecibo As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetRecibos", "TX_Req", IdRecibo))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'    Public Sub RecalcularRegistroContable_SubRecalculoAutomatico(ByVal SC As String, ByRef Recibo As Recibo, ByRef oRsCont As DataTable, _
'                                        ByVal mvarCliente As Long, ByVal mvarCuentaClienteMonedaLocal As Long, _
'                                        ByVal mvarCuentaClienteMonedaExtranjera As Long, _
'                                        ByVal mvarEjercicio As Long, ByVal mvarCuentaCajaTitulo As Long, ByVal mvarCuentaCliente As Long)


'        Dim oSrv 'As InterFazMTS.iCompMTS
'        Dim oRs As DataRow
'        Dim oRsDetCtas As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim mvarCuentaCaja As Long
'        Dim mvarCuentaValores As Long, mvarCuentaRetencionIva As Long
'        Dim mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
'        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
'        Dim mvarCuentaReventas As Long, mvarCuentaDescuentos As Long
'        Dim mvarCuentaDescuentosyRetenciones As Long, mvarCuenta As Long
'        Dim mvarCuentaValoresTitulo As Long
'        Dim mvarCuentaDescuentosyRetencionesTitulo As Long
'        Dim mvarTotalValores As Double
'        Dim mvarAux1 As Double, mvarAux2 As Double
'        Dim mvarDetalleValor As String
'        Dim mvarEsta As Boolean
'        Dim mvarIdMonedaPesos As Integer
'        Dim mvarTotalMonedaLocal As Double, mvarTotalMonedaExtranjera As Double

'        oSrv = CreateObject("MTSPronto.General")

'        oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
'        mvarEjercicio = oRs.Item("EjercicioActual")
'        mvarCuentaCaja = oRs.Item("IdCuentaCaja")
'        mvarCuentaCajaTitulo = oRs.Item("IdCuentaCajaTitulo")
'        mvarCuentaValores = oRs.Item("IdCuentaValores")
'        mvarCuentaValoresTitulo = oRs.Item("IdCuentaValoresTitulo")
'        mvarCuentaRetencionIva = oRs.Item("IdCuentaRetencionIva")
'        mvarCuentaRetencionGanancias = oRs.Item("IdCuentaRetencionGananciasCobros")
'        mvarCuentaRetencionIBrutos = oRs.Item("IdCuentaRetencionIBrutos")
'        mvarCuentaDescuentos = oRs.Item("IdCuentaDescuentos")
'        mvarCuentaDescuentosyRetenciones = oRs.Item("IdCuentaDescuentosyRetenciones")
'        mvarCuentaDescuentosyRetencionesTitulo = oRs.Item("IdCuentaDescuentosyRetencionesTitulo")
'        mvarIdMonedaPesos = oRs.Item("IdMoneda")
'        'oRs.Close()

'        'sub que es llamado por RecalcularRegistroContable
'        'separado solo para hacer mas claro el codigo

'        'recalculo automatico, aplica restricciones


'        Dim oRsDet As ADODB.Recordset
'        Dim oRsDetBD As DataTable


'        With Recibo




'            If Not IsNull(.Efectivo) Then
'                If .Efectivo <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow()
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaCaja
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            .Item("Debe") = Recibo.Efectivo
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda ") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)
'                    End With
'                    mvarCliente = mvarCliente + .Efectivo
'                End If
'            End If


'            If Not IsNull(.Descuentos) Then
'                If .Descuentos <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow()
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaDescuentos
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If Recibo.Descuentos > 0 Then
'                                .Item("Debe") = Recibo.Descuentos
'                            Else
'                                .Item("Haber") = Math.Abs(Recibo.Descuentos)
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)
'                    End With
'                    If .Descuentos > 0 Then
'                        mvarCliente = mvarCliente + .Descuentos
'                    Else
'                        mvarCliente = mvarCliente - .Descuentos
'                    End If

'                End If
'            End If


'            If Not IsNull(.RetencionIVA) Then
'                If .RetencionIVA <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow()
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaRetencionIva
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If Recibo.RetencionIVA > 0 Then
'                                .Item("Debe") = Recibo.RetencionIVA
'                            Else
'                                .Item("Haber") = Math.Abs(Recibo.RetencionIVA)
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)

'                    End With
'                    If .RetencionIVA > 0 Then
'                        mvarCliente = mvarCliente + .RetencionIVA
'                    Else
'                        mvarCliente = mvarCliente - .RetencionIVA
'                    End If
'                End If
'            End If



'            If Not IsNull(.RetencionGanancias) Then
'                If .RetencionGanancias <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaRetencionGanancias
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If Recibo.RetencionGanancias > 0 Then
'                                .Item("Debe") = Recibo.RetencionGanancias
'                            Else
'                                .Item("Haber") = Math.Abs(Recibo.RetencionGanancias)
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)
'                    End With
'                    If .RetencionGanancias > 0 Then
'                        mvarCliente = mvarCliente + .RetencionGanancias
'                    Else
'                        mvarCliente = mvarCliente - .RetencionGanancias
'                    End If
'                End If
'            End If

'            If Not IsNull(.RetencionIBrutos) Then
'                If .RetencionIBrutos <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaRetencionIBrutos
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If Recibo.RetencionIBrutos > 0 Then
'                                .Item("Debe") = Recibo.RetencionIBrutos
'                            Else
'                                .Item("Haber") = Math.Abs(Recibo.RetencionIBrutos)
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)

'                    End With
'                    If .RetencionIBrutos > 0 Then
'                        mvarCliente = mvarCliente + .RetencionIBrutos
'                    Else
'                        mvarCliente = mvarCliente - .RetencionIBrutos
'                    End If
'                End If
'            End If



'            '/////////////////////////////////////////////////
'            '/////////////////////////////////////////////////
'            'para "Otros Conceptos"
'            '/////////////////////////////////////////////////
'            '/////////////////////////////////////////////////

'            'For i = 1 To 10
'            '    If Not IsNull(.Otros & i).Value) Then
'            '        If .Otros" & i).Value <> 0 Then
'            '            With oRsCont
'            '                . Dim dr = .NewRow()      with dr()
'            '                .item("Ejercicio = mvarEjercicio
'            '                .item("IdCuentaSubdiario = mvarCuentaCajaTitulo
'            '                .item("IdCuenta = .IdCuenta" & i).Value()
'            '                .item("IdTipoComprobante = 2
'            '                .item("NumeroComprobante = .NumeroRecibo
'            '                .item("FechaComprobante = .FechaRecibo
'            '                .item("IdComprobante = Registro.Fields(0).Value
'            '                If .Otros" & i).Value > 0 Then
'            '                    .item("Debe = .Otros" & i).Value()
'            '                Else
'            '                    .item("Haber = Abs(.Otros" & i).Value)
'            '                End If
'            '                .item("IdMoneda = .IdMoneda
'            '                .item("CotizacionMoneda = .CotizacionMoneda
'            '                 End With    .Rows.Add(dr)
'            '                If .Otros" & i).Value > 0 Then
'            '                    mvarCliente = mvarCliente + .Otros" & i).Value
'            '                Else
'            '                    mvarCliente = mvarCliente - .Otros" & i).Value
'            '                End If
'            '            End With
'            '        End If
'            '    End If
'            'Next
'            '/////////////////////////////////////////////////
'            '/////////////////////////////////////////////////
'            '/////////////////////////////////////////////////




'            '//////////////////////////////////////////////////////
'            '//////////////////////////////////////////////////////
'            '//////////////////////////////////////////////////////
'            '//////////////////////////////////////////////////////

'            mvarTotalValores = 0


'            For Each i As ReciboValoresItem In .DetallesValores
'                With i
'                    If Not .Eliminado Then




'                        mvarTotalValores = mvarTotalValores + .Importe
'                        If Not IsNull(.NumeroInterno) Then
'                            mvarDetalleValor = "Ch." & .NumeroValor & " [" & .NumeroInterno & "] Vto.:" & .FechaVencimiento
'                        ElseIf Not IsNull(.NumeroTransferencia) Then
'                            mvarDetalleValor = "Transf." & .NumeroTransferencia
'                        End If
'                        mvarCuenta = mvarCuentaValores


'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        'se fija qué tipo de cuenta es
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////



'                        If Not IsNull(IdNull(.IdCuenta)) Then
'                            mvarCuenta = .IdCuenta
'                        ElseIf Not IsNull(IdNull(.IdCaja)) Then
'                            Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.Cajas, .IdCaja)
'                            If Not IsNull(dr.Item("IdCuenta")) Then
'                                mvarCuenta = dr.Item("IdCuenta")
'                            End If
'                        ElseIf Not IsNull(IdNull(.IdTarjetaCredito)) Then
'                            Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.TarjetasCredito, .IdTarjetaCredito)
'                            If Not IsNull(dr.Item("IdCuenta")) Then
'                                mvarCuenta = dr.Item("IdCuenta")

'                            End If
'                            oRsAux.Close()
'                            oRsAux = Nothing
'                        Else
'                            'Continue For 'no, porque si es distinto, usa el mvarcuentavalores que asignó antes
'                        End If

'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////


'                        With oRsCont
'                            Dim dr As DataRow = .NewRow()
'                            With dr
'                                .Item("Ejercicio") = mvarEjercicio
'                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                                .Item("IdCuenta") = mvarCuenta
'                                .Item("IdTipoComprobante") = 2
'                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                                .Item("FechaComprobante") = Recibo.FechaRecibo
'                                .Item("Detalle") = mvarDetalleValor
'                                .Item("IdComprobante") = Recibo.Id
'                                .Item("Debe") = i.Importe
'                                .Item("IdMoneda") = Recibo.IdMoneda
'                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                            End With
'                            .Rows.Add(dr)
'                        End With


'                    End If
'                End With
'            Next







'            '//////////////////////////////////////////////////////
'            '//////////////////////////////////////////////////////
'            'aparentenmente los compara con el original, no?
'            '//////////////////////////////////////////////////////
'            '//////////////////////////////////////////////////////

'            oRsDetBD = EntidadManager.GetListTX(SC, "DetRecibosValores", "TX_PorIdCabecera", Recibo.Id).Tables(0)

'            For Each draux As DataRow In oRsDetBD.Rows
'                With draux


'                    mvarEsta = False

'                    For Each i As ReciboValoresItem In Recibo.DetallesValores
'                        If i.Eliminado Then Continue For

'                        If .Item(0) = i.Id Then
'                            mvarEsta = True
'                            Exit For
'                        End If
'                    Next



'                    If Not mvarEsta Then
'                        mvarTotalValores = mvarTotalValores + .Item("Importe")




'                        If Not IsNull(.Item("NumeroInterno")) Then
'                            mvarDetalleValor = "Ch." & .Item("NumeroValor") & " [" & .Item("NumeroInterno") & "] Vto.:" & .Item("FechaVencimiento")
'                        ElseIf Not IsNull(.Item("NumeroTransferencia")) Then
'                            mvarDetalleValor = "Transf." & .Item("NumeroTransferencia")
'                        End If
'                        mvarCuenta = mvarCuentaValores





'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        'se fija qué tipo de cuenta es
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////

'                        If Not IsNull(.Item("IdCuenta")) Then
'                            mvarCuenta = .Item("IdCuenta")
'                        ElseIf Not IsNull(.Item("IdCaja")) Then

'                            Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.Cajas, .Item("IdCaja"))
'                            If Not IsNull(dr.Item("IdCuenta")) Then
'                                mvarCuenta = dr.Item("IdCuenta")
'                            End If

'                        ElseIf Not IsNull(.Item("IdTarjetaCredito")) Then

'                            Dim dr = EntidadManager.LeerUno(SC, EntidadManager.enumTablas.TarjetasCredito, .Item("IdTarjetaCredito"))
'                            If Not IsNull(dr.Item("IdCuenta")) Then
'                                mvarCuenta = dr.Item("IdCuenta")
'                            End If

'                        End If



'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////
'                        '//////////////////////////////////////////////////////////////////////////////////



'                        With oRsCont
'                            Dim dr As DataRow = .NewRow()
'                            With dr
'                                .Item("Ejercicio") = mvarEjercicio
'                                .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                                .Item("IdCuenta") = mvarCuenta
'                                .Item("IdTipoComprobante") = 2
'                                .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                                .Item("FechaComprobante") = Recibo.FechaRecibo
'                                .Item("Detalle") = mvarDetalleValor
'                                .Item("IdComprobante") = Recibo.Id
'                                .Item("Debe") = draux.Item("Importe")
'                                .Item("IdMoneda") = Recibo.IdMoneda
'                                .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                            End With
'                            .Rows.Add(dr)
'                        End With



'                    End If


'                End With

'            Next










'            '/////////////////////////////////////////////////////////////////////////////
'            'IMPUTACIONES
'            '/////////////////////////////////////////////////////////////////////////////
'            '/////////////////////////////////////////////////////////////////////////////
'            'cómo lo arma dependiendo de si hay moneda extranjera o tomar cotizacion
'            '/////////////////////////////////////////////////////////////////////////////
'            '/////////////////////////////////////////////////////////////////////////////
'            '/////////////////////////////////////////////////////////////////////////////

'            mvarCliente = mvarCliente + mvarTotalValores
'            mvarTotalMonedaLocal = 0
'            mvarTotalMonedaExtranjera = 0


'            If mvarCuentaClienteMonedaLocal = 0 Or mvarCuentaClienteMonedaExtranjera = 0 Then
'                '/////////////////////////////////////////////////////////////////////////////
'                'Creo que acá se mete si es "a Cuentas" (la grilla de imputaciones no se ve)
'                '/////////////////////////////////////////////////////////////////////////////

'                With oRsCont
'                    Dim dr As DataRow = .NewRow()
'                    With dr
'                        .Item("Ejercicio") = mvarEjercicio
'                        .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                        .Item("IdCuenta") = mvarCuentaCliente
'                        .Item("IdTipoComprobante") = 2
'                        .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                        .Item("FechaComprobante") = Recibo.FechaRecibo
'                        .Item("IdComprobante") = Recibo.Id
'                        If mvarCliente > 0 Then
'                            .Item("Haber") = mvarCliente
'                        Else
'                            .Item("Debe") = mvarCliente * -1
'                        End If
'                        .Item("IdMoneda") = Recibo.IdMoneda
'                        .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                    End With
'                    .Rows.Add(dr)
'                End With


'            Else

'                '/////////////////////////////////////////////////////////////////////////////
'                'acá vienen las imputaciones
'                '/////////////////////////////////////////////////////////////////////////////


'                For Each i As ReciboItem In Recibo.DetallesImputaciones
'                    If i.Eliminado Then Continue For

'                    If i.IdImputacion <= 0 Then
'                        mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
'                    Else
'                        Dim dt As DataTable = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion)
'                        If dt.Rows.Count > 0 Then
'                            If dt.Rows(0).Item("IdMoneda") = mvarIdMonedaPesos Then
'                                mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
'                            Else
'                                mvarTotalMonedaExtranjera = mvarTotalMonedaExtranjera + i.Importe
'                            End If
'                        Else
'                            mvarTotalMonedaLocal = mvarTotalMonedaLocal + i.Importe
'                        End If

'                    End If
'                Next






'                mvarAux1 = mvarTotalMonedaLocal
'                mvarAux2 = mvarTotalMonedaExtranjera

'                If mvarAux1 <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow()
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaClienteMonedaLocal
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If mvarAux1 > 0 Then
'                                .Item("Haber") = mvarAux1
'                            Else
'                                .Item("Debe") = mvarAux1 * -1
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)
'                    End With
'                End If


'                If mvarAux2 <> 0 Then
'                    With oRsCont
'                        Dim dr As DataRow = .NewRow()
'                        With dr
'                            .Item("Ejercicio") = mvarEjercicio
'                            .Item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
'                            .Item("IdCuenta") = mvarCuentaClienteMonedaExtranjera
'                            .Item("IdTipoComprobante") = 2
'                            .Item("NumeroComprobante") = Recibo.NumeroRecibo
'                            .Item("FechaComprobante") = Recibo.FechaRecibo
'                            .Item("IdComprobante") = Recibo.Id
'                            If mvarAux2 > 0 Then
'                                .Item("Haber") = mvarAux2
'                            Else
'                                .Item("Debe") = mvarAux2 * -1
'                            End If
'                            .Item("IdMoneda") = Recibo.IdMoneda
'                            .Item("CotizacionMoneda") = Recibo.CotizacionMoneda
'                        End With
'                        .Rows.Add(dr)
'                    End With
'                End If



'            End If




'        End With


'    End Sub

'    Public Function GuardarRegistroContable(ByVal RegistroContable As ADODB.Recordset)

'        Dim oCont ' As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim oRsComprobante As ADODB.Recordset
'        Dim Datos As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
'        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarCotizacionMoneda = 0
'        mvarDebe = 0
'        mvarHaber = 0

'        'With RegistroContable
'        '    If .State <> adStateClosed Then
'        '        If .RecordCount > 0 Then
'        '            .Update()
'        '            .MoveFirst()
'        '            oRsComprobante = oDet.LeerUno("Recibos", RegistroContable.Fields("IdComprobante").Value)
'        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
'        '            oRsComprobante.Close()
'        '            oRsComprobante = Nothing
'        '        End If
'        '        Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '        If .RecordCount > 0 Then
'        '            .MoveFirst()
'        '            If mvarDebe - mvarHaber <> 0 Then
'        '                If Not IsNull(.Fields("Debe").Value) Then
'        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
'        '                Else
'        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
'        '                End If
'        '            End If
'        '        End If
'        '        Do While Not .EOF
'        '            Datos = CreateObject("adodb.Recordset")
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'        '                    Datos.Fields(.Name).Precision = .Precision
'        '                    Datos.Fields(.Name).NumericScale = .NumericScale
'        '                End With
'        '            Next
'        '            Datos.Open()
'        '            Datos.AddNew()
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields(i).Value = .Value
'        '                End With
'        '            Next
'        '            Datos.Update()
'        '            Resp = oDet.Guardar("Subdiarios", Datos)
'        '            Datos.Close()
'        '            Datos = Nothing
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        GuardarRegistroContable = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function

'End Module


'Public Module MigrarRequerimiento
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdRequerimiento As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer


'        oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(SC, enumSPs.DetRequerimientos_TXReq, IdRequerimiento))
'        'oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetRequerimientos", "TX_Req", IdRequerimiento))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'End Module


'Public Module MigrarAsiento
'    Public Function GuardarNoConfirmados(ByVal SC As String, ByRef oCP As Asiento) As ICompMTSManager.MisEstados

'        Dim oCont 'As ObjectContext
'        Dim oDet As ICompMTSManager
'        Dim Resp As ICompMTSManager.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim Datos As ADODB.Recordset
'        Dim i As Integer
'        Dim oFld As ADODB.Field

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        Resp = oDet.GuardarPorRef(SC, "ComprobantesProveedores", oCP)

'        'With Detalles

'        '    If .State <> adStateClosed Then

'        '        If Not .EOF Then
'        '            .Update()
'        '            .MoveFirst()
'        '        End If

'        '        Do While Not .EOF

'        '            .Fields("IdAsiento").Value = Asiento.Fields(0).Value
'        '            .Update()

'        '            If .Fields("Eliminado").Value Then
'        '                oDet.Eliminar(sc, "DetComprobantesProveedores", .Fields(0).Value)
'        '            Else
'        '                Datos = CreateObject("adodb.Recordset")
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'        '                        Datos.Fields(.Name).Precision = .Precision
'        '                        Datos.Fields(.Name).NumericScale = .NumericScale
'        '                    End With
'        '                Next
'        '                Datos.Open()
'        '                Datos.AddNew()
'        '                For i = 0 To .Fields.Count - 2
'        '                    With .Fields(i)
'        '                        Datos.Fields(i).Value = .Value
'        '                    End With
'        '                Next
'        '                Datos.Update()
'        '                Resp = oDet.Guardar(sc, "DetComprobantesProveedores", Datos)
'        '                Datos.Close()
'        '                Datos = Nothing
'        '            End If

'        '            .MoveNext()

'        '        Loop

'        '    End If

'        'End With

'        'If Not oCont Is Nothing Then
'        '    With oCont
'        '        If .IsInTransaction Then .SetComplete()
'        '    End With
'        'End If

'Salir:
'        GuardarNoConfirmados = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        'If lErr Then
'        '    Err.Raise(lErr, sSource, sDesc)
'        'End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetComprobantePrvs", "TX_Req", IdComprobantePrv))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'    Public Function GuardarRegistroContable(ByVal RegistroContable As ADODB.Recordset)

'        Dim oCont ' As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim oRsComprobante As ADODB.Recordset
'        Dim Datos As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
'        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarCotizacionMoneda = 0
'        mvarDebe = 0
'        mvarHaber = 0

'        'With RegistroContable
'        '    If .State <> adStateClosed Then
'        '        If .RecordCount > 0 Then
'        '            .Update()
'        '            .MoveFirst()
'        '            oRsComprobante = oDet.LeerUno(sc,"ComprobantePrvs", RegistroContable.Fields("IdComprobante").Value)
'        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
'        '            oRsComprobante.Close()
'        '            oRsComprobante = Nothing
'        '        End If
'        '        Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '        If .RecordCount > 0 Then
'        '            .MoveFirst()
'        '            If mvarDebe - mvarHaber <> 0 Then
'        '                If Not IsNull(.Fields("Debe").Value) Then
'        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
'        '                Else
'        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
'        '                End If
'        '            End If
'        '        End If
'        '        Do While Not .EOF
'        '            Datos = CreateObject("adodb.Recordset")
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'        '                    Datos.Fields(.Name).Precision = .Precision
'        '                    Datos.Fields(.Name).NumericScale = .NumericScale
'        '                End With
'        '            Next
'        '            Datos.Open()
'        '            Datos.AddNew()
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields(i).Value = .Value
'        '                End With
'        '            Next
'        '            Datos.Update()
'        '            Resp = oDet.Guardar("Subdiarios", Datos)
'        '            Datos.Close()
'        '            Datos = Nothing
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        GuardarRegistroContable = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function

'    Public Sub RecalcularRegistroContable_SubRecalculoAutomatico(ByVal SC As String, ByRef ComprobantePrv As Asiento, ByRef oRsCont As DataTable, _
'                                    ByVal mvarCliente As Long, ByVal mvarCuentaClienteMonedaLocal As Long, _
'                                    ByVal mvarCuentaClienteMonedaExtranjera As Long, _
'                                    ByVal mvarEjercicio As Long, ByVal mvarCuentaCajaTitulo As Long, ByVal mvarCuentaCliente As Long)


'        Dim oSrv 'As InterFazMTS.iCompMTS
'        Dim oRs As DataRow
'        Dim oRsDetCtas As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim mvarCuentaCaja As Long
'        Dim mvarCuentaValores As Long, mvarCuentaRetencionIva As Long
'        Dim mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
'        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long
'        Dim mvarCuentaReventas As Long, mvarCuentaDescuentos As Long
'        Dim mvarCuentaDescuentosyRetenciones As Long, mvarCuenta As Long
'        Dim mvarCuentaValoresTitulo As Long
'        Dim mvarCuentaDescuentosyRetencionesTitulo As Long
'        Dim mvarTotalValores As Double
'        Dim mvarAux1 As Double, mvarAux2 As Double
'        Dim mvarDetalleValor As String
'        Dim mvarEsta As Boolean
'        Dim mvarIdMonedaPesos As Integer
'        Dim mvarTotalMonedaLocal As Double, mvarTotalMonedaExtranjera As Double

'        oSrv = CreateObject("MTSPronto.General")

'        oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

















'    End Sub

'    Public Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef oAs As Asiento) As ICompMTSManager.MisEstados
'        '            'todo esto estaba en el mts

'        Exit Function

'        'Dim RegistroContable As adodb.Recordset = AsientoManager.RecalcularRegistroContable(SC, oCP)




'        Dim oCont 'As ObjectContext
'        Dim oDet As ICompMTSManager
'        Dim Resp As ICompMTSManager.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim Datos As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oRsValores As ADODB.Recordset
'        Dim mvarIdentificador As Long, mvarIdCaja As Long, mvarIdBanco As Long
'        Dim mIdValor As Long, mvarIdDetalleAsiento As Long, mvarIdCuenta As Long
'        Dim i As Integer, mvarTipoComprobante As Integer
'        Dim mvarImporte As Double, mvarImporteDebe As Double, mvarImporteHaber As Double
'        Dim mvarBorrarEnValores As Boolean
'        Dim oFld As ADODB.Field

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarIdentificador = oAs.Id

'        ' Resp = iCompMTS_GuardarPorRef("Asientos", Asiento)


'        For Each d As AsientoItem In oAs.Detalles

'            With d

'                .IdAsiento = oAs.Id


'                'FALTA ARREGLAR:


'                'If .Eliminado Then

'                '    oDet.Eliminar(SC, "DetAsientos", .Id)
'                '    oDet.Tarea(sc, "Valores_BorrarPorIdDetalleAsiento", .Id)

'                'Else

'                '    mvarBorrarEnValores = True


'                '    mvarIdDetalleAsiento = Datos.id

'                '    If (IsNull(.Fields("RegistrarEnAnalitico").Value) Or _
'                '          .Fields("RegistrarEnAnalitico").Value = "SI") And _
'                '          IsNull(.Fields("IdValor").Value) Then
'                '        oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaCajaBanco", .Fields("IdCuenta").Value)
'                '        If oRsAux.RecordCount > 0 Then
'                '            If Not IsNull(oRsAux.Fields("EsCajaBanco").Value) And _
'                '                  (oRsAux.Fields("EsCajaBanco").Value = "BA" Or _
'                '                   oRsAux.Fields("EsCajaBanco").Value = "CA") Then

'                '                mvarIdCaja = IIf(IsNull(oRsAux.Fields("IdCaja").Value), 0, oRsAux.Fields("IdCaja").Value)
'                '                oRsAux.Close()

'                '                mIdValor = -1
'                '                oRsValores = oDet.TraerFiltrado("Valores", "_PorIdDetalleAsiento", mvarIdDetalleAsiento)
'                '                If oRsValores.RecordCount > 0 Then
'                '                    mIdValor = oRsValores.id
'                '                End If
'                '                oRsValores.Close()
'                '                oRsValores = Nothing

'                '                mvarIdBanco = 0
'                '                If Not IsNull(.Fields("IdCuentaBancaria").Value) Then
'                '                    oRsAux = oDet.TraerFiltrado("CuentasBancarias", "_PorId", .Fields("IdCuentaBancaria").Value)
'                '                    If oRsAux.RecordCount > 0 Then
'                '                        mvarIdBanco = oRsAux.Fields("IdBanco").Value
'                '                    End If
'                '                    oRsAux.Close()
'                '                End If

'                '                If mvarIdBanco <> 0 Or mvarIdCaja <> 0 Then
'                '                    mvarImporteDebe = 0
'                '                    mvarImporteHaber = 0
'                '                    If Not IsNull(.Fields("Debe").Value) And .Fields("Debe").Value <> 0 Then
'                '                        mvarImporteDebe = IIf(IsNull(.Fields("ImporteEnMonedaDestino").Value), .Fields("Debe").Value, .Fields("ImporteEnMonedaDestino").Value)
'                '                    End If
'                '                    If Not IsNull(.Fields("Haber").Value) And .Fields("Haber").Value <> 0 Then
'                '                        mvarImporteHaber = IIf(IsNull(.Fields("ImporteEnMonedaDestino").Value), .Fields("Haber").Value, .Fields("ImporteEnMonedaDestino").Value)
'                '                    End If
'                '                    mvarImporte = mvarImporteDebe - mvarImporteHaber
'                '                    If mvarImporte >= 0 Then
'                '                        mvarTipoComprobante = 36
'                '                    Else
'                '                        mvarImporte = Abs(mvarImporte)
'                '                        mvarTipoComprobante = 37
'                '                    End If
'                '                    oRsValores = CopiarRs(oDet.TraerFiltrado("Valores", "_Struc"))
'                '                    With oRsValores
'                '                        .Fields("IdTipoValor").Value = mvarTipoComprobante
'                '                        .Fields("NumeroValor").Value = 0
'                '                        .Fields("NumeroInterno").Value = 0
'                '                        .Fields("FechaValor").Value = Asiento.Fields("FechaAsiento").Value
'                '                        .Fields("IdCuentaBancaria").Value = Detalles.Fields("IdCuentaBancaria").Value
'                '                        If mvarIdBanco <> 0 Then .Fields("IdBanco").Value = mvarIdBanco
'                '                        If mvarIdCaja <> 0 Then .Fields("IdCaja").Value = mvarIdCaja
'                '                        .Fields("Importe").Value = mvarImporte
'                '                        .Fields("NumeroComprobante").Value = Asiento.Fields("NumeroAsiento").Value
'                '                        .Fields("FechaComprobante").Value = Asiento.Fields("FechaAsiento").Value
'                '                        .Fields("IdTipoComprobante").Value = 38
'                '                        .Fields("IdDetalleAsiento").Value = mvarIdDetalleAsiento
'                '                        .Fields("IdMoneda").Value = Detalles.Fields("IdMonedaDestino").Value
'                '                        .Fields("CotizacionMoneda").Value = IIf(IsNull(Detalles.Fields("CotizacionMonedaDestino").Value), 0, Detalles.Fields("CotizacionMonedaDestino").Value)
'                '                        .id = mIdValor
'                '                    End With
'                '                    Resp = oDet.Guardar("Valores", oRsValores)
'                '                    oRsValores.Close()
'                '                    oRsValores = Nothing
'                '                    mvarBorrarEnValores = False
'                '                End If
'                '            End If
'                '        Else
'                '            oRsAux.Close()
'                '        End If
'                '        oRsAux = Nothing
'                '    Else
'                '        mvarBorrarEnValores = True
'                '    End If

'                '    If .Id > 0 And mvarBorrarEnValores Then
'                '        oDet.Tarea("Valores_BorrarPorIdDetalleAsiento", .Id)
'                '    End If

'                'End If



'            End With















'        Next




'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        Guardar_CodigoOriginalDeVB6 = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir






'    End Function
'End Module


'Public Module MigrarOrdenPago
'    Public Function IsValidItemValor(ByVal SC As String, ByRef myItemValor As OrdenPagoValoresItem, Optional ByRef ms As String = "", Optional ByRef myOrdenPago As OrdenPago = Nothing) As Boolean

'        With myItemValor

'            'If Len(DataCombo1(0).BoundText) = 0 Then
'            '    MsgBox("No definio el tipo de valor", vbExclamation)
'            '    Exit Function
'            'End If

'            'If DataCombo1(1).Visible And Len(DataCombo1(1).BoundText) = 0 Then
'            '    MsgBox("No definio la cuenta bancaria", vbExclamation)
'            '    Exit Function
'            'End If

'            'If DataCombo1(0).BoundText = 6 And Len(DataCombo1(2).BoundText) = 0 Then
'            '    MsgBox("No definio la chequera", vbExclamation)
'            '    Exit Function
'            'End If

'            'If DataCombo1(3).Visible And Len(DataCombo1(3).BoundText) = 0 Then
'            '    MsgBox("No definio la tarjeta de credito", vbExclamation)
'            '    Exit Function
'            'End If

'            'If Not origen.NumeroValorValido Then
'            '    MsgBox("Numero de valor existente", vbExclamation)
'            '    Exit Function
'            'End If



'            'mDiasCheque = 1
'            'If BuscarClaveINI("No controlar fecha de cheques de pago diferido en op") = "SI" Then mDiasCheque = 0
'            'If Not Me.Exterior And mvarChequeraPagoDiferido = "SI" And DateDiff("d", Me.FechaOP, DTFields(0).Value) < mDiasCheque Then
'            '    MsgBox("La fecha del cheque no puede ser anterior al " & DateAdd("d", mDiasCheque, Me.FechaOP), vbExclamation)
'            '    Exit Function
'            'End If


'            Dim mvarChequeraDesde, mvarChequeraHasta, mvarChequeraPagoDiferido

'            Dim oRs = TraerFiltradoVB6(SC, enumSPs.BancoChequeras_TX_PorId, .IdBancoChequera)
'            If oRs.RecordCount > 0 Then
'                mvarChequeraDesde = IIf(IsNull(oRs.Fields("DesdeCheque").Value), 0, oRs.Fields("DesdeCheque").Value)
'                mvarChequeraHasta = IIf(IsNull(oRs.Fields("HastaCheque").Value), 0, oRs.Fields("HastaCheque").Value)
'                mvarChequeraPagoDiferido = IIf(IsNull(oRs.Fields("ChequeraPagoDiferido").Value), "NO", oRs.Fields("ChequeraPagoDiferido").Value)
'            End If

'            If mvarChequeraDesde <> 0 And mvarChequeraHasta <> 0 And .NumeroValor < mvarChequeraDesde Or .NumeroValor > mvarChequeraHasta Then
'                ms = "El numero de valor debe estar entre " & mvarChequeraDesde & " y el " & mvarChequeraHasta
'            End If


'        End With


'        Return True

'    End Function
'    Public Function ValorDiferenciaCambio(ByVal SC As String, ByRef OP As OrdenPago)

'        Dim oRs As ADODB.Recordset
'        Dim oRs1 As ADODB.Recordset
'        Dim mDifer As Double


'        mDifer = 0
'        For Each i In OP.DetallesImputaciones
'            With i
'                If Not .Eliminado Then
'                    If Not IsNull(.IdImputacion) And Not IsNull(.Importe) Then
'                        oRs1 = TraerFiltradoVB6(SC, enumSPs.DiferenciasCambio_TX_ParaCalculoIndividual, _
'                              .IdImputacion, 4, .Importe, OP.IdMoneda)
'                        If oRs1.RecordCount > 0 Then
'                            mDifer = mDifer + iisNull(oRs1.Fields("Dif_cambio $").Value, 0)
'                        End If
'                        oRs1.Close()
'                        oRs1 = Nothing
'                    End If
'                End If
'            End With
'        Next

'        oRs = Nothing

'        ValorDiferenciaCambio = Math.Round(mDifer, 2)
'    End Function

'    Public Sub RecalcularImpuestos(ByVal SC As String, ByRef myOP As OrdenPago)

'        ' traido de Compronto.DetOrdenesPagoImpuestos.RegistrosConFormato (de la coleccion de impuestos)

'        Dim mCol As OrdenPagoImpuestosItemList = myOP.DetallesImpuestos
'        Dim Item As OrdenPagoImpuestosItem


'        'Dim oRs As adodb.Recordset
'        'Dim oRsFmt As adodb.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oRsAux1 As Pronto.ERP.BO.Proveedor
'        Dim oC As OrdenPagoImpuestosItem '  DetOrdenPagoImpuestos 
'        Dim oFld As ADODB.Field
'        Dim VectorX As String, VectorT As String, mLeyendaPorcentajeAdicional As String, GeneraImpuestos As String
'        Dim mRegimenEspecialConstruccionIIBB As String
'        Dim mFecha As Date, mFechaInicioVigenciaIBDirecto As Date, mFechaFinVigenciaIBDirecto As Date
'        Dim mEsta As Boolean, mFacturaM As Boolean, mAplicarAlicuotaConvenio As Boolean, mAplicarAlicuotaDirecta As Boolean
'        Dim i As Integer, mIdMoneda As Integer
'        Dim mIdProveedor As Long
'        Dim mImporte As Double, mImpuestoRetenido As Double, mBaseIIBB As Double, mImpuestoAdicional As Double
'        Dim mImpuestoARetener As Double, mImporteComprobantesMParaRetencionGanancias As Double
'        Dim mPorcentajeATomarSobreBase As Single, mPorcentajeAdicional As Single, mCoeficienteUnificado As Single
'        Dim mAlicuota As Single, mAlicuotaConvenio As Single, mPorcentajeRetencionGananciasComprobantesM As Single
'        Dim mAlicuotaDirecta As Single



'        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
'        With p
'            mImporteComprobantesMParaRetencionGanancias = If(.Item("ImporteComprobantesMParaRetencionGanancias"), 0)
'            mPorcentajeRetencionGananciasComprobantesM = If(.Item("PorcentajeRetencionGananciasComprobantesM"), 0)
'        End With


'        mIdMoneda = IIf(IsNull(myOP.IdMoneda), 1, myOP.IdMoneda)
'        Dim r = GetStoreProcedureTop1(SC, enumSPs.Monedas_T, mIdMoneda)
'        If iisNull(r.Item("GeneraImpuestos"), "NO") = "NO" Then
'            GeneraImpuestos = "NO"
'        Else
'            GeneraImpuestos = "SI"
'        End If


'        'oRs = GetStoreProcedureTop1(SC, enumSPs.DetOrdenesPagoImpuestos_TXPrimero)



'        oRsAux = myOP.Detalle

'        mIdProveedor = 0
'        If Not IsNull(myOP.IdProveedor) Then
'            mIdProveedor = myOP.IdProveedor
'        End If

'        mFecha = Today
'        If Not IsNull(myOP.FechaOrdenPago) Then
'            mFecha = myOP.FechaOrdenPago
'        End If



'        For Each oC In mCol
'            If Not oC.Eliminado Then
'                With oC
'                    .ImportePagado = 0
'                    .ImpuestoRetenido = 0
'                    .ImporteTotalFacturasMPagadasSujetasARetencion = 0
'                End With
'            End If
'        Next

'        If GeneraImpuestos = "NO" Then
'            GoTo Salida
'        End If

'        'Generar registros de Ganancias
'        For Each it In myOP.DetallesImputaciones

'            If it.Eliminado Then Continue For

'            With it
'                If .IdTipoRetencionGanancia > 0 Then
'                    If Mid(.Numero, 1, 1) = "M" Then mFacturaM = True Else mFacturaM = False

'                    mImporte = iisNull(.ImportePagadoSinImpuestos, .Importe)

'                    mEsta = False
'                    For Each oC In mCol
'                        If Not oC.Eliminado Then
'                            With oC
'                                If .TipoImpuesto = "Ganancias" And _
'                                      .IdTipoRetencionGanancia = it.IdTipoRetencionGanancia Then

'                                    .ImportePagado += mImporte

'                                    mEsta = True
'                                    Exit For
'                                End If
'                            End With
'                        End If
'                    Next
'                    If Not mEsta Then
'                        Item = New OrdenPagoImpuestosItem
'                        With Item
'                            .TipoImpuesto = "Ganancias"





'                            .IdTipoRetencionGanancia = it.IdTipoRetencionGanancia
'                            .ImporteTotalFacturasMPagadasSujetasARetencion = 0
'                            .ImportePagado = mImporte
'                            .ImpuestoRetenido = 0
'                        End With
'                        mCol.Add(Item)
'                    End If
'                End If
'            End With
'        Next



'        'Generar registros de Ingresos Brutos
'        For Each it In myOP.DetallesImputaciones

'            If it.Eliminado Then Continue For

'            With it
'                If .IdIBCondicion > 0 Then
'                    If .BaseCalculoIIBB = "SIN IMPUESTOS" Then
'                        mImporte = iisNull(.ImportePagadoSinImpuestos, .Importe)
'                    Else
'                        mImporte = iisNull(.Importe, .ImportePagadoSinImpuestos)
'                    End If
'                    mEsta = False


'                    For Each oC In mCol
'                        If Not oC.Eliminado Then
'                            With oC
'                                If .TipoImpuesto = "I.Brutos" And _
'                                      Not IsNull(it.IdIBCondicion) And _
'                                      .IdIBCondicion = it.IdIBCondicion Then
'                                    .ImportePagado += mImporte
'                                    mEsta = True
'                                    Exit For
'                                End If
'                            End With
'                        End If
'                    Next
'                    If Not mEsta Then
'                        Item = New OrdenPagoImpuestosItem
'                        With Item

'                            .TipoImpuesto = "I.Brutos"
'                            .IdIBCondicion = it.IdIBCondicion
'                            .ImportePagado = mImporte
'                            .ImpuestoRetenido = 0


'                        End With
'                        mCol.Add(Item)
'                    End If
'                End If
'            End With
'        Next

'        oRsAux = Nothing




'        For Each oC In mCol
'            If Not oC.Eliminado Then
'                With oC
'                    If .IdTipoRetencionGanancia > 0 Then
'                        '///////////////////////////////////////////////////////////////////////////////
'                        '///////////////////////////////////////////////////////////////////////////////
'                        'Ganancias
'                        '///////////////////////////////////////////////////////////////////////////////
'                        '///////////////////////////////////////////////////////////////////////////////


'                        .Categoria = GetStoreProcedureTop1(SC, enumSPs.TiposRetencionGanancia_TX_PorId, .IdTipoRetencionGanancia).Item("Descripcion")
'                        .NumeroCertificadoRetencionGanancias = .NumeroCertificadoRetencionGanancias
'                        mImporte = IIf(IsNull(.ImportePagado), 0, .ImportePagado)
'                        oRsAux = TraerFiltradoVB6(SC, enumSPs.Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia, mIdProveedor, mFecha, .IdTipoRetencionGanancia, mImporte, myOP.Id)
'                        mImpuestoARetener = 0
'                        If oRsAux.RecordCount > 0 Then
'                            mImpuestoARetener = oRsAux.Fields("ImpuestoARetener").Value
'                            .PagosMes = oRsAux.Fields("ImporteAcumulado").Value
'                            .RetencionesMes = oRsAux.Fields("Retenido").Value
'                        End If
'                        oRsAux.Close()
'                        If .ImporteTotalFacturasMPagadasSujetasARetencion <> 0 Then
'                            mImpuestoARetener = mImpuestoARetener + _
'                                           Math.Round(.ImporteTotalFacturasMPagadasSujetasARetencion * mPorcentajeRetencionGananciasComprobantesM / 100, 2)
'                        End If
'                        .ImpuestoRetenido = mImpuestoARetener

'                    ElseIf .IdIBCondicion > 0 Then
'                        '///////////////////////////////////////////////////////////////////////////////
'                        '///////////////////////////////////////////////////////////////////////////////
'                        'IIBB
'                        '///////////////////////////////////////////////////////////////////////////////
'                        '///////////////////////////////////////////////////////////////////////////////


'                        .ImpuestoRetenido = 0
'                        '.NumeroCertificadoRetencionIIBB = .Fields("NumeroCertificadoRetencionIIBB").Value
'                        mImpuestoAdicional = 0
'                        mImpuestoRetenido = 0
'                        mAlicuotaConvenio = 0
'                        mCoeficienteUnificado = 0
'                        mAlicuotaDirecta = 0
'                        mFechaInicioVigenciaIBDirecto = Nothing
'                        mFechaFinVigenciaIBDirecto = Nothing
'                        mAplicarAlicuotaConvenio = False
'                        mAplicarAlicuotaDirecta = False
'                        mRegimenEspecialConstruccionIIBB = ""


'                        oRsAux1 = ProveedorManager.GetItem(SC, mIdProveedor)
'                        mCoeficienteUnificado = oRsAux1.CoeficienteIIBBUnificado
'                        mAlicuotaDirecta = IIf(IsNull(oRsAux1.PorcentajeIBDirecto), 0, oRsAux1.PorcentajeIBDirecto)
'                        mFechaInicioVigenciaIBDirecto = IIf(IsNull(oRsAux1.FechaInicioVigenciaIBDirecto), 0, oRsAux1.FechaInicioVigenciaIBDirecto)
'                        mFechaFinVigenciaIBDirecto = IIf(IsNull(oRsAux1.FechaFinVigenciaIBDirecto), 0, oRsAux1.FechaFinVigenciaIBDirecto)
'                        'mRegimenEspecialConstruccionIIBB = oRsAux1.RegimenEspecialConstruccionIIBB
'                        If Not IsNull(oRsAux1.IBCondicion) And oRsAux1.IBCondicion = 2 Then
'                            Dim oRsAux3 = GetStoreProcedureTop1(SC, enumSPs.DetProveedoresIB_TX_PorIdProveedorIdIBCondicion, mIdProveedor, .IdIBCondicion)
'                            If Not IsNothing(oRsAux3) Then
'                                mAlicuotaConvenio = iisNull(oRsAux3.Item("AlicuotaAAplicar"), 0)
'                                mAplicarAlicuotaConvenio = True
'                            End If
'                        End If


'                        Dim oRsAux2 = DataTable_To_Recordset(GetStoreProcedure(SC, enumSPs.IBCondiciones_T, .IdIBCondicion))
'                        If oRsAux2.RecordCount > 0 Then
'                            mPorcentajeATomarSobreBase = IIf(IsNull(oRsAux2.Fields("PorcentajeATomarSobreBase").Value), 100, oRsAux2.Fields("PorcentajeATomarSobreBase").Value)
'                            mPorcentajeAdicional = IIf(IsNull(oRsAux2.Fields("PorcentajeAdicional").Value), 0, oRsAux2.Fields("PorcentajeAdicional").Value)
'                            mLeyendaPorcentajeAdicional = IIf(IsNull(oRsAux2.Fields("LeyendaPorcentajeAdicional").Value), "", oRsAux2.Fields("LeyendaPorcentajeAdicional").Value)
'                            If IIf(IsNull(oRsAux2.Fields("IdProvinciaReal").Value), oRsAux2.Fields("IdProvincia").Value, oRsAux2.Fields("IdProvinciaReal").Value) = 2 And _
'                                  mFecha >= mFechaInicioVigenciaIBDirecto And mFecha <= mFechaFinVigenciaIBDirecto And mRegimenEspecialConstruccionIIBB <> "SI" Then
'                                'mAlicuotaDirecta <> 0 And
'                                mAlicuota = mAlicuotaDirecta
'                                mAplicarAlicuotaDirecta = True
'                            Else
'                                mAlicuota = IIf(IsNull(oRsAux2.Fields("Alicuota").Value), 0, oRsAux2.Fields("Alicuota").Value)
'                            End If
'                            .Categoria = oRsAux2.Fields("Descripcion").Value
'                            .ImporteTopeMinimoIIBB = IIf(IsNull(oRsAux2.Fields("ImporteTopeMinimo").Value), 0, oRsAux2.Fields("ImporteTopeMinimo").Value)
'                            .AlicuotaIIBB = mAlicuota
'                            .AlicuotaConvenioIIBB = mAlicuotaConvenio
'                            .PagosMes = 0
'                            .RetencionesMes = 0
'                            .ImpuestoRetenido = 0
'                            .PorcentajeATomarSobreBase = 100
'                            .PorcentajeAdicional = 0
'                            .ImpuestoAdicional = 0
'                            mImporte = IIf(IsNull(.ImportePagado), 0, .ImportePagado)
'                            If Not IsNull(oRsAux2.Fields("AcumulaMensualmente").Value) And oRsAux2.Fields("AcumulaMensualmente").Value = "SI" Then
'                                oRsAux = DataTable_To_Recordset(GetStoreProcedure(SC, enumSPs.IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion, mIdProveedor, mFecha, .IdIBCondicion, myOP.Id))
'                                If oRsAux.RecordCount > 0 Then
'                                    .PagosMes = oRsAux.Fields("ImporteAcumulado").Value
'                                    .RetencionesMes = oRsAux.Fields("ImpuestoRetenido").Value
'                                End If
'                                oRsAux.Close()
'                            End If
'                            If mImporte > .ImporteTopeMinimoIIBB Then
'                                mBaseIIBB = (mImporte + .PagosMes * mPorcentajeATomarSobreBase / 100)
'                                If mCoeficienteUnificado > 0 And mCoeficienteUnificado <= 100 Then
'                                    mBaseIIBB = mBaseIIBB * mCoeficienteUnificado / 100
'                                End If
'                                If mAplicarAlicuotaConvenio And Not mAplicarAlicuotaDirecta Then
'                                    mImpuestoRetenido = Math.Round(mBaseIIBB * mAlicuotaConvenio / 100, 2)
'                                Else
'                                    mImpuestoRetenido = Math.Round(mBaseIIBB * mAlicuota / 100, 2)
'                                End If
'                                mImpuestoAdicional = Math.Round(mImpuestoRetenido * mPorcentajeAdicional / 100, 2)
'                                mImpuestoRetenido = mImpuestoRetenido + mImpuestoAdicional
'                                mImpuestoRetenido = mImpuestoRetenido - .RetencionesMes
'                                If mImpuestoRetenido < 0 Then mImpuestoRetenido = 0
'                            End If
'                            .ImpuestoRetenido = mImpuestoRetenido
'                            If mCoeficienteUnificado > 0 And mCoeficienteUnificado <= 100 Then
'                                .PorcentajeATomarSobreBase = mCoeficienteUnificado
'                            Else
'                                .PorcentajeATomarSobreBase = mPorcentajeATomarSobreBase
'                            End If
'                            .PorcentajeAdicional = mPorcentajeAdicional
'                            .ImpuestoAdicional = mImpuestoAdicional
'                            .PorcentajeATomarSobreBase = mPorcentajeATomarSobreBase
'                            .PorcentajeAdicional = mPorcentajeAdicional
'                            '.LeyendaPorcentajeAdicional = mLeyendaPorcentajeAdicional
'                            .ImpuestoAdicional = mImpuestoAdicional
'                            .ImpuestoRetenido = mImpuestoRetenido
'                            If mAplicarAlicuotaConvenio And Not mAplicarAlicuotaDirecta Then
'                                .AlicuotaAplicada = Nothing
'                                .AlicuotaConvenioAplicada = mAlicuotaConvenio
'                            Else
'                                .AlicuotaAplicada = mAlicuota
'                                .AlicuotaConvenioAplicada = Nothing
'                            End If
'                        End If
'                    End If
'                End With
'            End If
'        Next


'        RefrescarDesnormalizados(SC, myOP)


'Salida:

'        'oRs.Close()

'        'oRs = Nothing
'        oRsAux = Nothing
'        oRsAux1 = Nothing
'        oC = Nothing
'        oFld = Nothing


'    End Sub

'    Public Function _RegistroContableOriginalVB6conADORrecordsets(ByVal SC As String, ByRef OP As OrdenPago) As ADODB.Recordset


'        'Traido de Compronto.OrdenPago.RegistroContable()

'        Dim oRs As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oRsCont As ADODB.Recordset
'        Dim oRsDet As ADODB.Recordset
'        Dim oRsDetCtas As ADODB.Recordset
'        Dim oRsBco As DataRow
'        Dim oRsProv As ADODB.Recordset
'        Dim oRsDetBD As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim mvarEjercicio As Long, mvarCuentaCaja As Long, mvarCuentaProveedor As Long, mvarCuentaValores As Long
'        Dim mvarCuentaRetencionIva As Long, mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
'        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaReventas As Long
'        Dim mvarCuentaDescuentos As Long, mvarCuentaDescuentosyRetenciones As Long, mvarCuentaValores1 As Long
'        Dim mvarCuentaCajaTitulo As Long, mvarCuentaValoresTitulo As Long, mvarCuentaDescuentosyRetencionesTitulo As Long
'        Dim mvarPosicion As Long, mvarCuentaRetencionSUSS As Long, mvarIdImpuestoDirectoSUSS As Long
'        Dim mvarIdIBCondicionPorDefecto As Long, mvarCuentaRetencionIvaComprobantesM As Long
'        Dim mvarRetencionIvaComprobantesM As Double, mvarTotalValores As Double, mvarImporte As Double, mvarDebe As Double
'        Dim mvarHaber As Double
'        Dim mvarDetalleValor As String, mvarDetalle As String, mvarDebeHaber As String, mvarChequeraPagoDiferido As String
'        Dim mvarActivarCircuitoChequesDiferidos As String, mvarDetVal As String
'        Dim mvarEsta As Boolean, mvarProcesar As Boolean




'        'mvarEjercicio = IIf(IsNull(oRs.Fields("EjercicioActual").Value), 0, oRs.Fields("EjercicioActual").Value)
'        'mvarCuentaCaja = IIf(IsNull(oRs.Fields("IdCuentaCaja").Value), 0, oRs.Fields("IdCuentaCaja").Value)
'        'mvarCuentaCajaTitulo = IIf(IsNull(oRs.Fields("IdCuentaCajaTitulo").Value), 0, oRs.Fields("IdCuentaCajaTitulo").Value)
'        'mvarCuentaValores = IIf(IsNull(oRs.Fields("IdCuentaValores").Value), 0, oRs.Fields("IdCuentaValores").Value)
'        'mvarCuentaValoresTitulo = IIf(IsNull(oRs.Fields("IdCuentaValoresTitulo").Value), 0, oRs.Fields("IdCuentaValoresTitulo").Value)
'        'mvarCuentaRetencionIva = IIf(IsNull(oRs.Fields("IdCuentaRetencionIva").Value), 0, oRs.Fields("IdCuentaRetencionIva").Value)
'        'mvarCuentaRetencionIvaComprobantesM = IIf(IsNull(oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value), 0, oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value)
'        'mvarCuentaRetencionGanancias = IIf(IsNull(oRs.Fields("IdCuentaRetencionGanancias").Value), 0, oRs.Fields("IdCuentaRetencionGanancias").Value)
'        'mvarCuentaRetencionIBrutos = IIf(IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value), 0, oRs.Fields("IdCuentaRetencionIBrutos").Value)
'        'mvarCuentaDescuentos = IIf(IsNull(oRs.Fields("IdCuentaDescuentos").Value), 0, oRs.Fields("IdCuentaDescuentos").Value)
'        'mvarCuentaDescuentosyRetenciones = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetenciones").Value), 0, oRs.Fields("IdCuentaDescuentosyRetenciones").Value)
'        'mvarCuentaDescuentosyRetencionesTitulo = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value), 0, oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value)
'        'mvarCuentaRetencionSUSS = IIf(IsNull(oRs.Fields("IdCuentaRetencionSUSS").Value), 0, oRs.Fields("IdCuentaRetencionSUSS").Value)
'        'mvarActivarCircuitoChequesDiferidos = IIf(IsNull(oRs.Fields("ActivarCircuitoChequesDiferidos").Value), "NO", oRs.Fields("ActivarCircuitoChequesDiferidos").Value)
'        'oRs.Close()





'        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
'        With p
'            mvarEjercicio = .Item("EjercicioActual")
'            mvarCuentaCaja = .Item("IdCuentaCaja")
'            mvarCuentaCajaTitulo = .Item("IdCuentaCajaTitulo")
'            mvarCuentaValores = .Item("IdCuentaValores")
'            mvarCuentaValoresTitulo = .Item("IdCuentaValoresTitulo")
'            mvarCuentaRetencionIva = .Item("IdCuentaRetencionIva")
'            mvarCuentaRetencionIvaComprobantesM = .Item("IdCuentaRetencionIvaComprobantesM")
'            mvarCuentaRetencionGanancias = .Item("IdCuentaRetencionGananciasCobros")
'            mvarCuentaRetencionIBrutos = .Item("IdCuentaRetencionIBrutos")
'            mvarCuentaDescuentos = .Item("IdCuentaDescuentos")
'            mvarCuentaDescuentosyRetenciones = .Item("IdCuentaDescuentosyRetenciones")
'            mvarCuentaDescuentosyRetencionesTitulo = .Item("IdCuentaDescuentosyRetencionesTitulo")
'            mvarCuentaRetencionSUSS = iisNull(.Item("IdCuentaRetencionSUSS"), 0)
'            mvarActivarCircuitoChequesDiferidos = iisNull(.Item("ActivarCircuitoChequesDiferidos"), "NO")
'        End With















'        If OP.IdProveedor > 0 Then
'            Dim prov = ProveedorManager.GetItem(SC, OP.IdProveedor)
'            mvarCuentaProveedor = prov.IdCuenta
'            mvarIdImpuestoDirectoSUSS = prov.IdImpuestoDirectoSUSS
'            mvarIdIBCondicionPorDefecto = prov.IdIBCondicionPorDefecto

'            If mvarIdImpuestoDirectoSUSS <> 0 Then
'                oRs = LeerUnoVB6(SC, "ImpuestosDirectos", mvarIdImpuestoDirectoSUSS)
'                If oRs.RecordCount > 0 Then
'                    If Not IsNull(oRs.Fields("IdCuenta").Value) Then
'                        mvarCuentaRetencionSUSS = oRs.Fields("IdCuenta").Value
'                    End If
'                End If
'                oRs.Close()
'            End If
'            If mvarIdIBCondicionPorDefecto <> 0 Then
'                oRs = TraerFiltradoVB6(SC, enumSPs.IBCondiciones_TX_IdCuentaPorProvincia, mvarIdIBCondicionPorDefecto)
'                If oRs.RecordCount > 0 Then
'                    If Not IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value) Then
'                        mvarCuentaRetencionIBrutos = oRs.Fields("IdCuentaRetencionIBrutos").Value
'                    End If
'                End If
'                oRs.Close()
'            End If
'        Else
'            mvarCuentaProveedor = IIf(IsNull(OP.IdCuenta), 0, OP.IdCuenta)
'        End If

'        oRsCont = CreateObject("adodb.Recordset")
'        oRs = TraerFiltradoVB6(SC, enumSPs.Subdiarios_TX_Estructura)

'        With oRs
'            For Each oFld In .Fields
'                With oFld
'                    oRsCont.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'                    oRsCont.Fields.Item(.Name).Precision = .Precision
'                    oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
'                End With
'            Next
'            oRsCont.Open()
'        End With
'        oRs.Close()

'        If Not IsNull(OP.AsientoManual) And OP.AsientoManual = "SI" Then
'            'oRsDetCtas = DetOrdenesPagoCuentas.TodosLosRegistros
'            oRsDetCtas = OP.DetallesCuentas
'            If oRsDetCtas.RecordCount > 0 Then
'                oRsDetCtas.MoveFirst()
'                Do While Not oRsDetCtas.EOF
'                    With oRsCont
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = oRsDetCtas.Fields("IdCuenta").Value
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If Not IsNull(oRsDetCtas.Fields("Debe").Value) Then
'                            .Fields("Debe").Value = oRsDetCtas.Fields("Debe").Value
'                        End If
'                        If Not IsNull(oRsDetCtas.Fields("Haber").Value) Then
'                            .Fields("Haber").Value = oRsDetCtas.Fields("Haber").Value
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda

'                        mvarDetalleValor = ""
'                        oRsDet = OP.DetallesValores
'                        With oRsDet
'                            If .Fields.Count > 0 Then
'                                If .RecordCount > 0 Then
'                                    .MoveFirst()
'                                    Do While Not .EOF
'                                        If Not .Fields("Eliminado").Value Then
'                                            mvarCuentaValores1 = mvarCuentaValores
'                                            mvarProcesar = True

'                                            oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
'                                            mvarDetVal = ""
'                                            If Not IsNothing(oRsBco) Then
'                                                mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
'                                            End If
'                                            oRsBco = Nothing

'                                            If IsNull(.Fields("IdValor").Value) Then
'                                                If Not IsNull(.Fields("IdBanco").Value) Then
'                                                    If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
'                                                        mvarProcesar = False
'                                                    End If
'                                                    If mvarProcesar Then
'                                                        mvarChequeraPagoDiferido = "NO"
'                                                        If Not IsNull(.Fields("IdBancoChequera").Value) Then
'                                                            oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
'                                                            If Not IsNothing(oRsBco) Then
'                                                                If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
'                                                                    mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
'                                                                End If
'                                                            End If

'                                                        End If
'                                                        oRsBco = EntidadManager.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
'                                                        If Not IsNothing(oRsBco) Then
'                                                            If mvarActivarCircuitoChequesDiferidos = "NO" Or _
'                                                                  mvarChequeraPagoDiferido = "NO" Or _
'                                                                  IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
'                                                                If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                                                    mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                                                End If
'                                                            Else
'                                                                mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
'                                                            End If
'                                                        End If

'                                                    End If
'                                                End If
'                                            End If
'                                            If mvarProcesar Then
'                                                If Not IsNull(.Fields("NumeroValor").Value) And oRsDetCtas.Fields("IdCuenta").Value = mvarCuentaValores1 Then
'                                                    mvarDetalleValor = mvarDetalleValor & mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value & " "
'                                                End If
'                                            End If
'                                        End If
'                                        .MoveNext()
'                                    Loop
'                                End If
'                            End If
'                        End With
'                        oRsDet = Nothing

'                        .Fields("Detalle").Value = Mid(mvarDetalleValor, 1, .Fields("Detalle").DefinedSize)
'                        .Update()
'                    End With
'                    oRsDetCtas.MoveNext()
'                Loop
'                oRsDetCtas.MoveFirst()
'            End If
'            oRsDetCtas = Nothing

'        Else




'            If OP.Efectivo <> 0 Then
'                With oRsCont
'                    mvarImporte = OP.Efectivo
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                    .Fields("IdCuenta").Value = mvarCuentaCaja
'                    .Fields("IdTipoComprobante").Value = 17
'                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                    .Fields("IdComprobante").Value = OP.Id
'                    .Fields("Haber").Value = mvarImporte
'                    .Fields("IdMoneda").Value = OP.IdMoneda
'                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    .Update()
'                    mvarDebeHaber = "Debe"
'                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                    If mvarPosicion = 0 Then
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaProveedor
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        .Fields(mvarDebeHaber).Value = mvarImporte
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    Else
'                        .AbsolutePosition = mvarPosicion
'                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
'                    End If
'                    .Update()
'                End With
'            End If



'            If OP.GastosGenerales <> 0 And OP.IdCuenta <> 0 Then
'                With oRsCont
'                    mvarImporte = OP.GastosGenerales
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                    .Fields("IdCuenta").Value = OP.IdCuenta
'                    .Fields("IdTipoComprobante").Value = 17
'                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                    .Fields("IdComprobante").Value = OP.Id
'                    .Fields("Haber").Value = mvarImporte
'                    .Fields("IdMoneda").Value = OP.IdMoneda
'                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    .Update()
'                    mvarDebeHaber = "Debe"
'                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                    If mvarPosicion = 0 Then
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaCaja
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        .Fields(mvarDebeHaber).Value = mvarImporte
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    Else
'                        .AbsolutePosition = mvarPosicion
'                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
'                    End If
'                    .Update()
'                End With

'            End If

'            If OP.Descuentos <> 0 Then
'                With oRsCont
'                    mvarImporte = OP.Descuentos
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                    .Fields("IdCuenta").Value = mvarCuentaDescuentos
'                    .Fields("IdTipoComprobante").Value = 17
'                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                    .Fields("IdComprobante").Value = OP.Id
'                    If mvarImporte > 0 Then
'                        .Fields("Haber").Value = mvarImporte
'                    Else
'                        .Fields("Debe").Value = Math.Abs(mvarImporte)
'                    End If
'                    .Fields("IdMoneda").Value = OP.IdMoneda
'                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    .Update()
'                    If mvarImporte > 0 Then
'                        mvarDebeHaber = "Debe"
'                    Else
'                        mvarDebeHaber = "Haber"
'                    End If
'                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                    If mvarPosicion = 0 Then
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaProveedor
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                    Else
'                        .AbsolutePosition = mvarPosicion
'                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                    End If
'                    .Update()
'                End With

'            End If

'            mvarRetencionIvaComprobantesM = IIf(IsNull(OP.RetencionIVAComprobantesM), 0, OP.RetencionIVAComprobantesM)

'            If Not IsNull(OP.RetencionIVA) Then
'                If OP.RetencionIVA - mvarRetencionIvaComprobantesM <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.RetencionIVA - mvarRetencionIvaComprobantesM
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaRetencionIva
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            If mvarImporte > 0 Then
'                                .Fields("Debe").Value = mvarImporte
'                            Else
'                                .Fields("Haber").Value = Math.Abs(mvarImporte)
'                            End If
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If mvarRetencionIvaComprobantesM <> 0 Then
'                With oRsCont
'                    mvarImporte = mvarRetencionIvaComprobantesM
'                    .AddNew()
'                    .Fields("Ejercicio").Value = mvarEjercicio
'                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                    .Fields("IdCuenta").Value = mvarCuentaRetencionIvaComprobantesM
'                    .Fields("IdTipoComprobante").Value = 17
'                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                    .Fields("IdComprobante").Value = OP.Id
'                    If mvarImporte > 0 Then
'                        .Fields("Haber").Value = mvarImporte
'                    Else
'                        .Fields("Debe").Value = Math.Abs(mvarImporte)
'                    End If
'                    .Fields("IdMoneda").Value = OP.IdMoneda
'                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    .Update()
'                    If mvarImporte > 0 Then
'                        mvarDebeHaber = "Debe"
'                    Else
'                        mvarDebeHaber = "Haber"
'                    End If
'                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                    If mvarPosicion = 0 Then
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaProveedor
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Debe").Value = mvarImporte
'                        Else
'                            .Fields("Haber").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                    Else
'                        .AbsolutePosition = mvarPosicion
'                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                    End If
'                    .Update()
'                End With
'            End If

'            If Not IsNull(OP.RetencionGanancias) Then
'                If OP.RetencionGanancias <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.RetencionGanancias
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaRetencionGanancias
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        If Not IsNull(OP.IdProveedor) Then
'                            mvarDetalle = ""
'                            If Not IsNull(OP.NumeroCertificadoRetencionGanancias) Then
'                                mvarDetalle = mvarDetalle & "Cert.: " & OP.NumeroCertificadoRetencionGanancias
'                            End If
'                            oRsProv = EntidadManager.LeerUnoVB6(SC, "Proveedores", OP.IdProveedor)
'                            If oRsProv.RecordCount > 0 Then
'                                If Not IsNull(oRsProv.Fields("RazonSocial").Value) Then
'                                    mvarDetalle = mvarDetalle & " Prov.: " & Trim(oRsProv.Fields("RazonSocial").Value)
'                                End If
'                                If Not IsNull(oRsProv.Fields("Cuit").Value) Then
'                                    mvarDetalle = mvarDetalle & " Cuit: " & Trim(oRsProv.Fields("Cuit").Value)
'                                End If
'                            End If
'                            .Fields("Detalle").Value = mvarDetalle
'                            oRsProv.Close()
'                            oRsProv = Nothing
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If Not IsNull(OP.RetencionIBrutos) Then
'                If OP.RetencionIBrutos <> 0 Then
'                    With oRsCont


'                        'oRsAux = OrdenPagoManager.TraerRegistrosPorImpuesto(OP, "I.Brutos")
'                        If True Then ' oRsAux.RecordCount > 0 Then
'                            For Each i In OP.DetallesImpuestos
'                                If i.TipoImpuesto = "I.Brutos" Then
'                                    mvarImporte = i.ImpuestoRetenido
'                                    .AddNew()
'                                    .Fields("Ejercicio").Value = mvarEjercicio
'                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                                    .Fields("IdCuenta").Value = mvarCuentaRetencionIBrutos 'i.Idcuenta
'                                    .Fields("IdTipoComprobante").Value = 17
'                                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                                    .Fields("IdComprobante").Value = OP.Id
'                                    If mvarImporte > 0 Then
'                                        .Fields("Haber").Value = mvarImporte
'                                    Else
'                                        .Fields("Debe").Value = Math.Abs(mvarImporte)
'                                    End If
'                                    .Fields("IdMoneda").Value = OP.IdMoneda
'                                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                                    .Update()
'                                End If
'                            Next

'                        Else
'                            mvarImporte = OP.RetencionIBrutos
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaRetencionIBrutos
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            If mvarImporte > 0 Then
'                                .Fields("Haber").Value = mvarImporte
'                            Else
'                                .Fields("Debe").Value = Math.Abs(mvarImporte)
'                            End If
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Update()
'                            oRsAux.Close()
'                        End If

'                        mvarImporte = OP.RetencionIBrutos
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If Not IsNull(OP.Otros1) Then
'                If OP.Otros1 <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.Otros1
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = OP.IdCuenta1
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If Not IsNull(OP.Otros2) Then
'                If OP.Otros2 <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.Otros2
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = OP.IdCuenta2
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If Not IsNull(OP.Otros3) Then
'                If OP.Otros3 <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.Otros3
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = OP.IdCuenta3
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            If Not IsNull(OP.RetencionSUSS) Then
'                If OP.RetencionSUSS <> 0 Then
'                    With oRsCont
'                        mvarImporte = OP.RetencionSUSS
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaRetencionSUSS
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        If mvarImporte > 0 Then
'                            .Fields("Haber").Value = mvarImporte
'                        Else
'                            .Fields("Debe").Value = Math.Abs(mvarImporte)
'                        End If
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                        .Update()
'                        If mvarImporte > 0 Then
'                            mvarDebeHaber = "Debe"
'                        Else
'                            mvarDebeHaber = "Haber"
'                        End If
'                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                        If mvarPosicion = 0 Then
'                            .AddNew()
'                            .Fields("Ejercicio").Value = mvarEjercicio
'                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                            .Fields("IdCuenta").Value = mvarCuentaProveedor
'                            .Fields("IdTipoComprobante").Value = 17
'                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                            .Fields("IdComprobante").Value = OP.Id
'                            .Fields("IdMoneda").Value = OP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
'                        Else
'                            .AbsolutePosition = mvarPosicion
'                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
'                        End If
'                        .Update()
'                    End With
'                End If
'            End If

'            mvarTotalValores = 0


'            'oRsDet = DataTable_To_Recordset(GetDataSetNative(OP.DetallesValores).Tables(0))
'            'oRsDet = DataTable_To_Recordset(ConvertToDataTable(OP.DetallesValores))


'            For Each oRsDetItem In OP.DetallesValores
'                With oRsDetItem





'                    If Not .Eliminado Then
'                        mvarCuentaValores1 = mvarCuentaValores
'                        mvarProcesar = True

'                        oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .IdTipoValor)
'                        mvarDetVal = ""
'                        If Not IsNothing(oRsBco) Then
'                            mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
'                        End If
'                        oRsBco = Nothing

'                        If .IdValor < 1 Then
'                            If .IdBanco > 0 Then
'                                '                           Set oRsBco = EntidadManager.TraerFiltrado("Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
'                                '                           If Not IsNothing(oRsBco) Then
'                                '                              If IIf(IsNull(oRsBco.Item("Anulado")), "NO", oRsBco.Item("Anulado")) = "SI" Then
'                                '                                 mvarProcesar = False
'                                '                              End If
'                                '                           End If
'                                '                           oRsBco.Close
'                                If IIf(IsNull(.Anulado), "NO", .Anulado) = "SI" Then
'                                    mvarProcesar = False
'                                End If
'                                If mvarProcesar Then
'                                    mvarChequeraPagoDiferido = "NO"
'                                    If .IdBancoChequera > 0 Then
'                                        oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .IdBancoChequera)
'                                        If Not IsNothing(oRsBco) Then
'                                            If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
'                                                mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
'                                            End If
'                                        End If
'                                        oRsBco = Nothing
'                                    End If
'                                    oRsBco = EntidadManager.LeerUno(SC, "Bancos", .IdBanco)
'                                    If Not IsNothing(oRsBco) Then
'                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
'                                              IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
'                                            If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                                mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                            End If
'                                        Else
'                                            mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
'                                        End If
'                                    End If
'                                    oRsBco = Nothing
'                                End If
'                            ElseIf .IdTarjetaCredito > 0 Then
'                                oRsBco = EntidadManager.LeerUno(SC, "TarjetasCredito", .IdTarjetaCredito)
'                                If Not IsNothing(oRsBco) Then
'                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                    End If
'                                End If
'                                oRsBco = Nothing
'                            Else
'                                oRsBco = EntidadManager.LeerUno(SC, "Cajas", .IdCaja)
'                                If Not IsNothing(oRsBco) Then
'                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                    End If
'                                End If
'                                oRsBco = Nothing
'                            End If
'                        End If
'                        If mvarProcesar Then
'                            mvarTotalValores = mvarTotalValores + .Importe
'                            mvarDetalleValor = ""
'                            If Not IsNull(.NumeroValor) Then
'                                mvarDetalleValor = mvarDetVal & " " & .NumeroValor & " [" & .NumeroInterno & "] Vto.:" & .FechaVencimiento
'                            End If
'                            With oRsCont
'                                .AddNew()
'                                .Fields("Ejercicio").Value = mvarEjercicio
'                                .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                                .Fields("IdCuenta").Value = mvarCuentaValores1
'                                .Fields("IdTipoComprobante").Value = 17
'                                .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                                .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                                .Fields("Detalle").Value = mvarDetalleValor
'                                .Fields("IdComprobante").Value = OP.Id
'                                .Fields("Haber").Value = oRsDetItem.Importe
'                                .Fields("IdMoneda").Value = OP.IdMoneda
'                                .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                                .Update()
'                            End With
'                        End If
'                    End If

'                End With
'            Next

'            oRsDetBD = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoValores_TX_PorIdCabecera, OP.Id)
'            With oRsDetBD
'                If .RecordCount > 0 Then
'                    .MoveFirst()
'                    Do While Not .EOF
'                        mvarEsta = False

'                        For Each i In OP.DetallesValores
'                            If .Fields(0).Value = i.Id Then
'                                mvarEsta = True
'                                Exit For
'                            End If
'                        Next


'                        If Not mvarEsta Then
'                            mvarCuentaValores1 = mvarCuentaValores
'                            mvarProcesar = True

'                            oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
'                            mvarDetVal = ""
'                            If Not IsNothing(oRsBco) Then
'                                mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
'                            End If
'                            oRsBco = Nothing

'                            If Not IsNull(.Fields("IdBanco").Value) Then
'                                '                     Set oRsBco = EntidadManager.TraerFiltrado("Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
'                                '                     If Not IsNothing(oRsBco) Then
'                                '                        If IIf(IsNull(oRsBco.Item("Anulado")), "NO", oRsBco.Item("Anulado")) = "SI" Then
'                                '                           mvarProcesar = False
'                                '                        End If
'                                '                     End If
'                                '                     oRsBco.Close
'                                If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
'                                    mvarProcesar = False
'                                End If
'                                If mvarProcesar Then
'                                    mvarChequeraPagoDiferido = "NO"
'                                    If Not IsNull(.Fields("IdBancoChequera").Value) Then
'                                        oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
'                                        If Not IsNothing(oRsBco) Then
'                                            If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
'                                                mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
'                                            End If
'                                        End If
'                                        oRsBco = Nothing
'                                    End If
'                                    oRsBco = EntidadManager.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
'                                    If Not IsNothing(oRsBco) Then
'                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
'                                              IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
'                                            If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                                mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                            End If
'                                        Else
'                                            mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
'                                        End If
'                                    End If
'                                    oRsBco = Nothing
'                                End If
'                            Else
'                                oRsBco = EntidadManager.LeerUno(SC, "Cajas", .Fields("IdCaja").Value)
'                                If Not IsNothing(oRsBco) Then
'                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
'                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
'                                    End If
'                                End If
'                                oRsBco = Nothing
'                            End If
'                            If mvarProcesar Then
'                                mvarTotalValores = mvarTotalValores + .Fields("Importe").Value
'                                mvarDetalleValor = ""
'                                If Not IsNull(.Fields("NumeroValor").Value) Then
'                                    mvarDetalleValor = mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value
'                                End If
'                                With oRsCont
'                                    .AddNew()
'                                    .Fields("Ejercicio").Value = mvarEjercicio
'                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                                    .Fields("IdCuenta").Value = mvarCuentaValores1
'                                    .Fields("IdTipoComprobante").Value = 17
'                                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                                    .Fields("Detalle").Value = mvarDetalleValor
'                                    .Fields("IdComprobante").Value = OP.Id
'                                    .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value
'                                    .Fields("IdMoneda").Value = OP.IdMoneda
'                                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                                    .Update()
'                                End With
'                            End If
'                        End If
'                        .MoveNext()
'                    Loop
'                End If
'                .Close()
'            End With
'            oRsDetBD = Nothing

'            'If oRsDet.Fields.Count > 0 Then oRsDet.Close()
'            oRsDet = Nothing

'            If mvarTotalValores <> 0 Then
'                With oRsCont
'                    mvarDebeHaber = "Debe"
'                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
'                    If mvarPosicion = 0 Then
'                        .AddNew()
'                        .Fields("Ejercicio").Value = mvarEjercicio
'                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
'                        .Fields("IdCuenta").Value = mvarCuentaProveedor
'                        .Fields("IdTipoComprobante").Value = 17
'                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
'                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
'                        .Fields("IdComprobante").Value = OP.Id
'                        .Fields(mvarDebeHaber).Value = mvarTotalValores
'                        .Fields("IdMoneda").Value = OP.IdMoneda
'                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
'                    Else
'                        .AbsolutePosition = mvarPosicion
'                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarTotalValores
'                    End If
'                    .Update()
'                End With
'            End If

'        End If

'        With oRsCont
'            If .RecordCount > 0 Then
'                .MoveFirst()
'                Do While Not .EOF
'                    mvarDebe = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value)
'                    mvarHaber = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value)
'                    If mvarDebe < 0 Then
'                        mvarHaber = mvarHaber + Math.Abs(mvarDebe)
'                        mvarDebe = 0
'                        .Fields("Haber").Value = mvarHaber
'                        .Fields("Debe").Value = DBNull.Value
'                        .Update()
'                    End If
'                    If mvarHaber < 0 Then
'                        mvarDebe = mvarDebe + Math.Abs(mvarHaber)
'                        mvarHaber = 0
'                        .Fields("Debe").Value = mvarDebe
'                        .Fields("Haber").Value = DBNull.Value
'                        .Update()
'                    End If
'                    .MoveNext()
'                Loop
'                .MoveFirst()
'            End If
'        End With

'        _RegistroContableOriginalVB6conADORrecordsets = oRsCont

'        oRs = Nothing
'        oRsAux = Nothing
'        oRsCont = Nothing
'        oRsBco = Nothing

'    End Function



'    Public Function EmisionCertificadoRetencionIIBB(ByVal mIdOrdenPago As String, _
'                                                    ByVal mDestino As String, _
'                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

'        Dim oW As Word.Application
'        Dim cALetra 'As New clsNum2Let
'        Dim oRs As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim mNumeroCertificado As Long, mIdProveedor As Long
'        Dim mCopias As Integer
'        Dim mFecha As Date
'        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String, mProvincia As String
'        Dim mPrinterAnt As String, mIBNumeroInscripcion As String, mAux1 As String, mPlantilla As String, mPlantilla1 As String
'        Dim mCodPos As String, mImporteLetras As String, mAnulada As String
'        Dim mRetenido As Double, mRetencionAdicional As Double, mCotMon As Double



'        mCopias = 1
'        mAux1 = ClaseMigrar.BuscarClaveINI("Copias retenciones en op", SC, Session("glbIdUsuario"))
'        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

'        Try

'            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
'            With oRs
'                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
'                mIdProveedor = .Fields("IdProveedor").Value
'                mCotMon = .Fields("CotizacionMoneda").Value
'                mFecha = .Fields("FechaOrdenPago").Value
'                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
'                .Close()
'            End With
'        Catch ex As Exception

'        End Try

'        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
'        If oRs.RecordCount > 0 Then
'            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
'            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
'            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
'            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
'                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
'            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
'            mIBNumeroInscripcion = IIf(IsNull(oRs.Fields("IBNumeroInscripcion").Value), "", oRs.Fields("IBNumeroInscripcion").Value)
'            mCodPos = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
'            '      If Not IsNull(oRs.Fields("PlantillaRetencionIIBB").Value) Then
'            '         If Len(RTrim(oRs.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
'            '            mPlantilla = oRs.Fields("PlantillaRetencionIIBB").Value
'            '         End If
'            '      End If
'        End If
'        oRs.Close()
'        oRs = Nothing

'        oW = CreateObject("Word.Application")

'        oRs = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoImpuestos_TXOrdenPago, mIdOrdenPago)
'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                Do While Not oRs.EOF
'                    If iisNull(oRs.Fields("Tipo").Value) = "I.Brutos" And _
'                          Not IsNull(oRs.Fields("Certif_IIBB").Value) Then

'                        mNumeroCertificado = oRs.Fields("Certif_IIBB").Value
'                        mRetenido = oRs.Fields("Retencion").Value * mCotMon
'                        mRetencionAdicional = IIf(IsNull(oRs.Fields("Impuesto adic_").Value), 0, oRs.Fields("Impuesto adic_").Value) * mCotMon

'                        mPlantilla = "CertificadoRetencionIIBB.dot"
'                        oRsAux = TraerFiltradoVB6(SC, enumSPs.IBCondiciones_TX_IdCuentaPorProvincia, oRs.Fields("IdTipoImpuesto").Value)
'                        If oRsAux.RecordCount > 0 Then
'                            If Not IsNull(oRsAux.Fields("PlantillaRetencionIIBB").Value) Then
'                                If Len(RTrim(oRsAux.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
'                                    mPlantilla = oRsAux.Fields("PlantillaRetencionIIBB").Value
'                                End If
'                            End If
'                        End If
'                        oRsAux.Close()

'                        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionIIBB.dot" '_" & Session("glbEmpresaSegunString") & ".dot"


'                        'mPlantilla1 = Mid(mPlantilla, 1, Len(mPlantilla) - 4)
'                        'mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & "_" & glbEmpresaSegunString & ".dot"
'                        'If Len(Dir(mPlantilla)) = 0 Then
'                        '    mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & ".dot"
'                        '    If Len(Dir(mPlantilla)) = 0 Then
'                        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
'                        '        Exit Sub
'                        '    End If
'                        'End If



'                        With oW
'                            .Visible = False
'                            With .Documents.Add(mPlantilla)

'                                If InStr(1, mPlantilla, "Salta") = 0 Then
'                                    oW.DisplayAlerts = False
'                                    oW.ActiveDocument.FormFields("NumeroCertificado").Result = FormatVB6(mNumeroCertificado, "00000000")
'                                    oW.ActiveDocument.FormFields("Fecha").Result = mFecha
'                                    oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
'                                    oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
'                                    oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
'                                    oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
'                                    oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
'                                    oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'                                    oW.ActiveDocument.FormFields("NumeroInscripcion").Result = mIBNumeroInscripcion
'                                    oW.ActiveDocument.FormFields("Anulada").Result = mAnulada

'                                    oW.Selection.GoTo(What:=wdGoToBookmark, Name:="DetalleComprobantes")
'                                    oW.Selection.MoveDown(Unit:=wdLine)
'                                    oW.Selection.MoveLeft(Unit:=wdCell)
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & oRs.Fields("Categoria").Value)
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00"))
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Pagos mes").Value, "#,##0.00"))
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Ret_ mes").Value, "#,##0.00"))
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & oRs.Fields("% a tomar s/base").Value)
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & oRs.Fields("Alicuota_IIBB").Value)
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido - mRetencionAdicional, "#,##0.00"))
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & oRs.Fields("% adic_").Value)
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetencionAdicional, "#,##0.00"))
'                                    oW.Selection.MoveRight(Unit:=wdCell)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

'                                    oW.Selection.GoTo(What:=wdGoToBookmark, Name:="TotalRetencion")
'                                    oW.Selection.MoveRight(Unit:=wdCell, Count:=2)
'                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

'                                ElseIf InStr(1, mPlantilla, "Salta") > 0 Then
'                                    oW.DisplayAlerts = False
'                                    cALetra.Numero = mRetenido
'                                    mImporteLetras = cALetra.ALetra
'                                    oW.ActiveDocument.FormFields("NombreSujeto1").Result = mNombreSujeto
'                                    oW.ActiveDocument.FormFields("CuitSujeto1").Result = mCuitSujeto
'                                    oW.ActiveDocument.FormFields("DomicilioSujeto1").Result = mDomicilioSujeto
'                                    oW.ActiveDocument.FormFields("CodigoPostal1").Result = mCodPos
'                                    oW.ActiveDocument.FormFields("Monto1").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
'                                    oW.ActiveDocument.FormFields("Alicuota1").Result = oRs.Fields("Alicuota_IIBB").Value
'                                    oW.ActiveDocument.FormFields("Retencion1").Result = mRetenido
'                                    oW.ActiveDocument.FormFields("ImporteEnLetras1").Result = mImporteLetras
'                                    oW.ActiveDocument.FormFields("Fecha1").Result = mFecha

'                                    oW.ActiveDocument.FormFields("NombreSujeto2").Result = mNombreSujeto
'                                    oW.ActiveDocument.FormFields("CuitSujeto2").Result = mCuitSujeto
'                                    oW.ActiveDocument.FormFields("DomicilioSujeto2").Result = mDomicilioSujeto
'                                    oW.ActiveDocument.FormFields("CodigoPostal2").Result = mCodPos
'                                    oW.ActiveDocument.FormFields("Monto2").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
'                                    oW.ActiveDocument.FormFields("Alicuota2").Result = oRs.Fields("Alicuota_IIBB").Value
'                                    oW.ActiveDocument.FormFields("Retencion2").Result = mRetenido
'                                    oW.ActiveDocument.FormFields("ImporteEnLetras2").Result = mImporteLetras
'                                    oW.ActiveDocument.FormFields("Fecha2").Result = mFecha

'                                    oW.ActiveDocument.FormFields("NombreSujeto3").Result = mNombreSujeto
'                                    oW.ActiveDocument.FormFields("CuitSujeto3").Result = mCuitSujeto
'                                    oW.ActiveDocument.FormFields("DomicilioSujeto3").Result = mDomicilioSujeto
'                                    oW.ActiveDocument.FormFields("CodigoPostal3").Result = mCodPos
'                                    oW.ActiveDocument.FormFields("Monto3").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
'                                    oW.ActiveDocument.FormFields("Alicuota3").Result = oRs.Fields("Alicuota_IIBB").Value
'                                    oW.ActiveDocument.FormFields("Retencion3").Result = mRetenido
'                                    oW.ActiveDocument.FormFields("ImporteEnLetras3").Result = mImporteLetras
'                                    oW.ActiveDocument.FormFields("Fecha3").Result = mFecha

'                                End If

'                            End With
'                        End With

'                        'If mDestino = "Printer" Then
'                        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
'                        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
'                        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
'                        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
'                        '    oW.Documents(1).Close(False)
'                        'End If



'                        Exit Do



'                    End If
'                    oRs.MoveNext()
'                Loop
'            End If
'        End If
'        oRs.Close()

'        ' oW.Selection.HomeKey(wdStory)


'        Dim output As String = System.IO.Path.GetTempPath & "CertificadoIIBB.doc"

'        Try
'            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
'        Catch ex As Exception
'            ErrHandler2.WriteError("Explotó el .SaveAs()  ") ' & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.Message)
'            'MsgBoxAjax(Me, "No se generó el certificado")

'        End Try


'        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
'        'If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
'        'NAR(oW.ActiveDocument)
'        oW.Quit()
'        NAR(oW)
'        GC.Collect()

'        Return output


'    End Function


'    Public Function GuardarRegistroContable(ByVal RegistroContable As ADODB.Recordset)

'        Dim oCont ' As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim oRsComprobante As ADODB.Recordset
'        Dim Datos As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim i As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
'        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        If oCont Is Nothing Then
'            oDet = CreateObject("MTSPronto.General")
'        Else
'            oDet = oCont.CreateInstance("MTSPronto.General")
'        End If

'        mvarCotizacionMoneda = 0
'        mvarDebe = 0
'        mvarHaber = 0

'        'With RegistroContable
'        '    If .State <> adStateClosed Then
'        '        If .RecordCount > 0 Then
'        '            .Update()
'        '            .MoveFirst()
'        '            oRsComprobante = oDet.LeerUno("OrdenPagos", RegistroContable.Fields("IdComprobante").Value)
'        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
'        '            oRsComprobante.Close()
'        '            oRsComprobante = Nothing
'        '        End If
'        '        Do While Not .EOF
'        '            If Not IsNull(.Fields("Debe").Value) Then
'        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarDebe = mvarDebe + .Fields("Debe").Value
'        '            End If
'        '            If Not IsNull(.Fields("Haber").Value) Then
'        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'        '                .Update()
'        '                mvarHaber = mvarHaber + .Fields("Haber").Value
'        '            End If
'        '            .MoveNext()
'        '        Loop
'        '        If .RecordCount > 0 Then
'        '            .MoveFirst()
'        '            If mvarDebe - mvarHaber <> 0 Then
'        '                If Not IsNull(.Fields("Debe").Value) Then
'        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
'        '                Else
'        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
'        '                End If
'        '            End If
'        '        End If
'        '        Do While Not .EOF
'        '            Datos = CreateObject("adodb.Recordset")
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'        '                    Datos.Fields(.Name).Precision = .Precision
'        '                    Datos.Fields(.Name).NumericScale = .NumericScale
'        '                End With
'        '            Next
'        '            Datos.Open()
'        '            Datos.AddNew()
'        '            For i = 0 To .Fields.Count - 1
'        '                With .Fields(i)
'        '                    Datos.Fields(i).Value = .Value
'        '                End With
'        '            Next
'        '            Datos.Update()
'        '            Resp = oDet.Guardar("Subdiarios", Datos)
'        '            Datos.Close()
'        '            Datos = Nothing
'        '            .MoveNext()
'        '        Loop
'        '    End If
'        'End With

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        GuardarRegistroContable = Resp
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        Resume Salir

'    End Function

'    Sub RefrescarDesnormalizados(ByVal sc As String, ByRef myOP As OrdenPago)
'        'en parte, esto de RefrescarDesnormalizados es lo de RegistrosConFormato


'        With myOP

'            For Each i In .DetallesImpuestos
'                With i

'                    If .IdTipoRetencionGanancia > 0 Then
'                        .Categoria = GetStoreProcedureTop1(sc, enumSPs.TiposRetencionGanancia_T, .IdTipoRetencionGanancia).Item("Descripcion")
'                    ElseIf .IdIBCondicion > 0 Then
'                        .Categoria = GetStoreProcedureTop1(sc, enumSPs.IBCondiciones_T, .IdIBCondicion).Item("Descripcion")
'                    Else

'                    End If

'                End With
'            Next

'            If Not IsNothing(.DetallesImputaciones) Then
'                For Each i In .DetallesImputaciones
'                    If i.IdImputacion > 0 Then
'                        Try
'                            Dim dr As DataRow = CtaCteAcreedorManager.TraerMetadata(sc, i.IdImputacion).Rows(0)
'                            i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
'                            i.TipoComprobanteImputado = GetStoreProcedureTop1(sc, enumSPs.TiposComprobante_T, dr.Item("IdTipoComp")).Item("DescripcionAb")
'                            i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(sc, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
'                            If dr.Item("IdTipoComp") = 11 Then
'                                Dim a = GetStoreProcedureTop1(sc, enumSPs.ComprobantesProveedores_T, dr.Item("IdComprobante"))
'                                i.ComprobanteImputadoNumeroConDescripcionCompleta = i.TipoComprobanteImputado & " " & a.Item("Letra") & " " & a.Item("NumeroComprobante1") & "-" & a.Item("NumeroComprobante2")
'                            End If

'                        Catch ex As Exception

'                        End Try
'                    Else
'                        i.TipoComprobanteImputado = "PA" 'pagoanticipado
'                    End If


'                    If i.ComprobanteImputadoNumeroConDescripcionCompleta = "" Or i.ComprobanteImputadoNumeroConDescripcionCompleta = "0" Then
'                        i.ComprobanteImputadoNumeroConDescripcionCompleta = i.TipoComprobanteImputado & " " & i.NumeroComprobanteImputado
'                    End If



'                    With i


'                        Dim mIdMoneda = myOP.IdMoneda
'                        Dim oRsAux As ADODB.Recordset
'                        Dim mImportePagadoSinImpuestos As Double, mTotalBruto As Double
'                        Dim MonedaGeneraImpuesto As String
'                        Dim mIdOrdenPago As Long, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer, mIdMonedaEuro As Integer
'                        Dim mIvaCredito As Double

'                        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(sc)
'                        With p
'                            mIdMonedaPesos = iisNull(.Item("IdMoneda"), 1)
'                            mIdMonedaDolar = iisNull(.Item("IdMonedaDolar"), 2)
'                            mIdMonedaEuro = iisNull(.Item("IdMonedaEuro"), 2)
'                        End With
'                        oRsAux = TraerFiltradoVB6(sc, enumSPs.Monedas_T, mIdMoneda)
'                        If IsNull(oRsAux.Fields("GeneraImpuestos").Value) Or _
'                              oRsAux.Fields("GeneraImpuestos").Value = "NO" Then
'                            MonedaGeneraImpuesto = "NO"
'                        Else
'                            MonedaGeneraImpuesto = "SI"
'                        End If



'                        If .IdImputacion <> 0 Then
'                            If .IdImputacion = -1 Then
'                                .TipoComprobanteImputado = "PA"
'                                .Saldo = .Importe
'                                If .IdIBCondicion > 0 Then
'                                    oRsAux = TraerFiltrado(sc, enumSPs.IBCondiciones_TX_PorId, .IdIBCondicion)
'                                    If oRsAux.RecordCount > 0 Then
'                                        .BaseCalculoIIBB = oRsAux.Fields("BaseCalculo").Value
'                                    End If
'                                    oRsAux.Close()
'                                End If
'                            ElseIf .IdImputacion = -2 Then
'                                .TipoComprobanteImputado = "CO"
'                                .Saldo = .Importe
'                            Else

'                                Dim oRsCtaCte = TraerFiltradoVB6(sc, enumSPs.CtasCtesA_T, .IdImputacion)
'                                If Not IsNull(oRsCtaCte.Fields("IdTipoComp").Value) Then
'                                    Dim oRsComp = TraerFiltradoVB6(sc, enumSPs.TiposComprobante_T, oRsCtaCte.Fields("IdTipoComp").Value)
'                                    Dim oRsComp1 = TraerFiltradoVB6(sc, enumSPs.ComprobantesProveedores_TX_PorIdConDatos, oRsCtaCte.Fields("IdComprobante").Value)
'                                    .TipoComprobanteImputado = oRsComp.Fields("DescripcionAb").Value
'                                    .FechaComprobanteImputado = oRsCtaCte.Fields("Fecha").Value
'                                    If mIdMoneda = mIdMonedaPesos Then
'                                        .Imp = oRsCtaCte.Fields("ImporteTotal").Value * oRsComp.Fields("Coeficiente").Value
'                                        .Saldo = oRsCtaCte.Fields("Saldo").Value * oRsComp.Fields("Coeficiente").Value
'                                    ElseIf mIdMoneda = mIdMonedaDolar Then
'                                        .Imp = oRsCtaCte.Fields("ImporteTotalDolar").Value * oRsComp.Fields("Coeficiente").Value
'                                        .Saldo = oRsCtaCte.Fields("SaldoDolar").Value * oRsComp.Fields("Coeficiente").Value
'                                    ElseIf mIdMoneda = mIdMonedaEuro Then
'                                        .Imp = oRsCtaCte.Fields("ImporteTotalEuro").Value * oRsComp.Fields("Coeficiente").Value
'                                        .Saldo = oRsCtaCte.Fields("SaldoEuro").Value * oRsComp.Fields("Coeficiente").Value
'                                    Else
'                                        If oRsComp1.RecordCount > 0 Then
'                                            .Imp = Math.Round(oRsCtaCte.Fields("ImporteTotal").Value * _
'                                                            oRsComp.Fields("Coeficiente").Value / _
'                                                            IIf(IsNull(oRsComp1.Fields("CotizacionMoneda").Value), 1, oRsComp1.Fields("CotizacionMoneda").Value), 2)
'                                            .Saldo = Math.Round(oRsCtaCte.Fields("Saldo").Value * _
'                                                            oRsComp.Fields("Coeficiente").Value / _
'                                                            IIf(IsNull(oRsComp1.Fields("CotizacionMoneda").Value), 1, oRsComp1.Fields("CotizacionMoneda").Value), 2)
'                                        End If
'                                    End If
'                                    If Not IsNull(oRsComp.Fields("Agrupacion1").Value) And oRsComp.Fields("Agrupacion1").Value = "PROVEEDORES" Then
'                                        If oRsComp1.RecordCount > 0 Then
'                                            mTotalBruto = IIf(IsNull(oRsComp1.Fields("TotalBruto").Value), 0, oRsComp1.Fields("TotalBruto").Value) - _
'                                                           IIf(IsNull(oRsComp1.Fields("RestarAlBruto").Value), 0, oRsComp1.Fields("RestarAlBruto").Value)
'                                            .Numero = oRsComp1.Fields("Letra").Value & "-" & _
'                                                     FormatVB6(oRsComp1.Fields("NumeroComprobante1").Value, "0000") & "-" & _
'                                                     FormatVB6(oRsComp1.Fields("NumeroComprobante2").Value, "00000000")

'                                            .IdTipoRetencionGanancia = iisNull(oRsComp1.Fields("IdTipoRetencionGanancia").Value, -1)
'                                            .IdIBCondicion = oRsComp1.Fields("IdIBCondicion").Value
'                                            .PorcentajeIVAParaMonotributistas = iisNull(oRsComp1.Fields("PorcentajeIVAParaMonotributistas").Value, 0)
'                                            If mTotalBruto = 0 Then
'                                                ._ImportePagadoSinImpuestos = 0
'                                                .GravadoIVA = 0
'                                            End If
'                                            If MonedaGeneraImpuesto = "SI" And oRsCtaCte.Fields("ImporteTotal").Value <> 0 And mTotalBruto <> 0 Then
'                                                mImportePagadoSinImpuestos = (.Importe * _
'                                                      (IIf(IsNull(oRsComp1.Fields("GravadoIVA").Value), 0, oRsComp1.Fields("GravadoIVA").Value) * _
'                                                      oRsComp1.Fields("CotizacionMoneda").Value) / oRsCtaCte.Fields("ImporteTotal").Value)
'                                                .GravadoIVA = mImportePagadoSinImpuestos
'                                                mImportePagadoSinImpuestos = (.Importe * _
'                                                               (mTotalBruto * oRsComp1.Fields("CotizacionMoneda").Value) / _
'                                                               oRsCtaCte.Fields("ImporteTotal").Value)
'                                                .ImportePagadoSinImpuestos = mImportePagadoSinImpuestos
'                                                If oRsComp.Fields("Coeficiente").Value = 1 Then
'                                                    mIvaCredito = IIf(IsNull(oRsComp1.Fields("IvaCreditos").Value), 0, oRsComp1.Fields("IvaCreditos").Value)
'                                                    If (oRsComp1.Fields("TotalIva1").Value * oRsComp1.Fields("CotizacionMoneda").Value) - mIvaCredito > 0 Then
'                                                        .IVA = (oRsComp1.Fields("TotalIva1").Value * oRsComp1.Fields("CotizacionMoneda").Value) - mIvaCredito
'                                                    Else
'                                                        .IVA = 0
'                                                    End If
'                                                    .TotalComprobanteImputado = oRsComp1.Fields("TotalComprobante").Value * oRsComp1.Fields("CotizacionMoneda").Value
'                                                End If
'                                                If Not IsNull(oRsComp1.Fields("BienesOServicios").Value) Then
'                                                    .Bien_o_Servicio = oRsComp1.Fields("BienesOServicios").Value
'                                                Else
'                                                    oRsAux = TraerFiltradoVB6(sc, enumSPs.Proveedores_T, oRsCtaCte.Fields("IdProveedor").Value)
'                                                    If oRsAux.RecordCount > 0 Then
'                                                        If Not IsNull(oRsAux.Fields("BienesOServicios").Value) Then
'                                                            .Bien_o_Servicio = oRsAux.Fields("BienesOServicios").Value
'                                                        End If
'                                                    End If
'                                                    oRsAux.Close()
'                                                End If
'                                                If Not IsNull(oRsComp1.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value) Then
'                                                    oRsAux = TraerFiltradoVB6(sc, enumSPs.OrdenesPago_TX_PorIdDetalleOrdenPago, oRsComp1.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value)
'                                                    If oRsAux.RecordCount > 0 Then
'                                                        .RetIVAenOP = oRsAux.Fields("NumeroOrdenPago").Value
'                                                    End If
'                                                    oRsAux.Close()
'                                                End If
'                                            End If
'                                            If Not IsNull(oRsComp1.Fields("IdIBCondicion").Value) Then
'                                                oRsAux = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, oRsComp1.Fields("IdIBCondicion").Value)
'                                                If oRsAux.RecordCount > 0 Then
'                                                    .BaseCalculoIIBB = oRsAux.Fields("BaseCalculo").Value
'                                                End If
'                                                oRsAux.Close()
'                                            End If
'                                        End If
'                                    Else
'                                        .ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & "-" & _
'                                                                FormatVB6(oRsCtaCte.Fields("NumeroComprobante").Value, "00000000")
'                                    End If
'                                    oRsComp1.Close()
'                                    oRsComp1 = Nothing
'                                    oRsComp.Close()
'                                    oRsComp = Nothing
'                                End If




'                                '        oRsCtaCte.Close()
'                                '        oRsCtaCte = Nothing
'                                '        oRsAux = Nothing
'                                '        oRsAux1 = Nothing
'                            End If
'                            '    oRsFmt.Fields("Importe").Value = oC.Registro.Fields("Importe").Value
'                        End If



'                    End With


'                Next
'            End If

'            If Not IsNothing(.DetallesCuentas) Then
'                For Each i In .DetallesCuentas
'                    i.DescripcionCuenta = EntidadManager.NombreCuenta(sc, i.IdCuenta)
'                Next
'            End If

'            If Not IsNothing(.DetallesValores) Then
'                For Each i In .DetallesValores
'                    i.Tipo = EntidadManager.NombreValorTipo(sc, i.IdTipoValor)
'                Next
'            End If

'            If Not IsNothing(.DetallesRubrosContables) Then
'                For Each i In .DetallesRubrosContables
'                    i.DescripcionRubroContable = EntidadManager.NombreRubroContable(sc, i.IdRubroContable)
'                Next
'            End If

'        End With
'    End Sub

'    Public Function EmisionCertificadoRetencionIVA(ByVal mIdOrdenPago As String, _
'                                                    ByVal mDestino As String, _
'                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

'        Dim oW As Word.Application
'        Dim oRs As ADODB.Recordset
'        Dim oRsDet As ADODB.Recordset
'        Dim mNumeroCertificado As Long, mIdProveedor As Long
'        Dim mCopias As Integer
'        Dim mFecha As Date
'        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String
'        Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
'        Dim mRetenido As Double, mCotMon As Double



'        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionIVA.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

'        'mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA_" & glbEmpresaSegunString & ".dot"
'        'If Len(Dir(mPlantilla)) = 0 Then
'        '    mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA.dot"
'        '    If Len(Dir(mPlantilla)) = 0 Then
'        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
'        '        Exit Sub
'        '    End If
'        'End If

'        mCopias = 1
'        mAux1 = ClaseMigrar.BuscarClaveINI("Copias retenciones en op", SC, Session("glbIdUsuario"))
'        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

'        Try
'            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
'            With oRs
'                mNumeroCertificado = iisNull(.Fields("NumeroCertificadoRetencionIVA").Value, 0)
'                mComprobante = iisNull(FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000"), 0)
'                mIdProveedor = iisNull(.Fields("IdProveedor").Value, 0)
'                mCotMon = iisNull(.Fields("CotizacionMoneda").Value, 0)
'                mFecha = .Fields("FechaOrdenPago").Value
'                mRetenido = .Fields("RetencionIVA").Value * mCotMon
'                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
'                .Close()
'            End With
'        Catch ex As Exception

'        End Try

'        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
'        If oRs.RecordCount > 0 Then
'            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
'            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
'            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
'            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
'                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
'            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
'        End If
'        oRs.Close()
'        oRs = Nothing

'        oW = CreateObject("Word.Application")

'        With oW
'            .Visible = False
'            With .Documents.Add(mPlantilla)
'                oW.DisplayAlerts = False
'                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
'                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
'                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
'                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
'                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
'                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
'                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
'                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'                '         oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
'                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
'            End With
'        End With

'        oRsDet = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPago_TXOrdenPago, mIdOrdenPago)
'        oW.Selection.GoTo(What:=wdGoToBookmark, Name:="DetalleComprobantes")
'        oW.Selection.MoveDown(Unit:=wdLine)
'        oW.Selection.MoveLeft(Unit:=wdCell)
'        With oRsDet
'            If .RecordCount > 0 Then
'                .MoveFirst()
'                Do While Not .EOF
'                    If Not IsNull(.Fields("Ret_Iva").Value) And .Fields("Ret_Iva").Value <> 0 Then
'                        oW.Selection.MoveRight(Unit:=wdCell)
'                        oW.Selection.TypeText(Text:="" & .Fields("Comp_").Value & " " & _
'                              .Fields("Numero").Value)
'                        oW.Selection.MoveRight(Unit:=wdCell)
'                        oW.Selection.TypeText(Text:="" & .Fields("Fecha").Value)
'                        oW.Selection.MoveRight(Unit:=wdCell)
'                        oW.Selection.TypeText(Text:="" & Math.Round(.Fields("Tot_Comp_").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2))
'                        oW.Selection.MoveRight(Unit:=wdCell)
'                        oW.Selection.TypeText(Text:="" & Math.Round(.Fields("IVA").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2))
'                        oW.Selection.MoveRight(Unit:=wdCell)
'                        oW.Selection.TypeText(Text:="" & .Fields("Ret_Iva").Value * mCotMon)
'                    End If
'                    .MoveNext()
'                Loop
'            End If
'            .Close()
'        End With
'        oRsDet = Nothing

'        oW.Selection.GoTo(What:=wdGoToBookmark, Name:="TotalRetencion")
'        oW.Selection.MoveRight(Unit:=wdCell, Count:=2)
'        oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

'        'If mDestino = "Printer" Then
'        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
'        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
'        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
'        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
'        '    oW.Documents(1).Close(False)
'        'End If

'        oW.Selection.HomeKey(wdStory)

'Mal:

'        Dim output As String = System.IO.Path.GetTempPath & "CertificadoIVA.doc"

'        Try
'            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
'        Catch ex As Exception
'            ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.Message)
'            Throw
'        End Try


'        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
'        If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
'        'NAR(oDoc)
'        oW.Quit()
'        NAR(oW)
'        GC.Collect()


'        Return output 'porque no estoy pudiendo ejecutar el response desde acá

'    End Function

'    Public Function EmisionCertificadoRetencionSUSS(ByVal mIdOrdenPago As String, _
'                                                    ByVal mDestino As String, _
'                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

'        Dim oW As Word.Application
'        Dim oRs As ADODB.Recordset
'        Dim oRsDet As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim mNumeroCertificado As Long, mIdProveedor As Long
'        Dim mCopias As Integer
'        Dim mFecha As Date
'        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String
'        Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
'        Dim mRetenido As Double, mCotMon As Double, mvarPorcentajeRetencionSUSS As Double
'        Dim mvarBaseCalculoSUSS As Double



'        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionSUSS.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

'        'mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS_" & glbEmpresaSegunString & ".dot"
'        'If Len(Dir(mPlantilla)) = 0 Then
'        '    mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS.dot"
'        '    If Len(Dir(mPlantilla)) = 0 Then
'        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
'        '        Exit Sub
'        '    End If
'        'End If

'        mCopias = 1
'        mAux1 = ClaseMigrar.BuscarClaveINI("Copias retenciones en op", SC, Session("glbIdUsuario"))
'        If IsNumeric(mAux1) Then mCopias = Val(mAux1)


'        mvarPorcentajeRetencionSUSS = iisNull(ParametroOriginal(SC, ePmOrg.PorcentajeRetencionSUSS), 0)

'        Try
'            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
'            With oRs
'                mNumeroCertificado = iisNull(.Fields("NumeroCertificadoRetencionSUSS").Value, 0)
'                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
'                mIdProveedor = iisNull(.Fields("IdProveedor").Value, 0)
'                mCotMon = iisNull(.Fields("CotizacionMoneda").Value, 0)
'                mFecha = iisNull(.Fields("FechaOrdenPago").Value)
'                mRetenido = .Fields("RetencionSUSS").Value * mCotMon
'                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
'                .Close()
'            End With

'        Catch ex As Exception

'        End Try

'        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
'        If oRs.RecordCount > 0 Then
'            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
'            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
'            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
'            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
'                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
'            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
'            If Not IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value) Then
'                oRsAux = TraerFiltradoVB6(SC, enumSPs.ImpuestosDirectos_TX_PorId, oRs.Fields("IdImpuestoDirectoSUSS").Value)
'                If oRsAux.RecordCount > 0 Then
'                    mvarPorcentajeRetencionSUSS = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
'                End If
'                oRsAux.Close()
'            End If
'        End If
'        oRs.Close()

'        oRsDet = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPago_TXOrdenPago, mIdOrdenPago)
'        mvarBaseCalculoSUSS = 0
'        With oRsDet
'            If .RecordCount > 0 Then
'                .MoveFirst()
'                Do While Not .EOF
'                    If Not IsNull(.Fields("s/impuesto").Value) And .Fields("Gravado IVA").Value <> 0 Then
'                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Gravado IVA").Value
'                    Else
'                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Importe").Value
'                    End If
'                    .MoveNext()
'                Loop
'            End If
'            .Close()
'        End With

'        oW = CreateObject("Word.Application")

'        With oW
'            .Visible = False
'            With .Documents.Add(mPlantilla)
'                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
'                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
'                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
'                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
'                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
'                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
'                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
'                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'                oW.ActiveDocument.FormFields("Comprobante").Result = "OP " & mComprobante
'                oW.ActiveDocument.FormFields("Porcentaje").Result = mvarPorcentajeRetencionSUSS
'                oW.ActiveDocument.FormFields("BaseCalculoSUSS").Result = FormatVB6(mvarBaseCalculoSUSS, "#,##0.00")
'                oW.ActiveDocument.FormFields("Retenido").Result = FormatVB6(mRetenido, "#,##0.00")
'                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
'            End With
'        End With

'        oW.Selection.HomeKey(wdStory)

'        'If mDestino = "Printer" Then
'        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
'        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
'        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
'        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
'        '    oW.Documents(1).Close(False)
'        'End If


'        Dim output As String = System.IO.Path.GetTempPath & "CertificadoSUSS.doc"

'        Try
'            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
'        Catch ex As Exception
'            ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.Message)
'            Throw
'        End Try


'        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
'        If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
'        'NAR(oDoc)
'        oW.Quit()
'        NAR(oW)
'        GC.Collect()


'        Return output

'Mal:

'        If mDestino = "Printer" Then oW.Quit()
'        oW = Nothing
'        oRs = Nothing
'        oRsDet = Nothing
'        oRsAux = Nothing

'    End Function

'    Public Function EmisionCertificadoRetencionGanancias(ByVal mIdOrdenPago As String, _
'                                                            ByVal mDestino As String, _
'                                                            ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

'        Dim oW As Word.Application
'        Dim oRs As ADODB.Recordset
'        Dim mNumeroCertificado As Long, mIdProveedor As Long
'        Dim mCopias As Integer
'        Dim mFecha As Date
'        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String
'        Dim mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String, mPlantilla As String
'        Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double



'        'mPlantilla = session("glbPathPlantillas") & "\CertificadoRetencionGanancias_" & session("glbEmpresaSegunString") & ".dot"
'        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionGanancias.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

'        mCopias = 1
'        mAux1 = ClaseMigrar.BuscarClaveINI("Copias retenciones en op", SC, Session("glbIdUsuario"))
'        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

'        Try
'            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
'            With oRs
'                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
'                mIdProveedor = .Fields("IdProveedor").Value
'                mCotMon = .Fields("CotizacionMoneda").Value
'                mFecha = .Fields("FechaOrdenPago").Value
'                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
'                .Close()
'            End With

'        Catch ex As Exception

'        End Try

'        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
'        If oRs.RecordCount > 0 Then
'            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
'            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
'            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
'            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
'                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
'            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
'        End If
'        oRs.Close()
'        oRs = Nothing

'        oW = CreateObject("Word.Application")



'        oRs = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoImpuestos_TXOrdenPago, mIdOrdenPago)
'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                Do While Not oRs.EOF
'                    If iisNull(oRs.Fields("Tipo").Value) = "Ganancias" And _
'                          Not IsNull(oRs.Fields("Certif_Gan_").Value) Then

'                        mNumeroCertificado = oRs.Fields("Certif_Gan_").Value
'                        mMontoOrigen = oRs.Fields("Pago s/imp_").Value * mCotMon
'                        mRetenido = oRs.Fields("Retencion").Value * mCotMon

'                        With oW
'                            .Visible = False

'                            With .Documents.Add(mPlantilla)
'                                oW.DisplayAlerts = False
'                                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
'                                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
'                                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
'                                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
'                                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
'                                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
'                                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
'                                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
'                                oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
'                                oW.ActiveDocument.FormFields("Regimen").Result = iisNull(oRs.Fields("Categoria").Value)
'                                oW.ActiveDocument.FormFields("MontoOrigen").Result = FormatVB6(mMontoOrigen, "$ #,##0.00")
'                                oW.ActiveDocument.FormFields("Retencion").Result = FormatVB6(mRetenido, "$ #,##0.00")
'                                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
'                                mAux1 = ClaseMigrar.BuscarClaveINI("Aclaracion para certificado de retencion de ganancias", SC, Session("glbIdUsuario"))
'                                If Len(mAux1) > 0 Then
'                                    oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
'                                End If
'                            End With
'                        End With

'                        'If mDestino = "Printer" Then
'                        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
'                        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
'                        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
'                        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
'                        '    oW.Documents(1).Close(False)
'                        'End If

'                        Exit Do

'                    End If
'                    oRs.MoveNext()
'                Loop
'            End If
'        End If
'        oRs.Close()

'        'oW.Selection.HomeKey(Word.WdUnits.wdStory)

'        Dim output As String = System.IO.Path.GetTempPath & "CertificadoGanancias.doc"

'        Try
'            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
'        Catch ex As Exception
'            'ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.Message)
'            'Throw
'        End Try


'        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
'        'If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
'        'NAR(oDoc)
'        oW.Quit()
'        NAR(oW)
'        GC.Collect()


'        Return output

'        If mDestino = "Printer" Then oW.Quit()
'        oW = Nothing
'        oRs = Nothing

'    End Function

'    Public Sub CalcularRetencionIVA(ByVal SC As String, ByRef oOP As OrdenPago)



'        '//////////////////////////////////////////////////////////
'        'de tabla proveedores
'        '//////////////////////////////////////////////////////////
'        Dim oPrv = ProveedorManager.GetItem(SC, oOP.IdProveedor)
'        Dim mvarTipoIVA = oPrv.IdCodigoIva

'        Dim mvarExceptuadoRetencionIVA
'        If Not IsNull(oPrv.IvaExencionRetencion) And oPrv.IvaExencionRetencion = "SI" Then
'            mvarExceptuadoRetencionIVA = 100
'        Else
'            'If IsNull(oPrv.IvaFechaInicioExencion) Or oPrv.IvaFechaInicioExencion <= oOP.FechaOrdenPago Then
'            If Not IsNull(oPrv.IvaFechaCaducidadExencion) And oPrv.IvaFechaCaducidadExencion >= oOP.FechaOrdenPago Then
'                If Not IsNull(oPrv.IvaPorcentajeExencion) Then
'                    mvarExceptuadoRetencionIVA = oPrv.IvaPorcentajeExencion
'                End If
'            End If
'            'End If
'        End If


'        Dim mvarCodigoSituacionRetencionIVA = oPrv.CodigoSituacionRetencionIVA


'        '//////////////////////////////////////////////////////////
'        'de tabla parametros
'        '//////////////////////////////////////////////////////////
'        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)

'        Dim mvarAgenteRetencionIVA = iisNull(p.p(ePmOrg.AgenteRetencionIVA), "NO")
'        Dim mvarTopeMinimoRetencionIVA = iisNull(p.p(ePmOrg.TopeMinimoRetencionIVA), 0)
'        Dim mvarTopeMinimoRetencionIVAServicios = iisNull(p.p(ePmOrg.TopeMinimoRetencionIVAServicios), 0)
'        Dim mvarImporteMinimoRetencionIVA = iisNull(p.p(ePmOrg.ImporteMinimoRetencionIVA), 0)
'        Dim mvarImporteMinimoRetencionIVAServicios = iisNull(p.p(ePmOrg.ImporteMinimoRetencionIVAServicios), 0)
'        Dim mvarPorcentajeBaseRetencionIVABienes = iisNull(p.p(ePmOrg.PorcentajeBaseRetencionIVABienes), 0)
'        Dim mvarPorcentajeBaseRetencionIVAServicios = iisNull(p.p(ePmOrg.PorcentajeBaseRetencionIVAServicios), 0)
'        Dim mvarImporteTotalMinimoAplicacionRetencionIVA = iisNull(p.p(ePmOrg.ImporteTotalMinimoAplicacionRetencionIVA), 0)
'        Dim mvarImporteComprobantesMParaRetencionIVA = iisNull(p.p(ePmOrg.ImporteComprobantesMParaRetencionIVA), 0)
'        Dim mvarPorcentajeRetencionIVAComprobantesM = iisNull(p.p(ePmOrg.PorcentajeRetencionIVAComprobantesM), 0)


'        Dim glbTopeMonotributoAnual_Bienes = iisNull(TraerValorParametro2(SC, "TopeMonotributoAnual_Bienes"), 0)
'        Dim glbTopeMonotributoAnual_Servicios = iisNull(TraerValorParametro2(SC, "TopeMonotributoAnual_Servicios"), 0)

'        '//////////////////////////////////////////////////////////
'        '//////////////////////////////////////////////////////////
'        '//////////////////////////////////////////////////////////
'        '//////////////////////////////////////////////////////////




'        With oOP

'            If .Id < 1 Then







'                Dim mvarRetencionIVA As Double, mvarRetencionIVAComprobantesM As Double, mvarRetencionIVAIndividual As Double
'                Dim mvarBase As Double, mvarBienesUltimoAño As Double, mvarServiciosUltimoAño As Double
'                Dim oRs As ADODB.Recordset

'                mvarRetencionIVA = 0
'                mvarRetencionIVAComprobantesM = 0
'                mvarBienesUltimoAño = 0
'                mvarServiciosUltimoAño = 0

'                If mvarTipoIVA = 6 Then
'                    oRs = TraerFiltradoVB6(SC, enumSPs.ComprobantesProveedores_TX_TotalBSUltimoAño, oOP.IdProveedor, oOP.FechaOrdenPago, 6)
'                    If oRs.RecordCount > 0 Then
'                        mvarBienesUltimoAño = IIf(IsNull(oRs.Fields("Importe_Bienes").Value), 0, oRs.Fields("Importe_Bienes").Value)
'                        mvarServiciosUltimoAño = IIf(IsNull(oRs.Fields("Importe_Servicios").Value), 0, oRs.Fields("Importe_Servicios").Value)
'                    End If
'                    oRs.Close()
'                End If









'                For Each oL In oOP.DetallesImputaciones
'                    With oL
'                        If Not .Eliminado Then
'                            mvarRetencionIVAIndividual = 0
'                            If Len(oL.RetIVAenOP) = 0 Or oL.RetIVAenOP = oOP.NumeroOrdenPago Then
'                                mvarBase = Val(oL.IVA)
'                                If False Then 'Mid(oL.SubItems(1), 1, 1) = "M" Then
'                                    'If (Val(oL.TotalComprobanteImputado) - Val(oL.IVA)) >= mvarImporteComprobantesMParaRetencionIVA Then
'                                    '    mvarRetencionIVAIndividual = Math.Round(mvarBase * mvarPorcentajeRetencionIVAComprobantesM / 100, 2)
'                                    '    mvarRetencionIVAComprobantesM = mvarRetencionIVAComprobantesM + mvarRetencionIVAIndividual
'                                    'End If
'                                ElseIf mvarAgenteRetencionIVA = "SI" Then
'                                    If mvarCodigoSituacionRetencionIVA = 2 Then
'                                        mvarRetencionIVAIndividual = mvarBase
'                                    Else
'                                        If Val(oL.TotalComprobanteImputado) > mvarImporteTotalMinimoAplicacionRetencionIVA Then
'                                            If oL.Bien_o_Servicio = "B" Then
'                                                If mvarBase > mvarTopeMinimoRetencionIVA Then
'                                                    mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVABienes / 100
'                                                    If mvarExceptuadoRetencionIVA <> 0 Then
'                                                        mvarRetencionIVAIndividual = Math.Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
'                                                    Else
'                                                        mvarRetencionIVAIndividual = mvarBase
'                                                        If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVA Then
'                                                            mvarRetencionIVAIndividual = 0
'                                                        End If
'                                                    End If
'                                                    If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
'                                                End If
'                                            ElseIf oL.Bien_o_Servicio = "S" Then
'                                                If mvarBase > mvarTopeMinimoRetencionIVAServicios Then
'                                                    mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVAServicios / 100
'                                                    If mvarExceptuadoRetencionIVA <> 0 Then
'                                                        mvarRetencionIVAIndividual = Math.Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
'                                                    Else
'                                                        mvarRetencionIVAIndividual = mvarBase
'                                                        If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVAServicios Then
'                                                            mvarRetencionIVAIndividual = 0
'                                                        End If
'                                                    End If
'                                                    If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
'                                                End If
'                                            Else
'                                                mvarBase = 0
'                                            End If
'                                        End If
'                                    End If
'                                End If



'                                '/////////////////////////////////////////////////////////////////////////
'                                '/////////////////////////////////////////////////////////////////////////
'                                'Si es monotributista verifico la facturacion del ultimo año y recalculo la retencion
'                                '/////////////////////////////////////////////////////////////////////////
'                                '/////////////////////////////////////////////////////////////////////////
'                                'If mvarTipoIVA = 6 Then
'                                '    If mvarBienesUltimoAño > glbTopeMonotributoAnual_Bienes Or mvarServiciosUltimoAño > glbTopeMonotributoAnual_Servicios Then
'                                '        mvarBase = Val(oL.SubItems(6))
'                                '        If Val(oL.SubItems(19)) = 21 Then mvarRetencionIVAIndividual = mvarBase * 0.168
'                                '        If Val(oL.SubItems(19)) = 10.5 Then mvarRetencionIVAIndividual = mvarBase * 0.084
'                                '    End If
'                                'End If
'                                'oL.RetIVA = mvarRetencionIVAIndividual
'                                'With origen.DetOrdenesPago.Item(oL.Tag)
'                                '    .Registro.Fields("ImporteRetencionIVA").Value = mvarRetencionIVAIndividual
'                                '    .Modificado = True
'                                'End With
'                                '/////////////////////////////////////////////////////////////////////////
'                                '/////////////////////////////////////////////////////////////////////////
'                                '/////////////////////////////////////////////////////////////////////////



'                            End If
'                            .ImporteRetencionIVA = mvarRetencionIVAIndividual
'                            mvarRetencionIVA = mvarRetencionIVA + mvarRetencionIVAIndividual
'                        End If
'                    End With
'                Next

'                .RetencionIVA = mvarRetencionIVA
'                .RetencionIVAComprobantesM = mvarRetencionIVAComprobantesM

'                oRs = Nothing
'            End If


'        End With

'    End Sub

'    Public Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef oOP As OrdenPago)
'        '            'todo esto estaba en el mts

'        'Public Function Guardar(ByRef OrdenPago As adodb.Recordset, _
'        '                        ByVal Detalles As adodb.Recordset, _
'        '                        ByVal DetallesValores As adodb.Recordset, _
'        '                        ByVal DetallesCuentas As adodb.Recordset, _
'        '                        ByVal RegistroContable As adodb.Recordset, _
'        '                        ByVal AnticiposAlPersonal As adodb.Recordset, _
'        '                        ByVal DetallesImpuestos As adodb.Recordset, _
'        '                        ByVal DetallesRubrosContables As adodb.Recordset) As InterFazMTS.MisEstados

'        If Not IsDBNull(oOP.Confirmado) And _
'              oOP.Confirmado = "NO" Then
'            Guardar_CodigoOriginalDeVB6 = GuardarNoConfirmados(SC, oOP)
'            Exit Function
'        End If

'        Dim RegistroContable As ADODB.Recordset = DataTable_To_Recordset(OrdenPagoManager.RecalcularRegistroContable(SC, oOP))

'        Dim oCont 'As ObjectContext
'        Dim oDet As ICompMTSManager
'        Dim Resp As ICompMTSManager.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String
'        Dim Datos As ADODB.Recordset
'        Dim DatosCtaCte As ADODB.Recordset
'        Dim DatosCtaCteNv As ADODB.Recordset
'        Dim DatosProveedor As ADODB.Recordset
'        Dim oRsValores As ADODB.Recordset
'        Dim oRsValoresNv As ADODB.Recordset
'        Dim oRsComp As ADODB.Recordset
'        Dim DatosAsiento As ADODB.Recordset
'        Dim DatosAsientoNv As ADODB.Recordset
'        Dim oRsParametros As ADODB.Recordset
'        Dim DatosDetAsiento As ADODB.Recordset
'        Dim DatosDetAsientoNv As ADODB.Recordset
'        Dim DatosAnt As ADODB.Recordset
'        Dim oRsAux As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim i As Integer, mvarIdBanco As Integer
'        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
'        Dim mvarIdCuenta As Long, mIdDetalleOrdenPago As Long, mvarIdProveedorAnterior As Long
'        Dim mvarIdDetalleOrdenPagoCuentas As Long, mIdDetalleOrdenPagoValores As Long
'        Dim mIdValor As Long, mNumeroOrdenPago As Long
'        Dim Tot As Double, Sdo As Double, TotDol As Double, SdoDol As Double
'        Dim TotEu As Double, SdoEu As Double, mvarCotizacionEuro As Double
'        Dim mAcreedores As Double, mvarCotizacion As Double, mvarCotizacionMoneda As Double
'        Dim mvarCotizacionMonedaAnt As Double, mvarDebe As Double, mvarHaber As Double
'        Dim mvarAnulada As Boolean, mvarBorrarEnValores As Boolean
'        Dim mvarEsCajaBanco As String, mvarFormaAnulacionCheques As String



'        With oOP


'            'On Error GoTo Mal

'            'oCont = GetObjectContext

'            If oCont Is Nothing Then
'                oDet = CreateObject("MTSPronto.General")
'            Else
'                oDet = oCont.CreateInstance("MTSPronto.General")
'            End If

'            mvarIdentificador = oOP.Id

'            mvarAnulada = False
'            If oOP.Anulada = "OK" Then
'                mvarAnulada = True
'                oOP.Anulada = "SI"
'            End If
'            mvarCotizacion = IIf(IsDBNull(oOP.CotizacionDolar), 1, oOP.CotizacionDolar)
'            mvarCotizacionEuro = IIf(IsDBNull(oOP.CotizacionEuro), 1, oOP.CotizacionEuro)
'            mvarCotizacionMoneda = IIf(IsDBNull(oOP.CotizacionMoneda), 1, oOP.CotizacionMoneda)
'            mvarFormaAnulacionCheques = IIf(IsDBNull(oOP.FormaAnulacionCheques), "", oOP.FormaAnulacionCheques)

'            mAcreedores = 0
'            mvarIdProveedorAnterior = 0
'            If mvarIdentificador > 0 Then
'                DatosAnt = oDet.LeerUno("OrdenesPago", mvarIdentificador)
'                If DatosAnt.RecordCount > 0 Then
'                    mvarCotizacionMonedaAnt = IIf(IsDBNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
'                    mAcreedores = DatosAnt.Fields("Acreedores").Value
'                    If Not IsDBNull(DatosAnt.Fields("IdProveedor").Value) Then
'                        mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
'                    End If
'                End If
'                DatosAnt.Close()
'                DatosAnt = Nothing
'            End If

'            Resp = oDet.GuardarPorRef(SC, "OrdenesPago", oOP)

'            mNumeroOrdenPago = oOP.NumeroOrdenPago
'            DatosAnt = oDet.LeerUno("OrdenesPago", oOP.Id)
'            If DatosAnt.RecordCount > 0 Then
'                mNumeroOrdenPago = DatosAnt.Fields("NumeroOrdenPago").Value
'            End If
'            DatosAnt.Close()

'            If Not IsDBNull(oOP.IdOPComplementariaFF) Then
'                oDet.Tarea(SC, "OrdenesPago_ActualizarIdOrdenPagoComplementaria", ArrayVB6(oOP.IdOPComplementariaFF, oOP.Id))
'                oDet.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", ArrayVB6(0, oOP.Id))
'            End If

'            If mvarIdProveedorAnterior <> 0 Then
'                DatosProveedor = oDet.LeerUno("Proveedores", mvarIdProveedorAnterior)
'                If IsDBNull(DatosProveedor.Fields("Saldo").Value) Then
'                    DatosProveedor.Fields("Saldo").Value = 0
'                End If
'                DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value - (mAcreedores * mvarCotizacionMonedaAnt)
'                Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
'                DatosProveedor.Close()
'                DatosProveedor = Nothing
'            End If
'            If Not IsDBNull(oOP.IdProveedor) And Not mvarAnulada Then
'                DatosProveedor = oDet.LeerUno("Proveedores", oOP.IdProveedor)
'                If IsDBNull(DatosProveedor.Fields("Saldo").Value) Then
'                    DatosProveedor.Fields("Saldo").Value = 0
'                End If
'                DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value + (oOP.Acreedores * mvarCotizacionMoneda)
'                Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
'                DatosProveedor.Close()
'                DatosProveedor = Nothing
'            End If

'            If mvarIdentificador > 0 And mvarAnulada Then
'                DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdOrdenPago", mvarIdentificador)
'                If DatosAnt.RecordCount > 0 Then
'                    DatosAnt.MoveFirst()
'                    Do While Not DatosAnt.EOF
'                        DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_PorDetalleOrdenPago", DatosAnt.Fields(0).Value)
'                        If DatosCtaCteNv.RecordCount > 0 Then
'                            Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
'                            TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
'                            TotEu = IIf(IsDBNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
'                                     IIf(IsDBNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

'                            If Not IsDBNull(DatosAnt.Fields("IdImputacion").Value) Then
'                                If DatosAnt.Fields("IdImputacion").Value > 0 Then
'                                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
'                                    If DatosCtaCte.RecordCount > 0 Then
'                                        '                        If DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
'                                        DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
'                                        DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
'                                        DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
'                                        Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)

'                                        If IIf(IsDBNull(DatosAnt.Fields("ImporteRetencionIVA").Value), 0, DatosAnt.Fields("ImporteRetencionIVA").Value) <> 0 Then
'                                            oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", _
'                                                  ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, 0))
'                                        End If
'                                        '                        End If
'                                    End If
'                                    DatosCtaCte.Close()
'                                    DatosCtaCte = Nothing
'                                End If
'                            End If

'                            oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)
'                        End If
'                        DatosCtaCteNv.Close()
'                        DatosCtaCteNv = Nothing

'                        DatosAnt.MoveNext()
'                    Loop
'                End If
'                DatosAnt.Close()
'                DatosAnt = Nothing
'            End If



'            For Each item In oOP.DetallesImputaciones
'                With item

'                    'Safar de choclazos con muchos bloques anidados:
'                    'Folding is used to mask excessive length. The presence of folded code can lull developers into 
'                    'a false sense of what clean code looks like. Under the cover of folding, you can end up writing long, 
'                    'horrible spaghetti code blocks. If the code needs the crutch of folding to look organized, it's bad code.
'                    '-Finally someone who hates this useless #region crap. I have the same opinion - it drives me crazy when 
'                    'im looking at someone's code and can't see a thing. Linus Torvalds once wrote: if you need more than 3 levels 
'                    'of indentation, you're screwed anyway. If you need to use #refion - see above :-)

'                    .Id = oOP.Id


'                    If mvarIdentificador > 0 And Not mvarAnulada Then
'                        DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdDetalleOrdenPago", .Id)
'                        If DatosAnt.RecordCount > 0 Then
'                            DatosAnt.MoveFirst()
'                            Do While Not DatosAnt.EOF

'                                DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_PorDetalleOrdenPago", .Id)
'                                If DatosCtaCteNv.RecordCount > 0 Then

'                                    Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
'                                    TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
'                                    TotEu = IIf(IsDBNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
'                                             IIf(IsDBNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

'                                    If Not IsDBNull(DatosAnt.Fields("IdImputacion").Value) Then
'                                        If DatosAnt.Fields("IdImputacion").Value > 0 Then
'                                            DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
'                                            If DatosCtaCte.RecordCount > 0 Then
'                                                '                                 If DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
'                                                DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
'                                                DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
'                                                DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
'                                                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
'                                                '                                 End If
'                                            End If
'                                            DatosCtaCte.Close()
'                                            DatosCtaCte = Nothing
'                                        End If
'                                    End If

'                                    oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)

'                                End If
'                                DatosCtaCteNv.Close()
'                                DatosCtaCteNv = Nothing

'                                DatosAnt.MoveNext()
'                            Loop
'                        End If
'                        DatosAnt.Close()
'                        DatosAnt = Nothing

'                    ElseIf mvarIdentificador > 0 And mvarAnulada Then
'                        oDet.Tarea(SC, "DiferenciasCambio_Eliminar", ArrayVB6(17, .Id))
'                    End If





'                    If .Eliminado Then

'                        If .Id > 0 Then
'                            'Si borro la imputacion y tenia retencion iva, borra la marca en comprobante de proveedores
'                            DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdDetalleOrdenPago", .Id)
'                            If DatosAnt.RecordCount > 0 Then
'                                If IIf(IsDBNull(DatosAnt.Fields("ImporteRetencionIVA").Value), 0, DatosAnt.Fields("ImporteRetencionIVA").Value) <> 0 And _
'                                      IIf(IsDBNull(DatosAnt.Fields("IdImputacion").Value), 0, DatosAnt.Fields("IdImputacion").Value) > 0 Then
'                                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
'                                    If DatosCtaCte.RecordCount > 0 Then
'                                        oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, 0))
'                                    End If
'                                    DatosCtaCte.Close()
'                                End If
'                            End If
'                            DatosAnt.Close()
'                            oDet.Eliminar(SC, "DetOrdenesPago", .Id)
'                        End If

'                    ElseIf Not mvarAnulada Then

'                        Resp = oDet.Guardar(SC, "DetOrdenesPago", Datos)
'                        mIdDetalleOrdenPago = Datos.Fields(0).Value
'                        Datos.Close()

'                        DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
'                        DatosCtaCteNv = CopiarRs(DatosCtaCte)
'                        DatosCtaCte.Close()
'                        DatosCtaCte = Nothing

'                        With DatosCtaCteNv
'                            Tot = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda), 2)
'                            TotDol = 0
'                            If mvarCotizacion <> 0 Then
'                                TotDol = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / mvarCotizacion, 2)
'                            End If
'                            TotEu = 0
'                            If mvarCotizacionEuro <> 0 Then
'                                TotEu = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / mvarCotizacionEuro, 2)
'                            End If
'                            .Fields("IdProveedor").Value = oOP.IdProveedor
'                            .Fields("NumeroComprobante").Value = mNumeroOrdenPago
'                            .Fields("Fecha").Value = oOP.FechaOrdenPago
'                            .Fields("FechaVencimiento").Value = oOP.FechaOrdenPago
'                            If item.IdImputacion <> -2 Then
'                                .Fields("IdTipoComp").Value = 17
'                            Else
'                                .Fields("IdTipoComp").Value = 16
'                            End If
'                            .Fields("IdComprobante").Value = oOP.Id
'                            If item.IdImputacion <> -1 And _
'                                  item.IdImputacion <> -2 Then
'                                .Fields("IdImputacion").Value = item.IdImputacion
'                            End If
'                            .Fields("ImporteTotal").Value = Tot
'                            .Fields("Saldo").Value = Tot
'                            .Fields("IdDetalleOrdenPago").Value = mIdDetalleOrdenPago
'                            .Fields(0).Value = -1
'                            .Fields("CotizacionDolar").Value = mvarCotizacion
'                            .Fields("ImporteTotalDolar").Value = TotDol
'                            .Fields("SaldoDolar").Value = TotDol
'                            .Fields("CotizacionEuro").Value = mvarCotizacionEuro
'                            .Fields("ImporteTotalEuro").Value = TotEu
'                            .Fields("SaldoEuro").Value = TotEu
'                            .Fields("IdMoneda").Value = oOP.IdMoneda
'                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
'                            If Not IsNothing(.Fields("IdImputacion").Value) And _
'                                  Not IsDBNull(.Fields("IdImputacion").Value) Then
'                                DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", item.IdImputacion)
'                                If DatosCtaCte.RecordCount > 0 Then
'                                    Sdo = DatosCtaCte.Fields("Saldo").Value
'                                    SdoDol = IIf(IsDBNull(DatosCtaCte.Fields("SaldoDolar").Value), 0, DatosCtaCte.Fields("SaldoDolar").Value)
'                                    SdoEu = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value)
'                                Else
'                                    Sdo = 0
'                                    SdoDol = 0
'                                    SdoEu = 0
'                                End If
'                                If oOP.Dolarizada = "NO" Then
'                                    TotDol = 0
'                                    If DatosCtaCte.Fields("CotizacionDolar").Value <> 0 Then
'                                        TotDol = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / DatosCtaCte.Fields("CotizacionDolar").Value, 2)
'                                    End If
'                                    .Fields("CotizacionDolar").Value = DatosCtaCte.Fields("CotizacionDolar").Value
'                                    .Fields("ImporteTotalDolar").Value = TotDol
'                                    .Fields("SaldoDolar").Value = TotDol

'                                    TotEu = 0
'                                    If DatosCtaCte.Fields("CotizacionEuro").Value <> 0 Then
'                                        TotEu = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / DatosCtaCte.Fields("CotizacionEuro").Value, 2)
'                                    End If
'                                    .Fields("CotizacionEuro").Value = DatosCtaCte.Fields("CotizacionEuro").Value
'                                    .Fields("ImporteTotalEuro").Value = TotEu
'                                    .Fields("SaldoEuro").Value = TotEu
'                                End If

'                                If Tot > Sdo Then
'                                    Tot = Math.Round(Tot - Sdo, 2)
'                                    DatosCtaCte.Fields("Saldo").Value = 0
'                                    .Fields("Saldo").Value = Tot
'                                Else
'                                    Sdo = Math.Round(Sdo - Tot, 2)
'                                    DatosCtaCte.Fields("Saldo").Value = Sdo
'                                    .Fields("Saldo").Value = 0
'                                End If
'                                If TotDol > SdoDol Then
'                                    TotDol = Math.Round(TotDol - SdoDol, 2)
'                                    DatosCtaCte.Fields("SaldoDolar").Value = 0
'                                    .Fields("SaldoDolar").Value = TotDol
'                                Else
'                                    SdoDol = Math.Round(SdoDol - TotDol, 2)
'                                    DatosCtaCte.Fields("SaldoDolar").Value = SdoDol
'                                    .Fields("SaldoDolar").Value = 0
'                                End If
'                                If TotEu > SdoEu Then
'                                    TotEu = Math.Round(TotEu - SdoEu, 2)
'                                    DatosCtaCte.Fields("SaldoEuro").Value = 0
'                                    .Fields("SaldoEuro").Value = TotEu
'                                Else
'                                    SdoEu = Math.Round(SdoEu - TotEu, 2)
'                                    DatosCtaCte.Fields("SaldoEuro").Value = SdoEu
'                                    .Fields("SaldoEuro").Value = 0
'                                End If

'                                .Fields("IdImputacion").Value = DatosCtaCte.Fields("IdImputacion").Value
'                                oRsComp = oDet.TraerFiltrado(SC, "TiposComprobante", "_Buscar", DatosCtaCte.Fields("IdTipoComp").Value)
'                                If oRsComp.Fields("Coeficiente").Value = -1 Then
'                                    .Fields("IdTipoComp").Value = 16
'                                End If
'                                oRsComp.Close()
'                                If DatosCtaCte.Fields("IdTipoComp").Value <> 16 And DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
'                                    If Not IsDBNull(item.ImporteRetencionIVA) Then
'                                        If item.ImporteRetencionIVA <> 0 Then
'                                            oRsComp = oDet.LeerUno("ComprobantesProveedores", DatosCtaCte.Fields("IdComprobante").Value)
'                                            If oRsComp.RecordCount > 0 Then
'                                                If IsDBNull(oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value) Or _
'                                                      oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value = 0 Then
'                                                    oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", _
'                                                          ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, mIdDetalleOrdenPago))
'                                                    '                                    oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value = mIdDetalleOrdenPago
'                                                    '                                    Resp = oDet.Guardar(sc,"ComprobantesProveedores", oRsComp)
'                                                End If
'                                            End If
'                                            oRsComp.Close()
'                                        End If
'                                    End If
'                                End If
'                                oRsComp = Nothing
'                                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
'                                DatosCtaCte.Close()
'                                DatosCtaCte = Nothing
'                            End If
'                        End With

'                        If Not IsNothing(DatosCtaCteNv.Fields("IdImputacion").Value) Then
'                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
'                        Else
'                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
'                            DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
'                            item.IdImputacion = DatosCtaCteNv.Fields(0).Value
'                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
'                        End If
'                        DatosCtaCteNv.Close()
'                        DatosCtaCteNv = Nothing

'                        If mvarIdentificador > 0 Then
'                            oDet.Tarea(SC, "DiferenciasCambio_Eliminar", ArrayVB6(17, mIdDetalleOrdenPago))
'                        End If
'                        If oOP.Dolarizada = "SI" Then
'                            Datos = CopiarRs(oDet.TraerFiltrado(SC, "DiferenciasCambio", "_Struc"))
'                            Datos.Fields(0).Value = -1
'                            Datos.Fields("IdTipoComprobante").Value = 17
'                            Datos.Fields("IdRegistroOrigen").Value = mIdDetalleOrdenPago
'                            Resp = oDet.Guardar(SC, "DiferenciasCambio", Datos)
'                            Datos.Close()
'                        End If
'                        Datos = Nothing


'                    End If





'                End With
'            Next




'            If mvarIdentificador > 0 And mvarAnulada Then
'                oRsAux = oDet.TraerFiltrado(SC, "DetOrdenesPagoValores", "_PorIdCabecera", mvarIdentificador)
'                With oRsAux
'                    If .RecordCount > 0 Then
'                        .MoveFirst()
'                        Do While Not .EOF
'                            If Not IsDBNull(.Fields("IdValor").Value) Then
'                                oRsValores = oDet.LeerUno("Valores", .Fields("IdValor").Value)
'                                With oRsValores
'                                    .Fields("Estado").Value = DBNull.Value
'                                    .Fields("IdProveedor").Value = DBNull.Value
'                                    .Fields("NumeroOrdenPago").Value = DBNull.Value
'                                    .Fields("FechaOrdenPago").Value = DBNull.Value
'                                End With
'                                Resp = oDet.Guardar(SC, "Valores", oRsValores)
'                                oRsValores.Close()
'                                oRsValores = Nothing
'                            End If
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Fields(0).Value)
'                            .MoveNext()
'                        Loop
'                    End If
'                    .Close()
'                End With




'                oRsAux = Nothing
'            End If


'            For Each itV In .DetallesValores

'                With itV
'                    itV.IdOrdenPago = oOP.Id

'                    If itV.Eliminado Then
'                        If .Id > 0 Then
'                            If Not IsDBNull(itV.IdValor) Then
'                                oRsValores = oDet.LeerUno("Valores", itV.IdValor)
'                                With oRsValores
'                                    .Fields("Estado").Value = DBNull.Value
'                                    .Fields("IdProveedor").Value = DBNull.Value
'                                    .Fields("NumeroOrdenPago").Value = DBNull.Value
'                                    .Fields("FechaOrdenPago").Value = DBNull.Value
'                                End With
'                                Resp = oDet.Guardar(SC, "Valores", oRsValores)
'                                oRsValores.Close()
'                                oRsValores = Nothing
'                            End If
'                            oDet.Eliminar(SC, "DetOrdenesPagoValores", .Id)
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Id)
'                        End If
'                    Else

'                        Resp = oDet.Guardar(SC, "DetOrdenesPagoValores", Datos)
'                        mIdDetalleOrdenPagoValores = Datos.Fields(0).Value

'                        mvarBorrarEnValores = True

'                        mIdValor = -1
'                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleOrdenPagoValores", mIdDetalleOrdenPagoValores)
'                        If oRsValores.RecordCount > 0 Then mIdValor = oRsValores.Fields(0).Value
'                        oRsValores.Close()
'                        oRsValores = Nothing

'                        If Not IsDBNull(itV.IdCaja) Then
'                            If Not mvarAnulada Then
'                                oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
'                                oRsValoresNv = CopiarRs(oRsValores)
'                                oRsValores.Close()
'                                With oRsValoresNv
'                                    .Fields("IdTipoValor").Value = itV.IdTipoValor
'                                    .Fields("Importe").Value = itV.Importe
'                                    .Fields("NumeroComprobante").Value = mNumeroOrdenPago
'                                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
'                                    If Not IsDBNull(oOP.IdProveedor) Then
'                                        .Fields("IdProveedor").Value = oOP.IdProveedor
'                                    End If
'                                    .Fields("IdTipoComprobante").Value = 17
'                                    .Fields("IdDetalleOrdenPagoValores").Value = mIdDetalleOrdenPagoValores
'                                    .Fields("IdCaja").Value = itV.IdCaja
'                                    .Fields("IdMoneda").Value = oOP.IdMoneda
'                                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
'                                    .Fields(0).Value = mIdValor
'                                End With
'                                Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
'                                oRsValoresNv.Close()
'                                oRsValoresNv = Nothing
'                            End If
'                            mvarBorrarEnValores = False
'                        Else
'                            If Not IsDBNull(.IdValor) Then
'                                If Not mvarAnulada Then
'                                    oRsValores = oDet.LeerUno("Valores", .IdValor)
'                                    With oRsValores
'                                        .Fields("Estado").Value = "E"
'                                        If Not IsDBNull(oOP.IdProveedor) Then
'                                            .Fields("IdProveedor").Value = oOP.IdProveedor
'                                        End If
'                                        .Fields("NumeroOrdenPago").Value = mNumeroOrdenPago
'                                        .Fields("FechaOrdenPago").Value = oOP.FechaOrdenPago
'                                    End With
'                                    Resp = oDet.Guardar(SC, "Valores", oRsValores)
'                                    oRsValores.Close()
'                                    oRsValores = Nothing
'                                End If
'                            Else
'                                If Not mvarAnulada Or (Not IsDBNull(.Anulado) And .Anulado = "SI") Then
'                                    If mIdValor > 0 Then
'                                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorId", mIdValor)
'                                        oRsValoresNv = ClaseMigrar.CopiarUnRegistro(oRsValores)
'                                    Else
'                                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
'                                        oRsValoresNv = CopiarRs(oRsValores)
'                                    End If
'                                    oRsValores.Close()
'                                    oRsValores = Nothing
'                                    With oRsValoresNv
'                                        .Fields("IdTipoValor").Value = itV.IdTipoValor
'                                        .Fields("NumeroValor").Value = itV.NumeroValor
'                                        .Fields("NumeroInterno").Value = itV.NumeroInterno
'                                        .Fields("FechaValor").Value = itV.FechaVencimiento
'                                        .Fields("IdCuentaBancaria").Value = itV.IdCuentaBancaria
'                                        .Fields("IdBanco").Value = itV.IdBanco
'                                        .Fields("Importe").Value = itV.Importe
'                                        .Fields("NumeroComprobante").Value = mNumeroOrdenPago
'                                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
'                                        If Not IsDBNull(oOP.IdProveedor) Then
'                                            .Fields("IdProveedor").Value = oOP.IdProveedor
'                                        End If
'                                        .Fields("IdTipoComprobante").Value = 17
'                                        .Fields("IdDetalleOrdenPagoValores").Value = mIdDetalleOrdenPagoValores
'                                        .Fields("IdMoneda").Value = oOP.IdMoneda
'                                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
'                                        .Fields("Anulado").Value = itV.Anulado
'                                        .Fields("IdUsuarioAnulo").Value = itV.IdUsuarioAnulo
'                                        .Fields("FechaAnulacion").Value = itV.FechaAnulacion
'                                        .Fields("MotivoAnulacion").Value = itV.MotivoAnulacion
'                                        .Fields("IdTarjetaCredito").Value = itV.IdTarjetaCredito
'                                        .Fields(0).Value = mIdValor
'                                    End With
'                                    Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
'                                    oRsValoresNv.Close()
'                                    oRsValoresNv = Nothing

'                                    mvarBorrarEnValores = False
'                                    If mvarAnulada And mvarFormaAnulacionCheques = "E" Then mvarBorrarEnValores = True

'                                    If mIdValor > 0 And Not IsDBNull(.Anulado) And .Anulado = "SI" Then
'                                        oDet.Tarea(SC, "Asientos_EliminarItemChequePagoDiferido", ArrayVB6("0", 0, mIdValor))
'                                        oDet.Tarea(SC, "Conciliaciones_BorrarPorIdValor", mIdValor)
'                                    End If

'                                    If Not .Id > 0 And Not IsDBNull(itV.IdBancoChequera) Then
'                                        oRsValores = oDet.TraerFiltrado(SC, "BancoChequeras", "_PorId", itV.IdBancoChequera)
'                                        If oRsValores.RecordCount > 0 Then
'                                            '                           If itV.NumeroValor = oRsValores.Fields("ProximoNumeroCheque").Value Then
'                                            '                              oRsValores.Fields("ProximoNumeroCheque").Value = oRsValores.Fields("ProximoNumeroCheque").Value + 1
'                                            '                              Resp = oDet.Guardar(sc,"BancoChequeras", oRsValores)
'                                            '                           End If
'                                            If itV.NumeroValor >= oRsValores.Fields("ProximoNumeroCheque").Value Then
'                                                oRsValores.Fields("ProximoNumeroCheque").Value = itV.NumeroValor + 1
'                                                If oRsValores.Fields("ProximoNumeroCheque").Value >= oRsValores.Fields("HastaCheque").Value Then
'                                                    oRsValores.Fields("Activa").Value = "NO"
'                                                End If
'                                                oRsValores.Update()
'                                            End If
'                                            Resp = oDet.Guardar(SC, "BancoChequeras", oRsValores)
'                                        End If
'                                        oRsValores.Close()
'                                    End If
'                                End If
'                                oRsValores = Nothing
'                            End If
'                        End If
'                        Datos.Close()
'                        Datos = Nothing

'                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Id)
'                        End If
'                    End If

'                End With
'            Next

'            If mvarIdentificador > 0 And mvarAnulada Then
'                oRsAux = oDet.TraerFiltrado(SC, "DetOrdenesPagoCuentas", "_PorIdOrdenPago", mvarIdentificador)
'                With oRsAux
'                    If .RecordCount > 0 Then
'                        .MoveFirst()
'                        Do While Not .EOF
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Fields(0).Value)
'                            .MoveNext()
'                        Loop
'                    End If
'                    .Close()
'                End With
'                oRsAux = Nothing
'            End If

'            For Each iCta In .DetallesCuentas
'                With iCta
'                    iCta.IdOrdenPago = oOP.Id

'                    If iCta.Eliminado Then
'                        If .Id > 0 Then
'                            oDet.Eliminar(SC, "DetOrdenesPagoCuentas", .Id)
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Id)
'                        End If
'                    Else

'                        Resp = oDet.Guardar(SC, "DetOrdenesPagoCuentas", Datos)
'                        mvarIdDetalleOrdenPagoCuentas = Datos.Fields(0).Value
'                        Datos.Close()
'                        Datos = Nothing

'                        mvarBorrarEnValores = True

'                        If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
'                            oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaCajaBanco", iCta.IdCuenta)
'                            If oRsAux.RecordCount > 0 Then
'                                mvarEsCajaBanco = ""
'                                If Not IsDBNull(oRsAux.Fields("EsCajaBanco").Value) And _
'                                      (oRsAux.Fields("EsCajaBanco").Value = "BA" Or oRsAux.Fields("EsCajaBanco").Value = "CA" Or _
'                                       oRsAux.Fields("EsCajaBanco").Value = "TC") Then
'                                    mvarEsCajaBanco = oRsAux.Fields("EsCajaBanco").Value
'                                    oRsAux.Close()
'                                End If
'                                If Len(mvarEsCajaBanco) > 0 Then
'                                    mIdValor = -1
'                                    oRsAux = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleOrdenPagoCuentas", mvarIdDetalleOrdenPagoCuentas)
'                                    If oRsAux.RecordCount > 0 Then mIdValor = oRsAux.Fields(0).Value
'                                    oRsAux.Close()

'                                    mvarIdBanco = 0
'                                    If mvarEsCajaBanco = "BA" And Not IsDBNull(iCta.IdCuentaBancaria) Then
'                                        oRsAux = oDet.TraerFiltrado(SC, "CuentasBancarias", "_PorId", iCta.IdCuentaBancaria)
'                                        If oRsAux.RecordCount > 0 Then mvarIdBanco = oRsAux.Fields("IdBanco").Value
'                                    End If

'                                    oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
'                                    oRsValoresNv = CopiarRs(oRsValores)
'                                    oRsValores.Close()
'                                    oRsValores = Nothing
'                                    With oRsValoresNv
'                                        If mvarEsCajaBanco = "BA" Then
'                                            .Fields("IdTipoValor").Value = 21
'                                            .Fields("IdBanco").Value = mvarIdBanco
'                                            .Fields("IdCuentaBancaria").Value = iCta.IdCuentaBancaria
'                                        ElseIf mvarEsCajaBanco = "TC" Then
'                                            .Fields("IdTipoValor").Value = 43
'                                            .Fields("IdTarjetaCredito").Value = iCta.IdTarjetaCredito
'                                        Else
'                                            .Fields("IdTipoValor").Value = 32
'                                            .Fields("IdCaja").Value = iCta.IdCaja
'                                        End If
'                                        .Fields("NumeroValor").Value = 0
'                                        .Fields("NumeroInterno").Value = 0
'                                        .Fields("FechaValor").Value = oOP.FechaOrdenPago
'                                        If iCta.CotizacionMonedaDestino <> 0 Then
'                                            If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
'                                                .Fields("Importe").Value = (iCta.Debe * _
'                                                                            oOP.CotizacionMoneda) / _
'                                                                            iCta.CotizacionMonedaDestino * -1
'                                            End If
'                                            If Not IsDBNull(iCta.Haber) And iCta.Haber <> 0 Then
'                                                .Fields("Importe").Value = (iCta.Haber * _
'                                                                            oOP.CotizacionMoneda) / _
'                                                                            iCta.CotizacionMonedaDestino
'                                            End If
'                                            .Fields("CotizacionMoneda").Value = iCta.CotizacionMonedaDestino
'                                        Else
'                                            If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
'                                                .Fields("Importe").Value = iCta.Debe * -1
'                                            End If
'                                            If Not IsDBNull(iCta.Haber) And iCta.Haber <> 0 Then
'                                                .Fields("Importe").Value = iCta.Haber
'                                            End If
'                                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
'                                        End If
'                                        .Fields("NumeroComprobante").Value = mNumeroOrdenPago
'                                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
'                                        If Not IsDBNull(oOP.IdProveedor) Then
'                                            .Fields("IdProveedor").Value = oOP.IdProveedor
'                                        End If
'                                        .Fields("IdTipoComprobante").Value = 17
'                                        .Fields("IdDetalleOrdenPagoCuentas").Value = mvarIdDetalleOrdenPagoCuentas
'                                        .Fields("IdMoneda").Value = iCta.IdMoneda
'                                        .Fields(0).Value = mIdValor
'                                    End With
'                                    Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
'                                    oRsValoresNv.Close()
'                                    oRsValoresNv = Nothing
'                                    mvarBorrarEnValores = False
'                                End If
'                            Else
'                                oRsAux.Close()
'                            End If
'                            oRsAux = Nothing
'                        End If
'                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
'                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Id)
'                        End If
'                    End If

'                End With
'            Next

'            If mvarIdentificador > 0 And mvarAnulada Then
'                oDet.Tarea(SC, "AnticiposAlPersonal_BorrarPorIdOrdenPago", mvarIdentificador)
'            End If

'            'Borra la registracion contable anterior si la orden de pago fue modificada
'            If mvarIdentificador > 0 Or mvarAnulada Then
'                DatosAnt = oDet.TraerFiltrado(SC, "Subdiarios", "_PorIdComprobante", ArrayVB6(mvarIdentificador, 17))
'                With DatosAnt
'                    If .RecordCount > 0 Then
'                        .MoveFirst()
'                        Do While Not .EOF
'                            oDet.Eliminar(SC, "Subdiarios", .Fields(0).Value)
'                            .MoveNext()
'                        Loop
'                    End If
'                    .Close()
'                End With
'                DatosAnt = Nothing
'            End If

'            mvarDebe = 0
'            mvarHaber = 0

'            With RegistroContable
'                If .State <> adStateClosed And Not mvarAnulada Then
'                    If .RecordCount > 0 Then
'                        .Update()
'                        .MoveFirst()
'                    End If
'                    Do While Not .EOF
'                        If Not IsDBNull(.Fields("Debe").Value) Then
'                            .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
'                            .Update()
'                            mvarDebe = mvarDebe + .Fields("Debe").Value
'                        End If
'                        If Not IsDBNull(.Fields("Haber").Value) Then
'                            .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
'                            .Update()
'                            mvarHaber = mvarHaber + .Fields("Haber").Value
'                        End If
'                        .MoveNext()
'                    Loop
'                    If .RecordCount > 0 Then
'                        .MoveFirst()
'                        If mvarDebe - mvarHaber <> 0 Then
'                            If Not IsDBNull(.Fields("Debe").Value) Then
'                                .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
'                            Else
'                                .Fields("Haber").Value = .Fields("Haber").Value + Math.Round(mvarDebe - mvarHaber, 2)
'                            End If
'                        End If
'                    End If
'                    Do While Not .EOF
'                        Datos = CreateObject("adodb.Recordset")
'                        For i = 0 To .Fields.Count - 1
'                            With .Fields(i)
'                                Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
'                                Datos.Fields(.Name).Precision = .Precision
'                                Datos.Fields(.Name).NumericScale = .NumericScale
'                            End With
'                        Next
'                        Datos.Open()
'                        Datos.AddNew()
'                        For i = 0 To .Fields.Count - 1
'                            With .Fields(i)
'                                Datos.Fields(i).Value = .Value
'                            End With
'                        Next
'                        Datos.Fields("IdComprobante").Value = oOP.Id
'                        Datos.Fields("NumeroComprobante").Value = mNumeroOrdenPago
'                        Datos.Update()
'                        Resp = oDet.Guardar(SC, "Subdiarios", Datos)
'                        Datos.Close()
'                        Datos = Nothing
'                        .MoveNext()
'                    Loop
'                End If
'            End With

'            If mvarIdentificador > 0 And mvarAnulada Then
'                oDet.Tarea(SC, "DetOrdenesPagoRubrosContables_BorrarPorIdOrdenPago", mvarIdentificador)
'            End If


'            If Not oCont Is Nothing Then
'                With oCont
'                    If .IsInTransaction Then .SetComplete()
'                End With
'            End If

'Salir:
'            Guardar_CodigoOriginalDeVB6 = Resp
'            oDet = Nothing
'            oCont = Nothing
'            On Error GoTo 0
'            If lErr Then
'                Err.Raise(lErr, sSource, sDesc)
'            End If
'            Exit Function

'Mal:
'            If Not oCont Is Nothing Then
'                With oCont
'                    If .IsInTransaction Then .SetAbort()
'                End With
'            End If
'            With Err()
'                lErr = .Number
'                sSource = .Source
'                sDesc = .Description
'            End With
'            'oDet.Tarea(sc,"Log_InsertarRegistro", ArrayVB6("MTSOP", oop.id, 0, Now, 0, _
'            '      "Error " & Err.Number & Err.Description & ", " & Err.Source, _
'            '      "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
'            Resume Salir

'        End With

'    End Function
'End Module

'Public Module MigrarRemito
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdRemito As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetRemitos", "TX_Req", IdRemito))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'    Public Function Guardar(ByRef Remito As ADODB.Recordset, ByVal Detalles As ADODB.Recordset) 'As InterFazMTS.MisEstados

'        Dim oCont 'As ObjectContext
'        Dim oDet 'As iCompMTS
'        Dim Resp 'As InterFazMTS.MisEstados
'        Dim lErr As Long, sSource As String, sDesc As String, mCumplido As String
'        Dim Datos As ADODB.Recordset
'        Dim DatosStock As ADODB.Recordset
'        Dim oRs As ADODB.Recordset
'        Dim oRsCostos As ADODB.Recordset
'        Dim oRsCostosDolares As ADODB.Recordset
'        Dim oFld As ADODB.Field
'        Dim i As Integer
'        Dim mvarStockActual As Double, mvarStockTotal As Double, mvarCantidad As Double
'        Dim mvarUltimoCosto As Double, mvarUltimoCostoDolares As Double
'        Dim mvarIdentificador As Long, mIdArticulo As Long, mPartida As Long
'        Dim mvarIdCosto As Long, mvarIdDetalleRemito As Long
'        Dim mvarAnulado As String

'        On Error GoTo Mal

'        'oCont = GetObjectContext

'        'If oCont Is Nothing Then
'        '    oDet = CreateObject("MTSPronto.General")
'        'Else
'        '    oDet = oCont.CreateInstance("MTSPronto.General")
'        'End If

'        'mvarIdentificador = Remito.Fields(0).Value
'        'mvarAnulado = IIf(IsNull(Remito.Fields("Anulado").Value), "NO", Remito.Fields("Anulado").Value)

'        'Resp = iCompMTS_GuardarPorRef("Remitos", Remito)

'        mPartida = 0

'        '   If mvarIdentificador > 0 Then
'        '      Set oRs = oDet.TraerFiltrado("Remitos", "_DetallesPorIdRemito", mvarIdentificador)
'        '      If oRs.RecordCount > 0 Then
'        '         oRs.MoveFirst
'        '         Do While Not oRs.EOF
'        '            mIdArticulo = IIf(IsNull(oRs.Fields("IdArticulo").Value), 0, oRs.Fields("IdArticulo").Value)
'        '            mPartida = IIf(IsNull(oRs.Fields("Partida").Value), 0, oRs.Fields("Partida").Value)
'        '            Set DatosStock = oDet.TraerFiltrado("Stock", "_Stk", _
'        '                  Array(mIdArticulo, mPartida, _
'        '                     IIf(IsNull(oRs.Fields("IdUbicacion").Value), 1, oRs.Fields("IdUbicacion").Value), _
'        '                     IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value), _
'        '                     IIf(IsNull(oRs.Fields("IdUnidad").Value), 0, oRs.Fields("IdUnidad").Value)))
'        '            If DatosStock.RecordCount > 0 Then
'        '               DatosStock.Fields("CantidadUnidades").Value = DatosStock.Fields("CantidadUnidades").Value + oRs.Fields("Cantidad").Value
'        '            Else
'        '               Set DatosStock = CopiarRs(DatosStock)
'        '               DatosStock.Fields(0).Value = -1
'        '               DatosStock.Fields("IdArticulo").Value = mIdArticulo
'        '               DatosStock.Fields("Partida").Value = mPartida
'        '               DatosStock.Fields("IdUbicacion").Value = IIf(IsNull(oRs.Fields("IdUbicacion").Value), 1, oRs.Fields("IdUbicacion").Value)
'        '               DatosStock.Fields("CantidadUnidades").Value = oRs.Fields("Cantidad").Value
'        '               DatosStock.Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
'        '               DatosStock.Fields("IdObra").Value = IIf(IsNull(oRs.Fields("IdObra").Value), 0, oRs.Fields("IdObra").Value)
'        '            End If
'        '            Resp = oDet.Guardar("Stock", DatosStock)
'        '            DatosStock.Close
'        '            oRs.MoveNext
'        '         Loop
'        '      End If
'        '      oRs.Close
'        '   End If

'        With Detalles

'            If True Then '.State <> adStateClosed Then

'                If Not .EOF Then
'                    .Update()
'                    .MoveFirst()
'                End If

'                Do While Not .EOF

'                    .Fields("IdRemito").Value = Remito.Fields("IdRemito").Value
'                    .Update()

'                    If .Fields("Eliminado").Value Then

'                        oDet.Eliminar("DetRemitos", .Fields(0).Value)

'                    Else

'                        Datos = CreateObject("adodb.Recordset")
'                        For i = 0 To .Fields.Count - 2
'                            'With .Fields(i)
'                            '    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
'                            '    Datos.Fields(.Name).Precision = .Precision
'                            '    Datos.Fields(.Name).NumericScale = .NumericScale
'                            'End With
'                        Next
'                        Datos.Open()
'                        Datos.AddNew()
'                        For i = 0 To .Fields.Count - 2
'                            With .Fields(i)
'                                Datos.Fields(i).Value = .Value
'                            End With
'                        Next
'                        Datos.Update()
'                        Resp = oDet.Guardar("DetRemitos", Datos)
'                        mvarIdDetalleRemito = Datos.Fields(0).Value
'                        Datos.Close()
'                        Datos = Nothing

'                        mvarCantidad = .Fields("Cantidad").Value * -1

'                        'Log
'                        'oDet.Tarea("Log_InsertarRegistro", _
'                        '   Array("RM", Remito.Fields(0).Value, _
'                        '         mvarIdDetalleRemito, Now, mvarCantidad * -1, ""))

'                        If mvarAnulado <> "SI" Then
'                            'Registro de costo promedio ponderado
'                            DatosStock = oDet.TraerFiltrado("Stock", "_ExistenciaPorArticulo", .Fields("IdArticulo").Value)
'                            mvarStockActual = 0
'                            If DatosStock.RecordCount > 0 Then
'                                mvarStockActual = DatosStock.Fields("Stock actual").Value
'                            End If
'                            mvarStockTotal = mvarStockActual + mvarCantidad
'                            DatosStock.Close()
'                            DatosStock = Nothing

'                            mvarIdCosto = -1
'                            oRsCostos = oDet.TraerFiltrado("CostosPromedios", "_PorIdDetalleRemito", mvarIdDetalleRemito)
'                            If oRsCostos.RecordCount > 0 Then
'                                mvarIdCosto = oRsCostos.Fields(0).Value
'                            End If
'                            oRsCostos.Close()
'                            oRsCostos = oDet.TraerFiltrado("CostosPromedios", "_PorArticulo", .Fields("IdArticulo").Value)
'                            oRsCostosDolares = oDet.TraerFiltrado("CostosPromedios", "_PorArticuloEnDolares", .Fields("IdArticulo").Value)

'                            mvarUltimoCosto = 0
'                            If oRsCostos.RecordCount > 0 Then
'                                mvarUltimoCosto = oRsCostos.Fields("CostoFinal").Value
'                            End If

'                            mvarUltimoCostoDolares = 0
'                            If oRsCostosDolares.RecordCount > 0 Then
'                                mvarUltimoCostoDolares = oRsCostosDolares.Fields("CostoFinalU$S").Value
'                            End If
'                            oRsCostosDolares.Close()
'                            oRsCostosDolares = Nothing

'                            oRsCostos = CopiarRs(oRsCostos)
'                            oRsCostos.Fields("IdArticulo").Value = .Fields("IdArticulo").Value
'                            oRsCostos.Fields("TipoComprobante").Value = "RM"
'                            oRsCostos.Fields("NumeroComprobante").Value = Remito.Fields("NumeroRemito").Value
'                            oRsCostos.Fields("Fecha").Value = Now
'                            oRsCostos.Fields("Cantidad").Value = mvarCantidad
'                            oRsCostos.Fields("Costo").Value = DBNull.Value
'                            oRsCostos.Fields("StockInicial").Value = mvarStockActual
'                            oRsCostos.Fields("CostoInicial").Value = mvarUltimoCosto
'                            oRsCostos.Fields("StockFinal").Value = mvarStockTotal
'                            oRsCostos.Fields("CostoFinal").Value = mvarUltimoCosto
'                            oRsCostos.Fields("CostoInicialU$S").Value = mvarUltimoCostoDolares
'                            oRsCostos.Fields("CostoCompraU$S").Value = DBNull.Value
'                            oRsCostos.Fields("CostoFinalU$S").Value = mvarUltimoCostoDolares
'                            oRsCostos.Fields("IdDetalleRemito").Value = mvarIdDetalleRemito
'                            oRsCostos.Fields("IdOrigen").Value = .Fields(0).Value
'                            oRsCostos.Fields(0).Value = mvarIdCosto
'                            Resp = oDet.Guardar("CostosPromedios", oRsCostos)
'                            oRsCostos.Close()
'                            oRsCostos = Nothing

'                            '                  mIdArticulo = IIf(IsNull(.Fields("IdArticulo").Value), 0, .Fields("IdArticulo").Value)
'                            '                  mPartida = IIf(IsNull(.Fields("Partida").Value), 0, .Fields("Partida").Value)
'                            '                  Set DatosStock = oDet.TraerFiltrado("Stock", "_Stk", _
'                            '                        Array(mIdArticulo, mPartida, _
'                            '                        IIf(IsNull(.Fields("IdUbicacion").Value), 1, .Fields("IdUbicacion").Value), _
'                            '                        IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value), _
'                            '                        IIf(IsNull(.Fields("IdUnidad").Value), 0, .Fields("IdUnidad").Value)))
'                            '                  If DatosStock.RecordCount > 0 Then
'                            '                     DatosStock.Fields("CantidadUnidades").Value = DatosStock.Fields("CantidadUnidades").Value - .Fields("Cantidad").Value
'                            '                  Else
'                            '                     Set DatosStock = CopiarRs(DatosStock)
'                            '                     DatosStock.Fields(0).Value = -1
'                            '                     DatosStock.Fields("IdArticulo").Value = mIdArticulo
'                            '                     DatosStock.Fields("Partida").Value = mPartida
'                            '                     DatosStock.Fields("IdUbicacion").Value = IIf(IsNull(.Fields("IdUbicacion").Value), 1, .Fields("IdUbicacion").Value)
'                            '                     DatosStock.Fields("CantidadUnidades").Value = .Fields("Cantidad").Value * -1
'                            '                     DatosStock.Fields("IdUnidad").Value = .Fields("IdUnidad").Value
'                            '                     DatosStock.Fields("IdObra").Value = IIf(IsNull(.Fields("IdObra").Value), 0, .Fields("IdObra").Value)
'                            '                  End If
'                            '                  Resp = oDet.Guardar("Stock", DatosStock)
'                            '                  DatosStock.Close
'                        End If

'                    End If

'                    .MoveNext()

'                Loop

'            End If

'        End With

'        'Log
'        'oDet.Tarea("Log_InsertarRegistro", Array("RM", Remito.Fields(0).Value, 0, Now, 0, "Fin"))

'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetComplete()
'            End With
'        End If

'Salir:
'        Guardar = Resp
'        oRs = Nothing
'        DatosStock = Nothing
'        oDet = Nothing
'        oCont = Nothing
'        On Error GoTo 0
'        If lErr Then
'            Err.Raise(lErr, sSource, sDesc)
'        End If
'        Exit Function

'Mal:
'        If Not oCont Is Nothing Then
'            With oCont
'                If .IsInTransaction Then .SetAbort()
'            End With
'        End If
'        With Err()
'            lErr = .Number
'            sSource = .Source
'            sDesc = .Description
'        End With
'        'oDet.Tarea("Log_InsertarRegistro", Array("MTSRM", Remito.Fields(0).Value, 0, Now, 0, _
'        '      "Error " & Err.Number & Err.Description & ", " & Err.Source, _
'        '      "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
'        Resume Salir

'    End Function
'    Public Function OrdenesCompraImputadas() As String

'        Dim oC 'As DetRemito
'        Dim oSrv ' As InterFazMTS.iCompMTS
'        Dim oRs As ADODB.Recordset
'        Dim mOrdenes As String, mOrden As String

'        oSrv = CreateObject("MTSPronto.General")

'        'mOrdenes = ""
'        'For Each oC In mCol
'        '    With oC.Registro
'        '        If Not oC.Eliminado Then
'        '            If Not IsNull(.Fields("IdDetalleOrdenCompra").Value) Then
'        '                oRs = oSrv.TraerFiltrado("OrdenesCompra", "_DetallePorIdDetalle", .Fields("IdDetalleOrdenCompra").Value)
'        '                If oRs.RecordCount > 0 Then
'        '                    mOrden = "(" & IIf(IsNull(oRs.Fields("NumeroOrdenCompra").Value), 0, oRs.Fields("NumeroOrdenCompra").Value) & ")"
'        '                    If InStr(1, mOrdenes, mOrden) = 0 Then mOrdenes = mOrdenes & mOrden & ","
'        '                End If
'        '                oRs.Close()
'        '            End If
'        '        End If
'        '    End With
'        'Next

'        If Len(mOrdenes) > 0 Then mOrdenes = Mid(mOrdenes, 1, Len(mOrdenes) - 1)
'        OrdenesCompraImputadas = mOrdenes

'        oRs = Nothing
'        oSrv = Nothing

'    End Function


'End Module

'Public Module NotaDebito
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdNotaDeDebito As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetNotaDeDebitos", "TX_Req", IdNotaDeDebito))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function

'    Public Function ConvertirComProntoNotaDeDebitoAPuntoNET(ByVal oNotaDeDebito) As Pronto.ERP.BO.NotaDeDebito
'        Dim oDest As New Pronto.ERP.BO.NotaDeDebito

'        '///////////////////////////
'        '///////////////////////////
'        'ENCABEZADO
'        With oNotaDeDebito.Registro

'            oDest.Id = oNotaDeDebito.Id

'            oDest.Fecha = .Fields("FechaNotaDebito").Value
'            oDest.IdCliente = .Fields("IdCliente").Value

'            'oDest.TipoFactura = .Fields("TipoABC").Value

'            oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
'            oDest.Numero = .Fields("NumeroNotaDebito").Value


'            'oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
'            'oDest.Total = .Fields("ImporteTotal").Value
'            oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
'            'oDest.IdCodigoIVA = iisNull(.Fields("Idcodigoiva").Value, 0)

'            oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

'            'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
'            oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
'            oDest.ImporteTotal = .Fields("ImporteTotal").Value
'        End With


'        '///////////////////////////
'        '///////////////////////////
'        'DETALLE
'        Dim rsDet As ADODB.Recordset = oNotaDeDebito.DetNotasDebito.TraerTodos

'        With rsDet
'            If Not .EOF Then .MoveFirst()

'            Do While Not .EOF

'                Dim oDetNotaDeDebito = oNotaDeDebito.DetNotasDebito.Item(rsDet.Fields("IdDetalleNotaDebito"))

'                Dim item As New NotaDeDebitoItem


'                With oDetNotaDeDebito.Registro

'                    'item.IdConcepto = .Fields("IdConcepto").Value
'                    'item.Concepto = rsDet.Fields(3).Value
'                    item.ImporteTotalItem = .Fields("Importe").Value
'                    'item.gravado = .Fields("Gravado").Value
'                    'item.Precio = .Fields("IvaNoDiscriminado").Value
'                    'item.Precio = .Fields("PrecioUnitarioTotal").Value

'                End With

'                oDest.Detalles.Add(item)
'                .MoveNext()
'            Loop

'        End With


'        Return oDest
'    End Function
'End Module

'Public Module MigrarNotaCredito


'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdNotaDeCredito As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetNotaDeCreditos", "TX_Req", IdNotaDeCredito))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'    Public Sub AgregarImputacionSinAplicacionOPagoAnticipado(ByRef myNotaDeCredito As NotaDeCredito)
'        With myNotaDeCredito
'            'If mvarId > 0 Then
'            '    MsgBox("No puede modificar una nota de credito ya registrada!", vbCritical)
'            '    Exit Sub
'            'End If

'            'If Len(Trim(dcfields(0).BoundText)) = 0 Then
'            '    MsgBox("Falta completar el campo cliente", vbCritical)
'            '    Exit Sub
'            'End If

'            'If Len(Trim(txtNumeroNotaCredito.Text)) = 0 Then
'            '    MsgBox("Falta completar el campo numero de nota de credito", vbCritical)
'            '    Exit Sub
'            'End If


'            Dim oRs As ADODB.Recordset
'            Dim mvarDif As Double

'            RecalcularTotales(myNotaDeCredito)
'            mvarDif = Math.Round(.ImporteTotal - .TotalImputaciones, 2)

'            If mvarDif > 0 Then
'                Dim mItemImp As NotaDeCreditoImpItem = New NotaDeCreditoImpItem
'                mItemImp.Id = -1
'                mItemImp.Nuevo = True
'                mItemImp.IdImputacion = -1
'                mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "S/A"
'                mItemImp.FechaComprobanteImputado = Nothing
'                mItemImp.Importe = mvarDif
'                mvarDif = 0
'                .DetallesImp.Add(mItemImp)
'            End If

'            RecalcularTotales(myNotaDeCredito)
'        End With
'    End Sub


'End Module

'Public Module MigrarPedido
'    Public Function ItemEnOtrosPedidos(ByVal SC As String, ByVal myPedido As Pedido, ByVal IdItem As Long, ByVal Tipo As String) As String

'        Dim mResul As String
'        Dim oRs As ADODB.Recordset

'        If Tipo = "RM" Then
'            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetPedidos", "TX_BuscarItemRM", IdItem))
'        Else
'            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetPedidos", "TX_BuscarItemAco", IdItem))
'        End If

'        mResul = ""
'        With oRs
'            If .RecordCount > 0 Then
'                .MoveFirst()
'                Do While Not .EOF
'                    If .Fields("IdPedido").Value <> myPedido.Id Then
'                        mResul = mResul & " " & .Fields("NumeroPedido").Value & " - Item : " & .Fields("NumeroItem").Value & " - Cantidad : " & .Fields("Cantidad").Value & vbCrLf
'                    End If
'                    .MoveNext()
'                Loop
'            End If
'            .Close()
'        End With

'        oRs = Nothing

'        ItemEnOtrosPedidos = mResul

'    End Function
'End Module

'Public Module MigrarRecepcion
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetRecepciones", "TX_Req", IdComprobantePrv))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'End Module


'Public Module MigrarOrdenCompra
'    Public Function UltimoItemDetalle(ByVal SC As String, ByVal IdOrdenCompra As Long) As Integer

'        Dim oRs As ADODB.Recordset
'        Dim UltItem As Integer



'        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetOrdenCompras", "TX_Req", IdOrdenCompra))

'        If oRs.RecordCount = 0 Then
'            UltItem = 0
'        Else
'            oRs.MoveLast()
'            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
'        End If

'        oRs.Close()

'        'oRs = Me.Registros

'        If oRs.Fields.Count > 0 Then
'            If oRs.RecordCount > 0 Then
'                oRs.MoveFirst()
'                While Not oRs.EOF
'                    If Not oRs.Fields("Eliminado").Value Then
'                        If oRs.Fields("NumeroItem").Value > UltItem Then
'                            UltItem = oRs.Fields("NumeroItem").Value
'                        End If
'                    End If
'                    oRs.MoveNext()
'                End While
'            End If
'        End If

'        oRs = Nothing

'        UltimoItemDetalle = UltItem + 1

'    End Function
'End Module



