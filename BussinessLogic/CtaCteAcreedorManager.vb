Imports System
Imports System.ComponentModel
Imports System.Data.SqlClient
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Transactions
Imports System.EnterpriseServices
Imports System.Configuration
'Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports adodb.DataTypeEnum
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class CtaCteAcreedorManager
        Inherits ServicedComponent


        Const Tabla = "CuentasCorrientesAcreedores"
        Const IdTabla = "IdCtaCte"


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
Public Shared Function GetList(ByVal SC As String) As NotaDeDebitoList
            Return NotaDeDebitoDB.GetList(SC)
        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As NotaDeDebitoList
            Dim NotaDeDebitoList As Pronto.ERP.BO.NotaDeDebitoList = NotaDeDebitoDB.GetListByEmployee(SC, IdSolicito)
            If NotaDeDebitoList IsNot Nothing Then
                Select Case orderBy
                    Case "Fecha"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareFecha)
                    Case "Obra"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareObra)
                    Case "Sector"
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareSector)
                    Case Else 'Ordena por id
                        NotaDeDebitoList.Sort(AddressOf Pronto.ERP.BO.NotaDeDebitoList.CompareId)
                End Select
            End If
            Return NotaDeDebitoList
        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
            Return NotaDeDebitoDB.GetList_fm(SC)
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
                ds = GeneralDB.TraerDatos(SC, "CtasCtesA_TX_TT", -1)
            Catch ex As Exception
                ds = GeneralDB.TraerDatos(SC, "CtasCtesA_TX_TT", -1, -1)
                'ds = GeneralDB.TraerDatos(SC, "CtasCtesA_TT")
            End Try


            'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
            'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
            With ds.Tables(0)
                .Columns("IdProveedor").ColumnName = "Id"
                .Columns("Codigo").ColumnName = "Numero"
                '.Columns("FechaNotaDeDebito").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            Return ds

        End Function

        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXDetallesPendientes(ByVal SC As String) As System.Data.DataSet
            Return GetListTX(SC, "_Pendientes1", "P")
        End Function



        Public Shared Function Saldo(ByVal SC As String, ByVal IdCliente As Long, Optional ByVal IdMoneda As Long = 1) As Double
            Dim dt As Data.DataTable
            If IdMoneda = 1 Then
                dt = EntidadManager.TraerFiltrado(SC, enumSPs.CtasCtesA_TXTotal, IdCliente, -1, #1/1/2100#, -1)
            Else
                dt = EntidadManager.TraerFiltrado(SC, enumSPs.CtasCtesA_TXTotal_Dolares, IdCliente, -1, #1/1/2100#)
            End If

            Return dt.Rows(0).Item("SaldoCta")

        End Function


        <DataObjectMethod(DataObjectMethodType.Select, True)> _
        Public Shared Function GetListTXParams(ByVal SC As String, ByVal TX As String, Optional ByVal Param1 As String = Nothing, Optional ByVal Param2 As String = Nothing, Optional ByVal Param3 As String = Nothing, Optional ByVal Param4 As String = Nothing, Optional ByVal Param5 As String = Nothing, Optional ByVal Param6 As String = Nothing) As System.Data.DataSet
            'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una


            If Param6 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1, Param2, Param3, Param4, Param5, Param6)
            ElseIf Param5 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1, Param2, Param3, Param4, Param5)
            ElseIf Param4 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1, Param2, Param3, Param4)
            ElseIf Param3 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1, Param2, Param3)
            ElseIf Param2 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1, Param2)
            ElseIf Param1 IsNot Nothing Then
                Return GetListTX(SC, TX, Param1)
            Else
                Return GetListTX(SC, TX)
            End If

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


            'Try
            'ds = GeneralDB.TraerDatos(SC, "wCtasCtesA_TX" & TX, Parametros)
            'Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "CtasCtesA_TX" & TX, Parametros)
            'End Try
            ds.Tables(0).Columns.Add(dc)
            Return ds
        End Function





        Public Shared Function Fetch(ByVal SC As String) As DataTable

            'Return EntidadManager.GetListTX(SC, "CtaCtes", "TT", Nothing).Tables(0)
            'Return EntidadManager.ExecDinamico(SC, "CtaCtes_TT")


            Return EntidadManager.ExecDinamico(SC, "SELECT *  " & _
                        "  " & _
                        " FROM " & Tabla & " A " & _
                        "  " & _
                        "")
        End Function




        '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


        Public Shared Function BuscarEquivalencia(ByVal SC As String, ByVal s As String) As String
            Dim dtBuscar = ExecDinamico(SC, "SELECT * FROM CtaCtes WHERE Palabra='" & s & "'")

            If dtBuscar.Rows.Count = 0 Then
                Return ""
            Else
                Return dtBuscar.Rows(0).Item("Traduccion")
            End If

        End Function



        Public Shared Function TraerMetadata(ByVal SC As String, ByVal Descripcion As String) As Data.DataTable
            Dim dtBuscar = ExecDinamico(SC, "SELECT * FROM CtaCtes WHERE Palabra='" & Descripcion & "'")

            If dtBuscar.Rows.Count = 0 Then
                Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
            Else
                Return dtBuscar
            End If
        End Function

        Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal IdCtaCteD As Integer = -1) As Data.DataTable
            'http://social.msdn.microsoft.com/Forums/en-US/adodotnetdataproviders/thread/0cd9d46c-d822-41d4-8456-c921a8632d27/
            'IMPORTANTE:
            'No usar dim sarasa = tblOrder.NewRow
            'sino 
            'Dim drCurrentOrder AS DATAROW = tblOrder.NewRow
            'because you haven't declared drCurrentOrder as a datarow it will be declared as Object.  
            'When you pass it to Rows.Add it is using the overloaded method that accepts an object array instead 
            'of the method that accepts a DataRow.

            If IdCtaCteD = -1 Then
                Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
            Else
                Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & IdCtaCteD)
            End If
        End Function

        Public Shared Function Insert(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)


            'está difícil actualizar el identity usando esto
            'http://stackoverflow.com/questions/136536/possible-to-retrieve-identity-column-value-on-insert-using-sqlcommandbuilder-wit
            'Return ExecDinamico(SC, "SELECT " & Tabla & " = SCOPE_IDENTITY()").Rows(0).Item(0) 'no anduvo
            Dim r = ExecDinamico(SC, "SELECT TOP 1 " & IdTabla & " from  " & Tabla & "  order by " & IdTabla & " DESC")
            dt.Rows(0).Item(0) = r.Rows(0).Item(0) 'asigno el ID
            Return dt.Rows(0).Item(0)

        End Function






        Public Shared Function Update(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
            '// Write your own Insert statement blocks 


            'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
            ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
            'y esto? http://www.vbforums.com/showthread.php?t=352219


            ''convertir datarow en datatable
            'Dim ds As New DataSet
            'ds.Tables.Add(dr.Table.Clone())
            'ds.Tables(0).ImportRow(dr)

            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            'si te tira error acá, ojito con estar usando el dataset q usaste para el 
            'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
            adapterForTable1.Update(dt)

        End Function


        Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
            '// Write your own Delete statement blocks. 
            ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
        End Function

    End Class
End Namespace