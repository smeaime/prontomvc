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

Imports CartasDePorteImportador.FormatosDeExcel

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging

Imports ExcelImportadorManager
Imports ExcelImportadorManager.FormatosDeExcel

Imports ClaseMigrar.SQLdinamico



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
            panelEquivalencias.Visible = False
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
                ErrHandler.WriteError(ex.Message)
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

                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString) = ReyserAnalisis Then Exit Sub
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString) = Unidad6Analisis Then Exit Sub

                btnEmpezarImportacion.Visible = True
                txtFechaArribo.Visible = True
                panelEquivalencias.Visible = False
                txtLogErrores.Visible = False
                txtLogErrores.Text = ""

                If Not bEligioForzarFormato Then FormatoDelArchivo(nombrenuevo) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
                RefrescarTextosDefault()

            Catch ex As Exception
                ErrHandler.WriteError(ex.Message)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub


    Protected Sub btnVistaPrevia2_Click(sender As Object, e As System.EventArgs) Handles btnVistaPrevia2.Click
        ReyserCalidadesToDataset(Session("NombreArchivoSubido2").ToString)
    End Sub


    Protected Sub btnVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnVistaPrevia.Click




        Try

            If FormatearExcelImportado() > 0 Then

                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString) = ReyserAnalisis Then Exit Sub
                If FormatoDelArchivo(Session("NombreArchivoSubido").ToString) = Unidad6Analisis Then Exit Sub

                MostrarPrimerosDiezRenglones()

            Else
                ErrHandler.WriteError("IMPORTADOR No se pudo importar ningún renglón " & Session("NombreArchivoSubido"))

                MsgBoxAjax(Me, "No se pudo importar ningún renglón. Verifique el formato elegido")


            End If

        Catch ex As Exception
            ErrHandler.WriteError(ex)
            ErrHandler.WriteError(Session("NombreArchivoSubido").ToString)
            'MsgBoxAjax(Me, "Error al importar esquema." & ex.Message)
            MsgBoxAlert("Error al importar esquema." & ex.Message)
        End Try

    End Sub

    Protected Sub btnEmpezarImportacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEmpezarImportacion.Click
        Empezar()
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        validar() 'Guarda, que tambien lo llamas desde TextChanged y provoca un doble llamado
        ' a validar, haciendo que salte un campo
    End Sub


    Protected Sub cmbFormato_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbFormato.TextChanged
        bEligioForzarFormato = True
        RefrescarTextosDefault()

        'TODO: Y acá tendría que llamar de nuevo a GetExcel y MostrarPrimerosDiezRenglones

    End Sub

    Sub RefrescarTextosDefault()
        PanelAnexo.Visible = False
        Select Case FormatoDelArchivo()
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
                txtDestinatario.Text = "VICENTIN CEREALES S.A."
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


    Const MAXFILAS = 150
    Const MAXCOLS As Integer = 35  'oSheet.UsedRange.Cells.Columns.Count

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


    Function PuertoACAToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 50
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()
        dr(0) = "F. DE CARGA"
        dr(1) = "HORA"
        dr(2) = "Carton"
        dr(3) = "Turno"
        dr(4) = "CTG"
        dr(5) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(7) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(9) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(13) = "CORREDOR"

        dr(19) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        dr(21) = "TRANSPORTISTA"
        dr(22) = "TRANSPCUIT"
        dr(23) = "CHOFER"
        dr(24) = "CHOFERCUIT"
        dr(25) = "PRODUCTO"
        dr(26) = "CARTA PORTE"


        dt.Rows.Add(dr)






        ' 0        IngresoFecha(LLEGADA)
        ' 1        IngresoHora(HORA)
        ' 2 Carton (turno orden de ingreso) 
        ' 3 Turno  (código que le asigna ACA a cada camión ) (ORDEN)
        ' 4 Número de CTG  (CTG)
        ' 5 Cargador1 (TITULA DE CP) (CARGADOR)
        ' 6        CUIT()
        ' 7 Cargador2  (INTERMEDIARIO) (VEND. CJE.)
        ' 8        CUIT()
        ' 9 Cargador3 (REMITENTE COMERCIAL) (C Y ORD2)
        '10        CUIT()
        '11 Cargador4 (CUANDO CORRESPONDA “MERCADO A TERMINO”)
        '12        CUIT()
        '13 Corredor1 (CORREDOR QUE FIGURA EN CP “CORREDOR”) (CORREDOR) 
        '14        CUIT()
        '15 Corredor2 (CORREDOR QUE FIGURA EN OBSEVACIONES “CORR INTERVINIENTE”) (OBS)
        '16        CUIT()
        '17        Entregador1(ENTREGADOR)
        '18        CUIT()
        '19        Exportador1(DESTINATARIO)(COMPRADOR)
        '20        CUIT()
        '21        transportista()
        '22        CUIT(transportista(TRANSPORTISTA))
        '23        Chofer()
        '24        CUIT(chofer(CHOFER))
        '25        Producto(PRODUCTO)
        '26 Numero de CartaPorte (CARTA DE PORTE)





        '27        Procedencia.Bruto()
        dr(27) = "BRUTO PROC"
        '28        Procedencia.Tara()
        dr(28) = "TARA PROC"
        '29 Procedencia.Neto (KG PROCED)
        dr(29) = "NETO PROC"
        '30        Procedencia.Ciudad(PROCEDENCIA)
        dr(30) = "PROCEDENCIA"
        '31 Transporte ( A= SI ES CAMION    F= SI ES VAGON)
        'dr(31) = "PROCEDENCIA"
        '32        DominioChasis(PATENTE)
        dr(32) = "PATENTE"
        '33        DominioAcoplado(PAT.ACOPLADO)
        dr(33) = "ACOPLADO"
        '34        Contrato(CONTRATO)
        dr(34) = "CONTRATO"
        '35        SalidaBruto()
        dr(35) = "BRUTO PTO"
        '36        SalidaTara()
        dr(36) = "TARA PTO"
        '37 KilosMerma  (OTRAS MERMAS)
        dr(37) = "MERMA"
        '38 SalidaNeto 
        dr(38) = "NETO PTO"
        '39 SalidaFecha (DIA DESCARGA)
        dr(39) = "F. DE DESCARGA"
        '40        SalidaHora(HORA)
        'dr(40) = "HORA"
        '41 atributo de Porteria: “CON CUPO” o “SIN CUPO” o “LE DIERON CUPO”
        'dr(41) = "PROCEDENCIA"
        '42 atributo de Calada:  "DEMORADO" "ANALIZADO" "CONDICIONAL" "CONFORME"  "RECHAZADO"  "AUTORIZADO" camión ya autorizado por el entregador
        dr(42) = "CALIDAD"
        '43 Observaciones: comentarios varios, resultado de análisis de calidad, mermas, focos, etc. 
        dr(43) = "OBSERVACIONES"


        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using


        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds


        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function


    Function ReyserToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>

        dr(43) = "OBSERVACIONES"

        'dr(0) = "Prefijo Cp"
        dr(1) = "CARTA PORTE"
        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        dr(10) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(14) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(18) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(6) = "CORREDOR"

        dr(8) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        'dr(6) = "Razon Social Corredor"
        'dr(7) = "Cuit Destinatario"
        'dr(8) = "Razon Social Destinatario"
        'dr(9) = "Cuit Titular"
        'dr(10) = "Razon Social Titular"
        'dr(11) = "Nro Planta Oncca Titular"
        'dr(12) = "Descripcion Planta Titular"
        'dr(13) = "Cuit Intermediario"
        'dr(14) = "Razon Social Intermediario"
        'dr(15) = "Nro Planta Oncca Intermediario"
        'dr(16) = "Descripcion Planta Intermediario"
        'dr(17) = "Cuit Remitente C."
        'dr(18) = "Razon Social  Remitente C."
        'dr(19) = "Nro Planta Oncca Remitente C."
        'dr(20) = "Descripcion Planta Remitente C."
        'dr(21) = "Cod Oncca Cereal"
        'dr(22) = "Descrip. Oncca"
        'dr(23) = "Cod Oncca Procedencia"
        'dr(24) = "Descrip. Procedencia"

        'dr(23) = "CHOFER"
        'dr(24) = "CHOFERCUIT"
        dr(22) = "PRODUCTO"

        dr(24) = "PROCEDENCIA"
        dr(27) = "PATENTE"
        'dr(33) = "ACOPLADO"
        dr(26) = "CONTRATO"
        dr(33) = "OBSERVACIONES"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"
        dr(25) = "NETO PROC"

        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"
        dr(28) = "TRANSPORTISTA"
        dr(29) = "TRANSPCUIT"

        'dr(28) = "Cuit Transportista"
        'dr(29) = "Razon Social Transportista"
        'dr(30) = "Turno"
        'dr(31) = "Estado"
        dr(32) = "F. DE CARGA"
        'dr(33) = "Observacion"
        'dr(34) = "Hora Entrada"
        'dr(35) = "Cod Puerto"
        'dr(36) = "Medio"
        'dr(37) = "Kilos Netos Descargados"
        'dr(38) = "Tipo"
        'dr(39) = "Fecha Descarga"
        dr(39) = "F. DE DESCARGA"
        'dr(40) = "Calidad"
        dr(40) = "CALIDAD"
        'dr(41) = "Hora Salida"
        'dr(42) = "Bruto Descarga"
        'dr(43) = "Tara Descarga"
        dr(42) = "BRUTO PTO"
        dr(43) = "TARA PTO"
        'dr() = "MERMA"
        dr(37) = "NETO PTO"

        dr(44) = "RECIBO"


        dr(1) = "CARTA PORTE"
        'dr(2) = "VAGON"
        dr(30) = "TURNO"
        'dr(4) = "CTG"


        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows


            If Val(r(1)) = 0 Then Continue For

            r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))



            r(40) = CodigoCalidad(Val(r(40)))


        Next



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


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



    Function ReyserCalidadesToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>


        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)



        dr(0) = "PREFIJO"
        dr(1) = "CARTA PORTE"
        dr(2) = "RECIBO"
        dr(3) = "RUBRO"
        dr(4) = "VAGON"
        dr(5) = "MERMA"
        dr(6) = "PROCENTAJEHUMEDAD"
        dr(7) = "PORCENTAJEMERMA"
        dr(8) = "CANTIDAD"



        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using





        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        '4 Nro Vagon	numeric(6)   
        '5 Kilos Merma	numeric(6)
        '6 Porcentaje Humedad	numeric(3,2)
        '7 Porcentaje Merma	numeric(3,2)
        '8 Cantidad Analisis	numeric(6)
        'Fecha	date

        Dim c = 0
        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For
                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                Dim numeroCarta As Long = r(1)   '  Val(Replace(r(0), "-", ""))
                Dim vagon As Long = Val(r(4)) 'por ahora, las cdp importadas tendran subnumero 0
                Dim Rubro As Long = r(3)

                Dim kilosmerma As Double = Val(r(5))
                Dim porcentajehum As Double = Val(r(6))
                'Dim porcentajemerm As Double = Val(r(6)

                Dim analisis As Double = r(7)

                Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon)
                If cdp.Id = -1 Then
                    cdp.NumeroCartaDePorte = numeroCarta
                    cdp.SubnumeroVagon = vagon
                End If
                With cdp
                    Select Case Rubro
                        Case 1 'dañado
                            cdp.NobleDaniados = analisis
                        Case 2
                            cdp.Humedad = porcentajehum
                            cdp.HumedadDesnormalizada = kilosmerma
                        Case 3
                            .NobleHectolitrico = analisis
                        Case 4
                            .NobleExtranos = analisis
                        Case 5
                            .NobleQuebrados = analisis
                        Case 7
                            .NoblePicados = analisis



                            '	1	DAÑADO                        	DÑ 
                            '	2	HUMEDAD                       	HD 
                            '	3	PESO HECTOLITRICO             	PH 
                            '	4	MATERIA EXTRAÑA               	C/E 
                            '	5	QUEBRADO.                     	QB 
                            '	6	PARTIDO                       	PAR 
                            '	7	PICADO                        	PIC 


                        Case 8
                            .CalidadPuntaSombreada = analisis
                        Case 9
                            .NobleNegros = analisis
                        Case 10
                            .NobleObjetables = analisis


                            '	8	PUNTA SOMBREADO               	PS 
                            '	9	PUNTA NEGRA                   	PN 
                            '	10	OLORES OBJETABLES             	OL 
                            '	11	SEMILLAS DE TREBOL            	STR 
                            '	12	TIPO	TIP 


                            '	13	COLOR            	COL 
                            '	14	GRANOS AMOHOSADOS            	MH 
                        Case 14
                            .NobleAmohosados = analisis
                            '	15	CHAMICO                       	CHA 
                        Case 15
                            .CalidadMermaChamico = analisis
                            '	16	GRANOS CON CARBON             	GC  
                        Case 16
                            .NobleCarbon = analisis
                            '	17	REVOLCADO TIERRA              	REV 
                            '	18	FUMIGACION PART               	F/P 
                        Case 18
                            .Fumigada = analisis
                            '	19	FUMIGACION CINTA              	F/C 
                            '	24	TEMPERATURA                   	TP 
                            '	25	PROTEINAS                     	PRT 
                            '	26	FONDO                         	FDO 
                            '	27	MERMA CONVENIDA               	MC 
                            '	28	TIERRA                        	TIE
                        Case 28
                            .CalidadTierra = analisis

                            '	29	AVERIA                        	AVE 
                            '	30	PANZA BLANCA                  	PBA 
                        Case 30
                            .NoblePanzaBlanca = analisis
                            '	31	MERMA TOTAL                   	MT

                            '	32	CUERPOS EXTRAÑOS      	C.E

                            '	33	TOTAL DAÑADOS	TD

                            '	34	QUEBRADOS Y/O CHUZOS	CHU 
                        Case 34
                            .NobleQuebrados = analisis
                            '	38	ARDIDO                        	ARD 
                            '	39	GRANOS VERDES                 	GV
                        Case 39
                            .NobleVerdes = analisis
                            '	40	Humedad y chamicos	H/C 
                        Case 40
                            .CalidadMermaChamico = analisis
                            '	41	P.H. grado y tipo (trigo)	G/T

                            '	42	Grado y color (sorgo)	G/C
                            '	43	Grado tipo y color (ma¡z)	GTC
                            '	44	Análisis completo	A.C
                            '	45	Granos Ardidos y/o Dañados	A/D
                            '	46	Gastos Secada	G.S.
                            '	47	Merma x chamicos	MCH
                            '	48	SILO	SIL
                            '	49	Merma Volatil	MV

                            '	50	Acidez s/Materia Grasa	AMG
                            '	51	Aflatoxinas 	AFL
                            '	52	Arbitraje Otras Causas Calidad Inferior	CAL
                            '	53	Ardidos y Dañados por Calor	ADC
                            '	54	Brotados	BRO

                            '	55	Coloreados y/o con Estrias Roja	CER
                            '	56	Contenido Proteico	C/P
                            '	57	Cornezuelo	COR
                            '	58	Descascarado y Roto	D/R
                            '	59	Enyesados o Muertos	E/M
                            '	60	Esclerotos	ESC
                            '	61	Excremento de Roedores	EXC

                            '	62	Falling Number	FN
                            '	63	Granos Helados	GH
                            '	64	Granos Negros	GN
                            '	65	Granos Otro Color	OCO
                            '	66	Granos Sueltos	GS

                            '	67	Manchados y/o Coloreados	M/C
                            '	68	Materia Grasa S.S.S.	MG
                        Case 68
                            .NobleMGrasa = analisis
                            '	70	Otro Tipo	OT
                            '	71	Quebrados y/o Chuzos	Q/C
                            '	72	Quebrados y/o Partidos	Q/P

                            '	73	Rendimiento de Granos Enteros	EGE

                            '	74	Rendimiento de Granos Quebrados	RGQ
                            '	75	Rendimiento sobre zaranda 6.25 mm	Z62
                            '	76	Rendimiento sobre zaranda 7.5 mm	Z75
                            '	77	Sedimento	SED
                            '	78	Semillas de Bejuco y/o Porotillo	B/P
                            '	79	Total Dañados	TDÑ
                            '	80	Verde Intenso	VIN
                            '	81	GRADO	GRA
                            '	85	Insectos vivos 	INS.V
                            '	502	Granos clorados 	G.CLO
                        Case Else
                            If False Then txtLogErrores.Text &= "No se pudo importar rubro " & Rubro & vbCrLf

                            Continue For
                    End Select

                    c += 1


                    actualizar(.FechaArribo, txtFechaArribo.Text)
                End With


                Try
                    Dim ms As String
                    Dim valid = CartaDePorteManager.IsValid(SC, cdp, ms)
                    If CartaDePorteManager.Save(SC, cdp, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                        txtLogErrores.Text &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                        Debug.Print("No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf)
                        ErrHandler.WriteError("Error al grabar CDP importada")
                        txtLogErrores.Text &= ms
                    Else
                        'dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                    txtLogErrores.Text &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                    txtLogErrores.Text &= ex.Message

                End Try
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                txtLogErrores.Text &= ex.Message
            End Try

        Next







        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)

        panelEquivalencias.Visible = True
        MsgBoxAjax(Me, "Análisis Reyser importación terminada") ' . Analisis importados " & c)
        txtLogErrores.Text = "Análisis Reyser importación terminada." & vbCrLf & txtLogErrores.Text
        txtLogErrores.Visible = True


        Return ds

    End Function



    Function Unidad6ToDatasetVersionAnteriorConTabsPlayaPerez(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>

        dr(43) = "OBSERVACIONES"

        'dr(0) = "Prefijo Cp"
        dr(1) = "CARTA PORTE"
        'dr(2) = "Nro Vagon"
        'dr(3) = "Cuit Entregador"
        'dr(4) = "Razon Social Entregador"
        'dr(5) = "Cuit Corredor"

        dr(10) = "CARGADOR"
        'dr(6) = "CUIT"
        dr(14) = "INTERMEDIARIO"
        'dr(8) = "CUIT"
        dr(18) = "REMITENTE COMERCIAL"
        'dr(10) = "CUIT"
        dr(6) = "CORREDOR"

        dr(8) = "DESTINATARIO"
        'dr(20) = "DESTINATARIOCUIT"

        'dr(6) = "Razon Social Corredor"
        'dr(7) = "Cuit Destinatario"
        'dr(8) = "Razon Social Destinatario"
        'dr(9) = "Cuit Titular"
        'dr(10) = "Razon Social Titular"
        'dr(11) = "Nro Planta Oncca Titular"
        'dr(12) = "Descripcion Planta Titular"
        'dr(13) = "Cuit Intermediario"
        'dr(14) = "Razon Social Intermediario"
        'dr(15) = "Nro Planta Oncca Intermediario"
        'dr(16) = "Descripcion Planta Intermediario"
        'dr(17) = "Cuit Remitente C."
        'dr(18) = "Razon Social  Remitente C."
        'dr(19) = "Nro Planta Oncca Remitente C."
        'dr(20) = "Descripcion Planta Remitente C."
        'dr(21) = "Cod Oncca Cereal"
        'dr(22) = "Descrip. Oncca"
        'dr(23) = "Cod Oncca Procedencia"
        'dr(24) = "Descrip. Procedencia"

        'dr(23) = "CHOFER"
        'dr(24) = "CHOFERCUIT"
        dr(22) = "PRODUCTO"

        'problema con esto, porque no viene siempre con la descripcion
        ' U/6 NO LO TERMINE DE PEGAR, MIRA EL PRINT, NO ME PONIA EL PRODUCTO, (NO PUEDO PONERLE CUALQUIERA SIN SABER) INTERMEDIARIO ME PONE LA FECHA, REMITENTE UN NUMERO, PROCEDENCIA 0000??
        ' https://mail.google.com/mail/u/0/#inbox/13e3c383c5433feb

        dr(24) = "PROCEDENCIA"
        dr(27) = "PATENTE"
        'dr(33) = "ACOPLADO"
        dr(26) = "CONTRATO"
        dr(33) = "OBSERVACIONES"


        'dr(27) = "BRUTO PROC"
        'dr(28) = "TARA PROC"
        dr(25) = "NETO PROC"

        'dr(25) = "Kilos Netos Procedencia"
        'dr(27) = "Patente"
        dr(28) = "TRANSPORTISTA"
        dr(29) = "TRANSPCUIT"
        'dr(28) = "Cuit Transportista"
        'dr(29) = "Razon Social Transportista"
        'dr(30) = "Turno"
        'dr(31) = "Estado"
        dr(32) = "F. DE CARGA"
        'dr(33) = "Observacion"
        'dr(34) = "Hora Entrada"
        'dr(35) = "Cod Puerto"
        'dr(36) = "Medio"
        'dr(37) = "Kilos Netos Descargados"
        'dr(38) = "Tipo"
        'dr(39) = "Fecha Descarga"
        dr(39) = "F. DE DESCARGA"
        'dr(40) = "Calidad"
        dr(40) = "CALIDAD"
        'dr(41) = "Hora Salida"
        'dr(42) = "Bruto Descarga"
        'dr(43) = "Tara Descarga"
        dr(42) = "BRUTO PTO"
        dr(43) = "TARA PTO"
        'dr() = "MERMA"
        dr(37) = "NETO PTO"

        dr(44) = "RECIBO"


        dr(1) = "CARTA PORTE"
        'dr(2) = "VAGON"
        dr(30) = "TURNO"
        'dr(4) = "CTG"


        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab, ";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows
            'transformar columna de calidad
            '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE
            Try

                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                r(40) = CodigoCalidad(Val(r(40)))


            Catch ex As Exception

            End Try


        Next



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function



    Function Unidad6ToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()


        'nos estan delirando con los formatos
        'en uno nos mandan separado con puntocoma y en otro con tab
        'en uno el numero de carta porte esta en la columna n2 (empieza con prefijo/nrocarta) ,  y en otro en la columna n22 (empieza con cuit titular/cuit corredor)



        'este es el formato original de Reyser. De aca salen los de Unidad6
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9305


        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        'formato para cerealnet.  usando "playa perez"???? usando formato reyser????
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9308
        'fijate que en tu funcion Unidad6ToDatasetVersionAnteriorConTabs
        '//////////////////////////////////////////////
        'ejemplo:
        '5;31063160;0;30707386076;WILLIAMS ENTREGA S.A.;30539435589;GRIMALDI GRASSI S.A.;30697312028;ADM ARGENTINA S.A.;30708023635;CIGRA CAMPOS S.A;0;;30691576511;PROFERTIL S.A.;0;;30640872566;COMMODITIES S.A.;0;;19;MAIZ;4437;DIEGO DE ALVEAR;29920;3602;WHC142;27235772081;AGUERO SONIA;00000229;4;22/04/2013;;0000;19;30691576511;PROFERTIL S.A.;0;;1;29900;23/04/2013;5;0014;42960;13060;000000;0;00.00;00.00;21/04/2013;0000;00000000;;;;;;;;;;;;01/01/1900;;;;;;;;;;;01/01/1900;;;;;;NO;0;;0
        '5;31651086;0;30707386076;WILLIAMS ENTREGA S.A.;30539435589;GRIMALDI GRASSI S.A.;30710179987;MULTIGRAIN ARGENTINA S.A;30711045909;DEMARCHI JORGE JAVIER Y OTROS;0;;30707060871;GRUPO CKOOS S.R.L.;0;;30646328450;SYNGENTA AGRO S.A.;0;;22;SORGO GRANIFERO;8609;LAS PEÑAS SUD;30500;220829;GNO175;20256561345;BIANCO EDUARDO;00000775;4;22/04/2013;;0000;19;30646328450;SYNGENTA AGRO S.A.;0;;1;29960;23/04/2013;5;0037;44260;14300;000000;0;00.00;00.00;21/04/2013;0000;00000000;;;;;;;;;;;;01/01/1900;;;;;;;;;;;01/01/1900;;;;;;NO;0;;0
        '//////////////////////////////////////////////
        'otro ejemplo:
        '5	29490128	0	30707386076	WILLIAMS ENTREGA S.A.	11111111111	DIRECTO	30697312028	ADM ARGENTINA S.A.	30604954130	GRANERO S.R.L.	0		00000000000		0		00000000000		0		19	MAIZ	19281	VICTORIA	30240	013012952	SDJ179	20129905647	GONZALEZ JUAN CARLOS	00002738	4	06/02/2013			19	1	30160	1	06/02/2013	3		44940	14780	000000	151	00.00	00.00	06/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0
        '5	29490124	0	30707386076	WILLIAMS ENTREGA S.A.	11111111111	DIRECTO	30697312028	ADM ARGENTINA S.A.	30604954130	GRANERO S.R.L.	0		00000000000		0		00000000000		0		19	MAIZ	19281	VICTORIA	29800	013012952	ECF682	30710565976	BENEDETTI E.	00002734	4	06/02/2013			19	1	29780	1	06/02/2013	5		44960	15180	000000	0	00.00	00.00	05/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0
        '5	29495846	0	30707386076	WILLIAMS ENTREGA S.A.	30703605105	FUTURO Y OPCIONES CON. S.A.	30697312028	ADM ARGENTINA S.A.	20017339991	RAY, JOSE DOMINGO	0		00000000000		0		30537721274	TOMAS HNOS.	0		15	TRIGO PAN	10978	PEHUAJO	31280	033036793	RII796	30709049093	AGROLOGISTICA SRL	00009710	4	06/02/2013			19	1	31180	1	06/02/2013	3		44600	13420	000000	156	00.00	00.00	01/02/2013	0000	00000000	00000000	0000	0	0	00000000000		00000		00000000000	00000000	01/01/1900	00000000000				0.00	0.00	00000	00		0	01/01/1900						NO	0	000000000000	0


        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        '//////////////////////////////////////////////
        'y cual es el ejmplo que usaste acá?????
        ' http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultasCumplidos1.php?recordid=9837
        'sería lo de playa perez
        'pero el de la 9308 tambien era de playa perez
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30340;0;0;0;Camión;30524090;000000;0;;; ;Descargó;00000354;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30380;0;0;0;Camión;30524094;000000;0;;; ;Descargó;00000404;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369
        '30511512073;11111111111;30711160163;6419;19;19;30707386076;;MARIA ELENA SOC EN COM POR ACCIONES;;28/03/2013;00/00/0000;;0000;0;no;30520;0;0;0;Camión;30524092;000000;0;;; ;Descargó;00000405;MARIA ELENA SOC EN COM POR ACCIONES;DIRECTO;CHS DE ARGENTINA SA;;Maiz;GENERAL VILLEGAS;;1;30511512073;no;0;5;00000000000;;30511355040;SUCESION DE ANTONIO MORENO S A C A I F E;00000000000; ;30511512073;0;0;0;0;00000000000;00000; ;00000;;00000;;4500;56;369





        '0:      cuit_titular()
        'dr(0) = "CARGADOR" 'ya sé que lo repetís abajo. Este está para que sepa encontrar el renglon de titulos
        '1:      CUIT_corre()
        '2:      cuit_destinatario()
        '3:      cod_procedencia()
        '4:      cod_puerto()
        '5:      cod(mercaderia)
        '6:      cuit(entregador)
        '7:      contrato()
        dr(26) = "CONTRATO"
        '8	razon social titular
        '9:      fecha(descarga)
        dr(9) = "F. DE DESCARGA"
        '10:     fecha(entrada)
        dr(10) = "F. DE CARGA"
        '11:     fecha_emision()
        '12:     hora(salida)
        '13:     hora(entrada)
        '14:     kilos_merma()
        '15:     no()
        '16:     kgs(procedencia)
        dr(19) = "NETO PROC"
        '17:     bruto()
        dr(17) = "BRUTO PTO"
        '18:     tara()
        dr(18) = "TARA PTO"
        '19:     kgs(neto)
        dr(16) = "NETO PTO"
        '20:     medio(camion / vagon)
        '21	Nro de carta
        dr(21) = "CARTA PORTE"
        '22:     Nro(Recibo)
        dr(22) = "RECIBO"
        '23:     Nro(vagon)
        dr(23) = "VAGON"
        '24:     observacion()
        dr(24) = "OBSERVACIONES"
        '25:     patente()
        dr(25) = "PATENTE"
        '26:     ' '
        '27:     Descargó() '  
        '28:     turno()
        dr(30) = "TURNO"
        '29	razon social titular
        dr(29) = "CARGADOR"

        '30	razon social corredor
        dr(30) = "CORREDOR"


        '31	razon social destin
        dr(31) = "DESTINATARIO"
        '32:     nombre_puerto()
        '33:     descripcion(mercaderia)
        dr(33) = "PRODUCTO"
        '34:     nombre_proce()
        dr(34) = "PROCEDENCIA"
        '35:     cosecha()
        '36:     '1'
        '37:     cuit_titular()
        '38:     'no'
        '39:     calidad()
        dr(39) = "CALIDAD"
        '40:     prefijo(cp)
        '41:     cuit_intermediario()
        '42	razon social interm
        dr(42) = "INTERMEDIARIO"
        '43:     cuit_remitente(comercial)
        '44	razon social remitente comercial
        dr(44) = "REMITENTE COMERCIAL"
        '45:     '00000000000'
        '46:     ' '
        '47:     cuit(titular)
        '48:     '0'
        '49:     '0'
        '50:     '0'
        '51:     '0'
        '52:     cuit_transp()
        'dr() = "TRANSPORTISTA"
        dr(52) = "TRANSPCUIT"
        '53:     nro_planta_titular()
        '54:     descripcion_planta_titular()
        '55:     nro_planta_intermediario()
        '56:     descrip_planta_intermediario()
        '57:     nro_planta_remitente_comercial()
        '58:     descripcion_planta_remitente()
        '59:     cod_remi()
        '60:     cod_corre()
        '61:     cod_destin()



        '   Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>



        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {";"}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using


        For Each r In dt.Rows
            'transformar columna de calidad
            '1 = CO; 2 = CC; 3 = G1; 4 = G2; 5 = G3; 6 = FE
            Try

                If Val(r(1)) = 0 Then Continue For

                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                Dim c = CodigoCalidad(Val(r(40)))
                'r(40) = c
                r(39) = c


            Catch ex As Exception

            End Try


        Next



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)
        Return ds





        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


    End Function


    Function Unidad6CalidadesToDataset(ByVal pFileName As String) As Data.DataSet


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 1: abrirlo a lo macho y meterlo en un dataset
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        Dim dt As New Data.DataTable
        For i As Integer = 0 To 85
            dt.Columns.Add("column" & i + 1)
        Next

        Dim dr = dt.NewRow()














        Dim a() = {4, 8, 6, 11, 50, 11, 50, 11, 50, 11, 50, 6, 30, 11, 50, 6, 30, 11, 50, 6, 30, 3, 30, 6, 30, 6, 20, 6, 11, 50, 8, 1, 10, 50, 8, 3, 1, 6, 1, 10, 1, 8, 6, 6, 8}


        'Dim s As String
        's.Substring(




        ' <column1>5</column1> <column2>28093741</column2> <column3>0</column3> <column4>30707386076</column4> <column5>WILLIAMS ENTREGA S.A.</column5> <column6>11111111111</column6> <column7>NO INTERVIENE</column7> <column8>30506792165</column8> <column9>CARGILL S.A.C.I.</column9> <column10>30634224072</column10> <column11>ZERO AGROPECUARIA SA</column11> <column12>0</column12> <column13/> <column14>30506792165</column14> <column15>CARGILL S.A.C.I.</column15> <column16>21061</column16> <column17>9 DE JULIO</column17> <column18>30506792165</column18> <column19>CARGILL S.A.C.I.</column19> <column20>11111</column20> <column21>-</column21> <column22>23</column22> <column23>SOJA POROTO</column23> <column24>30</column24> <column25>9 DE JULIO</column25> <column26>28650</column26> <column27/> <column28>THT168</column28> <column29>30710817762</column29> <column30>LOGISTICA 22 DE ENERO S.R.L.</column30> <column31>00000128</column31> <column32>4</column32> <column33>05/11/2012</column33> <column34/> <column35/> <column36>19</column36> <column37>1</column37> <column38>28760</column38> <column39>1</column39> <column40>05/11/2012</column40> <column41>1</column41> <column42>11:06:36</column42> <column43>42460</column43> <column44>13700</column44> <column45/> <column46>0</column46> <column47/> <column48/> <column49>01/01/1900</column49> <column50>0000</column50> <column51>00000000</column51> <column52/> <column53/> <column54/> <column55/> <column56/> <column57/> <column58/> <column59/> <column60/> <column61/> <column62>01/01/1900</column62> <column63/> <column64/> <column65/> <column66/> <column67/> <column68/> <column69/> <column70/> <column71/> <column72/> <column73>01/01/1900</column73> <column74/> <column75/> <column76/> <column77/> <column78/> <column79>NO</column79> <column80>0</column80> <column81/> <column82>0</column82> </Table1>


        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)



        dr(0) = "PREFIJO"
        dr(1) = "CARTA PORTE"
        dr(2) = "RECIBO"
        dr(3) = "RUBRO"
        dr(4) = "VAGON"
        dr(5) = "MERMA"
        dr(6) = "PROCENTAJEHUMEDAD"
        dr(7) = "PORCENTAJEMERMA"
        dr(8) = "CANTIDAD"



        dt.Rows.Add(dr)



        Using MyReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(pFileName)

            MyReader.TextFieldType = Microsoft.VisualBasic.FileIO.FieldType.Delimited
            MyReader.Delimiters = New String() {vbTab}

            Dim currentRow As String()
            'Loop through all of the fields in the file. 
            'If any lines are corrupt, report an error and continue parsing. 
            While Not MyReader.EndOfData
                Try
                    currentRow = MyReader.ReadFields()

                    ' Include code here to handle the row.


                    dr = dt.NewRow()
                    For i As Integer = 0 To currentRow.Length - 1
                        dr(i) = currentRow(i)
                    Next
                    dt.Rows.Add(dr)


                Catch ex As Microsoft.VisualBasic.FileIO.MalformedLineException
                    ErrHandler.WriteError("Line " & ex.Message & " is invalid.  Skipping")
                End Try
            End While
        End Using





        '        Archivo(Anali.txt)
        'Prefijo Cp	numeric(4)
        'Nro CP	numeric(8)
        'Nro Recibo	numeric(8)
        'Nro Rubro Analisis	numeric(3)
        'Nro Vagon	numeric(6)
        'Kilos Merma	numeric(6)
        'Porcentaje Humedad	numeric(3,2)
        'Porcentaje Merma	numeric(3,2)
        'Cantidad Analisis	numeric(6)
        'Fecha	date

        Dim c = 0
        For Each r In dt.Rows

            Try
                If Val(r(1)) = 0 Then Continue For
                r(1) = Val(Val(r(0)) & Val(Replace(r(1), "-", "")))

                Dim numeroCarta As Long = r(1)   '  Val(Replace(r(0), "-", ""))
                Dim vagon As Long = Val(r(4)) 'por ahora, las cdp importadas tendran subnumero 0
                Dim Rubro As Long = r(3)
                Dim analisis As Double = r(7)

                Dim cdp = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon)
                If cdp.Id = -1 Then
                    cdp.NumeroCartaDePorte = numeroCarta
                    cdp.SubnumeroVagon = vagon
                End If
                With cdp
                    Select Case Rubro
                        Case 1 'dañado
                            cdp.NobleDaniados = analisis

                        Case 3
                            .NobleHectolitrico = analisis
                        Case 4
                            .NobleExtranos = analisis
                        Case 5
                            .NobleQuebrados = analisis
                        Case 7
                            .NoblePicados = analisis



                            '	1	DAÑADO                        	DÑ 
                            '	2	HUMEDAD                       	HD 
                            '	3	PESO HECTOLITRICO             	PH 
                            '	4	MATERIA EXTRAÑA               	C/E 
                            '	5	QUEBRADO.                     	QB 
                            '	6	PARTIDO                       	PAR 
                            '	7	PICADO                        	PIC 


                        Case 8
                            .CalidadPuntaSombreada = analisis
                        Case 9
                            .NobleNegros = analisis
                        Case 10
                            .NobleObjetables = analisis


                            '	8	PUNTA SOMBREADO               	PS 
                            '	9	PUNTA NEGRA                   	PN 
                            '	10	OLORES OBJETABLES             	OL 
                            '	11	SEMILLAS DE TREBOL            	STR 
                            '	12	TIPO	TIP 


                            '	13	COLOR            	COL 
                            '	14	GRANOS AMOHOSADOS            	MH 
                        Case 14
                            .NobleAmohosados = analisis
                            '	15	CHAMICO                       	CHA 
                        Case 15
                            .CalidadMermaChamico = analisis
                            '	16	GRANOS CON CARBON             	GC  
                        Case 16
                            .NobleCarbon = analisis
                            '	17	REVOLCADO TIERRA              	REV 
                            '	18	FUMIGACION PART               	F/P 
                        Case 18
                            .Fumigada = analisis
                            '	19	FUMIGACION CINTA              	F/C 
                            '	24	TEMPERATURA                   	TP 
                            '	25	PROTEINAS                     	PRT 
                            '	26	FONDO                         	FDO 
                            '	27	MERMA CONVENIDA               	MC 
                            '	28	TIERRA                        	TIE
                        Case 28
                            .CalidadTierra = analisis

                            '	29	AVERIA                        	AVE 
                            '	30	PANZA BLANCA                  	PBA 
                        Case 30
                            .NoblePanzaBlanca = analisis
                            '	31	MERMA TOTAL                   	MT

                            '	32	CUERPOS EXTRAÑOS      	C.E

                            '	33	TOTAL DAÑADOS	TD

                            '	34	QUEBRADOS Y/O CHUZOS	CHU 
                        Case 34
                            .NobleQuebrados = analisis
                            '	38	ARDIDO                        	ARD 
                            '	39	GRANOS VERDES                 	GV
                        Case 39
                            .NobleVerdes = analisis
                            '	40	Humedad y chamicos	H/C 
                        Case 40
                            .CalidadMermaChamico = analisis
                            '	41	P.H. grado y tipo (trigo)	G/T

                            '	42	Grado y color (sorgo)	G/C
                            '	43	Grado tipo y color (ma¡z)	GTC
                            '	44	Análisis completo	A.C
                            '	45	Granos Ardidos y/o Dañados	A/D
                            '	46	Gastos Secada	G.S.
                            '	47	Merma x chamicos	MCH
                            '	48	SILO	SIL
                            '	49	Merma Volatil	MV

                            '	50	Acidez s/Materia Grasa	AMG
                            '	51	Aflatoxinas 	AFL
                            '	52	Arbitraje Otras Causas Calidad Inferior	CAL
                            '	53	Ardidos y Dañados por Calor	ADC
                            '	54	Brotados	BRO

                            '	55	Coloreados y/o con Estrias Roja	CER
                            '	56	Contenido Proteico	C/P
                            '	57	Cornezuelo	COR
                            '	58	Descascarado y Roto	D/R
                            '	59	Enyesados o Muertos	E/M
                            '	60	Esclerotos	ESC
                            '	61	Excremento de Roedores	EXC

                            '	62	Falling Number	FN
                            '	63	Granos Helados	GH
                            '	64	Granos Negros	GN
                            '	65	Granos Otro Color	OCO
                            '	66	Granos Sueltos	GS

                            '	67	Manchados y/o Coloreados	M/C
                            '	68	Materia Grasa S.S.S.	MG
                        Case 68
                            .NobleMGrasa = analisis
                            '	70	Otro Tipo	OT
                            '	71	Quebrados y/o Chuzos	Q/C
                            '	72	Quebrados y/o Partidos	Q/P

                            '	73	Rendimiento de Granos Enteros	EGE

                            '	74	Rendimiento de Granos Quebrados	RGQ
                            '	75	Rendimiento sobre zaranda 6.25 mm	Z62
                            '	76	Rendimiento sobre zaranda 7.5 mm	Z75
                            '	77	Sedimento	SED
                            '	78	Semillas de Bejuco y/o Porotillo	B/P
                            '	79	Total Dañados	TDÑ
                            '	80	Verde Intenso	VIN
                            '	81	GRADO	GRA
                            '	85	Insectos vivos 	INS.V
                            '	502	Granos clorados 	G.CLO
                        Case Else
                            If False Then txtLogErrores.Text &= "No se pudo importar rubro " & Rubro & vbCrLf

                            Continue For
                    End Select

                    c += 1


                    actualizar(.FechaArribo, txtFechaArribo.Text)
                End With


                Try
                    Dim ms As String
                    Dim valid = CartaDePorteManager.IsValid(SC, cdp, ms)
                    If CartaDePorteManager.Save(SC, cdp, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                        txtLogErrores.Text &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                        Debug.Print("No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf)
                        ErrHandler.WriteError("Error al grabar CDP importada")
                        txtLogErrores.Text &= ms
                    Else
                        'dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                    txtLogErrores.Text &= "No se pudo grabar la carta n° " & cdp.NumeroCartaDePorte & vbCrLf
                    txtLogErrores.Text &= ex.Message

                End Try
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                txtLogErrores.Text &= ex.Message
            End Try

        Next







        'http://stackoverflow.com/questions/1103495/is-there-a-proper-way-to-read-csv-files
        'http://www.codeproject.com/KB/database/GenericParser.aspx

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 2: convertirlo a excel con OOXML
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'Dim oExc As SpreadsheetDocument=SpreadsheetDocument.Open(pFileName,False,OpenSettings.



        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'METODO 3: a excel pero con EPPLUS
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        Dim ds As New Data.DataSet
        ds.Tables.Add(dt)

        panelEquivalencias.Visible = True
        MsgBoxAjax(Me, "Análisis Unidad6 importación terminada") ' . Analisis importados " & c)
        txtLogErrores.Text = "Análisis Unidad6 importación terminada." & vbCrLf & txtLogErrores.Text
        txtLogErrores.Visible = True


        Return ds

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
            ErrHandler.WriteError("No pudo extraer el excel. " + ex.Message)
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
                ErrHandler.WriteError("No pudo cerrar el servicio excel. " + ex.Message)
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

        Select Case FormatoDelArchivo(nombre)
            Case Reyser
                ds = ReyserToDataset(nombre)
            Case ReyserAnalisis
                ds = ReyserCalidadesToDataset(nombre)

            Case Unidad6
                ds = Unidad6ToDataset(nombre)
            Case Unidad6PlayaPerez
                ds = Unidad6ToDatasetVersionAnteriorConTabsPlayaPerez(nombre)

            Case Unidad6Analisis
                ds = Unidad6CalidadesToDataset(nombre)



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

        Dim dtDestino As Data.DataTable = TablaFormato()

        Dim row As DataRow




        'busco el renglon de titulos

        Dim renglonDeTitulos As Integer
        If FormatoDelArchivo(nombre) = Unidad6 Then
            renglonDeTitulos = 0 'la pegatina de Unidad6 no tiene renglon de títulos
        Else
            renglonDeTitulos = RenglonTitulos(dtOrigen, nombre, FormatoDelArchivo)
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
        If FormatoDelArchivo(nombre) = BungeRamallo Or FormatoDelArchivo(nombre) = Unidad6PlayaPerez Then
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

        Dim f = FormatoDelArchivo()

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
            ErrHandler.WriteError("Los encabezados de columna " & errorEncabezadoTag & " no son reconocidos. " & _
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


        Dim fa = FormatoDelArchivo()

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

        '//////////////////////////////////////////
        '//////////////////////////////////////////
        '//////////////////////////////////////////
        'EXCEPCIONES post produccion
        'Copia de celdas vacias con lo que dice la celda superior
        '//////////////////////////////////////////
        '//////////////////////////////////////////

        'Excepcion de un caso raro...
        If InStr(nombre.ToUpper, "BUNGE") Or _
           InStr(nombre.ToUpper, "CARGILL") Then
            RellenarCeldaVaciaConCeldaSuperior(dtDestino)
        End If





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
            ErrHandler.WriteError("renglones antes de revisar numero de cartadeporte:" & renglonesOriginales & " Renglones despues:" & dtDestino.Rows.Count)

            If Debugger.IsAttached Then Stop
        End If
        'Debug.Assert(dtDestino.Rows.Count > 0, "Importacion vacía")




        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////
        'saco renglones que son de los colegas de Williams (excepto para NobleLima)

        Dim renglonesAntesDeFiltrarPorWilliams = dtDestino.Rows.Count

        If FormatoDelArchivo() <> NobleLima And FormatoDelArchivo() <> Renova Then

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
            ErrHandler.WriteError("Filtrando renglones de colegas.  renglones antes de revisar numero de cartadeporte:" & renglonesAntesDeFiltrarPorWilliams & " Renglones despues:" & dtDestino.Rows.Count)

            Stop
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
            ErrHandler.WriteError("Error al llamar GrabaExcelEnBase")
            ErrHandler.WriteAndRaiseError(ex)
        End Try

        Return dtDestino.Rows.Count
        'gvExcel.DataSource = dtOrigen
        'gvExcel.DataBind()

        'gvClientes.DataSource = ds
        'gvClientes.DataBind()

    End Function


    Sub verificarQueNoSeRepiteElIdMaestro()

    End Sub


    Sub FormatearColumnasDeCalidadesRamallo(ByRef dt As Data.DataTable)
        'excepcion BUNGE / RAMALLO: calidades en minicolumnas improvisadas para cada renglon
        '-pero esto no tiene que estar en postproduccion, sino en preproduccion

        '        HUMEDAD()
        'MERMA X HUMEDAD
        '        OTRAS(MERMAS)
        '        OBSERVACIONES()

        'tener en cuenta que en la columna de merma del exel el primer numero es la MERMA X HUMEDAD / las otras 2 sumadas van en OTRAS MERMAS
        '        ssss()

        Dim colRubros As Integer = 17, columnamerma As Integer = 15, colHumedad = 16 'As Integer


        dt.Columns.Add("MERMAXHUMEDAD")
        dt.Rows(0).Item("MERMAXHUMEDAD") = "MERMA"
        dt.Rows(1).Item("MERMAXHUMEDAD") = "MERMA"

        dt.Columns.Add("OBSERVACIONES")
        dt.Rows(0).Item("OBSERVACIONES") = "OBSERVACIONES"
        dt.Rows(1).Item("OBSERVACIONES") = "OBSERVACIONES"

        dt.Columns.Add("OTRASMERMAS")
        dt.Rows(0).Item("OTRASMERMAS") = "OTRASMERMAS"
        dt.Rows(1).Item("OTRASMERMAS") = "OTRASMERMAS"




        Dim mermaxhumedad As Long
        Dim otrasmermas As Long

        For r = 2 To dt.Rows.Count - 1 'empiezo en 2 para no pisar los encabezados... .no sé en qué renglon vendran
            Dim dr As DataRow = dt.Rows(r)
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
                ErrHandler.WriteError(ex)
            End Try

            Dim obs As String = ""

            For c = colRubros To colRubros + 10

                Try
                    obs &= dr.Item(c + 1).ToString & " "
                    '                    http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9841
                    '                    Lo que debe ir en observaciones es la concatenación de las tres columnas de rubros, por ejemplo:

                    'HUM 14,50	C.Ex. 01,50	Rev 00,50
                Catch ex As Exception

                End Try

                Try


                    Dim celda As String = dr.Item(c)
                    Dim pos As Integer = InStr(celda, "HUM ") '    DyR  / Gr.Amoh / Rev / C.Ex.
                    If pos > 0 Then
                        Dim calidad As Double = Val(Mid(celda, pos + 3).Replace(",", "."))

                        ' dr.Item("HUMEDAD") = calidad
                        dr.Item(colHumedad) = calidad
                    Else
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10066
                        '* Cuando el registro tiene solamente otras mermas (por ejemplo tiene un numero en MMA y en Rubros
                        ' dice \"C.Ex. 09,00\") los kg de merma, que vienen en MMA deben ir a otras mermas y están yendo a Mermas Por Humedad

                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try

            Next


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
    End Sub

    Sub ExcepcionTerminal6_UnirColumnasConPatente(ByRef dt As Data.DataTable, ByVal renglontitulos As Integer)
        Try
            Dim PATEcol = -1, NTEcol As Integer

            For c = 0 To dt.Columns.Count - 1 'me paseo por todas las columnas ....
                If dt.Rows(renglontitulos).Item(c) = "Pate" Then
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

        End Try
    End Sub

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
                        Stop 'columna de humedad
                    End If

                    dt.Rows(r + 1).Item(c) = dt.Rows(r).Item(c)
                End If
            Next

        Next
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////





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

        Dim dt = TraerExcelDeBase()
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

                c = GrabaRenglonEnTablaCDP(dt.Rows(r)) 'intenta grabar el renglon importado como una CDP

            Catch ex As Exception

                ErrHandler.WriteError(ex)
                Dim sError = "Error paso 1: " & ex.Source & " " & ex.Message

                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= sError & vbCrLf

                c = 0 'para que pase al renglon siguiente
            End Try

            If c = "0" Then r = r + 1
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
            Catch ex As Exception
                'La cuestion es aca. Consulta  http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8474

                '"centro de comercializacion de insumo" explota por lo largo? -síiiiiiii!!! y otros deben explotar por las comillas
                'se pasa de 50 caracteres. 


                ErrHandler.WriteError(ex)
                Dim sError = "Error paso 2: " & ex.Message
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
            '    ErrHandler.WriteError(ex)
            '    Dim sError = "Error al pisar la equivalencia en la importacion 3: " & ex.Message
            '    txtLogErrores.Visible = True
            '    If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
            '    txtLogErrores.Text &= sError & vbCrLf

            'End Try



        Else
            txtBuscarCliente.Enabled = False
            MsgBoxAjax(Me, "Se llegó al final de la planilla")
        End If



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

        Dim dt = DiccionarioEquivalenciasManager.TraerMetadata(HFSC.Value, lblPalabraNueva.Text)




       



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



    Function GrabaRenglonEnTablaCDP(ByRef dr As DataRow) As String 'devuelve la columna del error si es que hubo
        'Dim dt = ViewstateToDatatable()

        'Dim dr = dt.Rows(row)

        Dim myCartaDePorte As New Pronto.ERP.BO.CartaDePorte


        'If existeLaCarta Then
        Dim numeroCarta As Long = Val(Replace(dr.Item("NumeroCDP"), "-", ""))
        Dim vagon As Long = 0 'por ahora, las cdp importadas tendran subnumero 0
        Dim subfijo As Long = 0 'por ahora, las cdp importadas tendran subnumero 0

        myCartaDePorte = CartaDePorteManager.GetItemPorNumero(SC, numeroCarta, vagon)

        'y si tiene duplicados, como sabes?


        'End If

        With myCartaDePorte

            If .IdFacturaImputada > 0 Then
                'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
                ErrHandler.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque ya existe como facturada")
                Return 0
            End If


            If .NetoFinalSinMermas > 0 Or .NetoFinalIncluyendoMermas > 0 Then
                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9095
                'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada, porque ya existe como facturada o rechazada")
                ErrHandler.WriteAndRaiseError("La Carta " & numeroCarta & " " & IIf(vagon = 0, "", vagon) & " está en estado <descarga> y no se le pueden pisar datos. ")
                Return 0
            End If


            If .Anulada = "SI" Then
                ErrHandler.WriteError("La Carta " & numeroCarta & " estaba anulada. Se reestablece")
                LogPronto(SC, .Id, "IMPANU", Session(SESSIONPRONTO_UserName))
                CartaDePorteManager.CopiarEnHistorico(SC, ID)    'hacer historico siempre en las modificaciones de cartas y clientes?

                .Anulada = "NO"
            End If




            If .Id > 0 And .SubnumeroDeFacturacion > -1 Then

                Dim q As IQueryable(Of CartasDePorte) = CartaDePorteManager.FamiliaDeDuplicadosDeCartasPorte(SC, myCartaDePorte)

                If q.Count > 1 Then
                    'MsgBoxAjax(Me, "La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
                    ErrHandler.WriteAndRaiseError("La Carta " & numeroCarta & " no puede ser importada porque está duplicada para facturarsele a varios clientes")
                    Return 0
                End If

            ElseIf .Id <= 0 Then
                .SubnumeroDeFacturacion = -1
            End If



            'Pinta que no hay otra manera de actualizar un dataset suelto http://forums.asp.net/p/755961/1012665.aspx
            .NumeroCartaDePorte = numeroCarta
            .SubnumeroVagon = vagon
            If .NumeroCartaDePorte <= 0 Then
                'Debug.Print(r.Item("Carta Porte"))
                'renglonControl(r, "Carta Porte").BackColor = System.Drawing.Color.Red
                Stop
                Return 0
            End If



            '/////////////////////////////////////////
            '/////////////////////////////////////////

            dr.Item("Producto") = iisNull(dr.Item("Producto"))
            If dr.Item("Producto") <> "NO_VALIDAR" Then
                .IdArticulo = BuscaIdArticuloPreciso(dr.Item("Producto"), SC)
                If .IdArticulo = -1 Then .IdArticulo = BuscaIdArticuloPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Producto")), SC)
                'dt.Rows(row).Item("IdArticulo") = .IdArticulo
                If .IdArticulo = -1 Then Return "Producto"
            End If

            '/////////////////////////////////////////

            dr.Item("Titular") = iisNull(dr.Item("Titular"))
            If dr.Item("Titular") <> "NO_VALIDAR" Then
                .Titular = BuscaIdClientePrecisoConCUIT(dr.Item("Titular"), SC)
                If .Titular = -1 Then .Titular = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Titular")), SC)
                dr.Item("IdTitular") = .Titular
                If .Titular = -1 Then Return "Titular"
            End If


            dr.Item("Intermediario") = iisNull(dr.Item("Intermediario"))
            If dr.Item("Intermediario") <> "NO_VALIDAR" And dr.Item("Intermediario") <> "" Then
                .CuentaOrden1 = BuscaIdClientePrecisoConCUIT(dr.Item("Intermediario"), SC)
                If .CuentaOrden1 = -1 Then .CuentaOrden1 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Intermediario")), SC)
                dr.Item("IdIntermediario") = .CuentaOrden1
                If .CuentaOrden1 = -1 Then Return "Intermediario"
            End If


            dr.Item("RComercial") = iisNull(dr.Item("RComercial"))
            If dr.Item("RComercial") <> "NO_VALIDAR" And dr.Item("RComercial") <> "" Then
                .CuentaOrden2 = BuscaIdClientePrecisoConCUIT(dr.Item("RComercial"), SC)
                If .CuentaOrden2 = -1 Then .CuentaOrden2 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("RComercial")), SC)
                dr.Item("IdRComercial") = .CuentaOrden2
                If .CuentaOrden2 = -1 Then Return "RComercial"
            End If



            dr.Item("Corredor") = iisNull(dr.Item("Corredor"))
            If dr.Item("Corredor") <> "NO_VALIDAR" Then
                .Corredor = BuscaIdVendedorPrecisoConCUIT(dr.Item("Corredor"), SC)
                If .Corredor = -1 Then .Corredor = BuscaIdVendedorPrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Corredor")), SC)
                dr.Item("IdCorredor") = .Corredor
                If .Corredor = -1 Then Return "Corredor"
            End If





            dr.Item("Comprador") = iisNull(dr.Item("Comprador"))
            If dr.Item("Comprador") <> "NO_VALIDAR" Then
                .Entregador = BuscaIdClientePrecisoConCUIT(dr.Item("Comprador"), SC)
                If .Entregador = -1 Then .Entregador = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Comprador")), SC)
                dr.Item("IdDestinatario") = .Entregador
                If .Entregador = -1 Then
                    'solo uso el default si está vacío el texto
                    If dr.Item("Comprador") = "" Then .Entregador = BuscaIdClientePrecisoConCUIT(txtDestinatario.Text, SC)

                    'si sigue con problemas, pido la equivalencia al usuario
                    If .Entregador = -1 Then Return "Comprador"
                End If
            End If


            '/////////////////////////////////////////





            dr.Item("Procedencia") = iisNull(dr.Item("Procedencia"))
            If dr.Item("Procedencia") <> "NO_VALIDAR" Then
                .Procedencia = BuscaIdLocalidadPreciso(RTrim(dr.Item("Procedencia")), SC)
                If .Procedencia = -1 Then .Procedencia = BuscaIdLocalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Procedencia")), SC)
                'dt.Rows(row).Item("IdProcedencia") = .Procedencia
                If .Procedencia = -1 Then Return "Procedencia"
            End If



            dr.Item("Destino") = iisNull(dr.Item("Destino"))
            If dr.Item("Destino") <> "NO_VALIDAR" Then
                .Destino = BuscaIdWilliamsDestinoPreciso(RTrim(dr.Item("Destino")), SC)
                If .Destino = -1 Then .Destino = BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Destino")), SC)
                'dt.Rows(row).Item("IdDestino") = .Destino
                If .Destino = -1 And dr.Item("Destino") = "" Then
                    'solo uso el default si está vacío el texto
                    .Destino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC)
                End If
                If .Destino = -1 Then
                    Return "Destino"
                Else
                    AsignarContratistasSegunDestino(dr)
                End If
            End If



            '/////////////////////////////////////////



            dr.Item("Subcontratista1") = iisNull(dr.Item("Subcontratista1"))
            If dr.Item("Subcontratista1") <> "NO_VALIDAR" And dr.Item("Subcontratista1") <> "" Then
                .Subcontr1 = BuscaIdClientePrecisoConCUIT(dr.Item("Subcontratista1"), SC)
                If .Subcontr1 = -1 Then .Subcontr1 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Subcontratista1")), SC)
                If .Subcontr1 = -1 Then Return "Subcontratista1"
            End If


            dr.Item("Subcontratista2") = iisNull(dr.Item("Subcontratista2"))
            If dr.Item("Subcontratista2") <> "NO_VALIDAR" And dr.Item("Subcontratista2") <> "" Then
                .Subcontr2 = BuscaIdClientePrecisoConCUIT(dr.Item("Subcontratista2"), SC)
                If .Subcontr2 = -1 Then .Subcontr2 = BuscaIdClientePrecisoConCUIT(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Subcontratista2")), SC)
                If .Subcontr2 = -1 Then Return "Subcontratista2"
            End If

            CartaDePorteManager.ReasignoTarifaSubcontratistas(SC, myCartaDePorte)

            '/////////////////////////////////////////



            dr.Item("column21") = iisNull(dr.Item("column21"))
            If dr.Item("column21") <> "NO_VALIDAR" And dr.Item("column21") <> "" Then
                .IdTransportista = BuscaIdTransportistaPreciso(dr.Item("column21"), SC)
                If .IdTransportista = -1 Then .IdTransportista = BuscaIdTransportistaPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column21")), SC)
                If .IdTransportista = -1 Then Return "column21"
            End If


            dr.Item("column23") = iisNull(dr.Item("column23"))
            If dr.Item("column23") <> "NO_VALIDAR" And dr.Item("column23") <> "" Then
                .IdChofer = BuscaIdChoferPreciso(dr.Item("column23"), SC)
                If .IdChofer = -1 Then .IdChofer = BuscaIdChoferPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("column23")), SC)
                If .IdChofer = -1 Then Return "column23"
            End If



            '/////////////////////////////////////////

            dr.Item("Calidad") = iisNull(dr.Item("Calidad"))
            If dr.Item("Calidad") <> "NO_VALIDAR" And dr.Item("Calidad") <> "" Then
                .CalidadDe = BuscaIdCalidadPreciso(RTrim(iisNull(dr.Item("Calidad"))), SC)
                If .CalidadDe = -1 Then .CalidadDe = BuscaIdCalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, dr.Item("Calidad")), SC)
                If .CalidadDe = -1 Then Return "Calidad"
            End If





            .Patente = iisNull(dr.Item("Patente"))
            .Acoplado = iisNull(dr.Item("Acoplado"))


            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            'Persistencia de las pesadas
            '//////////////////////////////////////////////////////////////////////////////

            ' http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9095

            actualizar(.NetoPto, dr.Item("NetoProc"))

            '.NetoPto = IIf( StringToDecimal(iisNull(dr.Item("NetoProc"))) 

            actualizar(.BrutoFinal, dr.Item("column12"))
            actualizar(.TaraFinal, dr.Item("column13"))
            actualizar(.NetoFinalIncluyendoMermas, dr.Item("column14"))



            actualizar(.Humedad, dr.Item("column15"))

            actualizar(.HumedadDesnormalizada, dr.Item("column16"))
            If .HumedadDesnormalizada = 0 And .Humedad <> 0 And .IdArticulo > 0 Then
                Dim porcentajemerma = CartaDePorteManager.BuscaMermaSegunHumedadArticulo(SC, .IdArticulo, .Humedad)
                .HumedadDesnormalizada = porcentajemerma / 100 * .NetoFinalIncluyendoMermas
            End If

            '.Merma = 0 'la piso, por si ya se importó antes

            If Val(dr.Item("Auxiliar5").ToString) > 0 Then
                If .Merma = 0 Then
                    .Merma = Val(dr.Item("Auxiliar5").ToString)
                End If
            End If



            actualizar(.NetoFinalSinMermas, dr.Item("column17"))
            If .NetoFinalSinMermas = 0 Then
                'recalcular()
                .NetoFinalSinMermas = .NetoFinalIncluyendoMermas - .HumedadDesnormalizada
            Else
                'que pasa si lo que viene en el excel es distinto de lo calculado?
            End If


            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////

            If Val(iisNull(dr.Item("column20"))) > 0 Then .CEE = Val(iisNull(dr.Item("column20")))


            actualizar(.FechaDeCarga, dr.Item("column18"))
            actualizar(.FechaVencimiento, (dr.Item("column19")))



            actualizar(.FechaDescarga, iisValidSqlDate(TextoAFecha(iisNull(dr.Item("FechaDescarga"), IIf(.NetoFinalIncluyendoMermas > 0, Today, Nothing)))))




            'If iisNull(.FechaArribo, #12:00:00 AM#) = #12:00:00 AM# Then
            actualizar(.FechaArribo, txtFechaArribo.Text)
            'End If
            '.Merma = StringToDecimal(dr.Item("column16")) 'este es el otras mermas

            actualizar(.Observaciones, dr.Item("column25"))

            If .NetoFinalSinMermas <> .NetoFinalIncluyendoMermas - .HumedadDesnormalizada And iisNull(dr.Item("column17"), 0) <> 0 Then
                .Observaciones &= " (AVISO: renglon importado con incoherencias entre la merma y los netos -->  Neto importado: " & .NetoFinalSinMermas & "     Neto calculado:" & .NetoFinalIncluyendoMermas - .HumedadDesnormalizada & " =" & .NetoFinalIncluyendoMermas & "-" & .HumedadDesnormalizada & "   )"
            End If


            If Val(iisNull(dr.Item("CTG"))) > 0 Then .CTG = Val(iisNull(dr.Item("CTG")))

            actualizar(.TarifaTransportista, dr.Item("TarifaTransportista"))
            actualizar(.KmARecorrer, dr.Item("KmARecorrer"))



            .PuntoVenta = cmbPuntoVenta.SelectedValue ' Val(iisNull(EmpleadoManager.GetItem(SC, session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado, 1))

            actualizar(.Cosecha, (Year(.FechaArribo) - 1) & "/" & Right(Year(.FechaArribo), 2))


            'sector del confeccionó



            Dim ms As String
            If CartaDePorteManager.IsValid(SC, myCartaDePorte, ms) Then
                '                Try


                Try
                    'EntidadManager.LogPronto(HFSC.Value, id, "CartaPorte Anulacion de posiciones ", Session(SESSIONPRONTO_UserName))

                    'loguear el formato usado   y el nombre del archivo importado
                    Dim nombre = Session("NombreArchivoSubido")
                    Dim formato = FormatoDelArchivo(nombre)
                    Dim s = " F:" + formato.ToString + " " + nombre


                    EntidadManager.Tarea(SC, "Log_InsertarRegistro", "IMPORT", _
                                              .Id, 0, Now, 0, "Tabla : CartaPorte", "", Session(SESSIONPRONTO_UserName), _
                                             s, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                                            DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, DBNull.Value, _
                                            DBNull.Value, DBNull.Value, DBNull.Value)



                    'GetStoreProcedure(SC, enumSPs.Log_InsertarRegistro, IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
                    '                          CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario)

                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                End Try


                If CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName)) = -1 Then
                    Debug.Print("No se pudo grabar el renglon n° " & myCartaDePorte.NumeroCartaDePorte)
                    ErrHandler.WriteError("Error al grabar CDP importada")
                Else
                    'poner url hacia el ABM
                    'Response.Redirect(String.Format("CartaDePorte.aspx?Id={0}", IdCartaDePorte.ToString))

                    'Dim hl As WebControls.HyperLink = CType(r.Cells(getGridIDcolbyHeader("Ir a", gvExcel)).Controls(1), WebControls.HyperLink)
                    'hl.NavigateUrl = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)
                    dr.Item("URLgenerada") = String.Format("CartaDePorte.aspx?Id={0}", myCartaDePorte.Id.ToString)

                End If

            Else
                Dim sError = "Error al validar CDP importada: " & myCartaDePorte.NumeroCartaDePorte & " " & ms
                ErrHandler.WriteError(sError)
                txtLogErrores.Visible = True
                If txtLogErrores.Text = "" Then txtLogErrores.Text = "Errores: " & vbCrLf
                txtLogErrores.Text &= sError & vbCrLf
            End If

        End With

        Return 0
    End Function


    Sub actualizar(ByRef Destino As Double, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As Double = StringToDecimal(iisNull(OrigenDataRowItem))
        If temp <> 0 Then
            Destino = temp
        End If


        'End If

    End Sub

    Sub actualizar(ByRef Destino As Date, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As Object = iisValidSqlDate(TextoAFecha(iisNull(OrigenDataRowItem)))
        If Not temp Is Nothing Then
            Destino = temp
        End If


        'End If

    End Sub


    Sub actualizar(ByRef Destino As String, ByVal OrigenDataRowItem As Object)

        'todas estas volteretas para no pisar si ya hay dato 

        'If Destino = 0 Then

        Dim temp As String = iisNull(OrigenDataRowItem)
        If temp <> "" Then
            Destino = temp
        End If


        'End If

    End Sub


    Sub AsignarContratistasSegunDestino(ByVal dr As DataRow)
        With dr
            Dim iddest = BuscaIdWilliamsDestinoPreciso(.Item("Destino"), SC)

            If iddest <> -1 Then
                If iisNull(.Item("Subcontratista1"), "") = "" Then
                    Dim idcli1 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista1")
                    If IsNumeric(idcli1) Then
                        .Item("Subcontratista1") = EntidadManager.GetItem(SC, "Clientes", idcli1).Item("RazonSocial")
                    End If
                End If


                If iisNull(.Item("Subcontratista2"), "") = "" Then
                    Dim idcli2 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista2")
                    If IsNumeric(idcli2) Then
                        .Item("Subcontratista2") = EntidadManager.GetItem(SC, "Clientes", idcli2).Item("RazonSocial")
                    End If
                End If

            End If
        End With
    End Sub



    Sub Empezar()
        lblVistaPrevia.Visible = False
        panelEquivalencias.Visible = True
        btnEmpezarImportacion.Visible = False
        gvExcel.PageSize = 1
        ViewState("Row") = 0

        gvExcel.DataBind() 'para que no ocupe 5 renglones toda la pantalla si llega al final de la planilla sin encontrar errores

        proximoerror(TraerExcelDeBase())

    End Sub

    Sub MostrarPrimerosDiezRenglones()
        Dim nombre = Session("NombreArchivoSubido")  ' NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
        FormatoDelArchivo(nombre)

        Dim N = 6
        gvExcel.PageSize = N
        gvExcel.DataSource = GetTopN(TraerExcelDeBase, N)  'GetTopN???? -Pagina el dataset. Como no pone Start, es como un TOP (en .NET, no en SQL, es decir, es lento)
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




    Function TraerExcelDeBase() As Data.DataTable

        'Dim dtBase = ExcelImportadorManager.TraerMetadata(SC)
        Dim dtBase As Data.DataTable

        Try
            dtBase = ExcelImportadorManager.TraerMetadataPorIdMaestro(SC, m_IdMaestro)
        Catch ex As Exception
            ErrHandler.WriteError("Problemas con IdMaestro? Quizas no pude importar filas. " & ex.Message)
            'esta explotando porque no encuentra el idmaestro? por qué?
            '-en el unico lugar donde se asigna el IdMaestro es al final de FormatearExcel. Quizas 
            'no llega a ejecutarse porque no se pudieron importar filas
        End Try




        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        'OPTIMIZAR
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        'METODO 1: formateo dtExcel y le copio dtBase

        'Dim dtExcel = TablaFormato()

        'For Each drBase As DataRow In dtBase.Rows

        '    Dim drExcel = dtExcel.NewRow()

        '    For c As Integer = 0 To dtExcel.Columns.Count - 1
        '        Try
        '            drExcel(c) = drBase("Excel" & (c + 1))
        '        Catch ex As Exception
        '        End Try
        '    Next


        '    drExcel("IdExcelImportador") = drBase("IdExcelImportador")

        '    dtExcel.Rows.Add(drExcel)
        'Next


        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'Metodo 2: modifico directamente dtBase, para que no tarde tanto
        Dim dtExcel = dtBase

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////




        'Pongo los nombres de columna que figuran serializados en Observaciones

        'Dim nombres = Split(dtBase.Rows(0).Item("Observaciones"), "|")
        ''For c As Integer = 0 To dtExcel.Columns.Count - 1
        ''    dtExcel.Columns(c).ColumnName = "col" & c
        ''Next

        'For c As Integer = 0 To nombres.Length - 2
        '    Try
        '        dtExcel.Columns("Excel" & (c + 1)).ColumnName = nombres(c)
        '    Catch ex As Exception

        '    End Try
        'Next

        'For c As Integer = 0 To 50 ' (dtExcel.Columns.Count - 1)
        '    If Left(dtExcel.Columns(c).ColumnName, 5) = "Excel" Then dtExcel.Columns.RemoveAt(c)
        'Next



        Return dtExcel
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






    Function FormatoDelArchivo(Optional ByVal sNombreArchivoImportado As String = "") As FormatosDeExcel
        '"Bunge Ramallo" 
        '"Cargill Planta Quebracho"
        '"Cargill Pta Alvear"
        '"LDC Gral Lagos" 
        '"LDC Planta Timbues"
        '"Muelle Pampa"
        '"Terminal 6"
        '"Toepfer Pto El Transito"
        '"Toepfer Destino"
        '"VICENTIN"


        If cmbFormato.SelectedIndex <> Autodetectar Then Return [Enum].Parse(GetType(FormatosDeExcel), cmbFormato.SelectedItem.Value.ToString)




        If InStr(sNombreArchivoImportado.ToString.ToUpper, ".TXT") > 0 Then
            If InStr(sNombreArchivoImportado.ToString.ToUpper, "DESCAR") = 0 Then
                cmbFormato.SelectedIndex = FormatosDeExcel.PuertoACA
            Else
                cmbFormato.SelectedIndex = FormatosDeExcel.Reyser
            End If
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "BUNGE") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.BungeRamallo
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "PAMPA") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.MuellePampa
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "TIMBUES") > 0 Or InStr(sNombreArchivoImportado.ToString.ToUpper, "LDC") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.LDCPlantaTimbues
        ElseIf InStr(sNombreArchivoImportado.ToString.ToUpper, "VICENT") > 0 Then
            cmbFormato.SelectedIndex = FormatosDeExcel.VICENTIN
        End If


        Return cmbFormato.SelectedIndex


        'http://stackoverflow.com/questions/1061228/c-sharp-explicit-cast-string-to-enum
        'http://stackoverflow.com/questions/424366/c-sharp-string-enums
        'return (T)Enum.Parse(typeof(T), str)

        'If cmbFormato.SelectedValue = "PuertoACA" Then 'formato CSV
        '    Return PuertoACA
        'ElseIf cmbFormato.SelectedValue = "AdmServPortuarios" Then

        '    Return -1

        'ElseIf cmbFormato.SelectedValue = "Toepfer Transito" Or InStr(nombre.ToUpper, "TRANSITO") Then

        '    ds = GetExcel(DIRFTP + nombre, 3) 'hoja 3

        'ElseIf InStr(nombre.ToUpper, "TOEPFER") Then

        '    ds = GetExcel(DIRFTP + nombre, 1)

        'ElseIf cmbFormato.SelectedValue = "Cargill" Or InStr(nombre.ToUpper, "CARGILL") Then

        '    ds = GetExcel(DIRFTP + nombre, 1) 'hoja 1

        'Else

        '    ds = GetExcel(DIRFTP + nombre)

        'End If
    End Function

End Class






<Serializable()> _
Public Class ExcelImportador
    Public Descripcion As String
End Class

Public Class ExcelImportadorManager

    Const Tabla = "ExcelImportador"
    Const IdTabla = "IdExcelImportador"

    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx










    Private Shared Function HermanarLeyendaConColumna_aCadena(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As FormatosDeExcel = Nothing) As String
        s = Trim(s)

        Dim excep = ExcepcionHermanado(s, sNombreArchivoImportado, LetraColumna, formato)
        If excep <> enumColumnasDeGrillaFinal._Desconocido Then
            Return excep.ToString
        End If

        Select Case s
            Case "PRODUCTO", "PROD.", "MERC.", "MER", "GRANO", "MERCADERIA", "PROD"
                Return "Producto"

            Case "VENDEDOR", "CARGADOR", "TITULAR DE CARTA DE PORTE", "REMITENTE", "TITULAR CP", "TITULAR"
                Return "Titular" 'fijate que si está "remitente" solito, se usa Titular

            Case "CUENTA ORDEN 1", "1º CTA./ORDEN", "1º CTA./ORD.", "CY O 1", "C Y O 1", "CYO 1", "C/ORDEN 1", "C/O 1", "INTERMEDIARIO"
                Return "Intermediario"

            Case "CUENTA ORDEN 2", "2º CTA./ORDEN", "2º CTA./ORD.", "CY O 2", "C Y O 2", "CYO 2", "C/ORDEN 2", "C/O 2", "REMITENTE COMERCIAL", "REMIT COMERC", "RTE. COMERCIAL", "RTE.COMERCIAL", "R.COMERCIAL", "REMIT COMERCIAL"

                Return "RComercial"

            Case "CORREDOR"
                Return "Corredor"

            Case "ENTREGADOR", "REPRESENTANTE", "ENTREG"
                Return "EntregadorFiltrarPorWilliams" 'el entregador es el mismísimo Williams

            Case "DESTINATARIO", "EXPORTADOR", "EXPORT.", "COMPRADOR", "EXP", "EXP.", "DEST."
                Return "Comprador"

            Case "CARTA PORTE", "C/PORTE", "C. PORTE", "C.PORTE", "C. P.", "CP.", "CCPP", "CC PP", "CARTA DE PORTE", "CP"
                Return "NumeroCDP"



            Case "PROCEDENCIA", "PROCED", "PROCENDECIA", "PROCED.", "LOCALIDAD", "PROC", "PROC."

                Return "Procedencia"


            Case "DESTINO"
                Return "Destino"

            Case "SUBCONTRATISTAS"

                Return "Subcontratistas"

            Case "CALIDAD", "CALID."
                Return "Calidad"

            Case "F. DE CARGA"
                Return "column18"

            Case "F. DE DESCARGA", "FECHA"
                Return "FechaDescarga"




            Case "CONTRATO"
                'no lo estas importando.....


            Case "TURNO"
                'return  
            Case "PATENTE", "PAT CHASIS", "PTE.", "PATE", "CHASIS"
                Return "Patente"
            Case "ACOPLADO", "ACOPL", "PAT.ACOP."

                Return "Acoplado"


                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '   Pesajes en la procedencia/origen (ficha de posicion)
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "NETO PROC", "KG", "KG. PROC.", "KG,PROC", "KG P", _
                    "KGS", "KGS ORIGEN" '"KGS." qué va a ser? Neto proc o Neto Pto???

                'conflicto "PROC": lo usa "Las Palmas" para "Procedencia"
                Return "NetoProc"


                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '   Pesajes en el destino/puerto (se ven en la ficha de descarga)
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "BRUTO PTO", "BRUTO", "BRUTO BUNGE"
                Return "column12"
            Case "TARA PTO", "TARA", "TARA BUNGE"
                Return "column13"
            Case "NETO PTO", "NETO", "KG. DESC.", "KGS.", "KG.DESC", "DESC.", "NETO BUNGE", "DESC"
                Return "column14"

                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                'mermas y neto total final
                '/////////////////////////////////////////////////////////////////////////

            Case "HUMEDAD", "H", "GDO/HUM", "HUM"
                Return "column15"
            Case "MERMA", "MERMA Y/O REBAJAS", "MMA/H", "MMA"
                Return "column16"

            Case "OTRASMERMAS"
                Return "Auxiliar5" '"OtrasMermas"

            Case "NETO FINAL", "FINAL"
                Return "column17"


                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////
                '/////////////////////////////////////////////////////////////////////////

            Case "F. DE CARGA", "FEC.CARGA"
                Return "column18"
            Case "FECHA VTO.", "FEC.VTO."
                Return "column19"
            Case "C.E.E", "C.E.E NRO", "NRO.CEE", "NRO. CEE"
                Return "column20"
            Case "TRANSPORTISTA", "TRANSP.", "TRANSPORTE"
                Return "column21"
            Case "CUIT TRANS"
                Return "column22"
            Case "CHOFER", "NOMBRE CHOFER"
                Return "column23"
            Case "CUIT CHOFER"
                Return "column24"
            Case "OBSERVACIONES.", "OBSERVACIONES", "OBSERVACION", "OBSERV.", "MER/REB", "ANÁLISIS"
                Return "column25"



            Case "NRO. CTG", "CTG"
                Return "CTG"
            Case "KM"
                Return "KmARecorrer"
            Case "TAR.FLETE", "TARIFA"
                Return "TarifaTransportista"



            Case Else
                Debug.Print(s)
                Return ""



                'qué tendría que hacer para agregar nuevas columnas? (ctg, tarifa, 
                '-agregarlas en:
                '   la tabla temporal
                '   acá en el HermanarViejo
                '   a la enumeracion
                '   a la grilla
                '   a la GrabaRenglonEnTablaCDP
                'tambien sería bueno que estuviesen las columnas tipadas....


        End Select
    End Function




    Enum enumColumnasDeGrillaFinal As Integer
        Producto
        Titular
        Intermediario
        RComercial
        Corredor
        Comprador
        NumeroCDP
        Procedencia
        Destino
        Subcontratistas
        Calidad
        column18
        FechaDescarga
        Patente
        Acoplado
        NetoProc
        column12
        column13
        column14
        column15
        column16
        column17
        column19
        column20
        column21
        column22
        column23
        column24
        column25

        Auxiliar5

        CTG
        KmARecorrer
        TarifaTransportista

        EntregadorFiltrarPorWilliams 'columna que se debe filtrar en el excel para quedarnos solamente con las cartas de williams

        _Desconocido
    End Enum



    Shared Function HermanarLeyendaConColumna(ByVal s As String, Optional ByVal sNombreArchivoImportado As String = "", Optional ByVal LetraColumna As Integer = -1, Optional ByVal formato As FormatosDeExcel = Nothing) As String
        Dim sRet As String = HermanarLeyendaConColumna_aCadena(s, sNombreArchivoImportado, LetraColumna, formato)

        If sRet = "" Then sRet = "_Desconocido" 'trucheo. arreglar

        Dim enumEntidad As enumColumnasDeGrillaFinal = [Enum].Parse(GetType(enumColumnasDeGrillaFinal), sRet)

        Dim reconversion As String = enumEntidad.ToString
        If reconversion = "_Desconocido" Then reconversion = "" 'trucheo. arreglar


        Return reconversion
    End Function





    Shared Function RenglonTitulos(ByRef dtOrigen As Data.DataTable, ByVal nombre As String, ByVal fa As FormatosDeExcel) As Integer
        Dim renglonDeTitulos As Integer = -1
        Dim row As DataRow


        'busco el renglon (desde ABAJO para ARRIBA!!) con los titulos para despues hacer el macheo
        For j = dtOrigen.Rows.Count - 1 To 0 Step -1
            row = dtOrigen.Rows(j)
            If row.Item("column1").ToString.ToUpper = "PRODUCTO" _
            Or row.Item("column1").ToString.ToUpper = "ENTREGADOR" _
            Or row.Item("column1").ToString.ToUpper = "EXPORT." _
            Or row.Item("column1").ToString.ToUpper = "PROCENDECIA." _
            Or row.Item("column1").ToString.ToUpper = "MER" _
            Or row.Item("column1").ToString.ToUpper = "MERCADERIA" _
            Or row.Item("column1").ToString.ToUpper = "CARGADOR" _
            Or row.Item("column1").ToString.ToUpper = "F. DE CARGA" _
            Or row.Item("column2").ToString.ToUpper = "VENDEDOR" _
            Or row.Item("column2").ToString.ToUpper = "GRANO" _
            Or row.Item("column2").ToString.ToUpper = "TURNO" Then
                renglonDeTitulos = j
            End If
        Next



        Try
            If renglonDeTitulos = -1 Then
                'probar siendo mas flexible, solo en los primeros 3 renglones
                For j = Min(2, dtOrigen.Rows.Count - 1) To 0 Step -1
                    row = dtOrigen.Rows(j)
                    Dim s = row.Item("column1").ToString.ToUpper
                    If HermanarLeyendaConColumna(s, nombre, , fa) <> "" Then
                        renglonDeTitulos = j
                    End If
                Next


                If renglonDeTitulos = -1 Then
                    'probar en la segunda columna
                    For j = Min(5, dtOrigen.Rows.Count - 1) To 0 Step -1
                        row = dtOrigen.Rows(j)
                        Dim s = row.Item("column2").ToString.ToUpper
                        If HermanarLeyendaConColumna(s, nombre, , fa) <> "" Then
                            renglonDeTitulos = j
                        End If
                    Next
                End If


                'Stop
                If renglonDeTitulos = -1 Then

                    ErrHandler.WriteError("No se encontró el renglon de titulos. Renglones totales:" & dtOrigen.Rows.Count)


                    Stop
                    Return -1 'me rindo
                End If
            End If



        Catch ex As Exception
            ErrHandler.WriteError("No se encontró el renglon de titulos. Renglones totales:" & dtOrigen.Rows.Count)
            Stop
            Return -1 'me rindo
        End Try


        Return renglonDeTitulos
    End Function



    Shared Function ExcepcionHermanado(ByVal s As String, ByVal sNombreArchivoImportado As String, ByVal LetraColumna As Integer, ByVal FormatoDelArchivo As FormatosDeExcel) As enumColumnasDeGrillaFinal
        'Consulta 5784
        '        Bunge
        'VENDEDOR es Destinatario (generalmente es Titular)
        'NETO es Neto proc (generalmente es Neto Pto)

        '        Timbues
        'KGS. es Neto Proc (generalmente es Neto Pto)




        'If cmbFormato.SelectedValue = "Toepfer Transito" Then


        Select Case FormatoDelArchivo
            Case BungeRamallo
                If s = "CARGADOR" Then
                    Return enumColumnasDeGrillaFinal.Intermediario 'en lugar de vendedor/titular
                ElseIf s = "C/ORDEN 1" Then
                    Return enumColumnasDeGrillaFinal.RComercial 'en lugar de intermediario
                ElseIf s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf s = "RUBROS" Then
                    Return enumColumnasDeGrillaFinal.column15
                ElseIf LetraColumna = 19 Then '"U" Then
                    'Return enumColumnasDeGrillaFinal.column25
                End If
            Case MuellePampa, Terminal6, NobleLima
                If s = "NETO" Then
                    'en bunge muelle pampa usa "neto" para el netoproc
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
            Case LDCPlantaTimbues, LDCGralLagos
                If s = "KGS." Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf s = "PROC" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                ElseIf LetraColumna = 13 Then ' "N" Then
                    'columna N en timbues (columna sin titulo) es OBSERVACIONES
                    Return enumColumnasDeGrillaFinal.column25
                End If
            Case VICENTIN

                If s = "DESC" Or s = "KILOS" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
            Case VICENTIN_ExcepcionTagRemitenteConflictivo

                If s = "REMITENTE" Then
                    Return enumColumnasDeGrillaFinal.Titular
                End If
                If s = "REMITENTE COMERCIAL" Then
                    Return enumColumnasDeGrillaFinal.RComercial
                End If

            Case Renova
                If s = "FECHA" Then
                    Return enumColumnasDeGrillaFinal.column18
                End If
                If s = "NETO" Then
                    Return enumColumnasDeGrillaFinal.NetoProc
                End If
                If s = "ACOPLADO" Then
                    Return enumColumnasDeGrillaFinal.column24 'no te sirve poner _desconocido:  HermanarLeyenda() en ese caso se fija qué pasa. Lo mando entonces a una columna sin consecuencias (CUIT CHOFER)
                End If
                If s = "PATENTE" Then
                    Return enumColumnasDeGrillaFinal.column24
                End If


        End Select





        Return enumColumnasDeGrillaFinal._Desconocido
    End Function



    Public Enum FormatosDeExcel
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        Autodetectar
        PuertoACA
        BungeRamallo
        CargillPlantaQuebracho
        CargillPtaAlvear
        LDCGralLagos
        LDCPlantaTimbues
        MuellePampa
        NobleLima
        Renova
        Terminal6
        ToepferPtoElTransito
        Toepfer
        VICENTIN
        VICENTIN_ExcepcionTagRemitenteConflictivo
        Reyser
        ReyserAnalisis
        Unidad6
        Unidad6PlayaPerez
        Unidad6Analisis
        AdmServPortuarios

        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
        'esta enumeracion debe tener el mismo orden que el combo
    End Enum





    Public Shared Function TraerMetadataPorIdMaestro(ByVal SC As String, Optional ByVal id As Integer = -1) As Data.DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & "IdTanda" & "=" & id)
        End If
    End Function


    Public Shared Function TraerMetadataPorIdDetalle(ByVal SC As String, Optional ByVal id As Integer = -1) As Data.DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
        End If
    End Function

    Public Shared Function Insert(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)

        Try
            adapterForTable1.Update(dt)
        Catch ex As Exception
            ErrHandler.WriteError("ExcelImportadorManager.Insert()  " & ex.Message)
            Stop
            Throw
        End Try



        'Dim r = ExecDinamico(SC, "SELECT TOP 1 idListaPrecios from  " & Tabla & " order by idListaPrecios DESC")
        'Return r.Rows(0).Item(0)

    End Function





    Public Shared Function Fetch(ByVal SC As String) As Data.DataTable

        'Return EntidadManager.ExecDinamico(SC, Tabla & "_TT") 

        'el Trasnportistas_TT esta usando INNER JOIN
        Dim s = "Select " & _
     "Transportistas.IdTransportista, " & _
     "Transportistas.RazonSocial,  " & _
     "Transportistas.Direccion,  " & _
     "Localidades.Nombre AS [Localidad],  " & _
     "Transportistas.CodigoPostal,  " & _
     "Provincias.Nombre AS [Provincia],  " & _
     "Paises.Descripcion AS [Pais],  " & _
     "Transportistas.Telefono,  " & _
     "Transportistas.Fax,  " & _
     "Transportistas.Email,  " & _
     "Transportistas.Cuit,  " & _
     "DescripcionIva.Descripcion AS [Condicion IVA],  " & _
     "Transportistas.Contacto, " & _
     "Transportistas.Horario, " & _
        "    Transportistas.Celular " & _
        "    FROM Transportistas " & _
     "LEFT JOIN DescripcionIva ON Transportistas.IdCodigoIva = DescripcionIva.IdCodigoIva  " & _
     "LEFT JOIN Localidades ON Transportistas.IdLocalidad = Localidades.IdLocalidad  " & _
     "LEFT JOIN Provincias ON Transportistas.IdProvincia = Provincias.IdProvincia " & _
     "LEFT JOIN Paises ON Transportistas.IdPais = Paises.IdPais " & _
        "ORDER BY Transportistas.RazonSocial "

        Return EntidadManager.ExecDinamico(SC, s)


    End Function


    Public Shared Function Update(ByVal SC As String, ByVal dt As Data.DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)



        Dim myConnection = New SqlConnection(Encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        'si te tira error acá, ojito con estar usando el dataset q usaste para el 
        'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
        adapterForTable1.Update(dt)

    End Function


    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function

End Class





