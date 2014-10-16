Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class ComparativaItemManager
        Inherits ServicedComponent

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As ComparativaItem
            Return ComparativaItemDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String, ByVal IdComparativa As Integer) As ComparativaItemList
            Return ComparativaItemDB.GetList(SC, IdComparativa)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update, True)> _
         Public Shared Function Save(ByVal SC As String, ByVal myComparativaItem As ComparativaItem) As Integer
            Try
                Dim ComparativaItemId As Integer = ComparativaItemDB.Save(SC, myComparativaItem)
                myComparativaItem.Id = ComparativaItemId
                Return ComparativaItemId
            Catch ex As Exception
                'ContextUtil.SetAbort()
            Finally
                'CType(myTransactionScope, IDisposable).Dispose()
            End Try
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal idComparativaItem As Integer) As Boolean
            Return ComparativaItemDB.Delete(SC, idComparativaItem)
        End Function



    End Class
End Namespace