Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Diagnostics
Imports System.Collections.Generic

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class NotaDeDebitoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As NotaDeDebitoList
            Return NotaDeDebitoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As NotaDeDebito
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            GetCopyOfItem.Id = -1
            For Each item As NotaDeDebitoItem In GetCopyOfItem.Detalles
                item.Id = -1
            Next
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As NotaDeDebitoList
            Dim NotaDeDebitoList As Pronto.ERP.BO.NotaDeDebitoList = NotaDeDebitoDB.GetListByEmployee(SC, IdSolicito)
            If NotaDeDebitoList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareFecha)
                    Case "Obra"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareObra)
                    Case "Sector"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareSector)
                    Case Else 'Ordena por id
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareId)
                End Select
            End If
            Return NotaDeDebitoList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return NotaDeDebitoDB.GetList_fm(SC)
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


            Try
                ds = GeneralDB.TraerDatos(SC, "wNotaDeDebitos_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "NotasDebito_TT")
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdNotaDebito").ColumnName = "Id"
                .Columns("Nota Debito").ColumnName = "Numero"
                '.Columns("FechaNotaDeDebito").ColumnName = "Fecha"
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
                ds = GeneralDB.TraerDatos(SC, "wNotaDeDebitos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "NotaDeDebitos_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wNotaDeDebitos_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "NotaDeDebitos_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As NotaDeDebito
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getNotaDeDebitoDetalles As Boolean) As NotaDeDebito
            Dim myNotaDeDebito As NotaDeDebito
            myNotaDeDebito = NotaDeDebitoDB.GetItem(SC, id)

            If Not (myNotaDeDebito Is Nothing) AndAlso getNotaDeDebitoDetalles Then
                'traigo el detalle
                myNotaDeDebito.Detalles = NotaDeDebitoItemDB.GetList(SC, id)

                'traigo las descripciones de los items
                For Each i As NotaDeDebitoItem In myNotaDeDebito.Detalles
                    i.Concepto = EntidadManager.NombreConcepto(SC, i.IdConcepto)
                Next
            End If

            Return myNotaDeDebito
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As NotaDeDebitoItemList
            Return NotaDeDebitoItemDB.GetList(SC, id)
        End Function


        Public Shared Function ConvertirComProntoNotaDeDebitoAPuntoNET(ByVal oNotaDeDebito) As Pronto.ERP.BO.NotaDeDebito
            Dim oDest As New Pronto.ERP.BO.NotaDeDebito

            '///////////////////////////
            '///////////////////////////
            'ENCABEZADO
            With oNotaDeDebito.Registro

                oDest.Id = oNotaDeDebito.Id

                oDest.Fecha = .Fields("FechaNotaDebito").Value
                oDest.IdCliente = .Fields("IdCliente").Value

                'oDest.TipoFactura = .Fields("TipoABC").Value

                oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
                oDest.Numero = .Fields("NumeroNotaDebito").Value


                'oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
                'oDest.Total = .Fields("ImporteTotal").Value
                oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
                'oDest.IdCodigoIVA = iisNull(.Fields("Idcodigoiva").Value, 0)

                oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

                'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
                oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
                oDest.ImporteTotal = .Fields("ImporteTotal").Value
            End With


            '///////////////////////////
            '///////////////////////////
            'DETALLE
            Dim rsDet As adodb.Recordset = oNotaDeDebito.DetNotasDebito.TraerTodos

            With rsDet
                If Not .EOF Then .MoveFirst()

                Do While Not .EOF

                    Dim oDetNotaDeDebito = oNotaDeDebito.DetNotasDebito.Item(rsDet.Fields("IdDetalleNotaDebito"))

                    Dim item As New NotaDeDebitoItem


                    With oDetNotaDeDebito.Registro

                        'item.IdConcepto = .Fields("IdConcepto").Value
                        'item.Concepto = rsDet.Fields(3).Value
                        item.ImporteTotalItem = .Fields("Importe").Value
                        'item.gravado = .Fields("Gravado").Value
                        'item.Precio = .Fields("IvaNoDiscriminado").Value
                        'item.Precio = .Fields("PrecioUnitarioTotal").Value

                    End With

                    oDest.Detalles.Add(item)
                    .MoveNext()
                Loop

            End With


            Return oDest
        End Function






        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myNotaDeDebito As NotaDeDebito)
            With myNotaDeDebito
                Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                'estos debieran ser READ only, no?
                .IdCodigoIva = ocli.IdCodigoIva
                .TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                .IdPuntoVenta = EntidadManager.IdPuntoVentaComprobanteSegunSubnumeroYLetra(SC, .PuntoVenta, .TipoABC, EntidadManager.IdTipoComprobante.NotaDebito)
                .Numero = ProximoNumeroNotaDebitoPorIdCodigoIvaYNumeroDePuntoVenta(SC, .IdCodigoIva, .PuntoVenta)

                '.Numero = ProximoNumeroFactura(SC, myFactura.IdPuntoVenta)
            End With
        End Sub


        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myNotaDeDebito As NotaDeDebito, Optional ByVal sError As String = "") As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try


                Dim esNuevo As Boolean
                If myNotaDeDebito.Id = -1 Then esNuevo = True Else esNuevo = False

                If esNuevo Then
                    RefrescarTalonario(SC, myNotaDeDebito)
                End If


                Dim NotaDeDebitoId As Integer = NotaDeDebitoDB.Save(SC, myNotaDeDebito)
                'For Each myNotaDeDebitoItem As NotaDeDebitoItem In myNotaDeDebito.Detalles
                '    myNotaDeDebitoItem.IdNotaDeDebito = NotaDeDebitoId
                '    NotaDeDebitoItemDB.Save(myNotaDeDebitoItem)
                'Next




                If myNotaDeDebito.Id = -1 Then
                    Try
                        If myNotaDeDebito.CtaCte = "NO" Then
                            ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximaNotaDebitoInterna", ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaNotaDebitoInterna") + 1)
                        Else
                            ClaseMigrar.AsignarNumeroATalonario(SC, myNotaDeDebito.IdPuntoVenta, myNotaDeDebito.Numero + 1)
                        End If
                    Catch ex As Exception
                        sError = "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.Message
                        Exit Function
                    End Try
                End If

                myNotaDeDebito.Id = NotaDeDebitoId

                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Return NotaDeDebitoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                Debug.Print(ex.Message)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myNotaDeDebito As NotaDeDebito) As Boolean
            Return NotaDeDebitoDB.Delete(SC, myNotaDeDebito.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return NotaDeDebitoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal Id As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
            Dim myNotaDeDebito As Pronto.ERP.BO.NotaDeDebito = GetItem(SC, Id, True)

            With myNotaDeDebito
                .MotivoAnulacion = motivo
                .FechaAnulacion = Today
                .UsuarioAnulacion = IdUsuario
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                .Cumplido = "AN"
                .Anulada = "SI"
                .IdAutorizaAnulacion = IdUsuario

                For Each i As NotaDeDebitoItem In .Detalles
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


                Save(SC, myNotaDeDebito)
            End With


        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return NotaDeDebitoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal myNotaDeDebito As NotaDeDebito) As Boolean

            Dim eliminados As Integer
            'verifico el detalle
            For Each det As NotaDeDebitoItem In myNotaDeDebito.Detalles
                If det.IdConcepto = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                If det.Eliminado Then eliminados = eliminados + 1
            Next

            If myNotaDeDebito.Detalles.Count = eliminados Or myNotaDeDebito.Detalles.Count = 0 Then
                Return False
            End If


            Return True
        End Function

        Public Shared Function ProximoNumeroNotaDebitoPorIdCodigoIvaYNumeroDePuntoVenta(ByVal SC As String, ByVal IdCodigoIva As Integer, ByVal NumeroDePuntoVenta As Integer) As Long

            Try
                'averiguo la letra
                Dim Letra = EntidadManager.LetraSegunTipoIVA(IdCodigoIva)

                'averiguo el id del talonario 
                Dim IdPuntoVenta = EntidadManager.IdPuntoVentaComprobanteSegunSubnumeroYLetra(SC, NumeroDePuntoVenta, Letra, EntidadManager.IdTipoComprobante.NotaDebito)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Return -1
            End Try

        End Function


        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdNotaDeDebito As Long) As Integer

            Dim oRs As adodb.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetNotaDeDebitos", "TX_Req", IdNotaDeDebito))

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

        Public Shared Function UltimoItemDetalle(ByVal myNotaDeDebito As NotaDeDebito) As Integer

            For Each i As NotaDeDebitoItem In myNotaDeDebito.Detalles
                'If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            Next

        End Function


        Public Shared Sub RefrescaTalonarioIVA(ByRef myNotaDeDebito As NotaDeDebito)
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

        Public Shared Sub RecalcularTotales(ByVal SC As String, ByRef myNotaDeDebito As NotaDeDebito)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myNotaDeDebito


                Dim oRs As adodb.Recordset
                'Dim oL As ListItem
                Dim i As Integer, mIdProvinciaIIBB As Integer
                Dim TSumaGravado As Double, TSumaNoGravado As Double, mTopeIIBB As Double, mImporteItem As Double
                Dim mvarIVANoDiscriminadoItem As Double
                Dim mFecha1 As Date
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
                Dim mvarPercepcionIVA = 0

                Dim mvarDecimales = 2

                Dim mvarPorcentajeIBrutos = 0
                Dim mvarPorcentajeIBrutos2 = 0
                Dim mvarPorcentajeIBrutos3 = 0
                Dim mvar_IBrutos_Cap = 0
                Dim mvar_IBrutos_BsAs = 0
                Dim mvar_IBrutos_BsAsM = 0
                Dim mvarIVA2 = 0
                Dim mvarNetoGravado = 0

                ' mvarSubTotal = 0
                ' mvarMultilateral = "NO"
                Dim mvarIBrutos, mvarIBrutos2, mvarIBrutos3 As Double
                mvarPorcentajeIBrutos = 0
                mvarPorcentajeIBrutos2 = 0
                mvarPorcentajeIBrutos3 = 0
                mvar_IBrutos_Cap = 0
                mvar_IBrutos_BsAs = 0
                mvar_IBrutos_BsAsM = 0
                mvarIVA1 = 0
                mvarIVA2 = 0
                Dim mvarTotalNotaDebito = 0
                Dim mvarIVANoDiscriminado = 0
                mvarPercepcionIVA = 0

                TSumaGravado = SumaImporteGravado(myNotaDeDebito)
                TSumaNoGravado = SumaImporteNoGravado(myNotaDeDebito)
                mvarSubTotal = TSumaGravado + TSumaNoGravado

                RefrescaTalonarioIVA(myNotaDeDebito)

                Dim mvarMultilateral
                Dim mNumeroCertificadoPercepcionIIBB


                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////

                For Each o As NotaDeDebitoItem In myNotaDeDebito.Detalles
                    With o
                        If Not .Eliminado Then
                            .IvaNoDiscriminado = 0
                            If .Gravado = "SI" Then
                                If myNotaDeDebito.TipoABC = "B" Then
                                    mImporteItem = .ImporteTotalItem
                                    mvarIVANoDiscriminadoItem = Math.Round(mImporteItem - (mImporteItem / (1 + (Val(myNotaDeDebito.PorcentajeIva1) / 100))), 2)
                                    .IvaNoDiscriminado = mvarIVANoDiscriminadoItem
                                    mvarIVANoDiscriminado = mvarIVANoDiscriminado + mvarIVANoDiscriminadoItem
                                End If
                            End If
                        End If
                    End With
                Next





                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////
                'INGRESOS BRUTOS CATEGORIA 1
                '//////////////////////////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////////////////////////


                Dim NumeroCertificadoPercepcionIIBB = DBNull.Value
                Dim dr As DataRow


                '//////////////////////////////////////////////////////////////////////////////////////






                If .CtaCte = "SI" Then


                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'PERCEPCIONES (si no es AGENTE de RETENCION)
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If .Id < 0 Then
                        If mvarEsAgenteRetencionIVA = "NO" And TSumaGravado >= mvarBaseMinimaParaPercepcionIVA Then
                            mvarPercepcionIVA = Math.Round(TSumaGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
                        End If
                    Else
                        mvarPercepcionIVA = .PercepcionIVA
                    End If





                    '//////////////////////////////////////////////////////////////////////////////////////
                    'INGRESOS BRUTOS CATEGORIA 1
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If .IdIBCondicion > 0 Then
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
                            If mvarSubTotal > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos = Math.Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)



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

                    If .IdIBCondicion2 > 0 Then
                        dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion2)


                        mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
                        mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
                        If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
                              .Fecha >= mFechaInicioVigenciaIBDirecto And _
                              .Fecha <= mFechaFinVigenciaIBDirecto Then
                            'mAlicuotaDirecta <> 0 And
                            mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                        Else
                            If mvarSubTotal > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos2 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos2 = Math.Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)



                    End If


                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////
                    'INGRESOS BRUTOS CATEGORIA 3
                    '//////////////////////////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////////////////////////

                    If .IdIBCondicion3 > 0 Then
                        dr = EntidadManager.GetItem(SC, "IBCondiciones", .IdIBCondicion3)


                        mTopeIIBB = IIf(IsNull(dr.Item("ImporteTopeMinimoPercepcion")), 0, dr.Item("ImporteTopeMinimoPercepcion"))
                        mIdProvinciaIIBB = IIf(IsNull(dr.Item("IdProvincia")), 0, dr.Item("IdProvincia"))
                        If IIf(IsNull(dr.Item("IdProvinciaReal")), dr.Item("IdProvincia"), dr.Item("IdProvinciaReal")) = 2 And _
                              .Fecha >= mFechaInicioVigenciaIBDirecto And _
                              .Fecha <= mFechaFinVigenciaIBDirecto Then
                            'mAlicuotaDirecta <> 0 And
                            mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                        Else
                            If mvarSubTotal > mTopeIIBB And .Fecha >= mFecha1 Then
                                If mvarIBCondicion = 2 Then
                                    mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcionConvenio")), 0, dr.Item("AlicuotaPercepcionConvenio"))
                                    mvarMultilateral = "SI"
                                Else
                                    mvarPorcentajeIBrutos3 = IIf(IsNull(dr.Item("AlicuotaPercepcion")), 0, dr.Item("AlicuotaPercepcion"))
                                End If
                            End If
                        End If
                        mvarIBrutos3 = Math.Round((mvarSubTotal - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)


                    End If



                End If






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
                mvarSubTotal = 0

                For Each det As NotaDeDebitoItem In .Detalles
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
                        Dim mImporteIvaItem As Double = 0

                        If .Gravado = "SI" Then
                            If myNotaDeDebito.TipoABC = "B" Then
                                .IvaNoDiscriminado = Math.Round(.ImporteTotalItem - (.ImporteTotalItem / (1 + (myNotaDeDebito.PorcentajeIva1 / 100))), 2)
                            Else
                                mImporteIvaItem = Math.Round(.ImporteTotalItem * myNotaDeDebito.PorcentajeIva1 / 100, 2)
                            End If
                        End If

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



                        '////////////////////////
                        'Cálculo del item
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


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                '.TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
                '.TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems


                .RetencionIBrutos1 = mvarIBrutos
                .RetencionIBrutos2 = mvarIBrutos2
                .RetencionIBrutos3 = mvarIBrutos3




                .ImporteIva1 = mvarIVA1
                .ImporteTotal = mvarSubTotal + mvarIVA1 ' .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With
        End Sub

    

        Public Shared Function SumaImporteGravado(ByRef myNotaDeDebito As NotaDeDebito) As Double

            Dim TSumaGravado As Double

            TSumaGravado = 0

            For Each i As NotaDeDebitoItem In myNotaDeDebito.Detalles
                If Not i.Eliminado Then
                    If i.Gravado = "SI" Then
                        TSumaGravado = TSumaGravado + i.ImporteTotalItem
                    End If
                End If
            Next

            SumaImporteGravado = TSumaGravado

        End Function

        Public Shared Function SumaImporteNoGravado(ByRef myNotaDeDebito As NotaDeDebito) As Double

            Dim TSumaNoGravado As Double = 0


            For Each i As NotaDeDebitoItem In myNotaDeDebito.Detalles
                If Not i.Eliminado Then
                    If Not i.Gravado = "SI" Then
                        TSumaNoGravado += i.ImporteTotalItem
                    End If
                End If
            Next

            SumaImporteNoGravado = TSumaNoGravado

        End Function










    End Class
End Namespace