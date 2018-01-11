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

Imports System.Linq


Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging

Imports ExcelImportadorManager

Imports CartaDePorteManager

Imports LogicaImportador
Imports LogicaImportador.FormatosDeExcel


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


    Public Property NoValidarColumnas() As List(Of String)
        Get
            Return DirectCast(ViewState("NoValidarColumnas"), List(Of String))
        End Get
        Set(ByVal Value As List(Of String))
            ViewState("NoValidarColumnas") = Value
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
        If usuario Is Nothing Then
            Response.Redirect(String.Format("../Login.aspx"))
            'DatosDeSesion()
        End If

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
            panelEquivalencias.Visible = False
            txtFechaArribo.Visible = True


            NoValidarColumnas = New List(Of String)

            cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
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

        acClientes.ContextKey = SC
        acVendedores.ContextKey = SC
        acLocalidades.ContextKey = SC
        acArticulos.ContextKey = SC
        acDestinos.ContextKey = SC
        acTransportistas.ContextKey = SC
        acChoferes.ContextKey = SC
        acCalidades.ContextKey = SC

        AutoCompleteExtender6.ContextKey = SC
        AutoCompleteExtender8.ContextKey = SC



        Permisos()
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



    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload1.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()
                Dim nombrenuevo = DIRFTP + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload1.SaveAs(nombrenuevo)

                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = ReyserAnalisis Then Exit Sub
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = Unidad6Analisis Then Exit Sub
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = Urenport Then Exit Sub


                btnEmpezarImportacion.Visible = True
                txtBuscarCliente.Enabled = True

                txtFechaArribo.Visible = True
                panelEquivalencias.Visible = False
                txtLogErrores.Visible = True
                txtLogErrores.Text = ""

                If Not bEligioForzarFormato Then FormatoDelArchivo(nombrenuevo, cmbFormato) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
                RefrescarTextosDefault()

            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub


    Protected Sub btnVistaPrevia2_Click(sender As Object, e As System.EventArgs) Handles btnVistaPrevia2.Click
        ReyserCalidadesToDataset(Session("NombreArchivoSubido2").ToString, SC, cmbPuntoVenta.SelectedValue, txtLogErrores.Text, txtFechaArribo.Text, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))
    End Sub






    Protected Sub btnVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnVistaPrevia.Click


        Try

            If FormatearExcelImportado() > 0 Then



                'Object reference not set to an instance of an object.
                'explota por acá. evidentemente, Session("NombreArchivoSubido") no está declarado
                '-sin embargo, yo intente subir un txt diciendo q era formato excel, y me tiró también lo del error de esquema

                'Log Entry : 
                '05/28/2014 22:01:04
                'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.NullReferenceException
                'Object reference not set to an instance of an object.
                '   at CartasDePorteImportador.FormatoDelArchivo(String sNombreArchivoImportado)
                '   at CartasDePorteImportador.FormatearExcelImportado()
                '   at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e)
                'App_Web_z236ruay
                '__________________________

                'Log Entry : 
                '05/28/2014 22:01:04
                'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.NullReferenceException
                'Object reference not set to an instance of an object.
                '   at CartasDePorteImportador.btnVistaPrevia_Click(Object sender, EventArgs e)
                '   at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
                '   at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
                '   at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
                '   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
                '   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
                '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
                'App_Web_z236ruay
                '__________________________



                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = ReyserAnalisis Then
                    MsgBoxAjax(Me, txtLogErrores.Text)
                    Exit Sub
                End If
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = Unidad6Analisis Then
                    MsgBoxAjax(Me, txtLogErrores.Text)
                    Exit Sub
                End If
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString, cmbFormato) = Urenport Then
                    MsgBoxAjax(Me, txtLogErrores.Text)
                    Exit Sub
                End If

                MostrarPrimerosDiezRenglones()

            Else
                Dim nombre = NameOnlyFromFullPath(Session("NombreArchivoSubido").ToString)
                Try
                    File.Copy(Session("NombreArchivoSubido").ToString, Server.MapPath("~") + "\Error\" + nombre)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                End Try


                ErrHandler2.WriteError("IMPORTADOR No se pudo importar ningún renglón " & Session("NombreArchivoSubido"))

                MsgBoxAjax(Me, "No se pudo importar ningún renglón. Verifique el formato elegido")


            End If

        Catch ex As Exception


            ErrHandler2.WriteError(ex)
            MandarMailDeError(ex)

            Try
                ErrHandler2.WriteError(Session("NombreArchivoSubido").ToString)
                'MsgBoxAjax(Me, "Error al importar esquema." & ex.ToString)

                'guardate el archivo problematico

                Dim nombre = NameOnlyFromFullPath(Session("NombreArchivoSubido").ToString)

                File.Copy(Session("NombreArchivoSubido").ToString, Server.MapPath("~") + "\Error\" + nombre)
            Catch e2 As Exception
                ErrHandler2.WriteError(e2.ToString)
            End Try




            MsgBoxAlert("Error al importar esquema." & ex.ToString)


        End Try

    End Sub


    Protected Sub cmbFormato_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbFormato.TextChanged
        bEligioForzarFormato = True
        RefrescarTextosDefault()

        'TODO: Y acá tendría que llamar de nuevo a GetExcel y MostrarPrimerosDiezRenglones

    End Sub

    Sub RefrescarTextosDefault()
        PanelAnexo.Visible = False
        Select Case FormatoDelArchivo("", cmbFormato)
            Case BungeRamallo
                txtDestinatario.Text = "BUNGE ARGENTINA S.A."
                txtDestino.Text = "Ramallo - Bunge " '<<< no está en la base
            Case CargillPlantaQuebracho
                txtDestinatario.Text = "CARGILL S.A."
                txtDestino.Text = "EL QUEBRACHO ( CARGILL SA )"
            Case CargillPtaAlvear
                txtDestinatario.Text = "CARGILL S.A."
                txtDestino.Text = "Pta Alvear - Cargill "
            Case LDCGralLagos
                txtDestinatario.Text = "LDC ARGENTINA S.A."
                txtDestino.Text = "General Lagos - LDC Arg"      '<<< no está en la base
            Case LDCPlantaTimbues
                txtDestinatario.Text = "LDC ARGENTINA S.A."
                txtDestino.Text = "Dreyfus Pta Timbues"
            Case MuellePampa
                txtDestinatario.Text = "BUNGE ARGENTINA S.A."
                txtDestino.Text = "MUELLE PAMPA"
            Case Terminal6
                txtDestinatario.Text = "BUNGE ARGENTINA S.A." ' y Agd sa "
                txtDestino.Text = "TERMINAL 6"
            Case ToepferPtoElTransito
                txtDestinatario.Text = "ALFRED C. TOEPFER INT.  S.A."
                txtDestino.Text = "EL TRANSITO - ALFRED C TOEPFER"
            Case Toepfer
                txtDestinatario.Text = "ALFRED C. TOEPFER INT.  S.A."
                txtDestino.Text = "Arroyo Seco - Toepfer"
            Case VICENTIN
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11616
                'txtDestinatario.Text = "VICENTIN CEREALES S.A."
                txtDestino.Text = "FABRICA VICENTIN" 'y Fca Vicentin"

            Case Reyser
                'PanelAnexo.Visible = True
            Case ReyserAnalisis
        End Select

    End Sub


    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////

    Public Property m_IdMaestro() As Integer
        Get
            Return DirectCast(ViewState("IdMaestro"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdMaestro") = Value
        End Set
    End Property

    Public Property m_IdDetalle() As Integer
        Get
            Return DirectCast(ViewState("IdDetalle"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdDetalle") = Value
        End Set
    End Property


    Sub Permisos()

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "CDPs Importador")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            AsyncFileUpload1.Visible = False
            'lnkNuevo.Visible = False
        End If

        'If Not p("PuedeModificar") Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(
        '    GridView1.Columns(0).Visible = False
        'End If

        'If Not p("PuedeEliminar") Then
        '    'anular la columna de eliminar
        '    GridView1.Columns(7).Visible = False
        'End If

    End Sub


    



    


    ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
    'declare a variable to hold the CurrentCulture
    Dim oldCI As System.Globalization.CultureInfo

    'get the old CurrenCulture and set the new, en-US

    Private Sub SetNewCurrentCulture()

        oldCI = System.Threading.Thread.CurrentThread.CurrentCulture

        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-US")

    End Sub

    'reset Current Culture back to the originale

    Private Sub ResetCurrentCulture()

        System.Threading.Thread.CurrentThread.CurrentCulture = oldCI

    End Sub



    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub




    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////



    'linkbutton de descarga del encabezado 


    'subida de adjunto del encabezado








    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    Private Sub CopyColumns(ByRef source As Data.DataTable, ByRef dest As Data.DataTable, ByVal ParamArray columns() As String)
        For Each sourcerow As DataRow In source.Rows
            Dim destRow = dest.NewRow()
            For Each colname In columns
                destRow(colname) = sourcerow(colname)
            Next
            dest.Rows.Add(destRow)
        Next
    End Sub

    Private Sub CopyColumns(ByRef source As Data.DataTable, ByVal colorig As String, ByRef dest As Data.DataTable, ByVal coldest As String)
        For Each sourcerow As DataRow In source.Rows
            Dim destRow = dest.NewRow()
            destRow(coldest) = sourcerow(colorig)
            dest.Rows.Add(destRow)
        Next
    End Sub



    Function FormatearExcelImportado(Optional nombre As String = "") As Integer

        If nombre = "" Then nombre = Session("NombreArchivoSubido") 'DIRFTP + NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)

        If True Then

            Dim ff = FormatoDelArchivo(nombre, cmbFormato)
            Dim idm As Integer
            Dim texto As String
            Dim ret = FormatearExcelImportadoEnDLL(idm, nombre, ff, SC, cmbPuntoVenta.SelectedValue, texto, txtFechaArribo.Text, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))
            m_IdMaestro = idm
            txtLogErrores.Text = texto
            If texto <> "" Then txtLogErrores.Visible = True
            Return ret
        End If






        Dim ds As DataSet




        'http://stackoverflow.com/questions/938291/import-csv-file-into-c
        'http://stackoverflow.com/questions/938291/import-csv-file-into-c


        'Identificar el formato
        Select Case FormatoDelArchivo(nombre, cmbFormato)
            Case Nidera

                ds = NideraToDataset(nombre)

            Case CerealnetToepfer
                ds = ReyserToDataset(nombre)
            Case Reyser
                ds = ReyserToDataset(nombre)
            Case Reyser2
                ds = ReyserToDataset(nombre)

            Case ReyserAnalisis
                ds = ReyserCalidadesToDataset(nombre, SC, cmbPuntoVenta.SelectedValue, txtLogErrores.Text, txtFechaArribo.Text, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

                '/////////////////////
            Case Unidad6
                ds = Unidad6ToDataset_CUITTIT_CUITCORR_EstadoPosicion_NoEsDescarga_SeparadoConPuntoYComa(nombre)

            Case Unidad6Prefijo_NroCarta
                ds = Unidad6ToDatasetVersionAnteriorConTabsPlayaPerez_PREFIJO_NROCARTA(nombre)

            Case Unidad6Analisis
                ds = Unidad6CalidadesToDataset(nombre, SC, cmbPuntoVenta.SelectedValue, txtLogErrores.Text, txtFechaArribo.Text, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))



            Case PuertoACA
                'formato CSV
                ds = PuertoACAToDataset(nombre)
                'TODO: no muestra la vista previa si usa el formato de PuertoACA 


            Case AdmServPortuarios
                Return -1

            Case ToepferPtoElTransito
                ds = GetExcel(nombre, 3) 'hoja 3

            Case Toepfer
                ds = GetExcel(nombre, 1)

            Case CargillPlantaQuebracho, CargillPtaAlvear
                ds = GetExcel(nombre, 1) 'hoja 1

            Case Else
                ds = GetExcel(nombre)


        End Select


        If ds Is Nothing Then Return -1



        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////



        Dim dtOrigen = ds.Tables(0)

        Dim dtDestino As Data.DataTable = TablaFormato(SC)

        Dim row As DataRow




        'busco el renglon de titulos

        Dim renglonDeTitulos As Integer
        If FormatoDelArchivo(nombre, cmbFormato) = Unidad6 Then
            renglonDeTitulos = 0 'la pegatina de Unidad6 no tiene renglon de títulos
        Else
            renglonDeTitulos = RenglonTitulos(dtOrigen, nombre, FormatoDelArchivo("", cmbFormato))
        End If




        'Debug.Assert(renglonDeTitulos >= 0, "No se encontró el renglon de titulos de columnas")

        'creo espacio para los renglones
        For i = 1 To dtOrigen.Rows.Count
            dtDestino.Rows.Add(dtDestino.NewRow)
        Next




        row = dtOrigen.Rows(renglonDeTitulos)




        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        ' EXCEPCIONES preHermanado

        ExcepcionTerminal6_UnirColumnasConPatente(dtOrigen, renglonDeTitulos)



        'excepcion BUNGE / RAMALLO: calidades en minicolumnas improvisadas para cada renglon
        '-pero esto no tiene que estar en postproduccion, sino en preproduccion
        If FormatoDelArchivo(nombre, cmbFormato) = BungeRamallo Or FormatoDelArchivo(nombre, cmbFormato) = Unidad6Prefijo_NroCarta Then
            FormatearColumnasDeCalidadesRamallo(dtOrigen)
            'FormatearColumnasDeCalidadesRamallo()
        End If




        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        'HERMANADO
        'matchear las columnas en los renglones normales
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////

        Dim errorEncabezadoTag As String = ""

        Dim f = FormatoDelArchivo("", cmbFormato)

        For i = dtOrigen.Columns.Count - 1 To 0 Step -1

            Dim col = row.Item(i).ToString.ToUpper
            Dim coldest = HermanarLeyendaConColumna(col, nombre, i, f)
            If coldest <> "" Then

                For r = 0 To dtOrigen.Rows.Count - 1
                    dtDestino.Rows(r).Item(coldest) = dtOrigen.Rows(r).Item(i)
                    'Debug.Print(dtOrigen.Rows(r).Item(i), dtDestino.Rows(r).Item(coldest))
                Next

                'CopyColumns(dtOrigen, dtOrigen.Columns(i).ColumnName, dtDestino, coldest)
                'dtDestino(HermanarLeyendaConColumna(col)) = dtOrigen.Columns(col)

            Else
                errorEncabezadoTag &= "[" & col & "]"
            End If
        Next



        If errorEncabezadoTag <> "" Then
            ErrHandler2.WriteError("Los encabezados de columna " & errorEncabezadoTag & " no son reconocidos. " & _
                                  "Cambielos por los estándar. Ya ha sido enviado un mail notificando la incongruencia.")
        End If



        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        'Traigo los que se repiten en el encabezado
        'GUARDA!!! si lo haces despues de los renglones, podes llegar a pisar una columna que esté 
        'suelta y tambien en columnas
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////


        Dim fa = FormatoDelArchivo("", cmbFormato)

        For j = renglonDeTitulos - 1 To 0 Step -1
            row = dtOrigen.Rows(j)
            Debug.Print(row.Item("column1").ToString.ToUpper) 'Producto - >columna 1
            Dim col = Trim(row.Item("column1").ToString.ToUpper)

            Dim coldest = HermanarLeyendaConColumna(col, , , fa) 'cómo hago con el caso de "subcontratistas", que tiene 2 columnas de destino?

            If coldest = "Subcontratistas" Then

                For i = renglonDeTitulos + 1 To dtOrigen.Rows.Count - 1 'lo copio en todas las filas
                    If IsNull(dtDestino.Rows(i).Item("Subcontratista1")) Then
                        dtDestino.Rows(i).Item("Subcontratista1") = row.Item("column2").ToString 'Titular -> columna 2
                        dtDestino.Rows(i).Item("Subcontratista2") = row.Item("column2").ToString 'Titular -> columna 2
                    End If
                Next i

            Else

                If coldest <> "" Then

                    For i = renglonDeTitulos + 1 To dtOrigen.Rows.Count - 1 'lo copio en todas las filas
                        If IsNull(dtDestino.Rows(i).Item(coldest)) Then
                            dtDestino.Rows(i).Item(coldest) = row.Item("column2").ToString 'Titular -> columna 2
                        End If
                    Next i

                End If

            End If

        Next

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'EXCEPCIONES post produccion
        'Copia de celdas vacias con lo que dice la celda superior
        'Intuyo que todo procesamiento es mejor que venga despues del hermanado, y no antes.
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        'Excepcion de un caso raro...
        If InStr(nombre.ToUpper, "BUNGE") Or _
           InStr(nombre.ToUpper, "CARGILL") Then
            RellenarCeldaVaciaConCeldaSuperior(dtDestino)
        End If


        Select Case FormatoDelArchivo(nombre, cmbFormato)

            Case BungeRamallo
                'remapeos de clientes
                ReasignoTitularCOrdenETC(dtDestino)

            Case Nidera
                'remapeos de clientes
                ReasignoTitularCOrdenETC_Nidera(dtDestino)

            Case Reyser 'incluir las demás de cargill?  http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
                ReasignoExportacion_CerealnetParaCargill(dtDestino)
            Case Reyser2 'incluir las demás de cargill?  http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
                ReasignoExportacion_CerealnetParaReyser(dtDestino)
            Case Unidad6 'posicion, playa perez
                ReasignoExportacion_Unidad6PlayaPerez(dtDestino)

            Case CerealnetToepfer
                ReasignoExportacion_CerealnetParaToepfer(dtDestino)



            Case Else

        End Select



        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////

        'saco renglones sin numero de carta de porte
        Dim renglonesOriginales = dtDestino.Rows.Count


        For j = dtDestino.Rows.Count - 1 To 0 Step -1
            row = dtDestino.Rows(j)
            If IsDBNull(row.Item("NumeroCDP")) Then
                dtDestino.Rows.Remove(row)
                Continue For
            End If

            If Not IsNumeric(Replace(row.Item("NumeroCDP"), "-", "")) Then
                dtDestino.Rows.Remove(row)
            End If
        Next


        If dtDestino.Rows.Count = 0 Then
            ErrHandler2.WriteError("renglones antes de revisar numero de cartadeporte:" & renglonesOriginales & " Renglones despues:" & dtDestino.Rows.Count)

            If Debugger.IsAttached Then Stop
        End If
        'Debug.Assert(dtDestino.Rows.Count > 0, "Importacion vacía")




        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        'saco renglones que son de los colegas de Williams (excepto para NobleLima)

        Dim renglonesAntesDeFiltrarPorWilliams = dtDestino.Rows.Count

        If FormatoDelArchivo("", cmbFormato) <> NobleLima And FormatoDelArchivo("", cmbFormato) <> Renova Then

            For j = dtDestino.Rows.Count - 1 To 0 Step -1
                row = dtDestino.Rows(j)

                If IsDBNull(row.Item("EntregadorFiltrarPorWilliams")) Then
                    Continue For
                End If

                If row.Item("EntregadorFiltrarPorWilliams") = "" Then
                    Continue For
                End If

                If Not InStr(row.Item("EntregadorFiltrarPorWilliams").ToString.ToUpper, "WILLIAMS") > 0 And _
                    row.Item("EntregadorFiltrarPorWilliams").ToString.ToUpper <> "WE" Then
                    dtDestino.Rows.Remove(row)
                End If
            Next
        End If


        If dtDestino.Rows.Count = 0 Then
            ErrHandler2.WriteError("Filtrando renglones de colegas.  renglones antes de revisar numero de cartadeporte:" & renglonesAntesDeFiltrarPorWilliams & " Renglones despues:" & dtDestino.Rows.Count)

            If Debugger.IsAttached Then Stop
            'MsgBoxAjax(Me, "No se pudieron importar filas")
        End If


        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////


        'DatatableToViewstate(dtOrigen)




        Randomize()
        m_IdMaestro = Int(Rnd() * 200000) 'Guid.NewGuid().ToString())


        ExecDinamico(SC, String.Format("DELETE  ExcelImportador  WHERE {1}={0}", m_IdMaestro, "IdTanda"))
        '      ExcelImportadorManager.Delete(SC, m_IdMaestro)
        verificarQueNoSeRepiteElIdMaestro()




        Try
            GrabaExcelEnBase(dtDestino, SC, m_IdMaestro)

        Catch ex As Exception
            ErrHandler2.WriteError("Error al llamar GrabaExcelEnBase")
            ErrHandler2.WriteAndRaiseError(ex)
        End Try

        Return dtDestino.Rows.Count
        'gvExcel.DataSource = dtOrigen
        'gvExcel.DataBind()

        'gvClientes.DataSource = ds
        'gvClientes.DataBind()

    End Function










    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'casos especiales. pre hermanado
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'casos especiales: pos hermanado
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







    Function renglonControl(ByVal r As GridViewRow, ByVal sHeader As String) As WebControls.Label ' WebControls.TextBox
        If getGridIDcolbyHeader(sHeader, gvExcel) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvExcel)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, gvExcel) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvExcel)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvExcel)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function





    Protected Sub gvExcel_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvExcel.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            'Hago el bind de los controles para EDICION


            ac = e.Row.FindControl("AutoCompleteExtender1")
            If Not IsNothing(ac) Then ac.ContextKey = SC

            'End If



        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then


            'ac = e.Row.FindControl("AutoCompleteExtender7")
            'If Not IsNothing(ac) Then ac.ContextKey = SC

        End If
    End Sub




    Public Function ColorCode_CMBRET_SL(ByVal DataItem, ByVal d) As System.Drawing.Color
        'http://aspadvice.com/forums/thread/25659.aspx
        Dim cSL
        cSL = d

        If iisNull(cSL, 0) = -1 Then 'si no se intentó grabar todavía, es null. 
            'Return
            Return System.Drawing.Color.Red
        Else
            Return System.Drawing.Color.Transparent
        End If
    End Function

    Protected Sub txtBuscarCliente_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscarCliente.TextChanged
        'si le saco el viewstate al textbox, supongo que va a pasar por acá aún cuando
        'no hayan cambiado el texto (que es lo quiero)?
        'validar()
    End Sub


    Sub validar()





        'Dim dt = ViewstateToDatatable()
        Debug.Print("Validar()")

        Dim dt = TraerExcelDeBase(SC, m_IdMaestro)
        Dim row As Integer
        Dim col As String


        col = ViewState("Col")
        row = ViewState("Row")

        If col Is Nothing Then
            MsgBoxAjax(Me, "No hay errores")
            Exit Sub
        End If



        'Valido lo ingresado
        'If BuscaIdClientePreciso() Then

        'End If

        If txtBuscarCliente.Text = "" Then
            'el usuario decide saltear el campo invalido
            txtBuscarCliente.Text = "NO_VALIDAR"
        Else
            GrabarEquivalencia()
        End If




 
        '        _
        'URL:	/ProntoWeb/CartasDePorteImportador.aspx?Id=-1
        'User:   yburgos()
        '        Exception Type : System.IndexOutOfRangeException()
        'Message:	There is no row at position 68.
        'Stack Trace:	at System.Data.RBTree`1.GetNodeByIndex(Int32 userIndex)
        '        at CartasDePorteImportador.validar()
        'at CartasDePorteImportador.Button8_Click(Object sender, EventArgs e)
        'at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
        'at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
        'at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
        'at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
        'at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
        'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        'Server Error in '/' Application.

        'There is no row at position 68.

        Try
            dt.Rows(row).Item(col) = txtBuscarCliente.Text 'TODO: hacer un left 50???
        Catch ex As Exception
            MandarMailDeError(ex)
            MsgBoxAjax(Me, "Se llegó al final de la planilla.    " & ex.ToString)
        End Try





        'TO DO: el asunto de la comilla simple, no es tan simple como ponerle un replace("'","''")


        txtBuscarCliente.Text = ""

        'DatatableToViewstate(dt)


        proximoerror(dt)
        'col = GrabaRenglon(row)
        'If col = 0 Then
        '    ImportarCDPdeRenglon(row)
        '    row = row + 1
        'End If


        'ViewState("Col") = col
        'ViewState("Row") = row
        SetFocus(txtBuscarCliente)

    End Sub

    Sub proximoerror(ByVal dt As Data.DataTable)


        '        Log(Entry)
        '04/11/2012 09:07:11
        'Error in: http://pronto.williamsentregas.com.ar/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.Data.SqlClient.SqlException
        'Los datos de cadena o binarios se truncarían.
        'Se terminó la instrucción.
        '   at System.Data.Common.DbDataAdapter.UpdatedRowStatusErrors(RowUpdatedEventArgs rowUpdatedEvent, BatchCommandInfo[] batchCommands, Int32 commandCount)
        '   at System.Data.Common.DbDataAdapter.UpdatedRowStatus(RowUpdatedEventArgs rowUpdatedEvent, BatchCommandInfo[] batchCommands, Int32 commandCount)
        '   at System.Data.Common.DbDataAdapter.Update(DataRow[] dataRows, DataTableMapping tableMapping)
        '   at System.Data.Common.DbDataAdapter.UpdateFromDataTable(DataTable dataTable, DataTableMapping tableMapping)
        '   at System.Data.Common.DbDataAdapter.Update(DataTable dataTable)
        '   at ExcelImportadorManager.Update(String SC, DataTable dt)
        '   at CartasDePorteImportador.proximoerror(DataTable dt)
        '        at(CartasDePorteImportador.validar())
        '   at CartasDePorteImportador.Button8_Click(Object sender, EventArgs e)
        '   at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
        '   at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
        '   at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
        '   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
        '   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
        '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        '.Net SqlClient Data Provider


        'Dim dt = ExcelImportadorManager.TraerTanda(SC, m_IdMaestro)

        If dt.Rows.Count < 1 Then Exit Sub








        '//////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////
        'busca el primer error, empezando (incluso) por la casilla que se acaba de moficar
        Dim r As Integer, c As String
        r = ViewState("Row")
        Do
            'Debug.Print(dt.Rows(0).Item(0))


            Try

                '                quizas no está bien validado
                '                __________________________()

                '                Log(Entry)
                '07/16/2014 07:35:06
                'Error in: http://190.2.243.13/williamsdebug/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.ArgumentOutOfRangeException
                'Index and length must refer to a location within the string.
                '                Parameter(Name) : length()
                '   at System.String.InternalSubStringWithChecks(Int32 startIndex, Int32 length, Boolean fAlwaysCopy)
                '   at CartasDePorteImportador.NideraToDataset(String pFileName)
                '                mscorlib()
                '                __________________________()

                '                Log(Entry)
                '07/16/2014 07:35:06
                'Error in: http://190.2.243.13/williamsdebug/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:Los encabezados de columna [][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][] no son reconocidos. Cambielos por los estándar. Ya ha sido enviado un mail notificando la incongruencia.
                '                __________________________()

                '                Log(Entry)
                '07/16/2014 07:35:17
                'Error in: http://190.2.243.13/williamsdebug/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.NullReferenceException
                'Object reference not set to an instance of an object.
                '   at CartasDePorteImportador.GrabaRenglonEnTablaCDP(DataRow& dr)
                '   at CartasDePorteImportador.proximoerror(DataTable dt)
                'App_Web_cartasdeporteimportador.aspx.4199bbd4.htzdw4mf
                '                __________________________()

                '                Log(Entry)
                '07/16/2014 07:35:39
                'Error in: http://190.2.243.13/williamsdebug/ProntoWeb/CartasDePorteImportador.aspx?Id=-1. Error Message:System.NullReferenceException
                'Object reference not set to an instance of an object.
                '   at CartasDePorteImportador.GrabaRenglonEnTablaCDP(DataRow& dr)
                '   at CartasDePorteImportador.proximoerror(DataTable dt)
                'App_Web_cartasdeporteimportador.aspx.4199bbd4.htzdw4mf
                '                __________________________()


                c = GrabaRenglonEnTablaCDP(dt.Rows(r), SC, Session, txtDestinatario, txtDestino, chkAyer, txtLogErrores, cmbPuntoVenta, txtFechaArribo, cmbFormato, NoValidarColumnas) 'intenta grabar el renglon importado como una CDP





            Catch ex As Exception

                ErrHandler2.WriteError(ex)
                'quizás no se le puso el nombre del titular
                Dim sError = "Error paso 1: faltan datos? " & ex.Source
                ErrHandler2.WriteError(sError & " " & ex.ToString)

                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= sError & vbCrLf

                c = 0 'para que pase al renglon siguiente
            End Try

            If c = "0" Then
                If False Then
                    Dim sError = "Nuevo renglon" '"Carta grabada " & dt.Rows(r).Item("NumeroCDP")
                    txtLogErrores.Visible = True
                    txtLogErrores.Text &= sError & vbCrLf
                End If

                r = r + 1
            End If

        Loop While c = "0" And r < dt.Rows.Count
        '//////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////





        '//////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////
        If r < dt.Rows.Count Then
            'Encontró un error

            ViewState("Row") = r
            ViewState("Col") = c
            'm_IdMaestro = dt.rows(r).item("IdTanda")
            m_IdDetalle = dt.Rows(r).Item("IdExcelImportador")


            Dim dclone = dt.Clone 'hace solo las columnas
            dclone.ImportRow(dt.Rows(r))




            Try
                GrabaRenglonEnTablaBulk(dclone) 'graba el renglon modificado de excel en la base temporalmente


                If False Then

                    'si lo muestro así queda mal, lo repite por columna en la que me paseo
                    Dim sError = "Carta grabada " & dt.Rows(r).Item("NumeroCDP")
                    txtLogErrores.Visible = True
                    txtLogErrores.Text &= sError & vbCrLf
                End If



            Catch ex As Exception
                'La cuestion es aca. Consulta  http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8474

                '"centro de comercializacion de insumo" explota por lo largo? -síiiiiiii!!! y otros deben explotar por las comillas
                'se pasa de 50 caracteres. 


                ErrHandler2.WriteError(ex)
                Dim sError = "Error paso 2: " & ex.ToString
                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= sError & vbCrLf

                Exit Sub
            End Try




            'Try

            gvExcel.DataSource = dclone
            gvExcel.DataBind()
            'gvClientes.SelectedIndex = r
            'gvClientes.PageIndex = r
            Dim nombreColumna As String
            Select Case ViewState("Col")
                Case "column21"
                    nombreColumna = "Transportista"
                Case "column23"
                    nombreColumna = "Chofer"
                Case Else
                    nombreColumna = ViewState("Col")
            End Select

            lblUbicacion.Text = "Buscar equivalencia de " & nombreColumna & " en fila " & ViewState("Row") + 1 & "/" & dt.Rows.Count + 1
            lblPalabraNueva.Text = dt.Rows(ViewState("Row")).Item(ViewState("Col"))
            'lblUbicacion.Text = "Buscar equivalencia para " & dt.Rows(row).Item(col) & " de fila " & row & " la columna" & col
            MostrarAutocompleteCorrespondiente(c)

            'Catch ex As Exception
            '    ErrHandler2.WriteError(ex)
            '    Dim sError = "Error al pisar la equivalencia en la importacion 3: " & ex.ToString
            '    txtLogErrores.Visible = True
            '    If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
            '    txtLogErrores.Text &= sError & vbCrLf

            'End Try



        Else
            txtBuscarCliente.Enabled = False
            MsgBoxAjax(Me, "Se llegó al final de la planilla")
        End If







        'Dim row As Integer
        'Dim col As String
        'col = ViewState("Col")
        'row = ViewState("Row")
        'If NoValidarColumnas.Contains(col) Then
        '    If dt.Rows(row).Item(col) = "" Or True Then
        '        Debug.Print(dt.Rows(row).Item(col))
        '        dt.Rows(row).Item(col) = "NO_VALIDAR"
        '        proximoerror(dt)
        '    End If
        'End If




    End Sub



    Protected Sub btnEmpezarImportacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmpezarImportacion.Click
        Empezar()
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        validar() 'Guarda, que tambien lo llamas desde TextChanged y provoca un doble llamado
        ' a validar, haciendo que salte un campo
    End Sub

    Protected Sub btnSaltarTodos_Click(sender As Object, e As EventArgs) Handles btnSaltarTodos.Click
        Dim col = ViewState("Col")
        NoValidarColumnas.Add(col)
        validar()
    End Sub


    Sub MostrarAutocompleteCorrespondiente(ByVal col As String)

        acClientes.Enabled = False
        acVendedores.Enabled = False
        acLocalidades.Enabled = False
        acArticulos.Enabled = False
        acDestinos.Enabled = False
        acTransportistas.Enabled = False
        acChoferes.Enabled = False
        acCalidades.Enabled = False


        Select Case col
            Case "Producto" 'articulo
                acArticulos.Enabled = True
            Case "Corredor" 'corredor
                acVendedores.Enabled = True
            Case "Procedencia" 'localidades (origen)
                acLocalidades.Enabled = True
            Case "Destino" 'destinos
                acDestinos.Enabled = True
            Case "column21"
                acTransportistas.Enabled = True
            Case "column23"
                acChoferes.Enabled = True
            Case "Calidad"
                acCalidades.Enabled = True
            Case Else
                acClientes.Enabled = True
        End Select

    End Sub



    Sub GrabarEquivalencia()
        If lblPalabraNueva.Text = "" Then Exit Sub

        
        Dim dt As Data.DataTable
        Try


            dt = DiccionarioEquivalenciasManager.TraerMetadata(HFSC.Value, lblPalabraNueva.Text)

        Catch ex As Exception
            ErrHandler2.WriteError("Error en GrabarEquivalencia: " + lblPalabraNueva.Text)
            ErrHandler2.WriteError(ex)
            MandarMailDeError("Error en GrabarEquivalencia: " + lblPalabraNueva.Text + " " + ex.ToString)

            '            mcamacho()
            '            Exception(Type) : System.Data.SqlClient.SqlException()
            'Message:	Line 1: Incorrect syntax near 'Anna'. Unclosed quotation mark before the character string ''.
            'Stack Trace:	 at Microsoft.VisualBasic.CompilerServices.Symbols.Container.InvokeMethod(Method TargetProcedure, Object[] Arguments, Boolean[] CopyBack, BindingFlags Flags)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.CallMethod(Container BaseReference, String MethodName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, BindingFlags InvocationFlags, Boolean ReportErrors, ResolutionFailure& Failure)
            'at Microsoft.VisualBasic.CompilerServices.NewLateBinding.LateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)
            'at Pronto.ERP.Dal.GeneralDB.ExecDinamico(String SC, String comandoSQLdinamico, Int32 timeoutSegundos) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 300
            'at Pronto.ERP.Bll.EntidadManager.ExecDinamico(String SC, String sComandoDinamico, Int32 timeoutSegundos) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 316
            'at Pronto.ERP.Bll.DiccionarioEquivalenciasManager.TraerMetadata(String SC, String Descripcion) in C:\Backup\BDL\BussinessLogic\DiccionarioEquivalenciaManager.vb:line 62

            Exit Sub
        End Try


        Dim dr As DataRow




        If dt.Rows.Count = 0 Then
            dr = dt.NewRow
        Else
            dr = dt.Rows(0)
        End If

        dr.Item("Palabra") = lblPalabraNueva.Text
        dr.Item("Traduccion") = txtBuscarCliente.Text
        dr.Item("Tabla") = ""


        If dt.Rows.Count = 0 Then
            dt.Rows.Add(dr)
            DiccionarioEquivalenciasManager.Insert(HFSC.Value, dt)
        Else
            DiccionarioEquivalenciasManager.Update(HFSC.Value, dt)
        End If

    End Sub






    Sub Empezar()

        NoValidarColumnas = New List(Of String)

        lblVistaPrevia.Visible = False
        panelEquivalencias.Visible = True
        btnEmpezarImportacion.Visible = False
        gvExcel.PageSize = 1
        ViewState("Row") = 0

        gvExcel.DataBind() 'para que no ocupe 5 renglones toda la pantalla si llega al final de la planilla sin encontrar errores

        proximoerror(TraerExcelDeBase(SC, m_IdMaestro))

    End Sub

    Sub MostrarPrimerosDiezRenglones()
        Dim nombre = Session("NombreArchivoSubido")  ' NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
        FormatoDelArchivo(nombre, cmbFormato)

        Dim N = 6
        gvExcel.PageSize = N
        gvExcel.DataSource = GetTopN(TraerExcelDeBase(SC, m_IdMaestro), N)  'GetTopN???? -Pagina el dataset. Como no pone Start, es como un TOP (en .NET, no en SQL, es decir, es lento)
        gvExcel.DataBind()
        lblVistaPrevia.Visible = True
    End Sub



    Function GetTopN(ByVal dt As Data.DataTable, ByVal RowCount As Integer, Optional ByVal Start As Integer = 0) As Data.DataTable
        'GetTopN???? -Pagina el dataset. Como no pone Start, es como un TOP (en .NET, no en SQL, es decir, es lento)
        Dim table As Data.DataTable
        table = dt.Clone()
        For i = Start To Start + RowCount - 1
            If (i >= dt.Rows.Count) Then
                Exit For
            Else
                table.ImportRow(dt.Rows(i))
            End If
        Next

        Return table
    End Function












    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////








    Function GrabaRenglonEnTablaBulk(ByVal dtExcel As Data.DataTable)

        'Dim dtBase = ExcelImportadorManager.TraerMetadataPorIdDetalle(SC, dtExcel.Rows(0).Item("IdExcelImportador"))

        'Dim drBase As Data.DataRow = dtBase.Rows(0)
        ''For Each dr As DataRow In dtBase.Rows
        ''    If dr.Item("IdExcelImportador") = dtExcel.Rows(0).Item("IdExcelImportador") Then
        ''        drBase = dr
        ''        Exit For
        ''    End If
        ''Next

        'If drBase Is Nothing Then Exit Function

        'For c As Integer = 0 To dtExcel.Columns.Count - 1
        '    Try
        '        drBase("Excel" & (c + 1)) = dtExcel.Rows(0).Item(c)
        '    Catch ex As Exception

        '    End Try
        'Next

        ExcelImportadorManager.Update(SC, dtExcel)

    End Function






    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////

    Private Sub ReasignoExportacion_ReyserParaReyser(dtDestino As Data.DataTable)
        Throw New NotImplementedException
    End Sub











    
End Class











