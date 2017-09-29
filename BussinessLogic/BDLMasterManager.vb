Option Infer On

Imports System
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data
Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá
Imports System.Xml




Namespace Pronto.ERP.Bll

    Partial Public Class BDLMasterEmpresasManager

        Public Shared Function EmpresaPropietariaDeLaBase(ByVal conexionBase As String) As String
            Dim empresa As String
            Try
                Try
                    empresa = ParametroManager.TraerValorParametro2(conexionBase, ParametroManager.eParam2.WebConfiguracionEmpresa)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    empresa = ""
                End Try

                ' If empresa = "" Then empresa = EmpresaDefaultDel_webconfig()
                Return empresa
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
        End Function


        Public Shared Sub LlenarNodos(sc As String, rootElement As XmlElement)

            Dim desde = #1/1/2001#
            Dim hasta As Date = GetFirstDayInMonth(Now) ' #1/1/2001#
            Dim MAXITEMS = 100
            Dim s(MAXITEMS) As String

            s(0) = "Todas"

            For mes As Integer = 1 To MAXITEMS
                Dim mesresta As Date = DateAdd(DateInterval.Month, 1 - mes, hasta)
                If mesresta < desde Then Exit For
                s(mes) = mesresta.ToString("MMM yy")
            Next


            Dim teams = AddDynamicChildElementVB(rootElement, "", "por Períodos", "por Períodos")
            'AddDynamicChildElementVB(teams, "~/teams.aspx?name=Watford", "Watford", "Watford's team details")
            'Dim nodoporperiodos = New TreeNode("por Períodos")
            'nodoporperiodos.SelectAction = TreeNodeSelectAction.None



            Using db As New DataClassesRequerimientoDataContext(Encriptar(sc))
                Dim q = (From rm In db.linqRequerimientos
                        Select New With {.year = rm.FechaRequerimiento.Value.Year, .month = rm.FechaRequerimiento.Value.Month}) _
                        .Distinct.OrderBy(Function(i) i.year)

                Dim anios = q.Select(Function(i) i.Year).Distinct.OrderByDescending(Function(i) i)
                For Each anio As Integer In anios

                    Dim anionodo = AddDynamicChildElementVB(teams, "ProntoWeb/RequerimientosEsuco.aspx?año=" & anio, anio, anio)
                        'Dim anionodo = New TreeNode(anio, anio & " ", "", "ProntoWeb/RequerimientosEsuco.aspx?año=" & anio, "")

                    Dim aniotemp = anio
                    Dim meses = From rm In q Where rm.year = aniotemp Order By rm.month Descending Select rm.month

                    For Each Mes As Integer In meses
                        AddDynamicChildElementVB(anionodo, "ProntoWeb/RequerimientosEsuco.aspx?año=" & anio & "&mes=" & Mes, anio & " " & Mes, anio & " " & Mes)
                            'anionodo.ChildNodes.Add(New TreeNode(MonthName(Mes), anio & " " & Mes, "", "ProntoWeb/RequerimientosEsuco.aspx?año=" & anio & "&mes=" & Mes, ""))
                    Next

                        'AddDynamicChildElementVB(teams, "ProntoWeb/RequerimientosEsuco.aspx?año=" & anio & "&mes=" & Mes, anio & " " & Mes, anio & " " & Mes)

                        'nodoporperiodos.ChildNodes.Add(anionodo)
                Next
            End Using

            'nodoporperiodos.ChildNodes(5).Select()



        End Sub


        Private Shared Function AddDynamicChildElementVB(parentElement As XmlElement, url As String, title As String, description As String) As XmlElement

            Dim childElement = parentElement.OwnerDocument.CreateElement("siteMapNode")
            childElement.SetAttribute("url", url)
            childElement.SetAttribute("title", title)
            childElement.SetAttribute("description", description)


            parentElement.AppendChild(childElement)
            Return childElement
        End Function



        Public Shared Function GetConnectionStringEmpresa(ByVal UserId As String, ByVal idEmpresa As String, ByVal StringConnectionBDLmaster As String, Optional ByVal NombreEmpresa As String = "XXXXXXX") As String
            Dim empresaList As EmpresaList
            empresaList = EmpresaManager.GetEmpresasPorUsuario(StringConnectionBDLmaster, UserId)

            If empresaList Is Nothing Then
                'MandarMailDeError()
                'ErrHandler2.WriteError("No se encontró 
                Throw New Exception("No se encontró empresa para el usuario " & UserId)
                Return Nothing
            End If

            ' If NombreEmpresa Is Nothing Then  'se cuelga en MVC porque esta autenticado pero pierde el nombre de la base en la sesion

            Dim i As Integer = 0
            Dim cs As String = String.Empty
            For Each empresa As Pronto.ERP.BO.Empresa In empresaList
                If (empresaList(i).Id = idEmpresa Or empresaList(i).Descripcion.ToLower = NombreEmpresa.ToLower) Then
                    cs = empresaList(i).ConnectionString
                End If
                i = i + 1
            Next
            Return cs
        End Function



    End Class
End Namespace