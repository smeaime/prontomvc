Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class PresupuestoItemManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As PresupuestoItem
            Return PresupuestoItemDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, ByVal IdPresupuesto As Integer) As PresupuestoItemList
            Return PresupuestoItemDB.GetList(SC, IdPresupuesto)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
         Public Shared Function Save(ByVal SC As String, ByVal myPresupuestoItem As PresupuestoItem) As Integer
            Try
                Dim PresupuestoItemId As Integer = PresupuestoItemDB.Save(SC, myPresupuestoItem)
                myPresupuestoItem.Id = PresupuestoItemId
                Return PresupuestoItemId
            Catch ex As Exception
                'ContextUtil.SetAbort()
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal idPresupuestoItem As Integer) As Boolean
            Return PresupuestoItemDB.Delete(SC, idPresupuestoItem)
        End Function

        '////////////////////////
        'Cálculo del precio item
        Public Shared Function TotalItem(ByVal i As PresupuestoItem) As Double
            With i
                Dim mImporte = Val(.Precio) * Val(.Cantidad)
                .ImporteBonificacion = Math.Round(mImporte * Val(.PorcentajeBonificacion) / 100, 4)
                .ImporteIVA = Math.Round((mImporte - .ImporteBonificacion) * Val(.PorcentajeIVA) / 100, 4)
                .ImporteTotalItem = mImporte - .ImporteBonificacion + .ImporteIVA
                Return .ImporteTotalItem
            End With
        End Function


    End Class
End Namespace