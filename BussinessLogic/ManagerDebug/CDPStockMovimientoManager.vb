
Option Infer On

Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Data
Imports System.Diagnostics
Imports System.Linq
Imports System.Xml
Imports System.Collections.Generic



Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class CDPStockMovimientoManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As DataSetCDPmovimientos
            If id <= 0 Then Return Nothing

            GetCopyOfItem = GetItem(SC, id)
            'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
            'GetCopyOfItem.Id = -1
            'For Each item As CDPStockMovimientoItem In GetCopyOfItem.Detalles
            '    item.Id = -1
            'Next
        End Function



        Shared Function GetList(ByVal SC As String) As DataSetCDPmovimientos

            Dim ds As New DataSetCDPmovimientos
            Dim adapter As New DataSetCDPmovimientosTableAdapters.VistaCartasPorteMovimientosTableAdapter

            Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(SC)) ' Properties.Settings.Default.DistXsltDbConnectionString)
            Dim desiredConnectionString = builder.ConnectionString

            '// Set it directly on the adapter.
            adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
            adapter.Fill(ds.VistaCartasPorteMovimientos)

            Return ds
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


            'Try
            'ds = GeneralDB.TraerDatos(SC, "wCDPStockMovimientos_T", -1)
            'Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "wCDPStockMovimientos_TT")
            'End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdCDPStockMovimiento").ColumnName = "Id"
                .Columns("CDPStockMovimiento").ColumnName = "Numero"
                '.Columns("FechaCDPStockMovimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Dim dt As DataTable = ds.Tables(0)
            dt.DefaultView.Sort = "Id DESC"
            Return dt.DefaultView.Table
        End Function

     
        

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As DataSetCDPmovimientos

            Dim myCDPStockMovimiento As New DataSetCDPmovimientos

            If id > 0 Then 'si es menor, devuelvo el coso vacío para que lo de de alta
                Dim adapter As New DataSetCDPmovimientosTableAdapters.CartasPorteMovimientosTableAdapter
                Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(SC)) ' Properties.Settings.Default.DistXsltDbConnectionString)
                Dim desiredConnectionString = builder.ConnectionString

                '// Set it directly on the adapter.
                adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx

                adapter.FillOne(myCDPStockMovimiento.CartasPorteMovimientos, id)
                'adapter.Fill(myCDPStockMovimiento.CartasPorteMovimientos, id)
            End If


            Return myCDPStockMovimiento
        End Function







        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) 'As CDPStockMovimientoItemList
            'Return CDPStockMovimientoItemDB.GetList(SC, id)
        End Function

        Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myCDPStockMovimiento As CDPStockMovimiento)
            With myCDPStockMovimiento
                'Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

                'estos debieran ser READ only, no?
                '.IdCodigoIva = ocli.IdCodigoIva
                '.TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
                .IdPuntoVenta = IdPuntoVentaComprobanteCDPStockMovimientoSegunSubnumeroYLetra(SC, .PuntoVenta)
                .Numero = CDPStockMovimientoManager.ProximoNumeroPorPuntoVentaOTalonario(SC, .IdPuntoVenta)

            End With
        End Sub

        Shared Function BuscarIdMovimientoQueCorrespondeAlIdCarta(ByVal SC As String, ByVal IdCartaDePorte As Long) As Long
            'Dim dt = EntidadManager.ExecDinamico(SC, "SELECT IdMovimiento from CartasPorteMovimientos where IdCartaDePorte=" & IdCartaDePorte)

            Dim list = CDPStockMovimientoManager.GetList(SC)
            Dim id = From i In list.VistaCartasPorteMovimientos _
                     Where Not i.IsIdCartaDePorteNull AndAlso i.IdCartaDePorte = IdCartaDePorte _
                     Select i.IdCDPMovimiento

            'hacé que el property IdCartaDePorte del dataset tipado no levante un error si es DBNull (q devuelva Nothing, para safar)

            If id.Count > 1 Then
                Err.Raise(22222)
            ElseIf id.Count = 0 Then
                Return -1
            else
                Return id.Single 'verificar que esté "Imports System.Linq"
            End If
        End Function


        Public Shared Function Save(ByVal SC As String, ByVal IdCartaDePorte As Long, ByVal Titular As Long, ByVal Entregador As Long, ByVal IdArticulo As Long, ByVal Peso As Double, ByVal EsEntrada As Boolean, ByVal IdPuerto As Long)

            Dim idMov = BuscarIdMovimientoQueCorrespondeAlIdCarta(SC, IdCartaDePorte)
            Dim mov As DataSetCDPmovimientos = GetItem(SC, idMov)
            Dim nr As DataSetCDPmovimientos.CartasPorteMovimientosRow


            If idMov = -1 Then
                'crear movimiento nuevo
                nr = mov.CartasPorteMovimientos.NewCartasPorteMovimientosRow
            Else
                'lo cargo
                nr = mov.CartasPorteMovimientos(0)
            End If


            With nr
                .IdExportadorOrigen = Titular
                .IdExportadorDestino = Entregador
                .IdArticulo = IdArticulo
                .Puerto = IdPuerto
                .Cantidad = Peso
                .IdCartaDePorte = IdCartaDePorte
                .Entrada_o_Salida = IIf(EsEntrada, 1, 2)
            End With


            Try

                If idMov = -1 Then
                    With nr
                        .IdAjusteStock = ClaseMigrar.GrabarAjusteStockConCompronto(SC, -1, .IdArticulo, IIf(.Entrada_o_Salida = 1, .Cantidad, .Cantidad * -1))
                        mov.CartasPorteMovimientos.AddCartasPorteMovimientosRow(nr)
                    End With
                End If

            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try


            If Save(SC, mov) = -1 Then ErrHandler.WriteAndRaiseError("No es valido el movimiento que genera la carta")

        End Function




        <DataObjectMethod(DataObjectMethodType.Update, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myCDPStockMovimiento As DataSetCDPmovimientos) As Integer
            'Dim myTransactionScope As TransactionScope = New TransactionScope
            Try
                If Not IsValid(SC, myCDPStockMovimiento) Then Return -1

                Dim adapter As New DataSetCDPmovimientosTableAdapters.CartasPorteMovimientosTableAdapter

                Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(SC)) ' Properties.Settings.Default.DistXsltDbConnectionString)
                Dim desiredConnectionString = builder.ConnectionString

                '// Set it directly on the adapter.
                adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx


                adapter.Update(myCDPStockMovimiento.CartasPorteMovimientos) 'tanto para el update como para el insert, se usa "Update"

                With myCDPStockMovimiento.CartasPorteMovimientos(0)

                    Dim esNuevo As Boolean
                    If .IdCDPMovimiento = -1 Then esNuevo = True Else esNuevo = False
                    If esNuevo Then
                        'RefrescarTalonario(SC, myCDPStockMovimiento)
                    End If

                    '///////////////////////////////////////////////////////////////////////////////////////////

                    Try
                        ClaseMigrar.GrabarAjusteStockConCompronto(SC, .IdAjusteStock, .IdArticulo, IIf(.Entrada_o_Salida = 1, .Cantidad, .Cantidad * -1))
                    Catch ex As Exception
                        ErrHandler.WriteError(ex)
                    End Try

                End With


                Dim CDPStockMovimientoId As Integer ' = CDPStockMovimientoDB.Save(SC, myCDPStockMovimiento)



                Return CDPStockMovimientoId
            Catch ex As Exception
                'ContextUtil.SetAbort()
                ErrHandler.WriteError(ex)
                Debug.Print(ex.ToString)
                Return -1
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myCDPStockMovimiento As CDPStockMovimiento) As Boolean
            'Return CDPStockMovimientoDB.Delete(SC, myCDPStockMovimiento.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal empleado As Empleado) As Integer
            'Return CDPStockMovimientoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Anular(ByVal SC As String, ByVal IdCDPStockMovimiento As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

            'Dim myCDPStockMovimiento As Pronto.ERP.BO.CDPStockMovimiento = GetItem(SC, IdCDPStockMovimiento)
            Dim myCDPStockMovimiento As DataSetCDPmovimientos = CDPStockMovimientoManager.GetItem(SC, IdCDPStockMovimiento)

            With myCDPStockMovimiento.CartasPorteMovimientos(0)
                '.MotivoAnulacion = motivo
                '.FechaAnulacion = Today
                '.UsuarioAnulacion = IdUsuario
                .Anulada = "SI"

                ''.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
                '.Cumplido = "AN"
                '.Anulado = "SI"
                '.IdAutorizaAnulacion = IdUsuario

                'For Each i As CDPStockMovimientoItem In .Detalles
                '    With i
                '        .Cumplido = "AN"
                '        '.EnviarEmail = 1
                '    End With
                'Next


                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////
                'reviso si hay facturas que esten imputadas al CDPStockMovimiento que se quiere anular
                'Dim mFacturas As String
                'mFacturas = ""
                'Dim oRs As DataSet '= CDPStockMovimientoManager.GetListTX(SC, "_FacturasPorIdCDPStockMovimiento", IdCDPStockMovimiento)
                'For Each i As DataRow In oRs.Tables(0).Rows
                '    mFacturas = mFacturas & i.Item("Factura") & vbCrLf
                'Next

                'oRs = Nothing
                'If Len(mFacturas) > 0 Then
                '    Return "El CDPStockMovimiento que quiere anular ya ha sido facturado en los comprobantes" & vbCrLf & _
                '             mFacturas & "Anule primero las facturas y luego intente nuevamente"
                'End If
                '////////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////////


                CDPStockMovimientoManager.Save(SC, myCDPStockMovimiento)
            End With



            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            'ajusto el stock
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            'EntidadManager.Tarea(SC, "CDPStockMovimientos_AjustarStockCDPStockMovimientoAnulado", IdCDPStockMovimiento)

            'Dim oRs2 As DataSet ' = CDPStockMovimientoManager.GetListTX(SC, "_DetallesPorIdCDPStockMovimiento", IdCDPStockMovimiento)
            'For Each i As DataRow In oRs2.Tables(0).Rows
            '    If Not IsNull(i.Item("IdArticulo")) Then
            '        EntidadManager.Tarea(SC, "Articulos_RecalcularCostoPPP_PorIdArticulo", i.Item("IdArticulo"))
            '    End If
            'Next
            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////




            'Return CDPStockMovimientoDB.Anular(SC, IdCDPStockMovimiento, IdUsuario, motivo)
        End Function






        Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
            'Return CDPStockMovimientoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
        End Function


        Public Shared Function IsValid(ByVal SC As String, ByRef myCDPStockMovimiento As DataSetCDPmovimientos, Optional ByRef ms As String = "") As Boolean

            With myCDPStockMovimiento.CartasPorteMovimientos(0)

                Dim eliminados As Integer
                'verifico el detalle
                'For Each det As CDPStockMovimientoItem In myCDPStockMovimiento.Detalles
                '    If det.IdArticulo = 0 Then 'verifico que no pase un renglon en blanco
                '        det.Eliminado = True
                '    End If
                '    '.TipoDesignacion = "CMP" 'esto hay que cambiarlo, no?
                '    'If .TipoDesignacion = "" Then .TipoDesignacion = "S/D" 'esto hay que cambiarlo, no?
                '    If det.Cumplido <> "SI" And det.Cumplido <> "AN" Then det.Cumplido = "NO"
                '    '.Cumplido = IIf(.Cumplido = "SI", "SI", "NO") ' y qué pasa si es "AN"?


                '    If det.Eliminado Then eliminados = eliminados + 1
                'Next


                'If .Detalles.Count = eliminados Or .Detalles.Count = 0 Then
                '    ms = "La lista de items no puede estar vacía"
                '    Return False
                'End If


                If .Puerto < 0 Then
                    ms = "Debe indicar el valor declarado"
                    Return False
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

        Shared Function IdPuntoVentaComprobanteCDPStockMovimientoSegunSubnumeroYLetra(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            ' Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.CDPStockMovimiento)
            '  Return mvarPuntoVenta
        End Function

        Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdCDPStockMovimiento As Long) As Integer

            Dim oRs As ADODB.Recordset
            Dim UltItem As Integer



            oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetCDPStockMovimientos", "TX_Req", IdCDPStockMovimiento))

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

        Public Shared Function UltimoItemDetalle(ByVal myCDPStockMovimiento As CDPStockMovimiento) As Integer

            'For Each i As CDPStockMovimientoItem In myCDPStockMovimiento.Detalles
            '    If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
            'Next

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



        'Public Shared Sub RecalcularTotales(ByRef myCDPStockMovimiento As CDPStockMovimiento)


        '    Dim mvarSubTotal, mvarIVA1 As Single

        '    With myCDPStockMovimiento


        '        'tendrías que dejarlo como en pronto, donde se usan las variables locales para los calculos
        '        .TotalBonifEnItems = 0
        '        .ImporteIva1 = 0


        '        For Each det As CDPStockMovimientoItem In .Detalles
        '            With det
        '                '////////////////////////
        '                'codigo comentado: así lo hacía antes de mover todo al manager
        '                'Dim temp As Decimal
        '                'txtSubtotal.Text = StringToDecimal(txtSubtotal.Text) + det.Cantidad * det.Precio
        '                'temp = (det.Cantidad * det.Precio * ((100 + det.PorcentajeIVA) / 100) * ((100 + det.PorcentajeBonificacion) / 100))
        '                'temp = temp + txtTotal.Text 'StringToDecimal(txtTotal.Text)
        '                'Debug.Print(temp)
        '                'txtTotal.Text = temp
        '                '////////////////////////


        '                '////////////////////////
        '                'Cálculo del item
        '                Dim mImporte = Val(.Precio) * Val(.Cantidad)
        '                .ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
        '                .ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
        '                .ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
        '                '////////////////////////


        '                '////////////////////////
        '                'Sumador de totales
        '                mvarSubTotal += mImporte
        '                myCDPStockMovimiento.TotalBonifEnItems += .ImporteBonificacion
        '                mvarIVA1 += .ImporteIVA
        '                '////////////////////////
        '            End With
        '        Next


        '        '////////////////////////
        '        'Asigno totales generales
        '        .SubTotal = mvarSubTotal '+ .TotalBonifEnItems - mvarIVA1 'no sé en qué casos va esto
        '        .TotalBonifSobreElTotal = Math.Round((mvarSubTotal - .TotalBonifEnItems) * Val(.Bonificacion) / 100, 2)
        '        .TotalSubGravado = mvarSubTotal - .TotalBonifSobreElTotal - .TotalBonifEnItems
        '        .ImporteIva1 = mvarIVA1
        '        .Total = .TotalSubGravado + mvarIVA1 '+ mvarIVA2
        '    End With

        'End Sub








    End Class
End Namespace