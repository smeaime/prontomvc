﻿Imports System
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

Imports System.Linq


Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging

Imports ExcelImportadorManager

Imports CartaDePorteManager

Imports FertilizanteManager

Imports LogicaImportador
Imports LogicaImportador.FormatosDeExcel


Partial Class FertilizanteImportador

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
            panelEquivalencias.Visible = False
            txtFechaArribo.Visible = True


            NoValidarColumnas = New List(Of String)

            cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
            'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
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

        acClientes.ContextKey = SC
        acVendedores.ContextKey = SC
        acLocalidades.ContextKey = SC
        acArticulos.ContextKey = SC
        acDestinos.ContextKey = SC
        acTransportistas.ContextKey = SC
        acChoferes.ContextKey = SC
        acCalidades.ContextKey = SC



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

                'If Not bEligioForzarFormato Then FormatoDelArchivoFertilizantes(nombrenuevo) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
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

                If FormatoDelArchivoFertilizantes(Session("NombreArchivoSubido").ToString, cmbFormato) = ReyserAnalisis Then Exit Sub
                If FormatoDelArchivoFertilizantes(Session("NombreArchivoSubido").ToString, cmbFormato) = Unidad6Analisis Then Exit Sub

                btnEmpezarImportacion.Visible = True
                txtBuscarCliente.Enabled = True

                txtFechaArribo.Visible = True
                panelEquivalencias.Visible = False
                txtLogErrores.Visible = False
                txtLogErrores.Text = ""

                If Not bEligioForzarFormato Then FormatoDelArchivoFertilizantes(nombrenuevo, cmbFormato) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
                RefrescarTextosDefault()

            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

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
                '   at CartasDePorteImportador.FormatoDelArchivoFertilizantes(String sNombreArchivoImportado)
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



                If FormatoDelArchivoFertilizantes(Session("NombreArchivoSubido").ToString, cmbFormato) = ReyserAnalisis Then Exit Sub
                If FormatoDelArchivoFertilizantes(Session("NombreArchivoSubido").ToString, cmbFormato) = Unidad6Analisis Then Exit Sub

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
        Select Case FormatoDelArchivoFertilizantes("", cmbFormato)


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


    Const MAXFILAS = 150
    Const MAXCOLS As Integer = 53 ' 35  'oSheet.UsedRange.Cells.Columns.Count

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





    'conversion extraña de rtf a texto http://stackoverflow.com/questions/595865/get-plain-text-from-an-rtf-text
    Function ConvertRtfToText(rtf As String) As String
        Using rtb = New System.Windows.Forms.RichTextBox()
            rtb.Rtf = rtf
            Return rtb.Text
        End Using
    End Function



    Function CodigoCalidad(cal As Long) As String
        'transformar columna de calidad
        '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE

        'aca tenemos el problema de la 9877  
        'DARI, CARGILL SIGUE IGUAL. LAS CALIDADES DE MAIZ, ME LAS SIGUE PEGANDO MAL, C/C COMO GRADO 3 Y GRADO 1 COMO C/C.
        ' ellos esperarian 2 = G1   y 5=CC

        '            [01:30:42 p.m.] andres gurisatti: De: Diego Magnaterra [mailto:diegom@cerealnet.com] 
        'Enviado el: miércoles, 24 de abril de 2013 13:06
        'Para:       Andrés(Gurisatti)
        'Asunto:     Re() : Sincronismo(Cargill)

        'Hola Andres la tabla de calidad es la siguiente
        '1:          CONFORME(CO)
        '2 GRADO 1 G1
        '3 GRADO 2 G2
        '4 GRADO 3 G3
        '5:          CONDICIONAL(CC)
        '6 FUERA DE ESTANDAR FE
        'Perdona si te la pase mal la otra vez


        Select Case cal
            Case 1
                Return "CO"
            Case 2
                Return "G1"
            Case 3
                Return "G2"
            Case 4
                Return "G3"
            Case 5
                Return "CC"
            Case 6
                Return "FE"
            Case Else
                Return "  "
        End Select
        Return "  "
    End Function






    Public Function GetExcel(ByVal fileName As String, Optional ByVal SheetNumero As Integer = 1) As DataSet
        'traido de http://www.devcurry.com/2009/07/import-excel-data-into-aspnet-gridview_06.html


        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml
        'En lugar de usar el Interop como hago acá, podría usar el odbc que uso en ExcelToHtml



        Dim oXL As Application
        Dim oWB As Workbook
        Dim oSheet As Worksheet
        Dim oRng As Range
        Dim oWBs As Workbooks

        Try
            '  creat a Application object
            oXL = New ApplicationClass()
            '   get   WorkBook  object
            oWBs = oXL.Workbooks


            Try
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                'si salta un msgbox de seguridad en el servidor, la sesion del usuario se colgará
                oWB = oWBs.Open(fileName, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
    Missing.Value, Missing.Value)
            Catch ex As Exception

                'problemas al abrir T6

                ' http://www.made4dotnet.com/Default.aspx?tabid=141&aid=15
                'http://stackoverflow.com/questions/493178/excel-programming-exception-from-hresult-0x800a03ec-at-microsoft-office-inter


                '  Otro  problema mas con T6!!!!!!!
                'importacion de excel de Terminal6 hace tildar el sitio. Office automation, macros.....  
                '-Había un vinculo a "Camiones demorados.xls". Era eso? -es que eso lo revisa por la seguridad...  -Podes reemplazar el GetExcel????




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

                ErrHandler2.WriteError("No pudo extraer el excel. INCREIBLE: en 2008, en el directorio  C:\Windows\SysWOW64\config\systemprofile\ hay que crear una carpeta Desktop!!!!!!!!!!!!!!!!!!!!!  " + ex.ToString)


            End Try

            'dejé de usar .Sheets
            oSheet = CType(oWB.Worksheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
            '   get   WorkSheet object
            'Try
            '    'dejé de usar .Sheets 'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Sheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
            'Catch ex As Exception
            '    'http://stackoverflow.com/questions/2695229/why-cant-set-cast-an-object-from-excel-interop
            '    oSheet = CType(oWB.Worksheets(SheetNumero), Microsoft.Office.Interop.Excel.Worksheet)
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
                    oRng = CType(oSheet.Cells(i, j), Microsoft.Office.Interop.Excel.Range)



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


    Function TablaFormato() As Data.DataTable
        Dim dt As New System.Data.DataTable("dtExcel")
        'dt.Columns.Add("Estado", System.Type.GetType("System.String")) 'para el check
        'dt.Columns.Add("check1", System.Type.GetType("System.String")) 'para el check
        'dt.Columns.Add("URLgenerada", System.Type.GetType("System.String")) 'para el check

        'dt.Columns.Add("IdTitular", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdIntermediario", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdRComercial", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdCorredor", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdDestinatario", System.Type.GetType("System.Int32")) 'para el color de validacion
        'dt.Columns.Add("IdChofer", System.Type.GetType("System.Int32")) 'para el color de validacion

        'dt.Columns.Add("Producto", System.Type.GetType("System.String"))
        'dt.Columns.Add("Titular", System.Type.GetType("System.String"))
        'dt.Columns.Add("Intermediario", System.Type.GetType("System.String"))
        'dt.Columns.Add("RComercial", System.Type.GetType("System.String"))
        'dt.Columns.Add("Corredor", System.Type.GetType("System.String"))

        'dt.Columns.Add("Procedencia", System.Type.GetType("System.String"))
        'dt.Columns.Add("NumeroCDP", System.Type.GetType("System.String"))
        'dt.Columns.Add("Patente", System.Type.GetType("System.String"))
        'dt.Columns.Add("Acoplado", System.Type.GetType("System.String"))
        'dt.Columns.Add("NetoProc", System.Type.GetType("System.String"))
        'dt.Columns.Add("Calidad", System.Type.GetType("System.String"))

        'dt.Columns.Add("column12", System.Type.GetType("System.String"))
        'dt.Columns.Add("column13", System.Type.GetType("System.String"))
        'dt.Columns.Add("column14", System.Type.GetType("System.String"))
        'dt.Columns.Add("column15", System.Type.GetType("System.String"))
        'dt.Columns.Add("column16", System.Type.GetType("System.String"))
        'dt.Columns.Add("column17", System.Type.GetType("System.String"))
        'dt.Columns.Add("column18", System.Type.GetType("System.String"))
        'dt.Columns.Add("column19", System.Type.GetType("System.String"))
        'dt.Columns.Add("column20", System.Type.GetType("System.String"))
        'dt.Columns.Add("column21", System.Type.GetType("System.String"))
        'dt.Columns.Add("column22", System.Type.GetType("System.String"))
        'dt.Columns.Add("column23", System.Type.GetType("System.String"))
        'dt.Columns.Add("column24", System.Type.GetType("System.String"))
        'dt.Columns.Add("column25", System.Type.GetType("System.String"))


        'dt.Columns.Add("Comprador") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Destino") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Subcontratista1") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("Subcontratista2") 'por si no esta macheada y hay que porlotanto crearla
        'dt.Columns.Add("FechaDescarga")
        'dt.Columns.Add("Hora")


        'dt.Columns.Add("IdExcelImportador", System.Type.GetType("System.Int32"))



        Return ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, -1)
    End Function

    Function FormatearExcelImportado() As Integer



        Dim nombre = Session("NombreArchivoSubido")  'DIRFTP + NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)

        Dim ds As DataSet




        'http://stackoverflow.com/questions/938291/import-csv-file-into-c
        'http://stackoverflow.com/questions/938291/import-csv-file-into-c


        'Identificar el formato

        Select Case FormatoDelArchivoFertilizantes(nombre, cmbFormato)



            '/////////////////////
            Case FormatosDeExcelFertilizantes.Autodetectar
                ds = GetExcel(nombre)
            Case FormatosDeExcelFertilizantes.Moviport
                ds = GetExcel(nombre)
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

        Dim dtDestino As Data.DataTable = TablaFormato()

        Dim row As DataRow




        'busco el renglon de titulos

        Dim renglonDeTitulos As Integer
        If FormatoDelArchivoFertilizantes(nombre, cmbFormato) = Unidad6 Then
            renglonDeTitulos = 0 'la pegatina de Unidad6 no tiene renglon de títulos
        Else
            renglonDeTitulos = RenglonTitulos(dtOrigen, nombre, FormatoDelArchivoFertilizantes("", cmbFormato))
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
        If FormatoDelArchivoFertilizantes(nombre, cmbFormato) = BungeRamallo Or FormatoDelArchivoFertilizantes(nombre, cmbFormato) = Unidad6Prefijo_NroCarta Then
            FormatearColumnasDeCalidadesRamallo(dtOrigen)
            'FormatearColumnasDeCalidadesRamallo()
        End If



        dtOrigen.Rows(2).Item(22) = "% PRODUCTO 1"
        dtOrigen.Rows(2).Item(24) = "% PRODUCTO 2"
        dtOrigen.Rows(2).Item(26) = "% PRODUCTO 3"
        dtOrigen.Rows(2).Item(28) = "% PRODUCTO 4"



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

        Dim f = FormatoDelArchivoFertilizantes("", cmbFormato)

        For i = dtOrigen.Columns.Count - 1 To 0 Step -1

            Dim col = row.Item(i).ToString.ToUpper
            Dim coldest = FertilizanteManager.HermanarLeyendaConColumna(col, nombre, i, f)
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


        Dim fa = FormatoDelArchivoFertilizantes("", cmbFormato)

        For j = renglonDeTitulos - 1 To 0 Step -1
            row = dtOrigen.Rows(j)
            Debug.Print(row.Item("column1").ToString.ToUpper) 'Producto - >columna 1
            Dim col = Trim(row.Item("column1").ToString.ToUpper)

            Dim coldest = FertilizanteManager.HermanarLeyendaConColumna(col, , , fa) 'cómo hago con el caso de "subcontratistas", que tiene 2 columnas de destino?

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


        Select Case FormatoDelArchivoFertilizantes(nombre, cmbFormato)

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

        Dim rgx As New Regex("[a-zA-Z ]")

        For j = dtDestino.Rows.Count - 1 To 0 Step -1
            row = dtDestino.Rows(j)
            If IsDBNull(row.Item("NumeroCDP")) Then
                dtDestino.Rows.Remove(row)
                Continue For
            End If

            Try
                Dim aa = Replace(row.Item("NumeroCDP"), "-", "")
                If aa Is Nothing Then aa = ""

                Dim wordy As String = rgx.Replace(aa, "")

                If Val(wordy) = 0 Then
                    dtDestino.Rows.Remove(row)
                End If

            Catch ex As Exception

            End Try

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

        If FormatoDelArchivoFertilizantes("", cmbFormato) <> NobleLima And FormatoDelArchivoFertilizantes("", cmbFormato) <> Renova Then

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
            GrabaExcelEnBase(dtDestino)

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


    Sub verificarQueNoSeRepiteElIdMaestro()

    End Sub








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



    Sub FormatearColumnasDeCalidadesRamallo(ByRef dt As Data.DataTable)


        'excepcion BUNGE / RAMALLO: calidades en minicolumnas improvisadas para cada renglon
        '-pero esto no tiene que estar en postproduccion, sino en preproduccion

        '        HUMEDAD()
        'MERMA X HUMEDAD
        '        OTRAS(MERMAS)
        '        OBSERVACIONES()

        'tener en cuenta que en la columna de merma del exel el primer numero es la MERMA X HUMEDAD / las otras 2 sumadas van en OTRAS MERMAS
        '        ssss()






        'en efecto, estás harcodeando el numero de columna....

        Dim columnamerma As Integer = 16 '15
        Dim colHumedad As Integer = 17 ' 16
        Dim colRubros As Integer = 21 '17
        'no tengo manera de saber donde empiezan los rubros/calidades: en la nueva vienen en la columna "V", antes 


        For c = 0 To dt.Columns.Count - 1 'empiezo en 2 para no pisar los encabezados... .no sé en qué renglon vendran
            Dim nomb = dt.Rows(1).Item(c).ToUpper.Trim   'dt.Columns(c).ColumnName.ToUpper.Trim

            'If nomb = "MMA" Then columnamerma = c
            If nomb = "HUM" Then
                colHumedad = c
            End If

            'If nomb = "HUM" Then colRubros = c
        Next





        dt.Columns.Add("MERMAXHUMEDAD")
        dt.Rows(0).Item("MERMAXHUMEDAD") = "MERMA"
        dt.Rows(1).Item("MERMAXHUMEDAD") = "MERMA"

        dt.Columns.Add("OBSERVACIONES")
        dt.Rows(0).Item("OBSERVACIONES") = "OBSERVACIONES"
        dt.Rows(1).Item("OBSERVACIONES") = "OBSERVACIONES"

        dt.Columns.Add("OTRASMERMAS")
        dt.Rows(0).Item("OTRASMERMAS") = "OTRASMERMAS"
        dt.Rows(1).Item("OTRASMERMAS") = "OTRASMERMAS"

        'ahora, los de Bunge no juntan más en la columna de mermas (usando una "/") las distintas mermas. ahora solo ponen
        'un numero en esa columna, y la merma de los rubros la ponen en una columna adyacente a cada rubro.


        Dim mermaxhumedad As Long
        Dim otrasmermas As Long

        For r = 2 To dt.Rows.Count - 1 'empiezo en 2 para no pisar los encabezados... .no sé en qué renglon vendran

            Dim dr As DataRow = dt.Rows(r)


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'este era el metodo para cuando nos daban las calidades ensanguchadas en una columna

            Dim celdamerma As String = dr.Item(columnamerma)
            Try
                mermaxhumedad = 0
                otrasmermas = 0
                Dim mermas() = Split(celdamerma, "/")
                If mermas.Length > 0 Then mermaxhumedad = Val(mermas(0))
                If mermas.Length > 1 Then
                    otrasmermas = Val(mermas(1))
                End If
                If mermas.Length > 2 Then
                    otrasmermas = Val(mermas(1)) + Val(mermas(2))
                End If
                dr.Item(columnamerma) = mermaxhumedad
                'tengo que agregar otra columna en el importador para las "otras mermas"
                dr.Item("MERMAXHUMEDAD") = mermaxhumedad
                dr.Item("OTRASMERMAS") = otrasmermas
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try



            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'este es el nuevo metodo, donde las calidades tienen 2 columnas cada una (la primera su nombre y %, la segunda su merma)




            Dim obs As String = ""
            Dim otrasmermascalc As Long = 0
            For c = colRubros To colRubros + 10 Step 2

                Try
                    obs &= dr.Item(c).ToString & " "
                    '                    http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9841
                    '                    Lo que debe ir en observaciones es la concatenación de las tres columnas de rubros, por ejemplo:

                    'HUM 14,50	C.Ex. 01,50	Rev 00,50
                Catch ex As Exception

                End Try

                Try


                    Dim celda As String = dr.Item(c)
                    Dim pos As Integer = InStr(celda.ToUpper, "HUM ") '    DyR  / Gr.Amoh / Rev / C.Ex.
                    If pos > 0 Then
                        Dim calidad As Double = Val(Mid(celda, pos + 3).Replace(",", "."))

                        ' dr.Item("HUMEDAD") = calidad
                        dr.Item(colHumedad) = calidad

                        'todo bien
                        'salvo que no se trae el "15.00" de la humedad -quizás ya hay una columna con el encabezado "humedad"
                    Else
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10066
                        '* Cuando el registro tiene solamente otras mermas (por ejemplo tiene un numero en MMA y en Rubros
                        ' dice \"C.Ex. 09,00\") los kg de merma, que vienen en MMA deben ir a otras mermas y están yendo a Mermas Por Humedad
                        otrasmermascalc += Val(dr.Item(c + 1))
                    End If



                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

            Next

            If otrasmermascalc > 0 Then
                dr.Item("OTRASMERMAS") = otrasmermascalc
            End If




            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10066
            '* Cuando el registro tiene solamente otras mermas (por ejemplo tiene un numero en MMA y en Rubros
            ' dice \"C.Ex. 09,00\") los kg de merma, que vienen en MMA deben ir a otras mermas y están yendo a Mermas Por Humedad
            If dr.Item(colHumedad) = "" And otrasmermas = 0 Then
                dr.Item(columnamerma) = 0
                dr.Item("MERMAXHUMEDAD") = 0
                dr.Item("OTRASMERMAS") = mermaxhumedad
            End If



            dr.Item("OBSERVACIONES") = Left(obs, 49)








        Next



        'tengo que borrar los títulos "MMA" porque si no, los toma en la mermas por humedad cuando saliendo de esta funcion hace el hermanado
        For c = colRubros To colRubros + 10
            dt.Rows(1).Item(c) = ""
        Next



    End Sub

    Sub ExcepcionTerminal6_UnirColumnasConPatente(ByRef dt As Data.DataTable, ByVal renglontitulos As Integer)
        Try
            Dim PATEcol = -1, NTEcol As Integer

            For c = 0 To dt.Columns.Count - 1 'me paseo por todas las columnas ....
                If iisNull(dt.Rows(renglontitulos).Item(c), "") = "Pate" Then
                    PATEcol = c
                    NTEcol = c + 1
                    Exit For
                End If
            Next

            If PATEcol = -1 Then Exit Sub

            For Each r In dt.Rows
                r.item(PATEcol) &= r.item(NTEcol)
            Next

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
    End Sub



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



    Sub RellenarCeldaVaciaConCeldaSuperior(ByRef dt As Data.DataTable)
        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            If IsDBNull(dt.Rows(r).Item("NumeroCDP")) Then
                Continue For 'en caso de que no haya numero de CDP, voy al siguiente renglon
            End If

            For c = 0 To dt.Columns.Count - 1 'me paseo por todas las columnas ....
                If dt.Columns(c).ColumnName = "NumeroCDP" Then Continue For '... salvo la de CDP


                If iisNull(dt.Rows(r + 1).Item(c)) = """" Then
                    'si la celda esta vacía o tiene una comilla doble ("), le pego la de arriba
                    Debug.Print(dt.Columns(c).ColumnName)
                    If dt.Columns(c).ColumnName = "column15" Then
                        Debug.Print(dt.Rows(r).Item(c))
                        If Debugger.IsAttached Then Stop 'columna de humedad
                    End If

                    dt.Rows(r + 1).Item(c) = dt.Rows(r).Item(c)
                End If
            Next

        Next
    End Sub




    Sub ReasignoTitularCOrdenETC(ByRef dt As Data.DataTable)


        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
        'cargador ----> titular
        'vendedor ----> remitcomer	14/3/2014		
        'Mariano	andy, tengo en el codigo especificamente para Bunge este mapeo
        '"CARGADOR" ----> Intermediario 
        '"C/ORDEN 1" -----> RComercial
        'q hacemos con eso?	14/3/2014		
        'Andres	Debería quedar asi:

        'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, INTERMEDIARIO
        'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO
        'Si viene solo Vendedor (ni Cargador ni Cuenta Orden 1), ponerlo como Titular. Intermediario y Rte Comercial deben quedar vacios.



        '////////////////////////////////////////////////////////////////////////////////////////////////////////////



        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13427
        '        Paso a detallar como tendría que pegar la posición y la descarga de bunge ramallo, ya que últimamente no esta pegando como corresponde.
        '        CARGADOR: Para nosotros es TITULAR, (pero cuando esta vació en la planilla, el titular seria el vendedor) 
        '        VENDEDOR: Para nosotros REMITENTE, (pero cuando el cargador esta vació, EL VENDEDOR, seria el TITULAR; en el caso que haya cargador y vendedor, seria, cargador =TITULAR, vendedor= REMITENTE) 
        '        C/ ORDEN 1: Para nosotros seria el INTERMEDIARIO

        'CALIDAD:
        '        HUMEDAD: en el caso de que tenga, tendría que pegarla en el cuadradito donde dice HUMEDAD, tire o no tire merma, las tiene que pegar si o si.
        '        MERMA POR HUMEDAD: iría pegada en el cuadratiro de al lado de la humedad 
        '        MERMAS POR OTRAS COSAS: TENDRÍA QUE PEGARLA EN EL CUADRADITO DE OTRAS MERMAS

        '        SI TIENE HUMEDAD Y CUERPO EXTRAÑO (EJEMPLO) LAS MERMAS TENDRÍAN QUE IR PEGADAS AMBAS EN SU LUGAR CORRESPONDIENTE.






        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            Dim dr = dt.Rows(r)

            Dim cargador, vendedor, corden1 As String

            cargador = dr.Item("Titular").ToString.Trim
            vendedor = dr.Item("Intermediario").ToString.Trim
            corden1 = dr.Item("RComercial").ToString.Trim

            Dim titular, intermediario, remitente As String


            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11790

            If corden1 <> "" And vendedor <> "" And cargador <> "" Then
                'CUANDO HAY CARGADOR, VENDEDOR Y C/ORDEN -> TITULAR, REMITENTE E INTERMEDIARIO
                titular = cargador
                intermediario = corden1
                remitente = vendedor
            ElseIf corden1 = "" And vendedor <> "" And cargador <> "" Then
                'CUANDO HAY CARGADOR Y VENDEDOR -> TITULAR, RTE COMERCIAL
                titular = cargador
                intermediario = ""
                remitente = vendedor
            ElseIf corden1 = "" And vendedor <> "" And cargador = "" Then
                'Si viene solo Vendedor (ni Cargador ni Cuenta Orden 1), ponerlo como Titular. Intermediario y Rte Comercial deben quedar vacios.
                titular = vendedor
                intermediario = ""
                remitente = ""
            Else
                'si viene solo el cargador, es el titular
                titular = cargador
                intermediario = ""
                remitente = ""
            End If

            If False Then
                titular = IIf(dr.Item("Titular").ToString.Trim = "", dr.Item("Intermediario").ToString, dr.Item("Titular").ToString)
                intermediario = IIf(dr.Item("RComercial").ToString.Trim = "" And dr.Item("Titular").ToString.Trim <> "", dr.Item("Intermediario").ToString, dr.Item("RComercial").ToString)
                remitente = IIf(dr.Item("RComercial").ToString.Trim = "", "", dr.Item("Intermediario").ToString)
            End If

            dr.Item("Titular") = titular
            dr.Item("Intermediario") = intermediario
            dr.Item("RComercial") = remitente





        Next
    End Sub


    Sub ReasignoExportacion_CerealnetParaReyser(ByRef dt As Data.DataTable)


        'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14830

        '            ANDRES, BUENAS TARDES
        'TE PASO LOS ARCHIVOS QUE IMPORTAMOS DE REYSER GRAL LAGOS, EL ARCHIVO QUE IMPORTAMOS ES EL POSI19.TXT PARA LA POSICION Y PARA LA DESCARGA ES EL DESACAR19.TXT.
        'ES EL MISMO SISTEMA QUE CARGILL PTA ALVEAR. NO HAY QUE MODIFICAR NADA SOLAMENTE LOS PUNTOS QUE TE ACLARO A CONTINUACION.


        'AHORA BIEN HAY QUE MODIFICAR LO SIGUIENTE.

        '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

        '* Y LOS SIGUIENTES DESTINATARIOS LOS TIENE QUE PEGAR CON EL TILDE DE EXPORTACION: (SOLAMENTE LOS DE ESTA LISTA)

        '            AMAGGI EXPORT
        '            MULTIGRAIN ARG
        '            CURCIJA SA
        'LOS GROBO AGROP
        '            ANDREOLI SA
        'E-GRAIN SA
        '            BASF ARG
        '            CRESUD SA
        'DIAZ & FORTI
        '            ILLINOIS()
        'QUEBRACHITO GRANOS SA
        'FONDOMONTE SOUTH AMERICA SA

        'AGUARDO TU COMENTARIO Y LO NECESITAMOS CON URGENCIA
        '            SALUDOS()



        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim


            If destinatario.Contains("AMAGGI EXPORT") _
                Or destinatario.Contains("MULTIGRAIN") _
                Or destinatario.Contains("CURCIJA") _
                Or destinatario.Contains("LOS GROBO AGROP") _
                Or destinatario.Contains("E-GRAIN") _
                Or destinatario.Contains("BASF ARG") _
                Or destinatario.Contains("CRESUD") _
                Or destinatario.Contains("DIAZ & FORTI") _
                Or destinatario.Contains("ILLINOIS") _
                Or destinatario.Contains("QUEBRACHITO GRANOS") _
                Or destinatario.Contains("ILLINOIS") _
                Or destinatario.Contains("FONDOMONTE SOUTH AMERICA SA") _
                Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            Else
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If


            '* TODO LO QUE ES DESTINATARIO LDC ARGENTINA , TIENE QUE PEGAR SIN EL TILDE DE EXPORTACION (ES ENTREGA)

            If destinatario.Contains("LDC ARGENTINA") Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If

            'TE AGREGO UN DATO MAS , CUANDO ES DESTINATARIO CHS , NO TIENE QUE PEGAR EL CAMION
            If destinatario.Contains("CHS") Then dr.Item("NumeroCDP") = ""

        Next



    End Sub


    Sub ReasignoExportacion_CerealnetParaCargill(ByRef dt As Data.DataTable)
        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13055


        '        Cuando el destinatario no sea Cargill, automáticamente que le ponga el tilde de exportación.
        'Ejemplo LDC (adjunto archivos para que pruebes)

        '* El tilde de exportación tiene que ir en la original cuando no es destinatario Cargill : EJ LDC (ver archivos)

        '* No completa los datos de la solapa descarga , queda vacío y tiene que completar todo.

        '* cuando duplica una ccpp tiene que ser igual a la original sin el tilde de exportación. 

        'TODO ESTO ES PARA LA DESCARGA , LOS ARCHIVOS SON DESCAR19.TXT Y ANALI19.TXT



        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568

        'Andres , vamos con lo mas importante te paso los clientes que cuando vienen como 
        'DESTINATARIO tienen que llevar el tilde de exportacon : LDC ARGENTINA , MULTIGRAIN ARG, AMAGGI AR, CHS , LOS GROBO


        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim

            'If destinatario = "CARGILL S.A.C.I." Then
            '    dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            'Else
            '    dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            'End If


            If destinatario.Contains("LDC ARGENTINA") _
                Or destinatario.Contains("MULTIGRAIN") _
                Or destinatario.Contains("AMAGGI") _
                Or destinatario.Contains("CHS") _
                Or destinatario.Contains("LOS GROBO") _
                Then
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI"
            Else
                dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "NO"
            End If


            'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13568
            'Andres buenas tardes, hay algo que nunca te avisamos, 
            '    Todo lo que venga de CHS en cargill (como exportación - destinatario), 
            '    no lo tiene que pegar en la pegatina, (solo tiene que pegar cuando también vamos por entrega). favor de hacerlo urgente...
            If destinatario.Contains("CHS") And dr.Item(enumColumnasDeGrillaFinal.Exporta.ToString()) = "SI" Then dr.Item("NumeroCDP") = ""



        Next



    End Sub


    Sub ReasignoExportacion_Unidad6PlayaPerez(ByRef dt As Data.DataTable)


        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13418

        'Andres, la posición la está pegando bien, lo que faltaría es lo mismo que te pedimos para Cargill, es lo siguiente.

        'Cuando el destinatario es ADM , lo tiene que pegar como entrega normal.

        'Cuando el destinatario no es ADM, tiene que pegarlo siempre con el tilde de exportación.

        'Cuando el destinario es CHS , no tiene que pegar nada .

        For r = 0 To dt.Rows.Count - 1

            Dim dr = dt.Rows(r)

            Dim destinatario = dr.Item(enumColumnasDeGrillaFinal.Comprador.ToString()).ToString.Trim.ToUpper

            'Dim destinatario As String = dr.Item("column18").ToString.Trim ' dr.Item("Destinatario").ToString.Trim

            If destinatario.Contains("ADM") Or destinatario.Contains("TRADING SUR") Or destinatario.Contains("CIA. ARGENTINA DE GRANOS") Then
                dr.Item("Exporta") = "NO"
            ElseIf destinatario.Contains("MULTIGRAIN") Or destinatario.Contains("AMAGGI") Or destinatario.Contains("LDC") Or _
                    destinatario.Contains("ANDREOLI") Or destinatario.Contains("BTG") Then
                dr.Item("Exporta") = "SI"
            Else
                dr.Item("Exporta") = "NO"
            End If


            If destinatario.Contains("CHS DE ARGENTINA") Then dr.Item("NumeroCDP") = ""
        Next



        'http://bdlconsultores.sytes.net/Consultas/Admin/verConsultas1.php?recordid=13585
        '        Andres, ahí pudimos probar la pegatina de Playa Perez (Adjunto archivo).
        'Pega perfecto salvo:

        'Destinatario ADM tiene que pegar sin tilde de exportación y lo pega con tilde,
        'Destinatario Trading Sur tiene que pegar sin tilde de exportación y pega con tilde,
        'Destinatario Cia Arg de Granos tiene que pegar sin tilde de exportación,

        'Destinatario Multigrain tiene que pegar con tilde de exportación y lo pega sin tilde,
        'Destinatario Amaggi Tiene que pegar con tilde de exportación,
        'Destinatario LDC lo tiene que pegar con tilde de exportación. 

        'Destinatario CHS no lo tiene que pegar y lo pega.


        'ANDRES, NECESITAMOS QUE CUANDO VENGA DESTINATARIO : ANDREOLI SA Y BTG PACTUAL , SIEMPRE LO PEGUE CON TILDE.
        'AGUARDAMOS()

    End Sub




    Sub ReasignoTitularCOrdenETC_Nidera(ByRef dt As Data.DataTable)


        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11790
        '     Si están los 3 datos (o Cta/Ord 1 y Cargador):
        'CTA ORD 1 : Titular
        'CTA ORD 2 : Intermediario
        'Cargador: Rte(Comercial)

        '----------------------------

        'Si esta solo el cargador:

        'Cargador: Titular()

        '////////////////////////////////////////////////////////////////////////////////////////////////////////////


        For r = 0 To dt.Rows.Count - 2

            'voy iterando desde el renglon de arriba hasta abajo, arrastrando hacia abajo los valores

            Dim dr = dt.Rows(r)

            Dim cargador, vendedor, corden1, corden2 As String

            cargador = dr.Item("Titular").ToString.Trim
            corden2 = dr.Item("Intermediario").ToString.Trim
            corden1 = dr.Item("RComercial").ToString.Trim

            Dim titular, intermediario, remitente As String


            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11919

            If corden1 <> "" And corden2 <> "" And cargador <> "" Then
                '     Si están los 3 datos (o Cta/Ord 1 y Cargador):
                'CTA ORD 1 : Titular
                'CTA ORD 2 : Intermediario
                'Cargador: Rte(Comercial)
                titular = corden1
                intermediario = corden2
                remitente = cargador
            ElseIf corden1 <> "" And cargador <> "" Then
                '(o Cta/Ord 1 y Cargador):
                'CTA ORD 1 : Titular
                'CTA ORD 2 : Intermediario
                'Cargador: Rte(Comercial)
                titular = corden1
                intermediario = corden2
                remitente = cargador
            Else
                'si viene solo el cargador, es el titular
                titular = cargador
                intermediario = ""
                remitente = ""
            End If


            dr.Item("Titular") = titular
            dr.Item("Intermediario") = intermediario
            dr.Item("RComercial") = remitente





        Next
    End Sub





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

        dt.Rows(row).Item(col) = txtBuscarCliente.Text 'TODO: hacer un left 50???
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



                c = FertilizanteManager.GrabaRenglonEnTablaFertilizantes(dt.Rows(r), SC, Session, cmbDespacho, cmbPuntoDespacho, chkAyer, txtLogErrores, cmbPuntoVenta, txtFechaArribo, cmbFormato, NoValidarColumnas) 'intenta grabar el renglon importado como una CDP





            Catch ex As Exception

                ErrHandler2.WriteError(ex)
                'quizás no se le puso el nombre del titular
                Dim sError = "Error paso 1: faltan datos? " & ex.Source & " " & ex.ToString
                ErrHandler2.WriteError(sError)

                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= ex.Message & vbCrLf

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


            lblUbicacion.Text = "Buscar equivalencia de " & nombreColumna(ViewState("Col")) & " en fila " & ViewState("Row") + 1 & "/" & dt.Rows.Count + 1 & "   (" & dt.Rows(r).Item("NumeroCDP") & ")"

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
            Case "Producto", "column12", "column13", "column14", "column15" 'articulo
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

    Function nombreColumna(idcolumna As String) As String
        Select Case idcolumna
            Case "column21"
                nombreColumna = "Transportista"
            Case "column23"
                nombreColumna = "Chofer"
            Case "column12"
                nombreColumna = "Producto 1°"
            Case "column13"
                nombreColumna = "Producto 2°"
            Case "column14"
                nombreColumna = "Producto 3°"
            Case "column15"
                nombreColumna = "Producto 4°"
            Case Else
                nombreColumna = idcolumna
        End Select

    End Function




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
        FormatoDelArchivoFertilizantes(nombre, cmbFormato)

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








    Function GrabaExcelEnBase(ByVal dtExcel As Data.DataTable) As Integer

        'Dim dtBase = ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, -1) ' m_IdMaestro


        'Dim nombres(dtExcel.Columns.Count) As String
        'For c = 0 To dtExcel.Columns.Count - 1
        '    nombres(c) = dtExcel.Columns(c).ColumnName
        'Next
        'Dim snombres As String = Join(nombres, "|")


        For Each drExcel As DataRow In dtExcel.Rows

            '    Dim drBase = dtBase.NewRow()

            '    drBase("IdTanda") = m_IdMaestro
            '    drBase("Observaciones") = snombres
            drExcel("IdTanda") = m_IdMaestro

            '    For c As Integer = 0 To dtExcel.Columns.Count - 1
            '        drBase("Excel" & (c + 1)) = Left(iisNull(drExcel(c)), 50)
            '    Next


            '    dtBase.Rows.Add(drBase)
        Next


        ExcelImportadorManager.Insert(SC, dtExcel) 'En el bulk, del maestro solo hago insert. Del detalle sí hago update

        'todo: limpiar con este
        'ExcelImportadorManager.BorrarRegistrosViejos()
    End Function


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











