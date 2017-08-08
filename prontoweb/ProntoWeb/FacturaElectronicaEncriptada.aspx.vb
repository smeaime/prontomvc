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
Imports ExcelOffice = Microsoft.Office.Interop.Excel

Imports CartasDePorteImportador.FormatosDeExcel
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports ExcelImportadorManager
Imports ExcelImportadorManager.FormatosDeExcel
Imports ClaseMigrar.SQLdinamico
Imports System.Linq
Imports Word = Microsoft.Office.Interop.Word

Imports Microsoft.Reporting.WebForms

Imports Pronto.ERP.Bll.CDPMailFiltrosManager

Imports iTextSharp.text
Imports iTextSharp.text.pdf

Imports CartaDePorteManager

Partial Class FacturaElectronicaEncriptada
    Inherits System.Web.UI.Page


    Private IdFactura As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing
    Private _linkImagen2 As Object

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdFactura"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdFactura") = Value
        End Set
    End Property




    Dim sDirFTP As String = Nothing




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



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load




        If True Then 'parche porque no anda el openxml en produccion pero sí en clientes

            Response.Redirect(Request.Url.ToString.Replace("https://prontoweb.williamsentregas.com.ar", "http://prontoclientes.williamsentregas.com.ar"))
            Return

        End If



        'sDirFTP = HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings("sDirFTP")) 'no necesito usar MapPath, porque no estoy usando un dir virtual
        'sDirFTP = ConfigurationManager.AppSettings("sDirFTP")
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\Pronto\DataBackupear\"
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\ProntoWeb\DataBackupear\"
        'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\ProntoWeb\DataBackupear\"
        sDirFTP = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = EncriptarParaCSharp(scLocal)  'EncriptarParaCSharp("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Uid=sa; PWD=ok;")
            sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
            'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"


        ElseIf ConfigurationManager.AppSettings("UrlDominio").ToUpper.Contains("Testing") Then
            SC = EncriptarParaCSharp(scWilliamsDebug)

        Else

            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
            'sDirFTP = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
        End If




        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        'http://madskristensen.net/post/HttpModule-for-query-string-encryption.aspx

        Try



            If Not (Request.QueryString.Get("Id") Is Nothing) Then
                Dim strScramble = Request.QueryString.Get("Id")

                'EntidadManager.encryptQueryString("5000")
                'http://localhost:48391/ProntoWeb/ProntoWeb/FacturaElectronicaEncriptada.aspx?id=MqJdI5cWE8k=


                IdFactura = EntidadManager.decryptQueryString(strScramble.Replace(" ", "+"))
                Me.IdEntity = IdFactura
                ErrHandler2.WriteError("Viendo Encriptacion del ID " & IdFactura)

                lbltitulo.Text = "Factura ID " & IdFactura
                'numero(ycliente)


                If Not (Request.QueryString.Get("Modo") Is Nothing) Then
                    If Request.QueryString.Get("Modo") = "DescargaFactura" Then
                        Dim output = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura, True, SC, DirApp)


                        Try
                            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                            If MyFile1.Exists Then
                                Response.ContentType = "application/octet-stream"
                                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                                Response.TransmitFile(output)
                                Response.End()
                            Else
                                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
                            End If
                        Catch ex As Exception
                            MsgBoxAjax(Me, ex.ToString)
                            Return
                        End Try
                        Return
                    ElseIf Request.QueryString.Get("Modo") = "DescargaFacturaDOCX" Then
                        Dim output = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura, False, SC, DirApp)


                        Try
                            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                            If MyFile1.Exists Then
                                Response.ContentType = "application/octet-stream"
                                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                                Response.TransmitFile(output)
                                Response.End()
                            Else
                                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
                            End If
                        Catch ex As Exception
                            MsgBoxAjax(Me, ex.ToString)
                            Return
                        End Try

                        Return
                    ElseIf Request.QueryString.Get("Modo") = "DescargaAdjuntos" Then
                        ImprimirAdjuntos(IdFactura)
                        Return
                    ElseIf Request.QueryString.Get("Modo") = "ProcesarExcel" Then
                        ProcesarExcel(Request.QueryString.Get("Archivo"))
                        Return
                    End If

                End If



                'ImprimirFacturaElectronica(IdFactura)
            Else
                ErrHandler2.WriteError("Página no autorizada")
                MsgBoxAjax(Me, "Página no autorizada")
                Exit Sub
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "Página no autorizada")
            Exit Sub

        End Try











    End Sub





    Function PDFcon_iTextSharp(filepdf As String, filejpg As String, filejpg2 As String)


        ErrHandler2.WriteError("PDFcon_iTextSharp " & filejpg & "   " & filejpg2)



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


            Try
                document.Close()
            Catch ex As Exception
                ' The document has no pages.
                'Stack(Trace) : at(iTextSharp.text.pdf.PdfPages.WritePageTree())
                'at(iTextSharp.text.pdf.PdfWriter.Close())
                'at(iTextSharp.text.pdf.PdfDocument.Close())
                'at(iTextSharp.text.Document.Close())

                MandarMailDeError(ex.ToString + " " + filejpg + " " + filejpg2)
                ErrHandler2.WriteError(ex)
                'MsgBoxAjax(Me, "No se pudo generar el documento PDF. Quizas las cartas fueron modificadas y ya no tienen imágenes adjuntas")
                Throw
            End Try





        End Using

    End Function



    'http://www.codeproject.com/Questions/362618/How-to-reduce-image-size-in-asp-net-with-same-clar
    Public Shared Sub ResizeImage(image As String, Okey As String, key As String, width As Integer, height As Integer, newimagename As String, sDirVirtual As String)
        'Dim sDir = AppDomain.CurrentDomain.BaseDirectory & "DataBackupear\"
        'Dim sDir = ConfigurationManager.AppSettings("sDirFTP") ' & "DataBackupear\"


        Dim sDir As String

        If System.Diagnostics.Debugger.IsAttached() Then
            sDir = HttpContext.Current.Server.MapPath(sDirVirtual)
        Else
            sDir = "C:\Inetpub\wwwroot\Pronto\DataBackupear\"
        End If


        ErrHandler2.WriteError("ResizeImage " & sDir & image)



        'Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings(Okey) & image))
        Dim oImg As System.Drawing.Image = System.Drawing.Image.FromFile(sDir & image)

        'http://siderite.blogspot.com/2009/09/outofmemoryexception-in.html
        oImg = oImg.GetThumbnailImage(oImg.Width, oImg.Height, Nothing, IntPtr.Zero)


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
                oThumbNail.Save(sDir & image, System.Drawing.Imaging.ImageFormat.Jpeg)
            Else
                oThumbNail.Save(sDir & image, System.Drawing.Imaging.ImageFormat.Png)
            End If
        Else
            If newimagename.Substring(newimagename.LastIndexOf(".")) <> ".png" Then
                oThumbNail.Save(sDir & newimagename, System.Drawing.Imaging.ImageFormat.Jpeg)
            Else
                oThumbNail.Save(sDir & newimagename, System.Drawing.Imaging.ImageFormat.Png)
            End If
        End If
        oImg.Dispose()
    End Sub



    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        ImprimirAdjuntos(IdFactura)
    End Sub

    Protected Sub btnDescargaPDF_Click(sender As Object, e As System.EventArgs) Handles btnDescargaPDF.Click
        Dim output = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura, True, SC, DirApp)



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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            'Return
        End Try

    End Sub





    Function ImprimirAdjuntos(IdFactura As Integer)

        Dim output As String = ""


        'output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON_A4(SC, IdFactura, output, ReportViewer2)


        If True Then


            For n = 1 To 3 'bucle para ver si genera bien el archivo

                Dim ofac = FacturaManager.GetItem(SC, IdFactura, True)
                Dim prefijo As String = Int(Rnd() * 10000)
                Dim p = DirApp() & "\Documentos\" & "FactElec_Williams.docx"


                output = System.IO.Path.GetTempPath() & "\" & prefijo & "FacturaElecronicaAdjuntos_Numero" & ofac.Numero & ".xls"
                'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
                Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
                If MyFile2.Exists Then
                    MyFile2.Delete()
                End If


                Try
                    System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

                Catch ex As Exception
                    MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
                    Exit Function
                End Try


                Dim ocli = ClienteManager.GetItem(SC, ofac.IdCliente)

                'ocli.CartaPorteTipoDeAdjuntoDeFacturacion = 2

               
                If ocli.CartaPorteTipoDeAdjuntoDeFacturacion <= 0 Then
                    MsgBoxAlert("No se envían adjuntos a este cliente")
                    Exit Function
                End If


                Select Case ocli.CartaPorteTipoDeAdjuntoDeFacturacion
                    Case 0
                        'nada
                    Case 1
                        'texto

                        ErrHandler2.WriteError("  vez " & n.ToString)

                        
                        Dim temp = output
                        'output += ".txt"
                        output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON_A4(SC, IdFactura, output, ReportViewer2)
                        If True Then
                            Response.Redirect("FacturaElectronicaEncriptada.aspx?Modo=ProcesarExcel&Archivo=" & temp & "&Id=" & Request.QueryString.Get("Id"))
                            Exit Function
                        End If
                        Exit For

                    Case 2
                        'excel 

                        output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel(SC, IdFactura, output, ReportViewer2)


                    Case 3
                        'excel
                        output = CDPMailFiltrosManager.AdjuntosFacturacionCartasImputadas_Excel(IdFactura, SC, ReportViewer2)
                    Case Else
                        output = CDPMailFiltrosManager.AdjuntosFacturacionCartasImputadas_Excel(IdFactura, SC, ReportViewer2)

                End Select

            Next

        End If


        ErrHandler2.WriteError("nombres archivos" & output & " ")


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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            'Return
        End Try

    End Function

    Function ProcesarExcel(output As String)


        ErrHandler2.WriteError("ProcesarExcel antes de llamar a ExcelToTextWilliamsAdjunto_A4 " & output & " ")

        output = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto_A4(output)


        ErrHandler2.WriteError("ProcesarExcel despues " & output & " ")


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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            'Return
        End Try

    End Function


End Class






