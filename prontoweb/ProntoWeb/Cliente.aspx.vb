Imports System
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.BO.Cliente
Imports Pronto.ERP.Bll.ClienteManager
Imports System.Linq

Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools

Imports System.IO

Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Imports Pronto.ERP.Bll.EntidadManager
Imports PuntoVentaWilliams

Imports CartaDePorteManager

Partial Class ClienteABM
    Inherits System.Web.UI.Page

    Private IdCliente As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdCliente"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdCliente") = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdCliente = Convert.ToInt32(Request.QueryString.Get("Id"))
        Else
            IdCliente = -1
        End If
        Me.IdEntity = IdCliente

        mKey = "Cliente_" & Me.IdEntity.ToString
        mAltaItem = False

        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)


        '/////////////////////////////////////////////
        'Cómo puede ser que a veces llegue hasta acá (Page Load de un ABM) y el session(SESSIONPRONTO_USUARIO) está en nothing? Un cookie?
        If usuario Is Nothing Then 'Or SC Is Nothing Then
            'debug.print(session(SESSIONPRONTO_UserName))
            'pero si lo hacés así, no vas a poder redirigirlo, porque te quedas sin RequestUrl...
            ' ma sí, le pongo el dato en el session
            'session(SESSIONPRONTO_MiRequestUrl) = Request.Url..AbsoluteUri
            Session(SESSIONPRONTO_MiRequestUrl) = Request.RawUrl.ToLower
            'Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

            Return

            Session.RemoveAll() 'ehhh?? pero perdes lo que pusiste en  Session(SESSIONPRONTO_MiRequestUrl)!!!!!
            Response.Redirect("~/Login.aspx")
        End If
        '/////////////////////////////////////////////

        SC = usuario.StringConnection
        'SC = ConfigurationManager.ConnectionStrings("Pronto").ConnectionString



        chkEventual.Visible = False 'lo de eventual es para los proveedores.....


        Dim myCliente As Pronto.ERP.BO.ClienteNuevo

        If Not Page.IsPostBack Then
            TextBox1.Text = IdCliente
            BindTypeDropDown()


            If IdCliente > 0 Then
                myCliente = EditarSetup()
            Else
                myCliente = AltaSetup()

            End If


            MostrarElementos(False)
            Me.ViewState.Add(mKey, myCliente)

            TabContainer1.ActiveTabIndex = 0

        End If

        BloqueosDeEdicion(myCliente)


        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimiSobreGrandeXML)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimiSobreChicoXML)


        AutoCompleteExtender5.ContextKey = SC
        AutoCompleteExtender3.ContextKey = SC
        AutoCompleteExtender7.ContextKey = SC
        AutoCompleteExtender1.ContextKey = SC
    End Sub


    Function EditarSetup() As Pronto.ERP.BO.ClienteNuevo
        Dim myCliente As Pronto.ERP.BO.ClienteNuevo = ClienteManager.GetItem(SC, IdCliente)



        With myCliente
            txtCodigoEmpresa.Text = Val(Mid(.codigo, 3))
            txtRazonSocial.Text = .RazonSocial
            txtDireccion.Text = .Direccion
            txtCodigoPostal.Text = .CodigoPostal
            txtCUIT.Text = .Cuit
            txtTelefono1.Text = .Telefono1
            txtFax.Text = .Fax
            txtEmail.Text = .Email
            txtPaginaWeb.Text = .PaginaWeb
            txtIvaPorcentajeExencion.Text = .Calificacion
            txtNombreFantasia.Text = .NombreFantasia

            'txtInformacionAuxiliar.Text = myCliente.InformacionAuxiliar
            'txtChequesALaOrdenDe.Text = myCliente.ChequesALaOrdenDe
            'txtObservaciones.Text = myCliente.Observaciones
            'txtImportaciones_NumeroInscripcion.Text = myCliente.Importaciones_NumeroInscripcion
            'txtImportaciones_DenominacionInscripcion.Text = myCliente.Importaciones_DenominacionInscripcion
            'txtNombre1.Text = myCliente.Nombre1
            'txtNombre2.Text = myCliente.Nombre2

            BuscaIDEnCombo(cmbListaDePrecios, .IdListaPrecios)

            txtLocalidad.Text = EntidadManager.NombreLocalidad(SC, .IdLocalidad)

            txtAutocompleteCuenta.Text = EntidadManager.NombreCuentaConSufijo(SC, .IdCuenta)


            BuscaIDEnCombo(cmbProvincia, .IdProvincia)
            BuscaIDEnCombo(cmbPais, .IdPais)

            txtMailFacturaElectronica.Text = .EmailFacturacionElectronica
            txtAutorizadorSyngenta.Text = .AutorizacionSyngenta


            'BuscaIDEnCombo(DropDownList7, .CartaPorteTipoDeAdjuntoDeFacturacion)
            DropDownList7.SelectedIndex = .CartaPorteTipoDeAdjuntoDeFacturacion

            txtDireccionDeCorreos.Text = .DireccionDeCorreos
            txtLocalidadDeCorreos.Text = EntidadManager.NombreLocalidad(SC, .IdLocalidadDeCorreos)
            BuscaIDEnCombo(cmbProvinciaDeCorreos, .IdProvinciaDeCorreos)
            txtCodigoPostalDeCorreos.Text = .CodigoPostalDeCorreos
            txtObservacionesDeCorreos.Text = .ObservacionesDeCorreos



            If Not (cmbCondicionIVA.Items.FindByValue(.IdCodigoIva.ToString) Is Nothing) Then
                cmbCondicionIVA.Items.FindByValue(.IdCodigoIva.ToString).Selected = True
            End If
            If Not (cmbCondicionCompra.Items.FindByValue(.IdCondicionCompra.ToString) Is Nothing) Then
                cmbCondicionCompra.Items.FindByValue(.IdCondicionCompra.ToString).Selected = True
            End If


            If Not (cmbMoneda.Items.FindByValue(.IdMoneda.ToString) Is Nothing) Then
                cmbMoneda.Items.FindByValue(.IdMoneda.ToString).Selected = True
            End If
            'If Not (cmbEstadoActual.Items.FindByValue(.IdEstado.ToString) Is Nothing) Then
            '    cmbEstadoActual.Items.FindByValue(.IdEstado.ToString).Selected = True
            'End If
            'If Not (cmbActividad.Items.FindByValue(.IdActividad.ToString) Is Nothing) Then
            '    cmbActividad.Items.FindByValue(.IdActividad.ToString).Selected = True
            'End If

            'txtFechaUltimaPresentacionDocumentacion.Text = .FechaUltimaPresentacionDocumentacion.ToString("dd/MM/yyyy")
            'txtObservacionesPresentacionDocumentacion.Text = .ObservacionesPresentacionDocumentacion

            If .BienesOServicios = "B" Then
                RadioButtonList1.Items(0).Selected = True
            ElseIf .BienesOServicios = "S" Then
                RadioButtonList1.Items(1).Selected = True
            Else
                RadioButtonList1.Items(0).Selected = True
            End If



            'IIBB
            If .IBCondicion = 1 Then
                RadioButtonList3.Items(0).Selected = True
            ElseIf .IBCondicion = 2 Then
                RadioButtonList3.Items(2).Selected = True
            ElseIf .IBCondicion = 3 Then
                RadioButtonList3.Items(1).Selected = True
            ElseIf .IBCondicion = 4 Then
                RadioButtonList3.Items(3).Selected = True
            Else
                RadioButtonList3.Items(0).Selected = True
            End If
            'txtFechaLimiteExentoIIBB.Text = .FechaLimiteExentoIIBB.ToString("dd/MM/yyyy")
            txtIBNumeroInscripcion.Text = .IBNumeroInscripcion
            'txtCoeficienteIIBBUnificado.Text = .CoeficienteIIBBUnificado.ToString
            If Not (cmbCategoriaIIBB.Items.FindByValue(.IdIBCondicionPorDefecto.ToString) Is Nothing) Then
                cmbCategoriaIIBB.Items.FindByValue(.IdIBCondicionPorDefecto.ToString).Selected = True
            End If
            If .SujetoEmbargado = "SI" Then
                CheckBox1.Checked = True
            End If
            txtBaseMinima.Text = .SaldoEmbargo.ToString
            txtPorcentajeAplicar.Text = .DetalleEmbargo
            'txtPorcentajeIBDirecto.Text = .PorcentajeIBDirecto.ToString
            'txtGrupoIIBB.Text = .GrupoIIBB.ToString
            txtFechaInicioVigenciaIBDirecto.Text = .FechaInicioVigenciaIBDirecto.ToString("dd/MM/yyyy")
            txtFechaFinVigenciaIBDirecto.Text = .FechaFinVigenciaIBDirecto.ToString("dd/MM/yyyy")
            ControlesIIBB(.IBCondicion)

            'IVA
            If .IvaExencionRetencion = "SI" Then
                CheckBox2.Checked = True
            End If
            txtIvaFechaCaducidadExencion.Text = .IvaFechaCaducidadExencion.ToString("dd/MM/yyyy")
            txtIvaPorcentajeExencion.Text = .IvaPorcentajeExencion.ToString
            txtCodigoSituacionRetencionIVA.Text = .CodigoSituacionRetencionIVA
            ControlesIVA(.IvaExencionRetencion)

            Try
                'CheckBox1.Checked = IIf(.esAgenteRetencionIVA = "SI", True, False)
            Catch ex As Exception
            End Try

            BuscaIDEnCombo(DropDownList6, .IGCondicion)
            txtBaseMinima.Text = .BaseMinimaParaPercepcionIVA
            txtPorcentajeAplicar.Text = .PorcentajePercepcionIVA

            txtIBDdirecto.Text = .IBPorcentajeExencion
            txtGrupoIB.Text = .GrupoIIBB
            TextBox4.Text = .ExpresionRegularNoAgruparFacturasConEstosVendedores




            txtContactos.Text = .Contactos
            txtCorreosElectronicos.Text = .CorreosElectronicos
            txtTelefonosFijosOficina.Text = .TelefonosFijosOficina
            txtTelefonosCelulares.Text = .TelefonosCelulares

            ProntoCheckSINO(.ExigeDatosCompletosEnCartaDePorteQueLoUse, chkExigirValidacionCompletaDeCartaDePorte)
            ProntoCheckSINO(.IncluyeTarifaEnFactura, chkIncluyeTarifaEnFactura)


            ProntoCheckSINO(.EsAcondicionadoraDeCartaPorte, chkEsAcondicionadora)
            ProntoCheckSINO(.EsClienteExportador, chkEsExportador)
            ProntoCheckSINO(.UsaGastosAdmin, chkUsaGastosAdmin)
            ProntoCheckSINO(.DeshabilitadoPorCobranzas, chkHabilitadoCobranzas)

            ProntoCheckSINO(.EsClienteObservacionesFacturadoComoCorredor, chkClienteObservacionesFacturadoComoCorredor)



            ProntoCheckSINO(.Eventual, chkEventual)


            Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
            Dim oCliente = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = IdCliente And i.PuntoVenta = enumWilliamsPuntoVenta.BuenosAires).SingleOrDefault
            If oCliente IsNot Nothing Then
                With oCliente
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoTitular, chkComoTitular)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoIntermediario, chkComoIntermediario)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoRemcomercial, chkComoRComercial)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoClienteAuxiliar, chkComoClienteAuxiliar)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoCorredor, chkComoCorredor)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatario, chkComoDestinatarioLocal)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatarioExportador, chkComoDestinatarioExportador)
                    ProntoCheckSINO(.SeLeDerivaSuFacturaAlCorredorDeLaCarta, chkDerivarleSuFacturaAlCorredorDeLaCarta)
                    ProntoCheckSINO(.EsEntregador, chkEsEntregador)
                End With
            End If

            Dim oCliente2 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = IdCliente And i.PuntoVenta = enumWilliamsPuntoVenta.SanLorenzo).SingleOrDefault
            If oCliente2 IsNot Nothing Then
                With oCliente2
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoTitular, chkComoTitular2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoIntermediario, chkComoIntermediario2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoRemcomercial, chkComoRComercial2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoClienteAuxiliar, chkComoClienteAuxiliar2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoCorredor, chkComoCorredor2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatario, chkComoDestinatarioLocal2)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatarioExportador, chkComoDestinatarioExportador2)
                    ProntoCheckSINO(.SeLeDerivaSuFacturaAlCorredorDeLaCarta, chkDerivarleSuFacturaAlCorredorDeLaCarta2)
                    ProntoCheckSINO(.EsEntregador, chkEsEntregador2)
                End With
            End If


            Dim oCliente3 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = IdCliente And i.PuntoVenta = enumWilliamsPuntoVenta.ArroyoSeco).SingleOrDefault
            If oCliente3 IsNot Nothing Then
                With oCliente3
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoTitular, chkComoTitular3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoIntermediario, chkComoIntermediario3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoRemcomercial, chkComoRComercial3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoClienteAuxiliar, chkComoClienteAuxiliar3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoCorredor, chkComoCorredor3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatario, chkComoDestinatarioLocal3)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatarioExportador, chkComoDestinatarioExportador3)
                    ProntoCheckSINO(.SeLeDerivaSuFacturaAlCorredorDeLaCarta, chkDerivarleSuFacturaAlCorredorDeLaCarta3)
                    ProntoCheckSINO(.EsEntregador, chkEsEntregador3)
                End With
            End If

            Dim oCliente4 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = IdCliente And i.PuntoVenta = enumWilliamsPuntoVenta.BahiaBlanca).SingleOrDefault
            If oCliente4 IsNot Nothing Then
                With oCliente4
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoTitular, chkComoTitular4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoIntermediario, chkComoIntermediario4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoRemcomercial, chkComoRComercial4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoClienteAuxiliar, chkComoClienteAuxiliar4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoCorredor, chkComoCorredor4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatario, chkComoDestinatarioLocal4)
                    ProntoCheckSINO(.SeLeFacturaCartaPorteComoDestinatarioExportador, chkComoDestinatarioExportador4)
                    ProntoCheckSINO(.SeLeDerivaSuFacturaAlCorredorDeLaCarta, chkDerivarleSuFacturaAlCorredorDeLaCarta4)
                    ProntoCheckSINO(.EsEntregador, chkEsEntregador4)
                End With
            End If






            chkHabilitadoParaCartaPorte.Checked = .HabilitadoParaCartaPorte



            ''SUSS
            'If .RetenerSUSS = "EX" Then
            '    RadioButtonList4.Items(0).Selected = True
            'ElseIf .RetenerSUSS = "SI" Then
            '    RadioButtonList4.Items(1).Selected = True
            'ElseIf myCliente.RetenerSUSS = "NO" Then
            '    RadioButtonList4.Items(2).Selected = True
            'Else
            '    RadioButtonList4.Items(0).Selected = True
            'End If
            'txtSUSSFechaCaducidadExencion.Text = myCliente.SUSSFechaCaducidadExencion.ToString("dd/MM/yyyy")
            'If Not (cmbCategoriaSUSS.Items.FindByValue(myCliente.IdImpuestoDirectoSUSS.ToString) Is Nothing) Then
            '    cmbCategoriaSUSS.Items.FindByValue(myCliente.IdImpuestoDirectoSUSS.ToString).Selected = True
            'End If
            ControlesSUSS(.RetenerSUSS)

            txtContactoPrincipal.Text = .Contacto


            'Esto es porque muchas veces tienen que mandar correo y muchas veces no a la direccion fiscal






            GridView1.DataSource = .DetallesContactos
            GridView1.DataBind()

        End With





        Me.Title = "Cliente " + myCliente.RazonSocial.ToString
        nombrecli.Text = myCliente.RazonSocial.ToString


        Return myCliente

    End Function





    Sub BloqueosDeEdicion(ByVal myCliente As Pronto.ERP.BO.ClienteNuevo)
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or

        'Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

        'If Not p("PuedeModificar") Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(
        '    Response.Redirect(String.Format("Principal.aspx"))
        'End If





        With myCliente

            '//////////////////////////
            '/////// verifico q un desde un punto de venta no se metan en una carta de otro punto de venta
            '//////////////////////////

            Dim pventa As Integer
            Try
                pventa = If(EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)), New Empleado).PuntoVentaAsociado 'sector del confeccionó
            Catch ex As Exception
                pventa = 0
                ErrHandler2.WriteError(ex)
            End Try

            If pventa > 0 Then
                'aaaa()
            End If


            If Not EstaEsteRol("WilliamsFacturacion") Then
                txtMailFacturaElectronica.Visible = False
                lblMailFacturaElectronica.Visible = False

                lblHabilitadoCobranzas.Visible = False
                chkHabilitadoCobranzas.Visible = False
            End If


            '//////////////////////////
            '//////////////////////////
            '//////////////////////////




        End With


        '////////////////////////////////////////////
        '////////////////////////////////////////////


    End Sub


    Function AltaSetup() As Pronto.ERP.BO.ClienteNuevo
        Dim myCliente = New Pronto.ERP.BO.ClienteNuevo

        myCliente = New Pronto.ERP.BO.ClienteNuevo
        myCliente.Id = -1
        Me.Title = "Nuevo Cliente"

        BuscaTextoEnCombo(cmbCondicionIVA, "Responsable inscripto")


        BuscaTextoEnCombo(cmbMoneda, "PESOS")
        txtCodigoEmpresa.Text = EntidadManager.ExecDinamico(SC, "select top 1 idcliente+1 from clientes order by idcliente desc").Rows(0).Item(0)
        'txtCodigoEmpresa.Text = EntidadManager.ExecDinamico(SC, "DBCC CHECKIDENT  ('dbo.Clientes', NORESEED )").Rows(0).Item(0)
        Dim iddeudores = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.IdCuentaDeudoresVarios)
        txtAutocompleteCuenta.Text = EntidadManager.NombreCuentaConSufijo(SC, iddeudores)


        Return myCliente
    End Function

    Private Sub BindTypeDropDown()

        IniciaCombo(SC, cmbProvincia, tipos.Provincias)
        BuscaTextoEnCombo(cmbProvincia, "BUENOS AIRES")

        IniciaCombo(SC, cmbProvinciaDeCorreos, tipos.Provincias)
        BuscaTextoEnCombo(cmbProvinciaDeCorreos, "BUENOS AIRES")

        cmbPais.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Paises")
        cmbPais.DataTextField = "Titulo"
        cmbPais.DataValueField = "IdPais"
        cmbPais.DataBind()
        BuscaTextoEnCombo(cmbPais, "ARGENTINA")


        cmbCondicionIVA.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "DescripcionIVA")
        cmbCondicionIVA.DataTextField = "Titulo"
        cmbCondicionIVA.DataValueField = "IdCodigoIVA"
        cmbCondicionIVA.DataBind()



        cmbCondicionCompra.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "CondicionesCompra")
        cmbCondicionCompra.DataTextField = "Titulo"
        cmbCondicionCompra.DataValueField = "IdCondicionCompra"
        cmbCondicionCompra.DataBind()

        'cmbCuentaContable.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")
        'cmbCuentaContable.DataTextField = "Titulo"
        'cmbCuentaContable.DataValueField = "IdCuenta"
        'cmbCuentaContable.DataBind()

        cmbMoneda.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Monedas")
        cmbMoneda.DataTextField = "Titulo"
        cmbMoneda.DataValueField = "IdMoneda"
        cmbMoneda.DataBind()


        cmbListaDePrecios.DataSource = EntidadManager.ExecDinamico(SC, "ListasPrecios_TL")
        cmbListaDePrecios.DataTextField = "Titulo"
        cmbListaDePrecios.DataValueField = "IdListaPrecios"
        cmbListaDePrecios.DataBind()
        cmbListaDePrecios.Items.Insert(0, New ListItem("--Elija una lista--", -1))



        cmbCategoriaIIBB.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        cmbCategoriaIIBB.DataTextField = "Titulo"
        cmbCategoriaIIBB.DataValueField = "IdIBCondicion"
        cmbCategoriaIIBB.DataBind()
        cmbCategoriaIIBB.Items.Insert(0, New ListItem("--Elija una condición--", -1))




        DropDownList4.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        DropDownList4.DataTextField = "Titulo"
        DropDownList4.DataValueField = "IdIBCondicion"
        DropDownList4.DataBind()
        DropDownList4.Items.Insert(0, New ListItem("--Elija una condición--", -1))


        DropDownList5.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        DropDownList5.DataTextField = "Titulo"
        DropDownList5.DataValueField = "IdIBCondicion"
        DropDownList5.DataBind()
        DropDownList5.Items.Insert(0, New ListItem("--Elija una condición--", -1))


        'DropDownList2.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")
        'DropDownList2.DataTextField = "Titulo"
        'DropDownList2.DataValueField = "IdCuenta"
        'DropDownList2.DataBind()



        'DropDownList1.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")
        'DropDownList1.DataTextField = "Titulo"
        'DropDownList1.DataValueField = "IdCuenta"
        'DropDownList1.DataBind()


        DropDownList3.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Bancos_TL")
        DropDownList3.DataTextField = "Titulo"
        DropDownList3.DataValueField = "IdBanco"
        DropDownList3.DataBind()




        DropDownList6.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "IGCondiciones_TL")
        DropDownList6.DataTextField = "Titulo"
        DropDownList6.DataValueField = "IdIGCondicion"
        DropDownList6.DataBind()


    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Not mAltaItem Then
            EndEditing()
        Else
            mAltaItem = False
        End If
    End Sub

    Private Sub EndEditing()
        'Response.Redirect(String.Format("Clientes.aspx"))
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim mOk As Boolean
        Page.Validate()
        mOk = Page.IsValid






        If mOk Then
            If Not mAltaItem Then
                Dim myCliente As Pronto.ERP.BO.ClienteNuevo = CType(Me.ViewState(mKey), Pronto.ERP.BO.ClienteNuevo)


                With myCliente

                    .codigo = "CL" & Format(Val(txtCodigoEmpresa.Text.ToString), "0000")
                    .RazonSocial = txtRazonSocial.Text
                    .Direccion = txtDireccion.Text
                    .CodigoPostal = txtCodigoPostal.Text

                    'si es eventual, no validar el cuit
                    .Eventual = ProntoCheckSINO(chkEventual)

                    .Cuit = txtCUIT.Text

                    .Telefono1 = txtTelefono1.Text
                    .Fax = txtFax.Text
                    .Email = txtEmail.Text
                    .Calificacion = Convert.ToInt32(Val(txtCalificacion.Text))

                    .NombreFantasia = txtNombreFantasia.Text
                    .PaginaWeb = txtPaginaWeb.Text

                    'myCliente.InformacionAuxiliar = txtInformacionAuxiliar.Text
                    'myCliente.ChequesALaOrdenDe = txtChequesALaOrdenDe.Text
                    'myCliente.Observaciones = txtObservaciones.Text
                    'myCliente.Importaciones_NumeroInscripcion = txtImportaciones_NumeroInscripcion.Text
                    'myCliente.Importaciones_DenominacionInscripcion = txtImportaciones_DenominacionInscripcion.Text
                    'myCliente.Nombre1 = txtNombre1.Text
                    'myCliente.Nombre2 = txtNombre2.Text
                    'myRequerimiento.Fecha = Convert.ToDateTime(txtFechaRequerimiento.Text)

                    .IdListaPrecios = Convert.ToInt32(cmbListaDePrecios.SelectedValue)

                    .IdLocalidad = BuscaIdLocalidadPreciso(txtLocalidad.Text, SC)
                    .IdProvincia = Convert.ToInt32(cmbProvincia.SelectedValue)
                    .IdPais = Convert.ToInt32(cmbPais.SelectedValue)

                    .CartaPorteTipoDeAdjuntoDeFacturacion = DropDownList7.SelectedIndex


                    .IdLocalidadDeCorreos = BuscaIdLocalidadPreciso(txtLocalidadDeCorreos.Text, SC)
                    .IdProvinciaDeCorreos = Convert.ToInt32(cmbProvinciaDeCorreos.SelectedValue)
                    .DireccionDeCorreos = txtDireccionDeCorreos.Text
                    .CodigoPostalDeCorreos = txtCodigoPostalDeCorreos.Text
                    .ObservacionesDeCorreos = txtObservacionesDeCorreos.Text



                    .IdCodigoIva = Convert.ToInt32(cmbCondicionIVA.SelectedValue)
                    .IdCondicionCompra = Convert.ToInt32(cmbCondicionCompra.SelectedValue)

                    Try
                        .IdCuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAutocompleteCuenta.Text, SC)
                    Catch ex As Exception

                    End Try

                    .EmailFacturacionElectronica = txtMailFacturaElectronica.Text
                    .AutorizacionSyngenta = txtAutorizadorSyngenta.Text


                    .IdMoneda = Convert.ToInt32(cmbMoneda.SelectedValue)


                    .esAgenteRetencionIVA = CheckBox1.Checked
                    .IGCondicion = Convert.ToInt32(DropDownList6.SelectedValue)
                    .BaseMinimaParaPercepcionIVA = StringToDecimal(txtBaseMinima.Text)
                    .PorcentajePercepcionIVA = StringToDecimal(txtPorcentajeAplicar.Text)

                    .IBPorcentajeExencion = StringToDecimal(txtIBDdirecto.Text)
                    .GrupoIIBB = StringToDecimal(txtGrupoIB.Text)

                    .ExpresionRegularNoAgruparFacturasConEstosVendedores = TextBox4.Text

                    .ExigeDatosCompletosEnCartaDePorteQueLoUse = ProntoCheckSINO(chkExigirValidacionCompletaDeCartaDePorte)
                    .IncluyeTarifaEnFactura = ProntoCheckSINO(chkIncluyeTarifaEnFactura)

                    .EsAcondicionadoraDeCartaPorte = ProntoCheckSINO(chkEsAcondicionadora)
                    .EsClienteExportador = ProntoCheckSINO(chkEsExportador)
                    .UsaGastosAdmin = ProntoCheckSINO(chkUsaGastosAdmin)
                    .DeshabilitadoPorCobranzas = ProntoCheckSINO(chkHabilitadoCobranzas)
                    .EsClienteObservacionesFacturadoComoCorredor = ProntoCheckSINO(chkClienteObservacionesFacturadoComoCorredor)


                    '.SeLeFacturaCartaPorteComoTitular = ProntoCheckSINO(chkComoTitular)
                    '.SeLeFacturaCartaPorteComoIntermediario = ProntoCheckSINO(chkComoIntermediario)
                    '.SeLeFacturaCartaPorteComoRemcomercial = ProntoCheckSINO(chkComoRComercial)
                    '.SeLeFacturaCartaPorteComoClienteAuxiliar = ProntoCheckSINO(chkComoClienteAuxiliar)
                    '.SeLeFacturaCartaPorteComoRemcomercial2 = ProntoCheckSINO(chkComoRComercial)
                    '.SeLeFacturaCartaPorteComoCorredor = ProntoCheckSINO(chkComoCorredor)
                    '.SeLeFacturaCartaPorteComoDestinatarioLocal = ProntoCheckSINO(chkComoDestinatarioLocal)
                    '.SeLeFacturaCartaPorteComoDestinatarioExportador = ProntoCheckSINO(chkComoDestinatarioExportador)
                    '.SeLeDerivaSuFacturaAlCorredorDeLaCarta = ProntoCheckSINO(chkDerivarleSuFacturaAlCorredorDeLaCarta)

                    .EsEntregador = ProntoCheckSINO(chkEsEntregador)


                    'todo "* Modificación en los tildes de clientes: Separar ""Destinatario"" en dos: ""Destinatario Local"" y ""Destinatario Exportación""

                    'todo                   * Nueva función en Facturación Automática: "Facturarle al Corredor". Agregar un tilde en los clientes con ese nombre. En el Automático, las Cartas de Porte que corresponda facturarle a estos clientes se le facturarán al Corredor de cada Carta de Porte



                    'IIBB
                    If Not RadioButtonList3.SelectedItem Is Nothing Then
                        myCliente.IBCondicion = RadioButtonList3.SelectedItem.Value
                    End If
                    If CheckBox1.Checked Then
                        myCliente.SujetoEmbargado = "SI"
                    Else
                        myCliente.SujetoEmbargado = "NO"
                    End If
                    'If txtFechaLimiteExentoIIBB.Enabled Then
                    '    myCliente.FechaLimiteExentoIIBB = iisValidSqlDate(txtFechaLimiteExentoIIBB.Text)
                    'Else
                    '    myCliente.FechaLimiteExentoIIBB = DateTime.MinValue
                    'End If
                    If txtIBNumeroInscripcion.Enabled Then
                        myCliente.IBNumeroInscripcion = txtIBNumeroInscripcion.Text
                    Else
                        myCliente.IBNumeroInscripcion = ""
                    End If
                    If cmbCategoriaIIBB.Enabled Then
                        myCliente.IdIBCondicionPorDefecto = Convert.ToInt32(cmbCategoriaIIBB.SelectedValue)
                    Else
                        myCliente.IdIBCondicionPorDefecto = -1
                    End If

                    'If txtCoeficienteIIBBUnificado.Enabled Then
                    '    myCliente.CoeficienteIIBBUnificado = Convert.ToInt32(txtCoeficienteIIBBUnificado.Text)
                    'Else
                    myCliente.CoeficienteIIBBUnificado = 0
                    'End If

                    'If txtSaldoEmbargo.Enabled Then
                    '    myCliente.SaldoEmbargo = Convert.ToDouble(txtSaldoEmbargo.Text)
                    'Else
                    '    myCliente.SaldoEmbargo = 0
                    'End If
                    If txtPorcentajeAplicar.Enabled Then
                        myCliente.DetalleEmbargo = txtPorcentajeAplicar.Text
                    Else
                        myCliente.DetalleEmbargo = ""
                    End If

                    'If txtPorcentajeIBDirecto.Enabled Then
                    '    myCliente.PorcentajeIBDirecto = Convert.ToDouble(txtPorcentajeIBDirecto.Text)
                    'Else
                    myCliente.PorcentajeIBDirecto = 0
                    'End If

                    'If txtGrupoIIBB.Enabled Then
                    '    myCliente.GrupoIIBB = Convert.ToDouble(txtGrupoIIBB.Text)
                    'Else
                    myCliente.GrupoIIBB = 0
                    'End If


                    If txtFechaInicioVigenciaIBDirecto.Enabled Then
                        myCliente.FechaInicioVigenciaIBDirecto = iisValidSqlDate(txtFechaInicioVigenciaIBDirecto.Text)
                    Else
                        myCliente.FechaInicioVigenciaIBDirecto = DateTime.MinValue
                    End If
                    If txtFechaFinVigenciaIBDirecto.Enabled Then
                        myCliente.FechaFinVigenciaIBDirecto = iisValidSqlDate(txtFechaFinVigenciaIBDirecto.Text)
                    Else
                        myCliente.FechaFinVigenciaIBDirecto = DateTime.MinValue
                    End If

                    'IVA
                    If CheckBox2.Checked Then
                        myCliente.IvaExencionRetencion = "SI"
                    Else
                        myCliente.IvaExencionRetencion = "NO"
                    End If
                    If txtIvaFechaCaducidadExencion.Enabled Then
                        myCliente.IvaFechaCaducidadExencion = iisValidSqlDate(txtIvaFechaCaducidadExencion.Text)
                    Else
                        myCliente.IvaFechaCaducidadExencion = DateTime.MinValue
                    End If

                    'If txtIvaPorcentajeExencion.Enabled Then
                    ' myCliente.IvaPorcentajeExencion = Convert.ToDouble(txtIvaPorcentajeExencion.Text)
                    'Else
                    myCliente.IvaPorcentajeExencion = 0
                    'End If

                    If txtCodigoSituacionRetencionIVA.Enabled Then
                        .CodigoSituacionRetencionIVA = txtCodigoSituacionRetencionIVA.Text
                    Else
                        .CodigoSituacionRetencionIVA = ""
                    End If


                    .Contacto = txtContactoPrincipal.Text



                    .HabilitadoParaCartaPorte = chkHabilitadoParaCartaPorte.Checked




                    .Contactos = txtContactos.Text
                    .CorreosElectronicos = txtCorreosElectronicos.Text
                    .TelefonosFijosOficina = txtTelefonosFijosOficina.Text
                    .TelefonosCelulares = txtTelefonosCelulares.Text

                    '//////////////////////////////////////
                    'agregar esto al manager.isvalid

                    If .IdCuenta <= 0 Then .IdCuenta = 21

                    If .IdLocalidad = -1 Then
                        MsgBoxAjax(Me, "Elija una localidad")
                        Return
                    End If
                    If .IdProvincia = -1 Then
                        MsgBoxAjax(Me, "Elija una provincia")
                        Return
                    End If
                    '///////////////////////////////

                End With

                Dim s = Validar(SC, myCliente)

                If s <> "" Then
                    MsgBoxAjax(Me, s)
                    Return
                End If


                Try
                    Dim idcli = ClienteManager.Save(SC, myCliente, Session(SESSIONPRONTO_UserName))
                    grabarExt(idcli)



                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MsgBoxAjax(Me, "El cliente no es válido: " & ex.ToString)
                    Exit Sub
                End Try


                EndEditing()
            Else
                mAltaItem = False
            End If
        End If
    End Sub


    Function grabarExt(idcliente As Integer)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))

        Dim oCliente = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = idcliente And i.PuntoVenta = enumWilliamsPuntoVenta.BuenosAires).SingleOrDefault
        If oCliente Is Nothing Then oCliente = New CartasDePorteReglasDeFacturacion
        With oCliente
            .IdCliente = idcliente
            .PuntoVenta = 1

            .SeLeFacturaCartaPorteComoTitular = ProntoCheckSINO(chkComoTitular)
            .SeLeFacturaCartaPorteComoIntermediario = ProntoCheckSINO(chkComoIntermediario)
            .SeLeFacturaCartaPorteComoRemcomercial = ProntoCheckSINO(chkComoRComercial)
            .SeLeFacturaCartaPorteComoClienteAuxiliar = ProntoCheckSINO(chkComoClienteAuxiliar)
            .SeLeFacturaCartaPorteComoCorredor = ProntoCheckSINO(chkComoCorredor)
            .SeLeFacturaCartaPorteComoDestinatario = ProntoCheckSINO(chkComoDestinatarioLocal)
            .SeLeFacturaCartaPorteComoDestinatarioExportador = ProntoCheckSINO(chkComoDestinatarioExportador)
            .SeLeDerivaSuFacturaAlCorredorDeLaCarta = ProntoCheckSINO(chkDerivarleSuFacturaAlCorredorDeLaCarta)
            .EsEntregador = ProntoCheckSINO(chkEsEntregador)

            If oCliente.IdRegla = 0 Then
                db.CartasDePorteReglasDeFacturacions.InsertOnSubmit(oCliente)
            End If
        End With


        Dim oCliente2 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = idcliente And i.PuntoVenta = enumWilliamsPuntoVenta.SanLorenzo).SingleOrDefault
        If oCliente2 Is Nothing Then oCliente2 = New CartasDePorteReglasDeFacturacion
        With oCliente2
            .IdCliente = idcliente
            .PuntoVenta = 2

            .SeLeFacturaCartaPorteComoTitular = ProntoCheckSINO(chkComoTitular2)
            .SeLeFacturaCartaPorteComoIntermediario = ProntoCheckSINO(chkComoIntermediario2)
            .SeLeFacturaCartaPorteComoRemcomercial = ProntoCheckSINO(chkComoRComercial2)
            .SeLeFacturaCartaPorteComoClienteAuxiliar = ProntoCheckSINO(chkComoClienteAuxiliar2)
            .SeLeFacturaCartaPorteComoCorredor = ProntoCheckSINO(chkComoCorredor2)
            .SeLeFacturaCartaPorteComoDestinatario = ProntoCheckSINO(chkComoDestinatarioLocal2)
            .SeLeFacturaCartaPorteComoDestinatarioExportador = ProntoCheckSINO(chkComoDestinatarioExportador2)
            .SeLeDerivaSuFacturaAlCorredorDeLaCarta = ProntoCheckSINO(chkDerivarleSuFacturaAlCorredorDeLaCarta2)
            .EsEntregador = ProntoCheckSINO(chkEsEntregador2)

        End With
        If oCliente2.IdRegla = 0 Then
            db.CartasDePorteReglasDeFacturacions.InsertOnSubmit(oCliente2)
        End If



        Dim oCliente3 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = idcliente And i.PuntoVenta = enumWilliamsPuntoVenta.ArroyoSeco).SingleOrDefault
        If oCliente3 Is Nothing Then oCliente3 = New CartasDePorteReglasDeFacturacion
        With oCliente3
            .IdCliente = idcliente
            .PuntoVenta = 3

            .SeLeFacturaCartaPorteComoTitular = ProntoCheckSINO(chkComoTitular3)
            .SeLeFacturaCartaPorteComoIntermediario = ProntoCheckSINO(chkComoIntermediario3)
            .SeLeFacturaCartaPorteComoRemcomercial = ProntoCheckSINO(chkComoRComercial3)
            .SeLeFacturaCartaPorteComoClienteAuxiliar = ProntoCheckSINO(chkComoClienteAuxiliar3)
            .SeLeFacturaCartaPorteComoCorredor = ProntoCheckSINO(chkComoCorredor3)
            .SeLeFacturaCartaPorteComoDestinatario = ProntoCheckSINO(chkComoDestinatarioLocal3)
            .SeLeFacturaCartaPorteComoDestinatarioExportador = ProntoCheckSINO(chkComoDestinatarioExportador3)
            .SeLeDerivaSuFacturaAlCorredorDeLaCarta = ProntoCheckSINO(chkDerivarleSuFacturaAlCorredorDeLaCarta3)
            .EsEntregador = ProntoCheckSINO(chkEsEntregador3)

        End With
        If oCliente3.IdRegla = 0 Then
            db.CartasDePorteReglasDeFacturacions.InsertOnSubmit(oCliente3)
        End If

        Dim oCliente4 = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = idcliente And i.PuntoVenta = enumWilliamsPuntoVenta.BahiaBlanca).SingleOrDefault
        If oCliente4 Is Nothing Then oCliente4 = New CartasDePorteReglasDeFacturacion
        With oCliente4
            .IdCliente = idcliente
            .PuntoVenta = 4

            .SeLeFacturaCartaPorteComoTitular = ProntoCheckSINO(chkComoTitular4)
            .SeLeFacturaCartaPorteComoIntermediario = ProntoCheckSINO(chkComoIntermediario4)
            .SeLeFacturaCartaPorteComoRemcomercial = ProntoCheckSINO(chkComoRComercial4)
            .SeLeFacturaCartaPorteComoClienteAuxiliar = ProntoCheckSINO(chkComoClienteAuxiliar4)
            .SeLeFacturaCartaPorteComoCorredor = ProntoCheckSINO(chkComoCorredor4)
            .SeLeFacturaCartaPorteComoDestinatario = ProntoCheckSINO(chkComoDestinatarioLocal4)
            .SeLeFacturaCartaPorteComoDestinatarioExportador = ProntoCheckSINO(chkComoDestinatarioExportador4)
            .SeLeDerivaSuFacturaAlCorredorDeLaCarta = ProntoCheckSINO(chkDerivarleSuFacturaAlCorredorDeLaCarta4)
            .EsEntregador = ProntoCheckSINO(chkEsEntregador4)

        End With
        If oCliente4.IdRegla = 0 Then
            db.CartasDePorteReglasDeFacturacions.InsertOnSubmit(oCliente4)
        End If


        db.SubmitChanges()

    End Function





    Protected Sub RadioButtonList3_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList3.SelectedIndexChanged
        ControlesIIBB(RadioButtonList3.SelectedItem.Value)
    End Sub



    Private Sub ControlesIIBB(ByVal Codigo As Integer)
        If Codigo = 1 Or Codigo = 4 Then
            cmbCategoriaIIBB.Enabled = False
            'txtFechaLimiteExentoIIBB.Enabled = False
            txtIBNumeroInscripcion.Enabled = False
            'txtCoeficienteIIBBUnificado.Enabled = False
            CheckBox1.Enabled = False
            txtBaseMinima.Enabled = False
            txtPorcentajeAplicar.Enabled = False
            'txtPorcentajeIBDirecto.Enabled = False
            'txtGrupoIIBB.Enabled = False
            txtFechaInicioVigenciaIBDirecto.Enabled = False
            txtFechaFinVigenciaIBDirecto.Enabled = False


            CheckBox1.Enabled = False
            DropDownList6.Enabled = False
            txtBaseMinima.Enabled = False
            txtPorcentajeAplicar.Enabled = False

            txtIBDdirecto.Enabled = False
            txtGrupoIB.Enabled = False
        Else
            cmbCategoriaIIBB.Enabled = True
            'txtFechaLimiteExentoIIBB.Enabled = True
            txtIBNumeroInscripcion.Enabled = True
            'txtCoeficienteIIBBUnificado.Enabled = True
            CheckBox1.Enabled = True
            txtBaseMinima.Enabled = True
            txtPorcentajeAplicar.Enabled = True
            'txtPorcentajeIBDirecto.Enabled = True
            'txtGrupoIIBB.Enabled = True
            txtFechaInicioVigenciaIBDirecto.Enabled = True
            txtFechaFinVigenciaIBDirecto.Enabled = True

            CheckBox1.Enabled = True
            DropDownList6.Enabled = True
            txtBaseMinima.Enabled = True
            txtPorcentajeAplicar.Enabled = True

            txtIBDdirecto.Enabled = True
            txtGrupoIB.Enabled = True
        End If
    End Sub

    Private Sub ControlesIVA(ByVal Codigo As String)
        If Codigo = "SI" Then
            txtIvaPorcentajeExencion.Enabled = False
            txtIvaFechaCaducidadExencion.Enabled = False
        Else
            txtIvaPorcentajeExencion.Enabled = True
            txtIvaFechaCaducidadExencion.Enabled = True
        End If
    End Sub

    Private Sub ControlesSUSS(ByVal Codigo As String)
        'If Codigo = "EX" Then
        '    cmbCategoriaSUSS.Enabled = False
        '    txtSUSSFechaCaducidadExencion.Enabled = True
        'ElseIf Codigo = "SI" Then
        '    cmbCategoriaSUSS.Enabled = True
        '    txtSUSSFechaCaducidadExencion.Enabled = False
        'Else
        '    cmbCategoriaSUSS.Enabled = False
        '    txtSUSSFechaCaducidadExencion.Enabled = False
        'End If
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myCliente As Pronto.ERP.BO.ClienteNuevo
        If e.CommandName.ToLower = "eliminar" Then
            If (Me.ViewState(mKey) IsNot Nothing) Then
                myCliente = CType(Me.ViewState(mKey), Pronto.ERP.BO.ClienteNuevo)
                myCliente.DetallesContactos(mIdItem).Eliminado = True
                Me.ViewState.Add(mKey, myCliente)
                GridView1.DataSource = myCliente.DetallesContactos
                GridView1.DataBind()
            End If

        ElseIf e.CommandName.ToLower = "editar" Then
            ViewState("IdDetalleCliente") = mIdItem
            If (Me.ViewState(mKey) IsNot Nothing) Then
                MostrarElementos(True)
                myCliente = CType(Me.ViewState(mKey), Pronto.ERP.BO.ClienteNuevo)
                myCliente.DetallesContactos(mIdItem).Eliminado = False
                txtContacto.Text = myCliente.DetallesContactos(mIdItem).Contacto
                txtContactoPuesto.Text = myCliente.DetallesContactos(mIdItem).Puesto
                txtContactoTelefono.Text = myCliente.DetallesContactos(mIdItem).Telefono
                txtContactoEmail.Text = myCliente.DetallesContactos(mIdItem).Email
            End If
        End If

    End Sub

    Private Sub MostrarElementos(ByVal Modo As Boolean)
        lblContacto.Visible = Modo
        lblPuesto.Visible = Modo
        lblTelefono.Visible = Modo
        lblEmail.Visible = Modo
        txtContacto.Visible = Modo
        txtContactoPuesto.Visible = Modo
        txtContactoTelefono.Visible = Modo
        txtContactoEmail.Visible = Modo
        btnSaveItem.Visible = Modo
        btnCancelItem.Visible = Modo
        btnSave.Enabled = Not Modo
        btnCancel.Enabled = Not Modo
    End Sub

    Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
        MostrarElementos(False)
        mAltaItem = True
    End Sub

    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click
        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleCliente"), Integer)
            Dim myCliente As Pronto.ERP.BO.ClienteNuevo = CType(Me.ViewState(mKey), Pronto.ERP.BO.ClienteNuevo)
            If mIdItem = -1 Then
                Dim mItem 'As ClienteContacto = New Pronto.ERP.BO.ClienteContacto
                mItem.Id = myCliente.DetallesContactos.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myCliente.DetallesContactos.Add(mItem)
            End If
            With myCliente.DetallesContactos(mIdItem)
                .Contacto = txtContacto.Text
                .Puesto = txtContactoPuesto.Text
                .Telefono = txtContactoTelefono.Text
                .Email = txtContactoEmail.Text
            End With
            Me.ViewState.Add(mKey, myCliente)
            GridView1.DataSource = myCliente.DetallesContactos
            GridView1.DataBind()
        End If
        MostrarElementos(False)
        mAltaItem = True
    End Sub

    Protected Sub btnNuevoItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNuevoItem.Click
        ViewState("IdDetalleCliente") = -1
        MostrarElementos(True)
    End Sub

    Protected Sub lnkEditarListaPrecio_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEditarListaPrecio.Click
        Dim idLista As Long

        If Not BDLmasterPermisosManager.PuedeLeer(ConexBDLmaster, usuario.UserId, BDLmasterPermisosManager.EntidadesPermisos.Listas_de_Precios) Then
            MsgBoxAjax(Me, "Se necesitan permisos para ver la lista de precios")
            Return
        End If


        'Si ya tiene una lista, la edito. Si no, la creo, la asigno al combo, y la edito
        If cmbListaDePrecios.SelectedValue <> -1 Then
            'la edito

            idLista = cmbListaDePrecios.SelectedValue
        Else
            'la creo

            If Not BDLmasterPermisosManager.PuedeModificar(ConexBDLmaster, usuario.UserId, BDLmasterPermisosManager.EntidadesPermisos.Listas_de_Precios) Then
                MsgBoxAjax(Me, "Se necesitan permisos para crear la lista de precios")
                Return
            End If


            idLista = ListaPreciosManager.CrearLista(SC, txtRazonSocial.Text & " - Precios", 1)
            'Dim dt = ListaPreciosManager.TraerMetadata(SC)
            'Dim dr = dt.NewRow
            'dr.Item("Descripcion") = txtRazonSocial.Text & " - Precios"
            'dr.Item("IdMoneda") = 1
            'dr.Item("NumeroLista") = EntidadManager.ExecDinamico(SC, "select top 1 NumeroLista from ListasPrecios order by NumeroLista DESC").Rows(0).Item(0) + 1
            'dt.Rows.Add(dr)
            'idLista = ListaPreciosManager.Insert(SC, dt)
            'idLista = dr.Item(0)


            'refresco el combo
            cmbListaDePrecios.DataSource = EntidadManager.ExecDinamico(SC, "ListasPrecios_TL")
            cmbListaDePrecios.DataTextField = "Titulo"
            cmbListaDePrecios.DataValueField = "IdListaPrecios"
            cmbListaDePrecios.DataBind()
            cmbListaDePrecios.Items.Insert(0, New ListItem("--Elija una lista--", -1))
            BuscaIDEnCombo(cmbListaDePrecios, idLista)

            '////////////////////////////////
            'lo grabo porque sino pasa que editan la lista de precio pensando que ya está asociada al cliente
            'es el mal menor
            If IdEntity <> -1 Then
                EntidadManager.ExecDinamico(SC, "UPDATE Clientes SET idlistaprecios=" & idLista & " WHERE idCliente=" & IdEntity)
            End If
            '////////////////////////////////

        End If




        'abro la ventana. probablemente sea mejor hacerlo con un Hiperlink
        Dim str As String
        str = "window.open('ListasPrecios.aspx?Id=" & idLista & "');"
        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"

        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)

    End Sub

    Protected Sub txtAutoCompleteCorredor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutoCompleteCorredor.TextChanged
        TextBox4.Text &= "|" & txtAutoCompleteCorredor.Text
        txtAutoCompleteCorredor.Text = ""
    End Sub

    Protected Sub btnVaciarCorredoresSeparados_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnVaciarCorredoresSeparados.Click
        TextBox4.Text = ""
    End Sub



    Protected Sub butVerLog_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles butVerLog.Click
        VerLog()
    End Sub

    Sub VerLog()

        'Debug.Print(dt.Rows.Count)
        Dim s As String = "" '= dt.ToString()
        'Join(", ", dt.Rows(0).ItemArray)

        Dim listaCartas As New Generic.List(Of String)

        'For Each r In dt.Rows
        '    Dim texto As String = r.Item(0) & " " & r.Item(1) & " " & r.Item(2) & " " & r.Item(3) & " " & r.Item(4) & " " & r.Item(5) & " " & r.Item(6) & " " & r.Item(7) & "\n\n <br/>"
        '    Dim texto As String = r.Item(5) & " " & r.Item(6)
        '    Dim idcarta = TextoEntre(texto, "CartaPorte", "CDP")
        '    listaCartas.Add(Val(idcarta))
        '    s &= "<a href=""CartaDePorte.aspx?Id=" & idcarta & """ target=""_blank"">" & texto & "</a> <br/>"

        'Next

        Try
            Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))
            Dim o() As String = (From i In db.Logs Where i.IdComprobante = IdCliente Select i.Detalle & " " & i.FechaRegistro.ToString & " " & i.AuxString1).ToArray


            lblLog.Text = s & Join(o, vbCrLf & "\n") & vbCrLf
        Catch ex As Exception
            ErrHandler2.WriteError("Verlog Facturas")
            ErrHandler2.WriteError(ex)
        End Try
        'MsgBoxAjax(Me, s)

        '        "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
        '                                              CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _

    End Sub

    Protected Sub btnImprimiSobreChicoXML_Click(sender As Object, e As System.EventArgs) Handles btnImprimiSobreChicoXML.Click


        'si es nuevo el cliente, no mostrar
        If IdCliente = -1 Then
            MsgBoxAjax(Me, "Grabá el cliente antes de imprimir el sobre")
            Exit Sub
        End If


        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1

        Dim output As String
        'output = ImprimirWordDOT("Presupuesto_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPresupuesto)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa


        Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )


        Dim ofac = ClienteManager.GetItem(SC, IdEntity)

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Genera las plantillas 
        Dim p = DirApp() & "\Documentos\" & "Williams_SobreChico.docx"
        output = System.IO.Path.GetTempPath() & "\" & "SobreChico_" & ofac.Nombre1 & ".docx"
        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile2.Exists Then
            MyFile2.Delete()
        End If

        Try
            System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

        Catch ex As Exception
            MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
            Exit Sub
        End Try


        'Try
        '    Kill(System.IO.Path.GetTempPath & "FacturaNET_Numero*.docx")
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try



        SobreChicoXML_DOCX_Williams(output, ofac, SC)



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
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try


    End Sub

    Protected Sub btnImprimiSobreGrandeXML_Click(sender As Object, e As System.EventArgs) Handles btnImprimiSobreGrandeXML.Click

        If IdCliente = -1 Then
            MsgBoxAjax(Me, "Grabá el cliente antes de imprimir el sobre")
            Exit Sub
        End If


        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1

        Dim output As String
        'output = ImprimirWordDOT("Presupuesto_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPresupuesto)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa


        Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )


        Dim ofac = ClienteManager.GetItem(SC, IdEntity)

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Genera las plantillas 
        Dim p = DirApp() & "\Documentos\" & "Williams_SobreMediano.docx"
        output = System.IO.Path.GetTempPath() & "\" & "SobreMediano_" & ofac.Nombre1 & ".docx"
        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile2.Exists Then
            MyFile2.Delete()
        End If

        Try
            System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

        Catch ex As Exception
            MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
            Exit Sub
        End Try


        'Try
        '    Kill(System.IO.Path.GetTempPath & "FacturaNET_Numero*.docx")
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try



        SobreChicoXML_DOCX_Williams(output, ofac, SC)



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
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    Public Shared Sub SobreChicoXML_DOCX_Williams(ByVal document As String, ByVal oFac As Pronto.ERP.BO.ClienteNuevo, ByVal SC As String)

        'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



        Dim settings As New SimplifyMarkupSettings
        With settings
            .RemoveComments = True
            .RemoveContentControls = True
            .RemoveEndAndFootNotes = True
            .RemoveFieldCodes = False
            .RemoveLastRenderedPageBreak = True
            .RemovePermissions = True
            .RemoveProof = True
            .RemoveRsidInfo = True
            .RemoveSmartTags = True
            .RemoveSoftHyphens = True
            .ReplaceTabsWithSpaces = True
        End With
        OpenXmlPowerTools.MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





        Using (wordDoc)
            Dim docText As String = Nothing
            Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



            Using (sr)
                docText = sr.ReadToEnd
            End Using

            '/////////////////////////////
            '/////////////////////////////
            'Hace el reemplazo
            '/////////////////////////////




            Try



                regexReplace2(docText, "#Cliente#", oFac.RazonSocial.Replace("&", "Y"))
                regexReplace2(docText, "#CodigoCliente#", oFac.CodigoCliente)


                regexReplace2(docText, "#Direccion#", oFac.DireccionDeCorreos) 'Direccion) 'oFac.Domicilio)
                'regexReplace2(docText, "#DomicilioRenglon2#", oFac.Domicilio) 'oFac.Domicilio)


                regexReplace2(docText, "#Localidad#", EntidadManager.NombreLocalidad(SC, oFac.IdLocalidadDeCorreos)) 'oFac.Domicilio)

                regexReplace2(docText, "#CodPostal#", oFac.CodigoPostalDeCorreos)
                regexReplace2(docText, "#Provincia#", EntidadManager.NombreProvincia(SC, oFac.IdProvinciaDeCorreos))

                regexReplace2(docText, "#CUIT#", oFac.Cuit)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            'regexReplace2(docText, "#NumeroFactura#", oFac.Numero)
            'regexReplace2(docText, "#Fecha#", oFac.Fecha)








            Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
            Using (sw)
                sw.Write(docText)
            End Using








        End Using


        'Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )
        'For n = 1 To CANTIDAD_COPIAS

        '    Dim wordDoc1 As WordprocessingDocument = WordprocessingDocument.Open(document, False)
        '    Dim wordDoc2 As WordprocessingDocument = WordprocessingDocument.Open(document, True)
        '    Using (wordDoc2)
        '        Dim themePart1 As ThemePart = wordDoc1.MainDocumentPart.ThemePart
        '        Dim themePart2 As ThemePart = wordDoc2.MainDocumentPart.ThemePart
        '        Dim streamReader As StreamReader = New StreamReader(themePart1.GetStream())
        '        Dim streamWriter As StreamWriter = New StreamWriter(themePart2.GetStream(FileMode.Create))
        '        Using (streamWriter)
        '            streamWriter.Write(streamReader.ReadToEnd)
        '        End Using
        '    End Using

        'Next


    End Sub
End Class





