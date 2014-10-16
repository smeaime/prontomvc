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



Partial Class CartasDePorteFotosJuntas
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


        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdCartaDePorte = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdCartaDePorte

        ElseIf Request.QueryString.Get("CopiaDe") IsNot Nothing Then
        Else
            Me.IdEntity = IdCartaDePorte 'que ha de ser  -1. acá llegaría si no le pasan Id
            Debug.Assert(IdCartaDePorte = -1)
        End If

        mKey = "CartaDePorte_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)

        'que pasa si el usuario es Nothing? Qué se rompió?
        If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))

        SC = usuario.StringConnection



        Dim myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCartaDePorte, True)
        reloadimagen()


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

End Class