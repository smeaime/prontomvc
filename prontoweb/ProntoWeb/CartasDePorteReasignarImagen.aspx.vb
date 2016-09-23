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


Partial Class CartasDePorteReasignarImagen
    Inherits System.Web.UI.Page


    Private IdCartaDePorte As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing
    Private _linkImagen2 As Object

    Public Property IdEntity() As String
        Get
            Return DirectCast(ViewState("IdCartaDePorte"), String)
        End Get
        Set(ByVal Value As String)
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
            sDirFTP = "~/" + "..\ProntoWeb\DataBackupear\"
            'sDirFTP = "http://localhost:48391/ProntoWeb/DataBackupear/"
        Else
            SC = EncriptarParaCSharp(scWilliamsRelease) '    "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=90")
            'sDirFTP = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
        End If




        'http://stackoverflow.com/questions/240713/how-can-i-encrypt-a-querystring-in-asp-net?lq=1
        'http://madskristensen.net/post/HttpModule-for-query-string-encryption.aspx

        Try

            If Not (Request.QueryString.Get("Id") Is Nothing) Then
                Dim strScramble = Request.QueryString.Get("Id")
                Me.IdEntity = strScramble
                'IdCartaDePorte = EntidadManager.decryptQueryString(strScramble.Replace(" ", "+"))
                'Me.IdEntity = IdCartaDePorte
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




        Dim myCartaDePorte As CartaDePorte


        If System.Diagnostics.Debugger.IsAttached() And False Then
            myCartaDePorte = New CartaDePorte
            myCartaDePorte.PathImagen = "9675224abr2013_071802_30868007-CP.jpg"
            myCartaDePorte.PathImagen2 = "4088624abr2013_071803_30868007-TK.jpg"
        Else
            reloadimagen(Me.IdEntity)
        End If







    End Sub


    Protected Sub btnDescargaPDF_Click(sender As Object, e As System.EventArgs) Handles btnDescargaPDF.Click

        'If True Then
        '    MsgBoxAlert(output)
        '    Return
        'End If

        'ssss btn pdf
        Dim DIRTEMP = DirApp() & "\Temp\"
        Dim DIRFTP = DirApp() & "\DataBackupear\"

      
        If Not IsNumeric(TextBox1.Text) Then
            MsgBoxAjax(Me, "Poner un número de carta")
            Return
        End If


        Dim sError As String
        Dim s = CartaDePorteManager.GrabarImagen(-1, SC, TextBox1.Text, 0, Me.IdEntity, sError, DirApp(), False)

        If s = "" Then
            'hacer así: si la imagen no se pudo asignar, borrar el archivo del \DataBackupear\



            Dim MyFile5 As New FileInfo(DIRFTP + Me.IdEntity)
            Try
                If MyFile5.Exists Then
                    MyFile5.Delete()
                End If
            Catch ex As Exception
            End Try

            MsgBoxAjax(Me, "No se encontró la carta")
        Else

            Dim MyFile2 As New FileInfo(DIRTEMP + Me.IdEntity)
            Try
                If MyFile2.Exists Then
                    MyFile2.CopyTo(DIRFTP + Me.IdEntity)
                End If
            Catch ex As Exception
            End Try

            Dim MyFile5 As New FileInfo(DIRTEMP + Me.IdEntity)
            Try
                If MyFile5.Exists Then
                    MyFile5.Delete()
                End If
            Catch ex As Exception
            End Try

            Response.Redirect(String.Format("CartasDePorteReasignarImagenListado.aspx"))
            'MsgBoxAjax("Listo")
        End If




    End Sub




    Sub reloadimagen(archivo As String)

        Dim sDirTEMP As String

        sDirFTP = ConfigurationManager.AppSettings("UrlDominio") + "DataBackupear/"
        sDirTEMP = ConfigurationManager.AppSettings("UrlDominio") + "Temp/"

        'esta mal, si es prontotesting debe ir a prontotesting...
        If System.Diagnostics.Debugger.IsAttached() Then
        Else
            'sDirFTP = "https://prontoweb.williamsentregas.com.ar/DataBackupear/"
            'sDirTEMP = "https://prontoweb.williamsentregas.com.ar/Temp/"

        End If



        'linkimagenlabel.HRef = sDirFTP & "" & oCarta.PathImagen
        'linkImagen.Text = "ampliar"
        'linkImagen.NavigateUrl = sDirFTP & oCarta.PathImagen
        'linkImagen.Visible = False 'True
        imgFotoCarta.ImageUrl = sDirTEMP & archivo ' oCarta.PathImagen

        'ResizeImage(linkImagen.NavigateUrl, "", , , )

        ''http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
        ''btnDesfacturar.Visible = True
        '        Else
        'linkImagen.Visible = False
        '' btnadjuntarimagen.Visible = False
        '        End If
        ''//////////////////////////////////////////////////

    End Sub







End Class
