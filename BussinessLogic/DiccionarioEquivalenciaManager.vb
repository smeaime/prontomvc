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

Namespace Pronto.ERP.Bll

    <DataObjectAttribute()> _
    <Transaction(TransactionOption.Required)> _
    Public Class DiccionarioEquivalenciasManager
        Inherits ServicedComponent


        Const Tabla = "DiccionarioEquivalencias"
        Const IdTabla = "IdDiccionarioEquivalencia"






        Public Shared Function Fetch(ByVal SC As String) As DataTable

            'Return EntidadManager.GetListTX(SC, "DiccionarioEquivalencias", "TT", Nothing).Tables(0)
            'Return EntidadManager.ExecDinamico(SC, "DiccionarioEquivalencias_TT")


            Return EntidadManager.ExecDinamico(SC, "SELECT *  " & _
                        "  " & _
                        " FROM " & Tabla & " A " & _
                        "  " & _
                        "")
        End Function




        '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


        Public Shared Function BuscarEquivalencia(ByVal SC As String, ByVal s As String) As String

            'puede ser una cadena en blanco, y encuentra equivalencias ?
            If Trim(s) = "" Then
                Return ""
            End If

            Dim dtBuscar = ExecDinamico(SC, "SELECT * FROM DiccionarioEquivalencias WHERE Palabra=" & _c(s) & "")

            If dtBuscar.Rows.Count = 0 Then
                Return ""
            Else
                Return dtBuscar.Rows(0).Item("Traduccion")
            End If

        End Function



        Public Shared Function TraerMetadata(ByVal SC As String, ByVal Descripcion As String) As Data.DataTable

            Dim dtBuscar = ExecDinamico(SC, "SELECT * FROM DiccionarioEquivalencias WHERE Palabra='" & _c(Descripcion) & "'")

            If dtBuscar.Rows.Count = 0 Then
                Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
            Else
                Return dtBuscar
            End If
        End Function

        Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As Data.DataTable
            If id = -1 Then
                Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
            Else
                Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
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

            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
            myConnection.Open()

            Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
            Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
            adapterForTable1.Update(dt)

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

            Dim myConnection As SqlConnection = New SqlConnection(encriptar(SC))
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