Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ProvinciaManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ProvinciaList
            Return ProvinciaDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ProvinciaDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wProvincias_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Provincia
            Return ProvinciaDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myProvincia As Provincia) As Integer
            myProvincia.Id = ProvinciaDB.Save(SC, myProvincia)
            Return myProvincia.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myProvincia As Provincia) As Boolean
            Return ProvinciaDB.Delete(SC, myProvincia.Id)
        End Function
    End Class

End Namespace