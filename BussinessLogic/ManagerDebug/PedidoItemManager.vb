Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Namespace Pronto.ERP.Bll

	<DataObjectAttribute()> _
	<Transaction(TransactionOption.Required)> _
	Public Class PedidoItemManager
		Inherits ServicedComponent

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As PedidoItem
            Return PedidoItemDB.GetItem(SC, id)
		End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		Public Shared Function GetList(ByVal SC As String, ByVal IdPedido As Integer) As PedidoItemList
			Return PedidoItemDB.GetList(SC, IdPedido)
		End Function

		<DataObjectMethod(DataObjectMethodType.Update, True)> _
		 Public Shared Function Save(ByVal SC As String, ByVal myPedidoItem As PedidoItem) As Integer
			Try
				Dim PedidoItemId As Integer = PedidoItemDB.Save(SC, myPedidoItem)
				myPedidoItem.Id = PedidoItemId
				Return PedidoItemId
			Catch ex As Exception
				'ContextUtil.SetAbort()
			Finally
				'CType(myTransactionScope, IDisposable).Dispose()
			End Try
		End Function

		<DataObjectMethod(DataObjectMethodType.Delete, True)> _
		Public Shared Function Delete(ByVal SC As String, ByVal idPedidoItem As Integer) As Boolean
			Return PedidoItemDB.Delete(SC, idPedidoItem)
        End Function

       

	End Class
End Namespace