Option Infer On

Imports System
Imports System.ComponentModel
Imports System.Transactions
Imports System.EnterpriseServices
Imports Pronto.ERP.BO
Imports Pronto.ERP.Dal
Imports System.Configuration
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Linq   '"namespace or type specified in ... doesn't contain any " -Sorry Linq is only available in .net 3.5 http://forums.asp.net/t/1332780.aspx  Advanced Compile Options

Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.Strings
Imports ADODB.DataTypeEnum
Imports System.Diagnostics
Imports System.Data

Imports System.DateTime

Imports System.Xml

Imports ClaseMigrar.SQLdinamico

Imports ExcelOffice = Microsoft.Office.Interop.Excel

Imports System.Data.SqlClient

Imports System.IO

Imports System.Net.NetworkInformation
Imports System.Net.Security
Imports System.Net.Sockets


Imports System.Web
Imports System.Web.UI.WebControls

Imports CDPMailFiltrosManager2

Imports Microsoft.Reporting.WebForms




'Namespace ProntoMVC.Data.Models
'    <Serializable()> Partial Public Class FertilizantesCupos
'    End Class
'End Namespace




Namespace Pronto.ERP.Bll




    '<Transaction(TransactionOption.Required)> _
    <DataObjectAttribute()> _
    Public Class CDPMailFiltrosManager





        Shared Function AdjuntosFacturacionCartasImputadas_Excel(IdFactura As Long, SC As String, ByRef ReportViewer2 As Microsoft.Reporting.WebForms.ReportViewer) As String
            Dim q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada_Todos(SC)
            Dim l = q.Where(Function(x) x.IdFacturaImputada = IdFactura).ToList()
            Dim rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl"
            Dim sExcelFileName = Path.GetTempPath & "Listado general " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            Dim output = ProntoFuncionesUIWeb.RebindReportViewerExcel(SC, _
                                     rdl, _
                                    l.ToDataTable, sExcelFileName)
            Return output
        End Function


        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        'Function generarNotasDeEntrega(ByVal FechaDesde As Date, ByVal FechaHasta As Date, ByVal PosicionODescarga As String, ByVal IdVendedor As Integer, ByVal CuentaOrden1 As Integer, ByVal CuentaOrden2 As Integer, ByVal Corredor As Integer, ByVal IdEntregador As Integer, ByVal IdArticulo As Integer) As String
        'Shared Function generarNotasDeEntrega(ByVal SC As String, ByVal dr As DataRow, ByVal estado As CartaDePorteManager.enumCDPestado, ByRef lineasGeneradas As Long, ByRef titulo As String, ByVal strWHERE As String, ByVal logo As String) As String
        '    'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "Select * from CartasDePorte CDP where Entregador=" & IdEntregador)

        '    Dim dt = CartaDePorteManager.GetListDataTableDinamicoConWHERE(SC, estado, strWHERE)
        '    lineasGeneradas = dt.Rows.Count

        '    If System.Diagnostics.Debugger.IsAttached() And dt.Rows.Count > 2000 Then
        '        'Err.Raise(32434, "generarNotasDeEntrega", "Modo IDE. Mail muy grande. No se enviará")
        '        Return -2 'si estoy en modo IDE, no mandar mail grande
        '    End If

        '    If dt.Rows.Count > 0 Then

        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        'GENERO EL EXCEL
        '        'no se puede reemplazar esto con el epplus? 
        '        '-y con OOXML?

        '        Dim TituloDeFiltroUsado As String
        '        TituloDeFiltroUsado = titulo + " " + TituloDeFiltroUsado
        '        titulo = TituloDeFiltroUsado

        '        Dim sExcelFileName As String = DataTableToExcelWilliams(dt, TituloDeFiltroUsado, logo)
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////




        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        'y no te conviene zipear? 
        '        'http://weblogs.asp.net/jgalloway/archive/2007/10/25/creating-zip-archives-in-net-without-an-external-library-like-sharpziplib.aspx
        '        'http://msdn.microsoft.com/en-us/library/system.io.packaging.zippackage%28v=VS.90%29.aspx

        '        If False Then
        '            Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(sExcelFileName & ".zip") 'usando la .NET Zip Library
        '            zip.AddFile(sExcelFileName, True)
        '            zip.Save()
        '            Return zip.Name
        '        End If
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////
        '        '//////////////////////////////////////


        '        Return sExcelFileName
        '    Else
        '        Return -1
        '    End If
        'End Function



        Public Shared Function DataTableToExcelWilliams(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "", Optional ByVal logo As String = "") As String

            Dim vFileName As String = Path.GetTempFileName()
            'Dim vFileName As String = "c:\archivo.txt"
            FileOpen(1, vFileName, OpenMode.Output)
            Dim sb As String = ""
            Dim dc As DataColumn
            For Each dc In pDataTable.Columns
                sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
            Next
            PrintLine(1, sb)
            Dim i As Integer = 0
            Dim dr As DataRow
            For Each dr In pDataTable.Rows
                i = 0 : sb = ""
                For Each dc In pDataTable.Columns
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
                PrintLine(1, sb)
            Next


            FileClose(1)



            Return TextToExcelWilliams(vFileName, titulo, logo)
        End Function


        Public Shared Function TextToExcelWilliams(ByVal pFileName As String, Optional ByVal titulo As String = "", Optional ByVal sImgLogoWilliamsPath As String = "") As String

            Dim vFormato As ExcelOffice.XlRangeAutoFormat
            Dim Exc As ExcelOffice.Application = CreateObject("Excel.Application")
            Exc.Visible = False
            Exc.DisplayAlerts = False

            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            'importa el archivo de texto
            'Guarda con la configuracion regional. Si en el servidor está usando la coma (despues
            'de todo, no se usa el pronto en el servidor), lo importa mal
            'http://answers.yahoo.com/question/index?qid=20080917051138AAxit8S
            'http://msdn.microsoft.com/en-us/library/aa195814(office.11).aspx
            'http://www.newsgrupos.com/microsoft-public-es-excel/304517-problemas-con-comas-y-puntos-al-guardar-de-excel-un-archivo-txtmediante-vb.html

            Exc.Workbooks.OpenText(pFileName, , , , ExcelOffice.XlTextQualifier.xlTextQualifierNone, , True, , , , , , , , ".", ",")

            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////



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
                Dim filas = Ws.UsedRange.Rows.Count
                Ws.Cells(filas + 1, "E") = "TOTAL:"
                Ws.Cells(filas + 1, "F") = Exc.WorksheetFunction.Sum(Ws.Range("F2:F" & filas))
                Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
                Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))
                Ws.Cells(filas + 1, "I") = Exc.WorksheetFunction.Sum(Ws.Range("I2:I" & filas))
                Ws.Cells(filas + 1, "J") = Exc.WorksheetFunction.Sum(Ws.Range("J2:J" & filas))
                Ws.Cells(filas + 1, "K") = Exc.WorksheetFunction.Sum(Ws.Range("K2:K" & filas))
                Ws.Cells(filas + 1, "N") = Exc.WorksheetFunction.Sum(Ws.Range("N2:N" & filas))
                Ws.Cells(filas + 1, "O") = Exc.WorksheetFunction.Sum(Ws.Range("O2:O" & filas))
                Ws.Cells(filas + 1, "P") = Exc.WorksheetFunction.Sum(Ws.Range("P2:P" & filas))


                '/////////////////////////////////
                'muevo la planilla formateada para tener un espacio arriba
                Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

                '/////////////////////////////////
                'poner tambien el filtro que se usó para hacer el informe
                Ws.Cells(7, 1) = titulo

                '/////////////////////////////////
                'insertar la imagen 
                'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
                'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")
                Dim imag = Ws.Pictures.Insert(sImgLogoWilliamsPath)
                imag.Left = 1
                imag.top = 1

                '/////////////////////////////////
                'insertar link
                Dim rg As ExcelOffice.Range = Ws.Cells(3, 10)
                'rg.hip()
                'rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
                'rg.Hyperlinks(1).TextToDisplay=
                Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
                'Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








                '/////////////////////////////////
                '/////////////////////////////////

                'Usando un GUID
                'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                'Usando la hora
                pFileName = System.IO.Path.GetTempPath() + "WilliamsEntregas " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

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











        Public Shared Function EnviarMailFiltroPorRegistro(ByVal SC As String, ByVal fechadesde As Date, _
                                                  ByVal fechahasta As Date, ByVal puntoventa As Integer, _
                                                  ByVal titulo As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                  ByRef dr As DataRow, _
                                                  ByRef sError As String, ByVal bVistaPrevia As Boolean, _
                                                  ByVal SmtpServer As String, ByVal SmtpUser As String, _
                                                  ByVal SmtpPass As String, ByVal SmtpPort As Integer, ByVal CCOaddress As String, _
                                                  ByRef sError2 As String _
                                                     ) As String


            Dim ModoImpresion As String = iisNull(dr.Item("ModoImpresion"), "Excel")
            Dim bDescargaHtml = CartaDePorteManager.informesHtml.ToList().Contains(ModoImpresion)



            If bDescargaHtml Or True Then
                Return CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta, puntoventa, titulo, estado, dr, sError, bVistaPrevia, SmtpServer, SmtpUser, SmtpPass, SmtpPort, CCOaddress, sError2)

            End If






            Dim output As String
            'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, sc), Nothing)
            With dr
                Dim l As Long



                'If Not chkConLocalReport.Checked Then
                '    Dim sWHERE = generarWHEREparaSQL(sc, dr, titulo, estado, _
                '                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                '                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
                '    output = generarNotasDeEntrega(sc, dr, estado, l, titulo, sWHERE, Server.MapPath("~/Imagenes/Williams.bmp"))
                'Else




                If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
                    fechadesde = #1/1/1753#
                    fechahasta = #1/1/2100#

                ElseIf estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha Then
                    'saqué esto. justamente, si uso rangofecha, las fechas tienen que estar
                    'pero quizas estas usando otra cosa en el enviarya....
                    ' fechadesde = #1/1/1753#
                    ' fechahasta = #1/1/2100#


                End If


                Try
                    Dim sWHERE = generarWHEREparaDataset(SC, dr, titulo, estado, _
                                                iisValidSqlDate(fechadesde, #1/1/1753#), _
                                                iisValidSqlDate(fechahasta, #1/1/2100#), puntoventa)

                Catch ex As Exception
                    'logear el idfiltro con problemas

                    ErrHandler2.WriteError(ex.ToString)
                    dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Falló: " & ex.ToString, 100)
                    Throw
                End Try







                Dim tiempoinforme, tiemposql As Integer

                If Debugger.IsAttached And False Then
                    'output = generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
                Else
                    output = generarNotasDeEntregaConReportViewer(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
                End If


                'End If





                If output <> "-1" And output <> "-2" Then
                    'MandaEmail("mscalella911@gmail.com", "Mailing Williams", "", , , , , "C:\ProntoWeb\doc\williams\Excels de salida\NE Descargas para el corredor Intagro.xls")

                    'Dim mails() As String = Split(.Item("EMails"), ",")
                    'For Each s As String In mails
                    'ErrHandler2.WriteError("asdasde")
                    Dim De As String

                    Select Case puntoventa
                        Case 1
                            De = "buenosaires@williamsentregas.com.ar"
                            CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                        Case 2
                            De = "sanlorenzo@williamsentregas.com.ar"
                            CCOaddress = "descargas-sl@williamsentregas.com.ar" ' & CCOaddress
                        Case 3
                            De = "arroyoseco@williamsentregas.com.ar"
                            CCOaddress = "descargas-as@williamsentregas.com.ar" '& CCOaddress
                        Case 4
                            De = "bahiablanca@williamsentregas.com.ar"
                            CCOaddress = "descargas-bb@williamsentregas.com.ar" ' & CCOaddress
                        Case Else
                            De = "buenosaires@williamsentregas.com.ar"
                            CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                    End Select

                    Try
                        Dim destinatario As String
                        Dim truquito As String '= "    <img src =""http://" & HttpContext.Current.Request.ServerVariables("HTTP_HOST") & "/Pronto/mailPage.aspx?q=" & iisNull(UsuarioSesion.Mail(sc, Session)) & "&e=" & .Item("EMails") & "_" & tit & """/>" 'imagen para que llegue respuesta cuando sea leido
                        Dim cuerpo As String

                        If bVistaPrevia Then ' chkVistaPrevia.Checked Then
                            'lo manda a la casilla del usuario
                            'ver cómo crear una regla en Outlook para forwardearlo a la casilla correspondiente
                            'http://www.eggheadcafe.com/software/aspnet/34183421/question-on-rules-on-unattended-mailbox.aspx
                            destinatario = .Item("AuxiliarString2") ' UsuarioSesion.Mail(sc, Session)
                            cuerpo = .Item("EMails") & truquito
                        Else
                            'lo manda a la casilla del destino
                            destinatario = .Item("EMails")

                            'destinatario &= "," & De

                            cuerpo = truquito
                        End If


                        Dim stopWatch As New Stopwatch()
                        stopWatch.Start()














                        Dim idVendedor As Integer = iisNull(.Item("Vendedor"), -1)
                        Dim idCorredor As Integer = iisNull(.Item("Corredor"), -1)
                        Dim idDestinatario As Integer = iisNull(.Item("Entregador"), -1)
                        Dim idIntermediario As Integer = iisNull(.Item("CuentaOrden1"), -1)
                        Dim idRemComercial As Integer = iisNull(.Item("CuentaOrden2"), -1)
                        Dim idArticulo As Integer = iisNull(.Item("IdArticulo"), -1)
                        Dim idProcedencia As Integer = iisNull(.Item("Procedencia"), -1)
                        Dim idDestino As Integer = iisNull(.Item("Destino"), -1)



                        Dim AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR = iisNull(.Item("AplicarANDuORalFiltro"), 0)
                        Dim ModoExportacion As String = .Item("modo").ToString
                        Dim optDivisionSyngenta As String = "Ambas"


                        Dim asunto As String

                        Try

                            'Dim fechadesde As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/1753#)
                            'Dim fechahasta As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/2100#)



                            asunto = CartaDePorteManager.FormatearAsunto(SC, _
                                 "", _
                                estado, "", idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRemComercial, idArticulo, idProcedencia, idDestino, _
                               AplicarANDuORalFiltro, ModoExportacion, _
                              fechadesde, fechahasta, _
                               puntoventa, optDivisionSyngenta, False, "", "", -1)
                        Catch ex As Exception
                            asunto = "mal formateado"
                            ErrHandler2.WriteError(ex.ToString + " asunto mal formateado")
                        End Try



                        If bDescargaHtml Or ModoImpresion = "ExcHtm" Then

                            Dim html As String = ""
                            html = cuerpo


                            If True Then
                                'ahora mando un html corto aunque use el excel grande
                                dr("ModoImpresion") = "HImag2"
                                Dim lineasGeneradas As Integer = 0
                                Dim output2 = CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, lineasGeneradas, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)

                                Dim grid As New GridView
                                html = CartaDePorteManager.ExcelToHtml(output2, grid)
                                dr("ModoImpresion") = ModoImpresion
                            End If


                            cuerpo = EncabezadoHtml(puntoventa) & cuerpo & html & AgregarFirmaHtml(puntoventa)



                            MandaEmail_Nuevo(destinatario, _
                                        asunto, _
                                      cuerpo, _
                                   De, _
                                   SmtpServer, _
                                            SmtpUser, _
                                            SmtpPass, _
                                             output, _
                                            SmtpPort, _
                                    , _
                                    CCOaddress, , , De)


                            'MandaEmail(destinatario, _
                            '                    asunto, _
                            '                  cuerpo + output, _
                            '                   De, _
                            '                 SmtpServer, _
                            '                SmtpUser, _
                            '                SmtpPass, _
                            '                "", _
                            '                SmtpPort, _
                            '                 , _
                            '                 CCOaddress, _
                            '                    truquito _
                            '                    , "Williams Entregas" _
                            '               )
                        Else


                            cuerpo = EncabezadoHtml(puntoventa) & cuerpo & AgregarFirmaHtml(puntoventa)


                            MandaEmail_Nuevo(destinatario, _
                                                asunto, _
                                              cuerpo, _
                                               De, _
                                             SmtpServer, _
                                            SmtpUser, _
                                            SmtpPass, _
                                             output, _
                                            SmtpPort, _
                                             , _
                                             CCOaddress, _
                                                truquito _
                                                , "Williams Entregas", De _
                                           )

                        End If


                        stopWatch.Stop()
                        Dim tiempomail = stopWatch.Elapsed.Milliseconds


                        Dim s = "Enviado con éxito a las " & Now.ToString(" hh:mm") & ". CDPs filtradas: " & l & " sql:" & tiemposql & " rs:" & tiempoinforme & " mail:" & tiempomail

                        dr.Item("UltimoResultado") = s

                    Catch ex As Exception
                        'Verificar Mails rechazados en la cuenta que los envió
                        '        http://www.experts-exchange.com/Programming/Languages/C_Sharp/Q_23268068.html
                        'TheLearnedOne:
                        'The only way that I know of is to look in the Inbox for rejected messages.

                        '        Bob



                        ErrHandler2.WriteError("Error en EnviarMailFiltroPorId() " + ex.ToString)
                        'dddd()
                        dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Falló:  " & ex.ToString, 100)
                        'MsgBoxAjax(Me, "Fallo al enviar. " & ex.ToString)
                    End Try

                    'Next
                ElseIf output = "-1" Then
                    sError += "El filtro genera un informe vacío." & vbCrLf

                    dr.Item("UltimoResultado") = "Generó un informe vacío a las " & Now.ToString("hh:mm")
                ElseIf output = "-2" Then

                    sError += "Modo IDE. Mail muy grande. No se enviará." & vbCrLf

                    dr.Item("UltimoResultado") = Now.ToString("hh:mm") & " Modo IDE. Mail muy grande. No se enviará"
                End If




            End With

            Try
                sError2 = dr.Item("UltimoResultado")
            Catch ex As Exception

            End Try

            Return output


        End Function





        Public Shared Function EnviarMailFiltroPorId(ByVal SC As String, ByVal fechadesde As Date, _
                                                     ByVal fechahasta As Date, ByVal puntoventa As Integer, _
                                                     ByVal id As Long, ByVal titulo As String, ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                     ByRef sError As String, ByVal bVistaPrevia As Boolean, _
                                                     ByVal SmtpServer As String, ByVal SmtpUser As String, _
                                                     ByVal SmtpPass As String, ByVal SmtpPort As Integer, ByVal CCOaddress As String, _
                                                     ByRef sError2 As String _
                                                        ) As String






            'Dim Id = GridView1.DataKeys(fila.RowIndex).Values(0).ToString()
            Dim dt = CDPMailFiltrosManager2.TraerMetadata(SC, id)
            Dim dr = dt.Rows(0)


            Dim archivo = EnviarMailFiltroPorRegistro(SC, fechadesde, fechahasta, puntoventa, titulo, estado, dr, sError, bVistaPrevia, SmtpServer, SmtpUser, SmtpPass, SmtpPort, CCOaddress, sError2)


            Update(SC, dt)

            Return archivo




            ''Dim Id = GridView1.DataKeys(fila.RowIndex).Values(0).ToString()
            'Dim dt = TraerMetadata(SC, id)
            'Dim dr = dt.Rows(0)



            'If iisNull(dr.Item("ModoImpresion"), "Excel") = "ExcHtm" Then
            '    ErrHandler2.WriteError("llamando a EnviarMailFiltroPorId_DLL")

            '    Dim s = CDPMailFiltrosManager2.EnviarMailFiltroPorId_DLL(SC, fechadesde, fechahasta, puntoventa, id, titulo, estado, sError, bVistaPrevia, SmtpServer, SmtpUser, SmtpPass, SmtpPort, CCOaddress, sError2)

            '    ErrHandler2.WriteError("terminado EnviarMailFiltroPorId_DLL. " & sError2)

            '    Return s
            'End If




            'Dim output As String
            ''output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, sc), Nothing)
            'With dr
            '    Dim l As Long



            '    'If Not chkConLocalReport.Checked Then
            '    '    Dim sWHERE = generarWHEREparaSQL(sc, dr, titulo, estado, _
            '    '                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
            '    '                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
            '    '    output = generarNotasDeEntrega(sc, dr, estado, l, titulo, sWHERE, Server.MapPath("~/Imagenes/Williams.bmp"))
            '    'Else




            '    If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
            '        fechadesde = #1/1/1753#
            '        fechahasta = #1/1/2100#

            '    ElseIf estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha Then
            '        fechadesde = #1/1/1753#
            '        fechahasta = #1/1/2100#

            '    End If


            '    Try
            '        Dim sWHERE = generarWHEREparaDataset(SC, dr, titulo, estado, _
            '                                    iisValidSqlDate(fechadesde, #1/1/1753#), _
            '                                    iisValidSqlDate(fechahasta, #1/1/2100#), puntoventa)

            '    Catch ex As Exception
            '        'logear el idfiltro con problemas

            '        ErrHandler2.WriteError(ex.ToString)
            '        ErrHandler2.WriteError("Error en llamada a generarWHEREparaDataset().   IdFiltro " + id.ToString())
            '        'dddd()
            '        dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Falló: " & ex.ToString, 100)
            '        Throw
            '    End Try


            '    ' Dim bDescargaHtml =        CartaDePorteManager.CONSTANTE_HTML
            '    Dim bDescargaHtml = (iisNull(.Item("ModoImpresion"), "Excel") = "Html" Or iisNull(.Item("ModoImpresion"), "Excel") = "HtmlIm")


            '    Dim tiempoinforme, tiemposql As Integer

            '    If Debugger.IsAttached And False Then
            '        'output = generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
            '    Else
            '        output = generarNotasDeEntregaConReportViewer(SC, fechadesde, fechahasta, dr, estado, l, titulo, "", puntoventa, tiemposql, tiempoinforme, bDescargaHtml)
            '    End If


            '    'End If





            '    If output <> "-1" And output <> "-2" Then
            '        'MandaEmail("mscalella911@gmail.com", "Mailing Williams", "", , , , , "C:\ProntoWeb\doc\williams\Excels de salida\NE Descargas para el corredor Intagro.xls")

            '        'Dim mails() As String = Split(.Item("EMails"), ",")
            '        'For Each s As String In mails
            '        'ErrHandler2.WriteError("asdasde")
            '        Dim De As String

            '        Select Case puntoventa
            '            Case 1
            '                De = "buenosaires@williamsentregas.com.ar"
            '                CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
            '            Case 2
            '                De = "sanlorenzo@williamsentregas.com.ar"
            '                CCOaddress = "descargas-sl@williamsentregas.com.ar" ' & CCOaddress
            '            Case 3
            '                De = "arroyoseco@williamsentregas.com.ar"
            '                CCOaddress = "descargas-as@williamsentregas.com.ar" '& CCOaddress
            '            Case 4
            '                De = "bahiablanca@williamsentregas.com.ar"
            '                CCOaddress = "descargas-bb@williamsentregas.com.ar" ' & CCOaddress
            '            Case Else
            '                De = "buenosaires@williamsentregas.com.ar"
            '                CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
            '        End Select

            '        Try
            '            Dim destinatario As String
            '            Dim truquito As String '= "    <img src =""http://" & HttpContext.Current.Request.ServerVariables("HTTP_HOST") & "/Pronto/mailPage.aspx?q=" & iisNull(UsuarioSesion.Mail(sc, Session)) & "&e=" & .Item("EMails") & "_" & tit & """/>" 'imagen para que llegue respuesta cuando sea leido
            '            Dim cuerpo As String

            '            If bVistaPrevia Then ' chkVistaPrevia.Checked Then
            '                'lo manda a la casilla del usuario
            '                'ver cómo crear una regla en Outlook para forwardearlo a la casilla correspondiente
            '                'http://www.eggheadcafe.com/software/aspnet/34183421/question-on-rules-on-unattended-mailbox.aspx
            '                destinatario = .Item("AuxiliarString2") ' UsuarioSesion.Mail(sc, Session)
            '                cuerpo = .Item("EMails") & truquito
            '            Else
            '                'lo manda a la casilla del destino
            '                destinatario = .Item("EMails")

            '                'destinatario &= "," & De

            '                cuerpo = truquito
            '            End If


            '            Dim stopWatch As New Stopwatch()
            '            stopWatch.Start()



            '            cuerpo &= AgregarFirmaHtml(puntoventa)





            '            'Adjuntar zip de imagenes
            '            'imagenes = CartaDePorteManager.DescargarImagenesAdjuntas(dt, SC, False)




            '            Dim idVendedor As Integer = iisNull(.Item("Vendedor"), -1)
            '            Dim idCorredor As Integer = iisNull(.Item("Corredor"), -1)
            '            Dim idDestinatario As Integer = iisNull(.Item("Entregador"), -1)
            '            Dim idIntermediario As Integer = iisNull(.Item("CuentaOrden1"), -1)
            '            Dim idRemComercial As Integer = iisNull(.Item("CuentaOrden2"), -1)
            '            Dim idArticulo As Integer = iisNull(.Item("IdArticulo"), -1)
            '            Dim idProcedencia As Integer = iisNull(.Item("Procedencia"), -1)
            '            Dim idDestino As Integer = iisNull(.Item("Destino"), -1)



            '            Dim AplicarANDuORalFiltro As CartaDePorteManager.FiltroANDOR = iisNull(.Item("AplicarANDuORalFiltro"), 0)
            '            Dim ModoExportacion As String = .Item("modo").ToString
            '            Dim optDivisionSyngenta As String = "Ambas"


            '            Dim asunto As String

            '            Try

            '                'Dim fechadesde As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/1753#)
            '                'Dim fechahasta As DateTime = iisValidSqlDate(DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", Globalization.CultureInfo.InvariantCulture), #1/1/2100#)


            '                asunto = CartaDePorteManager.FormatearAsunto(SC, _
            '                     "", _
            '                   estado, "", idVendedor, idCorredor, _
            '                  idDestinatario, idIntermediario, _
            '                  idRemComercial, idArticulo, idProcedencia, idDestino, _
            '                   AplicarANDuORalFiltro, ModoExportacion, _
            '                  fechadesde, fechahasta, _
            '                   puntoventa, optDivisionSyngenta, False, "", "", -1)
            '            Catch ex As Exception
            '                asunto = "mal formateado"
            '                ErrHandler2.WriteError(ex.ToString + " asunto mal formateado")
            '            End Try



            '            If bDescargaHtml Then



            '                MandaEmail_Nuevo(destinatario, _
            '                            asunto, _
            '                          cuerpo + output, _
            '                       De, _
            '                       SmtpServer, _
            '                                SmtpUser, _
            '                                SmtpPass, _
            '                                 "", _
            '                                SmtpPort, _
            '                        , _
            '                        CCOaddress, , , De)


            '                'MandaEmail(destinatario, _
            '                '                    asunto, _
            '                '                  cuerpo + output, _
            '                '                   De, _
            '                '                 SmtpServer, _
            '                '                SmtpUser, _
            '                '                SmtpPass, _
            '                '                "", _
            '                '                SmtpPort, _
            '                '                 , _
            '                '                 CCOaddress, _
            '                '                    truquito _
            '                '                    , "Williams Entregas" _
            '                '               )
            '            Else

            '                MandaEmail_Nuevo(destinatario, _
            '                                    asunto, _
            '                                  cuerpo, _
            '                                   De, _
            '                                 SmtpServer, _
            '                                SmtpUser, _
            '                                SmtpPass, _
            '                                output, _
            '                                SmtpPort, _
            '                                 , _
            '                                 CCOaddress, _
            '                                    truquito _
            '                                    , "Williams Entregas", De _
            '                               )

            '            End If


            '            stopWatch.Stop()
            '            Dim tiempomail = stopWatch.Elapsed.Milliseconds


            '            Dim s = "Enviado con éxito a las " & Now.ToString(" hh:mm") & ". CDPs filtradas: " & l & " sql:" & tiemposql & " rs:" & tiempoinforme & " mail:" & tiempomail

            '            If False Then
            '                ErrHandler2.WriteError("IdFiltro(no de cola)=" & id & " Enviado con éxito a las " & Now.ToString & ". CDPs filtradas: " & l)
            '            End If

            '            dr.Item("UltimoResultado") = s

            '            Update(SC, dt)

            '        Catch ex As Exception
            '            'Verificar Mails rechazados en la cuenta que los envió
            '            '        http://www.experts-exchange.com/Programming/Languages/C_Sharp/Q_23268068.html
            '            'TheLearnedOne:
            '            'The only way that I know of is to look in the Inbox for rejected messages.

            '            '        Bob



            '            ErrHandler2.WriteError("Error en EnviarMailFiltroPorId() " + ex.ToString)
            '            'dddd()
            '            dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Falló:  " & ex.ToString, 100)
            '            Update(SC, dt)
            '            'MsgBoxAjax(Me, "Fallo al enviar. " & ex.ToString)
            '        End Try

            '        'Next
            '    ElseIf output = "-1" Then
            '        sError += "El filtro " & id & " genera un informe vacío." & vbCrLf

            '        dr.Item("UltimoResultado") = "Generó un informe vacío a las " & Now.ToString("hh:mm")
            '        Update(SC, dt)
            '    ElseIf output = "-2" Then

            '        sError += "Modo IDE. Mail muy grande. No se enviará." & vbCrLf

            '        dr.Item("UltimoResultado") = Now.ToString("hh:mm") & " Modo IDE. Mail muy grande. No se enviará"
            '        Update(SC, dt)
            '    End If




            'End With

            'Try
            '    sError2 = dr.Item("UltimoResultado")
            'Catch ex As Exception

            'End Try

            'Return output

        End Function





        Public Shared Sub MailLoopWork(ByVal SC As String)
            'Cómo hacer este proceso desatendido?????? -Un windows service en .net, como dice el tipo de abajo
            'http://codebetter.com/blogs/brendan.tompkins/archive/2004/05/13/13484.aspx
            'http://forums.asp.net/t/309249.aspx

            'IMHO the solution to this problem would be this: 
            '- create a windows Service in .Net that generated the printouts 
            '- have you ASP.NET application talk to the service to print it out. 
            'This way the two processes can be run under completely different account/securty contexts. The tricky stuff is where you communicate between the two processes. 

            Try

                ' CartasConCopiaSinAsignar(SC)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try





            Dim sError = "", sError2 = ""
            Dim c As Long
            Dim tHoraEmpieza, tHoraTermina As Date

            Dim encolado = 0

            'SC = Encriptar(SC)
            Dim dt '= CDPMailFiltrosManager.Fetch(SC, 0) 'el cero es porque levanta los filtros de TODOS los puntos de venta

            tHoraEmpieza = Now

            Randomize()


            'podria tener un tope de tiempo

            Const MAXIMO_MAILS_POR_LLAMADA = 3000



            Dim UltimoAgrupador As Integer = -1



            PurgarColaDeMails(SC)

            Try

                dt = ColaMails.TraerPrimerEncolado(SC)
                'dt = DataTableWHERE(dt, "UltimoResultado='En Cola'")
                c = dt.Rows.Count



                If c = 0 Then

                    dt = ColaMails.TraerPrimerAtrasado(SC)
                    c = dt.Rows.Count
                    If c = 0 Then Exit Sub

                End If

                'ErrHandler2.WriteError("Mailloopwork Empieza")
                'Label1.Text = c
                'Me.Refresh()
                'Application.DoEvents()


                'System.Threading.Thread.Sleep(200 + Rnd() * 200)

                While c > 0 And encolado < MAXIMO_MAILS_POR_LLAMADA

                    '-es importante que la dt esté ordenada por AgrupadorDeTandaPeriodos
                    '-quizas lo que podes hacer es solo traerte un dt que use el mismo AgrupadorDeTandaPeriodos!
                    '-pero... por qué dt trae solo el primerencolado??? para qué está el for entonces????


                    For Each iddr As DataRow In dt.Rows

                        Dim dta = ColaMails.TraerUno(SC, iddr.Item(0))
                        Dim fila = dta.Rows(0)

                        'ok, qué hacemos entonces con los que quedan con la marca de "procesandose"?????
                        '-verifico que siga encolado (quizas otra instancia ya lo envió) o que esté procesandose hace rato
                        If iisNull(fila.Item("UltimoResultado")) = "En Cola" _
                            Or (InStr(iisNull(fila.Item("UltimoResultado")), "Procesandose") > 0 _
                                    And MinutosDiferencia(fila.Item("UltimoResultado")) > 4) Then

                            Dim bPreview = False
                            If iisNull(fila.Item("AuxiliarString2")) <> "" Then bPreview = True

                            Dim puntoventa = iisNull(fila.Item("AuxiliarString1"))
                            Dim AgrupadorDeTandaPeriodos As Integer = iisNull(fila.Item("AgrupadorDeTandaPeriodos"), -1)

                            Dim estadoDeCartaporte As CartaDePorteManager.enumCDPestado = Val(iisNull(fila.Item("EstadoDeCartaPorte"), CartaDePorteManager.enumCDPestado.Posicion))


                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////



                            Dim fechadesde = iisValidSqlDate(fila.Item("FechaDesde"), #1/1/1753#)
                            Dim fechahasta = iisValidSqlDate(fila.Item("FechaHasta"), #1/1/2100#)

                            Dim SigueSiendoLaMismaTandaDePeriodo As Boolean

                            If AgrupadorDeTandaPeriodos = UltimoAgrupador Then
                                SigueSiendoLaMismaTandaDePeriodo = True
                            Else
                                SigueSiendoLaMismaTandaDePeriodo = False
                            End If
                            UltimoAgrupador = AgrupadorDeTandaPeriodos


                            If True Then

                                Try
                                    If Not SigueSiendoLaMismaTandaDePeriodo Then
                                        'refrescar el filtro en cartas portes
                                        CDPMailFiltrosManager2.AgruparPorPeriodo(SC, estadoDeCartaporte, AgrupadorDeTandaPeriodos, fechadesde, fechahasta)
                                    End If

                                Catch ex As Exception
                                    'si el agrupador tiene problemas, desactivarlo
                                    AgrupadorDeTandaPeriodos = -1
                                    'Desactivar()
                                End Try

                            Else
                                AgrupadorDeTandaPeriodos = -1
                            End If

                            'ojo, el EnviarMailFiltroPorId va a usar el AgrupadorDeTandaPeriodos del filtro, no de la cola!!!!!!

                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////
                            '////////////////////////////////////////////////////////////////////////////////////////////




                            dta.Rows(0).Item("UltimoResultado") = "Procesandose " & Now.ToString '("hh:mm")
                            Dim bOK = ColaMails.Insert_o_Update(SC, dta)

                            If bOK = 0 Then
                                CDPMailFiltrosManager.EnviarMailFiltroPorId(SC, _
                                                                    iisValidSqlDate(fila.Item("FechaDesde"), #1/1/1753#), _
                                                                    iisValidSqlDate(fila.Item("FechaHasta"), #1/1/2100#), _
                                                                     puntoventa, _
                                                                    fila.Item("IdWilliamsMailFiltro"), "", _
                                                                       estadoDeCartaporte, _
                                                                    sError, bPreview, _
                                                                    ConfigurationManager.AppSettings("SmtpServer"), _
                                                                    ConfigurationManager.AppSettings("SmtpUser"), _
                                                                    ConfigurationManager.AppSettings("SmtpPass"), _
                                                                     ConfigurationManager.AppSettings("SmtpPort"), _
                                                                      "", sError2)

                                encolado += 1


                                dta = ColaMails.TraerUno(SC, iddr.Item(0)) 'lo vuelvo a traer (parece que le gusta más así al adaptertable...) 
                                'dta.Rows(0).Item("UltimoResultado") = "Terminado " & Now.ToString '("hh:mm")
                                dta.Rows(0).Item("UltimoResultado") = sError2


                                '//////////////////////////////////////////////////////////////
                                'intentar diez veces si anduvo mal esto
                                Dim intento As Integer
                                Dim bok2 = ColaMails.Insert_o_Update(SC, dta)
                                Do While bok2 <> 0 And intento < 10
                                    bok2 = ColaMails.Insert_o_Update(SC, dta)
                                    intento = +1
                                Loop
                                '//////////////////////////////////////////////////////////////



                            End If


                        End If
                        c = c - 1
                        'Label1.Text = c
                        'Me.Refresh()
                        'Application.DoEvents()
                        'System.Threading.Thread.Sleep(2000)
                    Next






                    dt = ColaMails.TraerPrimerEncolado(SC)
                    c = dt.Rows.Count

                    If c = 0 Then
                        dt = ColaMails.TraerPrimerAtrasado(SC)
                        c = dt.Rows.Count
                    End If



                End While


            Catch ex As Exception


                ErrHandler2.WriteError(ex)
                'guardar cual es el idfiltro que falla
                'fila.Item("IdWilliamsMailFiltro")
            End Try

            Try
                tHoraTermina = Now
                ErrHandler2.WriteError("Mailloopwork Termina. " & encolado & " filtros armados" & " Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. ")

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            'Label1.Text = "Detenido"
        End Sub




        Shared Function HoyNoSeEnvioTodavia(ByVal SC As String) As Boolean
            Dim UltimoEnvio As DateTime = iisNull(ParametroManager.TraerValorParametro2(SC, "FechaUltimoEnvioCartasCopiaPendientes"), "1/1/1980")

            If DateTime.Today > UltimoEnvio And DateTime.Today.Hour > ConfigurationManager.AppSettings("HoraEnvioCartasPendientes") Then
                Return True
            End If
            Return False
        End Function

        Shared Sub MarcarFechaEnvioPendientes(sc As String)
            ParametroManager.GuardarValorParametro2(sc, "FechaUltimoEnvioCartasCopiaPendientes", DateTime.Now.ToString)
        End Sub


        Shared Function CartasConCopiaSinAsignar(ByVal SC As String)


            If HoyNoSeEnvioTodavia(SC) Then

                'Dim q = LogicaFacturacion.CartasConCopiaSinAsignarLINQ(SC)

                Dim q = LogicaFacturacion.TodasLasQueNoSonEntregadorWilliamsYavisarEnMensaje(SC)


                'Dim ReportViewerEscondido As Microsoft.Reporting.WinForms.ReportViewer  'con WinForms
                Dim ReportViewerEscondido As Microsoft.Reporting.WebForms.ReportViewer   'con WebForms


                Dim sExcelFileName As String = "CopiasSinAsignar.xls"

                Dim stopWatch As New Stopwatch()

                Dim rdl As String

                'Using ReportViewerEscondido As New Microsoft.Reporting.WebForms.ReportViewer
                Try

                    ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer


                    rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\Cartas con Copia sin asignar.rdl"

                    ProntoFuncionesUIWeb.RebindReportViewerLINQ(ReportViewerEscondido, sExcelFileName, rdl, q)
                    'sExcelFileName = ProntoFuncionesUIWeb.RebindReportViewer(ReportViewerEscondido, rdl, New DataTable())
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                Finally
                    'http://stackoverflow.com/questions/7208482/weird-behaviour-when-i-open-a-reportviewer-in-wpf
                    ReportViewerEscondido.LocalReport.ReleaseSandboxAppDomain()
                    ReportViewerEscondido.LocalReport.Dispose()
                End Try



                Dim sError As String





                MandaEmail(ConfigurationManager.AppSettings("CasillasEnvioCartasPendientes"), _
                                    "Copias de cartas porte pendientes de asignar", _
                                   "", _
                                      "buenosaires@williamsentregas.com.ar", _
                                 ConfigurationManager.AppSettings("SmtpServer"), _
                                                                    ConfigurationManager.AppSettings("SmtpUser"), _
                                                                    ConfigurationManager.AppSettings("SmtpPass"), _
                                 sExcelFileName, _
                           ConfigurationManager.AppSettings("SmtpPort"), _
                                  , _
                        , _
                        , _
                                      "Williams Entregas")


                MarcarFechaEnvioPendientes(SC)

            End If
        End Function




        Shared Function generarNotasDeEntregaConReportViewer(ByVal SC As String, ByVal fechadesde As Date, _
                                                             ByVal fechahasta As Date, ByVal dr As DataRow, _
                                                             ByVal estado As CartaDePorteManager.enumCDPestado, _
                                                             ByRef lineasGeneradas As Long, ByRef titulo As String, _
                                                             ByVal logo As String, ByVal puntoventa As Integer, _
                                                             Optional ByRef tiemposql As Integer = 0, _
                                                             Optional ByRef tiempoinforme As Integer = 0, _
                                                             Optional ByVal bDescargaHtml As Boolean = False, _
                                                             Optional grid As GridView = Nothing) As String

            'Dim ReportViewerEscondido As Microsoft.Reporting.WinForms.ReportViewer  'con WinForms
            Dim ReportViewerEscondido As Microsoft.Reporting.WebForms.ReportViewer   'con WebForms

            Dim dt As DataTable
            Dim sExcelFileName As String

            Dim stopWatch As New Stopwatch()

            Dim rdl As String

            Dim strRet As String




            'Using ReportViewerEscondido As New Microsoft.Reporting.WebForms.ReportViewer
            Try




                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////


                ' la llamada a wCartasDePorte_TX_Todas con DescargasDeHoyMasTodasLasPosiciones es
                ' ineficiente, porque no filtra por fecha. Esta ineficiencia se la banca el mail manual, pero
                ' el automático explota. -Ok, pero con las Posiciones tambien deberias
                ' tener problemas..., puesto que tampoco filtra por fecha. Necesito DE UNA BUENA VEZ, un 
                ' datasource de las cartas de porte pero YA FILTRADAS EN SQL


                With dr
                    Dim idVendedor As Long = iisNull(.Item("Vendedor"), -1)
                    Dim idCorredor As Long = iisNull(.Item("Corredor"), -1)
                    Dim idDestinatario As Long = iisNull(.Item("Entregador"), -1)
                    Dim idIntermediario As Long = iisNull(.Item("CuentaOrden1"), -1)
                    Dim idRemComercial As Long = iisNull(.Item("CuentaOrden2"), -1)
                    Dim IdClienteAuxiliar As Long = iisNull(.Item("IdClienteAuxiliar"), -1)
                    Dim idArticulo As Long = iisNull(.Item("IdArticulo"), -1)
                    Dim idProcedencia As Long = iisNull(.Item("Procedencia"), -1)
                    Dim idDestino As Long = iisNull(.Item("Destino"), -1)

                    Dim contrato As String = iisNull(.Item("Contrato"), -1)

                    Dim EnumSyngentaDivision As String = iisNull(.Item("EnumSyngentaDivision"), "")

                    Dim AgrupadorDeTandaPeriodos As String = iisNull(.Item("AgrupadorDeTandaPeriodos"), -1)


                    bDescargaHtml = (iisNull(.Item("ModoImpresion"), "Excel") = "Html" Or iisNull(.Item("ModoImpresion"), "Excel") = "HtmlIm")

                    'antes se filtraba con generarWHEREparaDataset






                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    'tengo que diferenciar si se le envía a un corredor, para mandarle los links o no. Pero no tengo otra manera
                    'de diferenciarlo que viendo los filtros...
                    'Dim IdClienteEquivalenteAlCorredor = BuscaIdVendedorPreciso(EntidadManager.NombreVendedor(SC, drCDP("Corredor")), SC)
                    'If IdClienteEquivalenteAlCorredor < 1 Then Return 0

                    'OJO OJO OJO!!: si haces las pruebas en Test usando la base de produccion, el MailLoopWork va a mandar los informes de produccion
                    'OJO OJO OJO!!: si haces las pruebas en Test usando la base de produccion, el MailLoopWork va a mandar los informes de produccion
                    'OJO OJO OJO!!: si haces las pruebas en Test usando la base de produccion, el MailLoopWork va a mandar los informes de produccion
                    'OJO OJO OJO!!: si haces las pruebas en Test usando la base de produccion, el MailLoopWork va a mandar los informes de produccion



                    'rdl = QueInforme(SC, dr) 
                    'todavia no lo puedo usar así, porque acá decido tambien si uso el RRSS o el reportviewer

                    '                    Andrés buen día

                    'En el Excel de descargas de GROBOCOPATEL HNOS , necesitamos que se reflejen los números de cuit de Titular / intermediario y Rte. Comercial.

                    'SOLO EN EL EXCEL DE DESCARGAS

                    'NO PARA EL SINCRO

                    'aguardo tu comentario


                    '                    agregar uno para grobo
                    Dim ret As String
                    ret = CartaDePorteManager.QueInforme_PorModoLocal(SC, rdl, idVendedor, idRemComercial, idIntermediario, idCorredor, idDestinatario, IdClienteAuxiliar, fechadesde, fechahasta, dr, estado, lineasGeneradas, titulo, logo, puntoventa, tiemposql, tiempoinforme, bDescargaHtml, grid)
                    If ret <> "" Then
                        Return ret
                    End If


                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////













                    ' Get the elapsed time as a TimeSpan value.
                    'Dim ts As TimeSpan = stopWatch.Elapsed

                    stopWatch.Start()


                    'usar agrupador de fechas para marcar los filtros que usen el mismo periodo

                    'cómo puede ser que este dt traiga informacion repetida
                    'https://mail.google.com/mail/u/0/#inbox/13f5c9dc24580285




                    'ya te digo si saben. deberiamos poner alguna marca en los mails aunque no se vea 
                    '(quizas en blanco en una celda perdida) para control nuestro


                    dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, _
                                   "", "", "", 1, 10000, _
                                   estado, "", idVendedor, idCorredor, _
                                   idDestinatario, idIntermediario, _
                                   idRemComercial, idArticulo, idProcedencia, idDestino, _
                                   iisNull(dr.Item("AplicarANDuORalFiltro"), 0), iisNull(dr.Item("modo")), _
                                   iisValidSqlDate(fechadesde, #1/1/1753#), _
                                  iisValidSqlDate(fechahasta, #1/1/2100#), _
                                   puntoventa, titulo, EnumSyngentaDivision, , contrato, , IdClienteAuxiliar, AgrupadorDeTandaPeriodos)


                    stopWatch.Stop()
                    tiemposql = stopWatch.Elapsed.Milliseconds




                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                End With

                'If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
                '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_DescargasDeHoyMasTodasLasPosiciones", Today)
                'ElseIf estado = CartaDePorteManager.enumCDPestado.Posicion Then
                '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Posiciones", iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
                'Else
                '    dt = EntidadManager.GetStoreProcedure(SC, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(fechadesde, #1/1/1753#), iisValidSqlDate(fechahasta, #1/1/2100#))
                'End If


                ' dejar de usar el strWHERE que recibo, y usar un datasource fijo

                'dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, _
                '                CartaDePorteManager.enumCDPestado.Todas, "", idVendedor, idCorredor, _
                '                idDestinatario, idIntermediario, _
                '                idRComercial, idArticulo, idProcedencia, idDestino, _
                '                "1", DropDownList2.Text, _
                '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                '                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                '                cmbPuntoVenta.SelectedValue)



                'Dim sWHERE As String = CDPMailFiltrosManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
                '                sTitulo, _
                '                CartaDePorteManager.enumCDPestado.Todas, "", idVendedor, idCorredor, _
                '                idDestinatario, idIntermediario, _
                '                idRComercial, idArticulo, idProcedencia, idDestino, _
                '                "1", DropDownList2.Text, _
                '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                '                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                '                cmbPuntoVenta.SelectedValue)






                'strWHERE += CartaDePorteManager.EstadoWHERE(estado, "CDP.")
                'strWHERE = strWHERE.Replace("CDP.", "")
                'dt = DataTableWHERE(dt, strWHERE)


                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////////////////////////


                Try

                    sExcelFileName = Path.GetTempPath & "Listado general " & Now.ToString("ddMMMyyyy_HHmmss") & CartaDePorteManager.GenerarSufijoRand() & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net


                    lineasGeneradas = dt.Rows.Count

                    If System.Diagnostics.Debugger.IsAttached() And dt.Rows.Count > 50000 Then
                        'Err.Raise(32434, "generarNotasDeEntrega", "Modo IDE. Mail muy grande. No se enviará")
                        Return -2 'si estoy en modo IDE, no mandar mail grande
                    End If




                    Dim logtexto As String = Date.Now.ToString() + " cant cdps " + dt.Rows.Count.ToString + " " + _
                                               "idfiltro: " + dr.Item(0).ToString + " " + _
                                                titulo + " " + Space(300)


                    If False Then


                        EntidadManager.Tarea(SC, "Log_InsertarRegistro", "ALTAINF", _
                                          dr.Item(0), 0, Now, 0, Mid(logtexto, 1, 100), _
                                       Mid(logtexto, 101, 50), Mid(logtexto, 151, 50), Mid(logtexto, 201, 50), _
                                       Mid(logtexto, 251, 50), Mid(logtexto, 301, 50), DBNull.Value, DBNull.Value, _
                                        DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                                        99990, DBNull.Value, DBNull.Value)

                    End If



                    ' LogPronto(SC, dr.Item(0), Mid(logtexto), , , , "logMails")

                Catch ex As Exception
                    ErrHandler2WriteErrorLogPronto("no se pudo hacer log del informe", SC, "")
                End Try


                Dim bServidor = False


                If bServidor Then

                    If bServidor Then
                        ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer
                        strRet = ProntoFuncionesUIWeb.RebindReportViewer_Servidor(ReportViewerEscondido, _
                                    rdl, _
                                    dt, Nothing, True, sExcelFileName, titulo, bDescargaHtml)




                    End If


                ElseIf dt.Rows.Count > 0 Then


                    stopWatch.Start()





                    If bDescargaHtml Then

                        If True Then
                            'metodo 1
                            Try
                                ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer
                                strRet = ProntoFuncionesUIWeb.RebindReportViewer(ReportViewerEscondido, _
                                                    rdl, _
                                                    dt, Nothing, True, sExcelFileName, titulo, bDescargaHtml)

                            Catch ex As Exception
                                ErrHandler2.WriteError(ex)
                            Finally
                                'http://stackoverflow.com/questions/7208482/weird-behaviour-when-i-open-a-reportviewer-in-wpf
                                ReportViewerEscondido.LocalReport.ReleaseSandboxAppDomain()
                                ReportViewerEscondido.LocalReport.Dispose()
                            End Try


                            strRet = CartaDePorteManager.ExcelToHtml(strRet, grid)
                        Else
                            'metodo2 directo desde datatable sin usar el reportviewer
                            strRet = DatatableToHtml(dt)


                        End If

                    Else

                        Try
                            ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer
                            strRet = ProntoFuncionesUIWeb.RebindReportViewer(ReportViewerEscondido, _
                                                rdl, _
                                                dt, Nothing, True, sExcelFileName, titulo, bDescargaHtml)

                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        Finally
                            'http://stackoverflow.com/questions/7208482/weird-behaviour-when-i-open-a-reportviewer-in-wpf
                            ReportViewerEscondido.LocalReport.ReleaseSandboxAppDomain()
                            ReportViewerEscondido.LocalReport.Dispose()
                        End Try



                    End If



                    stopWatch.Stop()
                    tiempoinforme = stopWatch.Elapsed.Milliseconds
                    '  Return sExcelFileName
                End If



            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try


            'Return -1
            'End Using


            Try
                If dt.Rows.Count > 0 Then

                    dt.Dispose()



                    If bDescargaHtml Then

                        '    strRet = ExcelToHtml(sExcelFileName)
                        Return strRet
                    End If

                    Return sExcelFileName
                Else
                    dt.Dispose()
                    Return -1
                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try

            Return -1

        End Function













        'Function EnviarMailFiltroPorIdanterior(ByVal id As Long, ByVal titulo As String, ByVal estado As CartaDePorteManager.enumCDPestado, ByRef sError As String, Optional ByVal bVistaPrevia As Boolean = False) As String

        '    'Dim Id = GridView1.DataKeys(fila.RowIndex).Values(0).ToString()
        '    Dim dt = TraerMetadata(HFSC.Value, id)
        '    Dim dr = dt.Rows(0)



        '    Dim output As String
        '    'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, HFSC.Value), Nothing)
        '    With dr
        '        Dim l As Long



        '        'If Not chkConLocalReport.Checked Then
        '        '    Dim sWHERE = generarWHEREparaSQL(HFSC.Value, dr, titulo, estado, _
        '        '                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
        '        '                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
        '        '    output = generarNotasDeEntrega(HFSC.Value, dr, estado, l, titulo, sWHERE, Server.MapPath("~/Imagenes/Williams.bmp"))
        '        'Else

        '        Dim sWHERE = generarWHEREparaDataset(HFSC.Value, dr, titulo, estado, _
        '                                    iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
        '                                    iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
        '        output = generarNotasDeEntregaConReportViewer(HFSC.Value, dr, estado, l, titulo, sWHERE, Server.MapPath("~/Imagenes/Williams.bmp"))

        '        'End If





        '        If output <> "-1" And output <> "-2" Then
        '            'MandaEmail("mscalella911@gmail.com", "Mailing Williams", "", , , , , "C:\ProntoWeb\doc\williams\Excels de salida\NE Descargas para el corredor Intagro.xls")

        '            'Dim mails() As String = Split(.Item("EMails"), ",")
        '            'For Each s As String In mails
        '            'ErrHandler2.WriteError("asdasde")
        '            Try
        '                Dim destinatario As String
        '                Dim truquito As String '= "    <img src =""http://" & HttpContext.Current.Request.ServerVariables("HTTP_HOST") & "/Pronto/mailPage.aspx?q=" & iisNull(UsuarioSesion.Mail(HFSC.Value, Session)) & "&e=" & .Item("EMails") & "_" & tit & """/>" 'imagen para que llegue respuesta cuando sea leido
        '                Dim cuerpo As String

        '                If bVistaPrevia Then ' chkVistaPrevia.Checked Then
        '                    'lo manda a la casilla del usuario
        '                    'ver cómo crear una regla en Outlook para forwardearlo a la casilla correspondiente
        '                    'http://www.eggheadcafe.com/software/aspnet/34183421/question-on-rules-on-unattended-mailbox.aspx
        '                    destinatario = txtRedirigirA.Text ' UsuarioSesion.Mail(HFSC.Value, Session)
        '                    cuerpo = .Item("EMails") & truquito
        '                Else
        '                    'lo manda a la casilla del destino
        '                    destinatario = .Item("EMails")

        '                    Dim s As String
        '                    Select Case cmbPuntoVenta.SelectedValue
        '                        Case 1
        '                            s = "buenosaires@williamsentregas.com.ar"
        '                        Case 2
        '                            s = "sanlorenzo@williamsentregas.com.ar"
        '                        Case 3
        '                            s = "arroyoseco@williamsentregas.com.ar"
        '                        Case 4
        '                            s = "bahiablanca@williamsentregas.com.ar"
        '                        Case Else
        '                            s = "buenosaires@williamsentregas.com.ar"
        '                    End Select
        '                    destinatario &= "," & s




        '                    cuerpo = truquito
        '                End If


        '                MandaEmail(destinatario, _
        '                                    titulo, _
        '                                  cuerpo, _
        '                                ConfigurationManager.AppSettings("SmtpUser"), _
        '                                ConfigurationManager.AppSettings("SmtpServer"), _
        '                                ConfigurationManager.AppSettings("SmtpUser"), _
        '                                ConfigurationManager.AppSettings("SmtpPass"), _
        '                                output, _
        '                                ConfigurationManager.AppSettings("SmtpPort"), _
        '                                , _
        '                                  iisNull(UsuarioSesion.Mail(HFSC.Value, Session)), _
        '                                    truquito _
        '                                    , "Williams Entregas" _
        '                               )



        '                'If Not VerificaDominio(destinatario) Then
        '                '    MandaEmail(iisNull(UsuarioSesion.Mail(HFSC.Value, Session)), _
        '                '                    "Mail rechazado", _
        '                '                  "El mail para " & destinatario & " ha sido rechazado", _
        '                '                ConfigurationManager.AppSettings("SmtpUser"), _
        '                '                ConfigurationManager.AppSettings("SmtpServer"), _
        '                '                ConfigurationManager.AppSettings("SmtpUser"), _
        '                '                ConfigurationManager.AppSettings("SmtpPass"), _
        '                '                output, _
        '                '                ConfigurationManager.AppSettings("SmtpPort"))
        '                'End If


        '                dr.Item("UltimoResultado") = "Enviado con éxito a las " & Now.ToString("hh:mm") & ". CDPs filtradas: " & l
        '                Update(HFSC.Value, dt)

        '            Catch ex As Exception
        '                'Verificar Mails rechazados en la cuenta que los envió
        '                '        http://www.experts-exchange.com/Programming/Languages/C_Sharp/Q_23268068.html
        '                'TheLearnedOne:
        '                'The only way that I know of is to look in the Inbox for rejected messages.

        '                '        Bob



        '                ErrHandler2.WriteError(ex.ToString)
        '                dr.Item("UltimoResultado") = Left(Now.ToString("hh:mm") & " Fallo al enviar. " & ex.ToString, 100)
        '                Update(HFSC.Value, dt)
        '                'MsgBoxAjax(Me, "Fallo al enviar. " & ex.ToString)
        '            End Try

        '            'Next
        '        ElseIf output = "-1" Then
        '            sError += "El filtro " & id & " genera un informe vacío." & vbCrLf

        '            dr.Item("UltimoResultado") = "Generó un informe vacío a las " & Now.ToString("hh:mm")
        '            Update(HFSC.Value, dt)
        '        ElseIf output = "-2" Then
        '            sError += "Modo IDE. Mail muy grande. No se enviará." & vbCrLf

        '            dr.Item("UltimoResultado") = Now.ToString("hh:mm") & " Modo IDE. Mail muy grande. No se enviará"
        '            Update(HFSC.Value, dt)
        '        End If




        '    End With

        '    Return output

        'End Function


        'http://www.codeproject.com/KB/validation/Valid_Email_Addresses.aspx
        Function VerificaDominio(ByVal address As String) As Boolean
            'no funciona con gmail, yahoo, porque hay que autenticar....
            Try

                Dim host As String() = address.Split("@")
                Dim hostname As String = host(1)

                Dim IPhst As Net.IPHostEntry = Net.Dns.GetHostEntry(hostname)
                Dim endPt As Net.IPEndPoint = New Net.IPEndPoint(IPhst.AddressList(0), 25)
                Dim s As Socket = New Socket(endPt.AddressFamily, SocketType.Stream, ProtocolType.Tcp)
                s.Connect(endPt)
            Catch ex As Exception
                Return False
            End Try
            Return True
        End Function








        Shared Function VerificoMailsRebotados(ByVal SC As String, ByRef Session As SessionState.HttpSessionState) As String

            '        ConfigurationManager.AppSettings("SmtpUser"), _
            'ConfigurationManager.AppSettings("SmtpServer"), _
            'ConfigurationManager.AppSettings("SmtpUser"), _
            'ConfigurationManager.AppSettings("SmtpPass"), _
            'output, _
            'ConfigurationManager.AppSettings("SmtpPort")

            'http://www.eggheadcafe.com/tutorials/aspnet/4b2941c6-fb99-4745-8437-3a2e28b778c4/aspnet-read-pop3-email.aspx

            'Dim mail As String = LeerMail()
            'While mail <> ""
            '    Try
            '        mail = LeerMail()
            '        Debug.Print(mail)
            '    Catch ex As Exception

            '    End Try

            'End While


            'LeerMail(1525)
            'Exit Function


            Const CANTMAILS As Integer = 10
            Dim sStat As String = LeerSTAT()
            Dim posCant As Integer = InStr(sStat, "messages")
            Dim CantidadMensajes As Integer

            Try
                If posCant > 6 Then
                    CantidadMensajes = Int(Mid(sStat, posCant - 6, 5))
                Else
                    CantidadMensajes = CANTMAILS + 1
                End If
            Catch ex As Exception
                CantidadMensajes = CANTMAILS + 1
            End Try


            'Debug.Print(mail)

            Dim usuarioMail As String
            Dim mails(2, 100) As String
            Dim indice As Integer = 0
            Dim princ As Integer = IIf(CantidadMensajes - CANTMAILS <= 0, 1, CantidadMensajes - CANTMAILS)
            For i = princ To CantidadMensajes
                Debug.Print("MENSAJE n° " & i)
                Dim mail = LeerMail_POP(i)
                'Debug.Print(mail)

                If mail = "-1" Then Continue For 'exit for

                If InStr(mail, "Delivery") > 0 Then
                    Debug.Print("Mensaje de rechazo! : " & mail)
                    Dim extracto As String

                    Dim flag As Boolean = True

                    Try

                        If InStr(mail, "Failed-Recipients:") > 0 Then
                            extracto = Mid(mail, InStr(mail, "Failed-Recipients:"), 70)
                            extracto = Trim(TextoEntre(extracto, "Failed-Recipients: ", vbCrLf))
                        ElseIf InStr(mail, "failed permanently") > 0 Then
                            extracto = Mid(mail, InStr(mail, "failed permanently"), 70)
                            extracto = Trim(TextoEntre(extracto, "failed permanently:    ", vbCrLf))
                        ElseIf InStr(mail, "The following addresses had permanent fatal errors") > 0 Then
                            extracto = Mid(mail, InStr(mail, "The following addresses had permanent fatal errors"), 100)
                            extracto = Trim(TextoEntre(extracto, "<", ">"))
                        Else
                            flag = False
                        End If

                        usuarioMail = Mid(mail, InStr(mail, "Disposition-Notification-To: "), 70)
                        usuarioMail = Trim(TextoEntre(usuarioMail, "Disposition-Notification-To: ", vbCrLf))
                        Debug.Print(usuarioMail)
                    Catch ex As Exception

                    End Try

                    If flag Then
                        Debug.Print(extracto)
                        mails(0, indice) = extracto
                        Dim mailTemp = mail

                        mailTemp = Replace(mailTemp, "+OK", "")

                        'Dim a, b As Integer
                        'Do
                        '    Try
                        '        a = InStr(mailTemp, "+OK")
                        '        b = InStr(a, mailTemp, vbCrLf)
                        '        mailTemp = Left(mailTemp, a - 1) & Mid(mailTemp, b)
                        '    Catch ex As Exception

                        '    End Try
                        'Loop While a <> 0 'saco todas las lineas del mail que sean de comandos


                        mails(1, indice) = mailTemp
                        indice += 1
                    End If


                    DeleteMail(i)

                End If

                If InStr(mail, "-ERR Message number out of range") > 0 Then
                    Debug.Print("Leidos " & i - 1 & " mensajes")
                    Exit For
                ElseIf InStr(mail, "-ERR No such message") > 0 Then
                    Debug.Print("Leidos " & i - 1 & " mensajes")
                    Exit For
                ElseIf InStr(mail, "Authentication failed") > 0 Then
                    Debug.Print("Authentication failed")
                    Return "Authentication failed"
                    Exit For
                End If
            Next

            If indice > 0 Then
                Dim cuentas As String = ""
                For ind = 0 To indice - 1
                    Dim cuerpo As String = "No se pudo mandar el correo a " & mails(0, ind) & vbCrLf & vbCrLf & vbCrLf & vbCrLf & mails(1, ind)

                    MandaEmail(iisNull(usuarioMail, UsuarioSesion.Mail(SC, Session)), "Correo rechazado", cuerpo, _
                                                   ConfigurationManager.AppSettings("SmtpUser"), _
                        ConfigurationManager.AppSettings("SmtpServer"), _
                        ConfigurationManager.AppSettings("SmtpUser"), _
                        ConfigurationManager.AppSettings("SmtpPass"), _
                        , _
                        ConfigurationManager.AppSettings("SmtpPort"), , , cuerpo.Replace(vbCrLf, "<br>"))

                    cuentas &= mails(0, ind) & " "
                Next

                'Return "Hubo problemas con las siguientes cuentas: " & Join( mails(0) , " ")
                Return "Hubo problemas con las siguientes cuentas: " & cuentas
            Else
                Return ""
            End If

        End Function






        Shared Function LeerMail_IMAP(ByVal numeroMensaje As Long, Optional ByVal EnableSSL As Boolean = False) As String
        End Function

        'http://stackoverflow.com/questions/4697831/help-convert-pop3-connection-to-imap

        Shared Function LeerMail_POP(ByVal numeroMensaje As Long, Optional ByVal EnableSSL As Boolean = False) As String
            Try
                Dim server As String = ConfigurationManager.AppSettings("PopServer")
                Dim port As Integer = ConfigurationManager.AppSettings("PopPort")

                Dim sw As System.IO.StreamWriter
                Dim reader As System.IO.StreamReader

                Dim tcpclient = New TcpClient
                tcpclient.ReceiveTimeout = 10000



                tcpclient.Connect(server, port) ' HOST NAME POP SERVER and gmail uses port number 995 for POP 




                ''Si se solicitó SSL, lo activo
                If port <> 995 Then 'EnableSSL = 0 Or

                    sw = New StreamWriter(tcpclient.GetStream())
                    reader = New StreamReader(tcpclient.GetStream())


                Else

                    Dim sslStream As System.Net.Security.SslStream = New SslStream(tcpclient.GetStream(), False, New RemoteCertificateValidationCallback(AddressOf ValidarCertificado), Nothing) ' // This is Secure Stream // opened the connection between client and POP Server


                    Try
                        sslStream.AuthenticateAsClient(server)
                    Catch ex As Exception
                        ErrHandler2.WriteError("Authentication failed - closing the connection.  " & ex.ToString)
                        'Console.WriteLine("Exception: {0}", e.Message)
                        'If Not IsNull(ex.InnerException) Then
                        '    Console.WriteLine("Inner exception: {0}", ex.InnerException.Message)
                        'End If

                        'Console.WriteLine("Authentication failed - closing the connection.")
                        'client.Close()
                        Return "Authentication failed - closing the connection. " & ex.ToString
                    End Try

                    sw = New StreamWriter(sslStream) ' // Asssigned the writer to stream
                    reader = New StreamReader(sslStream) ' // Assigned reader to stream
                End If






                'sw.Write("STLS")
                'sw.Flush()

                sw.WriteLine("USER " & ConfigurationManager.AppSettings("SmtpUser")) ' // refer POP rfc command, there very few around 6-9 command
                sw.Flush() ' // sent to server

                sw.WriteLine("PASS  " & ConfigurationManager.AppSettings("SmtpPass"))
                sw.Flush()

                'sw.WriteLine("RETR " & numeroMensaje) ' // this will retrive your first email 
                'sw.Flush()

                sw.WriteLine("TOP " & numeroMensaje & " 8") 'primeras 10 lineas del mensaje
                sw.Flush()

                'sw.WriteLine("LIST") 
                'sw.Flush()

                sw.WriteLine("Quit ") ' // close the connection
                sw.Flush()

                Dim str As String = String.Empty
                Dim strTemp As String = String.Empty

                Dim linea As Long = 0
                strTemp = reader.ReadLine() & vbCrLf
                str += strTemp
                While (Not IsNull(strTemp) And linea < 100)
                    linea += 1
                    If strTemp = "." Then Exit While

                    If strTemp.IndexOf("-ERR") <> -1 Then
                        'error en el numero del mensaje, probablemente
                        Exit While
                    End If

                    strTemp = reader.ReadLine() & vbCrLf
                    str += strTemp
                End While

                Debug.Print(str)
                Return str
                'Response.Write(str)
                'Response.Write("<BR>" + "Congratulation.. ....!!! You read your first gmail email ")


            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Return -1
                'throw
                'Response.Write(ex.ToString)

            End Try

        End Function


        Shared Function DeleteMail(ByVal numeroMensaje As Long, Optional ByVal EnableSSL As Boolean = False) As String
            Try
                Dim server As String = ConfigurationManager.AppSettings("PopServer")
                Dim port As Integer = ConfigurationManager.AppSettings("PopPort")

                Dim sw As System.IO.StreamWriter
                Dim reader As System.IO.StreamReader

                Dim tcpclient = New TcpClient
                tcpclient.ReceiveTimeout = 10000



                tcpclient.Connect(server, port) ' HOST NAME POP SERVER and gmail uses port number 995 for POP 




                ''Si se solicitó SSL, lo activo
                If port <> 995 Then 'EnableSSL = 0 Or

                    sw = New StreamWriter(tcpclient.GetStream())
                    reader = New StreamReader(tcpclient.GetStream())


                Else

                    Dim sslStream As System.Net.Security.SslStream = New SslStream(tcpclient.GetStream(), False, New RemoteCertificateValidationCallback(AddressOf ValidarCertificado), Nothing) ' // This is Secure Stream // opened the connection between client and POP Server


                    Try
                        sslStream.AuthenticateAsClient(server)
                    Catch ex As Exception
                        ErrHandler2.WriteError("Authentication failed - closing the connection.  " & ex.ToString)
                        'Console.WriteLine("Exception: {0}", e.Message)
                        'If Not IsNull(ex.InnerException) Then
                        '    Console.WriteLine("Inner exception: {0}", ex.InnerException.Message)
                        'End If

                        'Console.WriteLine("Authentication failed - closing the connection.")
                        'client.Close()
                        Return "Authentication failed - closing the connection. " & ex.ToString
                    End Try

                    sw = New StreamWriter(sslStream) ' // Asssigned the writer to stream
                    reader = New StreamReader(sslStream) ' // Assigned reader to stream
                End If






                'sw.Write("STLS")
                'sw.Flush()

                sw.WriteLine("USER " & ConfigurationManager.AppSettings("SmtpUser")) ' // refer POP rfc command, there very few around 6-9 command
                sw.Flush() ' // sent to server

                sw.WriteLine("PASS  " & ConfigurationManager.AppSettings("SmtpPass"))
                sw.Flush()

                'sw.WriteLine("RETR " & numeroMensaje) ' // this will retrive your first email 
                'sw.Flush()

                sw.WriteLine("DELE " & numeroMensaje)
                sw.Flush()

                'sw.WriteLine("LIST") 
                'sw.Flush()

                sw.WriteLine("Quit ") ' // close the connection
                sw.Flush()

                Dim str As String = String.Empty
                Dim strTemp As String = String.Empty

                Dim linea As Long = 0
                strTemp = reader.ReadLine() & vbCrLf
                str += strTemp
                While (Not IsNull(strTemp) And linea < 100)
                    linea += 1
                    If strTemp = "." Then Exit While

                    If strTemp.IndexOf("-ERR") <> -1 Then
                        'error en el numero del mensaje, probablemente
                        Exit While
                    End If

                    strTemp = reader.ReadLine() & vbCrLf
                    str += strTemp
                End While

                Debug.Print(str)
                Return str
                'Response.Write(str)
                'Response.Write("<BR>" + "Congratulation.. ....!!! You read your first gmail email ")


            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Return -1
                'throw
                'Response.Write(ex.ToString)

            End Try

        End Function


        Shared Function LeerSTAT(Optional ByVal EnableSSL As Boolean = False) As String
            Try
                Dim server As String = ConfigurationManager.AppSettings("PopServer")
                Dim port As Integer = ConfigurationManager.AppSettings("PopPort")

                Dim sw As System.IO.StreamWriter
                Dim reader As System.IO.StreamReader

                Dim tcpclient = New TcpClient
                tcpclient.ReceiveTimeout = 10000



                tcpclient.Connect(server, port) ' HOST NAME POP SERVER and gmail uses port number 995 for POP 




                ''Si se solicitó SSL, lo activo
                If port <> 995 Then 'EnableSSL = 0 Or

                    sw = New StreamWriter(tcpclient.GetStream())
                    reader = New StreamReader(tcpclient.GetStream())


                Else

                    Dim sslStream As System.Net.Security.SslStream = New SslStream(tcpclient.GetStream(), False, New RemoteCertificateValidationCallback(AddressOf ValidarCertificado), Nothing) ' // This is Secure Stream // opened the connection between client and POP Server


                    Try
                        sslStream.AuthenticateAsClient(server)
                    Catch ex As Exception
                        ErrHandler2.WriteError("Authentication failed - closing the connection.  " & ex.ToString)
                        'Console.WriteLine("Exception: {0}", e.Message)
                        'If Not IsNull(ex.InnerException) Then
                        '    Console.WriteLine("Inner exception: {0}", ex.InnerException.Message)
                        'End If

                        'Console.WriteLine("Authentication failed - closing the connection.")
                        'client.Close()
                        Return "Authentication failed - closing the connection. " & ex.ToString
                    End Try

                    sw = New StreamWriter(sslStream) ' // Asssigned the writer to stream
                    reader = New StreamReader(sslStream) ' // Assigned reader to stream

                End If






                'sw.Write("STLS")
                'sw.Flush()

                sw.WriteLine("USER " & ConfigurationManager.AppSettings("SmtpUser")) ' // refer POP rfc command, there very few around 6-9 command
                sw.Flush() ' // sent to server

                sw.WriteLine("PASS  " & ConfigurationManager.AppSettings("SmtpPass"))
                sw.Flush()

                sw.WriteLine("STAT") ' // this will retrive your first email 
                sw.Flush()

                'sw.WriteLine("LIST")
                'sw.Flush()

                sw.WriteLine("Quit ") ' // close the connection
                sw.Flush()

                Dim str As String = String.Empty
                Dim strTemp As String = String.Empty

                Dim linea As Long = 0
                strTemp = reader.ReadLine() & vbCrLf
                str += strTemp
                While (Not IsNull(strTemp) And linea < 100)
                    linea += 1
                    If strTemp = "." Then Exit While

                    If strTemp.IndexOf("-ERR") <> -1 Then
                        'error en el numero del mensaje, probablemente
                        Exit While
                    End If

                    strTemp = reader.ReadLine() & vbCrLf
                    str += strTemp
                End While

                Debug.Print(str)
                Return str
                'Response.Write(str)
                'Response.Write("<BR>" + "Congratulation.. ....!!! You read your first gmail email ")


            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Return -1
                'throw
                'Response.Write(ex.ToString)

            End Try

        End Function



        '    delegate string ReadLineDelegate ();
        '...
        'using (NetworkStream networkStream = tcpClient.GetStream()) {
        '    StreamReader reader = new StreamReader(networkStream);
        '    ReadLineDelegate rl = new ReadLineDelegate (reader.ReadLine);
        '    while (true) {
        '        IAsyncResult ares = rl.BeginInvoke (null, null);
        '        if (ares.AsyncWaitHandle.WaitOne (100) == false)
        '            break; // stop after waiting 100ms
        '        string str = rl.EndInvoke (ares);
        '        if (str != null) {
        '            Console.WriteLine ("Received: {0}", str);
        '            send (str);
        '        } 
        '    }
        '}


        Private Shared Function ValidarCertificado(ByVal sender As Object, ByVal certificate As System.Security.Cryptography.X509Certificates.X509Certificate, ByVal chain As System.Security.Cryptography.X509Certificates.X509Chain, ByVal sslPolicyErrors As System.Net.Security.SslPolicyErrors) As Boolean
            'bypass de la validación del certificado (aplicar aquí validación personalizada si fuera el caso)
            Return True
        End Function



        Function Recibir(ByVal messageNumber As String) As String
            'http://www.blog-de.net/funcion-con-socket-tcpclient-para-recibir-correo-en-net/
            Dim hostName As String = "pop.gmail.com" 'Pon el hostname de tu servidor de correo entrante
            Dim hostPort As String = 995 '110 'Pon el hostname de tu servidor de correo entrante
            'Dim userName As String = "GRUPO\Usuario" 'Pon tu Grupo\Usuario
            'Dim userPassword As String = "Password" ' Pon tu Password

            Dim tcpClient As Net.Sockets.TcpClient = New Net.Sockets.TcpClient
            'Dim messageNumber As String = "1″"
            Dim returnMessage As String
            Dim sTemp As String

            Try
                tcpClient.Connect(hostName, hostPort)
                Dim networkStream As Net.Sockets.NetworkStream = tcpClient.GetStream()
                Dim bytes(tcpClient.ReceiveBufferSize) As Byte
                Dim sendBytes As Byte()

                networkStream.Read(bytes, 0, CInt(tcpClient.ReceiveBufferSize))

                sendBytes = System.Text.Encoding.ASCII.GetBytes("User " + ConfigurationManager.AppSettings("SmtpUser") + vbCrLf)
                networkStream.Write(sendBytes, 0, sendBytes.Length)

                sTemp = networkStream.Read(bytes, 0, CInt(tcpClient.ReceiveBufferSize))

                sendBytes = System.Text.Encoding.ASCII.GetBytes("Pass " + ConfigurationManager.AppSettings("SmtpPass") + vbCrLf)
                networkStream.Write(sendBytes, 0, sendBytes.Length)

                sTemp = networkStream.Read(bytes, 0, CInt(tcpClient.ReceiveBufferSize))

                sendBytes = System.Text.Encoding.ASCII.GetBytes("STAT" + vbCrLf)
                networkStream.Write(sendBytes, 0, sendBytes.Length)

                sTemp = networkStream.Read(bytes, 0, CInt(tcpClient.ReceiveBufferSize))

                sendBytes = System.Text.Encoding.ASCII.GetBytes("RETR " + messageNumber + vbCrLf)
                networkStream.Write(sendBytes, 0, sendBytes.Length)

                System.Threading.Thread.Sleep(500)

                networkStream.Read(bytes, 0, CInt(tcpClient.ReceiveBufferSize))
                returnMessage = System.Text.Encoding.ASCII.GetString(bytes)

                Console.WriteLine(returnMessage.ToString)

                sendBytes = System.Text.Encoding.ASCII.GetBytes("QUIT" + vbCrLf)
                networkStream.Write(sendBytes, 0, sendBytes.Length)

                tcpClient.Close()

                Return returnMessage.ToString
            Catch ex As Exception
                Console.WriteLine("No se puede recibir correo o el buzon de entrada esta vacio")
            End Try

        End Function

        Private Shared Function Server() As Object
            Throw New NotImplementedException
        End Function













    End Class














End Namespace