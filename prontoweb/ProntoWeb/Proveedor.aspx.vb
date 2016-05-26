Imports System
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Imports CartaDePorteManager


Partial Class Proveedor
    Inherits System.Web.UI.Page

    Private IdProveedor As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdProveedor"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdProveedor") = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdProveedor = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdProveedor
        End If
        mKey = "Proveedor_" & Me.IdEntity.ToString
        mAltaItem = False

        Usuario = New Usuario
        Usuario = session(SESSIONPRONTO_USUARIO)
        SC = Usuario.StringConnection
        'SC = ConfigurationManager.ConnectionStrings("Pronto").ConnectionString

        If Not Page.IsPostBack Then
            TextBox1.Text = IdProveedor
            BindTypeDropDown()
            Dim myProveedor As Pronto.ERP.BO.Proveedor
            If IdProveedor > 0 Then
                myProveedor = ProveedorManager.GetItem(SC, IdProveedor, True)
                If Not (myProveedor Is Nothing) Then
                    txtCodigoEmpresa.Text = myProveedor.CodigoEmpresa
                    txtRazonSocial.Text = myProveedor.RazonSocial
                    txtDireccion.Text = myProveedor.Direccion
                    txtCodigoPostal.Text = myProveedor.CodigoPostal
                    txtCUIT.Text = myProveedor.Cuit
                    txtTelefono1.Text = myProveedor.Telefono1
                    txtFax.Text = myProveedor.Fax
                    txtEmail.Text = myProveedor.Email
                    txtPaginaWeb.Text = myProveedor.PaginaWeb
                    txtIvaPorcentajeExencion.Text = myProveedor.Calificacion
                    txtInformacionAuxiliar.Text = myProveedor.InformacionAuxiliar
                    txtChequesALaOrdenDe.Text = myProveedor.ChequesALaOrdenDe
                    txtObservaciones.Text = myProveedor.Observaciones
                    txtImportaciones_NumeroInscripcion.Text = myProveedor.Importaciones_NumeroInscripcion
                    txtImportaciones_DenominacionInscripcion.Text = myProveedor.Importaciones_DenominacionInscripcion
                    txtNombre1.Text = myProveedor.Nombre1
                    txtNombre2.Text = myProveedor.Nombre2

                    If Not (cmbLocalidad.Items.FindByValue(myProveedor.IdLocalidad.ToString) Is Nothing) Then
                        cmbLocalidad.Items.FindByValue(myProveedor.IdLocalidad.ToString).Selected = True
                    End If
                    If Not (cmbProvincia.Items.FindByValue(myProveedor.IdProvincia.ToString) Is Nothing) Then
                        cmbProvincia.Items.FindByValue(myProveedor.IdProvincia.ToString).Selected = True
                    End If
                    If Not (cmbPais.Items.FindByValue(myProveedor.IdPais.ToString) Is Nothing) Then
                        cmbPais.Items.FindByValue(myProveedor.IdPais.ToString).Selected = True
                    End If
                    If Not (cmbCondicionIVA.Items.FindByValue(myProveedor.IdCodigoIva.ToString) Is Nothing) Then
                        cmbCondicionIVA.Items.FindByValue(myProveedor.IdCodigoIva.ToString).Selected = True
                    End If
                    If Not (cmbCondicionCompra.Items.FindByValue(myProveedor.IdCondicionCompra.ToString) Is Nothing) Then
                        cmbCondicionCompra.Items.FindByValue(myProveedor.IdCondicionCompra.ToString).Selected = True
                    End If
                    If Not (cmbCuentaContable.Items.FindByValue(myProveedor.IdCuenta.ToString) Is Nothing) Then
                        cmbCuentaContable.Items.FindByValue(myProveedor.IdCuenta.ToString).Selected = True
                    End If
                    If Not (cmbMoneda.Items.FindByValue(myProveedor.IdMoneda.ToString) Is Nothing) Then
                        cmbMoneda.Items.FindByValue(myProveedor.IdMoneda.ToString).Selected = True
                    End If
                    If Not (cmbEstadoActual.Items.FindByValue(myProveedor.IdEstado.ToString) Is Nothing) Then
                        cmbEstadoActual.Items.FindByValue(myProveedor.IdEstado.ToString).Selected = True
                    End If
                    If Not (cmbActividad.Items.FindByValue(myProveedor.IdActividad.ToString) Is Nothing) Then
                        cmbActividad.Items.FindByValue(myProveedor.IdActividad.ToString).Selected = True
                    End If

                    txtFechaUltimaPresentacionDocumentacion.Text = myProveedor.FechaUltimaPresentacionDocumentacion.ToString("dd/MM/yyyy")
                    txtObservacionesPresentacionDocumentacion.Text = myProveedor.ObservacionesPresentacionDocumentacion

                    If myProveedor.BienesOServicios = "B" Then
                        RadioButtonList1.Items(0).Selected = True
                    ElseIf myProveedor.BienesOServicios = "S" Then
                        RadioButtonList1.Items(1).Selected = True
                    Else
                        RadioButtonList1.Items(0).Selected = True
                    End If

                    'GANANCIAS
                    If myProveedor.IGCondicion = 1 Then
                        RadioButtonList2.Items(0).Selected = True
                    ElseIf myProveedor.IGCondicion = 2 Then
                        RadioButtonList2.Items(1).Selected = True
                    Else
                        RadioButtonList2.Items(0).Selected = True
                    End If
                    txtFechaLimiteExentoGanancias.Text = myProveedor.FechaLimiteExentoGanancias.ToString("dd/MM/yyyy")
                    If Not (cmbCategoriaGanancias.Items.FindByValue(myProveedor.IdTipoRetencionGanancia.ToString) Is Nothing) Then
                        cmbCategoriaGanancias.Items.FindByValue(myProveedor.IdTipoRetencionGanancia.ToString).Selected = True
                    End If
                    ControlesGANANCIAS(myProveedor.IGCondicion)

                    'IIBB
                    If myProveedor.IBCondicion = 1 Then
                        RadioButtonList3.Items(0).Selected = True
                    ElseIf myProveedor.IBCondicion = 2 Then
                        RadioButtonList3.Items(2).Selected = True
                    ElseIf myProveedor.IBCondicion = 3 Then
                        RadioButtonList3.Items(1).Selected = True
                    ElseIf myProveedor.IBCondicion = 4 Then
                        RadioButtonList3.Items(3).Selected = True
                    Else
                        RadioButtonList3.Items(0).Selected = True
                    End If
                    txtFechaLimiteExentoIIBB.Text = myProveedor.FechaLimiteExentoIIBB.ToString("dd/MM/yyyy")
                    txtIBNumeroInscripcion.Text = myProveedor.IBNumeroInscripcion
                    txtCoeficienteIIBBUnificado.Text = myProveedor.CoeficienteIIBBUnificado.ToString
                    If Not (cmbCategoriaIIBB.Items.FindByValue(myProveedor.IdIBCondicionPorDefecto.ToString) Is Nothing) Then
                        cmbCategoriaIIBB.Items.FindByValue(myProveedor.IdIBCondicionPorDefecto.ToString).Selected = True
                    End If
                    If myProveedor.SujetoEmbargado = "SI" Then
                        CheckBox1.Checked = True
                    End If
                    txtSaldoEmbargo.Text = myProveedor.SaldoEmbargo.ToString
                    txtDetalleEmbargo.Text = myProveedor.DetalleEmbargo
                    txtPorcentajeIBDirecto.Text = myProveedor.PorcentajeIBDirecto.ToString
                    txtGrupoIIBB.Text = myProveedor.GrupoIIBB.ToString
                    txtFechaInicioVigenciaIBDirecto.Text = myProveedor.FechaInicioVigenciaIBDirecto.ToString("dd/MM/yyyy")
                    txtFechaFinVigenciaIBDirecto.Text = myProveedor.FechaFinVigenciaIBDirecto.ToString("dd/MM/yyyy")
                    ControlesIIBB(myProveedor.IBCondicion)

                    'IVA
                    If myProveedor.IvaExencionRetencion = "SI" Then
                        CheckBox2.Checked = True
                    End If
                    txtIvaFechaCaducidadExencion.Text = myProveedor.IvaFechaCaducidadExencion.ToString("dd/MM/yyyy")
                    txtIvaPorcentajeExencion.Text = myProveedor.IvaPorcentajeExencion.ToString
                    txtCodigoSituacionRetencionIVA.Text = myProveedor.CodigoSituacionRetencionIVA
                    ControlesIVA(myProveedor.IvaExencionRetencion)

                    'SUSS
                    If myProveedor.RetenerSUSS = "EX" Then
                        RadioButtonList4.Items(0).Selected = True
                    ElseIf myProveedor.RetenerSUSS = "SI" Then
                        RadioButtonList4.Items(1).Selected = True
                    ElseIf myProveedor.RetenerSUSS = "NO" Then
                        RadioButtonList4.Items(2).Selected = True
                    Else
                        RadioButtonList4.Items(0).Selected = True
                    End If
                    txtSUSSFechaCaducidadExencion.Text = myProveedor.SUSSFechaCaducidadExencion.ToString("dd/MM/yyyy")
                    If Not (cmbCategoriaSUSS.Items.FindByValue(myProveedor.IdImpuestoDirectoSUSS.ToString) Is Nothing) Then
                        cmbCategoriaSUSS.Items.FindByValue(myProveedor.IdImpuestoDirectoSUSS.ToString).Selected = True
                    End If
                    ControlesSUSS(myProveedor.RetenerSUSS)

                    txtContactoPrincipal.Text = myProveedor.Contacto
                    GridView1.DataSource = myProveedor.DetallesContactos
                    GridView1.DataBind()

                    Me.Title = "Edicion Proveedor " + myProveedor.CodigoEmpresa.ToString
                End If
            Else
                myProveedor = New Pronto.ERP.BO.Proveedor
                myProveedor.Id = -1
                Me.Title = "Nuevo Proveedor"
            End If
            MostrarElementos(False)
            Me.ViewState.Add(mKey, myProveedor)
        End If
    End Sub

    Private Sub BindTypeDropDown()
        cmbLocalidad.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Localidades")
        cmbLocalidad.DataTextField = "Titulo"
        cmbLocalidad.DataValueField = "IdLocalidad"
        cmbLocalidad.DataBind()

        cmbProvincia.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Provincias")
        cmbProvincia.DataTextField = "Titulo"
        cmbProvincia.DataValueField = "IdProvincia"
        cmbProvincia.DataBind()

        cmbPais.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Paises")
        cmbPais.DataTextField = "Titulo"
        cmbPais.DataValueField = "IdPais"
        cmbPais.DataBind()

        cmbCondicionIVA.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "DescripcionIVA")
        cmbCondicionIVA.DataTextField = "Titulo"
        cmbCondicionIVA.DataValueField = "IdCodigoIVA"
        cmbCondicionIVA.DataBind()

        cmbCondicionCompra.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "CondicionesCompra")
        cmbCondicionCompra.DataTextField = "Titulo"
        cmbCondicionCompra.DataValueField = "IdCondicionCompra"
        cmbCondicionCompra.DataBind()

        cmbCuentaContable.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")
        cmbCuentaContable.DataTextField = "Titulo"
        cmbCuentaContable.DataValueField = "IdCuenta"
        cmbCuentaContable.DataBind()

        cmbMoneda.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Monedas")
        cmbMoneda.DataTextField = "Titulo"
        cmbMoneda.DataValueField = "IdMoneda"
        cmbMoneda.DataBind()

        cmbEstadoActual.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "EstadosProveedores")
        cmbEstadoActual.DataTextField = "Titulo"
        cmbEstadoActual.DataValueField = "IdEstado"
        cmbEstadoActual.DataBind()

        cmbActividad.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "ActividadesProveedores")
        cmbActividad.DataTextField = "Titulo"
        cmbActividad.DataValueField = "IdActividad"
        cmbActividad.DataBind()

        cmbCategoriaGanancias.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "TiposRetencionGanancia")
        cmbCategoriaGanancias.DataTextField = "Titulo"
        cmbCategoriaGanancias.DataValueField = "IdTipoRetencionGanancia"
        cmbCategoriaGanancias.DataBind()

        cmbCategoriaIIBB.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        cmbCategoriaIIBB.DataTextField = "Titulo"
        cmbCategoriaIIBB.DataValueField = "IdIBCondicion"
        cmbCategoriaIIBB.DataBind()

        cmbCategoriaSUSS.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "ImpuestosDirectos")
        cmbCategoriaSUSS.DataTextField = "Titulo"
        cmbCategoriaSUSS.DataValueField = "IdImpuestoDirecto"
        cmbCategoriaSUSS.DataBind()

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        If Not mAltaItem Then
            EndEditing()
        Else
            mAltaItem = False
        End If
    End Sub

    Private Sub EndEditing()
        Response.Redirect(String.Format("Proveedores.aspx"))
    End Sub



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim mOk As Boolean
        Page.Validate()
        mOk = Page.IsValid
        If mOk Then
            If Not mAltaItem Then
                Dim myProveedor As Pronto.ERP.BO.Proveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.Proveedor)
                myProveedor.CodigoEmpresa = txtCodigoEmpresa.Text.ToString
                myProveedor.RazonSocial = txtRazonSocial.Text
                myProveedor.Direccion = txtDireccion.Text
                myProveedor.CodigoPostal = txtCodigoPostal.Text
                myProveedor.Cuit = txtCUIT.Text
                myProveedor.Telefono1 = txtTelefono1.Text
                myProveedor.Fax = txtFax.Text
                myProveedor.Email = txtEmail.Text
                myProveedor.PaginaWeb = txtPaginaWeb.Text
                myProveedor.Calificacion = Convert.ToInt32(Val(txtCalificacion.Text))
                myProveedor.InformacionAuxiliar = txtInformacionAuxiliar.Text
                myProveedor.ChequesALaOrdenDe = txtChequesALaOrdenDe.Text
                myProveedor.Observaciones = txtObservaciones.Text
                myProveedor.Importaciones_NumeroInscripcion = txtImportaciones_NumeroInscripcion.Text
                myProveedor.Importaciones_DenominacionInscripcion = txtImportaciones_DenominacionInscripcion.Text
                myProveedor.Nombre1 = txtNombre1.Text
                myProveedor.Nombre2 = txtNombre2.Text
                'myRequerimiento.Fecha = Convert.ToDateTime(txtFechaRequerimiento.Text)

                myProveedor.IdLocalidad = Convert.ToInt32(cmbLocalidad.SelectedValue)
                myProveedor.IdProvincia = Convert.ToInt32(cmbProvincia.SelectedValue)
                myProveedor.IdPais = Convert.ToInt32(cmbPais.SelectedValue)
                myProveedor.IdCodigoIva = Convert.ToInt32(cmbCondicionIVA.SelectedValue)
                myProveedor.IdCondicionCompra = Convert.ToInt32(cmbCondicionCompra.SelectedValue)
                myProveedor.IdCuenta = Convert.ToInt32(cmbCuentaContable.SelectedValue)
                myProveedor.IdMoneda = Convert.ToInt32(cmbMoneda.SelectedValue)
                myProveedor.IdEstado = Convert.ToInt32(cmbEstadoActual.SelectedValue)
                myProveedor.IdActividad = Convert.ToInt32(cmbActividad.SelectedValue)

                myProveedor.ObservacionesPresentacionDocumentacion = txtObservacionesPresentacionDocumentacion.Text
                If txtFechaUltimaPresentacionDocumentacion.Enabled Then
                    myProveedor.FechaUltimaPresentacionDocumentacion = Convert.ToDateTime(txtFechaUltimaPresentacionDocumentacion.Text)
                Else
                    myProveedor.FechaUltimaPresentacionDocumentacion = DateTime.MinValue
                End If

                myProveedor.BienesOServicios = RadioButtonList1.SelectedItem.Value

                'GANACIAS
                myProveedor.IGCondicion = RadioButtonList2.SelectedItem.Value
                If txtFechaLimiteExentoGanancias.Enabled Then
                    myProveedor.FechaLimiteExentoGanancias = Convert.ToDateTime(txtFechaLimiteExentoGanancias.Text)
                Else
                    myProveedor.FechaLimiteExentoGanancias = DateTime.MinValue
                End If
                If cmbCategoriaGanancias.Enabled Then
                    myProveedor.IdTipoRetencionGanancia = Convert.ToInt32(cmbCategoriaGanancias.SelectedValue)
                Else
                    myProveedor.IdTipoRetencionGanancia = -1
                End If

                'IIBB
                myProveedor.IBCondicion = RadioButtonList3.SelectedItem.Value
                If CheckBox1.Checked Then
                    myProveedor.SujetoEmbargado = "SI"
                Else
                    myProveedor.SujetoEmbargado = "NO"
                End If
                If txtFechaLimiteExentoIIBB.Enabled Then
                    myProveedor.FechaLimiteExentoIIBB = Convert.ToDateTime(txtFechaLimiteExentoIIBB.Text)
                Else
                    myProveedor.FechaLimiteExentoIIBB = DateTime.MinValue
                End If
                If txtIBNumeroInscripcion.Enabled Then
                    myProveedor.IBNumeroInscripcion = txtIBNumeroInscripcion.Text
                Else
                    myProveedor.IBNumeroInscripcion = ""
                End If
                If cmbCategoriaIIBB.Enabled Then
                    myProveedor.IdIBCondicionPorDefecto = Convert.ToInt32(cmbCategoriaIIBB.SelectedValue)
                Else
                    myProveedor.IdIBCondicionPorDefecto = -1
                End If
                If txtCoeficienteIIBBUnificado.Enabled Then
                    myProveedor.CoeficienteIIBBUnificado = txtCoeficienteIIBBUnificado.Text
                Else
                    myProveedor.CoeficienteIIBBUnificado = 0
                End If
                If txtSaldoEmbargo.Enabled Then
                    myProveedor.SaldoEmbargo = Convert.ToDouble(txtSaldoEmbargo.Text)
                Else
                    myProveedor.SaldoEmbargo = 0
                End If
                If txtDetalleEmbargo.Enabled Then
                    myProveedor.DetalleEmbargo = txtDetalleEmbargo.Text
                Else
                    myProveedor.DetalleEmbargo = ""
                End If
                If txtPorcentajeIBDirecto.Enabled Then
                    myProveedor.PorcentajeIBDirecto = Convert.ToDouble(txtPorcentajeIBDirecto.Text)
                Else
                    myProveedor.PorcentajeIBDirecto = 0
                End If
                If txtGrupoIIBB.Enabled Then
                    myProveedor.GrupoIIBB = Convert.ToDouble(txtGrupoIIBB.Text)
                Else
                    myProveedor.GrupoIIBB = 0
                End If
                If txtFechaInicioVigenciaIBDirecto.Enabled Then
                    myProveedor.FechaInicioVigenciaIBDirecto = Convert.ToDateTime(txtFechaInicioVigenciaIBDirecto.Text)
                Else
                    myProveedor.FechaInicioVigenciaIBDirecto = DateTime.MinValue
                End If
                If txtFechaFinVigenciaIBDirecto.Enabled Then
                    myProveedor.FechaFinVigenciaIBDirecto = Convert.ToDateTime(txtFechaFinVigenciaIBDirecto.Text)
                Else
                    myProveedor.FechaFinVigenciaIBDirecto = DateTime.MinValue
                End If

                'IVA
                If CheckBox2.Checked Then
                    myProveedor.IvaExencionRetencion = "SI"
                Else
                    myProveedor.IvaExencionRetencion = "NO"
                End If
                If txtIvaFechaCaducidadExencion.Enabled Then
                    myProveedor.IvaFechaCaducidadExencion = Convert.ToDateTime(txtIvaFechaCaducidadExencion.Text)
                Else
                    myProveedor.IvaFechaCaducidadExencion = DateTime.MinValue
                End If
                If txtIvaPorcentajeExencion.Enabled Then
                    myProveedor.IvaPorcentajeExencion = Convert.ToDouble(txtIvaPorcentajeExencion.Text)
                Else
                    myProveedor.IvaPorcentajeExencion = 0
                End If
                If txtCodigoSituacionRetencionIVA.Enabled Then
                    myProveedor.CodigoSituacionRetencionIVA = txtCodigoSituacionRetencionIVA.Text
                Else
                    myProveedor.CodigoSituacionRetencionIVA = ""
                End If

                'SUSS
                myProveedor.RetenerSUSS = RadioButtonList4.SelectedItem.Value
                If txtSUSSFechaCaducidadExencion.Enabled Then
                    myProveedor.SUSSFechaCaducidadExencion = Convert.ToDateTime(txtSUSSFechaCaducidadExencion.Text)
                Else
                    myProveedor.SUSSFechaCaducidadExencion = DateTime.MinValue
                End If
                If cmbCategoriaSUSS.Enabled Then
                    myProveedor.IdImpuestoDirectoSUSS = Convert.ToInt32(cmbCategoriaSUSS.SelectedValue)
                Else
                    myProveedor.IdImpuestoDirectoSUSS = -1
                End If

                myProveedor.Contacto = txtContactoPrincipal.Text

                ProveedorManager.Save(SC, myProveedor)
                EndEditing()
            Else
                mAltaItem = False
            End If
        End If
    End Sub

    Protected Sub RadioButtonList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList2.SelectedIndexChanged
        ControlesGANANCIAS(RadioButtonList2.SelectedItem.Value)
    End Sub

    Protected Sub RadioButtonList3_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList3.SelectedIndexChanged
        ControlesIIBB(RadioButtonList3.SelectedItem.Value)
    End Sub

    Protected Sub RadioButtonList4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList4.SelectedIndexChanged
        ControlesSUSS(RadioButtonList4.SelectedItem.Value)
    End Sub

    Private Sub ControlesGANANCIAS(ByVal Codigo As Integer)
        If Codigo = 1 Then
            cmbCategoriaGanancias.Enabled = False
            txtFechaLimiteExentoGanancias.Enabled = True
        Else
            cmbCategoriaGanancias.Enabled = True
            txtFechaLimiteExentoGanancias.Enabled = False
        End If
    End Sub

    Private Sub ControlesIIBB(ByVal Codigo As Integer)
        If Codigo = 1 Or Codigo = 4 Then
            cmbCategoriaIIBB.Enabled = False
            txtFechaLimiteExentoIIBB.Enabled = False
            txtIBNumeroInscripcion.Enabled = False
            txtCoeficienteIIBBUnificado.Enabled = False
            CheckBox1.Enabled = False
            txtSaldoEmbargo.Enabled = False
            txtDetalleEmbargo.Enabled = False
            txtPorcentajeIBDirecto.Enabled = False
            txtGrupoIIBB.Enabled = False
            txtFechaInicioVigenciaIBDirecto.Enabled = False
            txtFechaFinVigenciaIBDirecto.Enabled = False
        Else
            cmbCategoriaIIBB.Enabled = True
            txtFechaLimiteExentoIIBB.Enabled = True
            txtIBNumeroInscripcion.Enabled = True
            txtCoeficienteIIBBUnificado.Enabled = True
            CheckBox1.Enabled = True
            txtSaldoEmbargo.Enabled = True
            txtDetalleEmbargo.Enabled = True
            txtPorcentajeIBDirecto.Enabled = True
            txtGrupoIIBB.Enabled = True
            txtFechaInicioVigenciaIBDirecto.Enabled = True
            txtFechaFinVigenciaIBDirecto.Enabled = True
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
        If Codigo = "EX" Then
            cmbCategoriaSUSS.Enabled = False
            txtSUSSFechaCaducidadExencion.Enabled = True
        ElseIf Codigo = "SI" Then
            cmbCategoriaSUSS.Enabled = True
            txtSUSSFechaCaducidadExencion.Enabled = False
        Else
            cmbCategoriaSUSS.Enabled = False
            txtSUSSFechaCaducidadExencion.Enabled = False
        End If
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myProveedor As Pronto.ERP.BO.Proveedor
        If e.CommandName.ToLower = "eliminar" Then
            If (Me.ViewState(mKey) IsNot Nothing) Then
                myProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.Proveedor)
                myProveedor.DetallesContactos(mIdItem).Eliminado = True
                Me.ViewState.Add(mKey, myProveedor)
                GridView1.DataSource = myProveedor.DetallesContactos
                GridView1.DataBind()
            End If

        ElseIf e.CommandName.ToLower = "editar" Then
            ViewState("IdDetalleProveedor") = mIdItem
            If (Me.ViewState(mKey) IsNot Nothing) Then
                MostrarElementos(True)
                myProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.Proveedor)
                myProveedor.DetallesContactos(mIdItem).Eliminado = False
                txtContacto.Text = myProveedor.DetallesContactos(mIdItem).Contacto
                txtContactoPuesto.Text = myProveedor.DetallesContactos(mIdItem).Puesto
                txtContactoTelefono.Text = myProveedor.DetallesContactos(mIdItem).Telefono
                txtContactoEmail.Text = myProveedor.DetallesContactos(mIdItem).Email
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
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleProveedor"), Integer)
            Dim myProveedor As Pronto.ERP.BO.Proveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.Proveedor)
            If mIdItem = -1 Then
                Dim mItem As ProveedorContacto = New Pronto.ERP.BO.ProveedorContacto
                mItem.Id = myProveedor.DetallesContactos.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myProveedor.DetallesContactos.Add(mItem)
            End If
            With myProveedor.DetallesContactos(mIdItem)
                .Contacto = txtContacto.Text
                .Puesto = txtContactoPuesto.Text
                .Telefono = txtContactoTelefono.Text
                .Email = txtContactoEmail.Text
            End With
            Me.ViewState.Add(mKey, myProveedor)
            GridView1.DataSource = myProveedor.DetallesContactos
            GridView1.DataBind()
        End If
        MostrarElementos(False)
        mAltaItem = True
    End Sub

    Protected Sub btnNuevoItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNuevoItem.Click
        ViewState("IdDetalleProveedor") = -1
        MostrarElementos(True)
    End Sub

End Class
