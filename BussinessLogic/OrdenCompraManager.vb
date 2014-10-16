Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Diagnostics

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class OrdenCompraManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As OrdenCompraList
            Return OrdenCompraDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As OrdenCompraList
            Dim OrdenCompraList As Pronto.ERP.BO.OrdenCompraList '= OrdenCompraDB.GetListByEmployee(SC, IdSolicito)
            If OrdenCompraList IsNot Nothing Then
                Select Case orderBy
                    'Case "Fecha"
                    '    OrdenCompraList.Sort(AddressOf Pronto.ERP.BO.OrdenCompraList.CompareFecha)
                    'Case "Obra"
                    '    OrdenCompraList.Sort(AddressOf Pronto.ERP.BO.OrdenCompraList.CompareObra)
                    'Case "Sector"
                    '    OrdenCompraList.Sort(AddressOf Pronto.ERP.BO.OrdenCompraList.CompareSector)
                    'Case Else 'Ordena por id
                    '    OrdenCompraList.Sort(AddressOf Pronto.ERP.BO.OrdenCompraList.CompareId)
                End Select
            End If
            Return OrdenCompraList
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As OrdenCompra
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id, True)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            With GetCopyOfItem
                .Id = -1

                .IdAprobo = Nothing
                '.Aprobo = Nothing



                For Each item As OrdenCompraItem In .Detalles
                    item.Id = -1
                Next
            End With
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return OrdenCompraDB.GetList_fm(SC)
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
                ds = GeneralDB.TraerDatos(SC, "OrdenesCompra_TT")

                'ds = GeneralDB.TraerDatos(SC, "wOrdenCompras_T", -1)
            Catch ex As Exception
                Try
                    ds = GeneralDB.TraerDatos(SC, "wOrdenCompras_TT")
                Catch ex2 As Exception
                    ds = GeneralDB.TraerDatos(SC, "OrdenesCompra_TT")
                End Try
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdOrdenCompra").ColumnName = "Id"
                .Columns("Orden de compra").ColumnName = "Numero"
                '.Columns("Nro. interno").ColumnName = "Interno"
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


        Public Shared Function ProximoSubNumero(ByVal SC As String, ByVal PresupuestoNumero As Long) As Long
            'aa()
            'Dim mSubNumero As Integer = 0
            'Dim ds As Data.DataSet = PresupuestoManager.GetListTX(SC, "_PorNumeroBis", PresupuestoNumero)
            'If ds.Tables(0).Rows.Count > 0 Then
            '    For Each dr As Data.DataRow In ds.Tables(0).Rows
            '        If Not IsNull(dr.Item("SubNumero")) Then
            '            mSubNumero = System.Math.Max(mSubNumero, dr.Item("SubNumero"))
            '        End If
            '    Next
            'End If
            'mSubNumero = mSubNumero + 1
            'Return mSubNumero
        End Function


        Private Sub CalculaOrdenCompra()

            'Dim oRs As adodb.Recordset
            'Dim oL As ListItem
            'Dim i As Integer
            'Dim mCant As Double, mPrecio As Double, mPorcB As Double, mBonif As Double
            'Dim mvarSubTotal As Double

            'mvarSubTotal = 0

            'For Each oL In Lista.ListItems
            '    With origen.DetOrdenesCompra.Item(oL.Tag)
            '        If Not .Eliminado Then
            '            With .Registro
            '                mCant = IIf(IsNull(.Fields("Cantidad").Value), 0, .Fields("Cantidad").Value)
            '                mPrecio = IIf(IsNull(.Fields("Precio").Value), 0, .Fields("Precio").Value)
            '                mPorcB = IIf(IsNull(.Fields("PorcentajeBonificacion").Value), 0, .Fields("PorcentajeBonificacion").Value)
            '            End With
            '            mvarSubTotal = mvarSubTotal + (mCant * mPrecio * (1 - mPorcB / 100))
            '        End If
            '    End With
            'Next

            'mPorcB = Val(txtPorcentajeBonificacion.Text)
            'mBonif = mvarSubTotal * mPorcB / 100
            'mvarTotal = mvarSubTotal - mBonif

            'If mvarId > 0 Then
            '    With origen.Registro

            '    End With
            'Else

            'End If

            'txtTotal(0).Text = Format(mvarSubTotal, "#,##0.00")
            'txtTotal(1).Text = Format(mBonif, "#,##0.00")
            'txtTotal(8).Text = Format(mvarTotal, "#,##0.00")

        End Sub



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
                ds = GeneralDB.TraerDatos(SC, "wOrdenesCompra_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "OrdenesCompra_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wOrdenesCompra_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "OrdenesCompra_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function



        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenCompra
            Return GetItem(SC, id, False)
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getOrdenCompraDetalles As Boolean) As OrdenCompra
            Dim myOrdenCompra As OrdenCompra
            myOrdenCompra = OrdenCompraDB.GetItem(SC, id)
            If Not (myOrdenCompra Is Nothing) AndAlso getOrdenCompraDetalles Then
                myOrdenCompra.Detalles = OrdenCompraItemDB.GetList(SC, id)
            End If
            Return myOrdenCompra
        End Function








        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As OrdenCompraItemList
            Return OrdenCompraItemDB.GetList(SC, id)
        End Function

        '<DataObjectMethod(DataObjectMethodType.Update, True)> _
        ' Public Shared Function Save(ByVal SC As String, ByVal myOrdenCompra As OrdenCompra) As Integer
        '    'Dim myTransactionScope As TransactionScope = New TransactionScope
        '    Try
        '        Dim OrdenCompraId As Integer = OrdenCompraDB.Save(SC, myOrdenCompra)
        '        'For Each myOrdenCompraItem As OrdenCompraItem In myOrdenCompra.Detalles
        '        '    myOrdenCompraItem.IdOrdenCompra = OrdenCompraId
        '        '    OrdenCompraItemDB.Save(myOrdenCompraItem)
        '        'Next
        '        myOrdenCompra.Id = OrdenCompraId
        '        'myTransactionScope.Complete()
        '        'ContextUtil.SetComplete()
        '        Return OrdenCompraId
        '    Catch ex As Exception
        '        'ContextUtil.SetAbort()
        '        Debug.Print(ex.Message)
        '        Return -1
        '    Finally
        '        'CType(myTransactionScope, IDisposable).Dispose()
        '    End Try
        'End Function


        'Public Shared Function SaveConCOMPRONTO()

        'End Function

        Public Shared Function Save(ByVal SC As String, ByVal myOrdenCompra As Pronto.ERP.BO.OrdenCompra) As Integer

            If False Then
                'METODO NORMAL
                If Not IsValid(SC, myOrdenCompra) Then Return -1

                'myCliente.Id = ClienteDB.Save(SC, myCliente)
                Return myOrdenCompra.Id
            Else

                'METODO COMPRONTO
                If Not IsValid(SC, myOrdenCompra) Then Return -1

                Dim esNuevo As Boolean
                If myOrdenCompra.Id = -1 Then esNuevo = True Else esNuevo = False

                If esNuevo Then
                    myOrdenCompra.Numero = ParametroManager.ParametroOriginal(SC, "ProximoNumeroOrdenCompra")
                End If



                Dim oOrden = ClaseMigrar.ConvertirPuntoNETOrdenCompraAComPronto(SC, myOrdenCompra)
                oOrden.Guardar()

                '////////////////////////////////////////////////////
                '////////////////////////////////////////////////////
                'Incremento de número en capa de UI. Evitar.Fields("
                'esto es lo que está mal. no tenés que aumentarlo si es una edicion! -pero si está idOrdenCompra=-1! sí, pero puedo ser una alta a partir de una copia
                'cuando el usuario modifico manualmente el numero, o se está usando una copia de otro comprobante, por
                'más que sea un alta, no tenés que incrementar el numerador... -En Pronto pasa lo mismo!

                'If IdOrdenCompra = -1 And myOrdenCompra.SubNumero = 1 Then 'es un OrdenCompra nuevo y TAMBIEN empieza el subnumero
                If esNuevo Then 'es un OrdenCompra nuevo y TAMBIEN empieza el subnumero
                    If ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximoNumeroOrdenCompra, ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroOrdenCompra") + 1) = -1 Then
                        'MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                    End If
                End If
                '////////////////////////////////////////////////////
                '////////////////////////////////////////////////////


                'actualizo manualmente campos nuevos
                'EntidadManager.TablaUpdate(SC, "Clientes", "IdCliente", myOrdenCompra.Id, "ExpresionRegularNoAgruparFacturasConEstosVendedores", "'" & myCliente.ExpresionRegularNoAgruparFacturasConEstosVendedores & "'")
            End If
        End Function


        


        








        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myOrdenCompra As OrdenCompra) As Boolean
            Return OrdenCompraDB.Delete(SC, myOrdenCompra.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            Return OrdenCompraDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdOrdenCompra As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            Dim myOrdenCompra As OrdenCompra = GetItem(SC, IdOrdenCompra)

            Dim s As String
            s = ""
            Dim oRs As DataSet = OrdenCompraManager.GetListTX(SC, "_ItemsApuntadosPorIdOrdenCompra", IdOrdenCompra)

            With myOrdenCompra
                .Anulada = "SI"
                .Cumplido = "AN"
                .IdUsuarioAnulacion = IdUsuario
                .IdAutorizaAnulacion = IdUsuario
                '.UsuarioAnulacion = IdUsuario
                .MotivoAnulacion = motivo
                .FechaAnulacion = Today
                '.Anulada = "SI"
                '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue

                For Each i As OrdenCompraItem In .Detalles
                    With i
                        .Cumplido = "AN"
                        '.EnviarEmail = 1
                    End With
                Next


                For Each i As DataRow In oRs.Tables(0).Rows
                    s = s & "Item de OC : " & i.Item("NumeroItem") & ", " & _
                                 "Comprob.: " & i.Item("Tipo") & " " & _
                                 Format(i.Item("Numero"), "00000000") & " " & _
                                 "del " & i.Item("Fecha") & vbCrLf
                Next

                If Len(s) > 0 Then
                    Return "Hay items de la orden de compra apuntados por los siguientes comprobantes :" & vbCrLf & _
                           "" & vbCrLf & s
                End If



                Save(SC, myOrdenCompra)
            End With


            'Return OrdenCompraDB.Anular(SC, IdOrdenCompra)
        End Function


        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            Return OrdenCompraDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal SC As String, ByRef myOrdenCompra As OrdenCompra, Optional ByRef ms As String = "") As Boolean

            With myOrdenCompra

                Dim eliminados As Integer
                'verifico el detalle
                For Each det As OrdenCompraItem In .Detalles
                    If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                        det.Eliminado = True
                    End If
                    If det.Eliminado Then eliminados = eliminados + 1

                    '.TipoDesignacion = "CMP" 'esto hay que cambiarlo, no?
                    'If .TipoDesignacion = "" Then .TipoDesignacion = "S/D" 'esto hay que cambiarlo, no?
                    If det.Cumplido <> "SI" And det.Cumplido <> "AN" Then det.Cumplido = "NO"
                    '.Cumplido = IIf(.Cumplido = "SI", "SI", "NO") ' y qué pasa si es "AN"?

                Next



                If .Detalles.Count = eliminados Or .Detalles.Count = 0 Then
                    ms = "La lista de items no puede estar vacía"
                    Return False
                End If

                If Val(.NumeroOrdenCompraCliente) = 0 Then
                    ms = "Debe ingresar el numero de orden de compra del cliente"
                    Return False
                End If

                'If .AgrupacionFacturacion Then
                ' ms = "Debe ingresar el grupo para facturacion automatica"
                'return False
                'End If


            End With



            Return True
        End Function

        

        Public Shared Function UltimoItemDetalle(ByVal myOrdenCompra As OrdenCompra) As Integer

            For Each i As OrdenCompraItem In myOrdenCompra.Detalles
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



        Public Shared Sub RecalcularTotales(ByRef myOrdenCompra As OrdenCompra)

            Dim mvarSubTotal, mvarIVA1 As Single

            With myOrdenCompra




                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                'Calculo original de orden de compra
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////

                'mvarImporteBonificacion = Round(mvarSubTotal * mvarPorcentajeBonificacion / 100, 2)
                'mvarNetoGravado = mvarSubTotal - mvarImporteBonificacion

                'If mvarIBrutosC = "S" And mvarPorc_IBrutos_Cap <> 0 And mvarNetoGravado > mvarTope_IBrutos_Cap Then
                '    mvar_IBrutos_Cap = Round(mvarPorc_IBrutos_Cap * mvarNetoGravado / 100, mvarDecimales)
                'End If

                'If mvarIBrutosB = "S" Then
                '    If mvarMultilateral = "S" Then
                '        If mvarPorc_IBrutos_BsAs <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAs Then
                '            mvar_IBrutos_BsAs = Round(mvarPorc_IBrutos_BsAs * mvarNetoGravado / 100, mvarDecimales)
                '        End If
                '    Else
                '        If mvarPorc_IBrutos_BsAsM <> 0 And mvarNetoGravado > mvarTope_IBrutos_BsAsM Then
                '            mvar_IBrutos_BsAsM = Round(mvarPorc_IBrutos_BsAsM * mvarNetoGravado / 100, mvarDecimales)
                '        End If
                '    End If
                'End If



                ''cómo manejar lo del iva no discriminado?
                'If glbIdCodigoIva = 1 Then
                '    Select Case mvarTipoIVA
                '        Case 1
                '            mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                '            mvarPartePesos = mvarPartePesos + Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                '            mvarTipoABC = "A"
                '        Case 2
                '            mvarIVA1 = Round(mvarNetoGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
                '            mvarIVA2 = Round(mvarNetoGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                '            mvarPartePesos = mvarPartePesos + Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales) + _
                '                                              Round((mvarPartePesos + (mvarParteDolares * mvarCotizacion)) * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
                '            mvarTipoABC = "A"
                '        Case 3
                '            mvarTipoABC = "E"
                '        Case 8
                '            mvarTipoABC = "B"
                '        Case 9
                '            mvarTipoABC = "A"
                '        Case Else
                '            mvarIVANoDiscriminado = Round(mvarNetoGravado - (mvarNetoGravado / (1 + (Val(txtPorcentajeIva1.Text) / 100))), mvarDecimales)
                '            mvarTipoABC = "B"
                '    End Select
                'Else
                '    mvarTipoABC = "C"
                'End If



                'origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = Null
                'If dcfields(4).Enabled And Check1(0).Value = 1 And IsNumeric(dcfields(4).BoundText) Then
                '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(4).BoundText)
                '    If oRs.RecordCount > 0 Then
                '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                'mFecha1 = IIf(IsNull(oRs.Fields("FechaVigencia").Value), Date, oRs.Fields("FechaVigencia").Value)
                '        If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '              DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And _
                '              DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '            'mAlicuotaDirecta <> 0 And
                '            mvarPorcentajeIBrutos = mAlicuotaDirecta
                '        Else
                '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                If mvarIBCondicion = 2 Then
                '                    mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                    mvarMultilateral = "SI"
                '                Else
                '                    mvarPorcentajeIBrutos = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                End If
                '            End If
                '        End If
                '        mvarIBrutos = Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos / 100, 2)
                '    End If
                '    oRs.Close()
                '    If mvarIBrutos <> 0 Then
                '        oRs = Aplicacion.Provincias.TraerFiltrado("_PorId", mIdProvinciaIIBB)
                '        If oRs.RecordCount > 0 Then
                '            mNumeroCertificadoPercepcionIIBB = _
                '                  IIf(IsNull(oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value), 1, _
                '                      oRs.Fields("ProximoNumeroCertificadoPercepcionIIBB").Value)
                '        End If
                '        oRs.Close()
                '        origen.Registro.Fields("NumeroCertificadoPercepcionIIBB").Value = mNumeroCertificadoPercepcionIIBB
                '    End If
                '    oRs = Nothing
                'End If

                'If dcfields(5).Enabled And Check1(1).Value = 1 And IsNumeric(dcfields(5).BoundText) Then
                '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(5).BoundText)
                '    If oRs.RecordCount > 0 Then
                '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                '        If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '              DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And _
                '              DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '            'mAlicuotaDirecta <> 0 And
                '            mvarPorcentajeIBrutos2 = mAlicuotaDirecta
                '        Else
                '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                If mvarIBCondicion = 2 Then
                '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                    mvarMultilateral = "SI"
                '                Else
                '                    mvarPorcentajeIBrutos2 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                End If
                '            End If
                '        End If
                '        mvarIBrutos2 = Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2)
                '    End If
                '    oRs.Close()
                '    oRs = Nothing
                'End If

                'If dcfields(6).Enabled And Check1(2).Value = 1 And IsNumeric(dcfields(6).BoundText) Then
                '    oRs = Aplicacion.IBCondiciones.TraerFiltrado("_PorId", dcfields(6).BoundText)
                '    If oRs.RecordCount > 0 Then
                '        mTopeIIBB = IIf(IsNull(oRs.Fields("ImporteTopeMinimoPercepcion").Value), 0, oRs.Fields("ImporteTopeMinimoPercepcion").Value)
                '        mIdProvinciaIIBB = IIf(IsNull(oRs.Fields("IdProvincia").Value), 0, oRs.Fields("IdProvincia").Value)
                '        If IIf(IsNull(oRs.Fields("IdProvinciaReal").Value), oRs.Fields("IdProvincia").Value, oRs.Fields("IdProvinciaReal").Value) = 2 And _
                '              DTFields(0).Value >= mFechaInicioVigenciaIBDirecto And _
                '              DTFields(0).Value <= mFechaFinVigenciaIBDirecto Then
                '            'mAlicuotaDirecta <> 0 And
                '            mvarPorcentajeIBrutos3 = mAlicuotaDirecta
                '        Else
                '            If mvarNetoGravado > mTopeIIBB And DTFields(0).Value >= mFecha1 Then
                '                If mvarIBCondicion = 2 Then
                '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcionConvenio").Value), 0, oRs.Fields("AlicuotaPercepcionConvenio").Value)
                '                    mvarMultilateral = "SI"
                '                Else
                '                    mvarPorcentajeIBrutos3 = IIf(IsNull(oRs.Fields("AlicuotaPercepcion").Value), 0, oRs.Fields("AlicuotaPercepcion").Value)
                '                End If
                '            End If
                '        End If
                '        mvarIBrutos3 = Round((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2)
                '    End If
                '    oRs.Close()
                '    oRs = Nothing
                'End If

                'If mvarEsAgenteRetencionIVA = "NO" And mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA Then
                '    mvarPercepcionIVA = Round(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, mvarDecimales)
                'End If

                '.Total = mvarNetoGravado + mvarIVA1 + mvarIVA2 + mvarIBrutos + mvarIBrutos2 + mvarIBrutos3 + mvarPercepcionIVA + _
                '         Val(txtTotal(6).Text) + Val(txtTotal(7).Text) + Val(txtTotal(10).Text)



                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////




                'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
                .TotalBonifEnItems = 0
                .ImporteIva1 = 0


                For Each det As OrdenCompraItem In .Detalles
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
                        myOrdenCompra.TotalBonifEnItems += .ImporteBonificacion
                        mvarIVA1 += .ImporteIVA
                        '////////////////////////
                    End With
                Next


                '////////////////////////
                'Asigno totales generales
                .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
                .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.PorcentajeBonificacion) / 100, 2)
                .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
                .ImporteIva1 = mvarIVA1
                .Total = .TotalSubGravado + mvarIVA1 '+ mvarIVA2
            End With
        End Sub







    End Class
End Namespace