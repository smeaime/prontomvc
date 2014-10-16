Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ProveedorManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ProveedorList
            Return ProveedorDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ProveedorDB.GetList_fm(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataSet



            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            'With dc
            '    .ColumnName = "ColumnaTilde"
            '    .DataType = System.Type.GetType("System.Int32")
            '    .DefaultValue = 0
            'End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wProveedores_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "wProveedores_T", -1)
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdProveedor").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ProveedorList
        '    Return ProveedorDB.GetListParaWebService(SC, Busqueda)
        'End Function



        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wProveedores_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Proveedor
            If id < 1 Then Return Nothing
            Return ProveedorDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getProveedorContacto As Boolean) As Proveedor
            Dim myProveedor As Proveedor
            myProveedor = ProveedorDB.GetItem(SC, id)
            If Not (myProveedor Is Nothing) AndAlso getProveedorContacto Then
                myProveedor.DetallesContactos = ProveedorContactoDB.GetList(SC, id)
            End If
            Return myProveedor
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As ProveedorContactoList
            Return ProveedorContactoDB.GetList(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myProveedor As Proveedor) As Integer
            myProveedor.Id = ProveedorDB.Save(SC, myProveedor)
            Return myProveedor.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myProveedor As Proveedor) As Boolean
            Return ProveedorDB.Delete(SC, myProveedor.Id)
        End Function
    End Class

End Namespace