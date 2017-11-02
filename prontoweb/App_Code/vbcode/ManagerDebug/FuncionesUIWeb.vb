Option Infer On


Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.FileIO
Imports Microsoft.VisualBasic.Strings
Imports Microsoft.Reporting.WebForms
Imports System
Imports System.Diagnostics
Imports System.Web.UI
Imports System.Web

Imports System.Web.Security


Imports System.Xml

Imports System.Reflection
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports Word = Microsoft.Office.Interop.Word
Imports System.IO

Imports System.Web.UI.WebControls

Imports System.Data

Imports System.Linq
Imports Pronto.ERP.Bll.EntidadManager

Imports FuncionesUIWebCSharp
Imports ProntoCSharp.FuncionesUIWebCSharpEnDllAparte

Imports OfficeOpenXml 'EPPLUS, no confundir con el OOXML

Imports CodeEngine.Framework.QueryBuilder
Imports System.Data.SqlClient

Imports System.Data.OleDb

Imports CartaDePorteManager

Imports System.Text

Imports System.Text.RegularExpressions

'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'Why Debugger won't let me edit and continue
'http://social.msdn.microsoft.com/Forums/en/vsdebug/thread/38b8fe15-c76b-44f2-a3cb-730765bec137


'Me deja si uso un Web Aplication Project (ese sí tiene la opcion "Edit and continue" en 
'la pestaña Web de las propiedades. Pero el proyecto que usamos en pronto web es un Web Site Project.....


'http://stackoverflow.com/questions/2387985/edit-and-continue-in-asp-net-web-projects

'http://stackoverflow.com/questions/76349/edit-source-code-when-debugging

'http://forums.asp.net/t/1271807.aspx

'This is not the same. With Web site you can do "edit and refresh", i.e. edit page 
'and refresh it in the browser. This causes recompilation and new dll loaded in ASP.NET.
' Edit and continue is different since it does not require recompilation or browser
' refresh - code changes in place, without new dll produced. This is not supported in Web sites.


'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'Monday, June 08, 2009 7:14 PM
'JaedenRuiner



'0
'Sign In to Vote
'Okay,

'So, i've been debugging with VS for some time now, and when I have two projects open, a DLL Class Assembly, and an EXE application, I used to be able to step into source from the DLL, and Edit and Continue in the source files for the DLL.  Now granted I was having some weird configuration glitches so I recent ran a reset settings on VS, but isn't Edit and continue default?  Why won't it allow me to edit the dll source files while debugging like it used to?

'Thanks
'Jaeden "Sifo Dyas" al'Raec Ruiner
'"Never Trust a computer. Your brain is smarter than any micro-chip."

'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'//////////////////////////////////////////////////////////////////////////////////
'Public Class ObjectExtensions

'    public function  NullSafeToString(this object obj) As string

'        return obj != null ? obj.ToString() : String.Empty;
'    End Function

'End Class



Public Module ProntoFuncionesUIWeb

    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////


    Public Function AdjuntarImagenEnZip(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, forzarID As Long, ByRef sError As String, DirApp As String) As String

        Dim DIRTEMP As String = DirApp & "\Temp\"
        Dim DIRFTP As String = DirApp & "\DataBackupear\"




        Dim destzip = DIRTEMP + "zipeado.zip"
        Dim MyFile3 As New FileInfo(destzip)
        Try
            If MyFile3.Exists Then
                MyFile3.Delete()
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        If False Then
            'no borrar todos los archivos

            Dim files = Directory.GetFiles(DIRTEMP)
            For Each file As String In files
                IO.File.SetAttributes(file, FileAttributes.Normal)
                Try
                    IO.File.Delete(file)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            Next

        End If



        AsyncFileUpload1.SaveAs(destzip)
        Dim archivos As Generic.List(Of String) = ExtraerZip(destzip, DIRTEMP)


        If False Then
            'metodo anterior
            ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, archivos, forzarID, sError, DirApp)

        Else

            'preprocesarImagenesTiff()
            ProntoFlexicapture.ClassFlexicapture.ActivarMotor(SC, archivos, sError, DirApp, ConfigurationManager.AppSettings("UsarFlexicapture"))

        End If


    End Function



    Public ReadOnly Property scLocal() As String
        Get
            Return ConfigurationManager.AppSettings("scLocal")
        End Get
    End Property
    Public ReadOnly Property scWilliamsRelease() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsRelease")
        End Get
    End Property
    Public ReadOnly Property scWilliamsDebug() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsDebug")
        End Get
    End Property



    Public Function GetExcelToDatatable(ByVal fileName As String, Optional ByVal SheetNumero As Integer = 1, Optional ByVal MAXCOLS As Integer = 30, Optional ByVal MAXFILAS As Integer = 150) As DataSet
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html


        'http://stackoverflow.com/questions/15828/reading-excel-files-from-c-sharp

        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????
        'AUTOMATION, OOXML, EPPLUS, qué??????????????


        Dim oXL As ExcelOffice.Application
        Dim oWB As ExcelOffice.Workbook
        Dim oSheet As ExcelOffice.Worksheet
        Dim oRng As ExcelOffice.Range
        Dim oWBs As ExcelOffice.Workbooks

        Try
            '  creat a Application object
            oXL = New ExcelOffice.ApplicationClass()
            '   get   WorkBook  object
            oWBs = oXL.Workbooks


            Try
                oWB = oWBs.Open(fileName, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter

                'If Exception=HRESULT: 0x800A03EC 

                '        Try
                '            SetNewCurrentCulture()
                '            oWB = oWBs.Open(fileName, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
                'Missing.Value, Missing.Value)

                '        Catch ex2 As Exception
                '            Throw
                '        Finally
                '            ResetCurrentCulture()
                '        End Try


            End Try

            'dejé de usar .Sheets
            oSheet = CType(oWB.Worksheets(SheetNumero), ExcelOffice.Worksheet)
            '   get   WorkSheet object
            'Try
            '    'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Sheets(SheetNumero), Microsoft.Office.Interop.ExcelOffice.Worksheet)
            'Catch ex As Exception
            '    'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Worksheets(SheetNumero), Microsoft.Office.Interop.ExcelOffice.Worksheet)
            'End Try


            Dim dt As New Data.DataTable("dtExcel")

            '  creo las columnas
            For j As Integer = 1 To MAXCOLS
                dt.Columns.Add("column" & j, _
                               System.Type.GetType("System.String"))
            Next j


            Dim ds As New DataSet()
            ds.Tables.Add(dt)
            Dim dr As DataRow

            Dim sb As New StringBuilder()
            Dim iValue As Integer = IIf(oSheet.UsedRange.Cells.Rows.Count > MAXFILAS, MAXFILAS, oSheet.UsedRange.Cells.Rows.Count)



            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '  get data in cell
            'copio los datos nomás
            For i As Integer = 1 To iValue
                dr = ds.Tables("dtExcel").NewRow()

                For j As Integer = 1 To MAXCOLS

                    'traigo la celda y la pongo en una variable Range (no sé por qué)
                    oRng = CType(oSheet.Cells(i, j), ExcelOffice.Range)



                    'Range.Text << Formatted value - datatype is always "string"
                    'Range.Value << actual datatype ex: double, datetime etc
                    'Range.Value2 << actual datatype. slightly different than "Value" property.

                    If IsNumeric(oRng.Value) Then 'me fijo si es numerica, por el asuntillo de la coma
                        dr("column" & j) = oRng.Value
                    Else

                        Dim strValue As String = oRng.Text.ToString() 'acá como la convertís a string, estás trayendo la coma...
                        dr("column" & j) = Left(strValue, 50)
                    End If



                Next j

                ds.Tables("dtExcel").Rows.Add(dr)
            Next i
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Return ds


        Catch ex As Exception
            ErrHandler2.WriteError("No pudo extraer el excel. " + ex.ToString)
            Return Nothing


            '            1. In DCOMCNFG, right click on the My Computer and select properties.
            '2. Choose the COM Securities tab
            '3. In Access Permissions, click "Edit Defaults" and add Network Service to it and give it "Allow local access" permission. Do the same for <Machine_name>
            '  \Users.
            '  4. In launch and Activation Permissions, click "Edit Defaults" and add Network Service to it and give it "Local launch" and "Local Activation" permission. Do the same for <Machine_name>
            '    \Users
            '   Press OK and thats it. i can run my application now
        Finally
            Try
                'The service (excel.exe) will continue to run
                If Not oWB Is Nothing Then oWB.Close(False)
                NAR(oWB)
                oWBs.Close()
                NAR(oWBs)
                'quit and dispose app
                oXL.Quit()
                NAR(oXL)
                'VERY IMPORTANT
                GC.Collect()

                'Dispose()  'este me arruinaba todo, me hacia aparecer el cartelote del Prerender
            Catch ex As Exception
                ErrHandler2.WriteError("No pudo cerrar el servicio excel. " + ex.ToString)
            End Try
        End Try
    End Function






    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////








    Function TraerListaSQL(ByVal g As GridView, ByVal sc As String, ByVal sesionIdentificador As String)

        'Dim l = TraerLista(g)

        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim lista = (From i In db.wGrillaPersistencias Where i.Sesion = sesionIdentificador Select CStr(i.IdRenglon)).ToArray

        Return Join(lista, ",")

    End Function

    '/////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////


    Public Sub WriteToXml(ByVal xmlFileName As String, ByVal connectionString As String, ByVal comando As String)
        '  http://stackoverflow.com/questions/1473806/net-system-outofmemoryexception-filling-a-datatable
        'http://stackoverflow.com/questions/356645/exception-of-type-system-outofmemoryexception-was-thrown-why
        Dim writer As XmlWriter
        writer = XmlWriter.Create(xmlFileName)

        Dim myConnection As SqlConnection = New SqlConnection(Encriptar(connectionString))


        Dim myCommand As SqlCommand
        myCommand = New SqlCommand(comando, myConnection)
        'If timeoutSegundos <> 0 Then myCommand.CommandTimeout = timeoutSegundos
        myCommand.CommandType = CommandType.Text


        Try
            myConnection.Open()

            Dim reader As SqlDataReader
            reader = myCommand.ExecuteReader()

            While reader.Read()
                Dim s = reader(0) & "," & reader(1) & "," & reader(2) & "," & reader(3)
                writer.WriteRaw(s)
            End While



        Catch ex As Exception
            Throw
        Finally
            myConnection.Close()
            myConnection.Dispose()
        End Try
    End Sub

    '/////////////////////////////////////////////////////////////////////////////////////////////////

    Public Sub AbrirEnNuevaVentana(ByVal yo As Object, ByVal surl As String)
        Dim str = "window.open('" & surl & "');"
        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(yo.Page, yo.GetType, "alrt", str, True)
    End Sub

    Public Sub AbrirEnNuevaVentanaTab(ByVal yo As Object, ByVal surl As String)
        Dim str = "window.open('" & surl & "','_newtab" & Math.Floor(Rnd() * 999999) & "');"

        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(yo.Page, yo.GetType, "alrt", str, True)

    End Sub


    Public Function RebindReportViewer_Servidor(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, ByVal rdlFile As String, ByVal dt As DataTable,
                                       Optional ByVal dt2 As DataTable = Nothing, Optional ByVal bDescargaExcel As Boolean = False,
                                       Optional ByRef ArchivoExcelDestino As String = "", Optional ByVal titulo As String = "",
                                       Optional ByVal bDescargaHtml As Boolean = False) As String
        'http://forums.asp.net/t/1183208.aspx

        With oReportViewer
            .Reset()
            .ProcessingMode = ProcessingMode.Remote
            .Visible = False







            ' ReportViewerRemoto.ShowParameterPrompts = false



            '               // ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://serversql1:82/ReportServer");
            .ServerReport.ReportServerUrl = New Uri("http://localhost/ReportServer_MSSQLSERVER2")
            '    .ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServer"]);


            '
            '               ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
            '            '              // IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            '              IReportServerCredentials irsc = new CustomReportCredentials(ConfigurationManager.AppSettings["ReportUser"], ConfigurationManager.AppSettings["ReportPass"], ConfigurationManager.AppSettings["ReportDomain"]);
            '              ReportViewerRemoto.ServerReport.ReportServerCredentials = irsc;
            '             ReportViewerRemoto.ShowCredentialPrompts = false;




            'rdlFile = "/Pronto informes/" + "Resumen Cuenta Corriente Acreedores"
            rdlFile = "/Pronto informes/" + "Listado general de Cartas de Porte (simulando original) con foto - Desde SQL"

            With .ServerReport
                .ReportPath = rdlFile


                .ReportPath = rdlFile

                '.DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                '.DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.


                '.EnableHyperlinks = True

                '.DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                ' .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                ' If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile



                '.EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                If titulo <> "" Then
                    Try
                        If .GetParameters.Count = 1 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)
                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        ElseIf .GetParameters.Count = 2 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)

                                Dim serv As String
                                If System.Diagnostics.Debugger.IsAttached() Then
                                    serv = "http://localhost:48391/ProntoWeb"
                                Else
                                    serv = "http://prontoclientes.williamsentregas.com.ar/"
                                End If
                                Dim p2 = New ReportParameter("sServidor", serv)

                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1, p2})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        Else
                            ErrHandler2.WriteError("Error al buscar los parametros")
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex.ToString)
                        Dim inner As Exception = ex.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                            inner = inner.InnerException
                        End While
                    End Try
                End If
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            '/////////////////////
            '/////////////////////

            .Visible = False

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String
            Dim bytes As Byte()

            'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
            '             string mimeType;
            '2 string encoding;
            '3 Warning[] warnings;
            '4 string[] streamids;
            '5 string fileNameExtension;
            '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
            '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
            '8 return reportHtml;

            If False Then


                Try
                    bytes = .ServerReport.Render(
                          "HTML4.0", Nothing, mimeType, encoding,
                            extension,
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try

                Dim reportHtml As String = System.Text.Encoding.UTF8.GetString(bytes)
                'Return bytes
                Return reportHtml

            Else

                .Visible = False

                Try
                    bytes = .ServerReport.Render(
                          "Excel", Nothing, mimeType, encoding,
                            extension,
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try


                ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
                Try
                    Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                    fs.Write(bytes, 0, bytes.Length)
                    fs.Close()

                Catch ex As Exception

                    ErrHandler2.WriteAndRaiseError(ex)
                End Try




                '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)









                Dim sHtml As String

                If False Then
                    ExcelToHtml(ArchivoExcelDestino)
                Else
                    sHtml = ArchivoExcelDestino
                End If



                Return sHtml




                'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
                ''ExcelToCSV_SincroBLD

                'Return ArchivoCSVDestino



            End If


        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function

    Public Function RebindReportViewer(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, ByVal rdlFile As String, ByVal dt As DataTable, _
                                       Optional ByVal dt2 As DataTable = Nothing, Optional ByVal bDescargaExcel As Boolean = False, _
                                       Optional ByRef ArchivoExcelDestino As String = "", Optional ByVal titulo As String = "", _
                                       Optional ByVal bDescargaHtml As Boolean = False) As String
        'http://forums.asp.net/t/1183208.aspx



        With oReportViewer
            .Reset()
            .ProcessingMode = ProcessingMode.Local
            .Visible = True


            ErrHandler2.WriteError(ArchivoExcelDestino + "  Informe: " + titulo)


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                If titulo <> "" Then
                    Try
                        If .GetParameters.Count = 1 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)
                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        ElseIf .GetParameters.Count = 2 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)

                                Dim serv As String
                                If System.Diagnostics.Debugger.IsAttached() Then
                                    serv = "http://localhost:48391/ProntoWeb"
                                Else
                                    serv = "http://prontoclientes.williamsentregas.com.ar/"
                                End If
                                Dim p2 = New ReportParameter("sServidor", serv)

                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1, p2})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        Else
                            ErrHandler2.WriteError("Error al buscar los parametros")
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex.ToString)
                        Dim inner As Exception = ex.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                            inner = inner.InnerException
                        End While
                    End Try
                End If
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            If bDescargaHtml Then

                If False Then
                    .Visible = False

                    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                    Dim warnings As Warning()
                    Dim streamids As String()
                    Dim mimeType, encoding, extension As String
                    Dim bytes As Byte()

                    'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
                    '             string mimeType;
                    '2 string encoding;
                    '3 Warning[] warnings;
                    '4 string[] streamids;
                    '5 string fileNameExtension;
                    '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
                    '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
                    '8 return reportHtml;


                    Try
                        bytes = .LocalReport.Render( _
                              "HTML4.0", Nothing, mimeType, encoding, _
                                extension, _
                               streamids, warnings)

                    Catch e As System.Exception
                        Dim inner As Exception = e.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                'MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                            inner = inner.InnerException
                        End While
                        Throw
                    End Try



                    Dim reportHtml As String = System.Text.Encoding.UTF8.GetString(bytes)
                    'Return bytes
                    Return reportHtml
                Else

                    .Visible = False

                    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                    Dim warnings As Warning()
                    Dim streamids As String()
                    Dim mimeType, encoding, extension As String
                    Dim bytes As Byte()

                    Try
                        bytes = .LocalReport.Render( _
                              "Excel", Nothing, mimeType, encoding, _
                                extension, _
                               streamids, warnings)

                    Catch e As System.Exception
                        Dim inner As Exception = e.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                'MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                            inner = inner.InnerException
                        End While
                        Throw
                    End Try


                    ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
                    Try
                        Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                        fs.Write(bytes, 0, bytes.Length)
                        fs.Close()

                    Catch ex As Exception

                        ErrHandler2.WriteAndRaiseError(ex)
                    End Try




                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)









                    Dim sHtml As String

                    If False Then
                        ExcelToHtml(ArchivoExcelDestino)
                    Else
                        sHtml = ArchivoExcelDestino
                    End If



                    Return sHtml




                    'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
                    ''ExcelToCSV_SincroBLD

                    'Return ArchivoCSVDestino

                End If


            ElseIf bDescargaExcel Then
                .Visible = False

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String
                Dim bytes As Byte()

                Try
                    bytes = .LocalReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino
            Else

                .LocalReport.Refresh()
                .DataBind()

            End If

        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function



    Public Function RebindReportViewerPasandoleConsultaDinamica(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, _
                                       ByVal rdlFile As String, ByVal dt As DataTable, _
                                       SC As String, sQuerySQL As String, Optional ByVal bDescargaExcel As Boolean = False, _
                                       Optional ByRef ArchivoExcelDestino As String = "", Optional ByVal titulo As String = "", _
                                       Optional ByVal bDescargaHtml As Boolean = False) As String
        'http://forums.asp.net/t/1183208.aspx

        With oReportViewer
            .Reset()
            .ProcessingMode = ProcessingMode.Local
            .Visible = True


            ErrHandler2.WriteError(ArchivoExcelDestino + "  Informe: " + titulo)


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp
                'http://stackoverflow.com/questions/22062282/how-to-create-a-dynamic-query-in-a-local-report-rdlc-in-c-sharp

                'http://forums.asp.net/t/1240076.aspx?Passing+Parameters+to+a+Local+Report+rdlc+
                'Q:              Why doesn't the ReportViewer control support parameter prompting in local mode?
                'A: The ReportViewer control does not prompt for parameters when in local mode. It prompts for 
                'parameters when it is connected to a Report Server.
                'In local mode it does not make sense for ReportViewer to prompt for parameters. The rationale is as follows: 
                'The most common use of report parameters is to pass to queries as values of query parameters. But unlike 
                'the Report Server, the ReportViewer control does not execute queries itself. Rather, queries are executed by the 
                'host application, and the result is passed to the ReportViewer control. So the ReportViewer control does not have the opportunity to set query parameters. Applications should take advantage of the parameterization features of Visual Studio data wizards instead
                '    .DataSources.Add(New ReportDataSource(

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                'If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                If titulo <> "" Then
                    Try
                        If .GetParameters.Count = 1 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)
                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        ElseIf .GetParameters.Count = 2 Then
                            If .GetParameters.Item(0).Name = "ReportParameter1" Then
                                Dim p1 = New ReportParameter("ReportParameter1", titulo)

                                Dim serv As String
                                If System.Diagnostics.Debugger.IsAttached() Then
                                    serv = "http://localhost:48391/ProntoWeb"
                                Else
                                    serv = "http://prontoclientes.williamsentregas.com.ar/"
                                End If
                                Dim p2 = New ReportParameter("sServidor", serv)

                                'Dim p2 = New ReportParameter("FechaDesde", Today)
                                'Dim p3 = New ReportParameter("FechaHasta", Today)
                                '.SetParameters(New ReportParameter() {p1, p2, p3})
                                .SetParameters(New ReportParameter() {p1, p2})

                            Else
                                ErrHandler2.WriteError("Error al buscar los parametros")
                            End If
                        Else
                            ErrHandler2.WriteError("Error al buscar los parametros")
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex.ToString)
                        Dim inner As Exception = ex.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                            inner = inner.InnerException
                        End While
                    End Try
                End If
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True



            If bDescargaHtml Then

                If False Then
                    .Visible = False

                    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                    Dim warnings As Warning()
                    Dim streamids As String()
                    Dim mimeType, encoding, extension As String
                    Dim bytes As Byte()

                    'http://pareshjagatia.blogspot.com.ar/2008/05/export-reportviewer-report-to-pdf-excel.html
                    '             string mimeType;
                    '2 string encoding;
                    '3 Warning[] warnings;
                    '4 string[] streamids;
                    '5 string fileNameExtension;
                    '6 byte[] htmlBytes = MyReportViewer.ServerReport.Render("HTML4.0", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
                    '7 string reportHtml = System.Text.Encoding.UTF8.GetString(htmlBytes);
                    '8 return reportHtml;


                    Try
                        bytes = .LocalReport.Render( _
                              "HTML4.0", Nothing, mimeType, encoding, _
                                extension, _
                               streamids, warnings)

                    Catch e As System.Exception
                        Dim inner As Exception = e.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                'MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                            inner = inner.InnerException
                        End While
                        Throw
                    End Try



                    Dim reportHtml As String = System.Text.Encoding.UTF8.GetString(bytes)
                    'Return bytes
                    Return reportHtml
                Else

                    .Visible = False

                    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                    Dim warnings As Warning()
                    Dim streamids As String()
                    Dim mimeType, encoding, extension As String
                    Dim bytes As Byte()

                    Try
                        bytes = .LocalReport.Render( _
                              "Excel", Nothing, mimeType, encoding, _
                                extension, _
                               streamids, warnings)

                    Catch e As System.Exception
                        Dim inner As Exception = e.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                'MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                            inner = inner.InnerException
                        End While
                        Throw
                    End Try


                    ErrHandler2.WriteError("Por generar el archivo " + ArchivoExcelDestino)
                    Try
                        Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                        fs.Write(bytes, 0, bytes.Length)
                        fs.Close()

                    Catch ex As Exception

                        ErrHandler2.WriteAndRaiseError(ex)
                    End Try




                    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ErrHandler2.WriteError("Archivo generado " + ArchivoExcelDestino)









                    Dim sHtml As String

                    If False Then
                        CartaDePorteManager.ExcelToHtml(ArchivoExcelDestino)
                    Else
                        sHtml = ArchivoExcelDestino
                    End If



                    Return sHtml




                    'Dim ArchivoCSVDestino = ExcelToCSV(ArchivoExcelDestino)
                    ''ExcelToCSV_SincroBLD

                    'Return ArchivoCSVDestino

                End If


            ElseIf bDescargaExcel Then
                .Visible = False

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String
                Dim bytes As Byte()

                Try
                    bytes = .LocalReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino
            Else

                .LocalReport.Refresh()
                .DataBind()

            End If

        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function




    Public Function RebindReportViewer_Servidor_SalidaNormal(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer,
                                                                ByVal rdlFile As String, parametros As IEnumerable(Of ReportParameter)) As String


        'errores
        '   rsCredentialsNotSpecified     porque el datasource TestHarcodeada tiene las credenciales no configuradas para windows integrated
        '   rsProcessingAborted           porque la cuenta que corre el repservice no tiene permisos: 
        '                                         GRANT  Execute on [dbo].your_object to [public]
        '                                         REVOKE Execute on [dbo].your_object to [public]
        '                                         grant execute on wCar...  to [NT AUTHORITY\NETWORK SERVICE]
        '                                         grant execute on wCar...  to [NT AUTHORITY\ANONYMOUS LOGON]
        '                                         grant execute on wCart... to public

        If parametros IsNot Nothing Then
            For Each i In parametros
                If i Is Nothing Then
                    Throw New Exception("Te falta por lo menos un parametro. Recordá que el array que pasás se dimensiona con un elemento de más")
                End If
            Next
        End If


        With oReportViewer
            .Reset()
            .ProcessingMode = Microsoft.Reporting.WebForms.ProcessingMode.Remote
            .Visible = True



            'ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            .ServerReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer"))
            .ProcessingMode = ProcessingMode.Remote
            ' IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            Dim irsc As IReportServerCredentials = New CustomReportCredentials(ConfigurationManager.AppSettings("ReportUser"), ConfigurationManager.AppSettings("ReportPass"), ConfigurationManager.AppSettings("ReportDomain"))
            .ServerReport.ReportServerCredentials = irsc
            .ShowCredentialPrompts = False
            .ShowParameterPrompts = False



            'rdlFile = "/Pronto informes/" + "Resumen Cuenta Corriente Acreedores"
            'Dim reportName = "Listado general de Cartas de Porte (simulando original) con foto Buscador sin Webservice"
            If rdlFile = "" Then

            End If
            rdlFile = rdlFile.Replace(".rdl", "")
            rdlFile = "/Pronto informes/" & rdlFile



            With .ServerReport
                .ReportPath = rdlFile






                Try
                    If parametros IsNot Nothing Then oReportViewer.ServerReport.SetParameters(parametros)
                    'sera porque el informe tiene el datasource TestHarcodeada con credenciales NO en "integrated security"?






                Catch ex As Exception
                    'sera porque el informe tiene el datasource TestHarcodeada con credenciales NO en "integrated security"?

                    'unauthorized
                    '-es por la cuenta windows que usa repservices o por la cuenta sql que usa el datasource del informe?
                    '-ojo tambien conque no se puede usar el alias bdlconsultores.sytes.net
                    '-será por la cuenta built-in que usa el reporting para correr?
                    '-habilitar errores remotos del reporting services. agregar usuario/permisos en la base sql para el usuario windows que ejecuta el informa



                    ErrHandler2.WriteError(ex.ToString)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            Stop
                        End If
                        ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True


            .ServerReport.Refresh()

            '/////////////////////
            '/////////////////////


            .Visible = True






        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a

    End Function




    Function DatatableToHtml(dt As DataTable) As String
        'Dim dt As New DataTable()

        'dt.Columns.Add("col1")
        'dt.Columns.Add("col2")
        'dt.Columns.Add("col3")
        'dt.Rows.Add(New Object() {"a", "b", "c"})
        'dt.Rows.Add(New Object() {"d", "e", "f"})

        Dim tab As String = vbTab

        Dim sb As New StringBuilder()

        sb.AppendLine("<html>")
        sb.AppendLine(tab & "<body>")
        sb.AppendLine(tab & tab & "<table>")

        ' headers.
        sb.Append(tab & tab & tab & "<tr>")

        For Each dc As DataColumn In dt.Columns
            sb.AppendFormat("<td>{0}</td>", dc.ColumnName)
        Next

        sb.AppendLine("</tr>")

        Dim r As Integer = 0

        ' data rows
        For Each dr As DataRow In dt.Rows

            sb.Append(tab & tab & tab & "<tr>")

            For Each dc As DataColumn In dt.Columns
                Dim cellValue As String = If(dr(dc) IsNot Nothing, dr(dc).ToString(), "")
                sb.AppendFormat("<td>{0}</td>", cellValue)
            Next

            sb.AppendLine("</tr>")

            r += 1
        Next

        sb.AppendLine(tab & tab & "</table>")
        sb.AppendLine(tab & "</body>")
        sb.AppendLine("</html>")

        Return sb.ToString
    End Function




    Function RebindReportViewerLINQ(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, ArchivoExcelDestino As String, ByVal rdlFile As String, ByVal q As Object, Optional ByVal parametros As ReportParameter() = Nothing) As String
        'http://forums.asp.net/t/1183208.aspx

        With oReportViewer
            .ProcessingMode = ProcessingMode.Local

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", q)) '//the first parameter is the name of the datasource which you bind your report table to.

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                Try
                    If parametros IsNot Nothing Then
                        .SetParameters(parametros)
                    End If
                    '    If .GetParameters.Count > 1 Then
                    '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                    '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                    '            Dim p2 = New ReportParameter("FechaDesde", Today)
                    '            Dim p3 = New ReportParameter("FechaHasta", Today)
                    '            .SetParameters(New ReportParameter() {p1, p2, p3})
                    '        End If
                    '    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                End Try
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True




            If True Then
                .Visible = False

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String
                Dim bytes As Byte()

                Try
                    bytes = .LocalReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try


                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino

            End If

        End With



        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function


    Public Function RebindReportViewerExcel(ByVal SC As String, ByVal rdlFile As String, ByVal dt As Collections.IEnumerable, ByVal ArchivoExcelDestino As String) As String

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "Excel" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        ''Dim vFileName As String = "c:\archivo.txt"
        '' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        'ErrHandler2.WriteError("Este reportviewer EXPORTA a excel, pueden andar los mails y esto no. " & _
        '                      "-Eh? la otra función RebindReportViewer tambien exporta a EXCEL con un flag. Quizas lo hace con otro usuario... " & _
        '                      "-En fin. Puede llegar a explotar sin rastro. Fijate en los permisos de NETWORK SERVICE para " & _
        '                      "usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

        Using ReportViewer2 As New ReportViewer
            With ReportViewer2
                .ProcessingMode = ProcessingMode.Local

                .Visible = False

                With .LocalReport

                    .ReportPath = rdlFile
                    .EnableHyperlinks = True
                    .DataSources.Clear()

                    .EnableExternalImages = True

                    '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                    .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

                End With

                .DocumentMapCollapsed = True

                '.LocalReport.Refresh()
                '.DataBind()

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String

                Dim format = "Excel"

                Dim bytes As Byte()

                Try
                    bytes = ReportViewer2.LocalReport.Render( _
                               format, Nothing, mimeType, encoding, _
                                 extension, _
                                streamids, warnings)



                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()





                'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
                'Notas de Entrega: 160 ancho x 36 alt
                'Facturas y Adjuntos: 160 ancho x 78 alto

                'ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

            End With
        End Using


        Return ArchivoExcelDestino

    End Function

    Public Function RebindReportViewerExcel(ByVal SC As String, ByVal rdlFile As String, ByVal dt As DataTable, ByVal ArchivoExcelDestino As String) As String

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "Excel" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        ''Dim vFileName As String = "c:\archivo.txt"
        '' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        'ErrHandler2.WriteError("Este reportviewer EXPORTA a excel, pueden andar los mails y esto no. " & _
        '                      "-Eh? la otra función RebindReportViewer tambien exporta a EXCEL con un flag. Quizas lo hace con otro usuario... " & _
        '                      "-En fin. Puede llegar a explotar sin rastro. Fijate en los permisos de NETWORK SERVICE para " & _
        '                      "usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

        Using ReportViewer2 As New ReportViewer
            With ReportViewer2
                .ProcessingMode = ProcessingMode.Local

                .Visible = False

                With .LocalReport

                    .ReportPath = rdlFile
                    .EnableHyperlinks = True
                    .DataSources.Clear()

                    .EnableExternalImages = True

                    '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                    .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

                End With

                .DocumentMapCollapsed = True

                '.LocalReport.Refresh()
                '.DataBind()

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String

                Dim format = "Excel"

                Dim bytes As Byte()

                Try
                    bytes = ReportViewer2.LocalReport.Render( _
                               format, Nothing, mimeType, encoding, _
                                 extension, _
                                streamids, warnings)



                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    Throw
                End Try



                Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()





                'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
                'Notas de Entrega: 160 ancho x 36 alt
                'Facturas y Adjuntos: 160 ancho x 78 alto

                'ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

            End With
        End Using


        Return ArchivoExcelDestino

    End Function

    Function AbrirSegunTipoEntidad(ByVal sTipoEntidad As String, ByVal IdEntidad As Long) As String

        Select Case sTipoEntidad

            Case "Asiento"
                'usar formato "~/ProntoWeb/Clientes.aspx
                Return String.Format("Asiento.aspx?Id={0}", IdEntidad)
            Case "Factura"
                Return String.Format("Factura.aspx?Id={0}", IdEntidad)
            Case "Cmpbte proveedor"
                Return String.Format("ComprobantePrv.aspx?Id={0}", IdEntidad)
            Case EntidadManager.IdTipoComprobante.Remito
                Return String.Format("Remito.aspx?Id={0}", IdEntidad)
        End Select

    End Function

    Function AbrirSegunTipoComprobante(ByVal idtipocomprobante As IdTipoComprobante, ByVal IdComprobante As Long) As String

        Select Case idtipocomprobante

            'usar formato "~/ProntoWeb/Clientes.aspx
            Case idtipocomprobante.Factura
                Return String.Format("Factura.aspx?Id={0}", IdComprobante)
            Case EntidadManager.IdTipoComprobante.Recibo
                Return String.Format("Recibo.aspx?Id={0}", IdComprobante)
            Case EntidadManager.IdTipoComprobante.Remito
                Return String.Format("Remito.aspx?Id={0}", IdComprobante)
        End Select

    End Function


    Public Function stodUI(ByVal c As TextBox) As Decimal 'alias de StringToDecimal
        Return StringToDecimal(c.Text)
    End Function

    '/////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////


    Function GetStoreProcedure(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As System.Data.DataTable
        Return EntidadManager.GetStoreProcedure(SC, enumNombreSP_Completo, Parametros)
    End Function


    Function GetStoreProcedureTop1(ByVal SC As String, ByVal enumNombreSP_Completo As enumSPs, ByVal ParamArray Parametros() As Object) As System.Data.DataRow
        Return EntidadManager.GetStoreProcedureTop1(SC, enumNombreSP_Completo, Parametros)
    End Function



    '/////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////

    Public Function FolderFromFileName _
(ByVal FileFullPath As String) As String
        'EXAMPLE: input ="C:\winnt\system32\kernel.dll, 
        'output = C:\winnt\system32\

        Dim intPos As Integer
        intPos = FileFullPath.LastIndexOfAny("\")
        intPos += 1


        Return FileFullPath.Substring(0, intPos)

    End Function

    Public Function NameOnlyFromFullPath _
      (ByVal FileFullPath As String) As String

        'EXAMPLE: input ="C:\winnt\system32\kernel.dll, 
        'output = kernel.dll

        Dim intPos As Integer

        intPos = FileFullPath.LastIndexOfAny("\")
        intPos += 1


        Return FileFullPath.Substring(intPos, _
            (Len(FileFullPath) - intPos))

    End Function





    '/////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////
    Function ProntoPasswordSegunIdEmpleado(ByVal sc As String, ByVal IdEmpleado As Long) As String
        'Password de Pronto
        If IdEmpleado > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(sc, "Empleados", "T", IdEmpleado)
            If ds.Tables(0).Rows.Count > 0 Then
                Return ds.Tables(0).Rows(0).Item("Password").ToString
            End If
        End If
        Return Nothing
    End Function

    Function ProntoPasswordWEB(ByVal sEmpleado As String) As String
        'Password de ProntoWeb
        'session(SESSIONPRONTO_UserName)
        Dim mu As MembershipUser
        mu = Membership.GetUser(sEmpleado)
        Return mu.GetPassword()
    End Function
    '/////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////



    Public ReadOnly Property AplicacionConImagenes() As String 'si lo uso desde prontoclientes, debo apuntar hacia el de pronto a secas
        Get
            Return ConfigurationManager.AppSettings("AplicacionConImagenes")
        End Get
    End Property


    Function DirApp() As String
        Return ConfigurationManager.AppSettings("DirApp")
        'Return HttpContext.Current.Request.MapPath(HttpContext.Current.Request.ApplicationPath)
    End Function





    Sub DatosDeSesion(SC As String, UsuarioNombre As String, session As Object, ConexBDLmaster As String, yo As Login, idempresa As Integer)

        Try
            BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, session, ConexBDLmaster, yo)

            Dim emp As EmpresaList = EmpresaManager.GetList(ConexBDLmaster)

            Dim eee = emp.Find(Function(x) x.Id = idempresa)

            session(SESSIONPRONTO_NombreEmpresa) = eee.Descripcion


        Catch ex As Exception
            ErrHandler2.WriteError(ConexBDLmaster)
            ErrHandler2.WriteError(idempresa)
            ErrHandler2.WriteError(Membership.GetUser.UserName)
            ErrHandler2.WriteError(ex)
        End Try


        'HttpContext.Current.Session(SESSIONPRONTO_glbIdUsuario) 'esto es el idempleado en la base elegida
        'no tendria q llamar a AddEmpresaToSession? estoy sacando de ahi este codigo

        'Dim dt = EntidadManager.ExecDinamico(SC, "Empleados_TX_UsuarioNT '" & UsuarioNombre & "'", 15)

        'If dt.Rows.Count > 0 Then
        '    'Lo encontró, y me traigo sus datos
        '    With dt.Rows(0)
        '        session(SESSIONPRONTO_glbIdUsuario) = .Item(0)
        '        session(SESSIONPRONTO_glbIdSector) = .Item("IdSector")
        '        session(SESSIONPRONTO_glbLegajo) = .Item("Legajo")
        '        session(SESSIONPRONTO_glbIdCuentaFFUsuario) = .Item("IdCuentaFondoFijo")
        '        session(SESSIONPRONTO_glbIdObraAsignadaUsuario) = .Item("IdObraAsignada")
        '    End With
        'End If


    End Sub



    Function ConexBDLmaster() As String
        Dim sCadena As String

        sCadena = "LocalSqlServer"
        'no puedo agregar al login la eleccion de la bdlmaster (si detecta q esta el VStudio andando)?
        'sCadena = "VPNSqlServer"
        'esto no funciona así nomas! En "roleManager" tambien aparece "LocalSqlServer"!....

        Try
            Return Encriptar(System.Configuration.ConfigurationManager.ConnectionStrings(sCadena).ConnectionString)
        Catch ex As Exception
            ErrHandler2.WriteError("No se pudo conectar a la BDLmaster." & ex.ToString)
            Throw
        End Try

    End Function



    Class UsuarioSesion
        Public Shared Function Mail(ByVal sc As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String


            'Procedure 'Empleados_TX_PorId' expects parameter '@IdEmpleado', which was not supplied.

            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(sc, "Empleados", "TX_PorId", Session(SESSIONPRONTO_glbIdUsuario))

            If ds.Tables(0).Rows.Count > 0 Then
                'Lo encontró, y me traigo sus datos
                With ds.Tables(0).Rows(0)
                    Return iisNull(.Item("Email"))

                    'session(SESSIONPRONTO_glbIdUsuario) = .Item(0)
                    'Session("glbIdSector") = .Item("IdSector")
                    'Session("glbLegajo") = .Item("Legajo")
                    'Session("glbIdCuentaFFUsuario") = .Item("IdCuentaFondoFijo")
                    'session(SESSIONPRONTO_glbIdObraAsignadaUsuario) = .Item("IdObraAsignada")
                End With
            End If
            Return Nothing
        End Function
    End Class


    Sub PasearAutoComplete()
        '        For Each ac As AjaxControlToolkit.AutoCompleteExtender In Me.Controls
        '            ac.ContextKey = HFSC.Value
        '        Next

        'http://forums.asp.net/t/1013944.aspx
        '        ContentPlaceHolder(ContentPlaceHolder = (ContentPlaceHolder))
        '        Master.FindControl("ContentPlaceHolder1")

        '// replace with your ContentPlaceHolder id

        '  2.use foreach in contentPlaceHolder .Controls

        '        foreach (Control c in contentPlaceHolder .Controls)
        '        {
        '        If (c.GetType().ToString().Equal("System.Web.UI.WebControls.Label")) Then
        '            {
        '                Label myLabel = (Label)c;
        '                myLabel.Text += "this works";
        '            }
        '        }
    End Sub


    Function TextoWebControl(ByVal c As WebControl) As String
        Try
            Select Case c.GetType.Name
                Case "Label"
                    Return CType(c, WebControls.Label).Text
                Case "DropDownList"
                    Return CType(c, WebControls.DropDownList).Text
                Case "TextBox"
                    Return CType(c, WebControls.TextBox).Text
                Case Else
                    Return Nothing
            End Select
        Catch ex As Exception
            'Tiene que explotar, para advertir que se le pasó un control invalido
        End Try

    End Function



    Function pasearsePorDetalleCompronto()
        '"            'Dim rsDet As adodb.Recordset = oCliente.DetClientes.TraerTodos

        'With rsDet
        '    If Not .EOF Then .MoveFirst()

        '    Do While Not .EOF

        '        Dim oDetCliente 'As ComPronto.DetCliente  = oCliente.DetClientes.Item(rsDet.Fields(""IdDetalleCliente""))

        '        Dim item As New ClienteItem


        '        With oDetCliente.Registro

        '            item.IdArticulo = .Fields(""IdArticulo"").Value                             
        'If Not .Eliminado Then
        'pero que hago SI TODAVIA NO ESTAN GRABADOS?????  -mmm, debe ser paseandote desde el item(-100) y restando de a 1 (-101,-102,...)  For i = -100 To (-100 - (oFac.DetFacturas.Count - 1)) Step -1"

    End Function


    Public Function DataTableToExcelConEPPLUS(ByVal pDataTable As DataTable, ByVal newFile As FileInfo) As String
        'http://fourleafit.wikispaces.com/EPPlus

        Using pck As ExcelPackage = New ExcelPackage(newFile)

            '//Create the worksheet
            Dim ws As ExcelWorksheet = pck.Workbook.Worksheets.Add("Accounts")
            '//Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
            ws.Cells("A1").LoadFromDataTable(pDataTable, True)
            pck.Save()
        End Using
    End Function


    Public Function DataTableToExcel(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

        Dim vFileName As String = Path.GetTempFileName()
        'Dim vFileName As String = "c:\archivo.txt"
        Dim nF = FreeFile()
        FileOpen(nF, vFileName, OpenMode.Output)



        Dim sb As String = ""
        Dim dc As DataColumn
        For Each dc In pDataTable.Columns
            sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        Next
        PrintLine(nF, sb)
        Dim i As Integer = 0
        Dim dr As DataRow
        For Each dr In pDataTable.Rows
            i = 0 : sb = ""
            For Each dc In pDataTable.Columns
                If Not IsDBNull(dr(i)) Then
                    Try
                        If IsNumeric(dr(i)) Then
                            sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        ElseIf dr(i).GetType.Name = "Byte[]" Then
                            sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                        Else
                            sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        End If
                    Catch x As Exception
                        sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    End Try
                Else
                    sb &= Microsoft.VisualBasic.ControlChars.Tab
                End If
                i += 1
            Next
            PrintLine(nF, sb)
        Next


        FileClose(nF)



        Return TextToExcel(vFileName, titulo, sSufijoNombreArchivo)
    End Function


    Public Function DataTableToExcel(ByVal pDataView As DataView, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

        Dim vFileName As String = Path.GetTempFileName()
        'Dim vFileName As String = "c:\archivo.txt"
        Dim nF = FreeFile()
        FileOpen(nF, vFileName, OpenMode.Output)



        Dim sb As String = ""
        Dim dc As DataColumn
        For Each dc In pDataView.Table.Columns
            sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        Next
        PrintLine(nF, sb)
        Dim i As Integer = 0
        Dim dr As DataRow
        For Each dr In pDataView.Table.Rows
            i = 0 : sb = ""
            For Each dc In pDataView.Table.Columns
                If Not IsDBNull(dr(i)) Then
                    Try
                        If IsNumeric(dr(i)) Then
                            sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        Else
                            sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        End If
                    Catch x As Exception
                        sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    End Try
                Else
                    sb &= Microsoft.VisualBasic.ControlChars.Tab
                End If
                i += 1
            Next
            PrintLine(nF, sb)
        Next


        FileClose(nF)



        Return TextToExcel(vFileName, titulo, sSufijoNombreArchivo)
    End Function



    Public Function TextToExcel(ByVal pFileName As String, Optional ByVal titulo As String = "", Optional ByVal sSufijoNombreArchivo As String = "Notas de Entrega") As String

        Dim vFormato As ExcelOffice.XlRangeAutoFormat
        Dim Exc As ExcelOffice.Application = CreateObject("Excel.Application")
        Exc.Visible = False
        Exc.DisplayAlerts = False

        'importa el archivo de texto
        'cómo hacer para abrir el .tmp (que es un TAB SEPARATED) para que tome el punto decimal
        'http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12722
        Exc.Workbooks.OpenText(pFileName, , , , ExcelOffice.XlTextQualifier.xlTextQualifierNone, , True, , , , , , , , ".", ",")


        '        Workbooks.OpenText(Filename:=myFile.Name _
        ', Origin:=xlWindows, StartRow:=1, DataType:=xlDelimited, TextQualifier _
        ':=xlDoubleQuote, ConsecutiveDelimiter:=False, TAB:=True, Semicolon:= _
        'False, Comma:=False, Space:=False, Other:=False, FieldInfo:=Array(Array _
        '(1, 1), Array(2, 1)), DecimalSeparator:=".", ThousandsSeparator:=",", _
        'TrailingMinusNumbers:=True)




        Dim Wb As ExcelOffice.Workbook = Exc.ActiveWorkbook
        Dim Ws As ExcelOffice.Worksheet = CType(Wb.ActiveSheet, ExcelOffice.Worksheet)


        'Se le indica el formato al que queremos exportarlo
        Dim valor As Integer = 10

        If valor > -1 Then
            Select Case (valor)
                Case 10 : vFormato = ExcelOffice.XlRangeAutoFormat.xlRangeAutoFormatClassic1
            End Select
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(Ws.UsedRange.Rows.Count, Ws.UsedRange.Columns.Count)).AutoFormat(vFormato) 'le hace autoformato

            'insertar totales
            'Dim filas = Ws.UsedRange.Rows.Count
            'Ws.Cells(filas + 1, "E") = "TOTAL:"
            'Ws.Cells(filas + 1, "F") = Exc.WorksheetFunction.Sum(Ws.Range("F2:F" & filas))
            'Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
            'Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))
            'Ws.Cells(filas + 1, "I") = Exc.WorksheetFunction.Sum(Ws.Range("I2:I" & filas))
            'Ws.Cells(filas + 1, "J") = Exc.WorksheetFunction.Sum(Ws.Range("J2:J" & filas))
            'Ws.Cells(filas + 1, "K") = Exc.WorksheetFunction.Sum(Ws.Range("K2:K" & filas))
            'Ws.Cells(filas + 1, "N") = Exc.WorksheetFunction.Sum(Ws.Range("N2:N" & filas))
            'Ws.Cells(filas + 1, "O") = Exc.WorksheetFunction.Sum(Ws.Range("O2:O" & filas))
            'Ws.Cells(filas + 1, "P") = Exc.WorksheetFunction.Sum(Ws.Range("P2:P" & filas))


            '/////////////////////////////////
            'muevo la planilla formateada para tener un espacio arriba
            'Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

            '/////////////////////////////////
            'poner tambien el filtro que se usó para hacer el informe
            If titulo <> "" Then Ws.Cells(7, 1) = titulo

            '/////////////////////////////////
            'insertar la imagen 
            'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
            'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")
            'Dim imag = Ws.Pictures.Insert(Server.MapPath("~/Imagenes/Williams.bmp"))
            'imag.Left = 1
            'imag.top = 1

            '/////////////////////////////////
            'insertar link
            'Dim rg As ExcelOffice.Range = Ws.Cells(3, 10)
            ''rg.hip()
            ''rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
            ''rg.Hyperlinks(1).TextToDisplay=
            'Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
            ''Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








            '/////////////////////////////////
            '/////////////////////////////////

            'Usando un GUID
            'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Usando la hora
            pFileName = System.IO.Path.GetTempPath() + sSufijoNombreArchivo + " " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            '/////////////////////////////////

            'pFileName = Path.GetTempFileName  'tambien puede ser .GetRandomFileName
            'pFileName = Path.GetTempFileName.Replace("tmp", "xls")
            'problemas con el acceso del proceso al archivo? http://www.eggheadcafe.com/software/aspnet/34067727/file-cannot-be-accessed-b.aspx
            'pFileName = "C:\Archivo.xls"
            'File.Delete(pFileName) 'si no borro, va a aparecer el cartelote de sobreescribir. entonces necesito el .DisplayAlerts = False

            Exc.ActiveWorkbook.SaveAs(pFileName, ExcelOffice.XlTextQualifier.xlTextQualifierNone - 1, )
        End If


        'Exc.Quit()
        'Wb = Nothing
        'Exc = Nothing

        If Not Wb Is Nothing Then Wb.Close(False)
        NAR(Wb)
        'Wbs.Close()
        'NAR(Wbs)
        'quit and dispose app
        Exc.Quit()
        NAR(Exc)

        Ws = Nothing


        GC.Collect()
        'If valor > -1 Then
        '    Dim p As System.Diagnostics.Process = New System.Diagnostics.Process
        '    p.EnableRaisingEvents = False
        '    'System.Diagnostics.Process.Start(pFileName) 'para qué hace esto?
        'End If
        Return pFileName
    End Function







    Public Function ExportarAExcel(ByRef mLista As GridView, _
                              ByVal Session As System.Web.SessionState.HttpSessionState, _
                            ByRef Titulos As String, _
                           Optional ByRef Macro As String = "", _
                           Optional ByVal Parametros As String = "") As String

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'En lugar de usar una ListView, usa gridview
        'revisar la funcion Comparativa.ImpresionComparativa() que hiciste
        'NO PODES USAR LA GRIDVIEW COMO LA LISTVIEW PORQUE ESTA PAGINADAAAAA!!! SOLO VA A MOSTRAR LA PRIMERA!!!
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim oBooks As ExcelOffice.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        Dim oBook As ExcelOffice.Workbook




        'On Error Resume Next
        If mLista.Rows.Count = 0 And Mid(Titulos, 1, 17) <> "DEPOSITO BANCARIO" Then
            MsgBox("No hay elementos para exportar", vbExclamation)
            Exit Function
        End If

        Dim s As String, mParametrosEncabezado As String
        Dim fl As Long, cl As Long, cl1 As Long, i As Long, SaltoCada As Long
        Dim mContador As Long, mColumnaTransporte As Long
        Dim mColumnaSumador1 As Integer, mColumnaSumador2 As Integer
        Dim mColumnaSumador3 As Integer, mColumnaSumador4 As Integer
        Dim mColumnaSumador5 As Integer, mColumnaSumador6 As Integer
        Dim mColumnaSumador7 As Integer, mColumnaSumador8 As Integer
        Dim mColumnaSumador9 As Integer, mColumnaSumador10 As Integer
        Dim mPaginaInicial As Integer, mFontDiario As Integer, mRowHeight As Integer
        Dim mTotalPagina1 As Double, mTotalPagina2 As Double, mTotalPagina3 As Double
        Dim mTotalPagina4 As Double, mTotalPagina5 As Double, mTotalPagina6 As Double
        Dim mTotalPagina7 As Double, mTotalPagina8 As Double, mTotalPagina9 As Double
        Dim mTotalPagina10 As Double
        Dim mTotalizar As Boolean, mFinTransporte As Boolean
        Dim oEx As ExcelOffice.Application

        Dim oL As GridViewRow ' ex ListItem
        Dim oS As TableCell ' ex ListSubItem 
        Dim oCol As TableCell 'ex ColumnHeader
        Dim mVector, mVectorParametros, mSubVectorParametros, mVectorAux, mResumen(3, 1000)



        Dim output As String = System.IO.Path.GetTempPath & "archivo.xls" 'no funciona bien si uso el raíz
        Dim xlt As String = "C:\ProntoWeb\Proyectos\Pronto\Documentos" & "\Planilla.xlt"  'Session("glbPathPlantillas") & "\Planilla.xlt" 





        If Titulos <> "" Then
            mVector = Split(Titulos, "|")
        End If

        mContador = 0
        SaltoCada = 0
        mColumnaSumador1 = 0
        mColumnaSumador2 = 0
        mColumnaSumador3 = 0
        mColumnaSumador4 = 0
        mColumnaSumador5 = 0
        mColumnaSumador6 = 0
        mColumnaSumador7 = 0
        mColumnaSumador8 = 0
        mColumnaSumador9 = 0
        mColumnaSumador10 = 0
        mTotalPagina1 = 0
        mTotalPagina2 = 0
        mTotalPagina3 = 0
        mTotalPagina4 = 0
        mTotalPagina5 = 0
        mTotalPagina6 = 0
        mTotalPagina7 = 0
        mTotalPagina8 = 0
        mTotalPagina9 = 0
        mTotalPagina10 = 0
        mColumnaTransporte = 0
        mPaginaInicial = 0
        mParametrosEncabezado = ""
        mFinTransporte = False

        If Parametros <> "" Then
            mVectorParametros = Split(Parametros, "|")
            If UBound(mVectorParametros) > 0 Then
                For i = 0 To UBound(mVectorParametros)
                    If InStr(mVectorParametros(i), "SaltoDePaginaCada") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        SaltoCada = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja1") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador1 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja2") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador2 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja3") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador3 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja4") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador4 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja5") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador5 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja6") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador6 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja7") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador7 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja8") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador8 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja9") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador9 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "SumadorPorHoja10") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaSumador10 = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "ColumnaTransporte") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mColumnaTransporte = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "PaginaInicial") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mPaginaInicial = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "Enc:") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mParametrosEncabezado = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "FontDiario:") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mFontDiario = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "RowHeightDiario:") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mRowHeight = mSubVectorParametros(1)
                    ElseIf InStr(mVectorParametros(i), "TransporteInicialDiario:") <> 0 Then
                        mSubVectorParametros = Split(mVectorParametros(i), ":")
                        mTotalPagina1 = CDbl(mSubVectorParametros(1))
                        mTotalPagina2 = CDbl(mSubVectorParametros(1))

                    End If
                Next
            End If
        End If

        If mColumnaTransporte = 0 Then mColumnaTransporte = 3

        oEx = CreateObject("Excel.Application")

        Try
            oEx.Visible = False
            oBooks = oEx.Workbooks
            oBook = oBooks.Add()
            With oEx
                oEx.DisplayAlerts = False
                .Visible = False

                With .Workbooks.Add(xlt)

                    With .ActiveSheet

                        cl = 1
                        If mLista.Rows.Count > 0 Then
                            For Each oCol In mLista.HeaderRow.Cells
                                If oCol.Width.Value > 0 Or oCol.Text = "Vector_E" Then
                                    .Cells(1, cl) = oCol.Text
                                    cl = cl + 1
                                End If
                            Next
                        End If

                        fl = 2

                        If mTotalPagina1 <> 0 Or mTotalPagina2 <> 0 Or mTotalPagina3 <> 0 Or _
                              mTotalPagina4 <> 0 Or mTotalPagina5 <> 0 Or mTotalPagina6 <> 0 Or _
                              mTotalPagina7 <> 0 Or mTotalPagina8 <> 0 Or mTotalPagina9 <> 0 Or _
                              mTotalPagina10 <> 0 Then
                            .Cells(fl, mColumnaTransporte) = "Transporte"
                            If mColumnaSumador1 <> 0 Then
                                .Cells(fl, mColumnaSumador1) = mTotalPagina1
                                .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador2 <> 0 Then
                                .Cells(fl, mColumnaSumador2) = mTotalPagina2
                                .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador3 <> 0 Then
                                .Cells(fl, mColumnaSumador3) = mTotalPagina3
                                .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador4 <> 0 Then
                                .Cells(fl, mColumnaSumador4) = mTotalPagina4
                                .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador5 <> 0 Then
                                .Cells(fl, mColumnaSumador5) = mTotalPagina5
                                .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador6 <> 0 Then
                                .Cells(fl, mColumnaSumador6) = mTotalPagina6
                                .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador7 <> 0 Then
                                .Cells(fl, mColumnaSumador7) = mTotalPagina7
                                .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador8 <> 0 Then
                                .Cells(fl, mColumnaSumador8) = mTotalPagina8
                                .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador9 <> 0 Then
                                .Cells(fl, mColumnaSumador9) = mTotalPagina9
                                .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador10 <> 0 Then
                                .Cells(fl, mColumnaSumador10) = mTotalPagina10
                                .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                            End If
                            fl = fl + 1
                        End If

                        For Each oL In mLista.Rows

                            If mLista.HeaderRow.Cells(1).Width <> 0 Then

                                '///////////////////////////////////////////////////////////////////////
                                'Cómo saber que tipo de dato va a tener la columna de la gridview?
                                'Por ahora comento el codigo

                                'If mLista.TipoDatoColumna(0) = "D" Then
                                '    If IsDate(oL.Text) Then .Cells(fl, 1) = CDate(oL.Text)
                                'Else
                                '    If mLista.TipoDatoColumna(0) = "S" Then
                                '        .Cells(fl, 1) = "'" & oL.Text
                                '    Else
                                '        .Cells(fl, 1) = oL.Text
                                '    End If
                                'End If
                                '///////////////////////////////////////////////////////////////////////


                                cl1 = 1
                            Else
                                cl1 = 0
                            End If


                            cl = 1
                            For i = 0 To oL.Cells.Count - 2
                                oS = oL.Cells(i)

                                cl = cl + 1

                                If mLista.HeaderRow.Cells(i + 1).Width <> 0 Or _
                                      mLista.HeaderRow.Cells(i + 1).Text = "Vector_E" Then
                                    cl1 = cl1 + 1
                                    If Len(Trim(oS.Text)) <> 0 Then

                                        '///////////////////////////////////////////////////////////////////////
                                        'Cómo saber que tipo de dato va a tener la columna de la gridview?
                                        'Por ahora comento el codigo

                                        'If mLista.TipoDatoColumna(cl - 1) = "D" Then
                                        '    .Cells(fl, cl1) = CDate(oS.Text)
                                        'Else
                                        '    If mLista.TipoDatoColumna(cl - 1) = "S" Then
                                        '        .Cells(fl, cl1) = "'" & Mid(oS.Text, 1, 1000)
                                        '    Else
                                        '        .Cells(fl, cl1) = Mid(oS.Text, 1, 1000)
                                        '    End If
                                        'End If
                                        '///////////////////////////////////////////////////////////////////////


                                    End If

                                    mTotalizar = True
                                    mVectorAux = Split(oL.Cells(oL.Cells.Count - 1).Text, "|")
                                    If IsArray(mVectorAux) Then
                                        If UBound(mVectorAux) >= i Then
                                            If InStr(1, mVectorAux(i), "NOSUMAR") <> 0 Then
                                                mTotalizar = False
                                            End If
                                        End If
                                    End If

                                    If mLista.HeaderRow.Cells(i + 1).Text = "Vector_E" Then
                                        If InStr(1, oS.Text, "FinTransporte") <> 0 Then
                                            mFinTransporte = True
                                        End If
                                    End If

                                    If mColumnaSumador1 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina1 = mTotalPagina1 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador2 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina2 = mTotalPagina2 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador3 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina3 = mTotalPagina3 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador4 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina4 = mTotalPagina4 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador5 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina5 = mTotalPagina5 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador6 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina6 = mTotalPagina6 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador7 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina7 = mTotalPagina7 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador8 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina8 = mTotalPagina8 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador9 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina9 = mTotalPagina9 + CDbl(oS.Text)
                                    End If
                                    If mColumnaSumador10 = cl1 And IsNumeric(oS.Text) And mTotalizar Then
                                        mTotalPagina10 = mTotalPagina10 + CDbl(oS.Text)
                                    End If
                                End If
                            Next
                            fl = fl + 1
                            mContador = mContador + 1

                            If SaltoCada = mContador And Not mFinTransporte Then
                                mContador = 0
                                .Cells(fl, mColumnaTransporte) = "Transporte"
                                If mColumnaSumador1 <> 0 Then
                                    .Cells(fl, mColumnaSumador1) = mTotalPagina1
                                    .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador2 <> 0 Then
                                    .Cells(fl, mColumnaSumador2) = mTotalPagina2
                                    .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador3 <> 0 Then
                                    .Cells(fl, mColumnaSumador3) = mTotalPagina3
                                    .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador4 <> 0 Then
                                    .Cells(fl, mColumnaSumador4) = mTotalPagina4
                                    .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador5 <> 0 Then
                                    .Cells(fl, mColumnaSumador5) = mTotalPagina5
                                    .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador6 <> 0 Then
                                    .Cells(fl, mColumnaSumador6) = mTotalPagina6
                                    .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador7 <> 0 Then
                                    .Cells(fl, mColumnaSumador7) = mTotalPagina7
                                    .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador8 <> 0 Then
                                    .Cells(fl, mColumnaSumador8) = mTotalPagina8
                                    .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador9 <> 0 Then
                                    .Cells(fl, mColumnaSumador9) = mTotalPagina9
                                    .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                                End If
                                If mColumnaSumador10 <> 0 Then
                                    .Cells(fl, mColumnaSumador10) = mTotalPagina10
                                    .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                                End If
                                fl = fl + 1
                            End If

                        Next

                        If SaltoCada = -1 Then
                            If mColumnaSumador1 <> 0 Then
                                .Cells(fl, mColumnaSumador1) = mTotalPagina1
                                .Cells(fl, mColumnaSumador1).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador2 <> 0 Then
                                .Cells(fl, mColumnaSumador2) = mTotalPagina2
                                .Cells(fl, mColumnaSumador2).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador3 <> 0 Then
                                .Cells(fl, mColumnaSumador3) = mTotalPagina3
                                .Cells(fl, mColumnaSumador3).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador4 <> 0 Then
                                .Cells(fl, mColumnaSumador4) = mTotalPagina4
                                .Cells(fl, mColumnaSumador4).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador5 <> 0 Then
                                .Cells(fl, mColumnaSumador5) = mTotalPagina5
                                .Cells(fl, mColumnaSumador5).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador6 <> 0 Then
                                .Cells(fl, mColumnaSumador6) = mTotalPagina6
                                .Cells(fl, mColumnaSumador6).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador7 <> 0 Then
                                .Cells(fl, mColumnaSumador7) = mTotalPagina7
                                .Cells(fl, mColumnaSumador7).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador8 <> 0 Then
                                .Cells(fl, mColumnaSumador8) = mTotalPagina8
                                .Cells(fl, mColumnaSumador8).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador9 <> 0 Then
                                .Cells(fl, mColumnaSumador9) = mTotalPagina9
                                .Cells(fl, mColumnaSumador9).NumberFormat = "#,##0.00"
                            End If
                            If mColumnaSumador10 <> 0 Then
                                .Cells(fl, mColumnaSumador10) = mTotalPagina10
                                .Cells(fl, mColumnaSumador10).NumberFormat = "#,##0.00"
                            End If
                            fl = fl + 1
                        End If

                        .Range("A1").Select()

                        oEx.Run("ArmarFormato")

                        .Rows("1:1").Select()
                        oEx.Selection.Insert(Shift:=ExcelOffice.XlDirection.xlDown)
                        If Not IsNothing(mVector) Then
                            For i = 0 To UBound(mVector)
                                oEx.Selection.Insert(Shift:=ExcelOffice.XlDirection.xlDown)
                            Next

                            For i = 0 To UBound(mVector)
                                .Range("A" & i + 1).Select()
                                oEx.ActiveCell.FormulaR1C1 = mVector(i)
                                oEx.Selection.Font.Size = 12
                                If i = 0 Then oEx.Selection.Font.Bold = True
                            Next
                        End If





                        'If mPaginaInicial > 0 Then mPaginaInicial = mPaginaInicial - 1
                        oEx.Run("InicializarEncabezados", Session("glbEmpresa"), _
                                    Session("glbDireccion") & " " & Session("glbLocalidad"), Session("glbTelefono1"), _
                                    Session("glbDatosAdicionales1"), mPaginaInicial, mParametrosEncabezado)

                        With oEx.ActiveSheet.PageSetup
                            .PrintTitleRows = "$1:$" & UBound(mVector) + 3
                            .PrintTitleColumns = ""
                        End With

                        If Macro <> "" Then
                            If Len(Macro) > 0 Then
                                If InStr(Macro, "|") = 0 Then
                                    oEx.Run(Macro)
                                Else
                                    mVector = Split(Macro, "|")
                                    s = ""
                                    For i = 1 To UBound(mVector) : s = s & mVector(i) & "|" : Next
                                    If Len(s) > 0 Then s = Mid(s, 1, Len(s) - 1)
                                    oEx.Run(mVector(0), Session("glbStringConexion"), s)
                                End If
                            End If
                        End If

                    End With

                End With


                oBook.SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

            End With
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
            Return Nothing
        Finally

            'oEx.DisplayAlerts = True

            If Not oBook Is Nothing Then oBook.Close(False)
            NAR(oBook)
            If Not oBooks Is Nothing Then oBooks.Close()
            NAR(oBooks)
            'quit and dispose app
            oEx.Quit()
            NAR(oEx)
            'VERY IMPORTANT
            GC.Collect()
        End Try


        Return output

    End Function






    Function VerificarQueHayaCotizacionPesosDeHoyYSinoHuir(ByVal SC As String, ByRef YoSession As Object, Optional ByVal Fecha As Date = Nothing, Optional ByVal IdMoneda As Long = 1) As Double

        'por default pesos


        Dim mvarCotizacion = Cotizacion(SC)


        If mvarCotizacion = 0 Then
            MsgBox("No hay cotizacion, ingresela primero", vbExclamation)
        End If








        Fecha = iisValidSqlDate(Fecha, Today)


        If IdMoneda = 1 Then ' = mvarIdMonedaPesos Then
            Return 1
        Else
            Dim oRs = EntidadManager.GetStoreProcedure(SC, enumSPs.Cotizaciones_TX_PorFechaMoneda, Fecha, IdMoneda)
            If oRs.Rows.Count > 0 Then

                'asigna una cotizacion
                'txtCotizacionMoneda.Text = oRs.Fields("CotizacionLibre").Value

                'asigna OTRA cotizacion: para qué sirve esta?
                'If IdMoneda = mvarIdMonedaDolar Then
                ' txtCotizacion.Text = oRs.Fields("CotizacionLibre").Value
                'End If


            Else
                'Response.Redirect(String.Format("Cotizaciones.aspx"))
                MsgBoxAjaxAndRedirect(YoSession, "No hay cotizacion, ingresela manualmente", String.Format("Cotizaciones.aspx"))
                Return -1
            End If
        End If

    End Function





    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////







    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////



    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    'http://blog.evonet.com.au/post/Gridview-with-highlighted-search-results.aspx

    'Partial Class GridviewwithHighlightedSearch
    'Inherits System.Web.UI.Page

    ' Create a String to store our search results
    'Dim SearchString As String = ""

    Function HighlightText(ByVal InputTxt As String, ByVal q As String) As String
        ' This function is called whenever text is displayed in the FirstName and LastName 
        ' fields from our database. If we're not searching then just return the original 
        ' input, this speeds things up a bit

        'yo le agregué el parámetro donde le pasamos qué se está buscando. En el código original
        'usa una variable global donde se guardó el textbox, y no necesita que el Eval pase el parámetro

        If q = "" Then
            Return InputTxt
        Else
            ' Otherwise create a new regular expression and evaluate the FirstName and 
            ' LastName fields against our search string.
            Dim ResultStr As System.Text.RegularExpressions.Regex
            ResultStr = New Regex(q.Replace(" ", "|"), RegexOptions.IgnoreCase)
            Return ResultStr.Replace(InputTxt, New MatchEvaluator(AddressOf ReplaceWords))
        End If
    End Function

    Public Function ReplaceWords(ByVal m As Match) As String
        ' This match evaluator returns the found string and adds it a CSS class I defined 
        ' as 'highlight'
        Return "<span class=highlight>" + m.ToString + "</span>"
    End Function

    'Protected Sub btnClear_Click(ByVal sender As Object, ByVal e As  _
    '        System.Web.UI.ImageClickEventArgs) Handles btnClear.Click
    '    ' Simple clean up text to return the Gridview to it's default state
    '    'txtSearch.Text = ""
    '    SearchString = ""
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As  _
    '        System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
    '    ' Set the value of the SearchString so it gets 
    '    SearchString = q ' txtSearch.Text
    'End Sub
    'End Class




    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    Function iisIdValido(ByVal IdAValidar As Object, Optional ByVal verdadero As Object = True, Optional ByVal falso As Object = False) As Object
        If Not IsNumeric(IdAValidar) Then Return falso
        Try
            If IdAValidar > 0 Then
                Return verdadero
            Else
                Return falso
            End If
        Catch ex As Exception
            Return falso
        End Try
    End Function



    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    ' Casting entre capas.....
    '////////////////////////////////////////////////////////////////////////////////////////////

    'SQLtoNET()

    Function deGUIaBIZ(ByVal tipoSQL As ADODB.Field) As Object

    End Function

    Function deBIZaSQL(ByVal tipoSQL As ADODB.Field) As Object
        'SQLtoNET()
    End Function




    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////










    Enum tipos
        Cajas


        Empleados

        Vendedores
        ListasPrecios

        IBCondiciones

        Unidades

        Cuentas
        TiposCuentaGrupos
        CuentasGasto
        CuentasBancarias

        Bancos

        TiposValor

        Conceptos
        Obras
        Monedas


        CondicionCompra
        CondicionIVA
        TiposRetencionGanancias



        Provincias

        TiposComprobanteDeProveedores


    End Enum


    Sub IniciaCombo(ByVal combo As Object, ByVal datasource As Data.DataSet, ByVal textfield As String, ByVal valuefield As String, Optional ByVal leyendaNuevoItem As String = "-- Elija una Condición --")
        IniciaCombo(combo, datasource.Tables(0), textfield, valuefield, leyendaNuevoItem)
    End Sub

    Sub IniciaCombo(ByVal combo As Object, ByVal datasource As Data.DataTable, ByVal textfield As String, ByVal valuefield As String, Optional ByVal leyendaNuevoItem As String = "-- Elija una Condición --")
        combo.DataSource = datasource
        combo.DataTextField = textfield
        combo.DataValueField = valuefield
        combo.DataBind()
        combo.Items.Insert(0, New ListItem(leyendaNuevoItem, -1))
    End Sub


    Sub IniciaCombo(ByVal sc As String, ByVal combo As Object, ByVal tipo As tipos)
        Select Case tipo

            Case tipos.Cuentas
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Cuentas", "TL"), "Titulo", "IdCuenta", "-- Elija una Cuenta --")
            Case tipos.CuentasGasto
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "CuentasGastos", "TL"), "Titulo", "IdCuentaGasto", "-- Elija una cuenta de gasto --")
            Case tipos.TiposCuentaGrupos
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "TiposCuentaGrupos", "TL"), "Titulo", "IdTipoCuentaGrupo", "")

            Case tipos.Bancos
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Bancos", "TL"), "Titulo", "IdBanco", "-- Elija un Banco --")
            Case tipos.CuentasBancarias
                IniciaCombo(combo, EntidadManager.GetStoreProcedure(sc, "CuentasBancarias_TX_TodasParaCombo", -1), "Titulo", "IdCuentaBancaria", "-- Elija una cuenta bancaria --")



            Case tipos.TiposValor
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "TiposValor", "TL"), "Titulo", "IdTipoComprobante", "-- Elija un tipo de valor --")


            Case tipos.Cajas
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Cajas", "TL"), "Titulo", "IdCaja", "-- Elija una Caja --")

            Case tipos.Monedas
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Monedas", "TL"), "Titulo", "IdMoneda", "")
                BuscaTextoEnCombo(combo, "PESOS")

            Case tipos.Obras
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Obras", "TL"), "Titulo", "IdObra", "-- Elija una Obra --")

            Case tipos.Conceptos
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Conceptos", "TL"), "Titulo", "IdConcepto", "-- Elija un Concepto --")

            Case tipos.CondicionIVA
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "DescripcionIVA", "TL"), "Titulo", "IdCodigoIVA", "-- Elija una Condición --")


            Case tipos.Empleados
                IniciaCombo(combo, Pronto.ERP.Bll.EmpleadoManager.GetListCombo(sc), "Titulo", "IdEmpleado", "")

            Case tipos.Vendedores
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "Vendedores", "TL"), "Titulo", "IdVendedor", "")


            Case tipos.ListasPrecios
                IniciaCombo(combo, EntidadManager.GetListTX(sc, "ListasPrecios", "TL"), "Titulo", "IdListaPrecios", "-- Elija una Lista --")

            Case tipos.IBCondiciones

                IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.IBCondiciones_TL), "Titulo", "IdIBCondicion", "-- Elija una condición de IIBB--")

            Case tipos.Unidades
                Err.Raise(234, , "Usar LlenoComboDeUnidades(). Lo hace TraerDatosArticulo(), no hacerlo pues en BindTypeDropDown()")
                'IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.Unidades_TL), "Titulo", "IdUnidad", "-- Elija una unidad--")


            Case tipos.CondicionCompra
                IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.CondicionesCompra_TL), "Titulo", "IdCondicionCompra", "-- Elija una condición de compra--")
                'If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
                '    BuscaIDEnCombo(cmbCondicionCompra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
                '    cmbCondicionCompra.Enabled = False
                'Else


            Case tipos.TiposComprobanteDeProveedores
                IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.TiposComprobante_TX_ParaComboProveedores), "Titulo", "IdTipoComprobante", "-- Elija un comprobante --")

            Case tipos.Provincias
                IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.Provincias_TL), "Titulo", "IdProvincia", "")

            Case tipos.TiposRetencionGanancias
                IniciaCombo(combo, GetStoreProcedure(sc, enumSPs.TiposRetencionGanancia_TL), "Titulo", "IdTipoRetencionGanancia", "-- Elija una retención --")

            Case Else
                Err.Raise(234234)
        End Select
    End Sub






    Sub LlenoComboDeUnidades(ByVal SC As String, ByVal combo As DropDownList, ByVal IdArticulo As Long)
        With combo
            'Dim listaUnidadesHabilitadas = UnidadesHabilitadas(IdArticulo)
            Dim listaUnidadesHabilitadas = GetStoreProcedure(SC, enumSPs.Articulos_TX_UnidadesHabilitadas, IdArticulo) ' ArticuloManager.GetListTX(SC, "_UnidadesHabilitadas", IdArticulo)
            If listaUnidadesHabilitadas.Rows.Count > 1 Then
                .DataSource = listaUnidadesHabilitadas
                .DataTextField = "Titulo"
                .DataValueField = "IdUnidad"
                .DataBind()
                'If .Items.Count > 1 Then .Enabled = True Else .Enabled = False
            Else
                .DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
                .DataTextField = "Titulo"
                .DataValueField = "IdUnidad"
                .DataBind()
                BuscaIDEnCombo(combo, UnidadPorIdArticulo(IdArticulo, SC))
                '.Enabled = False
            End If

        End With
    End Sub

    Sub LlenoComboDeUnidades(ByVal SC As String, ByVal combo As AjaxControlToolkit.ComboBox, ByVal IdArticulo As Long)
        With combo
            'Dim listaUnidadesHabilitadas = UnidadesHabilitadas(IdArticulo)
            Dim listaUnidadesHabilitadas = GetStoreProcedure(SC, enumSPs.Articulos_TX_UnidadesHabilitadas, IdArticulo) 'ArticuloManager.GetListTX(SC, "_UnidadesHabilitadas", IdArticulo)
            If listaUnidadesHabilitadas.Rows.Count > 1 Then
                .DataSource = listaUnidadesHabilitadas
                .DataTextField = "Titulo"
                .DataValueField = "IdUnidad"
                .DataBind()
                If .Items.Count > 1 Then .Enabled = True Else .Enabled = False
            Else
                .DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
                .DataTextField = "Titulo"
                .DataValueField = "IdUnidad"
                .DataBind()
                BuscaIDEnCombo(combo, UnidadPorIdArticulo(IdArticulo, SC))
                .Enabled = False
            End If

        End With
    End Sub

    Public Function UnidadesHabilitadas(ByVal IdArticulo As Long) As ADODB.Recordset

        'Dim oRs As adodb.Recordset
        'oRs = ArticuloManager.GetListTX(sc, "_UnidadesHabilitadas", IdArticulo)
        'If oRs.RecordCount = 0 Then
        '    oRs.Close()
        '    oRs =entidadmanager.GetListTX(sc, "_UnidadesHabilitadas", IdArticulo) Unidades_TL
        'End If
        'UnidadesHabilitadas = oRs
        'oRs = Nothing

    End Function


    'Quién fue el que hizo el postback??
    'http://ryanfarley.com/blog/archive/2005/03/11/1886.aspx
    Function GetPostBackControl(ByVal Page As Page) As Control

        Dim control As Control = Nothing

        Dim ctrlname As String = Page.Request.Params.Get("__EVENTTARGET")

        If ctrlname <> Nothing And ctrlname <> String.Empty Then
            control = Page.FindControl(ctrlname)
        Else
            For Each ctl As String In Page.Request.Form
                Dim c As Control = Page.FindControl(ctl)
                If TypeOf c Is System.Web.UI.WebControls.Button Then
                    control = c
                    Exit For
                End If
            Next
        End If
        Return control
    End Function


    Public Function ImprimirWordDOT(ByVal mPlantilla As String, ByRef Yo As Object, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState, ByRef Response As System.Web.HttpResponse, ByVal Id As Long, Optional ByVal Arg3 As Object = Nothing, Optional ByVal Arg4 As Object = Nothing, Optional ByVal Arg5 As Object = Nothing, Optional ByVal outputFileName As String = "", Optional ByVal Arg6 As Object = Nothing, Optional ByVal Arg7 As Object = Nothing) As String


        If Id < 1 Then Return Nothing

        'Verificar:
        '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
        '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
        '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
        '   Reiniciar IIS
        '2) Trust Center de Excel 07
        '3) ComPronto mal referenciada en la plantilla XLT
        '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx


        'http://www.developerdotstar.com/community/automate_excel_dotnet


        'If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
        '    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
        '    MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
        '    Exit Sub
        'End If
        'Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
        'Dim mImprime As String = "N"
        'Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

        '///////////////////////////////////////////
        '///////////////////////////////////////////
        'es importante en estos dos archivos poner bien el directorio. 
        Dim plant As String
        If InStr(mPlantilla, "\") > 0 Then
            plant = mPlantilla
        Else
            plant = Session("glbPathPlantillas") & "\" & mPlantilla '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        End If
        'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

        'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
        'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
        Dim output As String
        If outputFileName = "" Then
            output = Session("glbPathPlantillas") & "\archivo.doc" 'no funciona bien si uso el raíz
        Else
            output = outputFileName
        End If

        Dim MyFile1 As New FileInfo(plant)
        Try
            If Not MyFile1.Exists Then 'busca la plantilla
                ErrHandler2.WriteError("No se encuentra la plantilla " & plant)
                MsgBoxAjax(Yo, "No se encuentra la plantilla " & plant)
                Return ""
            End If

            MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Yo, ex.ToString)
            Throw
            'Return ""
        End Try

        '///////////////////////////////////////////
        '///////////////////////////////////////////






        Dim oW As Word.Application
        Dim oDoc As Word.Document
        'Dim oBooks As ExcelOffice.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109


        Try
            oW = CreateObject("Word.Application")
            oW.Visible = False


            'estaría bueno que si acá tarda mucho, salga
            'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
            '  permisos (-permisos de qué???), y en el Run si está mal referenciada la dll
            '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
            Try
                oDoc = oW.Documents.Add(plant)
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString & "Explota en el oW.Documents.Add(plant).  Plantilla: " & plant & " No se puede abrir el " & _
                                      "almacenamiento de macros? Verficar las referencias de la plantilla a dlls (especialmente COMPRONTO). " & _
                                      "Verificar el directorio de plantillas. Tiene permisos para usar el directorio?")
                ErrHandler2.WriteError("Ojo que en 2008 en el directorio  C:\Windows\SysWOW64\config\systemprofile\ hay que crear una carpeta Desktop!!!!!!!!!!!!!!!!!!!!!  " + ex.ToString)

                Throw
            End Try




            If IsNothing(oDoc) Then
                'why the methord "Microsoft.Office.Interop.Word.ApplicationClass.Documents.Add" Returns null in .net web page
                'http://social.msdn.microsoft.com/Forums/en/vbgeneral/thread/5deb3d3a-552c-4dfd-8d94-236b8a441daf
                'http://forums.asp.net/t/1232621.aspx
                ErrHandler2.WriteError("!!!! ALERTA !!!! ALERTA !!!!!!!!!!! oDoc está en NOTHING!!! Muy probable que " & _
                                      "esté mal el impersonate (no dejarlo en true vacío, ponerle el " & _
                                      "usuario y el pass) " & IsNothing(oW) & "  Plantilla: " & plant & "")

                'Parece ser que puede ser por el impersonate… ERA ESO!!!! No me dejaba poner el 
                'impersonate=true vacío, le tuve que poner el usuario!!!!!!!!!!!

                'Huyo. Pero antes cierro todo
                Try
                    NAR(oDoc)
                    'quit and dispose app
                    oW.Quit()
                    NAR(oW)
                    'VERY IMPORTANT
                    GC.Collect()
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    'COM object that has been separated from its underlying RCW cannot be used.?????
                End Try

                Return ""
            End If






            With oDoc
                oW.DisplayAlerts = False ' Word.WdAlertLevel.wdAlertsNone

                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////


                Dim sStringVBA = "Emision """ & DebugCadenaImprimible(ClaseMigrar.ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing")

                Debug.Print(sStringVBA)
                ErrHandler2.WriteError(sStringVBA)



                'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
                'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
                'llamada a Emision desde el Excel del servidor y ver donde explota.
                '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
                '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!

                'Cómo hacer para que si se cuelga la llamada a .Run, salga a los 10 segundos?
                'Corro el riesgo de que se tilde el sitio:
                'The RPC server is unavailable. (Excepción de HRESULT: 0x800706BA)   (Remote Procedure Call)

                'http://forums.asp.net/p/1134671/1808767.aspx
                'http://forums.asp.net/p/1134671/1808767.aspx
                '                Hi(there!)
                '                That looks VBA-ish: Have you manually invoked the VBA editor on the server at least once (under the same account ASP.Net will use later)? That could solve the hanging, but Office performance on the web server will be just horrible (for Office was not designed to work in a multi user environment).
                'So we refrained from using Office InterOp at all. Instead we used OleDocumentProperties to pass server side information to some auto-starting Excel macros and let them do all the work, e.g. pulling data into work sheets using the connection settings provided via OleDocumentProperties by Asp.Net.
                'Just have a look at Microsoft's DsoFile.dll (comes with source code and .Net InterOp wrappers): The Dsofile.dll files lets you edit Office document properties when you do not have Office installed [sic].



                Try
                    If Arg7 IsNot Nothing Then
                        ErrHandler2.WriteError("6 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6, Arg7)
                    ElseIf Arg6 IsNot Nothing Then
                        ErrHandler2.WriteError("5 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6)
                    ElseIf Arg5 IsNot Nothing Then
                        ErrHandler2.WriteError("4 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5)
                    ElseIf Arg4 IsNot Nothing Then
                        ErrHandler2.WriteError("3 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4)
                    ElseIf Arg3 IsNot Nothing Then
                        ErrHandler2.WriteError("2 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3)
                    Else
                        ErrHandler2.WriteError("1 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id)
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError("Explota en la llamada a Emision ()" & ex.ToString & "")
                    'Throw
                End Try


                '                *Plantillas
                'Se queda colgado?
                'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                '-Mejor dicho, que no tengan un MsgBox al disparar un error
                'Permisos para ejecutar macros


                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                ' fin de macro
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////



                'and added it to the saveas command. The extn (.doc) decides on what format
                'the document is saved as.
                Const wrdFormatDocument As Object = 0 '(save in default format)
                ErrHandler2.WriteError("Pudo ejecutar el Emision(), ahora tratará de grabar")

                Try
                    'verificar q la ruta existe, sino se queda muy colgado
                    .SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
                Catch ex As Exception
                    ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oDoc) & " " & output & " " & wrdFormatDocument & ex.ToString & _
                        "Tiró 'El comando falló' o 'Command fail'? " & _
                        "Revisá http://social.msdn.microsoft.com/Forums/en/netfx64bit/thread/65a355ce-49c1-47f1-8c12-d9cf5f23c53e" & _
                        "y http://support.microsoft.com/default.aspx?scid=kb;EN-US;244264")
                    Throw
                End Try

                'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                oW.DisplayAlerts = True '  Word.WdAlertLevel.wdAlertsAll ' True
            End With





            'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " Archivo Plantilla: " & plant & vbCrLf & _
            "Figura en el log una llamada a Emision() o explotó antes? Verificar que la DLL ComPronto esté bien referenciada en la " & _
            "plantilla. no solamente basta con ver que esten bien las referencias! A veces, aunque figuren bien " & _
            ", el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la llamada a Emision , o " & _
            " que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), " & _
            " o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se " & _
            " llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro. Si no figura en el log " & _
            " una llamada a Emision, es que ni siquiera se lo pudo llamar")

            'MsgBoxAjax(Yo, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
            'Throw
            output = ""
        Finally
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBook)
            'oBook = Nothing
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
            'oBooks = Nothing
            'oEx.Quit()
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
            'oEx = Nothing
            'http://forums.devx.com/showthread.php?threadid=155202
            'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
            'The service (excel.exe) will continue to run
            Try
                ErrHandler2.WriteError("cerrando...")
                If Not oDoc Is Nothing Then oDoc.Close(False)
                ErrHandler2.WriteError("oDoc.Close(False) exito")
                NAR(oDoc)
                ErrHandler2.WriteError("NAR(oDoc) exito")
                'quit and dispose app
                oW.Quit()
                ErrHandler2.WriteError("oW.Quit() exito")

                NAR(oW) 'pinta q es acá donde se trula

                ErrHandler2.WriteError(" NAR(oW) exito")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                'VERY IMPORTANT
                GC.Collect()
                ErrHandler2.WriteError("Se llamó con exito a GC.Collect")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try



        End Try





        Return output 'porque no estoy pudiendo ejecutar el response desde acá

        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)

                Response.TransmitFile(output)
                Response.End()
            Else
                ErrHandler2.WriteError("No se pudo generar el informe. Consulte al administrador")
                'MsgBoxAjax(Yo, "No se pudo generar el informe. Consulte al administrador")
                Return ""
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'MsgBoxAjax(Yo, ex.ToString)
            'Return ""
        End Try



        ''Mandar el excel al cliente
        'HttpContext.Current.Response.Clear()
        'HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        'HttpContext.Current.Response.ContentType = "application/ms-excel"
        'Dim sw As StringWriter = New StringWriter
        'Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        ''  Create a form to contain the grid
        'Dim table As Table = New Table
        'table.GridLines = gv.GridLines
        ''  render the table into the htmlwriter
        'table.RenderControl(htw)
        ''  render the htmlwriter into the response
        'HttpContext.Current.Response.Write(sw.ToString)
        'HttpContext.Current.Response.End()



    End Function

    Public Function ImprimirWordDOTyGenerarTambienTXT(ByVal mPlantilla As String, ByRef Yo As Object, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState, ByRef Response As System.Web.HttpResponse, ByVal Id As Long, Optional ByVal Arg3 As Object = Nothing, Optional ByVal Arg4 As Object = Nothing, Optional ByVal Arg5 As Object = Nothing, Optional ByVal outputFileName As String = "", Optional ByVal Arg6 As Object = Nothing, Optional ByVal Arg7 As Object = Nothing) As String


        If Id < 1 Then Return Nothing

        'Verificar:
        '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
        '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
        '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
        '   Reiniciar IIS
        '2) Trust Center de Excel 07
        '3) ComPronto mal referenciada en la plantilla XLT
        '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx


        'http://www.developerdotstar.com/community/automate_excel_dotnet


        'If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
        '    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
        '    MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
        '    Exit Sub
        'End If
        'Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
        'Dim mImprime As String = "N"
        'Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

        '///////////////////////////////////////////
        '///////////////////////////////////////////
        'es importante en estos dos archivos poner bien el directorio. 
        Dim plant As String
        If InStr(mPlantilla, "\") > 0 Then
            plant = mPlantilla
        Else
            plant = Session("glbPathPlantillas") & "\" & mPlantilla '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        End If
        'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

        'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
        'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
        Dim output As String
        If outputFileName = "" Then
            output = Session("glbPathPlantillas") & "\archivo.doc" 'no funciona bien si uso el raíz
        Else
            output = outputFileName
        End If

        Dim MyFile1 As New FileInfo(plant)
        Try
            If Not MyFile1.Exists Then 'busca la plantilla
                ErrHandler2.WriteError("No se encuentra la plantilla " & plant)
                MsgBoxAjax(Yo, "No se encuentra la plantilla " & plant)
                Return ""
            End If

            MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Yo, ex.ToString)
            Throw
            'Return ""
        End Try

        '///////////////////////////////////////////
        '///////////////////////////////////////////






        Dim oW As Word.Application
        Dim oDoc As Word.Document
        'Dim oBooks As ExcelOffice.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109


        Try
            oW = CreateObject("Word.Application")
            oW.Visible = False


            'estaría bueno que si acá tarda mucho, salga
            'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
            '  permisos (-permisos de qué???), y en el Run si está mal referenciada la dll
            '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
            Try
                oDoc = oW.Documents.Add(plant)
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString & "Explota en el oW.Documents.Add(plant).  Plantilla: " & plant & " No se puede abrir el " & _
                                      "almacenamiento de macros? Verficar las referencias de la plantilla a dlls (especialmente COMPRONTO). " & _
                                      "Verificar el directorio de plantillas. Tiene permisos para usar el directorio?")
                ErrHandler2.WriteError("Ojo que en 2008 en el directorio  C:\Windows\SysWOW64\config\systemprofile\ hay que crear una carpeta Desktop!!!!!!!!!!!!!!!!!!!!!  " + ex.ToString)

                Throw
            End Try




            If IsNothing(oDoc) Then
                'why the methord "Microsoft.Office.Interop.Word.ApplicationClass.Documents.Add" Returns null in .net web page
                'http://social.msdn.microsoft.com/Forums/en/vbgeneral/thread/5deb3d3a-552c-4dfd-8d94-236b8a441daf
                'http://forums.asp.net/t/1232621.aspx
                ErrHandler2.WriteError("!!!! ALERTA !!!! ALERTA !!!!!!!!!!! oDoc está en NOTHING!!! Muy probable que " & _
                                      "esté mal el impersonate (no dejarlo en true vacío, ponerle el " & _
                                      "usuario y el pass) " & IsNothing(oW) & "  Plantilla: " & plant & "")

                'Parece ser que puede ser por el impersonate… ERA ESO!!!! No me dejaba poner el 
                'impersonate=true vacío, le tuve que poner el usuario!!!!!!!!!!!

                'Huyo. Pero antes cierro todo
                Try
                    NAR(oDoc)
                    'quit and dispose app
                    oW.Quit()
                    NAR(oW)
                    'VERY IMPORTANT
                    GC.Collect()
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    'COM object that has been separated from its underlying RCW cannot be used.?????
                End Try

                Return ""
            End If






            With oDoc
                oW.DisplayAlerts = False ' Word.WdAlertLevel.wdAlertsNone

                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////


                Dim sStringVBA = "Emision """ & DebugCadenaImprimible(ClaseMigrar.ReEncriptaParaPronto(SC)) & """," & Id & "," & iisNull(Arg3, "Nothing") & "," & iisNull(Arg4, "Nothing") & "," & iisNull(Arg5, "Nothing") & "," & iisNull(Arg6, "Nothing") & "," & iisNull(Arg7, "Nothing")

                Debug.Print(sStringVBA)
                'ErrHandler2.WriteError(sStringVBA)



                'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
                'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
                'llamada a Emision desde el Excel del servidor y ver donde explota.
                '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
                '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!

                'Cómo hacer para que si se cuelga la llamada a .Run, salga a los 10 segundos?
                'Corro el riesgo de que se tilde el sitio:
                'The RPC server is unavailable. (Excepción de HRESULT: 0x800706BA)   (Remote Procedure Call)

                'http://forums.asp.net/p/1134671/1808767.aspx
                'http://forums.asp.net/p/1134671/1808767.aspx
                '                Hi(there!)
                '                That looks VBA-ish: Have you manually invoked the VBA editor on the server at least once (under the same account ASP.Net will use later)? That could solve the hanging, but Office performance on the web server will be just horrible (for Office was not designed to work in a multi user environment).
                'So we refrained from using Office InterOp at all. Instead we used OleDocumentProperties to pass server side information to some auto-starting Excel macros and let them do all the work, e.g. pulling data into work sheets using the connection settings provided via OleDocumentProperties by Asp.Net.
                'Just have a look at Microsoft's DsoFile.dll (comes with source code and .Net InterOp wrappers): The Dsofile.dll files lets you edit Office document properties when you do not have Office installed [sic].



                Try
                    If Arg7 IsNot Nothing Then
                        'ErrHandler2.WriteError("6 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6, Arg7)
                    ElseIf Arg6 IsNot Nothing Then
                        'ErrHandler2.WriteError("5 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5, Arg6)
                    ElseIf Arg5 IsNot Nothing Then
                        'ErrHandler2.WriteError("4 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4, Arg5)
                    ElseIf Arg4 IsNot Nothing Then
                        'ErrHandler2.WriteError("3 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3, Arg4)
                    ElseIf Arg3 IsNot Nothing Then
                        'ErrHandler2.WriteError("2 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id, Arg3)
                    Else
                        'ErrHandler2.WriteError("1 argumento")
                        oW.Application.Run("Emision", ClaseMigrar.ReEncriptaParaPronto(SC), Id)
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError("Explota en la llamada a Emision ()" & ex.ToString & "")
                    'Throw
                End Try


                '                *Plantillas
                'Se queda colgado?
                'Verificar que tengan puesto un On Error Resume Next (no puedo catchear el error, y queda andando el Winword o Excel)
                '-Mejor dicho, que no tengan un MsgBox al disparar un error
                'Permisos para ejecutar macros


                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                ' fin de macro
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////



                'and added it to the saveas command. The extn (.doc) decides on what format
                'the document is saved as.
                Const wrdFormatDocument As Object = 0 '(save in default format)
                'ErrHandler2.WriteError("Pudo ejecutar el Emision(), ahora tratará de grabar")



                Try
                    If False Then
                        .SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
                    End If
                    .SaveAs(output & ".txt", Microsoft.Office.Interop.Word.WdSaveFormat.wdFormatUnicodeText, InsertLineBreaks:=False)
                    'expression.SaveAs(FileName, FileFormat, LockComments, Password, AddToRecentFiles, WritePassword, ReadOnlyRecommended, EmbedTrueTypeFonts, SaveNativePictureFormat, SaveFormsData, SaveAsAOCELetter, Encoding, InsertLineBreaks, AllowSubstitutions, LineEnding, AddBiDiMarks)
                    ' http://msdn.microsoft.com/en-us/library/bb221597(v=office.12).aspx
                Catch ex As Exception
                    ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oDoc) & " " & output & " " & wrdFormatDocument & ex.ToString & _
                        "Tiró 'El comando falló' o 'Command fail'? " & _
                        "Revisá http://social.msdn.microsoft.com/Forums/en/netfx64bit/thread/65a355ce-49c1-47f1-8c12-d9cf5f23c53e" & _
                        "y http://support.microsoft.com/default.aspx?scid=kb;EN-US;244264")
                    Throw
                End Try

                'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                oW.DisplayAlerts = True '  Word.WdAlertLevel.wdAlertsAll ' True
            End With





            'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " Archivo Plantilla: " & plant & vbCrLf & _
            "Figura en el log una llamada a Emision() o explotó antes? Verificar que la DLL ComPronto esté bien referenciada en la " & _
            "plantilla. no solamente basta con ver que esten bien las referencias! A veces, aunque figuren bien " & _
            ", el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la llamada a Emision , o " & _
            " que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), " & _
            " o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se " & _
            " llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro. Si no figura en el log " & _
            " una llamada a Emision, es que ni siquiera se lo pudo llamar")

            'MsgBoxAjax(Yo, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro")
            'Throw
            output = ""
        Finally
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBook)
            'oBook = Nothing
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
            'oBooks = Nothing
            'oEx.Quit()
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
            'oEx = Nothing
            'http://forums.devx.com/showthread.php?threadid=155202
            'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
            'The service (excel.exe) will continue to run
            Try
                'ErrHandler2.WriteError("cerrando...")
                If Not oDoc Is Nothing Then oDoc.Close(False)
                'ErrHandler2.WriteError("oDoc.Close(False) exito")
                NAR(oDoc)
                'ErrHandler2.WriteError("NAR(oDoc) exito")
                'quit and dispose app
                oW.Quit()
                'ErrHandler2.WriteError("oW.Quit() exito")

                NAR(oW) 'pinta q es acá donde se trula

                'ErrHandler2.WriteError(" NAR(oW) exito")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                'VERY IMPORTANT
                GC.Collect()
                ErrHandler2.WriteError("Se llamó con exito a GC.Collect")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try



        End Try





        Return output 'porque no estoy pudiendo ejecutar el response desde acá

        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)

                Response.TransmitFile(output)
                Response.End()
            Else
                ErrHandler2.WriteError("No se pudo generar el informe. Consulte al administrador")
                'MsgBoxAjax(Yo, "No se pudo generar el informe. Consulte al administrador")
                Return ""
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'MsgBoxAjax(Yo, ex.ToString)
            'Return ""
        End Try



        ''Mandar el excel al cliente
        'HttpContext.Current.Response.Clear()
        'HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        'HttpContext.Current.Response.ContentType = "application/ms-excel"
        'Dim sw As StringWriter = New StringWriter
        'Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        ''  Create a form to contain the grid
        'Dim table As Table = New Table
        'table.GridLines = gv.GridLines
        ''  render the table into the htmlwriter
        'table.RenderControl(htw)
        ''  render the htmlwriter into the response
        'HttpContext.Current.Response.Write(sw.ToString)
        'HttpContext.Current.Response.End()



    End Function

    Public Function ImprimirExcelXLT(ByVal mPlantilla As String, ByRef Yo As Object, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState, ByRef Response As System.Web.HttpResponse, ByVal Macro As String, Optional ByVal Arg1 As Object = Nothing, Optional ByVal Arg2 As Object = Nothing, Optional ByVal Arg3 As Object = Nothing, Optional ByVal Arg4 As Object = Nothing, Optional ByVal Arg5 As Object = Nothing, Optional ByVal Arg6 As Object = Nothing) As String
        '//////////////////////)

        'Verificar:
        '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
        '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
        '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
        '   Reiniciar IIS
        '2) Trust Center de Excel 07
        '3) ComPronto mal referenciada en la plantilla XLT
        '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx


        'http://www.developerdotstar.com/community/automate_excel_dotnet


        'If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
        '    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
        '    MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
        '    Exit Sub
        'End If
        'Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
        'Dim mImprime As String = "N"
        'Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

        '///////////////////////////////////////////
        '///////////////////////////////////////////

        'es importante en estos dos archivos poner bien el directorio. 
        Dim xlt As String = Session("glbPathPlantillas") & "\" & mPlantilla '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

        'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
        'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
        Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz


        Dim MyFile1 As New FileInfo(xlt)
        Try
            If Not MyFile1.Exists Then
                MsgBoxAjax(Yo, "No se encuentra la plantilla " & xlt)
                Return Nothing
            End If

            MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            MsgBoxAjax(Yo, ex.ToString)
            Return Nothing
        End Try

        '///////////////////////////////////////////
        '///////////////////////////////////////////






        Dim oEx As ExcelOffice.Application
        Dim oBooks As ExcelOffice.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        Dim oBook As ExcelOffice.Workbook


        Try
            oEx = CreateObject("Excel.Application")
            oEx.Visible = False

            oBooks = oEx.Workbooks



            'estaría bueno que si acá tarda mucho, salga
            'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
            '  permisos, y en el Run si está mal referenciada la dll
            '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
            oBook = oBooks.Add(xlt)


            'ProntoFuncionesUIWeb.Current_Alert("Hasta aca llega")
            'Return


            With oBook


                'Declaracion de la funcion en la plantilla:
                'Public Sub GenerarResFF(ByVal StringConexion As String, _
                '            ByVal Rendicion As Long, _
                '            ByVal IdCuentaFF As Long, _
                '            ByVal mEmpresa As String, _
                '            ByVal mImprime As String, _
                '            ByVal mCopias As Integer, _
                '            ByVal IdObra As Long)




                oEx.DisplayAlerts = False

                'txtPendientesReintegrar.Text = Encriptar(HFSC.Value)
                'ProntoFuncionesUIWeb.Current_Alert("Depurar GenerarResFF " & Encriptar(HFSC.Value) & " " & Rendicion & " " & cmbCuenta.SelectedValue & " EmpresaNombre " & mImprime & " 1 " & mObra)
                'Return

                'Try

                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                'ejecuto la macro. ZONA DE RIESGO (porque VBA puede tirar un error y no volver)
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////////
                Dim s As String = "'" & .Name & "'!" & Macro


                'http://forums.asp.net/p/1134671/1808767.aspx
                'http://forums.asp.net/p/1134671/1808767.aspx
                '                Hi(there!)
                'That looks VBA-ish: Have you manually invoked the VBA editor on the server at least 
                'once (under the same account ASP.Net will use later)? That could solve the hanging, but Office performance on the web server will be just horrible (for Office was not designed to work in a multi user environment).
                'So we refrained from using Office InterOp at all. Instead we used OleDocumentProperties to pass server side information to some auto-starting Excel macros and let them do all the work, e.g. pulling data into work sheets using the connection settings provided via OleDocumentProperties by Asp.Net.
                'Just have a look at Microsoft's DsoFile.dll (comes with source code and .Net InterOp wrappers): The Dsofile.dll files lets you edit Office document properties when you do not have Office installed [sic].


                'Debug.Print("Emision """ & DebugCadenaImprimible(Encriptar(SC)) & "," & Id)
                oEx.Run(s, ClaseMigrar.ReEncriptaParaPronto(SC), Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
                '//////////////////////



                'Catch ex As Exception
                'ProntoFuncionesUIWeb.Current_Alert("Llega a ejecutar la macro")
                'Return
                'End Try



                .SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

                'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                oEx.DisplayAlerts = True
            End With





            'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
            'MsgBoxAjax(Yo, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
            Throw
        Finally
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBook)
            'oBook = Nothing
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
            'oBooks = Nothing
            'oEx.Quit()
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
            'oEx = Nothing
            'http://forums.devx.com/showthread.php?threadid=155202
            'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
            'The service (excel.exe) will continue to run
            If Not oBook Is Nothing Then oBook.Close(False)
            NAR(oBook)
            oBooks.Close()
            NAR(oBooks)
            'quit and dispose app
            oEx.Quit()
            NAR(oEx)
            'VERY IMPORTANT
            GC.Collect()
        End Try




        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output)
                Response.End()
            Else
                MsgBoxAjax(Yo, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            Throw
            'MsgBoxAjax(Yo, ex.ToString)
            Return Nothing
        End Try



        ''Mandar el excel al cliente
        'HttpContext.Current.Response.Clear()
        'HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        'HttpContext.Current.Response.ContentType = "application/ms-excel"
        'Dim sw As StringWriter = New StringWriter
        'Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        ''  Create a form to contain the grid
        'Dim table As Table = New Table
        'table.GridLines = gv.GridLines
        ''  render the table into the htmlwriter
        'table.RenderControl(htw)
        ''  render the htmlwriter into the response
        'HttpContext.Current.Response.Write(sw.ToString)
        'HttpContext.Current.Response.End()



    End Function










    Function EncriptarParaCSharp(ByVal s As String) As String
        Return Encriptar(s)
    End Function




    'VIEWSTATE http://msdn.microsoft.com/en-us/magazine/cc163322.aspx
    'http://www.binaryfortress.com/aspnet-viewstate-helper/
    'http://blog.hmobius.com/post/2009/08/07/Debugging-ViewState-Errors-Visual-Studio-Debugging-Options.aspx
    Public Class DebugViewState
        'Ejemplo: DebugViewState.SeeViewState(Request.Form("__VIEWSTATE"), "c:\temp\viewstate.txt")
        'http://www.xoc.net/works/tips/viewstate.asp
        'Written by Greg Reddick. http://www.xoc.net
        Public Shared Sub SeeViewState(ByVal strViewState As String, ByVal strFilename As String)
            If Not strViewState Is Nothing Then
                Debug.Listeners.Clear()
                System.IO.File.Delete(strFilename)
                Debug.Listeners.Add(New TextWriterTraceListener(strFilename))
                Dim strViewStateDecoded As String = _
                    (New System.Text.UTF8Encoding()).GetString(Convert.FromBase64String(strViewState))
                Dim astrDecoded As String() = strViewStateDecoded.Replace("<", "<" _
                    & vbCr).Replace(">", vbCr & ">").Replace(";", ";" _
                    & vbCr).Split(Convert.ToChar(vbCr))
                Dim str As String
                Debug.IndentSize = 4
                For Each str In astrDecoded
                    If str.Length > 0 Then
                        If Right(str, 2) = "\<" Then
                            Debug.Write(str)
                        ElseIf Right(str, 1) = "\" Then
                            Debug.Write(str)
                        ElseIf Right(str, 1) = "<" Then
                            Debug.WriteLine(str)
                            Debug.Indent()
                        ElseIf str = ">;" Or str = ">" Then
                            Debug.Unindent()
                            Debug.WriteLine(str)
                        ElseIf Right(str, 2) = "\;" Then
                            Debug.Write(str)
                        Else
                            Debug.WriteLine(str)
                        End If
                    End If
                Next
                Debug.Close()
                Debug.Listeners.Clear()

                'Get into the debugger after executing this line to see how .NET looks at
                'the ViewState info. Compare it to the text file produced above.
                Try
                    Dim trp As Triplet = CType((New LosFormatter()).Deserialize(strViewState), Triplet)
                Catch ex As Exception
                    Dim pair As Pair = CType((New LosFormatter()).Deserialize(strViewState), Pair)
                    Debug.Print("")
                End Try

            End If
        End Sub







        'http://aspalliance.com/articleViewer.aspx?aId=135&pId=













    End Class







    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////



    Function UnidadPorIdArticulo(ByVal IdArticulo As Long, ByVal SC As String) As String
        If IdArticulo <= 0 Then Return 1
        Try
            Return ArticuloManager.GetItem(SC, IdArticulo).IdUnidad
        Catch ex As Exception
            Return 1 'esto es peligroso.... pero por ahora....

        End Try

    End Function

    Function UnidadDescripcionPorIdArticulo(ByVal IdArticulo As Long, ByVal SC As String) As String
        If IdArticulo <= 0 Then Return 1
        Try
            Return EntidadManager.GetItem(SC, "Unidades", ArticuloManager.GetItem(SC, IdArticulo).IdUnidad).Item("Descripcion")
        Catch ex As Exception
            Return 1 'esto es peligroso.... pero por ahora....

        End Try

    End Function






    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////





    Function ProntoCheckSINO(ByVal chkboxOrigen As CheckBox, Optional ByRef stringDestino As String = Nothing) As String
        ProntoCheckSINO = IIf(chkboxOrigen.Checked, "SI", "NO")
        If Not IsNothing(stringDestino) Then stringDestino = ProntoCheckSINO
    End Function

    Function ProntoCheckSINO(ByVal stringOrigen As String, ByRef chkboxDestino As CheckBox) As Boolean
        ProntoCheckSINO = IIf(stringOrigen = "SI", True, False)
        chkboxDestino.Checked = ProntoCheckSINO
    End Function

    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////


    Function ProntoOptionButton(ByRef optbOrigen As RadioButtonList, ByRef sDestino As String) As String
        sDestino = optbOrigen.SelectedItem.Value
        Return sDestino
    End Function

    Function ProntoOptionButton(ByRef optbOrigen As RadioButtonList, ByRef lDestino As Long) As Long
        lDestino = optbOrigen.SelectedItem.Value
        Return lDestino
    End Function

    Sub ProntoOptionButton(ByVal lOrigen As String, ByRef optbDestino As RadioButtonList)
        optbDestino.SelectedValue = lOrigen
    End Sub

    Sub ProntoOptionButton(ByVal lOrigen As Integer, ByRef optbDestino As RadioButtonList)
        optbDestino.SelectedValue = lOrigen
    End Sub
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////














    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////





    Function RefrescaSession(ByVal Server As System.Web.HttpServerUtility) As String

        '//////////////////////////////////////////////////////////////////
        'Quilombos con la session

        Dim mu As MembershipUser
        mu = Membership.GetUser()
        HttpContext.Current.Session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
        HttpContext.Current.Session(SESSIONPRONTO_UserName) = mu.UserName


        'el problema es q va a buscar datos de la session...  -el ID de la session tambien se manda por cookie

        Dim lista As Pronto.ERP.BO.EmpresaList
        'Como las conexiones del web.config que apuntan a la BDLmaster no estan encriptadas,
        'las encripto para que la capa inferior la use desencriptada cuando
        'cree que la encripta por primera vez
        Dim sConex As String
        sConex = ConexBDLmaster()
        lista = EmpresaManager.GetEmpresasPorUsuario(sConex, mu.ProviderUserKey.ToString)
        Dim usuario As Usuario = Nothing
        usuario = New Usuario
        usuario.UserId = mu.ProviderUserKey.ToString
        usuario.Nombre = mu.UserName


        'arreglar esto
        If Encriptar(sConex).Contains("SERVERSQL3") Then
            usuario.IdEmpresa = 52
        Else
            usuario.IdEmpresa = 18
        End If


        Try
            Dim s = Encriptar(BDLMasterEmpresasManager.GetConnectionStringEmpresa(usuario.UserId, usuario.IdEmpresa, sConex, "XXXXXX"))
            If s = "" Then
                'en la bdlMaster no hay conexion para este usuario+empresa
                '-pero el usuario ya está logueado... a donde lo redirigimos?

                Server.Transfer("~/SeleccionarEmpresa.aspx")

            End If
            usuario.StringConnection = s

        Catch ex As Exception

            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError("Verificar que el usuario tenga una empresa asignada")
            Throw
            'La conversión de la cadena "No se encontró empresa para el u" en el tipo 'Integer' no es válida
            'ah, el usuario gradice no tiene empresa asignada en la bdlmaster de clientes


        End Try



        HttpContext.Current.Session(SESSIONPRONTO_USUARIO) = usuario

        DatosDeSesion(usuario.StringConnection, usuario.Nombre, HttpContext.Current.Session, sConex, Nothing, usuario.IdEmpresa)


        Return usuario.StringConnection


    End Function




    Function GetConnectionString(ByVal Server As System.Web.HttpServerUtility, ByVal Session As System.Web.SessionState.HttpSessionState) As String
        Dim stringConn As String = String.Empty


        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection



            If stringConn = "" Then
                If Membership.GetUser() IsNot Nothing Then
                    ErrHandler2.WriteError(Membership.GetUser().UserName + " esta logueado, pero lo redirijo al login porque faltan los datos de session. No deberia mejor mandarlo a SeleccionarEmpresa? Ademas, no hago el LogOut y le queda el cookie!!!")



                    Return RefrescaSession(Server)
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////
                    '//////////////////////////////////////////////////////////////////

                Else
                    Server.Transfer("~/Login.aspx")
                End If
            End If
        Else
            If Membership.GetUser() IsNot Nothing Then
                ErrHandler2.WriteError(Membership.GetUser().UserName + " esta logueado, pero lo redirijo al login porque faltan los datos de session. No deberia mejor mandarlo a SeleccionarEmpresa? Ademas, no hago el LogOut y le queda el cookie!!!")



                Return RefrescaSession(Server)

                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////




            Else
                    Server.Transfer("~/Login.aspx")
            End If
        End If


        Return stringConn
    End Function


    Function EstaEsteRol(ByVal rolEnCuestion As String) As Boolean
        'existe ese rol?
        'Roles.GetAllRoles()

        'lo tiene el usuario de la sesion?
        Dim rol() As String
        rol = Roles.GetRolesForUser()
        For Each x As String In rol
            If x = rolEnCuestion Then
                Return True
            End If
        Next
        Return False
    End Function

    Function BuscaTextoEnCombo(ByVal combo As DropDownList, ByVal TextoSeleccionado As Object) As Boolean
        Dim s As String = If(IsDBNull(TextoSeleccionado), "", CStr(TextoSeleccionado))
        Return BuscaTextoEnCombo(combo, s)
    End Function

    Function BuscaTextoEnCombo(ByVal combo As DropDownList, ByVal TextoSeleccionado As String) As Boolean


        If Not (combo.Items.FindByText(TextoSeleccionado) Is Nothing) Then
            combo.SelectedIndex = -1
            combo.Items.FindByText(TextoSeleccionado).Selected = True
            Return True
        Else
            'no estarás buscando el id?
            'If BuscaIDEnCombo() Then
            Return False
        End If
    End Function

    Function BuscaTextoEnCombo(ByVal combo As AjaxControlToolkit.ComboBox, ByVal TextoSeleccionado As Object) As Boolean
        Dim s As String = If(IsDBNull(TextoSeleccionado), "", CStr(TextoSeleccionado))
        Return BuscaTextoEnCombo(combo, s)
    End Function


    Function BuscaTextoEnCombo(ByVal combo As AjaxControlToolkit.ComboBox, ByVal TextoSeleccionado As String) As Boolean


        If Not (combo.Items.FindByText(TextoSeleccionado) Is Nothing) Then
            combo.SelectedIndex = -1
            combo.Items.FindByText(TextoSeleccionado).Selected = True
            Return True
        Else
            'no estarás buscando el id?
            'If BuscaIDEnCombo() Then
            Return False
        End If
    End Function

    Public Function ProntoParamOriginal(ByVal SC As String, ByVal Campo As String) As String
        Return ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item(Campo).ToString()
    End Function

    Function BuscaIDEnCombo(ByVal combo As DropDownList, ByVal id As Integer) As Boolean
        If Not (combo.Items.FindByValue(id) Is Nothing) Then
            combo.SelectedValue = id
            Return True
        Else
            'no estarás buscando el texto, no?
            Return False
        End If
    End Function

    Function BuscaIDEnCombo(ByVal combo As AjaxControlToolkit.ComboBox, ByVal id As Integer) As Boolean
        If Not (combo.Items.FindByValue(id) Is Nothing) Then
            combo.SelectedValue = id
            Return True
        Else
            'no estarás buscando el texto, no?
            Return False
        End If
    End Function


    Function AgregaLeyendaEnCombo(ByVal combo As DropDownList, ByVal s As String) As Boolean
        If combo.Items.FindByText(s) Is Nothing And combo.Items.FindByValue(-1) Is Nothing Then
            combo.Items.Insert(0, New ListItem(s, -1))
            combo.SelectedIndex = 0
        End If
    End Function
    Function AgregaLeyendaEnCombo(ByVal combo As AjaxControlToolkit.ComboBox, ByVal s As String) As Boolean
        If combo.Items.FindByText(s) Is Nothing And combo.Items.FindByValue(-1) Is Nothing Then
            combo.Items.Insert(0, New ListItem(s, -1))
            combo.SelectedIndex = 0
        End If
    End Function


    'http://stackoverflow.com/questions/505353/how-do-i-disable-all-controls-in-asp-net-page
    'http://www.experts-exchange.com/Programming/Languages/.NET/ASP.NET/Q_23920814.html
    'Then call it like so: 
    '           DisableControls(Page)
    Sub DisableControls(ByVal parent As Control, Optional ByVal sSufijoObligatorio As String = "ContentPlaceHolder")
        Try
            For Each c As Control In parent.Controls
                If InStr(c.ClientID, sSufijoObligatorio) > 0 Then
                    If (TypeOf c Is DropDownList) Then CType(c, DropDownList).Enabled = False
                    If (TypeOf c Is RadioButtonList) Then CType(c, RadioButtonList).Enabled = False
                    If (TypeOf c Is TextBox) Then CType(c, TextBox).Enabled = False
                    If (TypeOf c Is Label) Then CType(c, Label).Enabled = False
                    If (TypeOf c Is GridView) Then CType(c, GridView).Enabled = False
                    If (TypeOf c Is Button) Then CType(c, Button).Enabled = False
                    If (TypeOf c Is LinkButton) Then CType(c, LinkButton).Enabled = False
                    If (TypeOf c Is CheckBox) Then CType(c, CheckBox).Enabled = False
                End If

                DisableControls(c)
            Next
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub



    '//////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////
    ' MSGBOX
    '//////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////

    'Cómo hacer para mandar un MsgBox desde el servidor (problema del UserInteractive)
    'http://forums.asp.net/p/907491/907491.aspx
    'Si se usan updatepanels no se puede usar el truquito del alert. Usá ajax directo
    'http://forums.asp.net/t/1170288.aspx

    Public Sub MsgBoxAjaxAndRedirect(ByRef Yo As Object, ByVal sAviso As String, ByVal sRedirect As String)
        On Error Resume Next
        Dim s = String.Format("alert('{0}');", sAviso.Replace("'", "\'").Replace("\n", "\\n").Replace("\r", "\\r"))

        s += "window.location.href ='" & sRedirect & "';"

        's += "window.location.href ='Principal.aspx';"

        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Yo, Yo.GetType(), "StartUpScript1", s, True)
    End Sub

    Public Sub MsgBoxAjax(ByRef Yo As Object, ByVal sAviso As String)
        On Error Resume Next
        'sAviso = sAviso.Replace("'", "\'").Replace("\n", "\\n").Replace("\r", "\\r").Replace(vbCrLf, "\\n")
        sAviso = sAviso.Replace("'", "\'").Replace("\n", "\n").Replace("\r", "\r").Replace(vbCrLf, "\n")
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Yo, Yo.GetType(), "StartUpScript1", "alert('" & sAviso & " ')", True)
    End Sub

    Public Sub MsgBoxAjaxAndCerrarVentana(ByRef Yo As Object, ByVal sAviso As String)
        On Error Resume Next
        Dim cerrar = "alert('" & sAviso & " '); window.close();"



        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Yo, Yo.GetType(), "StartUpScript1", cerrar, True)
    End Sub




    'Este no sé cuando conviene usarlo... Si es desde el BUS? Eh? No tiene sentido
    Public Sub MsgBoxAlert(ByVal sMessage As String, Optional ByVal sURL As String = "")
        On Error Resume Next
        Dim str As String
        Dim P As System.Web.UI.Page = CType(System.Web.HttpContext.Current.Handler, System.Web.UI.Page)
        Dim sb As New Text.StringBuilder(Len(sMessage) * 5)
        sMessage = sMessage.Replace(Chr(0), "")
        For Each c As String In sMessage : sb.Append("\x" & Right("0" & Hex(Asc(c)), 2)) : Next
        str = vbCrLf & "<script language=javascript>" & vbCrLf
        str = str & "    alert('" & sb.ToString & "');" & vbCrLf
        If Len(sURL) > 0 Then str = str & "    window.location='" & sURL & "';" & vbCrLf
        str = str & "</script>" & vbCrLf
        P.ClientScript.RegisterStartupScript(P.GetType, "", str)
    End Sub






    Public Sub SetFocusAjax(ByRef Yo As Object, ByVal ctrlUniqueID As String)
        Try
            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Yo, Yo.GetType(), "FocusScript", _
                                            "document.getElementById('" + ctrlUniqueID + "').focus();", _
                                            True)

        Catch ex As Exception

        End Try
    End Sub




    '//////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////



    ''' <summary>
    ''' Me traigo el id de una columna de un gridview buscando por el nombre 
    ''' </summary>
    ''' <param name="columnName"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function getGridIDcolbyHeader(ByVal columnName As String, ByVal GridView1 As GridView) As Integer

        'http://forums.asp.net/p/1076872/1584635.aspx
        'http://forums.asp.net/p/1064584/3311593.aspx#3311593
        'Usage:    lblDepartment.Text = GridView1.Rows(0).Cells(getColumnID("Department")).Text


        For Each column As DataControlField In GridView1.Columns

            If column.HeaderText = columnName Then

                Dim columnID As Integer = GridView1.Columns.IndexOf(column)

                Return columnID

            End If
        Next

        Return -1
    End Function


    Public Function TraerCadenaConexionSegunEmpresa(ByVal IdEmpresa As String, ByRef Session As Object, ByVal StringConnection As String, ByVal Yo As Object) As String
        'GetConnectionStringEmpresa()
        'GetConnectionStringEmpresa(Usuario.UserId, 0, StringConnection, IdEmpresa)

        'Encriptar()
    End Function




    Private Function CUIToRazonSocial(ByVal s As Proveedor) _
        As Boolean

        ' AndAlso prevents evaluation of the second Boolean
        ' expression if the string is so short that an error
        ' would occur.

        'If (s.RazonSocial = session(SESSIONPRONTO_USUARIO)) Or s.Cuit = session(SESSIONPRONTO_USUARIO) Then
        'Return True
        'Else
        'Return False
        'End If
    End Function


End Module

Public Module ProntoDebugUIWebPendientesDeMigrar


    Function DebugGetDataTableColumnNamesRSconValores(ByVal rs As ADODB.Recordset) As String
        DebugGetDataTableColumnNamesRSconValores = ""
        For i As Integer = 0 To rs.Fields.Count - 1
            DebugGetDataTableColumnNamesRSconValores += rs.Fields(i).Name.PadRight(40) & rs.Fields(i).Value & vbCrLf
        Next


        Dim nombre As String = "Debug" & DateTime.Today.ToString("dd-MM-yy") & ".txt"
        Dim nombreLargo As String = System.Web.HttpContext.Current.Server.MapPath(nombre)

        Try
            File.Create(nombreLargo).Close()
        Catch ex As Exception
            'si no está creado el directorio "Error", lo graba en el de la aplicacion, pero con hora, por si ya existe otro
            'nombreLargo = System.Web.HttpContext.Current.Server.MapPath("~/" & DateTime.Now.ToString & ".txt")
            'File.Create(nombreLargo).Close()
        End Try


        Using w As StreamWriter = File.AppendText(nombreLargo)
            w.WriteLine(DebugGetDataTableColumnNamesRSconValores)
            w.Flush()
            w.Close()

            'Debug.Print(err)
        End Using



        Process.Start("notepad.exe", nombreLargo)


    End Function



End Module






