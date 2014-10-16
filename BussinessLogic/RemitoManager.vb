Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Diagnostics

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class RemitoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As RemitoList
            Return RemitoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As RemitoList
            Dim RemitoList As Pronto.ERP.BO.RemitoList = RemitoDB.GetListByEmployee(SC, IdSolicito)
            If RemitoList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        RemitoList.Sort(AddressOf Pronto.ERP.BO.RemitoList.CompareFecha)
                    Case "Obra"
                        RemitoList.Sort(AddressOf Pronto.ERP.BO.RemitoList.CompareObra)
                    Case "Sector"
                        RemitoList.Sort(AddressOf Pronto.ERP.BO.RemitoList.CompareSector)
                    Case Else 'Ordena por id
                        RemitoList.Sort(AddressOf Pronto.ERP.BO.RemitoList.CompareId)
                End Select
            End If
            Return RemitoList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return RemitoDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As Remito
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            For Each item As RemitoItem In GetCopyOfItem.Detalles
                item.Id = -1
            Next
        End Function

        

        Public Sub AsignaOrdenCompra()

            'Y ESTO????

            'Dim oF As frm_Aux
            '         Dim oL As ListItem
            '         Dim oDet 
            '         Dim oRs As adodb.Recordset
            '         Dim mIdDetalleOrdenCompra As Long, mIdObraDefault As Long, mIdObra As Long
            '         Dim mModeloDatos As String
            '         Dim mOk As Boolean
            '         Dim mAux1

            '         mModeloDatos = BuscarClaveINI("Modelo de datos para combo de ordenes de compra")
            '         If Len(mModeloDatos) = 0 Then mModeloDatos = "01"

            'Set oF = New frm_Aux
            'With oF
            '             .Caption = "Asignacion de item de orden de compra"
            '             .Text1.Visible = False
            '             .Label1.Caption = "Item O.Compra :"
            '             With .dcfields(0)
            '      .Left = oF.Text1.Left
            '      .Top = oF.Text1.Top
            '      .Width = oF.Text1.Width * 7
            '                 .BoundColumn = "IdDetalleOrdenCompra"
            '                 If Not IsNull(origen.Registro.Fields("IdCliente").Value) Then
            '                     .RowSource = Aplicacion.OrdenesCompra.TraerFiltrado("_ItemsPendientesDeRemitirPorIdClienteParaCombo", _
            '                                          Array(origen.Registro.Fields("IdCliente").Value, "F", mModeloDatos))
            '                 End If
            '                 .Visible = True
            '             End With
            '             .Width = .Width * 3
            '             .Show(vbModal, Me)
            '             mOk = .Ok
            '             If .Ok Then mIdDetalleOrdenCompra = .dcfields(0).BoundText
            '         End With
            'Unload oF
            'Set oF = Nothing
            '         If Not mOk Then Exit Sub

            '         mAux1 = TraerValorParametro2("IdObraDefault")
            '         mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)

            '         oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", mIdDetalleOrdenCompra)
            '         If oRs.RecordCount > 0 Then
            '             With origen.Registro
            '                 If mIdObraDefault = 0 Then
            '                     mIdObra = IIf(IsNull(oRs.Fields("IdObra").Value), mIdObraDefault, oRs.Fields("IdObra").Value)
            '                 Else
            '                     mIdObra = mIdObraDefault
            '                 End If
            '                 If Not IsNull(oRs.Fields("IdListaPrecios").Value) Then
            '                     .Fields("IdListaPrecios").Value = oRs.Fields("IdListaPrecios").Value
            '                 End If
            '                 If Not IsNull(oRs.Fields("IdDetalleClienteLugarEntrega").Value) Then
            '                     .Fields("IdDetalleClienteLugarEntrega").Value = oRs.Fields("IdDetalleClienteLugarEntrega").Value
            '                     dcfields(6).BoundText = oRs.Fields("IdDetalleClienteLugarEntrega").Value
            '                 End If
            '                 If Not IsNull(oRs.Fields("IdCondicionVenta").Value) Then
            '                     .Fields("IdCondicionVenta").Value = oRs.Fields("IdCondicionVenta").Value
            '                 End If
            '             End With
            '         End If
            '         oRs.Close()

            '         For Each oL In Lista.ListItems
            '             With oL
            '                 If .Selected Then
            '                     oDet = origen.DetRemitos.Item(.Tag)
            '                     With oDet
            '                         With .Registro
            '                             .Fields("IdDetalleOrdenCompra").Value = mIdDetalleOrdenCompra
            '                             .Fields("IdObra").Value = mIdObra
            '                         End With
            '                         .Modificado = True
            '                     End With
            '                     oDet = Nothing
            '                     .SmallIcon = "Modificado"
            '                 End If
            '             End With
            '         Next

            '         oRs = Nothing

        End Sub




        

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


            'Try
            'ds = GeneralDB.TraerDatos(SC, "wRemitos_T", -1)
            'Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "wRemitos_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdRemito").ColumnName = "Id"
                .Columns("Remito").ColumnName = "Numero"
                '.Columns("FechaRemito").ColumnName = "Fecha"
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
                If TX = "_DetallesPendientesDeFacturarPorIdCliente" Then
                    ds = GeneralDB.TraerDatos(SC, "Remitos_TX" & TX, Parametros)
                Else
                    ds = GeneralDB.TraerDatos(SC, "wRemitos_TX" & TX, Parametros)
                End If
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Remitos_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wRemitos_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Remitos_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Remito
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getRemitoDetalles As Boolean) As Remito
            Dim myRemito As Remito
            myRemito = RemitoDB.GetItem(SC, id)
            If Not (myRemito Is Nothing) AndAlso getRemitoDetalles Then
                myRemito.Detalles = RemitoItemDB.GetList(SC, id)
            End If
            Return myRemito
        End Function


        







        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As RemitoItemList
            Return RemitoItemDB.GetList(SC, id)
        End Function

        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myRemito As Remito)
            With myRemito
                'Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                'estos debieran ser READ only, no?
                '.IdCodigoIva = ocli.IdCodigoIva
                '.TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                .IdPuntoVenta = IdPuntoVentaComprobanteRemitoSegunSubnumeroYLetra(SC, .PuntoVenta)
                .Numero = RemitoManager.ProximoNumeroPorPuntoVentaOTalonario(SC, .IdPuntoVenta)

            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myRemito As Remito) As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                If Not IsValid(SC, myRemito) Then Return -1

                Dim esNuevo As Boolean
                If myRemito.Id = -1 Then esNuevo = True Else esNuevo = False
                If esNuevo Then
                    RefrescarTalonario(SC, myRemito)

                End If



                Dim RemitoId As Integer = RemitoDB.Save(SC, myRemito)


                '////////////////////////////////////////////////////
                '////////////////////////////////////////////////////
                'Incremento de número en capa de UI. Evitar.Fields("
                'esto es lo que está mal. no tenés que aumentarlo si es una edicion! -pero si está idRemito=-1! sí, pero puedo ser una alta a partir de una copia
                'cuando el usuario modifico manualmente el numero, o se está usando una copia de otro comprobante, por
                'más que sea un alta, no tenés que incrementar el numerador... -En Pronto pasa lo mismo!

                'If IdRemito = -1 And myRemito.SubNumero = 1 Then 'es un Remito nuevo y TAMBIEN empieza el subnumero
                'If IdRemito = -1 Then 'es un Remito nuevo y TAMBIEN empieza el subnumero
                '    If GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroRemito", TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroRemito") + 1) = -1 Then
                '        MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                '    End If
                'End If

                If esNuevo Then
                    Try
                        ClaseMigrar.AsignarNumeroATalonario(SC, myRemito.IdPuntoVenta, myRemito.Numero + 1)
                    Catch ex As Exception
                        'MsgBoxAjax(Me, "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.Message)
                        'Exit Function
                    End Try
                End If


                'For Each myRemitoItem As RemitoItem In myRemito.Detalles
                '    myRemitoItem.IdRemito = RemitoId
                '    RemitoItemDB.Save(myRemitoItem)
                'Next
                myRemito.Id = RemitoId
                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Return RemitoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                Debug.Print(ex.Message)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myRemito As Remito) As Boolean
            Return RemitoDB.Delete(SC, myRemito.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return RemitoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdRemito As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
            Dim myRemito As Pronto.ERP.BO.Remito = ClaseMigrar.GetItemComProntoRemito(SC, IdRemito, True)

            With myRemito
                .MotivoAnulacion = motivo
                .FechaAnulacion = Today
                .UsuarioAnulacion = IdUsuario
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                .Cumplido = "AN"
                .Anulado = "SI"
                .IdAutorizaAnulacion = IdUsuario

                For Each i As RemitoItem In .Detalles
                    With i
                        .Cumplido = "AN"
                        '.EnviarEmail = 1
                    End With
                Next


                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'reviso si hay facturas que esten imputadas al remito que se quiere anular
                Dim mFacturas As String
                mFacturas = ""
                Dim oRs As DataSet = RemitoManager.GetListTX(SC, "_FacturasPorIdRemito", IdRemito)
                For Each i As DataRow In oRs.Tables(0).Rows
                    mFacturas = mFacturas & i.Item("Factura") & vbCrLf
                Next

                oRs = Nothing
                If Len(mFacturas) > 0 Then
                    Return "El remito que quiere anular ya ha sido facturado en los comprobantes" & vbCrLf & _
                             mFacturas & "Anule primero las facturas y luego intente nuevamente"
                End If
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////


                RemitoManager.Save(SC, myRemito)
            End With



            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            'ajusto el stock
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            EntidadManager.Tarea(SC, "Remitos_AjustarStockRemitoAnulado", IdRemito)

            Dim oRs2 As DataSet = RemitoManager.GetListTX(SC, "_DetallesPorIdRemito", IdRemito)
            For Each i As DataRow In oRs2.Tables(0).Rows
                If Not IsNull(i.Item("IdArticulo")) Then
                    EntidadManager.Tarea(SC, "Articulos_RecalcularCostoPPP_PorIdArticulo", i.Item("IdArticulo"))
                End If
            Next
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////




            'Return RemitoDB.Anular(SC, IdRemito, IdUsuario, motivo)
        End Function



        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return RemitoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal SC As String, ByRef myRemito As Remito, Optional ByRef ms As String = "") As Boolean

            With myRemito

                Dim eliminados As Integer
                'verifico el detalle
                For Each det As RemitoItem In myRemito.Detalles
                    If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    '.TipoDesignacion = "CMP" 'esto hay que cambiarlo, no?
                    'If .TipoDesignacion = "" Then .TipoDesignacion = "S/D" 'esto hay que cambiarlo, no?
                    If det.Cumplido <> "SI" And det.Cumplido <> "AN" Then det.Cumplido = "NO"
                    '.Cumplido = IIf(.Cumplido = "SI", "SI", "NO") ' y qué pasa si es "AN"?


                    If det.Eliminado Then eliminados = eliminados + 1
                Next


                If .Detalles.Count = eliminados Or .Detalles.Count = 0 Then
                    ms = "La lista de items no puede estar vacía"
                    Return False
                End If


                If .ValorDeclarado < 0 Then
                    ms = "Debe indicar el valor declarado"
                    Return False
                End If



                Dim dc ' As DataCombo
                Dim dtp 'As DTPicker
                Dim est ' As EnumAcciones
                Dim mvarImprime As Integer
                Dim mvarNumero As Long
                Dim mvarErr As String, mvarAux1 As String, mvarAux2 As String, mvarAux3 As String, mvarAux4 As String
                Dim mvarAux5 As String, mvarArticulo1 As String, mvarArticulo As String
                Dim mvarCantidadUnidades As Double, mvarStock As Double, mvarStock1 As Double, mvarStock2 As Double
                Dim mvarCantConj As Double
                Dim mvarRegistrarStock As Boolean
                'Dim oRs As adodb.Recordset
                'Dim oRsStk As adodb.Recordset
                'Dim oRsAux As adodb.Recordset

                'If Not IsNumeric(dcfields(0).BoundText) And Not IsNumeric(dcfields(3).BoundText) Then
                '    MsgBox("No definio el destino")
                '    Exit Function
                'End If

                'If Len(txtTotal(0).Text) = 0 Then
                '    MsgBox("Debe indicar el valor declarado")
                '    Exit Function
                'End If

                'If Lista.ListItems.Count = 0 Then
                '    MsgBox("No se puede almacenar un Remito sin detalles")
                '    Exit Function
                'End If

                'If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
                '    MsgBox("Cliente inhabilitado", vbExclamation)
                '    Exit Function
                'End If

                'With origen.Registro
                '    For Each dtp In DTFields
                '        If ExisteCampo(origen.Registro, dtp.DataField) Then
                '            .Fields(dtp.DataField).Value = dtp.Value
                '        End If
                '    Next
                '    For Each dc In dcfields
                '        If dc.Enabled And dc.Visible And ExisteCampo(origen.Registro, dc.DataField) Then
                '            If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 7 Then
                '                MsgBox("Falta completar el campo " & dc.Tag, vbCritical)
                '                Exit Function
                '            End If
                '            If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
                '        End If
                '    Next
                'End With

                'If Not IsNumeric(dcfields(5).BoundText) And dcfields(5).Visible And mvarTransportistaConEquipos Then
                '    MsgBox("Debe ingresar el equipo de transporte", vbExclamation)
                '    Exit Function
                'End If

                'If BuscarClaveINI("Controlar la imputacion de varios ordenes de compra en un mismo remito de venta") = "SI" Then
                '    mvarAux1 = origen.DetRemitos.OrdenesCompraImputadas
                '    If InStr(1, mvarAux1, ",") <> 0 Then
                '        MsgBox("El remito imputa a mas de una nota de venta : " & mvarAux1, vbInformation)
                '    End If
                'End If

                'mvarAux1 = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock")
                'mvarAux2 = BuscarClaveINI("Inhabilitar stock negativo")
                'mvarAux3 = BuscarClaveINI("Inhabilitar stock global negativo")
                'mvarAux4 = BuscarClaveINI("Exigir orden de compra en remitos")
                'mvarAux5 = BuscarClaveINI("No permitir items en cero en remitos de venta")
                'mvarErr = ""
                'With origen.DetRemitos.Registros
                '    If .Fields.Count > 0 Then
                '        If .RecordCount > 0 Then
                '            .MoveFirst()
                '            Do While Not .EOF
                '                If Not .Fields("Eliminado").Value Then
                '                    If IsNull(.Fields("IdObra")) Then
                '                        mvarErr = mvarErr + "Hay items que no tienen indicada la obra" & vbCrLf
                '                        Exit Do
                '                    End If
                '                    If IsNull(.Fields("IdUbicacion")) And mvarAux1 <> "SI" Then
                '                        mvarErr = mvarErr + "Hay items que no tienen indicada la ubicacion" & vbCrLf
                '                        Exit Do
                '                    End If

                '                    mvarRegistrarStock = True
                '                    oRsStk = Aplicacion.Articulos.TraerFiltrado("_PorId", .Fields("IdArticulo"))
                '                    If oRsStk.RecordCount > 0 Then
                '                        If Not IsNull(oRsStk.Fields("RegistrarStock").Value) And oRsStk.Fields("RegistrarStock").Value = "NO" Then
                '                            mvarRegistrarStock = False
                '                        End If
                '                        mvarArticulo = IIf(IsNull(oRsStk.Fields("Descripcion").Value), "", oRsStk.Fields("Descripcion").Value)
                '                    End If
                '                    oRsStk.Close()

                '                    mvarCantidadUnidades = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
                '                    If mvarAux5 = "SI" And mvarCantidadUnidades <= 0 Then
                '                        MsgBox("El articulo " & mvarArticulo & ", tiene ingresado un item en cero", vbExclamation)
                '                        Exit Function
                '                    End If

                '                    If mvarRegistrarStock And (mvarAux2 = "SI" Or mvarAux3 = "SI") Then
                '                        mvarStock1 = 0
                '                        mvarStock2 = 0
                '                        If IIf(IsNull(.Fields("DescargaPorKit").Value), "NO", .Fields("DescargaPorKit").Value) = "NO" Then
                '                            oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockPorArticuloPartidaUnidadUbicacionObra", _
                '                                         Array(.Fields("IdArticulo").Value, IIf(IsNull(.Fields("Partida").Value), "", .Fields("Partida").Value), _
                '                                               .Fields("IdUnidad").Value, IIf(IsNull(.Fields("IdUbicacion").Value), 0, .Fields("IdUbicacion").Value), _
                '                                               .Fields("IdObra").Value))
                '                            If oRsStk.RecordCount > 0 Then
                '                                mvarStock1 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                '                                mvarArticulo = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                '                            End If
                '                            oRsStk.Close()
                '                            oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", .Fields("IdArticulo").Value)
                '                            If oRsStk.RecordCount > 0 Then
                '                                mvarStock2 = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                '                            End If
                '                            oRsStk.Close()
                '                            oRsStk = Nothing
                '                            If mvarId < 0 Then
                '                                If mvarAux3 <> "SI" And mvarStock1 < mvarCantidadUnidades Then
                '                                    MsgBox("El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                '                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                '                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                '                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock")
                '                                    Exit Function
                '                                End If
                '                                If mvarStock2 < mvarCantidadUnidades Then
                '                                    MsgBox("El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & _
                '                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock")
                '                                    Exit Function
                '                                End If
                '                            Else
                '                                oRsStk = Aplicacion.TablasGenerales.TraerUno("DetRemitos", .Fields(0).Value)
                '                                mvarStock = 0
                '                                If oRsStk.RecordCount > 0 Then
                '                                    mvarStock = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                '                                End If
                '                                oRsStk.Close()
                '                                oRsStk = Nothing
                '                                If mvarAux3 <> "SI" And mvarStock1 < mvarCantidadUnidades - mvarStock Then
                '                                    MsgBox("El articulo " & mvarArticulo & ", tiene" & vbCrLf & _
                '                                             "stock insuficiente segun datos ingresados :" & vbCrLf & _
                '                                             "cantidad actual en stock para la partida, unidad, ubicacion y obra : " & mvarStock1 & vbCrLf & _
                '                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock")
                '                                    Exit Function
                '                                End If
                '                                If mvarStock2 < mvarCantidadUnidades - mvarStock Then
                '                                    MsgBox("El articulo " & mvarArticulo & ", tiene stock insuficiente" & vbCrLf & _
                '                                             "cantidad total actual en stock : " & mvarStock2, vbExclamation, "Sin stock")
                '                                    Exit Function
                '                                End If
                '                            End If
                '                        Else
                '                            oRsAux = Aplicacion.Conjuntos.TraerFiltrado("_DetallesPorIdArticulo", .Fields("IdArticulo").Value)
                '                            If oRsAux.RecordCount > 0 Then
                '                                oRsAux.MoveFirst()
                '                                Do While Not oRsAux.EOF
                '                                    mvarCantConj = IIf(IsNull(oRsAux.Fields("Cantidad").Value), 0, oRsAux.Fields("Cantidad").Value)
                '                                    oRsStk = Aplicacion.Articulos.TraerFiltrado("_StockTotalPorArticulo", oRsAux.Fields("IdArticulo").Value)
                '                                    mvarStock = 0
                '                                    mvarArticulo1 = ""
                '                                    If oRsStk.RecordCount > 0 Then
                '                                        mvarStock = IIf(IsNull(oRsStk.Fields("Stock").Value), 0, oRsStk.Fields("Stock").Value)
                '                                        mvarArticulo1 = IIf(IsNull(oRsStk.Fields("Articulo").Value), "", oRsStk.Fields("Articulo").Value)
                '                                    End If
                '                                    oRsStk.Close()
                '                                    If mvarId < 0 Then
                '                                        If mvarStock < mvarCantidadUnidades * mvarCantConj Then
                '                                            oRsAux = Nothing
                '                                            oRsStk = Nothing
                '                                            MsgBox("El articulo " & mvarArticulo1 & vbCrLf & _
                '                                                     "que es parte del kit " & mvarArticulo & vbCrLf & _
                '                                                     "dejaria el stock negativo, reingrese", vbExclamation)
                '                                            Exit Function
                '                                        End If
                '                                    Else
                '                                        oRsStk = Aplicacion.TablasGenerales.TraerUno("DetSalidasMateriales", .Fields(0).Value)
                '                                        mvarStock1 = 0
                '                                        If oRsStk.RecordCount > 0 Then
                '                                            mvarStock1 = IIf(IsNull(oRsStk.Fields("Cantidad").Value), 0, oRsStk.Fields("Cantidad").Value)
                '                                        End If
                '                                        oRsStk.Close()
                '                                        If mvarStock < (mvarCantidadUnidades * mvarCantConj) - (mvarStock1 * mvarCantConj) Then
                '                                            oRsAux = Nothing
                '                                            oRsStk = Nothing
                '                                            MsgBox("El articulo " & mvarArticulo1 & vbCrLf & _
                '                                                     "que es parte del kit " & mvarArticulo & vbCrLf & _
                '                                                     "dejaria el stock negativo, reingrese", vbExclamation)
                '                                            Exit Function
                '                                        End If
                '                                    End If
                '                                    oRsAux.MoveNext()
                '                                Loop
                '                            End If
                '                            oRsAux.Close()
                '                        End If
                '                        oRsAux = Nothing
                '                        oRsStk = Nothing
                '                    End If

                '                    If mvarAux4 = "SI" Then
                '                        If IsNull(.Fields("IdDetalleOrdenCompra").Value) Then
                '                            MsgBox("El articulo " & mvarArticulo & ", no tiene asignado un item de orden de compra del cliente", vbExclamation, "Sin stock")
                '                            Exit Function
                '                        End If
                '                    End If
                '                End If
                '                .MoveNext()
                '            Loop
                '        End If
                '    End If
                'End With

                If Len(mvarErr) Then
                    MsgBox("Errores encontrados :" & vbCrLf & mvarErr, vbExclamation)
                    Exit Function
                End If

                Return True
            End With

        End Function

        Public Shared Function ProximoNumeroPorPuntoVentaOTalonario(ByVal SC As String, ByVal IdPuntoVenta As Integer) As Integer
            Return EntidadManager.ProximoNumeroPorIdPuntoVenta(SC, IdPuntoVenta)
        End Function

        Public Shared Sub AsignarNumeroPorIdPuntoVentaOTalonario(ByVal SC As String, ByVal IdPuntoVenta As Integer, ByVal numero As Long)
            ClaseMigrar.AsignarNumeroATalonario(SC, IdPuntoVenta, numero)
        End Sub

        Shared Function IdPuntoVentaComprobanteRemitoSegunSubnumeroYLetra(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Remito)
            Return mvarPuntoVenta
        End Function

        

        Public Shared Function UltimoItemDetalle(ByVal myRemito As Remito) As Integer

            For Each i As RemitoItem In myRemito.Detalles
                If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function


        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////

        Public Shared Function RecalculaItem(ByVal Cantidad As Double, ByVal PrecioUnitario As Double, ByVal PorcentajeBonificacion As Double, ByVal PorcentajeIVA As Double) As Double
            Dim mImporte = Cantidad * PrecioUnitario
            Dim mBonificacion = Math.Round(mImporte * Val(PorcentajeBonificacion) / 100, 4)
            Dim mIVA = Math.Round((mImporte - mBonificacion) * Val(PorcentajeIVA) / 100, 4)
            Dim total = mImporte - mBonificacion + mIVA

            Return total
        End Function



        Public Shared Sub RecalcularTotales(ByRef myRemito As Remito)


            Dim mvarSubTotal, mvarIVA1 As Single

            With myRemito


                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                .TotalBonifEnItems = 0
                .ImporteIva1 = 0


                For Each det As RemitoItem In .Detalles
                    With det
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
                        .ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        .ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        .ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                        '////////////////////////


                        '////////////////////////
                        'Sumador de totales
                        mvarSubTotal += mImporte
                        myRemito.TotalBonifEnItems += .ImporteBonificacion
                        mvarIVA1 += .ImporteIVA
                        '////////////////////////
                    End With
                Next


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .ImporteIva1 = mvarIVA1
                .Total = .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With

        End Sub








    End Class
End Namespace