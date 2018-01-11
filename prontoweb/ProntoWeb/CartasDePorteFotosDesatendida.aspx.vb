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


Imports Inlite.ClearImageNet

Imports CartasDePorteImportador.FormatosDeExcel

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging

Imports ExcelImportadorManager
Imports ExcelImportadorManager.FormatosDeExcel

Imports ClaseMigrar.SQLdinamico

Imports System.Linq

Imports CartaDePorteManager

Imports FCEngine
Imports ProntoFlexicapture


Partial Class CartasDePorteFotosDesatendida
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
            ErrHandler2.WriteError(ex)
        End Try



        If Not IsPostBack Then
            'primera carga
            txtFechaArribo.Text = Today
            btnEmpezarImportacion.Visible = False

            txtFechaArribo.Visible = True


            cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(SC)
            'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
            cmbPuntoVenta.DataTextField = "PuntoVenta"
            cmbPuntoVenta.DataValueField = "PuntoVenta"
            cmbPuntoVenta.DataBind()

            If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()) .PuntoVentaAsociado > 0 Then
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
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub





    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        If (Me.FileUpload1.HasFile) Then


            Dim DIRTEMP As String = DirApp() & "\Temp\"
            Me.FileUpload1.SaveAs(DIRTEMP + Me.FileUpload1.FileName)

        End If


    End Sub


    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        Debug.Print("eventtarget: " & Request.Params.Get("__EVENTTARGET"))

        If (AsyncFileUpload1.IsUploading And False) Then Return

        Dim s As String = Request.Params.Get("__EVENTTARGET")

        'http://stackoverflow.com/questions/5018044/asyncfileupload-postback-causes-double-upload
        If (s <> "UpdatePanelAFU") Or True Then
            MsgBoxAjax(Me, "Terminado")
            Return
        End If


        Dim DIRTEMP As String = DirApp() & "\Temp\"


        Dim sError As String
        Try
            If InStr(AsyncFileUpload1.FileName, ".zip") Then
                'CartaDePorteManager.
                AdjuntarImagenEnZip(SC, AsyncFileUpload1, -1, sError)
            ElseIf InStr(AsyncFileUpload1.FileName, ".rar") Then
                'CartaDePorteManager.
                'AdjuntarImagenEnZip(SC, AsyncFileUpload1, -1, sError)
                MsgBoxAjax(Me, "No se aceptan archivos RAR. Convertilo en un ZIP")
            Else

                'archivo simple

                If False Then

                    Dim numeroCarta = Val(ReadBarcode1D_ZXing(DIRFTP + AsyncFileUpload1.PostedFile.FileName, 0))
                End If

                AsyncFileUpload1.SaveAs(DIRTEMP + AsyncFileUpload1.PostedFile.FileName)
                Dim archivos As New Generic.List(Of String)
                archivos.Add(DIRTEMP + AsyncFileUpload1.PostedFile.FileName)
                If False Then
                    ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, archivos, -1, sError, DirApp())

                Else
                    preprocesarImagenesTiff()
                    ClassFlexicapture.ActivarMotor(SC, archivos, sError, DirApp(), ConfigurationManager.AppSettings("UsarFlexicapture"))
                End If

                'CartaDePorteManager.AdjuntarImagen(SC, AsyncFileUpload1, -1, sError, DirApp(),                                                   NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName))
            End If

        Catch ex As Exception
            sError = ex.ToString & " " & ex.Source & vbCrLf & sError
            'MandarMailDeError(sError)
        End Try

        txtLogErrores.Text = sError
        txtLogErrores.Visible = True

        'UpdatePanelAFU.Update()
        'MsgBoxAjax(Me, sError.Replace("<br/>", "\n"))

    End Sub


    Private Shared Function preprocesarImagenesTiff()

    End Function

    Protected Sub btnVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnVistaPrevia.Click

        Exit Sub


    End Sub

    Protected Sub btnEmpezarImportacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmpezarImportacion.Click
    End Sub





    '  private void btnStartDecoding_Click(object sender, EventArgs e)
    '{
    '   var fileName = txtBarcodeImageFile.Text;
    '   if (!File.Exists(fileName))
    '   {
    '      MessageBox.Show(this, String.Format("File not found: {0}", fileName), "Error", MessageBoxButtons.OK,
    '                      MessageBoxIcon.Error);
    '      return;
    '   }

    '   using (var bitmap = (Bitmap)Bitmap.FromFile(fileName))
    '   {
    '      if (TryOnlyMultipleQRCodes)
    '         Decode(bitmap, TryMultipleBarcodes, new List<BarcodeFormat> { BarcodeFormat.QR_CODE });
    '      else
    '         Decode(bitmap, TryMultipleBarcodes, null);
    '   }
    '}

    'private void Decode(Bitmap image, bool tryMultipleBarcodes, IList<BarcodeFormat> possibleFormats)
    '{
    '   resultPoints.Clear();
    '   lastResults.Clear();
    '   txtContent.Text = String.Empty;

    '   var timerStart = DateTime.Now.Ticks;
    '   Result[] results = null;
    '   var previousFormats = barcodeReader.Options.PossibleFormats;
    '   if (possibleFormats != null)
    '      barcodeReader.Options.PossibleFormats = possibleFormats;
    '   if (tryMultipleBarcodes)
    '      results = barcodeReader.DecodeMultiple(image);
    '   else
    '   {
    '      var result = barcodeReader.Decode(image);
    '      if (result != null)
    '      {
    '         results = new[] {result};
    '      }
    '   }
    '   var timerStop = DateTime.Now.Ticks;

    '   barcodeReader.Options.PossibleFormats = previousFormats;

    '   if (results == null)
    '   {
    '      txtContent.Text = "No barcode recognized";
    '   }
    '   labDuration.Text = new TimeSpan(timerStop - timerStart).ToString();

    '   if (results != null)
    '   {
    '      foreach (var result in results)
    '      {
    '         if (result.ResultPoints.Length > 0)
    '         {
    '            var rect = new Rectangle((int) result.ResultPoints[0].X, (int) result.ResultPoints[0].Y, 1, 1);
    '            foreach (var point in result.ResultPoints)
    '            {
    '               if (point.X < rect.Left)
    '                  rect = new Rectangle((int) point.X, rect.Y, rect.Width + rect.X - (int) point.X, rect.Height);
    '               if (point.X > rect.Right)
    '                  rect = new Rectangle(rect.X, rect.Y, rect.Width + (int) point.X - rect.X, rect.Height);
    '               if (point.Y < rect.Top)
    '                  rect = new Rectangle(rect.X, (int) point.Y, rect.Width, rect.Height + rect.Y - (int) point.Y);
    '               if (point.Y > rect.Bottom)
    '                  rect = new Rectangle(rect.X, rect.Y, rect.Width, rect.Height + (int) point.Y - rect.Y);
    '            }
    '            using (var g = picBarcode.CreateGraphics())
    '            {
    '               g.DrawRectangle(Pens.Green, rect);
    '            }
    '         }
    '      }
    '   }
    '}




    Shared Function AdjuntarImagenEnZip(SC As String, AsyncFileUpload1 As AjaxControlToolkit.AsyncFileUpload, Optional forzarID As Long = -1, Optional ByRef sError As String = "") As String

        Dim DIRTEMP As String = DirApp() & "\Temp\"
        Dim DIRFTP As String = DirApp() & "\DataBackupear\"




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
            ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, archivos, forzarID, sError, DirApp())

        Else

            preprocesarImagenesTiff()
            ClassFlexicapture.ActivarMotor(SC, archivos, sError, DirApp(), ConfigurationManager.AppSettings("UsarFlexicapture"))

        End If


    End Function






End Class





