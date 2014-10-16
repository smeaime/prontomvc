Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ComprobanteProveedorItemManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComprobanteProveedorItem
            Dim i As ComprobanteProveedorItem = ComprobanteProveedorItemDB.GetItem(SC, id)
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
            Return i
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, ByVal IdComprobanteProveedor As Integer) As ComprobanteProveedorItemList
            Dim x As ComprobanteProveedorItemList = ComprobanteProveedorItemDB.GetList(SC, IdComprobanteProveedor)

            For Each i As ComprobanteProveedorItem In x
                If i.CuentaGastoDescripcion = "" Then

                    ' a diferencia de los detalles comunes, que se vinculan directamente con una tabla,
                    ' acá me tengo que traer la IdCuentaGasto a partir de la IdCuenta
                    Dim ds As System.Data.DataSet
                    Try
                        ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", i.IdCuenta) 'traigo los datos de la cuenta
                        ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "CuentasGastos", ds.Tables(0).Rows(0).Item("IdCuentaGasto"))
                        i.IdCuentaGasto = ds.Tables(0).Rows(0).Item("IdCuentaGasto")
                        i.CuentaGastoDescripcion = ds.Tables(0).Rows(0).Item("Descripcion")
                    Catch ex As Exception

                    End Try
                End If
            Next

            Return x

        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
         Public Shared Function Save(ByVal SC As String, ByVal myComprobanteProveedorItem As ComprobanteProveedorItem) As Integer
            Try
                Dim ComprobanteProveedorItemId As Integer = ComprobanteProveedorItemDB.Save(SC, myComprobanteProveedorItem)
                myComprobanteProveedorItem.Id = ComprobanteProveedorItemId
                Return ComprobanteProveedorItemId
            Catch ex As Exception
                'ContextUtil.SetAbort()
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal idComprobanteProveedorItem As Integer) As Boolean
            Return ComprobanteProveedorItemDB.Delete(SC, idComprobanteProveedorItem)
        End Function



    End Class
End Namespace