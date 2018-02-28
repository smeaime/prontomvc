Imports System.IO
Imports System.Linq
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.ParametroManager
Imports System.Data
Imports System.Diagnostics
Imports System.Collections.Generic


'Imports Microsoft.SqlServer.Management.Smo
'Imports Microsoft.SqlServer.Management.Sdk.Sfc



Imports CartaDePorteManager

Partial Class Configuracion
    Inherits System.Web.UI.Page
    Dim SC As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        'que pasa si el usuario es Nothing? Qué se rompió?
        'If Usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))
        SC = GetConnectionString(Server, Session)
        Dim Usuario = New Usuario
        Usuario = Session(SESSIONPRONTO_USUARIO)
        'SC = Usuario.StringConnection
        HFSC.Value = GetConnectionString(Server, Session)

        Dim membershipUser As MembershipUser
        membershipUser = Membership.GetUser(Usuario.Nombre)
        Dim rols() As String = Roles.GetRolesForUser(Usuario.Nombre)


        If True And (Session(SESSIONPRONTO_UserName) = "Mariano" Or Session(SESSIONPRONTO_UserName) = "Andres") Or rols.Contains("SuperAdministrador") Or Request.QueryString.Count > 0 Then
            panelcito.Visible = True
            PanelSuperadmin.Visible = True
            ' VerTraerFacturasSinImputaciones()
        End If


        'si estás buscando el filtro, andá a PresupuestoManager.GetList
        If Not (Request.QueryString.Get("Id") Is Nothing) Then 'guardo el nodo del treeview en un hidden

            DescargarLog()
            Exit Sub

        End If

        'Dim FilePath As String = lnkAdjunto1.Text  'si lo grabó el pronto, va a venir con el directorio original...
        Dim FileName As String = System.IO.Path.GetFileName("\")
        Dim MyFile As New FileInfo("Debug.bat")
        'If MyFile.Exists Then
        If ConfigurationManager.AppSettings("Debug") = "SI" Then
            Button1.Visible = True
            Button2.Visible = True
            Button3.Visible = True
            Button8.Visible = True
        Else
            Button1.Visible = False
            Button2.Visible = False
            Button3.Visible = False
            Button8.Visible = False
        End If

        If Not IsPostBack Then
            'primera vez que se carga
            Dim di As DirectoryInfo = New DirectoryInfo(DirApp() & "\Error") '(ErrHandler2.DirectorioErrores)
            Dim files As FileSystemInfo() = di.GetFileSystemInfos() 'agarro el directorio con los logs de errores


            Dim orderedFiles = files.OrderBy(Function(f) f.LastWriteTime)
            'Dim t = orderedFiles.ToDataTable
            ' Dim a = New Data.DataView(t)
            ' a.Sort = "CreationTime"

            cmbArchivoError.DataSource = orderedFiles 'files
            cmbArchivoError.DataTextField = "Fullname"
            'cmbPuntoVenta.DataValueField = "PuntoVenta" 
            cmbArchivoError.DataBind()

            bindCounters()


            cmbArchivoError.SelectedIndex = cmbArchivoError.Items.Count - 1 'selecciono el ultimo
            'TODO: pero no los ordena bien


            txtEmpresaConfiguracion.Text = ParametroManager.TraerValorParametro2(SC, eParam2.WebConfiguracionEmpresa)

            txtLogoArchivo.Text = ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.LogoArchivo)

            TextNotificaciones.Text = ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb) & _
                                 ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb2) & _
                                  ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb3) & _
                                   ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb4) & _
                                    ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb5)


            montomaximo.Text = iisNull(ParametroManager.TraerValorParametro2(Usuario.StringConnection, "MontoMaximoFacturaDeCartaPorte"), "")
            montomaximoclientes.Text = iisNull(ParametroManager.TraerValorParametro2(Usuario.StringConnection, "MontoMaximoCartaPorteClientes"), "")


            Dim myConfiguration As System.Configuration.Configuration = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~")
            Dim section As System.Web.Configuration.PagesSection = myConfiguration.GetSection("system.web/pages")
            cmbCSS.Text = section.Theme

            TextBox1.Text = ConfigurationManager.AppSettings("ConfiguracionEmpresa")

            CargarNombresDeLasPlantillas()

            Try
                bindInformes()
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
        End If


        MostrarArchivo()

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkButton6)

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkFacturaLetraA)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkFacturaLetraB)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkFacturaLetraE)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaCreditoLetraA)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaCreditoLetraB)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaCreditoLetraE)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaDebitoLetraA)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaDebitoLetraB)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkNotaDebitoLetraE)


        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnGenerarScript)

        '
        'Try
        '    If InStr(ErrHandler2.WriteError("Prueba para ver si está andando el log de errores"), "Error") = 0 Then
        '        'quizas esta siendo usada por otro error.... 
        '        MsgBoxAjax(Me, "El log está siendo usado en otro proceso, o el directorio de log de errores no está habilitado")
        '    End If
        'Catch ex As Exception
        '    MsgBoxAjax(Me, "El log está siendo usado en otro proceso, o el directorio de log de errores no está habilitado")
        'End Try



        '
        'debug
        'Dim usuario As Usuario
        'Dim sc As String
        'usuario = New Usuario
        'usuario = session(SESSIONPRONTO_USUARIO)
        'sc = usuario.StringConnection
        'Dim depurandoRM As Pronto.ERP.BO.RequerimientoList = Pronto.ERP.Bll.RequerimientoManager.GetList(sc)
        'Dim depurandoPED As Pronto.ERP.BO.PedidoList = Pronto.ERP.Bll.PedidoManager.GetList(sc)
        'Dim depurandoPRE As Pronto.ERP.BO.PresupuestoList = Pronto.ERP.Bll.PresupuestoManager.GetList(sc)
        'Dim depurandoCOMP As Pronto.ERP.BO.ComparativaList = Pronto.ERP.Bll.ComparativaManager.GetList(sc)


    End Sub

    Sub TambienLogDelPronto()

        '    select  * from log where fecharegistro >'2013-09-05 11:00:25.560' 
        'and fecharegistro <'2013-09-05 11:20:00.000' 
        'order by fecharegistro
    End Sub


    Sub DescargarLog()

        TambienLogDelPronto()



        Dim di As DirectoryInfo = New DirectoryInfo(DirApp() & "\Error") '(ErrHandler2.DirectorioErrores)
        Dim files As FileSystemInfo() = di.GetFileSystemInfos() 'agarro el directorio con los logs de errores


        Dim orderedFiles = files.OrderByDescending(Function(f) f.LastWriteTime).Select(Function(f) f.FullName)

        Dim output As String = orderedFiles(0).ToString


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
                'MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Sub CargarNombresDeLasPlantillas()


        lnkFacturaLetraA.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.FacturaA, SC)
        lnkFacturaLetraB.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.FacturaB, SC)
        lnkFacturaLetraE.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.FacturaE, SC)
        lnkNotaCreditoLetraA.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaCreditoA, SC)
        lnkNotaCreditoLetraB.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaCreditoB, SC)
        lnkNotaCreditoLetraE.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaCreditoE, SC)
        lnkNotaDebitoLetraA.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaDebitoA, SC)
        lnkNotaDebitoLetraB.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaDebitoB, SC)
        lnkNotaDebitoLetraE.Text = OpenXML_Pronto.NombrePlantilla(OpenXML_Pronto.enumPlantilla.NotaDebitoE, SC)
    End Sub


    Sub bindInformes()
        If True Then
            'LinqDataSource1.ContextTypeName = "DataClasses1DataContext"
        Else
            gvInformes.DataSourceID = ""
            gvInformes.DataSource = InformesWebManager.RebindTablaInformes(SC)
            gvInformes.DataBind()
        End If


    End Sub

    Protected Sub LinqDataSource1_ContextCreating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LinqDataSourceContextEventArgs) Handles LinqDataSource1.ContextCreating
        'http://stackoverflow.com/questions/1188962/linq-to-sql-set-connection-string-dynamically-based-on-environment-variable

        e.ObjectInstance = New LinqCartasPorteDataContext(Encriptar(SC))

        'Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!! 
        'Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!! 
        'Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!! 
    End Sub




    Sub MostrarArchivo()
        Try

            'muestro el archivo
            Dim oFile As System.IO.File
            Dim oRead As System.IO.StreamReader
            oRead = File.OpenText(cmbArchivoError.SelectedItem.Text)
            txtErrores.Text = oRead.ReadToEnd()
            'txtErrores. 'ScrollToCaret solo existe en Winforms. Para hacer scroll hasta el final, tenes que usar jscript
        Catch ex As Exception

        End Try

    End Sub



    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Sub TraerLogDeMailsEnviados()
        'usar linq

        'select fecharegistro,detalle from log where detalle like '%EnviarYa%' --and fecharegistro between now and now 
        'union()
        'select cast(Substring(UltimoResultado,11,LEN(UltimoResultado)-11) as datetime), * from WilliamsMailFiltrosCola 
    End Sub


    Function TraerFacturasSinImputaciones() As DataTable



        Dim s = " select distinct Clientes.RazonSocial,Clientes.CUIT,Facturas.numerofactura,Facturas.tipoabc, facturas.idfactura," & _
            "Facturas.puntoventa,Facturas.ImporteTotal,Facturas.fechafactura,NotasCredito.IdNotaCredito  " & _
        "        from Facturas " & _
        " left join CartasDePorte on CartasDePorte.IdFacturaImputada=Facturas.idfactura " & _
        "LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.Idcomprobante=Facturas.IdFactura and CuentasCorrientesDeudores.IdTipoComp=1 " & _
        "left join Clientes on Clientes.IdCliente=Facturas.IdCliente   " & _
        "LEFT OUTER JOIN DetalleNotasCreditoImputaciones DetCre ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion " & _
        "LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito " & _
        "        where  " & _
        "Idcartadeporte is null " & _
        "and " & _
        "isnull(Facturas.Anulada,'NO')<>'SI' " & _
        "and " & _
        "not Facturas.IdCondicionVenta is null " & _
        "order by Facturas.idfactura desc"




        ' SELECT NotasCredito.IdNotaCredito,Facturas.idfactura
        'FROM DetalleNotasCreditoImputaciones DetCre
        'LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=DetCre.IdNotaCredito
        'LEFT OUTER JOIN CuentasCorrientesDeudores ON CuentasCorrientesDeudores.IdCtaCte=DetCre.IdImputacion
        'LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesDeudores.IdTipoComp
        'inner  join Facturas ON 
        'CuentasCorrientesDeudores.Idcomprobante=Facturas.IdFactura and CuentasCorrientesDeudores.IdTipoComp=1




        'Debug.Print(s)
        Return EntidadManager.ExecDinamico(SC, s)

    End Function



    Sub VerTraerFacturasSinImputaciones()

        Dim dt = TraerFacturasSinImputaciones()
        'Debug.Print(dt.Rows.Count)
        Dim s As String = "" '= dt.ToString()
        'Join(", ", dt.Rows(0).ItemArray)

        Dim listaCartas As New Generic.List(Of String)

        For Each r In dt.Rows
            If IsNumeric(r.Item("IdNotaCredito")) Then Continue For
            'Dim texto As String = r.Item(0) & " " & r.Item(1) & " " & r.Item(2) & " " & r.Item(3) & " " & r.Item(4) & " " & r.Item(5) & " " & r.Item(6) & " " & r.Item(7) & "\n\n <br/>"
            Dim texto As String = r.Item("FechaFactura").ToString.PadRight(20) & " " & r.Item("puntoventa") & " " & r.Item("numerofactura").ToString.PadRight(10) & r.Item("RazonSocial").ToString.PadRight(100) & " " & r.Item("cuit") & "    NC imputada: " & r.Item("IdNotaCredito")
            Dim idcarta = r.item("IdFactura")  '   TextoEntre(texto, "CartaPorte", "CDP")
            listaCartas.Add(Val(idcarta))
            s &= "<a href=""Factura.aspx?Id=" & idcarta & """ target=""_blank"">" & texto & "</a> <br/>"

        Next

        lblLog.Text = s '& Join(listaCartas.ToArray, ",")
        'MsgBoxAjax(Me, s)

        '        "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
        '                                              CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _

    End Sub

    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Links de mapa de compras 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
        Response.Redirect(String.Format("frmConsultaRMsPendientesDeAsignacion.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        Response.Redirect(String.Format("Presupuesto.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect(String.Format("Requerimiento.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton5.Click
        Response.Redirect(String.Format("Pedido.aspx?Id=-1"))
    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Tests 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestFondoFijo(sc, Session)
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestSolicitudes(sc, Session)
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
        'Tests.TestFondoFijo(sc, Session)
        'Tests.TestSolicitudes(sc, Session)
    End Sub








    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection

        'Tests.ImportarArticulosWilliams(sc)
        'Tests.ImportarHumedadesWilliams(sc)
        'Tests.ImportarChoferesWilliams(sc)
        'Tests.ImportarTransportistasWilliams(sc)
        'Tests.ImportarCalidadesWilliams(sc)

    End Sub

    Protected Sub LinkButton6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton6.Click
        Dim output As String

        'http://stackoverflow.com/questions/52842/sorting-directory-getfiles


        'Dim oFile As System.IO.File
        'Dim oRead As System.IO.StreamReader
        'oRead = File.OpenText(cmbArchivoError.SelectedItem.Text)
        'txtErrores.Text = oRead.ReadToEnd()
        output = cmbArchivoError.SelectedItem.Text


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
                'MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Protected Sub cmbArchivoError_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbArchivoError.TextChanged
        MostrarArchivo()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        ParametroManager.GuardarValorParametro2(SC, eParam2.WebConfiguracionEmpresa, txtEmpresaConfiguracion.Text)

        ParametroManager.GuardarValorParametro2(SC, eParam2.NotificacionesWeb, Mid(TextNotificaciones.Text, 1, 50))
        ParametroManager.GuardarValorParametro2(SC, eParam2.NotificacionesWeb2, Mid(TextNotificaciones.Text, 51, 50))
        ParametroManager.GuardarValorParametro2(SC, eParam2.NotificacionesWeb3, Mid(TextNotificaciones.Text, 101, 50))
        ParametroManager.GuardarValorParametro2(SC, eParam2.NotificacionesWeb4, Mid(TextNotificaciones.Text, 151, 50))
        ParametroManager.GuardarValorParametro2(SC, eParam2.NotificacionesWeb5, Mid(TextNotificaciones.Text, 201, 50))


        ParametroManager.GuardarValorParametro2(SC, ParametroManager.eParam2.LogoArchivo, txtLogoArchivo.Text)


        ParametroManager.GuardarValorParametro2(SC, "MontoMaximoFacturaDeCartaPorte", montomaximo.Text)
        ParametroManager.GuardarValorParametro2(SC, "MontoMaximoCartaPorteClientes", montomaximoclientes.Text)



        Dim myConfiguration As System.Configuration.Configuration = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~")
        Dim section As System.Web.Configuration.PagesSection = myConfiguration.GetSection("system.web/pages")
        If section.Theme <> cmbCSS.Text Then
            section.Theme = cmbCSS.Text
            myConfiguration.Save()
        End If


        If myConfiguration.AppSettings.Settings.Item("ConfiguracionEmpresa").Value <> TextBox1.Text Then
            myConfiguration.AppSettings.Settings.Item("ConfiguracionEmpresa").Value = TextBox1.Text
            myConfiguration.Save()
        End If




        Response.Redirect("Configuracion.aspx")

        'Dear Mr./Ms. Next-Poor-Bass-Turd-To-Read-This-Thread,
        'Arjay was definitely helpful, I had to right-click my project in Solution Explorer and add a reference to System.Configuration in addition to adding a using System.Configuration statement. Then the following code (slightly modified from the example above) compiled and worked as I expected. txtInputFile is the name of a System.Windows.Forms.TextBox that is on my Form.

        '// Load the application's configuration file.
        'Configuration config = ConfigurationManager.OpenExeConfiguration(Application.ExecutablePath);

        '// Set the dbName entry
        'config.AppSettings.Settings["InputFile"].Value = txtInputFile.Text;

        '// Save the changes back to the original configuration file
        'config.Save();

        'Take care,
        'Charlie
    End Sub

    Protected Sub btnFacturaXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFacturaXML.Click
        'ProntoOpenOOXML_factura.SearchAndReplace(output, CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura), HFSC.Value)

        'ProntoOpenOOXML_factura.SearchAndReplace(output, CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura), SC)

    End Sub



    Protected Sub btnNotaCreditoXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNotaCreditoXML.Click

        Dim idNC = 10
        Dim oNC = NotaDeCreditoManager.GetCopyOfItem(SC, idNC)
        Dim f = OpenXML_Pronto.NotaCreditoXML_DOCX(oNC, SC)


        Dim MyFile1 = New FileInfo(f)
        Try
            Dim nombrearchivo = "NotaCredito.docx"
            If Not IsNothing(f) Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & nombrearchivo)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)

                Response.TransmitFile(f)
                'Response.BinaryWrite()
                'Response.OutputStream


                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Protected Sub btnNotaDebitoXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNotaDebitoXML.Click

    End Sub


    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload1.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()

                Dim nombrenuevo = Session(SESSIONPRONTO_DirectorioFTP) + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try

                AsyncFileUpload1.SaveAs(nombrenuevo)

                Dim ePlantilla = DirectCast([Enum].Parse(GetType(OpenXML_Pronto.enumPlantilla), cmbPlantilla.SelectedValue), OpenXML_Pronto.enumPlantilla)
                OpenXML_Pronto.GuardarEnSQL(SC, ePlantilla, nombre, "", nombrenuevo)

                CargarNombresDeLasPlantillas()


                UpdatePanel2.Update()
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


    Sub Descargar(ByVal p As OpenXML_Pronto.enumPlantilla)
        Dim archiv = OpenXML_Pronto.CargarPlantillaDeSQL(p, SC)
        Dim output As String = archiv 'DirApp() & "\Documentos\" & archiv


        Dim MyFile1 As FileInfo 'busca si ya existe el archivo a generar y en ese caso lo borra

        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
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


    End Sub





    Protected Sub lnkNotaCreditoLetraA_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaCreditoLetraA.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaCreditoA)
    End Sub

    Protected Sub lnkNotaCreditoLetraB_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaCreditoLetraB.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaCreditoB)
    End Sub

    Protected Sub lnkNotaCreditoLetraE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaCreditoLetraE.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaCreditoE)
    End Sub

    Protected Sub lnkFacturaLetraA_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFacturaLetraA.Click
        Descargar(OpenXML_Pronto.enumPlantilla.FacturaA)
    End Sub

    Protected Sub lnkFacturaLetraB_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFacturaLetraB.Click
        Descargar(OpenXML_Pronto.enumPlantilla.FacturaB)
    End Sub

    Protected Sub lnkFacturaLetraE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFacturaLetraE.Click
        Descargar(OpenXML_Pronto.enumPlantilla.FacturaE)
    End Sub

    Protected Sub lnkNotaDebitoLetraA_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaDebitoLetraA.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaDebitoA)
    End Sub

    Protected Sub lnkNotaDebitoLetraB_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaDebitoLetraB.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaDebitoB)
    End Sub

    Protected Sub lnkNotaDebitoLetraE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNotaDebitoLetraE.Click
        Descargar(OpenXML_Pronto.enumPlantilla.NotaDebitoE)
    End Sub




    Protected Sub AsyncFileUpload2_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload2.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload2.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload2.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()

                Dim temppath = System.IO.Path.GetTempPath()
                Dim nombrenuevo = temppath + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try




                AsyncFileUpload2.SaveAs(nombrenuevo)

                If False Then
                    Dim ds = GetExcelToDatatable(nombrenuevo, , , 12000)
                    ImportarEstablecimientosLosGrobo(ds)
                Else
                    Dim ds As New DataSet
                    Dim dt = ExcelImportadorManager.GetExcel2_ODBC(nombrenuevo, "bwF1C") 'buscar primera pagina o avisar por lo menos
                    ds.Tables.Add(dt.Copy)
                    ImportarEstablecimientosLosGrobo(ds)
                End If


            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                MandarMailDeError(ex.ToString)
                MsgBoxAjax(Me, "Verificar que la primera hoja del excel se llame 'bwF1C'")
                'Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click

        End If
    End Sub

    Sub ImportarEstablecimientosLosGrobo(ByVal ds As DataSet)
        'ds.Tables(0).Rows(0).Item(0)


        Const RENGLON_DE_ENCABEZADOS = 3
        For c = 0 To ds.Tables(0).Columns.Count - 1
            Try
                ds.Tables(0).Columns(c).ColumnName = ds.Tables(0).Rows(RENGLON_DE_ENCABEZADOS).Item(c)
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
            End Try
        Next


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        Dim establecimientos = From e In db.linqCDPEstablecimientos


        For Each i As DataRow In ds.Tables(0).Rows

            'Dim idClienteAfacturarle As Long = BuscaIdClientePreciso(i("Cliente"), HFSC.Value)
            'Dim idart As Long = BuscaIdArticuloPreciso(i("Articulo"), HFSC.Value)
            'Dim tarif As Double = Val(i("Tarifa"))
            'Dim bPORdestino As Boolean
            'Dim iddestino As Long
            'Try
            '    bPORdestino = (i("Por Destino?") = "SI")
            '    If bPORdestino Then
            '        iddestino = BuscaIdWilliamsDestinoPreciso(i("Destino"), HFSC.Value)
            '    End If
            'Catch ex As Exception
            '    ErrHandler2.WriteError(ex.ToString)
            'End Try


            Dim codestab As String = i(0).ToString ' i("CODIGO")
            Dim aux1 As String = i(1).ToString 'i("Campo")
            Dim aux2 As String = i(4).ToString 'i("Cuit Comprador")

            CDPEstablecimientosManager.Update(HFSC.Value, codestab, "", "", aux1, aux2, "")


            '            update(cdpestablecimientos)
            '            AuxiliarString1 = descripcion
            'where isnumeric(descripcion)=0 --codigo alfanumerico

            '            update(cdpestablecimientos)
            '            descripcion = AuxiliarString1
            'where isnumeric(descripcion)=0 --codigo alfanumerico



            'CDPEstablecimientoManager.Update(codEstab, desc, obs1)

            '            If existeelcodigo Then

            'Else
            '    e.

            'End If


        Next



        MsgBoxAjax(Me, "Importación terminada")
    End Sub




    Protected Sub btnActualizarBase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnActualizarBase.Click
        BackupMasActualizacionConADONET()
    End Sub

    Sub BackupMasActualizacionConADONET()

        'Dim a = "sp_configure()"
        'Dim a = "RECONFIGURE"
        'Dim a = "sp_configure (('xp_cmdshell', 1)"
        'Dim a = "RECONFIGURE"
        Try

            EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'show advanced options', 1")
            EntidadManager.ExecDinamico(SC, "RECONFIGURE")
            EntidadManager.ExecDinamico(SC, "EXEC sp_configure 'xp_cmdshell', 1")
            EntidadManager.ExecDinamico(SC, "RECONFIGURE")

            Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
            Dim servidor As String = parser.DataSource
            Dim base As String = parser.InitialCatalog
            Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"


            'declare @DBServerName varchar(100)
            'declare @DBName  varchar(100)
            'declare @FilePathName varchar(100)
            'set @DBServerName='MARIANO-PC\SQLEXPRESS'
            'set @DBName='wDemoWilliams'
            'set @FilePathName='"E:\Backup\BDL\ProntoWeb\Proyectos\Pronto\Novedades\Nuevos_SP WEB.sql"'
            ' EXEC(xp_cmdshell)  'sqlcmd -S ' + @DBServerName + ' -d  ' + @DBName + ' -i ' + @FilePathName

            'no puedo usar el archivo que se copió en el IIS para referenciarlo desde el SQL!!!!!

            Dim sSql = " declare @f varchar(100) " & vbCrLf & _
                       " set  @f='""" & filescript & """'" & vbCrLf & _
                       " declare @s varchar(300) " & vbCrLf & _
                       " set @s='sqlcmd -S ''" & servidor & "'' -d  ''" & base & "'' -i ' + @f " & vbCrLf & _
                       "  EXEC xp_cmdshell @s "
            ErrHandler2.WriteError(sSql)
            Dim ret = EntidadManager.ExecDinamico(SC, sSql)


            'http://stackoverflow.com/questions/40814/how-do-i-execute-a-large-sql-script-with-go-commands-from-c
            '-necesita una version 2008 de sql? no encuentro las referencias para  Microsoft.SqlServer.Management
            'Dim fileInfo = New FileInfo(filescript)
            'Dim script As String = fileInfo.OpenText().ReadToEnd()
            'Dim connection = New System.Data.SqlClient.SqlConnection(Encriptar(HFSC.Value))
            'Dim a As Microsoft.SqlServer.Management.Common.ServerConnection
            'Dim server = New server(New Microsoft.SqlServer.Management.Common.ServerConnection(connection))
            'server.ConnectionContext.ExecuteNonQuery(script)



            MsgBoxAjax(Me, "Actualizada con éxito")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "Se produjo un error al actualizar. " & ex.ToString)
        End Try


    End Sub


    'Function ExportarScriptConSMO()
    '    'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
    '    'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server

    '    Dim filescript As String = DirApp() & "\Novedades\Nuevos_SP WEB.sql"

    '    Dim filescriptdrops As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB drops.sql"

    '    Try


    '        'SQL Server 2008 - Backup and Restore Databases using SMO

    '        Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
    '        Dim servidor As String = parser.DataSource
    '        Dim user As String = parser.UserID
    '        Dim pass = parser.Password

    '        Dim base As String = parser.InitialCatalog


    '        'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
    '        Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

    '        Dim srv = New Server(connection)


    '        '//Reference the AdventureWorks2008R2 database.  
    '        Dim db = srv.Databases(base)

    '        ' http://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.scriptingoptions.aspx
    '        '//Define a Scripter object and set the required scripting options. 
    '        Dim scrp As Scripter



    '        scrp = New Scripter(srv)



    '        If False Then

    '            Using outfile As StreamWriter = New StreamWriter(filescript, True)



    '                'Iterate through the tables in database and script each one. Display the script.
    '                'Note that the StringCollection type needs the System.Collections.Specialized namespace to be included.
    '                Dim tb As Table
    '                Dim sp As StoredProcedure
    '                Dim smoObjects(1) As Urn
    '                Dim i, total As Long



    '                For Each sp In db.StoredProcedures
    '                    If Left(sp.Name, 1) = "w" Then
    '                        total += 1
    '                    End If
    '                Next
    '                Debug.Print(total)


    '                Dim drop = New ScriptingOptions()
    '                drop.ScriptDrops = True
    '                drop.IncludeIfNotExists = True

    '                If False Then
    '                    For Each sp In db.StoredProcedures
    '                        If Left(sp.Name, 1) = "w" Then
    '                            If sp.IsSystemObject = False Then
    '                                smoObjects = New Urn(0) {}
    '                                smoObjects(0) = sp.Urn

    '                                Dim sc As StringCollection
    '                                sc = scrp.Script(smoObjects)

    '                                'outfile.WriteLine(sc.ToString())

    '                                'Dim st As String
    '                                'For Each st In sc
    '                                '    Console.WriteLine(st)
    '                                '    outfile.WriteLine(st)
    '                                'Next

    '                            End If
    '                            i += 1
    '                            Debug.Print(i)
    '                        End If
    '                    Next

    '                End If


    '                outfile.Close()
    '            End Using

    '        End If


    '        'http://stackoverflow.com/questions/274408/using-smo-to-get-create-script-for-table-defaults

    '        Dim list = New Generic.List(Of Urn)()
    '        Dim dataTable = db.EnumObjects(DatabaseObjectTypes.StoredProcedure) '.Table)
    '        For Each row In dataTable.Rows
    '            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
    '                list.Add(New Urn(row("Urn")))
    '            End If
    '        Next

    '        dataTable = db.EnumObjects(DatabaseObjectTypes.View) '.Table)
    '        For Each row In dataTable.Rows
    '            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
    '                list.Add(New Urn(row("Urn")))
    '            End If
    '        Next

    '        dataTable = db.EnumObjects(DatabaseObjectTypes.UserDefinedFunction) '.Table)
    '        For Each row In dataTable.Rows
    '            If Left(row("Name"), 1) = "w" Then 'And row("IsSystemObject") = False Then
    '                list.Add(New Urn(row("Urn")))
    '            End If
    '        Next


    '        With scrp
    '            ' scrp.Options.ScriptDrops = True
    '            '    scrp.Options.WithDependencies = False
    '            scrp.Options.ScriptSchema = True
    '            .Options.ScriptData = False
    '            '    scrp.Options.IncludeIfNotExists = False
    '            scrp.Options.IncludeHeaders = True
    '            'scrp.Options.SchemaQualify = True

    '            '    '.Options.SchemaQualifyForeignKeysReferences = True
    '            '    '.Options.NoCollation = True
    '            '    .Options.DriAllConstraints = True
    '            '    scrp.Options.DriAll = True
    '            '    .Options.DriAllKeys = True
    '            '    .Options.DriIndexes = True
    '            '.Options.ClusteredIndexes = True
    '            '.Options.NonClusteredIndexes = True



    '            .Options.ToFileOnly = True
    '            .Options.FileName = filescript

    '            .Script(list.ToArray())


    '            .Options.FileName = filescriptdrops
    '            scrp.Options.ScriptDrops = True
    '            .Script(list.ToArray())
    '        End With

    '    Catch ex As Exception
    '        ErrHandler2.WriteAndRaiseError(ex)
    '    End Try

    '    Dim str As String
    '    str &= File.ReadAllText(filescriptdrops)
    '    str &= File.ReadAllText(filescript)

    '    Dim objStreamWriter As StreamWriter
    '    objStreamWriter = File.CreateText(filescript)
    '    objStreamWriter.Write(str)
    '    objStreamWriter.Close()



    '    Dim MyFile1 = New FileInfo(filescript)
    '    Try
    '        Dim nombrearchivo = MyFile1.Name
    '        If Not IsNothing(filescript) Then
    '            Response.ContentType = "application/octet-stream"
    '            Response.AddHeader("Content-Disposition", "attachment; filename=" & nombrearchivo)
    '            'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
    '            'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
    '            'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)

    '            Response.TransmitFile(filescript)
    '            'Response.BinaryWrite()
    '            'Response.OutputStream


    '            Response.End()
    '        Else
    '            MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
    '        End If
    '    Catch ex As Exception
    '        'MsgBoxAjax(Me, ex.ToString)
    '        ErrHandler2.WriteError(ex)
    '    End Try
    'End Function



    'Protected Sub btnGenerarScript_Click(sender As Object, e As System.EventArgs) Handles btnGenerarScript.Click
    '    ExportarScriptConSMO()
    '    'MsgBoxAjax(Me, "Script generado")

    'End Sub

    'Protected Sub Button7_Click(sender As Object, e As System.EventArgs) Handles Button7.Click
    '    BackupMasActualizacionConSMO()
    'End Sub



    'Function BackupMasActualizacionConSMO()
    '    'http://msdn.microsoft.com/en-us/library/ms162160(v=sql.90).aspx
    '    'http://stackoverflow.com/questions/3488666/how-to-automate-script-generation-using-smo-in-sql-server


    '    'SQL Server 2008 - Backup and Restore Databases using SMO

    '    Dim parser = New System.Data.SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value))
    '    Dim servidor As String = parser.DataSource
    '    Dim user As String = parser.UserID
    '    Dim pass = parser.Password

    '    Dim base As String = parser.InitialCatalog


    '    'Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(Encriptar(HFSC.Value))
    '    Dim connection = New Microsoft.SqlServer.Management.Common.ServerConnection(servidor, user, pass)

    '    Dim srv = New Server(connection)



    '    '//Reference the AdventureWorks2008R2 database.  
    '    Dim db = srv.Databases(base)

    '    Dim tableText As String

    '    Try

    '        Dim nuevtablefile As String = DirApp() & "\Novedades\dev\Nuevas_Tablas Web.sql"
    '        Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(nuevtablefile)
    '            tableText = FileReader.ReadToEnd
    '        End Using

    '        Dim altertablefile As String = DirApp() & "\Novedades\dev\ALTERTABLE 2011 Modulo WEB.sql"
    '        Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(altertablefile)
    '            tableText = FileReader.ReadToEnd
    '        End Using

    '        db.ExecuteNonQuery(tableText)
    '    Catch ex As Exception
    '        ErrHandler2.WriteError(ex)
    '    End Try



    '    Dim filescript As String = DirApp() & "\Novedades\dev\Nuevos_SP WEB desarrollo.sql"
    '    Using FileReader As New Microsoft.VisualBasic.FileIO.TextFieldParser(filescript)
    '        tableText = FileReader.ReadToEnd
    '    End Using


    '    Try
    '        db.ExecuteNonQuery(tableText)
    '    Catch ex As Exception
    '        ErrHandler2.WriteError(ex)
    '        Dim inner As Exception = ex.InnerException
    '        While Not (inner Is Nothing)
    '            MsgBox(inner.Message)
    '            ErrHandler2.WriteError(inner.Message)
    '            inner = inner.InnerException
    '        End While

    '        MsgBoxAjax(Me, ex.ToString)

    '        Throw
    '        'ex.InnerException
    '        'ex.InnerException.InnerException
    '    End Try

    '    MsgBoxAjax(Me, "exito")

    'End Function



    Sub EventLog()

        Dim el As EventLog = New EventLog()
        el.Source = DropDownList1.SelectedItem.Text
        gvEventlog.DataSource = el.Entries
        gvEventlog.DataBind()

    End Sub

    Sub bindCounters()

        Dim pcc As List(Of String) = New List(Of String)
        For Each item As PerformanceCounterCategory In _
        PerformanceCounterCategory.GetCategories()
            pcc.Add(item.CategoryName)
        Next
        pcc.Sort()
        pcc.Remove(".NET CLR Data")
        DropDownList1.DataSource = pcc
        DropDownList1.DataBind()
        Dim myPcc As PerformanceCounterCategory
        myPcc = New PerformanceCounterCategory(DropDownList1.SelectedItem.Text)
        DisplayCounters(myPcc)
    End Sub

    Protected Sub DisplayCounters(ByVal pcc As PerformanceCounterCategory)
        DisplayInstances(pcc)
        Dim myPcc As List(Of String) = New List(Of String)
        If DropDownList3.Items.Count > 0 Then
            For Each pc As PerformanceCounter In _
            pcc.GetCounters(DropDownList3.Items(0).Value)
                myPcc.Add(pc.CounterName)
            Next
        Else
            For Each pc As PerformanceCounter In pcc.GetCounters()
                myPcc.Add(pc.CounterName)
            Next
        End If
        myPcc.Sort()
        DropDownList2.DataSource = myPcc
        DropDownList2.DataBind()
    End Sub

    Protected Sub DisplayInstances(ByVal pcc As PerformanceCounterCategory)
        Dim listPcc As List(Of String) = New List(Of String)
        For Each item As String In pcc.GetInstanceNames()
            listPcc.Add(item.ToString())
        Next
        listPcc.Sort()


        DropDownList3.DataSource = listPcc
        DropDownList3.DataBind()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, _
    ByVal e As System.EventArgs)
        Dim pcc As PerformanceCounterCategory
        pcc = New PerformanceCounterCategory(DropDownList1.SelectedItem.Text)
        DropDownList2.Items.Clear()
        DropDownList3.Items.Clear()
        DisplayCounters(pcc)
    End Sub

    Protected Sub Button9_Click(ByVal sender As Object, _
    ByVal e As System.EventArgs) Handles Button9.Click
        Dim pc As PerformanceCounter
        If DropDownList3.Items.Count > 0 Then
            pc = New PerformanceCounter(DropDownList1.SelectedItem.Text, _
            DropDownList2.SelectedItem.Text, DropDownList3.SelectedItem.Text)
        Else
            pc = New PerformanceCounter(DropDownList1.SelectedItem.Text, _
            DropDownList2.SelectedItem.Text)
        End If
        Label1.Text = "<b>Latest Value:</b> " & pc.NextValue().ToString()
    End Sub



    Sub storesporuso()
        '        use(Master)

        'SELECT TOP 100 qt.TEXT AS 'SP Name',
        'qs.execution_count AS 'Execution Count',
        'qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
        'qs.total_worker_time AS 'TotalWorkerTime',
        'qs.total_physical_reads AS 'PhysicalReads',
        'qs.creation_time 'CreationTime',
        'qs.execution_count/DATEDIFF(Second, qs.creation_time, GETDATE()) AS 'Calls/Second'
        'FROM sys.dm_exec_query_stats AS qs
        'CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
        'WHERE qt.dbid = (SELECT dbid FROM sys.sysdatabases WHERE name = 'Autotrol')
        'ORDER BY qs.total_physical_reads DESC
    End Sub

    Sub FacturasContraCartaporte()
        '        select a.IdFactura,clientes.razonsocial,cantidad,neto,abs(neto-cantidad) as dif 
        'from (select idfactura, sum(detallefacturas.Cantidad) as cantidad  from detallefacturas group by idfactura)  A
        'join (select idfacturaimputada, sum(NetoFinal/1000)  as neto from cartasdeporte group by idfacturaimputada)  B  on A.idfactura=B.idfacturaimputada
        'join facturas on facturas.IdFactura=a.IdFactura
        'join clientes on clientes.idcliente=facturas.idcliente
        'order by abs(neto-cantidad)  desc

    End Sub


    Sub ArreglarVB6()
        Dim s = " Object = ""{12DE615C-8D4B-4936-8801-459AB2EAA3FC}#1.2#0""; ""Controles1013.ocx"""
    End Sub

End Class







