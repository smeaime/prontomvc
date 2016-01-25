Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ComprobantePrvManagerFondoFijo
        Inherits ServicedComponent






        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myComprobantePrv As ComprobanteProveedor, Optional ByVal sError As String = "") As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            'Try




            Dim esNuevo As Boolean
            If myComprobantePrv.Id = -1 Then esNuevo = True Else esNuevo = False

            If esNuevo Then
                'RefrescarTalonario(SC, myComprobantePrv)
            End If



            Dim ComprobantePrvId As Integer = ComprobanteProveedorDB.Save(SC, myComprobantePrv)



            'For Each myComprobantePrvItem As ComprobanteProveedorItem In myComprobantePrv.Detalles
            '    myComprobantePrvItem.IdComprobantePrv = ComprobantePrvId
            '    ComprobantePrvItemDB.Save(myComprobantePrvItem)
            'Next


            Guardar_CodigoOriginalDeVB6(SC, myComprobantePrv)

            myComprobantePrv.Id = ComprobantePrvId




            'myTransactionScope.Complete()
            'ContextUtil.SetComplete()
            Return ComprobantePrvId




            'Catch ex As Exception
            '    'ContextUtil.SetAbort()
            '    ErrHandler2.WriteError(ex)
            '    'Debug.Print(ex.Message)
            '    Return -1
            'Finally
            '    'CType(myTransactionScope, IDisposable).Dispose()
            'End Try
        End Function



        Private Shared Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor)
            '            'todo esto estaba en el mts



            Dim oCont 'As ObjectContext
            Dim oDet As ICompMTSManager
            Dim Resp ' As InterFazMTS.MisEstados
            Dim lErr As Long, sSource As String, sDesc As String
            Dim Datos As DataTable
            Dim DatosAnt As DataTable
            Dim DatosCtaCte As DataTable
            Dim DatosCtaCteNv As DataTable
            Dim DatosCliente As Cliente
            Dim oRsValores As DataTable
            Dim oRsValoresNv As DataTable
            Dim oRsComp As DataTable
            Dim DatosAsiento As DataTable
            Dim DatosAsientoNv As DataTable
            Dim oRsParametros As DataRow
            Dim DatosDetAsiento As DataTable
            Dim DatosDetAsientoNv As DataTable
            Dim oRsAux As DataTable
            Dim oFld As ADODB.Field
            Dim i As Integer
            Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
            Dim mIdDetalleComprobantePrv As Long, mIdValor As Long, mvarIdCuenta As Long
            Dim mIdDetalleComprobantePrvValores As Long, mvarIdMonedaPesos As Long
            Dim mvarIdDetalleComprobantePrvCuentas As Long, mvarIdBanco As Long
            Dim Tot As Decimal, TotDol As Decimal, Sdo As Decimal, SdoDol As Decimal
            Dim mPagadoParteEnDolares As Double, mDeudores As Double, mvarCotizacion As Double
            Dim mvarCotizacionMoneda As Double, mvarCotizacionMonedaAnt As Double
            Dim mvarDebe As Double, mvarHaber As Double
            Dim mvarProcesa As Boolean, mvarLlevarAPesosEnValores As Boolean
            Dim mvarBorrarEnValores As Boolean, mvarAnulada As Boolean
            Dim mvarEsCajaBanco As String



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
        Public Shared Function GetListDataset(ByVal SC As String, ByVal dtDesde As Date, ByVal dtHasta As Date) As DataTable



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            'Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With



            Dim dt = EntidadManager.GetStoreProcedure(SC, enumSPs.ComprobantesProveedores_TXFecha, dtDesde, dtHasta, -1)


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With dt
                .Columns("IdComprobanteProveedor").ColumnName = "Id"
                '.Columns("ComprobantePrv").ColumnName = "Numero"
                '.Columns("FechaComprobantePrv").ColumnName = "Fecha"
            End With


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
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getComprobantePrvDetalles As Boolean) As ComprobanteProveedor
            Dim myComprobantePrv As ComprobanteProveedor
            myComprobantePrv = ComprobanteProveedorDB.GetItem(SC, id)

            If Not (myComprobantePrv Is Nothing) AndAlso getComprobantePrvDetalles Then
                'traigo el detalle
                myComprobantePrv.Detalles = ComprobanteProveedorItemDB.GetList(SC, id)
                myComprobantePrv.DetallesProvincias = ComprobanteProveedorProvinciasItemDB.GetList(SC, id)


                TraerDatosDesnormalizados(SC, myComprobantePrv)


            End If

            Return myComprobantePrv
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



        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorItemList
            'Dim list As ComprobanteProveedorItemList = ComprobantePrvItemDB.GetList(SC, id)
            'For Each i As ComprobanteProveedorItem In list
            '    If i.IdImputacion > 0 Then
            '        Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
            '        i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
            '        i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
            '    End If
            'Next
            'Return list
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
                    If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1

                Next



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
                ErrHandler2.WriteError(ex)
                Return -1
            End Try

        End Function

        Shared Function IdPuntoVentaComprobanteComprobantePrvSegunSubnumero(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.ComprobantePrv)
            Return mvarPuntoVenta
        End Function

        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdComprobantePrv As Long) As Integer

            Dim oRs As ADODB.Recordset
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
            '    txtNumeroComprobantePrv2.Text = ComprobantePrvManager.ProximoNumeroComprobantePrvPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.Text) 'ParametroOriginal(SC, "ProximoFactura")
            'End If
        End Sub





        Public Function GuardarRegistroContable(ByVal RegistroContable As adodb.Recordset)

            Dim oCont ' As ObjectContext
            Dim oDet 'As iCompMTS
            Dim Resp 'As InterFazMTS.MisEstados
            Dim oRsComprobante As ADODB.Recordset
            Dim Datos As ADODB.Recordset
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

            'oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto
            'If oCont Is Nothing Then
            '    'CreateObject("MTSPronto.General") dfgh
            'Else
            '    oDet = oCont.CreateInstance("MTSPronto.General")
            'End If

            mvarCotizacionMoneda = 0
            mvarDebe = 0
            mvarHaber = 0

            'With RegistroContable
            '    If .State <> adStateClosed Then
            '        If .RecordCount > 0 Then
            '            .Update()
            '            .MoveFirst()
            '            oRsComprobante = oDet.LeerUno("ComprobantePrvs", RegistroContable.Fields("IdComprobante").Value)
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
            '            Datos = CreateObject("adodb.Recordset")
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
            Dim oRsDetCtas As ADODB.Recordset
            Dim oRsAux As ADODB.Recordset
            Dim oFld As ADODB.Field
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

            ' oSrv = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            oRs = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)

        End Sub

        Public Shared Function RecalcularRegistroContable(ByVal SC As String, ByRef ComprobantePrv As ComprobanteProveedor) As DataTable

            Dim oRsCont As DataTable
            Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
            Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
            Dim mvarCliente As Double
            Dim mvarCuentaCliente As Long

            IsValid(SC, ComprobantePrv) 'para marcar los vacios

            mvarCuentaClienteMonedaLocal = 0
            mvarCuentaClienteMonedaExtranjera = 0
            mvarCliente = 0


            Return oRsCont


        End Function














        Public Shared Sub RecalcularTotales(ByRef myComprobantePrv As ComprobanteProveedor)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myComprobantePrv


                RefrescaTalonarioIVA(myComprobantePrv)




                Dim i As Integer
                Dim oRs As ADODB.Recordset






            End With
        End Sub

        Sub refrescar()
            '    RefrescarNumeroTalonario()
            '    refrescartotales()
            '    refrescarRegistroContable()
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


                Dim oRs As ADODB.Recordset
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