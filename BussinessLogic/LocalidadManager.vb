Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class LocalidadManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As LocalidadList
            Return LocalidadDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return LocalidadDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wLocalidades_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Localidad
            Return LocalidadDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myLocalidad As Localidad) As Integer
            myLocalidad.Id = LocalidadDB.Save(SC, myLocalidad)
            Return myLocalidad.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myLocalidad As Localidad) As Boolean
            Return LocalidadDB.Delete(SC, myLocalidad.Id)
        End Function
    End Class

End Namespace