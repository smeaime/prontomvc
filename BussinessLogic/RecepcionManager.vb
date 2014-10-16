Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Diagnostics
Imports System.Collections.Generic
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Reflection

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class RecepcionManager
        Inherits ServicedComponent





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
                .Columns("IdRecepcion").ColumnName = "Id"
                '.Columns("ComprobantePrv").ColumnName = "Numero"
                '.Columns("FechaComprobantePrv").ColumnName = "Fecha"
            End With


            dt.DefaultView.Sort = "Id DESC"
            Return dt.DefaultView.Table
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientes(ByVal SC As String, ByVal IdProveedor As Long) As System.Data.DataSet
            Return GetListTX(SC, "_PendientesDeComprobante", IdProveedor)
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
                ds = GeneralDB.TraerDatos(SC, "wRecepciones_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Recepciones_TX" & TX, Parametros)
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
                ds = GeneralDB.TraerDatos(SC, "wRecepciones_TX" & TX)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Recepciones_TX" & TX)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
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
                Dim IdPuntoVenta = IdPuntoVentaComprobanteRecepcionesegunSubnumero(SC, NumeroDePuntoVenta)


                Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
                Return oPto.Item("ProximoNumero")
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Return -1
            End Try

        End Function

        Shared Function IdPuntoVentaComprobanteRecepcionesegunSubnumero(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
            Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.ComprobantePrv)
            Return mvarPuntoVenta
        End Function

        

        


        





        

        















        



        


        












    End Class





End Namespace