Option Infer On


Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Collections.Generic
Imports System.Linq
Imports System.Data.Linq


Imports System.Linq.Expressions
Imports System.Linq.Dynamic



Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class PedidoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As PedidoList
            Return PedidoDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return PedidoDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pedido
            Return GetItem(SC, id, False)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getPedidoDetalles As Boolean) As Pedido
            Dim myPedido As Pedido
            myPedido = PedidoDB.GetItem(SC, id)
            If Not (myPedido Is Nothing) AndAlso getPedidoDetalles Then
                myPedido.Detalles = PedidoItemDB.GetList(SC, id)

            End If

            For Each i In myPedido.Detalles
                With i
                    Try
                        .Subtotal = .Precio * .Cantidad
                        .Subtotal_grav_ = .Cantidad * .Precio - .ImporteBonificacion
                        .Equipo_destino = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).Equipo
                        .It_LA = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).Item
                        .RM_solicitada_por = RequerimientoManager.GetItem(SC, RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).IdRequerimiento).Solicito
                        .Obra = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).centrocosto

                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try
                End With
            Next

            Return myPedido
        End Function


        
        Public Shared Function GetTotalNumberOfPedidos(ByVal SC As String, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#) As Integer '   List(Of DataRow) As Integer 'es importante que sea un Integer y no un Long
            Dim i As Long = EntidadManager.ExecDinamico(SC, "select count(*) from Pedidos").Rows(0).Item(0)
            Return i
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#) As DataTable


            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With
            If maximumRows = 0 Then maximumRows = 8

            Dim dt As DataTable


            Using db As New DataClasses2DataContext(Encriptar(SC))
                ' http://stackoverflow.com/questions/9708266/assign-values-from-one-list-to-another-using-linq

                '    Dim q As IEnumerable(Of DataRow) = (From i In GeneralDB.TraerDatos(SC, "wPedidos_T", -1).Tables(0).AsEnumerable _
                'Skip startRowIndex Take maximumRows _
                ').ToList ' Select i) ', .id = 1, .numero = 1, .fecha = 1})



                'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
                'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
                Dim linqDinamico As IQueryable(Of wVistaPedido)


                If txtBuscar <> "" Then
                    Dim busq
                    If cmbBuscarEsteCampo Is Nothing Then cmbBuscarEsteCampo = "NumeroPedido"
                    If cmbBuscarEsteCampo = "NumeroPedido" Then busq = Val(txtBuscar) Else busq = txtBuscar
                    Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")
                    Try
                        linqDinamico = db.wVistaPedidos.Where("" & nombrecampo & ".Contains(@0) ", busq)
                        'linqDinamico = db.wVistaPedidos.Where("Convert.ToString(" & nombrecampo & ").Contains(@0) ", busq)

                        'linqDinamico = db.wVistaPedidos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                    Catch ex As Exception
                        ' MsgBoxAjax(Me, "No se puede usar ese filtro")
                        Try
                            linqDinamico = db.wVistaPedidos.Where(nombrecampo & " = @0 ", busq)
                        Catch ex2 As Exception
                            linqDinamico = db.wVistaPedidos
                        End Try
                    End Try
                Else
                    linqDinamico = db.wVistaPedidos
                End If




                'una vez que está filtrado, uso linq normal tipado
                Dim q = (From rm In linqDinamico _
                         Where (rm.FechaPedido <= fHasta And rm.FechaPedido >= fDesde) _
                                And (True Or txtBuscar = "" Or rm.NumeroPedido.ToString.StartsWith(txtBuscar)) _
                         Order By rm.IdPedido Descending _
                         Skip startRowIndex Take maximumRows).ToList



                'dt = ToDataTableNull(q)

            End Using




            'If q.Count = 0 Then Return Nothing
            'Dim dt = q.CopyToDataTable
            With dt
                .Columns("IdPedido").ColumnName = "Id"
                .Columns("NumeroPedido").ColumnName = "Numero"
                .Columns("FechaPedido").ColumnName = "Fecha"
            End With
            Return dt

            'Dim dt = GeneralDB.TraerDatos(SC, "wPedidos_T", -1).Tables(0)
            'Dim a = dt.AsEnumerable.Take(8)
            'a.ToDataTable()

            'Try
            '    ds = GeneralDB.TraerDatos(SC, "wPedidos_T", -1)
            'Catch ex As Exception
            '    ds = GeneralDB.TraerDatos(SC, "Pedidos_T", -1)
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres


            'ds.Tables(0).Columns.Add(dc)










        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset_conList(ByVal SC As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, Optional txtBuscar As String = "", Optional cmbBuscarEsteCampo As String = "", Optional fDesde As Date = #1/1/1900#, Optional fHasta As Date = #1/1/2100#) As List(Of wVistaPedido)


            'Dim txtBuscar As String = ""
            'Dim cmbBuscarEsteCampo As String = ""
            'Dim fDesde = #1/1/1900#, fHasta = #1/18/2100#


            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With
            If maximumRows = 0 Then maximumRows = 8

            Dim dt As DataTable


            Using db As New DataClasses2DataContext(Encriptar(SC))
                ' http://stackoverflow.com/questions/9708266/assign-values-from-one-list-to-another-using-linq

                '    Dim q As IEnumerable(Of DataRow) = (From i In GeneralDB.TraerDatos(SC, "wPedidos_T", -1).Tables(0).AsEnumerable _
                'Skip startRowIndex Take maximumRows _
                ').ToList ' Select i) ', .id = 1, .numero = 1, .fecha = 1})



                'http://stackoverflow.com/questions/2455659/how-to-use-contains-or-like-in-a-dynamic-linq-query
                'Dim linqDinamico = db.wVistaRequerimientos.Where(cmbBuscarEsteCampo.SelectedValue & ".Contains(@0)", Val(txtBuscar.Text))  'el filtro de columna lo hago con linq dinamico
                Dim linqDinamico As IQueryable(Of wVistaPedido)


                If txtBuscar <> "" Then
                    Try
                        Dim busq
                        If cmbBuscarEsteCampo Is Nothing Then cmbBuscarEsteCampo = "Numero_Req_"
                        If cmbBuscarEsteCampo = "Numero_Req_" Then busq = Val(txtBuscar) Else busq = txtBuscar
                        Dim nombrecampo As String = cmbBuscarEsteCampo.Replace("[", "").Replace("]", "")
                        linqDinamico = db.wVistaPedidos.Where(nombrecampo & " = @0 ", busq)  'el filtro de columna lo hago con linq dinamico
                    Catch ex As Exception
                        ' MsgBoxAjax(Me, "No se puede usar ese filtro")
                        linqDinamico = db.wVistaPedidos
                    End Try
                Else
                    linqDinamico = db.wVistaPedidos
                End If




                'una vez que está filtrado, uso linq normal tipado
                Dim q = (From rm In linqDinamico _
                         Where (rm.FechaPedido <= fHasta And rm.FechaPedido >= fDesde) _
                                And (txtBuscar = "" Or rm.NumeroPedido.ToString.StartsWith(txtBuscar)) _
                         Order By rm.IdPedido Descending _
                         Skip startRowIndex Take maximumRows).ToList


                Return q

                'dt = ToDataTableNull(q)

            End Using









        End Function


        Shared Function ProximoNumeroPedido(sc)
            'If ExisteEsteNumero(SC, myPedido.Numero, myPedido.Id) Then
            '    Dim nuevonum = StringToDecimal(ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximoNumeroPedido))
            '    MsgBoxAjax(Me, "El número de pedido " & myPedido.Numero & " ya existe, se actualiza a " & nuevonum)
            '    myPedido.Numero = nuevonum
            '    txtNumeroPedido.Text = nuevonum
            '    mAltaItem = False
            '    'ScriptManager1.RegisterDataItem(Label2, DateTime.Now.ToString())
            '    'UpdatePanel22.Update()
            '    Return
            'End If

            Dim nuevonum = StringToDecimal(ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(sc, ParametroManager.ePmOrg.ProximoNumeroPedido))
            If ExisteEsteNumero(sc, nuevonum, 0, -1) Then
                'se descajetó el numerador, y el próximo pisa uno existente
                'busco, pues, el máximo
                Dim a = EntidadManager.ExecDinamico(sc, String.Format("SELECT max(NumeroPedido) FROM Pedidos")).Rows(0).Item(0)
                Return a + 1
            Else
                Return nuevonum
            End If
        End Function

        Shared Function ExisteEsteNumero(sc As String, n As Long, subnumero As Integer, Id As Long) As Boolean
            Try
                Dim a = EntidadManager.ExecDinamico(sc, String.Format("SELECT NumeroPedido FROM Pedidos WHERE NumeroPedido={0} AND Isnull(SubNumero,{2})={2} AND IdPedido<>{1}", n, Id, subnumero)).Rows(0).Item(0)
                If a IsNot Nothing Then Return True
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try
            Return False
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As PedidoItemList
            Return PedidoItemDB.GetList(SC, id)
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXAnticiposAProveedor(ByVal SC As String, ByVal IdProveedor As Long) As System.Data.DataTable
            Return EntidadManager.GetStoreProcedure(SC, enumSPs.Pedidos_TX_AnticipoAProveedores, IdProveedor)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myPedido As Pronto.ERP.BO.Pedido) As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                Dim PedidoId As Integer = PedidoDB.Save(SC, myPedido)
                'For Each myPedidoItem As PedidoItem In myPedido.Detalles
                '    myPedidoItem.IdPedido = PedidoId
                '    PedidoItemDB.Save(myPedidoItem)
                'Next


                myPedido.Id = PedidoId
                'myTransactionScope.Complete()
                'ContextUtil.SetComplete()
                Try
                    EntidadManager.LogPronto(SC, PedidoId, "Pedido", "")
                Catch ex As Exception
                End Try


                Try

                    Using db As New DataClasses2DataContext(Encriptar(SC))
                        ' http://stackoverflow.com/questions/9708266/assign-values-from-one-list-to-another-using-linq
                        Dim cab = (From i In db.linqPedidos Where i.IdPedido = PedidoId).Single
                        With cab
                            .ConfirmadoPorWeb = myPedido.ModificadoPorWeb
                        End With
                        db.SubmitChanges()
                    End Using
                Catch ex As Exception
                End Try



                Return PedidoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myPedido As Pedido) As Boolean
            Return PedidoDB.Delete(SC, myPedido.Id)
        End Function


        Public Shared Function IsValid(ByVal myPedido As Pedido, ByVal SC As String, Optional ByRef ms As String = "") As Boolean


            
            Dim eliminados As Integer
            'verifico el detalle
            For Each det As PedidoItem In myPedido.Detalles
                If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                If det.Eliminado Then eliminados = eliminados + 1
            Next

            If myPedido.Detalles.Count = eliminados Or myPedido.Detalles.Count = 0 Then
                Return False
            End If

        
            '.CotizacionDolar = Cotizacion(SC)
            '.CotizacionMoneda = Cotizacion(SC, , .IdMoneda)
            ''en el campo CotizacionDolar SIEMPRE va la cotizacion del dolar del dia

            'en el campo CotizacionMoneda, si la NP esta en pesos siempre va 1
            'si la cotizacion esta en otra moneda va la cotizacion del dia de esa moneda (Si la NP es en dolares ese campo seria igual al de CotizacionDolar)


            RecalcularTotales(SC, myPedido)
            If myPedido.TotalPedido = 0 Then
                ms = "El precio no puede ser cero"
                Return False
            End If




            Return True
        End Function


        Public Shared Sub RecalcularTotales(sc As String, ByRef myPresupuesto As Pedido)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myPresupuesto

                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                .TotalBonifEnItems = 0
                .ImporteIva1 = 0



                For Each det As PedidoItem In .Detalles
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

                        ' Dim mvarBonificacionDistribuida = myPresupuesto.PorcentajeBonificacion * (mvarImporteTotalItem / mvarSubTotal)
                        .ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                        .ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                        .ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                        '////////////////////////


                        '////////////////////////
                        'Sumador de totales
                        mvarSubTotal += mImporte
                        myPresupuesto.TotalBonifEnItems += .ImporteBonificacion
                        mvarIVA1 += .ImporteIVA
                        '////////////////////////
                    End With
                Next


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.PorcentajeBonificacion) / 100, 2)
                .Bonificacion = .TotalBonifSobreElTotal
                .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .ImporteIva1 = Math.Round(mvarIVA1 * Val(100 - .PorcentajeBonificacion) / 100, 2)
                .TotalIva1 = .ImporteIva1
                .TotalOtrosConceptos = .OtrosConceptos1 + .OtrosConceptos2 + .OtrosConceptos3 + .OtrosConceptos4 + .OtrosConceptos5
                .Total = .TotalSubGravado + .ImporteIva1 + .TotalOtrosConceptos + .ImpuestosInternos '+ mvarIVA2 
                .TotalPedido = .Total
            End With
        End Sub




        Public Shared Function ItemEnOtrosPedidos(ByVal SC As String, ByVal myPedido As Pedido, ByVal IdItem As Long, ByVal Tipo As String) As String

            Dim mResul As String
            Dim oRs ' As ADOR.Recordset

            If Tipo = "RM" Then
                oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetPedidos", "TX_BuscarItemRM", IdItem))
            Else
                oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetPedidos", "TX_BuscarItemAco", IdItem))
            End If

            mResul = ""
            With oRs
                If .RecordCount > 0 Then
                    .MoveFirst()
                    Do While Not .EOF
                        If .Fields("IdPedido").Value <> myPedido.Id Then
                            mResul = mResul & " " & .Fields("NumeroPedido").Value & " - Item : " & .Fields("NumeroItem").Value & " - Cantidad : " & .Fields("Cantidad").Value & vbCrLf
                        End If
                        .MoveNext()
                    Loop
                End If
                .Close()
            End With

            oRs = Nothing

            ItemEnOtrosPedidos = mResul

        End Function



     


    End Class

End Namespace