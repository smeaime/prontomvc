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

Imports CartaDePorteManager

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











        'sDirFTP = HttpContext.Current.Server.MapPath("~/" + ConfigurationManager.AppSettings("sDirFTP")) 'no necesito usar MapPath, porque no estoy usando un dir virtual
        'sDirFTP = ConfigurationManager.AppSettings("sDirFTP")
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\Pronto\DataBackupear\"
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\ProntoWeb\DataBackupear\"
        'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        'sDirFTP = HttpContext.Current.Server.MapPath("~/") + "..\ProntoWeb\DataBackupear\"
        sDirFTP = "~/" + "..\Pronto\DataBackupear\" ' Cannot use a leading .. to exit above the top directory..

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = EncriptarParaCSharp(scLocal)  'EncriptarParaCSharp("Data Source=MARIANO-PC\MSSQLSERVER2;Initial Catalog=Williams;Uid=sa; PWD=ok;")
            'sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
            sDirFTP = "~/DataBackupear\"
            'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        Else
            'ssdfgsdfg


            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
            'sDirFTP = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
        End If




        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        'http://madskristensen.net/post/HttpModule-for-query-string-encryption.aspx

        Try

            If Not (Request.QueryString.Get("Id") Is Nothing) Then
                Dim strScramble = Request.QueryString.Get("Id")

                Try
                    IdCartaDePorte = EntidadManager.decryptQueryString(strScramble.Replace(" ", "+"))
                Catch ex As Exception
                    'no pudo convertirlo a integer
                    ErrHandler2.WriteError(strScramble)
                    ErrHandler2.WriteError(EntidadManager.decryptQueryString(strScramble.Replace(" ", "+")))
                    Throw
                End Try

                Me.IdEntity = IdCartaDePorte

                ErrHandler2.WriteError("Viendo Encriptacion del ID " & IdCartaDePorte)
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



        'mKey = "CartaDePorte_" & Me.IdEntity.ToString
        'mAltaItem = False
        'usuario = New Usuario
        'usuario = Session(SESSIONPRONTO_USUARIO)

        ''que pasa si el usuario es Nothing? Qué se rompió?
        'If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))







        If True Then


            Dim iMinAircraftImgWidth As Integer = 500
            Dim iMinAircraftImgHeight As Integer = 372
            '  ResizeImage(imagename, "imagepath", "imagepath", iMinAircraftImgWidth, iMinAircraftImgHeight, strNewFileName)
        Else
            'Dim img As Image
            'img.GetThumbnailImage(400, 400, null, IntPtr.Zero)

        End If


        If Not IsPostBack Then

            Dim myCartaDePorte As CartaDePorte


            If System.Diagnostics.Debugger.IsAttached() And False Then
                myCartaDePorte = New CartaDePorte
                myCartaDePorte.PathImagen = "9675224abr2013_071802_30868007-CP.jpg"
                myCartaDePorte.PathImagen2 = "4088624abr2013_071803_30868007-TK.jpg"
            Else


                myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCartaDePorte, True)


                If myCartaDePorte Is Nothing Then
                    '                Log Entry 
                    '08/09/2017 16:58:56
                    'Error in: https :  //prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImagenEncriptada.aspx?Id=h1iKH/Ma/Mw=. Error Message:Viendo Encriptacion del ID 3033792
                    '__________________________

                    '                Log Entry 
                    '08/09/2017 16:58:56
                    'Error in: https :  //prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImagenEncriptada.aspx?Id=h1iKH/Ma/Mw=. Error Message:System.NullReferenceException
                    '                Object reference Not set to an instance of an object.
                    '   at CartaDePorteManager.GetItem(String SC, Int32 id, Boolean getCartaDePorteDetalles) in C:\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:Line 9636
                    'BusinessLogic

                    ErrHandler2.WriteError(IdCartaDePorte.ToString + " " + Encriptar(SC))
                End If









                Response.Write("Carta " & myCartaDePorte.NumeroCartaDePorte)
                If True Then
                    reloadimagen()
                    'refrescaIdEncriptados(SC)
                End If

            End If


            If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then
                'verificar la carta de porte original a ver si tiene las imagenes
                If myCartaDePorte.SubnumeroDeFacturacion > 0 Then

                    Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


                    Dim idorig = _
                                     (From c In db.CartasDePortes _
                                     Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
                                     And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
                                      And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault

                    If idorig > 0 Then
                        myCartaDePorte = CartaDePorteManager.GetItem(SC, idorig)

                        btnDescargaPDF.Text = "Descargar PDF  (carta original " & myCartaDePorte.NumeroCartaDePorte.ToString & " id " & idorig.ToString & ")"

                        IdCartaDePorte = idorig
                        reloadimagen()
                    End If

                End If
            End If



            If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then


                Dim s = "La carta " & myCartaDePorte.NumeroCartaDePorte.ToString & " fue modificada y ya no tiene imágenes adjuntas (" & IdCartaDePorte.ToString & ")"
                MsgBoxAjax(Me, s)
                btnDescargaPDF.Enabled = False
                btnDescargaPDF.Text = s
            End If
        End If









    End Sub


    Protected Sub btnDescargaPDF_Click(sender As Object, e As System.EventArgs) Handles btnDescargaPDF.Click

        'If True Then
        '    MsgBoxAlert(output)
        '    Return
        'End If

        'ssss btn pdf


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



        If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then
            'verificar la carta de porte original a ver si tiene las imagenes
            If myCartaDePorte.SubnumeroDeFacturacion > 0 Then

                Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


                Dim idorig = _
                                 (From c In db.CartasDePortes _
                                 Where c.NumeroCartaDePorte = myCartaDePorte.NumeroCartaDePorte _
                                 And c.SubnumeroVagon = myCartaDePorte.SubnumeroVagon _
                                  And c.SubnumeroDeFacturacion = 0 Select c.IdCartaDePorte).FirstOrDefault

                If idorig > 0 Then
                    myCartaDePorte = CartaDePorteManager.GetItem(SC, idorig)

                    btnDescargaPDF.Text = "Descargar PDF  (carta original " & myCartaDePorte.NumeroCartaDePorte.ToString & " id " & idorig.ToString & ")"

                    IdCartaDePorte = idorig
                    reloadimagen()
                End If

            End If
        End If



        If myCartaDePorte.PathImagen = "" And myCartaDePorte.PathImagen2 = "" Then


            Dim s = "La carta " & myCartaDePorte.NumeroCartaDePorte.ToString & " fue modificada y ya no tiene imágenes adjuntas (" & IdCartaDePorte.ToString & ")"
            MsgBoxAjax(Me, s)
            btnDescargaPDF.Enabled = False
            btnDescargaPDF.Text = s
        End If


        '///////////////////////////////////////////////////////////////////////////////////////////////////////










        Dim output As String
        If True Then
            'myCartaDePorte.PathImagen = "4225mar2013_111151_29950530 104 TK.jpg"
            'myCartaDePorte.PathImagen2 = "91408abr2013_164618_Tulips.jpg"

            output = Path.GetTempPath & "ImagenesCartaPorte " & Now.ToString("ddMMMyyyy_HHmmss") & GenerarSufijoRand() & ".pdf" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net






            If System.Diagnostics.Debugger.IsAttached() Then
                CartaDePorteManager.PDFcon_iTextSharp(output, _
                                   HttpContext.Current.Server.MapPath(IIf(myCartaDePorte.PathImagen <> "", sDirFTP, "")) + myCartaDePorte.PathImagen, _
                                 HttpContext.Current.Server.MapPath(IIf(myCartaDePorte.PathImagen2 <> "", sDirFTP, "")) + myCartaDePorte.PathImagen2 _
                                  )
            Else

                sDirFTP = AppDomain.CurrentDomain.BaseDirectory & "\..\Pronto\DataBackupear\"
                sDirFTP = "E:\Sites\Pronto\DataBackupear\"

                Try
                    CartaDePorteManager.PDFcon_iTextSharp(output, _
                                      IIf(myCartaDePorte.PathImagen <> "", sDirFTP + myCartaDePorte.PathImagen, ""), _
                                    IIf(myCartaDePorte.PathImagen2 <> "", sDirFTP + myCartaDePorte.PathImagen2, "") _
                                      )

                Catch ex As Exception

                    ErrHandler2.WriteError(ex)
                    'MsgBoxAjax(Me, "La carta " & myCartaDePorte.Numero & " fue modificada y ya no tiene imágenes adjuntas")
                    MsgBoxAjax(Me, "La carta " & myCartaDePorte.NumeroCartaDePorte & " fue modificada y ya no tiene imágenes adjuntas")
                    Return

                End Try

            End If





        Else
            ' output = generarInformeFotosConReportViewerPDF(SC, pa + myCartaDePorte.PathImagen, pa + myCartaDePorte.PathImagen2)
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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try
    End Sub




    Sub reloadimagen()

        If System.Diagnostics.Debugger.IsAttached() Then
        Else
            sDirFTP = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
            'sDirFTP = "http://localhost/Pronto/DataBackupear/" 'no podés usar localhost desde afuera....
        End If


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
                    If True Then

                        CartaDePorteManager.ResizeImage(oCarta.PathImagen, 400, 400, oCarta.PathImagen & ".temp." & Path.GetExtension(oCarta.PathImagen), sDirFTP, AplicacionConImagenes)
                        'oCarta.PathImagen = "temp_" + oCarta.PathImagen
                    End If



                    linkimagenlabel.HRef = sDirFTP & "" & oCarta.PathImagen
                    linkImagen.Text = "ampliar"
                    linkImagen.NavigateUrl = sDirFTP & oCarta.PathImagen
                    linkImagen.Visible = False 'True
                    imgFotoCarta.ImageUrl = sDirFTP & oCarta.PathImagen & ".temp." & Path.GetExtension(oCarta.PathImagen) ' oCarta.PathImagen

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

                    If True Then
                        CartaDePorteManager.ResizeImage(oCarta.PathImagen2, 400, 400, oCarta.PathImagen2 & ".temp." & Path.GetExtension(oCarta.PathImagen2), sDirFTP, AplicacionConImagenes)
                        'oCarta.PathImagen2 = "temp_" + oCarta.PathImagen2
                    End If

                    linkimagenlabel2.HRef = sDirFTP & "" & oCarta.PathImagen2 'lo que se ve es la ajustada
                    linkImagen_2.Text = "ampliar"
                    linkImagen_2.NavigateUrl = sDirFTP & oCarta.PathImagen2   ' al hacer click, deberia usar la imagen NO-ajustada
                    linkImagen_2.Visible = False 'True
                    imgFotoCarta2.ImageUrl = sDirFTP & oCarta.PathImagen2 & ".temp." & Path.GetExtension(oCarta.PathImagen2) ' oCarta.PathImagen




                    'http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
                    'btnDesfacturar.Visible = True
                Else
                    linkImagen_2.Visible = False
                    ' btnadjuntarimagen.Visible = False
                End If

            End Using

        Catch ex As Exception

            'http://stackoverflow.com/questions/16055667/graphics-drawimage-out-of-memory-exception

            'http://stackoverflow.com/questions/5288204/help-to-resolve-out-of-memory-exception-when-calling-drawimage

            ErrHandler2.WriteError(ex)
        End Try

    End Sub







End Class
