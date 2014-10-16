Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.EntidadManager
Imports Microsoft.Office.Interop.Excel
Imports System.Text
Imports System.Data
Imports System.Diagnostics
Imports System.Web.UI
Imports Excel = Microsoft.Office.Interop.Excel

Imports CartasDePorteImportador.FormatosDeExcel
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports ExcelImportadorManager
Imports ExcelImportadorManager.FormatosDeExcel
Imports ClaseMigrar.SQLdinamico
Imports System.Linq

Imports Microsoft.Reporting.WebForms

Imports Pronto.ERP.Bll.CDPMailFiltrosManager

Imports iTextSharp.text
Imports iTextSharp.text.pdf


Partial Class CartasDePorteImagenEncriptada
    Inherits System.Web.UI.Page


    Private IdCartaDePorte As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing
    Private _linkImagen2 As Object

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdCartaDePorte"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdCartaDePorte") = Value
        End Set
    End Property






    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        'http://madskristensen.net/post/HttpModule-for-query-string-encryption.aspx

        Try

            If Not (Request.QueryString.Get("Id") Is Nothing) Then
                Dim strScramble = Request.QueryString.Get("Id")

                IdCartaDePorte = EntidadManager.decryptQueryString(strScramble.Replace(" ", "+"))
                Me.IdEntity = IdCartaDePorte
            Else
                ErrHandler.WriteError("Página no autorizada")
                MsgBoxAjax(Me, "Página no autorizada")
                Exit Sub
            End If

        Catch ex As Exception
            ErrHandler.WriteError(ex)
            MsgBoxAjax(Me, "Página no autorizada")
            Exit Sub

        End Try



        'mKey = "CartaDePorte_" & Me.IdEntity.ToString
        'mAltaItem = False
        'usuario = New Usuario
        'usuario = Session(SESSIONPRONTO_USUARIO)

        ''que pasa si el usuario es Nothing? Qué se rompió?
        'If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))
        Dim pa

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = EncriptarParaCSharp("Data Source=MARIANO-PC;Initial Catalog=wDemoWilliams;Uid=sa; PWD=3D1consultore5;")
            pa = "http://localhost:48391/ProntoWeb/DataBackupear/"
        Else
            SC = EncriptarParaCSharp("Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
            pa = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
        End If


        If Not IsPostBack Then

            Dim myCartaDePorte As CartaDePorte


            If System.Diagnostics.Debugger.IsAttached() And False Then
                myCartaDePorte = New CartaDePorte
                myCartaDePorte.PathImagen = "9675224abr2013_071802_30868007-CP.jpg"
                myCartaDePorte.PathImagen2 = "4088624abr2013_071803_30868007-TK.jpg"
            Else
                myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCartaDePorte, True)
                If True Then
                    reloadimagen()
                    'refrescaIdEncriptados(SC)
                End If

            End If

        End If





    End Sub


    Protected Sub btnDescargaPDF_Click(sender As Object, e As System.EventArgs) Handles btnDescargaPDF.Click

        'If True Then
        '    MsgBoxAlert(output)
        '    Return
        'End If

        'ssss btn pdf
        Dim pa

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = EncriptarParaCSharp("Data Source=MARIANO-PC;Initial Catalog=wDemoWilliams;Uid=sa; PWD=3D1consultore5;")
            pa = "http://localhost:48391/ProntoWeb/DataBackupear/"
        Else
            SC = EncriptarParaCSharp("Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
            pa = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
        End If

        Dim myCartaDePorte As CartaDePorte


        If System.Diagnostics.Debugger.IsAttached() And False Then
            myCartaDePorte = New CartaDePorte
            myCartaDePorte.PathImagen = "9675224abr2013_071802_30868007-CP.jpg"
            myCartaDePorte.PathImagen2 = "4088624abr2013_071803_30868007-TK.jpg"
        Else
            myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCartaDePorte, True)
            If True Then
                reloadimagen()
                'refrescaIdEncriptados(SC)
            End If

        End If


        Dim output As String
        If True Then
            'myCartaDePorte.PathImagen = "4225mar2013_111151_29950530 104 TK.jpg"
            'myCartaDePorte.PathImagen2 = "91408abr2013_164618_Tulips.jpg"

            pa = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
            output = Path.GetTempPath & "ImagenesCartaPorte " & Now.ToString("ddMMMyyyy_HHmmss") & GenerarSufijoRand() & ".pdf" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            PDFcon_iTextSharp(output, _
                              IIf(myCartaDePorte.PathImagen <> "", pa + myCartaDePorte.PathImagen, ""), _
                              IIf(myCartaDePorte.PathImagen2 <> "", pa + myCartaDePorte.PathImagen2, ""))
        Else
            output = generarInformeFotosConReportViewerPDF(SC, pa + myCartaDePorte.PathImagen, pa + myCartaDePorte.PathImagen2)
        End If





        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MandarMailDeError("PDF de imágenes de cartaporte. Probablemente por la memoria. Reiniciar el IIS. " & MyFile1.Name)
                MsgBoxAjax(Me, "No se pudo generar el pdf. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler.WriteAndRaiseError(ex.Message)
            ErrHandler.WriteError(ex.Message)
            'MsgBoxAjax(Me, ex.Message)
            Return
        End Try
    End Sub


    Sub refrescaIdEncriptados(SC As String)
        Using db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim q = From c In db.CartasDePortes Where (If(c.PathImagen, "") <> "" Or If(c.PathImagen2, "") <> "") And (If(c.ClaveEncriptada, "") = "") Select c.IdCartaDePorte

            For Each i In q
                Dim s = EntidadManager.encryptQueryString(i.ToString)
                ExecDinamico(SC, "update cartasdeporte set  ClaveEncriptada ='" & s & "' where idcartadeporte=" & i)
            Next
        End Using
    End Sub

    Sub reloadimagen()

        Dim sDirFTP = "https://prontoweb.williamsentregas.com.ar/ProntoWeb/"


        Try

            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = IdCartaDePorte).SingleOrDefault

                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                If False And linkImagen.NavigateUrl <> "" Then
                    'linkimagenlabel.HRef = "..\DataBackupear\" & linkImagen.NavigateUrl

                    'http://stackoverflow.com/questions/6826478/asp-net-asyncfileupload-show-list-of-uploaded-files/6826681#6826681

                    'UpdatePanel7.UpdateMode = UpdatePanelUpdateMode.Conditional
                    'imgFotoCarta.Src = "..\DataBackupear\" & linkImagen.NavigateUrl
                    'UpdatePanel7.Update()
                ElseIf oCarta.PathImagen <> "" Then
                    linkimagenlabel.HRef = sDirFTP & "..\DataBackupear\" & oCarta.PathImagen
                    linkImagen.Text = "ampliar"
                    linkImagen.NavigateUrl = sDirFTP & "..\DataBackupear\" & oCarta.PathImagen
                    linkImagen.Visible = False 'True
                    imgFotoCarta.Src = linkImagen.NavigateUrl ' oCarta.PathImagen

                    'ResizeImage(linkImagen.NavigateUrl, "", , , )

                    'http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
                    'btnDesfacturar.Visible = True
                Else
                    linkImagen.Visible = False
                    ' btnadjuntarimagen.Visible = False
                End If
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////

                If oCarta.PathImagen2 <> "" Then
                    linkimagenlabel2.HRef = sDirFTP & "..\DataBackupear\" & oCarta.PathImagen2
                    linkImagen_2.Text = "ampliar"
                    linkImagen_2.NavigateUrl = sDirFTP & "..\DataBackupear\" & oCarta.PathImagen2
                    linkImagen_2.Visible = False 'True
                    imgFotoCarta2.Src = linkImagen_2.NavigateUrl ' oCarta.PathImagen
                    'http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
                    'btnDesfacturar.Visible = True
                Else
                    linkImagen_2.Visible = False
                    ' btnadjuntarimagen.Visible = False
                End If

            End Using

        Catch ex As Exception

        End Try

    End Sub


    Function RebindReportViewer(ByVal rdlFile As String, ByVal dt As Data.DataTable, Optional ByVal dt2 As Data.DataTable = Nothing, Optional ByVal bDescargaExcel As Boolean = False, Optional ByRef ArchivoExcelDestino As String = "") As String
        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True



            End With


            .DocumentMapCollapsed = True




            If bDescargaExcel Then
                .Visible = False

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String
                Dim bytes As Byte()

                Try
                    bytes = ReportViewer2.LocalReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)

                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                        End If

                        ErrHandler.WriteError(inner.Message)
                        inner = inner.InnerException
                    End While
                End Try


                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino
            Else
                'nononono chambon, no se puede (y no tiene sentido) usar los parametros en un informe local
                '.ShowParameterPrompts = True

                .LocalReport.Refresh()
                .DataBind()

            End If

        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function


    Function generarInformeFotosConReportViewerPDF(ByVal SC As String, Optional ByVal param1 As String = "", Optional ByVal param2 As String = "") As String

        'Dim ReportViewerEscondido As Microsoft.Reporting.WinForms.ReportViewer  'con WinForms
        Dim ReportViewerEscondido As Microsoft.Reporting.WebForms.ReportViewer   'con WebForms

        Dim sExcelFileName As String

        Dim stopWatch As New Stopwatch()

        Dim rdl As String

        'explota silencioso, te deja en el aire

        'Using ReportViewerEscondido As New Microsoft.Reporting.WebForms.ReportViewer
        Try

            ' ReportViewerEscondido = New Microsoft.Reporting.WebForms.ReportViewer



            rdl = AppDomain.CurrentDomain.BaseDirectory & "ProntoWeb\Informes\ImagenesCartaPorte.rdl"


            sExcelFileName = Path.GetTempPath & "ImagenesCartaPorte " & Now.ToString("ddMMMyyyy_HHmmss") & GenerarSufijoRand() & ".pdf" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            ErrHandler.WriteError("Generando PDF en " & sExcelFileName & " p1 " & param1 & " p2 " & param2)
            RebindReportViewerPDF(ReportViewer2, _
                                rdl, _
                                True, sExcelFileName, "", param1, param2)

            ErrHandler.WriteError("Salgo de RebindReportViewerPDF.  " & sExcelFileName & " p1 " & param1 & " p2 " & param2)

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        Finally
            'http://stackoverflow.com/questions/7208482/weird-behaviour-when-i-open-a-reportviewer-in-wpf
            '  ReportViewerEscondido.LocalReport.ReleaseSandboxAppDomain()
            '  ReportViewerEscondido.LocalReport.Dispose()

            ReportViewer2.LocalReport.ReleaseSandboxAppDomain()
            ReportViewer2.LocalReport.Dispose()
        End Try


        'Return -1
        'End Using



        Return sExcelFileName



    End Function



    Public Function RebindReportViewerPDF(ByRef oReportViewer As Microsoft.Reporting.WebForms.ReportViewer, ByVal rdlFile As String, Optional ByVal bDescargaExcel As Boolean = False, Optional ByRef ArchivoExcelDestino As String = "", Optional ByVal titulo As String = "", Optional ByVal param1 As String = "", Optional ByVal param2 As String = "") As String
        'http://forums.asp.net/t/1183208.aspx


        With ReportViewer2
            .Reset()
            .ProcessingMode = ProcessingMode.Local
            .Visible = False

            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                ' .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                ' If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////

                Try
                    If .GetParameters.Item(0).Name = "ReportParameter1" Then
                        Dim p1 = New ReportParameter("ReportParameter1", param1)
                        Dim p2 = New ReportParameter("ReportParameter2", param2)
                        'Dim p3 = New ReportParameter("FechaHasta", Today)
                        '.SetParameters(New ReportParameter() {p1, p2, p3})
                        .SetParameters(New ReportParameter() {p1, p2})

                    Else
                        ErrHandler.WriteError("Error al buscar los parametros")
                    End If


                Catch ex As Exception
                    ErrHandler.WriteError(ex.Message)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True




            If bDescargaExcel Then
                Try

                    .Visible = False

                    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                    Dim warnings As Warning()
                    Dim streamids As String()
                    Dim mimeType, encoding, extension As String
                    Dim bytes As Byte()



                    Try
                        bytes = .LocalReport.Render( _
                              "PDF", Nothing, mimeType, encoding, _
                                extension, _
                               streamids, warnings)

                    Catch e As System.Exception
                        Dim inner As Exception = e.InnerException
                        While Not (inner Is Nothing)
                            If System.Diagnostics.Debugger.IsAttached() Then
                                'MsgBox(inner.Message)
                                'Stop
                            End If
                            ErrHandler.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message & "   Filtro:" & titulo)
                            inner = inner.InnerException
                        End While
                        Throw e
                    End Try


                    Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                    fs.Write(bytes, 0, bytes.Length)
                    fs.Close()
                Catch ex As Exception
                    Throw ex
                Finally                    'asegurarse de que liberas la memoria
                    .LocalReport.ReleaseSandboxAppDomain()
                    .LocalReport.Dispose()
                End Try
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







    Function PDFcon_iTextSharp(filepdf As String, filejpg As String, filejpg2 As String)

        Dim document As Document = New Document()

        Using stream = New FileStream(filepdf, FileMode.Create, FileAccess.Write, FileShare.None)

            iTextSharp.text.pdf.PdfWriter.GetInstance(document, stream)
            document.Open()


            If filejpg <> "" Then
                Using imageStream = New FileStream(filejpg, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)
                    Dim Image = iTextSharp.text.Image.GetInstance(imageStream)
                    'Image.SetAbsolutePosition(0, 0)
                    'Image.ScaleToFit(document.PageSize.Width, document.PageSize.Height)
                    Dim percentage As Decimal = 0.0F
                    percentage = 540 / Image.Width
                    Image.ScalePercent(percentage * 100)
                    document.Add(Image)
                End Using
            End If
            If filejpg2 <> "" Then
                Using imageStream = New FileStream(filejpg2, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)
                    Dim Image = iTextSharp.text.Image.GetInstance(imageStream)
                    Image.ScaleToFit(document.PageSize.Width, document.PageSize.Height)
                    Dim percentage As Decimal = 0.0F
                    percentage = 540 / Image.Width
                    Image.ScalePercent(percentage * 100)
                    document.Add(Image)
                End Using
            End If
            document.Close()
        End Using

    End Function



    'http://www.codeproject.com/Questions/362618/How-to-reduce-image-size-in-asp-net-with-same-clar
    Public Shared Sub ResizeImage(image As String, Okey As String, key As String, width As Integer, height As Integer, newimagename As String)
        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image))

        Dim oThumbNail As System.Drawing.Image = New System.Drawing.Bitmap(width, height)
        ', System.Drawing.Imaging.PixelFormat.Format24bppRgb
        Dim oGraphic As System.Drawing.Graphics = System.Drawing.Graphics.FromImage(oThumbNail)

        oGraphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality

        'set smoothing mode to high quality
        oGraphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality
        'set the interpolation mode
        oGraphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic
        'set the offset mode
        oGraphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality

        Dim oRectangle As New System.Drawing.Rectangle(0, 0, width, height)

        oGraphic.DrawImage(oImg, oRectangle)

        If newimagename = "" Then
            If image.Substring(image.LastIndexOf(".")) <> ".png" Then
                oThumbNail.Save(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image), System.Drawing.Imaging.ImageFormat.Jpeg)
            Else
                oThumbNail.Save(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image), System.Drawing.Imaging.ImageFormat.Png)
            End If
        Else
            If newimagename.Substring(newimagename.LastIndexOf(".")) <> ".png" Then
                oThumbNail.Save(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & newimagename), System.Drawing.Imaging.ImageFormat.Jpeg)
            Else
                oThumbNail.Save(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & newimagename), System.Drawing.Imaging.ImageFormat.Png)
            End If
        End If
        oImg.Dispose()
    End Sub


End Class
