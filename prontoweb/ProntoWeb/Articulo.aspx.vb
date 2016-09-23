Imports System
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Imports System.Linq
Imports System.Diagnostics

Imports CartaDePorteManager

Partial Class ArticuloABM
    Inherits System.Web.UI.Page

    Private IdArticulo As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdArticulo"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdArticulo") = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdArticulo = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdArticulo
        Else
            Me.IdEntity = -1
        End If

        mKey = "Articulo_" & Me.IdEntity.ToString


        mAltaItem = False

        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)

        'que pasa si el usuario es Nothing? Qué se rompió?
        If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))

        SC = usuario.StringConnection

        If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(SC) = "Williams" Then TabPanel2.Visible = True

        Dim myArticulo As Pronto.ERP.BO.Articulo

        If Not Page.IsPostBack Then
            TextBox1.Text = IdArticulo
            BindTypeDropDown()


            If IdArticulo > 0 Then

                myArticulo = EditarSetup()

                If Not (myArticulo Is Nothing) Then
                    With myArticulo

                        Me.Title = "Edicion Articulo " + .Codigo.ToString
                    End With
                End If
            Else
                myArticulo = AltaSetup()

                myArticulo = New Pronto.ERP.BO.Articulo
                myArticulo.Id = -1
                Me.Title = "Nuevo Articulo"
                TabContainer1.ActiveTabIndex = 0

            End If

        
            CrearSiempreLosControlesDinamicos(cmbRubro.SelectedValue, cmbSubrubro.SelectedValue, IdArticulo)
            RebindMascaraDeArticulos(cmbRubro.SelectedValue, cmbSubrubro.SelectedValue, IdArticulo)

            Me.ViewState.Add(mKey, myArticulo)
            '  BloqueosDeEdicion(myArticulo)
        Else
            myArticulo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Articulo)
            CrearSiempreLosControlesDinamicos(cmbRubro.SelectedValue, cmbSubrubro.SelectedValue, IdArticulo)
        End If


        Permisos()


        '////////////////////////////////////////////


    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

        'If Not p("PuedeLeer") Then
        '    'esto tiene que anular el sitemapnode
        '    GridView1.Visible = False
        '    lnkNuevo.Visible = False
        'End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(0).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            'GridView1.Columns(7).Visible = False

            'muestro el borrar posiciones
            'lnkBorrarPosiciones.Visible = False
        Else
            'lnkBorrarPosiciones.Visible = True
        End If

    End Sub
    Function AltaSetup() As Pronto.ERP.BO.Articulo
        Dim myObra As Pronto.ERP.BO.Articulo = New Pronto.ERP.BO.Articulo

        myObra.Id = -1

        With myObra
            'txtFechaObra.Text = System.DateTime.Now.ToShortDateString()
            '  txtNumeroObra.Text = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroObra").ToString

            ' BuscaIDEnCombo(cmbEmpleado, Session(SESSIONPRONTO_glbIdUsuario)) 'confeccionó

            Try
                'BuscaIDEnCombo(cmbSectores, EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)).IdSector) 'sector del confeccionó
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            AgregarRenglonVacio(myObra)
            AgregarRenglonVacio(myObra)
            AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)


            RebindDetalle(myObra)

            '  GuardarProximoItem(myObra)

            ''/////////////////////////////////
            ''/////////////////////////////////
            '
            '  TraerFirmas(myObra)

        End With
        ViewState("PaginaTitulo") = "Nueva Obra"
        Return myObra

    End Function


    Sub GuardarProximoItem(ByRef myRM As Pronto.ERP.BO.Articulo)
        '  hfProxItem.Value = ObraManager.UltimoItemDetalle(myRM) + 1
        'txtItem.Text = hfProxItem.Value
    End Sub


    Sub AgregarRenglonVacio(ByRef myRM As Pronto.ERP.BO.Articulo)
        With myRM
            '/////////////////////////////////
            '/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As RequerimientoItem = New Pronto.ERP.BO.RequerimientoItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Cantidad = 0
            Dim mvarAux As String = EntidadManager.BuscarClaveINI("Dias default para fecha necesidad en RM", SC, Session(SESSIONPRONTO_glbIdUsuario))
            If Len(mvarAux) > 0 Then
                mItem.FechaEntrega = DateAdd("d", Val(mvarAux), Today)
            Else
                mItem.FechaEntrega = Today
            End If

            mItem.NumeroItem = Nothing 'ObraManager.UltimoItemDetalle(myRM) + 1
            'mItem.NumeroItem = ObraManager.UltimoItemDetalle(SC, myRM.Id) + 1
            mItem.Nuevo = True
            mItem.Eliminado = True


            .linqHelper.DetalleUnidades.Add(New DetalleArticulosUnidade)
            RebindDetalle(myRM)
            ''/////////////////////////////////
        End With
    End Sub



    Sub RebindDetalle(ByRef myRM As Pronto.ERP.BO.Articulo)

        If IsNothing(myRM) Then myRM = CType(Me.ViewState(mKey), Pronto.ERP.BO.Articulo)

        GridView1.DataSource = myRM.linqHelper.DetalleUnidades
        GridView1.DataBind()

        GridView2.DataSource = myRM.linqHelper.DetalleUnidades
        GridView2.DataBind()


        Dim TotalDebe, TotalHaber As Decimal

        'For Each det As ObraItem In myRM.Detalles
        '    With det

        '        If .Eliminado Then Continue For

        '        'TotalDebe += .Debe

        '        'TotalHaber += .Haber

        '    End With
        'Next

        'GridView1.FooterRow.Cells(getGridIDcolbyHeader("Debe", GridView1)).Text = FF2(TotalDebe)
        'GridView1.FooterRow.Cells(getGridIDcolbyHeader("Haber", GridView1)).Text = FF2(TotalHaber)



        UpdatePanelGrilla.Update()
    End Sub


    Function EditarSetup() As Pronto.ERP.BO.Articulo
        Dim myArticulo As Pronto.ERP.BO.Articulo
        myArticulo = ArticuloManager.GetItem(SC, IdArticulo)
        If Not (myArticulo Is Nothing) Then
            With myArticulo

                txtCodigo.Text = .Codigo
                txtNumeroInventario.Text = .NumeroInventario
                txtDescripcion.Text = .Descripcion
                txtObservaciones.Text = .Observaciones
                txtAlicuotaIVA.Text = .AlicuotaIVA
                txtCostoPPP.Text = .CostoPPP
                txtCostoPPPDolar.Text = .CostoPPPDolar
                txtCostoReposicion.Text = .CostoReposicion
                txtCostoReposicionDolar.Text = .CostoReposicionDolar
                txtEspecieONCAA.Text = .AuxiliarString5
                txtCodigoSagypa.Text = .AuxiliarString6
                txtCodigoZeni.Text = .AuxiliarString7


                If Not (cmbRubro.Items.FindByValue(.IdRubro.ToString) Is Nothing) Then
                    cmbRubro.Items.FindByValue(.IdRubro.ToString).Selected = True
                End If
                If Not (cmbSubrubro.Items.FindByValue(.IdSubrubro.ToString) Is Nothing) Then
                    cmbSubrubro.Items.FindByValue(.IdSubrubro.ToString).Selected = True
                End If
                If Not (cmbUnidad.Items.FindByValue(.IdUnidad.ToString) Is Nothing) Then
                    cmbUnidad.Items.FindByValue(.IdUnidad.ToString).Selected = True
                End If



                'txtNumeroObra.Text = .Numero
                'txtFechaObra.Text = .Fecha.ToString("dd/MM/yyyy")
                ''calFecha.SelectedDate = myObra.Fecha

                'BuscaIDEnCombo(cmbObra, .IdObra)
                'BuscaIDEnCombo(cmbEmpleado, .IdSolicito)
                'BuscaIDEnCombo(cmbSectores, .IdSector)
                'If Not (cmbLibero.Items.FindByValue(.IdAprobo.ToString) Is Nothing) Then
                '    cmbLibero.Items.FindByValue(.IdAprobo.ToString).Selected = True
                '    cmbLibero.Enabled = False
                '    btnLiberar.Visible = False
                'End If
                'txtLugarEntrega.Text = .LugarEntrega
                'txtDetalle.Text = .Detalle
                'txtObservaciones.Text = .Observaciones
                'txtLibero.Text = myObra.Aprobo
                'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

                'lnkAdjunto1.Text = .Detalles(0).ArchivoAdjunto1 'ATENTI!: lo grabo en el adjunto de TODOS los items, porque la RM no tiene adjuntos en el encabezado
                'If lnkAdjunto1.Text <> "" Then
                '    MostrarBotonesParaAdjuntar(False)
                'Else
                '    MostrarBotonesParaAdjuntar(True)
                'End If

                'GuardarProximoItem(myObra)


                'TraerFirmas(myObra)


                'GridView1.DataSource = .Detalles
                'GridView1.DataBind()
                'ViewState("PaginaTitulo") = "Edicion RM " + .Numero.ToString
            End With
        End If
        Return myArticulo

    End Function

    Private Sub BindTypeDropDown()
        cmbRubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Rubros")
        cmbRubro.DataTextField = "Titulo"
        cmbRubro.DataValueField = "IdRubro"
        cmbRubro.DataBind()

        cmbSubrubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Subrubros")
        cmbSubrubro.DataTextField = "Titulo"
        cmbSubrubro.DataValueField = "IdSubrubro"
        cmbSubrubro.DataBind()

        cmbUnidad.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
        cmbUnidad.DataTextField = "Titulo"
        cmbUnidad.DataValueField = "IdUnidad"
        cmbUnidad.DataBind()

    End Sub

    Sub CrearSiempreLosControlesDinamicos(ByVal idRubro As Long, ByVal idSubrubro As Long, ByVal idarticulo As Long)
        'se llaman en todo page_load (sea o no un postback), y el viewstate hará la magia correspondiente
        '-pero hay que hacer el bind del datasource??? -no hombre, acá sí usas el viewstate, porque no son muchos datos

        'http://stackoverflow.com/questions/6489395/to-generate-textboxes-dynamically-in-asp-net
        'http://support.microsoft.com/kb/317794/es

        Dim db = New DataClassesRequerimientoDataContext(Encriptar(SC))
        Dim mascara = From i In db.DefinicionArticulos Where i.IdRubro = idRubro And i.IdSubrubro = idSubrubro
        Dim articulo = (From i In db.linqArtis Where i.IdArticulo = idarticulo).SingleOrDefault

        For Each mascItem In mascara
            With mascItem
                Dim trow = New HtmlTableRow()

                Dim tcell0 = New HtmlTableCell()
                Dim label1 As New Label
                label1.Text = .Etiqueta
                label1.CssClass = "EncabezadoCell"
                tcell0.Controls.Add(label1)



                Dim tcell2 = New HtmlTableCell()

                If .TablaCombo Is Nothing And .CampoSiNo <> "SI" Then
                    'texto
                    'tcell1.InnerText = o.Etiqueta
                    Dim t = New TextBox()
                    tcell2.Controls.Add(t)

                    t.ID = .Campo
                Else
                    'tabla y combo

                    Dim comboDinamico = New DropDownList()
                    tcell2.Controls.Add(comboDinamico)

                    comboDinamico.ID = .Campo
                End If



                trow.Cells.Add(tcell0)
                trow.Cells.Add(tcell2)

                TablaDinamica.Rows.Add(trow)
            End With
        Next

    End Sub



    Sub RebindMascaraDeArticulos(ByVal idRubro As Long, ByVal idSubrubro As Long, ByVal idarticulo As Long)
        'http://stackoverflow.com/questions/6489395/to-generate-textboxes-dynamically-in-asp-net
        'http://support.microsoft.com/kb/317794/es

        Dim db = New DataClassesRequerimientoDataContext(Encriptar(SC))
        Dim mascara = From i In db.DefinicionArticulos Where i.IdRubro = idRubro And i.IdSubrubro = idSubrubro
        Dim articulo = (From i In db.linqArtis Where i.IdArticulo = idarticulo).SingleOrDefault

        For Each mascItem In mascara
            With mascItem



                If .TablaCombo Is Nothing And .CampoSiNo <> "SI" Then
                    'textbox
                    Dim tboxDinamico As TextBox = TablaDinamica.FindControl(.Campo)


                    If articulo IsNot Nothing Then
                        Dim t As Type = articulo.GetType
                        Dim pi As PropertyInfo = t.GetProperty(.Campo)  'uso Reflection para traer la property por nombre, que guarda el valor en la tabla artículos de la relacion indicada en la tabla DefinicionArticulos
                        Dim valor As String = pi.GetValue(articulo, Nothing)

                        tboxDinamico.Text = valor
                    End If
                Else
                    'combo

                    Dim comboDinamico As DropDownList = TablaDinamica.FindControl(.Campo)
                    Dim dt
                    If .CampoSiNo = "SI" Then
                        'cmbSubrubro.DataSource = EntidadManager.ExecDinamico(SC,"SELECT " & .campocombo "," & Titul  & "  FROM " &  .TablaCombo & "")
                        dt = EntidadManager.GetStoreProcedure(SC, "SiNo_TL")
                    Else
                        dt = EntidadManager.GetStoreProcedure(SC, .TablaCombo & "_TL")
                    End If
                    comboDinamico.DataSource = dt
                    'cmbSubrubro.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, .TablaCombo)
                    comboDinamico.DataTextField = "Titulo"
                    If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
                        comboDinamico.DataValueField = "IdSiNo"
                    Else
                        comboDinamico.DataValueField = .CampoCombo
                    End If
                    comboDinamico.DataBind()

                    If articulo IsNot Nothing Then
                        Dim t As Type = articulo.GetType
                        Dim pi As PropertyInfo = t.GetProperty(.Campo)  'uso Reflection para traer la property por nombre, que guarda el valor en la tabla artículos de la relacion indicada en la tabla DefinicionArticulos
                        Dim valor As String = pi.GetValue(articulo, Nothing)
                        comboDinamico.ID = .Campo
                        If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
                            BuscaTextoEnCombo(comboDinamico, valor)
                        Else
                            BuscaIDEnCombo(comboDinamico, valor)
                        End If
                    End If
                End If

            End With
        Next
    End Sub



    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        EndEditing()
    End Sub

    Private Sub EndEditing()
        Response.Redirect(String.Format("Articulos.aspx"))
    End Sub



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim mOk As Boolean
        Page.Validate()
        mOk = Page.IsValid
        If mOk Then

            If Not mAltaItem Then
                Dim myArticulo As Pronto.ERP.BO.Articulo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Articulo)
                With myArticulo
                    .Codigo = txtCodigo.Text.ToString
                    .NumeroInventario = txtNumeroInventario.Text.ToString
                    .Descripcion = txtDescripcion.Text.ToString
                    .Observaciones = txtObservaciones.Text.ToString
                    .AlicuotaIVA = Convert.ToDecimal(Val(txtAlicuotaIVA.Text))
                    .CostoPPP = Convert.ToDouble(Val(txtCostoPPP.Text))
                    .CostoPPPDolar = Convert.ToDecimal(Val(txtCostoPPPDolar.Text))
                    .CostoReposicion = Convert.ToDecimal(Val(txtCostoReposicion.Text))
                    .CostoReposicionDolar = Convert.ToDecimal(Val(txtCostoReposicionDolar.Text))
                    .IdRubro = Convert.ToInt32(cmbRubro.SelectedValue)
                    .IdSubrubro = Convert.ToInt32(cmbSubrubro.SelectedValue)
                    .IdUnidad = Convert.ToInt32(cmbUnidad.SelectedValue)
                    .AuxiliarString5 = txtEspecieONCAA.Text
                    .AuxiliarString6 = txtCodigoSagypa.Text
                    .AuxiliarString7 = txtCodigoZeni.Text




                    Dim idCreado = ArticuloManager.Save(SC, myArticulo)



                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    'controles dinamicos. 
                    '/////////////////////////////////////////////////////////////////////////

                    'TODO: arreglar esto, que lo haga el manager
                    Dim db = New DataClassesRequerimientoDataContext(Encriptar(SC))
                    Dim linqart = (From i In db.linqArtis Where i.IdArticulo = idCreado).SingleOrDefault
                    IterateThroughChildren(Me) 'solo para debuggear que estuviesen creados los controles


                    Dim mascara = From i In db.DefinicionArticulos Where i.IdRubro = .IdRubro And i.IdSubrubro = .IdSubrubro

                    For Each mascItem In mascara 'en lugar de iterar los controles, itero la máscara esperada y voy a buscar de prepo los ids de los controles (iterar en la tablecell es mas molesto, especialmente por sus controles anidados)
                        With mascItem
                            Dim valor As Object
                            If .TablaCombo Is Nothing And .CampoSiNo <> "SI" Then
                                'textbox
                                Dim txtbox As TextBox = TablaDinamica.FindControl(.Campo)
                                valor = txtbox.Text
                            Else
                                'combo
                                Dim combo As DropDownList = TablaDinamica.FindControl(.Campo) 'si usaba el Me en lugar de la tabla, no se metia en el arbol

                                If .TablaCombo = "SiNo" Or .CampoSiNo = "SI" Then
                                    valor = combo.SelectedItem.Text
                                Else
                                    valor = combo.SelectedValue
                                End If
                            End If



                            Dim t As Type = linqart.GetType
                            Dim pi As PropertyInfo = t.GetProperty(.Campo)  'uso Reflection para traer la property por nombre, que guarda el valor en la tabla artículos de la relacion indicada en la tabla DefinicionArticulos
                            Dim tipo = If(Nullable.GetUnderlyingType(pi.PropertyType), pi.PropertyType)
                            Dim valor2 As Object
                            Try
                                'http://stackoverflow.com/questions/1089123/setting-a-property-by-reflection-with-a-string-value
                                'http://stackoverflow.com/questions/3531318/convert-changetype-fails-on-nullable-types
                                valor2 = IIf(valor Is Nothing, Nothing, Convert.ChangeType(valor, tipo))
                            Catch ex As Exception
                                valor2 = IIf(valor Is Nothing, Nothing, Convert.ChangeType(StringToDecimal(valor), tipo))
                            End Try
                            pi.SetValue(linqart, valor2, Nothing)





                            'comboDinamico.ID = .Campo
                            'If .TablaCombo = "SiNo" Then
                            '    BuscaTextoEnCombo(comboDinamico, valor)
                            'Else
                            '    BuscaIDEnCombo(comboDinamico, valor)
                            'End If
                        End With

                    Next


                    db.SubmitChanges()
                    '/////////////////////////////////////////////////////////////////////////
                    'fin controles dinamicos
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////////////////////



                    EndEditing()
                End With
            End If
        End If
    End Sub


    Sub IterateThroughChildren(ByVal parent As Control)
        'http://www.4guysfromrolla.com/articles/082102-1.aspx

        For Each c As Control In parent.Controls

            If c.GetType().ToString().Equals("System.Web.UI.WebControls.DropDownList") Then
                Debug.Print(c.ID)
            ElseIf c.GetType().ToString().Equals("System.Web.UI.WebControls.TextBox") Then
                'Debug.Print(c.ID)
            End If

            If (c.Controls.Count > 0) Then IterateThroughChildren(c)

        Next
    End Sub

    Protected Sub cmbRubro_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbRubro.SelectedIndexChanged
        RebindMascaraDeArticulos(cmbRubro.SelectedValue, cmbSubrubro.SelectedValue, IdArticulo)
    End Sub



    Protected Sub cmbSubrubro_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbSubrubro.SelectedIndexChanged
        RebindMascaraDeArticulos(cmbRubro.SelectedValue, cmbSubrubro.SelectedValue, IdArticulo)
    End Sub
End Class

Class MigrarCodigoVB6

    'Sub ProntoVB6_BotonCargarArticulos()
    '    Dim i As Long, dcR As Long, dcS As Long, dcF As Long, ind_art As Long
    '    Dim PosIni As Long, iTop As Long, iLeft As Long, CtrlCount As Long
    '    Dim mColumna As Integer, mFicha As Integer, mPos As Integer, X As Integer
    '    Dim mvarErr As String, TipIni As String
    '    Dim mEsta As Boolean
    '    Dim oAp 'As ComPronto.Aplicacion
    '    Dim oRs As ADOR.Recordset
    '    Dim oRs1 As ADOR.Recordset

    '    ind_art = 0
    '    PosIni = 0
    '    mFicha = 0
    '    mColumna = 1
    '    mvarErr = ""
    '    TipIni = " "
    '    Dim HayAgregados = False

    '    Dim datacombo1()
    '    Dim aplicacion
    '    Dim campos_sino
    '    Dim check1
    '    Dim label1
    '    Dim check2
    '    Dim origen




    '    If Len(Trim(DataCombo1(0).BoundText)) = 0 Then
    '        mvarErr = mvarErr + "No ha definido el rubro." + vbCrLf
    '    End If

    '    If Len(Trim(DataCombo1(1).BoundText)) = 0 Then
    '        mvarErr = mvarErr + "No ha definido el subrubro." + vbCrLf
    '    End If

    '    If Len(Trim(mvarErr)) <> 0 Then
    '        MsgBox(mvarErr, vbCritical)
    '        Exit Sub
    '    End If

    '    dcR = DataCombo1(0).BoundText
    '    dcS = DataCombo1(1).BoundText

    '    iTop = Label1(0).Top - 100
    '    iLeft = SSTab1.Left + 50

    '    oAp = Aplicacion
    '    oRs = oAp.Rubros.Item(dcR).Registro
    '    mRubro = IIf(IsNull(oRs.Fields("Descripcion").Value), oRs.Fields("Abreviatura").Value, oRs.Fields("Descripcion").Value)
    '    mRubro1 = IIf(IsNull(oRs.Fields("Abreviatura").Value), "", oRs.Fields("Abreviatura").Value)
    '    oRs.Close()
    '    oRs = oAp.Subrubros.Item(dcS).Registro
    '    mSubrubro = IIf(IsNull(oRs.Fields("Descripcion").Value), oRs.Fields("Abreviatura").Value, oRs.Fields("Descripcion").Value)
    '    mSubrubro1 = IIf(IsNull(oRs.Fields("Abreviatura").Value), oRs.Fields("Descripcion").Value, oRs.Fields("Abreviatura").Value)
    '    oRs.Close()

    '    oRs = oAp.DefinicionesArt.TraerFiltrado("_Art", Array(dcR, dcS))

    '    Do Until oRs.EOF
    '        If oRs.Fields("AddNombre").Value = "SI" Then
    '            HayAgregados = True
    '            If Len(Trim(oRs.Fields("Antes").Value)) <> 0 Then
    '                ind_art = ind_art + 1
    '                ReDim Preserve def_art(ind_art)
    '                def_art(ind_art) = "*|" & oRs.Fields("Antes").Value
    '            End If
    '            ind_art = ind_art + 1
    '            If oRs.Fields("AgregaUnidadADescripcion").Value = "SI" Then
    '                ind_art = ind_art + 1
    '                ReDim Preserve def_art(ind_art)
    '                If oRs.Fields("UsaAbreviatura").Value = "SI" Then
    '                    def_art(ind_art - 1) = "-CA|" & oRs.Fields("Campo").Value
    '                Else
    '                    def_art(ind_art - 1) = " |" & oRs.Fields("Campo").Value
    '                End If
    '                If oRs.Fields("UsaAbreviaturaUnidad").Value = "SI" Then
    '                    def_art(ind_art) = "-UA|" & oRs.Fields("CampoUnidad").Value
    '                Else
    '                    def_art(ind_art) = "-Un|" & oRs.Fields("CampoUnidad").Value
    '                End If
    '            Else
    '                ReDim Preserve def_art(ind_art)
    '                If oRs.Fields("UsaAbreviatura").Value = "SI" Then
    '                    def_art(ind_art) = "-CA|" & oRs.Fields("Campo").Value
    '                Else
    '                    def_art(ind_art) = " |" & oRs.Fields("Campo").Value
    '                End If
    '            End If
    '            If Len(Trim(oRs.Fields("Despues").Value)) <> 0 Then
    '                ind_art = ind_art + 1
    '                ReDim Preserve def_art(ind_art)
    '                def_art(ind_art) = "*|" & oRs.Fields("Despues").Value
    '            End If
    '        End If

    '        i = Label1.Count
    '        If CtrlCount = mItemsPorColumna Then
    '            If mColumna = mColumnasPorSeccion Then
    '                mFicha = mFicha + 1
    '                SSTab1.TabVisible(mFicha) = True
    '                SSTab1.Tab = mFicha
    '                mColumna = 1
    '                iLeft = SSTab1.Left + 10
    '            Else
    '                mColumna = mColumna + 1
    '                iLeft = iLeft + (Label1(0).Width + Text1(0).Width + 600)
    '            End If
    '            iTop = Label1(0).Top - 100
    '            CtrlCount = 0
    '        End If

    '        Load(Label1(i))
    '        With Label1(i)
    '            .Top = iTop + Text1(0).Height + 45
    '            .Left = iLeft
    '            .Caption = IIf(IsNull(oRs.Fields("Etiqueta").Value), "????", oRs.Fields("Etiqueta").Value)
    '            .Visible = True
    '        End With

    '        If oRs.Fields("CampoSiNo").Value = "SI" Then
    '            i = Check1.Count
    '            If PosIni = 0 Then PosIni = i : TipIni = "C"
    '            Load(Check1(i))
    '            With Check1(i)
    '                .Top = Label1(Label1.Count - 1).Top
    '                .Left = iLeft + Label1(0).Width + 80
    '                .Visible = True
    '            End With
    '            i = Check2.Count
    '            Load(Check2(i))
    '            With Check2(i)
    '                .Top = Label1(Label1.Count - 1).Top
    '                .Left = iLeft + Label1(0).Width + 700
    '                .Visible = True
    '            End With

    '            ReDim Preserve Campos_SiNo(i)
    '            mEsta = False
    '            For X = 0 To UBound(Campos_SiNo)
    '                If Campos_SiNo(X) = oRs.Fields("Campo").Value Then
    '                    mEsta = True
    '                    Exit For
    '                End If
    '            Next
    '            If Not mEsta Then
    '                Campos_SiNo(i) = oRs.Fields("Campo").Value
    '                If origen.Registro.Fields(oRs.Fields("Campo").Value).Value = "SI" Then
    '                    Check2(i).Value = 1
    '                Else
    '                    Check1(i).Value = 1
    '                End If
    '            End If

    '        ElseIf origen.Registro.Fields(oRs.Fields("Campo").Value).Type = adDBTimeStamp Or _
    '              origen.Registro.Fields(oRs.Fields("Campo").Value).Type = adDBTime Or _
    '              origen.Registro.Fields(oRs.Fields("Campo").Value).Type = adDBDate Then
    '            i = DTFields.Count
    '            If PosIni = 0 Then PosIni = i : TipIni = "D"
    '            Load(DTFields(i))
    '            With DTFields(i)
    '                .Top = Label1(Label1.Count - 1).Top
    '                .Left = iLeft + Label1(0).Width + 80
    '                '                  Set .DataSource = origen
    '                .DataField = oRs.Fields("Campo").Value
    '                .Value = origen.Registro.Fields(oRs.Fields("Campo").Value).Value
    '                .Visible = True
    '                .Enabled = True
    '            End With

    '        ElseIf origen.Registro.Fields(oRs.Fields("Campo").Value).Type = adLongVarWChar Then
    '            i = RichTextBox1.Count
    '            If PosIni = 0 Then PosIni = i : TipIni = "R"
    '            Load(RichTextBox1(i))
    '            With RichTextBox1(i)
    '                .Top = Label1(Label1.Count - 1).Top
    '                .Left = iLeft + Label1(0).Width + 80
    '                .DataField = oRs.Fields("Campo").Value
    '                .TextRTF = IIf(IsNull(origen.Registro.Fields(oRs.Fields("Campo").Value).Value), "", origen.Registro.Fields(oRs.Fields("Campo").Value).Value)
    '                .Visible = True
    '                .Enabled = True
    '            End With

    '        ElseIf Len(Trim(oRs.Fields("TablaCombo").Value)) = 0 Or IsNull(oRs.Fields("TablaCombo").Value) Then
    '            'i = Text1.Count
    '            'If PosIni = 0 Then PosIni = i : TipIni = "T"
    '            'Load(Text1(i))
    '            'With Text1(i)
    '            '    .Top = Label1(Label1.Count - 1).Top
    '            '    .Left = iLeft + Label1(0).Width + 80
    '            '    .DataSource = origen
    '            '    .DataField = oRs.Fields("Campo").Value
    '            '    .Visible = True
    '            '    .Enabled = True
    '            'End With
    '            If oRs.Fields("Campo").Value = "Caracteristicas" Then mCaracteristicas = True
    '            If CtrlCount = 0 And mColumna = 1 Then
    '                mPrimerControl(mFicha) = "T"
    '                mPrimerControlIndex(mFicha) = i
    '            End If
    '            If CtrlCount + 1 = mItemsPorColumna And mColumna = mColumnasPorSeccion Then
    '                mUltimoControl(mFicha) = "T"
    '                mUltimoControlIndex(mFicha) = i
    '            End If
    '            If Len(Trim(oRs.Fields("CampoUnidad").Value)) <> 0 Then
    '                mPos = i
    '                With Text1(i)
    '                    .Width = Text1(i).Width * 0.4
    '                    .Alignment = 1
    '                End With
    '                i = DataCombo2.Count
    '                Load(DataCombo2(i))
    '                With DataCombo2(i)
    '                    .Top = Label1(Label1.Count - 1).Top
    '                    .Left = Text1(mPos).Left + Text1(mPos).Width + 50
    '                    .Width = .Width * 0.8
    '                    .BoundColumn = "IdUnidad"
    '                    .DataField = oRs.Fields("CampoUnidad").Value
    '                    .Tag = "Unidades"
    '                    .DataSource = origen
    '                    .RowSource = oAp.CargarLista("Unidades")
    '                    .Visible = True
    '                    If Not IsNull(oRs.Fields("UnidadDefault").Value) And _
    '                          (mvarId < 0 Or IsNull(origen.Registro.Fields(oRs.Fields("CampoUnidad").Value).Value)) Then
    '                        .BoundText = oRs.Fields("UnidadDefault").Value
    '                    End If
    '                    .Enabled = True
    '                End With
    '            End If

    '        Else
    '            i = DataCombo2.Count
    '            If PosIni = 0 Then PosIni = i : TipIni = "D"
    '            Load(DataCombo2(i))
    '            With DataCombo2(i)
    '                .Top = Label1(Label1.Count - 1).Top
    '                .Left = iLeft + Label1(0).Width + 80
    '                .BoundColumn = oRs.Fields("CampoCombo").Value
    '                .DataField = oRs.Fields("Campo").Value
    '                .Tag = oRs.Fields("TablaCombo").Value
    '                .DataSource = origen
    '                If Mid(oRs.Fields("TablaCombo").Value, 1, 3) = "Aco" Then
    '                    oRs1 = oAp.CargarListaConParametros(oRs.Fields("TablaCombo").Value, Array(dcR, dcS))
    '                ElseIf oRs.Fields("TablaCombo").Value = "Ubicaciones" Then
    '                    oRs1 = oAp.Ubicaciones.TraerFiltrado("_AbreviadoParaCombo")
    '                ElseIf oRs.Fields("TablaCombo").Value = "Scheduler" Then
    '                    oRs1 = oAp.Schedulers.TraerLista
    '                ElseIf oRs.Fields("Campo").Value = "IdTipoArticulo" Then
    '                    oRs1 = oAp.Tipos.TraerFiltrado("_PorGrupoParaCombo", 1)
    '                ElseIf oRs.Fields("Campo").Value = "IdTratamiento" Then
    '                    oRs1 = oAp.TTermicos.TraerLista
    '                ElseIf oRs.Fields("TablaCombo").Value = "Cuentas" Then
    '                    oRs1 = oAp.Cuentas.TraerFiltrado("_SinCuentasGastosObras")
    '                Else
    '                    oRs1 = oAp.CargarLista(oRs.Fields("TablaCombo").Value)
    '                End If
    '                .RowSource = oRs1
    '                oRs1 = Nothing
    '                .Visible = True
    '                .Enabled = True
    '            End With
    '            If oRs.Fields("Campo").Value = "IdCalidadClad" Then mClasificacion = True

    '        End If

    '        iTop = iTop + Text1(0).Height + 50
    '        CtrlCount = CtrlCount + 1

    '        oRs.MoveNext()
    '    Loop
    '    oRs.Close()

    '    oAp = Nothing
    '    oRs = Nothing

    '    SSTab1.Tab = 0

    '    For i = 0 To 5
    '        cmd(i).TabIndex = 1000 + i
    '    Next
    '    txtDescripcion.TabIndex = 1000 + i
    '    SSTab1.TabIndex = 1000 + i + 1

    '    If Me.Visible Then
    '        If TipIni = "D" Then DataCombo2(PosIni).SetFocus()
    '        If TipIni = "T" Then Text1(PosIni).SetFocus()
    '        If TipIni = "C" Then Check1(PosIni).SetFocus()
    '    End If

    '    cmd(3).Enabled = False
    '    cmd(4).Enabled = True
    '    DataCombo1(3).Enabled = False

    '    Me.Refresh()

    'End Sub


    'Public Sub ProntoVB6_RecargarCombos()

    '    Dim oAp As ComPronto.Aplicacion
    '    Dim oControl As Control
    '    Dim mVector

    '    On Error Resume Next

    '    Me.MousePointer = vbHourglass
    '    DoEvents()

    '    oAp = Aplicacion
    '    oBind = Nothing
    '    oBind = New BindingCollection

    '    With oBind
    '        .DataSource = origen
    '        For Each oControl In Me.Controls
    '            If TypeOf oControl Is DataCombo Then
    '                If Len(oControl.DataField) Then oControl.DataSource = origen
    '                If Len(oControl.Tag) Then
    '                    mVector = VBA.Split(oControl.Tag, "|")
    '                    If UBound(mVector) > 0 Then
    '                        oControl.RowSource = oAp.TablasGenerales.TraerFiltrado(mVector(0), "_PorGrupoParaCombo", mVector(1))
    '                    Else
    '                        If Mid(mVector(0), 1, 3) = "Aco" Then
    '                            oControl.RowSource = oAp.CargarListaConParametros(mVector(0), Array(DataCombo1(0).BoundText, DataCombo1(1).BoundText))
    '                        Else
    '                            oControl.RowSource = oAp.CargarLista(mVector(0))
    '                        End If
    '                    End If
    '                End If
    '            End If
    '        Next
    '    End With

    '    oAp = Nothing

    '    Me.MousePointer = vbDefault

    'End Sub
End Class