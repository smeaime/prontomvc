Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class PaisManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As PaisList
            Return PaisDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return PaisDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wPaises_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Pais
            Return PaisDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myPais As Pais) As Integer
            myPais.Id = PaisDB.Save(SC, myPais)
            Return myPais.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myPais As Pais) As Boolean
            Return PaisDB.Delete(SC, myPais.Id)
        End Function
    End Class

End Namespace