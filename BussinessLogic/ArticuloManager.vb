Imports System
Imports System.ComponentModel
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    Public Class ArticuloManager
        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList(ByVal SC As String) As ArticuloList
            Return ArticuloDB.GetList(SC)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return ArticuloDB.GetList_fm(SC)
        End Function


        'Public Function GetPrecioPorLista(ByVal SC As String, ByVal IdArticulo As Long, ByVal IdListaPrecios As Long, Optional ByVal IdMoneda As Long = Nothing) As Double
        '    Return ListaPreciosManager.GetPrecioPorLista(SC, IdArticulo, IdListaPrecios, IdMoneda)
        'End Function


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
                ds = GeneralDB.TraerDatos(SC, "wArticulos_T", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Articulos_TT")
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdArticulo").ColumnName = "Id"
                '.Columns("NumeroRequerimiento").ColumnName = "Numero"
                '.Columns("FechaRequerimiento").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListCombo(ByVal SC As String) As System.Data.DataSet
            Return GeneralDB.TraerDatos(SC, "wArticulos_TL")
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, False)> _
        Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As Articulo
            Return ArticuloDB.GetItem(SC, id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Update Or DataObjectMethodType.Insert, True)> _
        Public Shared Function Save(ByVal SC As String, ByVal myArticulo As Articulo) As Integer
            myArticulo.Id = ArticuloDB.Save(SC, myArticulo)
            Return myArticulo.Id
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal myArticulo As Articulo) As Boolean
            Return ArticuloDB.Delete(SC, myArticulo.Id)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function Delete(ByVal SC As String, ByVal idArticulo As Long) As Boolean
            Return ArticuloDB.Delete(SC, idArticulo)
        End Function

        <DataObjectMethod(DataObjectMethodType.Delete, True)> _
        Public Shared Function GetArticulos(ByVal SC As String, ByVal codigo As String, ByVal description As String, ByVal idRubro As Integer) As ArticuloList
            'Dim where As String = Nothing
            'If idArticulo > 0 Then
            '    where = String.Format("Articulos.IdArticulo = {0}", idArticulo)
            'Else
            '    If idRubro > 0 Then
            '        where = String.Format("Articulos.IdRubro = {0}", idRubro)
            '    End If
            '    If description <> String.Empty Then
            '        If where = Nothing Then
            '            where = String.Format("Articulos.i  Articulos.Descripcion LIKE '%'{0}'%'", description)
            '        Else
            '            where += String.Format(" and Articulos.i  Articulos.Descripcion LIKE '%'{0}'%'", description)
            '        End If
            '    End If
            'End If

            Return ArticuloDB.GetArticulos(SC, codigo, description, idRubro)
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
 Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
            ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
            Dim ds As DataSet
            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With


            Try
                ds = GeneralDB.TraerDatos(SC, "wArticulos_TX" & TX, Parametros)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "Articulos_TX" & TX, Parametros)
            End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function

        '<DataObjectMethod(DataObjectMethodType.Delete, True)> _
        'Public Shared Function GetListParaWebService(ByVal SC As String, ByVal Busqueda As String) As ArticuloList
        '    Return ArticuloDB.GetListParaWebService(SC, Busqueda)
        'End Function



        Public Shared Function GetPrecioPorLista(ByVal SC As String, ByVal IdArticulo As Long, Optional ByVal IdListaPrecios As Long = 0, Optional ByVal IdMoneda As Long = Nothing) As Double
            Return ListaPreciosManager.GetPrecioPorLista(SC, IdArticulo, IdListaPrecios, IdMoneda)
        End Function


    End Class

End Namespace