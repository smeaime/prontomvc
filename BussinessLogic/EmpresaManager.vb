Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

	<DataObjectAttribute()> _
	Public Class EmpresaManager

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		Public Shared Function GetList(ByVal SC As String) As EmpresaList
            Try

                Return EmpresaDB.GetList(SC)
            Catch ex As Exception
                System.Diagnostics.Debug.WriteLine(Encriptar(SC))
                Throw
            End Try

        End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		  Public Shared Function GetEmpresasPorUsuario(ByVal SC As String, ByVal UserId As String) As EmpresaList
			Return EmpresaDB.EmpresasPorUsuario(SC, UserId)
		End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		  Public Shared Function AddUserInCompanies(ByVal SC As String, ByVal UserId As String, ByVal IdCompany As Integer) As Boolean
			Return EmpresaDB.AddUserInCompanies(SC, UserId, IdCompany)
		End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		  Public Shared Function DeleteUserInCompanies(ByVal SC As String, ByVal UserId As String, ByVal IdCompany As Integer) As Boolean
			Return EmpresaDB.DeleteUserInCompanies(SC, UserId, IdCompany)
		End Function

		<DataObjectMethod(DataObjectMethodType.Select, True)> _
		  Public Shared Function EmpresasDesasociadasPorUsuario(ByVal SC As String, ByVal UserId As String) As EmpresaList
			Return EmpresaDB.EmpresasDesasociadasPorUsuario(SC, UserId)
		End Function

	End Class
End Namespace
