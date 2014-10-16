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

Partial Class CartasDePorteImportador
    Inherits System.Web.UI.Page

    'Tecnicas de importacion de excel a gridview
    ' 
    'http://forums.asp.net/p/1192930/2057005.aspx#2057005
    'http://forums.asp.net/t/1195205.aspx
    'Una tecnica puede ser usar un ODS  http://forums.asp.net/t/995531.aspx

    'http://www.4guysfromrolla.com/articles/031208-1.aspx
    'http://www.aspboy.com/Categories/GridArticles/Excel_Like_GridView.aspx


    'http://www.codeproject.com/KB/webforms/BulkEditGridView.aspx

    'voy a necesitar eliminacion de columnas y desplazamiento de columnas?

    'copy paste
    'http://forums.asp.net/t/1092548.aspx

    'asuntos del render
    'http://forums.asp.net/p/901776/986762.aspx#986762

    'asuntos con el teclado (las flechitas)
    'http://forums.asp.net/t/1522647.aspx
    'http://codeasp.net/articles/gridview-rows-navigation-using-arrow-up-down-keys/137/gridview-rows-navigation-using-arrow-up-down-keys

    'VINCE XU
    'Hi, There are two approach for achieving it.
    'One is using Excel Object(Microsoft.Office.Interop.Excel) to retrieve it into DataSet.
    'The following post is retrieving excel file and import into GridView by using Microsoft.Office.Interop.Excel: http://forums.asp.net/p/1192930/2057005.aspx#2057005
    'Another is using OLEDB to retrieve excel into DataSet which can be convert into database. It's easier and more appropriated for you.


    Private DIRFTP As String = "C:\"

    Private IdComparativa As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Private bEligioForzarFormato As Boolean = False
    Private _acVendedores As Object

    Private Property acVendedores As Object
        Get
            Return _acVendedores
        End Get
        Set(value As Object)
            _acVendedores = value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        'If Not (Request.QueryString.Get("Id") Is Nothing) Then 'si trajo el parametro ID, lo guardo aparte
        '    IdComparativa = Convert.ToInt32(Request.QueryString.Get("Id"))
        '    Me.IdEntity = IdComparativa
        'End If
        'mKey = "Comparativa_" & Me.IdEntity.ToString
        'mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)

        'que pasa si el usuario es Nothing? Qué se rompió?
        If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))

        SC = usuario.StringConnection
        HFSC.Value = SC

        DIRFTP = System.IO.Path.GetTempPath()

        lblVistaPrevia.Visible = False

        Dim cSuperbuscador As WebControls.TextBox = Me.Master.FindControl("txtSuperbuscador")
        cSuperbuscador.Visible = False 'pinta que si está el superbuscador, me tira lo del Response Server Error

        Try
            Dim cmbSuperbuscador As WebControls.DropDownList = Me.Master.FindControl("cmbFiltroSuperbuscador")
            cmbSuperbuscador.Visible = False
            'btnVistaPrevia.Visible = False

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try



        If Not IsPostBack Then
            'primera carga
            txtFechaArribo.Text = Today
            btnEmpezarImportacion.Visible = False

            txtFechaArribo.Visible = True


            cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
            cmbPuntoVenta.DataTextField = "PuntoVenta"
            cmbPuntoVenta.DataValueField = "PuntoVenta"
            cmbPuntoVenta.DataBind()

            If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If

        Else

            'hicieron postback desde el textbox?
            'If sender = txtBuscarCliente Then validar()

        End If
        '///////////////////////////
        '///////////////////////////
        'DEBUG
        'Dim ds As DataSet = GetExcel("C:\Rasic Monte.xls") '("C:\williamsf11.xls") '   (DIRFTP + FileUpLoad2.FileName)
        'gvClientes.DataSource = ds
        'gvClientes.DataBind()
        'gvExcel.DataSource = ds
        'gvExcel.DataBind()
        '///////////////////////////
        '///////////////////////////




        AutoCompleteExtender6.ContextKey = SC
        AutoCompleteExtender8.ContextKey = SC



        'Permisos()
    End Sub



    Protected Sub AsyncFileUpload2_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload2.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload2.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload2.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()
                Dim nombrenuevo = DIRFTP + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido2") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload2.SaveAs(nombrenuevo)

                'btnEmpezarImportacion.Visible = True
                'txtFechaArribo.Visible = True
                'panelEquivalencias.Visible = False
                'txtLogErrores.Visible = False
                'txtLogErrores.Text = ""

                'If Not bEligioForzarFormato Then FormatoDelArchivo(nombrenuevo) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
                'RefrescarTextosDefault()

            Catch ex As Exception
                ErrHandler.WriteError(ex.Message)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub






    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        Dim sError As String
        Try
            If InStr(AsyncFileUpload1.FileName, ".zip") Then
                'CartaDePorteManager.
                AdjuntarImagenEnZip(SC, AsyncFileUpload1, -1, sError)
            Else
                CartaDePorteManager.AdjuntarImagen(SC, AsyncFileUpload1, -1, sError)
            End If

        Catch ex As Exception
            sError = ex.Message & " " & ex.Source & vbCrLf & sError

        End Try
        'MsgBoxAjax(Me, sError)
        txtLogErrores.Text = sError
        txtLogErrores.Visible = True



    End Sub




    Protected Sub btnVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnVistaPrevia.Click

        Exit Sub


    End Sub

    Protected Sub btnEmpezarImportacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmpezarImportacion.Click
    End Sub


    Private Shared Function Extraer(ZipAExtraer As String, DirectorioExtraccion As String) As Generic.List(Of String)




        Dim archivos As New Generic.List(Of String)

        Using zip1 As Ionic.Zip.ZipFile = Ionic.Zip.ZipFile.Read(ZipAExtraer)
            Dim e As Ionic.Zip.ZipEntry
            For Each e In zip1
                e.Extract(DirectorioExtraccion, Ionic.Zip.ExtractExistingFileAction.OverwriteSilently)
                archivos.Add(e.FileName)
            Next
        End Using





        Return archivos
    End Function


    Shared Function AdjuntarImagenEnZip(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, Optional forzarID As Long = -1, Optional ByRef sError As String = "") As String

        Dim DIRTEMP = DirApp() & "\Temp\"
        Dim DIRFTP = DirApp() & "\DataBackupear\"


        Dim destzip = DIRTEMP + "zipeado.zip"
        Dim MyFile3 As New FileInfo(destzip)
        Try
            If MyFile3.Exists Then
                MyFile3.Delete()
            End If
        Catch ex As Exception
        End Try


        Dim files = Directory.GetFiles(DIRTEMP)
        For Each file As String In files
            IO.File.SetAttributes(file, FileAttributes.Normal)
            IO.File.Delete(file)
        Next


        AsyncFileUpload1.SaveAs(destzip)
        Dim archivos As Generic.List(Of String) = Extraer(destzip, DIRTEMP)






        For Each nombre As String In archivos

            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            Randomize()
            Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre

            Dim no As String() = Split(nombre)

            Dim numeroCarta = Val(no(0))
            Dim vagon = 0
            Try
                vagon = Val(no(1)) ' Val(Mid(nombre, InStr(nombre, " ")))
            Catch ex As Exception

            End Try

            Dim MyFile1 As New FileInfo(DIRFTP + nombrenuevo)
            Try
                If MyFile1.Exists Then
                    MyFile1.Delete()
                End If
            Catch ex As Exception
            End Try

            'copio el archivo cambiandole el nombre agregandole un sufijo

            Dim MyFile2 As New FileInfo(DIRTEMP + nombre)
            Try
                If MyFile2.Exists Then
                    MyFile2.CopyTo(DIRFTP + nombrenuevo)
                End If
            Catch ex As Exception
            End Try



            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////






            Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon)
            If cdp.Id = -1 Then
                sError &= numeroCarta & "/" & vagon & " no existe <br/> "

                Continue For
            End If
            forzarID = cdp.Id


            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = forzarID).SingleOrDefault


            If InStr(nombrenuevo.ToUpper, "TK") Then
                oCarta.PathImagen2 = nombrenuevo
            ElseIf InStr(nombrenuevo.ToUpper, "CP") Then
                oCarta.PathImagen = nombrenuevo
            Else
                If oCarta.PathImagen = "" Then
                    oCarta.PathImagen = nombrenuevo 'nombrenuevo
                ElseIf oCarta.PathImagen2 = "" Then
                    oCarta.PathImagen2 = nombrenuevo 'nombrenuevo
                Else
                    sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a> tiene las dos imagenes ocupadas;  <br/> "
                    'sError &= vbCrLf & numeroCarta & " tiene las dos imagenes ocupadas  <br/>"
                    Continue For
                End If
            End If

            sError &= "<a href=""CartaDePorte.aspx?Id=" & forzarID & """ target=""_blank"">" & oCarta.NumeroCartaDePorte & "/" & oCarta.SubnumeroVagon & "</a>;  <br/> "

            db.SubmitChanges()
        Next
    End Function




End Class





