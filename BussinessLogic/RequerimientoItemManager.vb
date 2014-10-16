Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Namespace Pronto.ERP.Bll

	<DataObjectAttribute()> _
	<Transaction(TransactionOption.Required)> _
	Public Class RequerimientoItemManager
		Inherits ServicedComponent

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As RequerimientoItem
			Return RequerimientoItemDB.GetItem(SC, id)
		End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		Public Shared Function GetList(ByVal SC As String, ByVal IdRequerimiento As Integer) As RequerimientoItemList
			Return RequerimientoItemDB.GetList(SC, IdRequerimiento)
		End Function

		<DataObjectMethod(DataObjectMethodType.Update, True)> _
		 Public Shared Function Save(ByVal SC As String, ByVal myRequerimientoItem As RequerimientoItem) As Integer
			Try
				Dim RequerimientoItemId As Integer = RequerimientoItemDB.Save(SC, myRequerimientoItem)
				myRequerimientoItem.Id = RequerimientoItemId
				Return RequerimientoItemId
			Catch ex As Exception
				'ContextUtil.SetAbort()
			Finally
				'CType(myTransactionScope, IDisposable).Dispose()
			End Try
		End Function

		<DataObjectMethod(DataObjectMethodType.Delete, True)> _
		Public Shared Function Delete(ByVal SC As String, ByVal idRequerimientoItem As Integer) As Boolean
			Return RequerimientoItemDB.Delete(SC, idRequerimientoItem)
        End Function

       

	End Class
End Namespace