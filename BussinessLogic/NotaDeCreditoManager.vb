Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Diagnostics
Imports Pronto.ERP.Bll.EntidadManager


Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class NotaDeCreditoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As NotaDeCreditoList
            Return NotaDeCreditoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As NotaDeCredito
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            For Each item As NotaDeCreditoItem In GetCopyOfItem.Detalles
                item.Id = -1
            Next
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As NotaDeCreditoList
            Dim NotaDeCreditoList As Pronto.ERP.BO.NotaDeCreditoList = NotaDeCreditoDB.GetListByEmployee(SC, IdSolicito)
            If NotaDeCreditoList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        NotaDeCreditoList.Sort(AddressOf Pronto.ERP.BO.NotaDeCreditoList.CompareFecha)
                    Case "Obra"
                        NotaDeCreditoList.Sort(AddressOf Pronto.ERP.BO.NotaDeCreditoList.CompareObra)
                    Case "Sector"
                        NotaDeCreditoList.Sort(AddressOf Pronto.ERP.BO.NotaDeCreditoList.CompareSector)
                    Case Else 'Ordena por id
                        NotaDeCreditoList.Sort(AddressOf Pronto.ERP.BO.NotaDeCreditoList.CompareId)
                End Select
            End If
            Return NotaDeCreditoList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return NotaDeCreditoDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With

            ds = GeneralDB.TraerDatos(SC, "NotasCredito_TT")

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wNotaDeCreditos_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "NotasCredito_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdNotaCredito").ColumnName = "Id"
                .Columns("Nota credito").ColumnName = "Numero"
                '.Columns("FechaNotaDeCredito").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

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
                ds = GeneralDB.TraerDatos(SC, "wNotaDeCreditos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "NotaDeCreditos_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wNotaDeCreditos_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "NotaDeCreditos_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function




        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, Optional ByVal getNotaDeCreditoDetalles As Boolean = False) As NotaDeCredito



            'NombreCliente()
            'codigocliente()
            'direccion =
            '                    Localidad =
            '                    cuit
            'condicionIVA()
            'condicionventa()

            'porciva?

            Dim myNotaDeCredito As NotaDeCredito
            myNotaDeCredito = NotaDeCreditoDB.GetItem(SC, id)
            If Not (myNotaDeCredito Is Nothing) AndAlso getNotaDeCreditoDetalles Then

                '  myNotaDeCredito.Cliente = ClienteManager.GetItem(SC, myNotaDeCredito.IdCliente)
                myNotaDeCredito.CondicionVenta_Descripcion = NombreCondicionVenta_y_Compra(SC, myNotaDeCredito.IdCondicionVenta)
                myNotaDeCredito.CondicionIVADescripcion = NombreCondicionIVA(SC, myNotaDeCredito.IdCodigoIva)

                myNotaDeCredito.Detalles = NotaDeCreditoItemDB.GetList(SC, id)
                myNotaDeCredito.DetallesImp = NotaDeCreditoImpItemDB.GetList(SC, id)
                myNotaDeCredito.DetallesOC = NotaDeCreditoOCItemDB.GetList(SC, id)
                'myNotaDeCredito.DetallesProvincias = NotaDeCreditoProvinciasItemDB.GetList(SC, id)

                TraerDatosDesnormalizados(SC, myNotaDeCredito)
            End If
            Return myNotaDeCredito
        End Function

        Private Shared Sub TraerDatosDesnormalizados(ByVal SC As String, ByRef myNotaDeCredito As NotaDeCredito)
            With myNotaDeCredito

                'traigo las descripciones de los items
                For Each i As NotaDeCreditoItem In .Detalles
                    i.Concepto = EntidadManager.NombreConcepto(SC, i.IdConcepto)
                Next


                If Not IsNothing(.DetallesImp) Then
                    For Each i As NotaDeCreditoImpItem In .DetallesImp
                        If i.IdImputacion > 0 Then
                            Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
                            i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
                            i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
                        Else
                            i.TipoComprobanteImputado = "PA" 'pagoanticipado
                        End If
                    Next
                End If







                'tendría que traer los datos del mismo sp que usa el Pronto para llenar la grilla
                'Dim DetOC = OrdenCompraItemDB.GetItem(SC, i.IdDetalleOrdenCompra)
                Dim dt = EntidadManager.TraerFiltrado(SC, enumSPs.DetNotasCreditoOC_TXCre, .Id)

                If Not IsNothing(.DetallesOC) Then
                    For Each i As NotaDeCreditoOCItem In .DetallesOC
                        Dim dr As DataRow
                        Try
                            dr = DataTableWHERE(dt, "IdDetalleNotaCreditoOrdenesCompra=" & i.Id).Rows(0)
                        Catch ex As Exception
                            Continue For
                        End Try


                        'encabezado
                        i.NumeroOrdenCompra = dr.Item("O_Compra")
                        i.NumeroOrdenCompraCliente = dr.Item("O_C_(Cli_)")
                        i.Obra = dr.Item("Obra")

                        'item
                        i.ItemOC = dr.Item("Item")
                        i.Articulo = dr.Item("Articulo")
                        i.Unidad = dr.Item("Unidad")
                        i.Precio = dr.Item("Precio")
                        i.Importe = dr.Item("Importe")
                        i.Pendiente = dr.Item("Pendiente")
                    Next
                End If


            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As NotaDeCreditoItemList
            Return NotaDeCreditoItemDB.GetList(SC, id)
        End Function


        



        


        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myNotaDeCredito As NotaDeCredito)
            With myNotaDeCredito
                Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                'estos debieran ser READ only, no?
                .IdCodigoIva = ocli.IdCodigoIva
                .TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                .IdPuntoVenta = EntidadManager.IdPuntoVentaComprobanteSegunSubnumeroYLetra(SC, .PuntoVenta, .TipoABC, EntidadManager.IdTipoComprobante.NotaCredito)
                .Numero = ProximoNumeroNotaCreditoPorIdCodigoIvaYNumeroDePuntoVenta(SC, .IdCodigoIva, .PuntoVenta)
                '.Numero = ProximoNumeroFactura(SC, myFactura.IdPuntoVenta)
            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeCredito As NotaDeCredito, Optional ByVal sError As String = "") As Integer
            With myNotaDeCredito
                'Dim myTransactionScope As TransactionScope = New TransactionScope
                Try

                    Dim esNuevo As Boolean
                    If myNotaDeCredito.Id = -1 Then esNuevo = True Else esNuevo = False

                    If esNuevo Then
                        RefrescarTalonario(SC, myNotaDeCredito)
                    End If


                    Dim NotaDeCreditoId As Integer = NotaDeCreditoDB.Save(SC, myNotaDeCredito)
                    'For Each myNotaDeCreditoItem As NotaDeCreditoItem In myNotaDeCredito.Detalles
                    '    myNotaDeCreditoItem.IdNotaDeCredito = NotaDeCreditoId
                    '    NotaDeCreditoItemDB.Save(myNotaDeCreditoItem)
                    'Next






                    If .Id = -1 Then
                        Try
                            If .CtaCte = "NO" Then
                                'hay dos talonarios (interno y externo). Uno se maneja
                                'por la tabla Parametros, y el otro por el PuntosVe
                                ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximaNotaDebitoInterna", ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaNotaDebitoInterna") + 1)
                            Else
                                ClaseMigrar.AsignarNumeroATalonario(SC, .IdPuntoVenta, .Numero + 1)



                            End If
                        Catch ex As Exception
                            sError = "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.Message
                            Exit Function
                        End Try
                    End If


                    .Id = NotaDeCreditoId
                    'myTransactionScope.Complete()
                    'ContextUtil.SetComplete()
                    Return NotaDeCreditoId
                Catch ex As Exception
                    'ContextUtil.SetAbort()
                    Debug.Print(ex.Message)
                    Return -1
                Finally
                    'CType(myTransactionScope, IDisposable).Dispose()
                End Try
            End With
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myNotaDeCredito As NotaDeCredito) As Boolean
            Return NotaDeCreditoDB.Delete(SC, myNotaDeCredito.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return NotaDeCreditoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdNotaDeCredito As Integer) As Integer
            Return NotaDeCreditoDB.Anular(SC, IdNotaDeCredito)
        End Function
        Public Shared Function Anular(ByVal SC As String, ByVal Id As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
            Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = GetItem(SC, Id, True)

            With myNotaDeCredito
                .MotivoAnulacion = motivo
                .FechaAnulacion = Today
                .UsuarioAnulacion = IdUsuario
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                '.Cumplido = "AN"
                .anulada = "SI"
                '.IdAutorizaAnulacion = IdUsuario

                For Each i As NotaDeCreditoItem In .Detalles
                    With i
                        '.Cumplido = "AN"
                        '.EnviarEmail = 1
                    End With
                Next






                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'TO DO: No encontré el campo CAE en la nota de debito
                If iisNull(.CAE, "") <> "" Then
                    Return "No puede anular un comprobante electronico (CAE)"
                End If



                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'reviso si hay facturas que esten imputadas al remito que se quiere anular
                Dim dr As DataRow
                Try
                    dr = EntidadManager.GetStoreProcedureTop1(SC, "CtasCtesD_TX_BuscarComprobante", Id, EntidadManager.IdTipoComprobante.NotaDebito)
                Catch ex As Exception

                End Try

                If Not IsNothing(dr) Then
                    If dr.Item("ImporteTotal") <> dr.Item("Saldo") Then
                        Return "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse"
                    End If
                End If

                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////


                Save(SC, myNotaDeCredito)
            End With


        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return NotaDeCreditoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal SC As String, ByVal myNotaDeCredito As NotaDeCredito, Optional ByRef ms As String = "") As Boolean

            With myNotaDeCredito

                RecalcularTotales(myNotaDeCredito)


                Dim eliminados As Integer
                'verifico el detalle
                For Each det As NotaDeCreditoItem In myNotaDeCredito.Detalles
                    If det.IdConcepto = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1
                Next



                If myNotaDeCredito.Detalles.Count = eliminados Or myNotaDeCredito.Detalles.Count = 0 Then
                    ms = "La lista de conceptos no puede estar vacía"
                    Return False
                End If

                If .DetallesImp.Count = eliminados Or .DetallesImp.Count = 0 Then
                    ms = "La lista de imputaciones no puede estar vacía"
                    Return False
                End If

                If Math.Round(.ImporteTotal, 2) <> Math.Round(.TotalImputaciones, 2) Then
                    ms = "La suma de conceptos debe ser igual a la de imputaciones"
                    Return False
                End If

                'If DTFields(0).Value <= gblFechaUltimoCierre And _
                'Not AccesoHabilitado(Me.OpcionesAcceso, DTFields(0).Value) Then
                '    MsgBox("La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation)
                '    Exit Function
                'End If

                'Dim mIdObra As Integer, mIdProvinciaDestino As Integer
                'If mvarId > 0 Then
                '    If Len(dcfields(1).Text) = 0 Or Not IsNumeric(dcfields(1).BoundText) Then
                '        mIdObra = -1
                '    Else
                '        mIdObra = dcfields(1).BoundText
                '    End If
                '    mIdProvinciaDestino = -1

                '    If Check3.Value = 1 Then
                '        origen.Registro.Fields("NoIncluirEnCubos").Value = "SI"
                '    Else
                '        origen.Registro.Fields("NoIncluirEnCubos").Value = Null
                '    End If
                '    Aplicacion.Tarea("NotasCredito_ActualizarCampos", _
                '          Array(mvarId, mIdProvinciaDestino, mIdObra, origen.Registro.Fields("NoIncluirEnCubos").Value, rchObservaciones.Text))
                '    Unload(Me)
                '    Exit Function
                'End If

                'If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
                '    oRs = Aplicacion.NotasCredito.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
                '    If oRs.RecordCount > 0 Then
                '        If oRs.Fields("FechaNotaCredito").Value > DTFields(0).Value Then
                '            MsgBox("La fecha de la ultima nota de credito es " & oRs.Fields("FechaNotaCredito").Value & ", modifiquela", vbExclamation)
                '            oRs.Close()
                '            oRs = Nothing
                '            Exit Function
                '        End If
                '    End If
                '    oRs.Close()
                '    oRs = Nothing
                'End If

                'If EstadoEntidad(SC, "Clientes", .IdCliente) = "INACTIVO" Then
                '    ms = "Cliente inhabilitado"
                '    Exit Function
                'End If

                Return True
            End With
        End Function


        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdNotaDeCredito As Long) As Integer

            Dim oRs As adodb.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetNotaDeCreditos", "TX_Req", IdNotaDeCredito))

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

        Public Shared Function UltimoItemDetalle(ByVal myNotaDeCredito As NotaDeCredito) As Integer

            For Each i As NotaDeCreditoItem In myNotaDeCredito.Detalles
                'If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function



        Public Shared Function ProximoNumeroNotaCreditoPorIdCodigoIvaYNumeroDePuntoVenta(ByVal SC As String, ByVal IdCodigoIva As Integer, ByVal NumeroDePuntoVenta As Integer) As Long

            Try
                'averiguo la letra
                Dim Letra = EntidadManager.LetraSegunTipoIVA(IdCodigoIva)

                'averiguo el id del talonario 
                Dim IdPuntoVenta = EntidadManager.IdPuntoVentaComprobanteSegunSubnumeroYLetra(SC, NumeroDePuntoVenta, Letra, EntidadManager.IdTipoComprobante.NotaCredito)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Return -1
            End Try

        End Function



        Public Shared Sub RecalcularTotales(ByRef myNotaDeCredito As NotaDeCredito)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myNotaDeCredito


                ' Dim oRs As adodb.Recordset
                ' Dim oL As ListItem
                ' Dim i As Integer, mIdProvinciaIIBB As Integer
                ' Dim TSumaGravado As Double, TSumaNoGravado As Double, mTopeIIBB As Double, mImporteItem As Double
                ' Dim mvarIVANoDiscriminadoItem As Double
                ' Dim mFecha1 As Date

                ' mvarSubTotal = 0
                ' mvarMultilateral = "NO"
                ' mvarIBrutos = 0
                ' mvarIBrutos2 = 0
                ' mvarIBrutos3 = 0
                ' mvarPorcentajeIBrutos = 0
                ' mvarPorcentajeIBrutos2 = 0
                ' mvarPorcentajeIBrutos3 = 0
                ' mvar_IBrutos_Cap = 0
                ' mvar_IBrutos_BsAs = 0
                ' mvar_IBrutos_BsAsM = 0
                ' mvarIVA1 = 0
                ' mvarIVA2 = 0
                ' mvarTotalNotaDebito = 0
                ' mvarIVANoDiscriminado = 0
                ' mvarPercepcionIVA = 0

                'TSumaGravado = SumaImporteGravado()
                'TSumaNoGravado = SumaImporteNoGravado()
                'mvarSubTotal = TSumaGravado + TSumaNoGravado

                RefrescaTalonarioIVA(myNotaDeCredito)

                ' oRs = origen.DetNotasDebito.Registros
                ' If oRs.Fields.Count > 0 Then
                '     If oRs.RecordCount > 0 Then
                '         oRs.MoveFirst()
                '         Do While Not oRs.EOF
                '             If Not oRs.Fields("Eliminado").Value Then
                '                 With origen.DetNotasDebito.Item(oRs.Fields(0).Value).Registro
                '                     .Fields("IVANoDiscriminado").Value = 0
                '                     If Not IsNull(.Fields("Gravado").Value) Then
                '                         If .Fields("Gravado").Value = "SI" Then
                '                             If mvarTipoABC = "B" Then
                '                                 mImporteItem = IIf(IsNull(.Fields("Importe").Value), 0, .Fields("Importe").Value)
                '                                 mvarIVANoDiscriminadoItem = Round(mImporteItem - (mImporteItem / (1 + (Val(txtPorcentajeIva1.Text) / 100))), 2)
                '                                 .Fields("IVANoDiscriminado").Value = mvarIVANoDiscriminadoItem
                '                                 mvarIVANoDiscriminado = mvarIVANoDiscriminado + mvarIVANoDiscriminadoItem
                '                             End If
                '                         End If
                '                     End If
                '                 End With
                '             End If
                '             oRs.MoveNext()
                '         Loop
                '     End If
                ' End If
                ' oRs = Nothing

                ' If Option5.Value Then
                '     If mvarId < 0 Then
                '         If mvarEsAgenteRetencionIVA = "NO" And TSumaGravado >= mvarBaseMinimaParaPercepcionIVA Then
                '             mvarPercepcionIVA = Round(TSumaGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
                '         End If
                '     Else
                '         mvarPercepcionIVA = IIf(IsNull(origen.Registro.Fields("PercepcionIVA").Value), 0, origen.Registro.Fields("PercepcionIVA").Value)
                '     End If

                '     If dcfields(4).Enabled And IsNumeric(dcfields(4).BoundText) And Check1(0).Value = 1 Then
                '         If mvarId < 0 Then
                '             oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)
                '             If oRs.RecordCount > 0 Then
                '                 mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '                 mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                'mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
                '                 If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '                       DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '                     'mAlicuotaDirecta <> 0 And
                '                     mvarPorcentajeIBrutos = mAlicuotaDirecta
                '                 Else
                '                     If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                         If mvarIBCondicion = 2 Then
                '                             mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                             mvarMultilateral = "SI"
                '                         Else
                '                             mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                         End If
                '                     End If
                '                 End If
                '                 mvarIBrutos = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
                '             End If
                '             oRs.Close()
                '             oRs = Nothing
                '         Else
                '             mvarIBrutos = origen.Registro.Fields("RetencionIBrutos1").Value
                '             mvarPorcentajeIBrutos = origen.Registro.Fields("PorcentajeIBrutos1").Value
                '         End If
                '     Else
                '         If mvarId > 0 Then
                '             mvarIBrutos = origen.Registro.Fields("RetencionIBrutos1").Value
                '             mvarPorcentajeIBrutos = origen.Registro.Fields("PorcentajeIBrutos1").Value
                '         End If
                '     End If

                '     If dcfields(5).Enabled And IsNumeric(dcfields(5).BoundText) And Check1(1).Value = 1 Then
                '         If mvarId < 0 Then
                '             oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
                '             If oRs.RecordCount > 0 Then
                '                 mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '                 mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                'mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
                '                 If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '                       DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '                     'mAlicuotaDirecta <> 0 And
                '                     mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                '                 Else
                '                     If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                         If mvarIBCondicion = 2 Then
                '                             mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                             mvarMultilateral = "SI"
                '                         Else
                '                             mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                         End If
                '                     End If
                '                 End If
                '                 mvarIBrutos2 = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
                '             End If
                '             oRs.Close()
                '             oRs = Nothing
                '         Else
                '             mvarIBrutos2 = origen.Registro.Fields("RetencionIBrutos2").Value
                '             mvarPorcentajeIBrutos2 = origen.Registro.Fields("PorcentajeIBrutos2").Value
                '         End If
                '     Else
                '         If mvarId > 0 Then
                '             mvarIBrutos2 = origen.Registro.Fields("RetencionIBrutos2").Value
                '             mvarPorcentajeIBrutos2 = origen.Registro.Fields("PorcentajeIBrutos2").Value
                '         End If
                '     End If

                '     If dcfields(6).Enabled And IsNumeric(dcfields(6).BoundText) And Check1(2).Value = 1 Then
                '         If mvarId < 0 Then
                '             oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
                '             If oRs.RecordCount > 0 Then
                '                 mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '                 mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                'mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
                '                 If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '                       DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '                     'mAlicuotaDirecta <> 0 And
                '                     mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                '                 Else
                '                     If mvarSubTotal > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                         If mvarIBCondicion = 2 Then
                '                             mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                             mvarMultilateral = "SI"
                '                         Else
                '                             mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                         End If
                '                     End If
                '                 End If
                '                 mvarIBrutos3 = Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
                '             End If
                '             oRs.Close()
                '             oRs = Nothing
                '         Else
                '             With origen.Registro
                '                 mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
                '                 mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
                '             End With
                '         End If
                '     Else
                '         If mvarId > 0 Then
                '             With origen.Registro
                '                 mvarIBrutos3 = IIf(IsNull(.Fields("RetencionIBrutos3").Value), 0, .Fields("RetencionIBrutos3").Value)
                '                 mvarPorcentajeIBrutos3 = IIf(IsNull(.Fields("PorcentajeIBrutos3").Value), 0, .Fields("PorcentajeIBrutos3").Value)
                '             End With
                '         End If
                '     End If
                ' End If

                ' If mvarId < 0 Then
                '     If Option5.Value Then
                '         mvarPuntoVenta = 0
                '         If IsNumeric(dcfields(10).BoundText) Then
                '             mvarPuntoVenta = dcfields(10).BoundText
                '         End If
                '         If mvarNumeracionUnica Then
                '             oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(1, mvarTipoABC))
                '         Else
                '             oRs = Aplicacion.PuntosVenta.TraerFiltrado("_PuntosVentaPorIdTipoComprobanteLetra", Array(3, mvarTipoABC))
                '         End If
                '         If oRs.RecordCount = 1 Then
                '             oRs.MoveFirst()
                '             mvarPuntoVenta = oRs.Fields(0).Value
                '             If mvarId <= 0 Then
                '                 origen.Registro.Fields("NumeroNotaDebito").Value = oRs.Fields("ProximoNumero").Value
                '                 txtNumeroNotaDebito.Text = oRs.Fields("ProximoNumero").Value
                '             End If
                '         End If
                '         dcfields(10).Enabled = True
                '         dcfields(10).RowSource = oRs
                '         dcfields(10).BoundText = mvarPuntoVenta
                '         If Len(dcfields(10).Text) = 0 Then
                '             origen.Registro.Fields("NumeroNotaDebito").Value = Null
                '             txtNumeroNotaDebito.Text = ""
                '         End If
                '         oRs = Nothing
                '     Else
                '         dcfields(10).Enabled = False
                '         origen.Registro.Fields("IdPuntoVenta").Value = 0
                '         oRs = Aplicacion.Parametros.TraerFiltrado("_PorId", 1)
                '         If Not origen Is Nothing Then
                '             origen.Registro.Fields("NumeroNotaDebito").Value = oRs.Fields("ProximaNotaDebitoInterna").Value
                '         End If
                '         oRs.Close()
                '         oRs = Nothing
                '     End If
                ' End If

                ' mvarTotalNotaDebito = mvarSubTotal + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + _
                '             Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text) + mvarPercepcionIVA

                ' lblLetra.Caption = mvarTipoABC
                ' txtTotal(3).Text = Format(mvarSubTotal, "#,##0.00")
                ' txtTotal(4).Text = Format(mvarIVA1, "#,##0.00")
                ' txtTotal(5).Text = Format(mvarIBrutos + mvarIBrutos2 + mvarIBrutos3, "#,##0.00")
                ' txtTotal(11).Text = Format(mvarPercepcionIVA, "#,##0.00")
                ' txtTotal(8).Text = Format(mvarTotalNotaDebito, "#,##0.00")

                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////




                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                '.TotalBonifEnItems = 0
                .ImporteIva1 = 0


                For Each det As NotaDeCreditoItem In .Detalles
                    With det

                        Dim mImporteIvaItem As Double = 0
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




                        If .Gravado = "SI" Then
                            If myNotaDeCredito.TipoABC = "B" Then
                                .IvaNoDiscriminado = Math.Round(.ImporteTotalItem - (.ImporteTotalItem / (1 + (myNotaDeCredito.PorcentajeIva1 / 100))), 2)
                            Else
                                mImporteIvaItem = Math.Round(.ImporteTotalItem * myNotaDeCredito.PorcentajeIva1 / 100, 2)
                            End If
                        End If



                        Dim mImporte = .ImporteTotalItem ' Val(.Precio) * Val(.Cantidad)






                        '.ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        '.ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        '.ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                        '////////////////////////


                        '////////////////////////
                        'Sumador de totales
                        mvarSubTotal += mImporte
                        'myNotaDeDebito.TotalBonifEnItems += .ImporteBonificacion
                        mvarIVA1 += mImporteIvaItem
                        '////////////////////////
                    End With
                Next


                .TotalImputaciones = 0
                For Each det As NotaDeCreditoImpItem In .DetallesImp
                    With det
                        If Not .Eliminado Then myNotaDeCredito.TotalImputaciones += .Importe
                    End With
                Next



                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                '.TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                '.TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .ImporteIva1 = mvarIVA1
                .ImporteTotal = mvarSubTotal + mvarIVA1 ' .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With
        End Sub

        Public Shared Sub RefrescaTalonarioIVA(ByRef myNotaDeCredito As NotaDeCredito)
            'myNotaDeDebito.letra=

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
            '    txtNumeroNotaDeDebito2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaNotaDebitoInterna")
            'Else
            '    txtNumeroNotaDeDebito2.Text = NotaDeDebitoManager.ProximoNumeroNotaDebitoPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.Text) 'ParametroOriginal(SC, "ProximoFactura")
            'End If
        End Sub




        Public Function SumaImporteGravado() As Double

            'Dim oRs As adodb.Recordset
            'Dim TSumaGravado As Double

            'TSumaGravado = 0

            'oRs = Me.TraerTodos

            'If oRs.Fields.Count > 0 Then
            '    If oRs.RecordCount > 0 Then
            '        oRs.MoveFirst()
            '        Do While Not oRs.EOF
            '            If oRs.Fields("Gravado?").Value = "SI" Then
            '                TSumaGravado = TSumaGravado + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            '            End If
            '            oRs.MoveNext()
            '        Loop
            '    End If
            '    oRs.Close()
            'End If

            'oRs = Me.Registros

            'If oRs.Fields.Count > 0 Then
            '    If oRs.RecordCount > 0 Then
            '        oRs.MoveFirst()
            '        Do While Not oRs.EOF
            '            If Not oRs.Fields(0).Value > 0 And Not oRs.Fields("Eliminado").Value Then
            '                If oRs.Fields("Gravado").Value = "SI" Then
            '                    TSumaGravado = TSumaGravado + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            '                End If
            '            End If
            '            oRs.MoveNext()
            '        Loop
            '    End If
            '    oRs.Close()
            'End If

            'oRs = Nothing

            'SumaImporteGravado = TSumaGravado

        End Function

        Public Function SumaImporteNoGravado() As Double

            'Dim oRs As adodb.Recordset
            'Dim TSumaNoGravado As Double

            'TSumaNoGravado = 0

            'oRs = Me.TraerTodos

            'If oRs.Fields.Count > 0 Then
            '    If oRs.RecordCount > 0 Then
            '        oRs.MoveFirst()
            '        Do While Not oRs.EOF
            '            If Not oRs.Fields("Gravado?").Value = "SI" Then
            '                TSumaNoGravado = TSumaNoGravado + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            '            End If
            '            oRs.MoveNext()
            '        Loop
            '    End If
            '    oRs.Close()
            'End If

            'oRs = Me.Registros

            'If oRs.Fields.Count > 0 Then
            '    If oRs.RecordCount > 0 Then
            '        oRs.MoveFirst()
            '        Do While Not oRs.EOF
            '            If Not oRs.Fields(0).Value > 0 And Not oRs.Fields("Eliminado").Value Then
            '                If Not oRs.Fields("Gravado").Value = "SI" Then
            '                    TSumaNoGravado = TSumaNoGravado + IIf(IsNull(oRs.Fields("Importe").Value), 0, oRs.Fields("Importe").Value)
            '                End If
            '            End If
            '            oRs.MoveNext()
            '        Loop
            '    End If
            '    oRs.Close()
            'End If

            'oRs = Nothing

            'SumaImporteNoGravado = TSumaNoGravado

        End Function




        Public Shared Sub AgregarImputacionSinAplicacionOPagoAnticipado(ByRef myNotaDeCredito As NotaDeCredito)
            With myNotaDeCredito
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

                RecalcularTotales(myNotaDeCredito)
                mvarDif = Math.Round(.ImporteTotal - .TotalImputaciones, 2)

                If mvarDif > 0 Then
                    Dim mItemImp As NotaDeCreditoImpItem = New NotaDeCreditoImpItem
                    mItemImp.Id = -1
                    mItemImp.Nuevo = True
                    mItemImp.IdImputacion = -1
                    mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "S/A"
                    mItemImp.FechaComprobanteImputado = Nothing
                    mItemImp.Importe = mvarDif
                    mvarDif = 0
                    .DetallesImp.Add(mItemImp)
                End If

                RecalcularTotales(myNotaDeCredito)
            End With
        End Sub












    End Class
End Namespace