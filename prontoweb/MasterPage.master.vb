Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Drawing
Imports System.Diagnostics
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Linq

Imports EmpresaFunciones

Imports Pronto.ERP.Bll.BDLmasterPermisosManager.EntidadesPermisos



Imports CartaDePorteManager



Partial Class MasterPage
    Inherits System.Web.UI.MasterPage
    Private SC As String

    Private sConexionBaseEmpresa As String

    Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_header.jpg") 'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios
    Public imgMenuBackgrund As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_headerMenu.jpg") 'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios
    Public imgSegundoSectorBackgrund As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_headerSegundoSector.jpg") 'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios



    Public imgLupita As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/lupita.jpg")










    'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios

    'Qué asunto.... y si uso la combinacion CELESTE+GRIS del "Gmail sin conexión"
    'Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_headerliv2.jpg") 'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios



    'TODO: otra vez está refrescando el fondo de pantalla, y es irritante





    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim asdasd = GetConnectionString(Server, Session)  'para que lo redirija al login si hay algo raro

        SC = ConexBDLmaster()
        HFSC.Value = SC  'por qué uso aca la conexion de la bdlmaster? despues me confundo con el autocomplete


        ConfiguracionDeLaEmpresa()


        Dim Usuario = New Usuario

        'por qué el User.Identity.Name (el que usa el LoginView) puede ser distinto del que tengo guardado en la Session(SESSIONPRONTO_USUARIO)????
        'será porque está usando mi login de Windows??? (windows authentication)
        '-puede ser.....

        'Bind Accordion to SiteMapDataSource
        'http://forums.asp.net/t/1375571.aspx
        If True Then 'If Not IsPostBack Then



            If Usuario Is Nothing Or Session(SESSIONPRONTO_UserId) Is Nothing Then
                If Not Request.IsAuthenticated Then
                    FormsAuthentication.SignOut()
                End If

                Response.Redirect(FormsAuthentication.LoginUrl)
                Return
            End If


            Usuario = Session(SESSIONPRONTO_USUARIO) 'acá puede quedar con nothing. por qué lo dejé?
            'lblInfo.Text = Usuario.Empresa

            If Usuario IsNot Nothing Then
                sConexionBaseEmpresa = Usuario.StringConnection
            End If


            cmbFiltroSuperbuscador.Visible = True
            cmbFiltroSuperbuscador.Enabled = True





            lblInfo.Text = Session(SESSIONPRONTO_NombreEmpresa)

            lnkEmpresa.Text = Session(SESSIONPRONTO_NombreEmpresa)



            If BDLMasterEmpresasManagerMigrar.ElUsuarioTieneUnaSolaEmpresa(SC, Session(SESSIONPRONTO_UserId)) Then
                lnkEmpresa.Enabled = False
                lnkEmpresa.ToolTip = "Sólo tenés una base asignada"
            Else
                lnkEmpresa.Enabled = True
            End If


            'Panel1.Visible = False
            'Accordion1.Visible = False



            RebindAcordion(sender, e)
        End If


        'ArbolSiteMap.DataSource = SiteMapDataSource
        'ArbolSiteMap.DataBind()



        If Not IsPostBack Then
            RefrescarFiltro()
            'Dim tb As TextBox = Me.Master.FindControl("TextBox3")
            txtSuperbuscador.Focus()
            txtSuperbuscador.Text = Session(SESSIONPRONTO_Busqueda)
            LlenarComboMes()
            'ScriptManager.GetCurrent(Me).SetFocus(tb)

            cmbFiltroSuperbuscador.Items.Add("en Todo")
            cmbFiltroSuperbuscador.Items.Add("Cartas Porte")
            cmbFiltroSuperbuscador.Items.Add("Clientes")


            If Not Debugger.IsAttached Then
                cmbFiltroSuperbuscador.Visible = False
            Else
                cmbFiltroSuperbuscador.Visible = False
            End If


            Dim nodo As String = Session("NodoArbol")
            If nodo IsNot Nothing Then rmArbol.FindNode(nodo).Select()




        End If

        If InStr(Request.Url.ToString, "?año=") = 0 Then
            ArbolSiteMap.DataBind()
            arbolCopia.Nodes.Clear()
            ImpresoraMatrizDePuntosEPSONTexto.CopyTreeview(ArbolSiteMap, arbolCopia)
        End If

        arbolCopia.CollapseAll()
        Dim nodo2 As String = Session("NodoArbol")
        If nodo2 IsNot Nothing Then rmArbol.FindNode(nodo2).Select()
        Try
            If arbolCopia.SelectedNode Is Nothing Then Exit Try
            arbolCopia.SelectedNode.Expand()

            If arbolCopia.SelectedNode.Parent Is Nothing Then Exit Try
            arbolCopia.SelectedNode.Parent.Expand()

            If arbolCopia.SelectedNode.Parent.Parent Is Nothing Then Exit Try
            arbolCopia.SelectedNode.Parent.Parent.Expand()

            If arbolCopia.SelectedNode.Parent.Parent.Parent Is Nothing Then Exit Try
            arbolCopia.SelectedNode.Parent.Parent.Parent.Expand()
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        ArbolSiteMap.Visible = False

        ValidarEspacioLibre()

        If Usuario IsNot Nothing Then 'pero en qué casos resulta que sí es nothing?

            AutoCompleteExtender1.ContextKey = Usuario.StringConnection 'para que el autocomplete sepa la cadena de conexion



            lblNotificaciones.Text &= ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb) &
                                     ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb2) &
                                      ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb3) &
                                       ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb4) &
                                        ParametroManager.TraerValorParametro2(Usuario.StringConnection, ParametroManager.eParam2.NotificacionesWeb5)


            If lblNotificaciones.Text = "" Then
                lblNotificaciones.Visible = False
            Else
                lblNotificaciones.Visible = True
            End If





            Dim mensaje As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")
            lblTipoBase.Text = mensaje
            lblInfoBajoElLogo.Text = mensaje

            If lblTipoBase.Text = "" Then
                lblTipoBase.Visible = False
                lblInfoBajoElLogo.Visible = False
            Else
                lblTipoBase.Visible = True
                lblInfoBajoElLogo.Visible = True
            End If



        End If

        Try
            If True Or InStr(Session(SESSIONPRONTO_NombreEmpresa).ToLower, "williams") Or InStr(Session(SESSIONPRONTO_NombreEmpresa).ToLower, "capen") Then
                Accordion1.Visible = True
                arbolCopia.Visible = False
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        'smdsHarriyott.SiteMapProvider =
        'smdsHarriyott.SiteMapProvider = "main"

        Try

            'Numero de version
            'me está devolviendo 0.0.0.0
            'http://stackoverflow.com/questions/2815324/cannot-get-assembly-version-for-footer
            'http://odetocode.com/blogs/scott/archive/2006/01/24/assemblyversion-and-web-projects.aspx
            'Dim web As System.Reflection.Assembly = System.Reflection.Assembly.GetExecutingAssembly()
            'Dim web As System.Reflection.Assembly = System.Reflection.Assembly.GetAssembly(GetType(Pronto.ERP.Bll.EntidadManager))
            Dim web As System.Reflection.Assembly = System.Reflection.Assembly.GetAssembly(GetType(ProntoFuncionesUIWeb))
            'Dim web As System.Reflection.Assembly = System.Reflection.Assembly.Load("App_Code")


            Dim webName As System.Reflection.AssemblyName = web.GetName()
            Dim myVersion As String = webName.Version.ToString()
            'myVersion = "1.11.4"

            If Usuario IsNot Nothing Then 'pero en qué casos resulta que sí es nothing?
                lnkBDL.ToolTip = "Version " & myVersion & " " & " SPs " & ParametroManager.TraerValorParametro2(ProntoFuncionesUIWeb.GetConnectionString(Server, Session), "ProntoWebVersionSQL")
                'lblVersion.Text = myVersion & " " & "SPs " & ParametroManager.TraerValorParametro2(ProntoFuncionesUIWeb.GetConnectionString(Server, Session), "ProntoWebVersionSQL")
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        'If Not IsPostBack Then ArbolSiteMap.CollapseAll()


    End Sub


    Function ValidarEspacioLibre()
        Dim MINIMO_MEGAS = 200


        Dim di As System.IO.DriveInfo = New System.IO.DriveInfo("C")
        Dim espacio As Long = di.TotalFreeSpace / 1000000

        'Try
        '{
        '    DriveInfo driveInfo = new DriveInfo(@"C:");
        '    long FreeSpace = driveInfo.AvailableFreeSpace;
        '}
        'catch (System.IO.IOException errorMesage)
        '{
        '    Console.WriteLine(errorMesage);
        '}


        If espacio < MINIMO_MEGAS Then
            lblNotificaciones.Text = "ALERTA: el espacio en el servidor debe ser mayor que " & MINIMO_MEGAS & "Megas  ( solo quedan " & espacio & "!)"
            lblNotificaciones.Visible = True
        Else
            lblNotificaciones.Text = ""
        End If
    End Function


    Sub RebindAcordion(ByVal sender As Object, ByVal e As System.EventArgs)


        Dim siteMapView As SiteMapDataSourceView = CType(SiteMapDataSource.GetView(String.Empty), SiteMapDataSourceView)
        Dim nodes As SiteMapNodeCollection = CType(siteMapView.Select(DataSourceSelectArguments.Empty), SiteMapNodeCollection)


        'NodosRequerimientos(nodes)


        '///////////////////////////////////////////////////////


        'Dim Children As SiteMapNodeCollection
        'Dim n As SiteMapNode
        'Children = From n In SiteMap.CurrentNode.ChildNodes.Cast(Of SiteMapNode)() _
        '                    Where n.Url <> "/Registration.aspx" _
        '                    Select n


        '///////////////////////////////////////////////////////


        Accordion1.DataSource = nodes
        Accordion1.DataBind()

        'con SelectedIndex=-1 el acordion cierra solito los panes
        'SelectedIndex=0 es el panel de arriba de todo
        If Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) Is Nothing Then
            Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = -1
        End If

        If session("SelectedPane") Is Nothing Then
            'panel abierto por default del acordion 

            If True Then
                session("SelectedPane") = 5
            ElseIf BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(ConexBDLmaster) = "Williams" Then
                Session("SelectedPane") = 5
            Else
                session("SelectedPane") = 5 '-1
            End If

        End If

        Accordion1.SelectedIndex = session("SelectedPane")
        If False Then
            If Accordion1.SelectedIndex > -1 And SiteMap.CurrentNode IsNot Nothing Then
                AccordionSiteMap_OpenCurrentPane(sender, e)         'http://forums.asp.net/p/1092148/1921906.aspx
                Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = Accordion1.SelectedIndex
            ElseIf SiteMap.CurrentNode IsNot Nothing Then
                AccordionSiteMap_OpenCurrentPane(sender, e)
                'Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = Accordion1.SelectedIndex
            Else
                If Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) > -1 Then
                    'AccordionSiteMap_OpenCurrentPane(sender, e)
                    Accordion1.SelectedIndex = Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion)
                    Accordion1.SelectedIndex = session("SelectedPane")
                    'Los problemas son por acá

                Else
                    'cierro los panelcitos
                    Accordion1.SelectedIndex = -1
                End If
                Accordion1.SelectedIndex = session("SelectedPane")
            End If
        End If

        'ResaltarNodoElegido()


    End Sub

    Protected Sub arbolCopia_PreRender(sender As Object, e As System.EventArgs) Handles arbolCopia.PreRender

        'arbolCopia es un treeview; no es el accordion que estoy usando en Williams

        CallRecursive(arbolCopia)

    End Sub


    Private Sub PrintRecursive(ByVal n As TreeNode)
        If HayQueOcultarEsteNodo(n.NavigateUrl) Then


            n.Text = ""

            'Dim parentNode = n.Parent
            'parentNode.ChildNodes.Remove(n)

        End If

        Dim aNode As TreeNode
        For Each aNode In n.ChildNodes
            PrintRecursive(aNode)
        Next
    End Sub

    ' Call the procedure using the top nodes of the treeview.
    Private Sub CallRecursive(ByVal aTreeView As TreeView)
        Dim n As TreeNode
        For Each n In aTreeView.Nodes
            PrintRecursive(n)
        Next
    End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'Acordion
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////




    '///////////////////////////////////
    'Cómo resaltar el link elegido?
    '///////////////////////////////////

    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////
    Sub RepeaterItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        'http://forums.asp.net/t/1695206.aspx/1

        Dim item As RepeaterItem = e.Item

        Dim node As SiteMapNode = item.DataItem

        Dim hl As HyperLink = e.Item.FindControl("HyperLink2")

        Dim td = e.Item.FindControl("AccordionSideBarItem")
        Dim a = e.Item.FindControl("aLink1")


        'If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
        'DirectCast(e.Item.FindControl("HyperLink1"), HyperLink).ForeColor = System.Drawing.Color.Red
        'End If

        'si una rama se queda sin nodos, tambien hay que volarla


        If HayQueOcultarEsteNodo(hl.NavigateUrl) Then
            e.Item.Visible = False
            Return
        End If






        Dim bEncontro = False
        If Not IsNothing(hl) Then
            If hl.NavigateUrl = Request.Url.PathAndQuery.ToString() Then
                'If InStr(Request.Url.PathAndQuery.ToString(), hl.NavigateUrl) > 0 Then
                'hl.ForeColor = System.Drawing.Color.Red
                'hl.Font.Bold = True

                'hl.BorderStyle = BorderStyle.Solid
                hl.CssClass = "AccordionItemSeleccionado"
                'hl.Style.Add("border", "solid 1px 0px 0px 0px")
                '                text-decoration: none;
                'border-width: 2px;
                'margin: 2px;
                'border-style: solid;
                '}

                Try
                    Debug.Print(item.ItemIndex)
                    Debug.Print(item.Parent.ClientID)
                    Session("SelectedPane") = CInt(TextoEntre(item.Parent.ClientID, "Pane_", "_content"))
                Catch ex As Exception

                End Try

                bEncontro = True
            End If
        End If

        If Not bEncontro Then Accordion1.SelectedIndex = Session("SelectedPane")

        If Not IsNothing(td) Or Not IsNothing(a) Or Not IsNothing(hl) Then
            'Stop
        End If

    End Sub


    Sub RepeaterPreRender(sender As Object, e As System.EventArgs)
        'Repeater()

        'Repeater1.

        ''http://stackoverflow.com/questions/6281559/asp-net-repeater-loop-through-items-in-the-item-template
        ''You would want to do that in the Page PreRender, after the Repeater has been bound.



        'For Each sss


        'Next

        'Dim item As RepeaterItem = e.Item

    End Sub

    Sub AccordionPreRender(sender As Object, e As System.EventArgs)

        'oculto el panel si no tiene nodos

        For Each p In Accordion1.Panes
            Debug.Print(p.Visible)
            'Debug.Print(p.ContentContainer.Controls.Count)
            Dim n As SiteMapNode = p.ContentContainer.DataItem
            Debug.Print(n.Title)
            Debug.Print(n.ChildNodes.Count)
            If n.ChildNodes.Count <= 0 Then p.Visible = False
        Next



    End Sub




    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////




    Sub ConfiguracionDeLaEmpresa()
        Try

            Dim Usuario = New Usuario
        Usuario = Session(SESSIONPRONTO_USUARIO)


        LogoImage.ImageUrl = BDLMasterEmpresasManagerMigrar.SetLogoImage_MasterPage(Usuario)
        SiteMapDataSource.SiteMapProvider = BDLMasterEmpresasManagerMigrar.SetSiteMap(Usuario)


        Catch ex As Exception

            ErrHandler.WriteError(ex)
        End Try

    End Sub


    Sub ResaltarNodoElegido()
        'http://forums.asp.net/t/1695206.aspx/1
        'Re: Highlight the current hyperlink menu item in a repeater control
        'Jun 30, 2011 01:50 PM | LINK
        'The basic idea of doing this in ItemDataBound is good.
        'To determine if a Node is the one to change, you could compare the URL on it to that of the current page. After all, 
        'the click of that node is what lead to this page.
        'You may have to debug to see what to do to make the match. The browser may have sent a URL in 
        'a slightly different format. For instance, your URL can be "MyPage.aspx" and the browser may have 
        'requested "MyServer/MyPage.aspx".


        'Accordion1.


    End Sub

    Function HayQueOcultarEsteNodo(ByVal url As String) As Boolean

        Try
            If Session(SESSIONPRONTO_UserId) Is Nothing Then Return True


            If InStr(url, "CartaDePorteAnalisisTarifa.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_InfAnalisisTarifa)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "CartaDePorteInformesGerenciales.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_InfGerenciales)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If



            If InStr(url, "CDPFacturacion.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_Facturacion)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "Facturas.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Facturas)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "ListasPrecios.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Listas_de_Precios)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "Vendedores.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Vendedores)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Clientes.aspx") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Clientes)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "/Obra") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Obras)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Requerimiento") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Requerimientos)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Articulo") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Artículos)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "/Unidad") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Unidades)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Sector") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Sectores)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

        Catch ex As Exception

        End Try

        Return False
    End Function

    '///////////////////////////////////
    '///////////////////////////////////
    '///////////////////////////////////



    Protected Sub AccordionSiteMap_OpenCurrentPane(ByVal sender As Object, ByVal e As EventArgs)


        'Debug.Print(SiteMap.RootNode.ChildNodes(0).Title) 'si imprime "FAVORITOS", es que está usando el otro sitemap....

        Dim siteMapView As SiteMapDataSourceView = CType(SiteMapDataSource.GetView(String.Empty), SiteMapDataSourceView)
        Dim nodes As SiteMapNodeCollection = CType(siteMapView.Select(DataSourceSelectArguments.Empty), SiteMapNodeCollection)


        If SiteMap.CurrentNode Is Nothing Then
            Accordion1.SelectedIndex = -1
        Else
            Accordion1.SelectedIndex = RootIndexofCurrentNode(SiteMap.RootNode.ChildNodes)
            'Accordion1.SelectedIndex = RootIndexofCurrentNode(nodes)
        End If
    End Sub

    Private Function RootIndexofCurrentNode(ByVal Nodes As SiteMapNodeCollection) As Short
        'busca el indice del padre del nodo elegido, para poder elegir el panelcito del acordion correspondiente

        Dim index As Short = -2
        If Nodes Is Nothing Then
            RootIndexofCurrentNode = -1
        ElseIf Nodes.Contains(SiteMap.CurrentNode) Then
            RootIndexofCurrentNode = Nodes.IndexOf(SiteMap.CurrentNode)
        Else
            For Each n As SiteMapNode In Nodes
                index = RootIndexofCurrentNode(n.ChildNodes)
                If index <> -1 Then
                    If n.ParentNode.ToString = SiteMap.RootNode.ToString Then
                        Return SiteMap.RootNode.ChildNodes.IndexOf(n)
                    Else
                        Return index
                    End If
                End If
            Next
            Return -1
        End If
    End Function



    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    'Bind Accordion to SiteMapDataSource    'http://forums.asp.net/t/1375571.aspx
    '////////////////////////////////////////////////////////////////////

    Protected Sub Accordion1_DataBound(ByVal sender As Object, ByVal e As AjaxControlToolkit.AccordionItemEventArgs) Handles Accordion1.ItemDataBound
        If CType(e, AjaxControlToolkit.AccordionItemEventArgs).ItemType = AjaxControlToolkit.AccordionItemType.Content Then
            Dim cPanel As AjaxControlToolkit.AccordionContentPanel = e.AccordionItem
            Dim rptr As System.Web.UI.WebControls.Repeater = CType(cPanel.Controls(1), System.Web.UI.WebControls.Repeater)
            Dim sNode As System.Web.SiteMapNode = CType(CType(e, AjaxControlToolkit.AccordionItemEventArgs).AccordionItem.DataItem, System.Web.SiteMapNode)
            Dim childNodes As System.Web.SiteMapNodeCollection = sNode.ChildNodes
            If Not childNodes Is Nothing AndAlso childNodes.Count > 0 Then
                rptr.DataSourceID = Nothing
                rptr.DataSource = childNodes
                rptr.DataBind()
            End If
        End If
    End Sub


    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////


    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////



    Protected Sub LoginStatus1_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        'FormsAuthentication.RedirectToLoginPage()

        '      Me esta redirigiendo a "account\login"
        ' Poniendo LogoutAction="Redirect" y la url del login, funca


    End Sub




    Private Sub ListadoEmpresasPorUsuarioMenu()
        'Dim nodoRequerimineto As TreeNode = Me.TreeView.Nodes(0).ChildNodes(0)
        Dim lista() As Integer = DirectCast(Session("Empresas"), Integer())
        Dim newNode As TreeNode

        'Cómo funciona esto? -fijate que nodoRequerimiento ya tiene el nodo de donde se engancha -ah!

        For i As Integer = 0 To lista.Length - 1
            Dim empresa As Pronto.ERP.BO.Empresa = BDLMasterEmpresasManagerMigrar.GetEmpresa(lista(i), Application.Item("empresaList"))
            If Session(SESSIONPRONTO_UserName) Is Nothing Then
                Response.Redirect("login.aspx") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
            Else
                If (EmpleadoManager.HaveAccess(empresa.ConnectionString, Session(SESSIONPRONTO_UserName).ToString, "Requerimientos")) Then
                    Dim countRequerimiento As Integer
                    Session(SESSIONPRONTO_IdEmpleado) = DirectCast(EmpleadoManager.GetEmployeeByName(empresa.ConnectionString, Session(SESSIONPRONTO_UserName).ToString), Empleado).Id.ToString
                    countRequerimiento = RequerimientoManager.GetCountRequemientoForEmployee(empresa.ConnectionString, Convert.ToInt32(Session("IdEmpleado")))
                    newNode = New TreeNode()
                    newNode.Text = String.Format("{0} ({1})", empresa.Descripcion, countRequerimiento)
                    newNode.Value = empresa.Id.ToString
                    'nodoRequerimineto.ChildNodes.Add(newNode)
                End If
            End If
        Next
    End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub LinkButton100_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton100.Click
        PanelMenu.Style.Add("visibility", "hidden")
    End Sub

    Protected Sub txtSuperbuscador_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSuperbuscador.TextChanged
        Buscar("")

    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBuscar.Click
        Buscar("")
    End Sub


    <System.Web.Services.WebMethod()> _
    Sub Buscar(key As String)

        Exit Sub

        If txtSuperbuscador.Text = ">UnitTest1" Then

            Dim u As Usuario = Session(SESSIONPRONTO_USUARIO) 'acá puede quedar con nothing. por qué lo dejé?
            Dim sConexionBaseEmpresa = u.StringConnection
            Dim output As String = Tests.test1_ReclamoN9066(sConexionBaseEmpresa)

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
                    MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
                End If
            Catch ex As Exception
                'ErrHandler2.WriteAndRaiseError(ex.ToString)
                ErrHandler2.WriteError(ex.ToString)
                'MsgBoxAjax(Me, ex.ToString)
                Return
            End Try


            Return
        End If

        If txtSuperbuscador.Text = ">DarPermisosDeSuperAdministrador" Then
            Try
                Session("SuperAdmin") = "Habilitado"
                MsgBoxAlert("Permisos de admin otorgados")
                Page.Response.Redirect(Page.Request.Url.ToString(), True)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                MsgBoxAlert("Probablemente ya tenía los permisos")
            End Try
            Return
        End If


        If txtSuperbuscador.Text = ">DarPermisosDeAdministrador" Then
            Try
                Roles.AddUserToRole(Session(SESSIONPRONTO_UserName), "AdminSolo")
                MsgBoxAlert("Permisos de admin otorgados")
                Page.Response.Redirect(Page.Request.Url.ToString(), True)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Roles.RemoveUserFromRoles(Session(SESSIONPRONTO_UserName), Roles.GetRolesForUser(Session(SESSIONPRONTO_UserName)))
                Roles.AddUserToRole(Session(SESSIONPRONTO_UserName), "Administrador")
                MsgBoxAlert("Probablemente ya tenía los permisos")
            End Try
            Return
        End If





        Dim Ret(9) As String
        Ret(0) = key

        If False Then
            Dim temp As New WebServiceSuperbuscador
            'Dim Ret As String() = temp.GetCompletionList(txtSuperbuscador.Text, 0, sConexionBaseEmpresa)
        End If





        'http://stackoverflow.com/questions/96029/get-url-of-asp-net-page-in-code-behind
        'This(doesn) 't work if the application is not hosted on the server root but in a directory. If the application is hosted on www.contoso.com/app/ this will return just www.contoso.com
        Dim ss = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath
        'ss = "~"




        Dim i = InStr(txtSuperbuscador.Text, "Ver más resultados para")
        If i > 0 Then
            Session("Busqueda") = Mid(txtSuperbuscador.Text, Len("Ver más resultados para") + 2)
            txtSuperbuscador.Text = Session("Busqueda")


            'http://stackoverflow.com/questions/96029/get-url-of-asp-net-page-in-code-behind
            'This(doesn) 't work if the application is not hosted on the server root but in a directory. If the application is hosted on www.contoso.com/app/ this will return just www.contoso.com


            Response.Redirect(ss + "/ProntoWeb/Busqueda.aspx?q=" & Session("Busqueda"))
            Return
        End If

        'If Session("Busqueda") <> txtSuperbuscador.Text Then
        Session("Busqueda") = txtSuperbuscador.Text

        If Session("Busqueda") = "No se encontraron resultados" Then
            txtSuperbuscador.Text = ""
            Session("Busqueda") = ""
            Return
        End If

        If Session("Busqueda") = "" Or Session("Busqueda") = "Buscar" Then Return




        If Ret.Length > 0 Then


            If InStr(Ret(0), "No se encontraron resultados") > 0 Then
                Return
            End If




            If InStr(Ret(0), "Carta.de.porte") > 0 Then
                '            AbrirSegunTipoComprobante(
                'Return String.Format("Factura.aspx?Id={0}", IdComprobante)
                Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")

                Response.Redirect("~/ProntoWeb/CartaDePorte.aspx?Id=" & t(0))
                'AbrirSegunTipoEntidad("CartaPorte", 20)
            ElseIf InStr(Ret(0), "Cliente...") > 0 Then
                Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Cliente.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Articulo...") > 0 Then
                Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Articulo.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Factura...") > 0 Then
                Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Factura.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Requerimiento...") > 0 Then
                Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/RequerimientoB.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            End If
        End If

        For Each s As String In Ret
            Dim dest = TextoEntre(s, "Second"":""", """}")
            If InStr(Request.Url.AbsolutePath, Mid(dest, 2)) > 0 Then Exit Sub 'ya estoy adonde quiero ir
            If InStr(dest, "\u0") > 0 Or InStr(dest, "^") > 0 Then Continue For 'no es un link directo, quizas es un comprobante
            Response.Redirect(dest)
        Next

        'If Ret.Length = 1 Then
        '    Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
        '    If InStr(Request.Url.AbsolutePath, Mid(dest, 2)) > 0 Then Exit Sub 'ya estoy adonde quiero ir
        '    Response.Redirect(dest)
        'Else

        Response.Redirect(ss + "/ProntoWeb/Busqueda.aspx?q=" & Session("Busqueda"))
        'End If
        'End If
    End Sub

    Protected Sub lnkFiltroUltimaSemana_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFiltroUltimaSemana.Click
        Session("Filtro") = "Ultimo semana"
        RefrescarFiltro()
    End Sub

    Protected Sub lnkFiltroUltimaMes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFiltroUltimaMes.Click
        Session(SESSIONPRONTO_Filtro) = "Ultimo mes"
        RefrescarFiltro()
    End Sub

    Protected Sub lnkFiltroPeriodoPersonalizado_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkFiltroPeriodoPersonalizado.Click
        Session("Filtro") = "Periodo personalizado"
        RefrescarFiltro()
    End Sub

    Sub RefrescarFiltro()
        lnkFiltroUltimaMes.Font.Bold = False
        lnkFiltroUltimaMes.Font.Size = 10
        lnkFiltroUltimaMes.ForeColor = Color.White
        lnkFiltroUltimaSemana.Font.Bold = False
        lnkFiltroUltimaSemana.Font.Size = 10
        lnkFiltroUltimaSemana.ForeColor = Color.White
        lnkFiltroPeriodoPersonalizado.Font.Bold = False
        lnkFiltroPeriodoPersonalizado.Font.Size = 10
        lnkFiltroPeriodoPersonalizado.ForeColor = Color.White


        Select Case Session("Filtro")
            Case "Ultimo semana"
                lnkFiltroUltimaSemana.Font.Bold = True
                lnkFiltroUltimaSemana.Font.Size = 10
                lnkFiltroUltimaSemana.ForeColor = ColorTranslator.FromHtml("#2200C1")
            Case "Ultimo mes"
                lnkFiltroUltimaMes.Font.Bold = True
                lnkFiltroUltimaMes.Font.Size = 10
                lnkFiltroUltimaMes.ForeColor = ColorTranslator.FromHtml("#2200C1")
            Case "Periodo personalizado"
                lnkFiltroPeriodoPersonalizado.Font.Bold = True
                lnkFiltroPeriodoPersonalizado.Font.Size = 10
                lnkFiltroPeriodoPersonalizado.ForeColor = ColorTranslator.FromHtml("#2200C1")
            Case Else
                Session("Filtro") = "Ultimo semana"
                lnkFiltroUltimaSemana.Font.Bold = True
                lnkFiltroUltimaSemana.Font.Size = 10
                lnkFiltroUltimaSemana.ForeColor = ColorTranslator.FromHtml("#2200C1")
        End Select
    End Sub


    Public Function FiltroFechaDesde() As Date
        Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
        txtFechaDesde.Text = GetFirstDayInMonth(Today)
        txtFechahasta.Text = GetLastDayInMonth(Today)
        Return GetFirstDayInMonth(Today)
    End Function


    Sub LlenarComboMes()
        Dim desde As Date = #1/1/2001#
        Dim hasta As Date = GetFirstDayInMonth(Now) ' #1/1/2001#
        Dim MAXITEMS = 100
        Dim s(MAXITEMS - 1) As String

        For mes = 1 To MAXITEMS
            Dim mesresta As Date = DateAdd(DateInterval.Month, 1 - mes, hasta)
            If mesresta < desde Then Exit For
            s(mes - 1) = mesresta.ToString("MMMM yy")
        Next


        cmbMesFiltro.DataSource = s
        cmbMesFiltro.DataBind()
    End Sub


    Protected Sub cmbMesFiltro_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbMesFiltro.SelectedIndexChanged
        If Not IsNothing(Master) Then
            Try
                Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
                Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
                txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
                txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
            Catch ex As Exception

            End Try
        End If
    End Sub



    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    'Passing Information Between Content and Master Pages
    'http://www.4guysfromrolla.com/articles/013107-1.aspx
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////


    'Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
    '    Me.ContentPlaceHolder1.rebind()
    'End Sub

    'Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
    '    Me.ContentPlaceHolder1.rebind()
    'End Sub


    Protected Sub lnkEmpresa_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEmpresa.Click
        Session(SESSIONPRONTO_NombreEmpresa) = ""
        Session("SaltarSeleccionarEmpresa") = "NO"
        Response.Redirect("~/SeleccionarEmpresa.aspx" + Request.Url.Query)
        'ssss()
        'jjjjj()
    End Sub

    Protected Sub rmArbol_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rmArbol.SelectedNodeChanged
        Session("NodoArbol") = rmArbol.SelectedNode
    End Sub

    Protected Sub arbolCopia_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles arbolCopia.SelectedNodeChanged
        Session("NodoArbol") = rmArbol.SelectedNode
    End Sub


    Sub NodosRequerimientos(ByVal nodos As SiteMapNodeCollection)

        Return


        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////

        Dim nodoporperiodos ' = New SiteMapNode(Me.currentprovider, "por Períodos")
        nodoporperiodos.SelectAction = TreeNodeSelectAction.None

        Using db As New DataClassesRequerimientoDataContext(Encriptar(HFSC.Value))
            Dim q = (From rm In db.linqRequerimientos Select rm.FechaRequerimiento.Value.Year, rm.FechaRequerimiento.Value.Month).Distinct.OrderBy(Function(i) i.Year)
            Dim anios = q.Select(Function(i) i.Year).Distinct.OrderByDescending(Function(i) i)
            For Each anio In anios


                Dim anionodo = New TreeNode(anio, anio & " ", "", "ProntoWeb/RequerimientosB.aspx?año=" & anio, "")

                Dim aniotemp = anio
                Dim meses = From rm In q Where rm.Year = aniotemp Order By rm.Month Descending Select rm.Month

                For Each Mes In meses
                    anionodo.ChildNodes.Add(New TreeNode(MonthName(Mes), anio & " " & Mes, "", "ProntoWeb/RequerimientosB.aspx?año=" & anio & "&mes=" & Mes, ""))
                Next

                nodoporperiodos.ChildNodes.Add(anionodo)
            Next
        End Using



        'Dim rmArbol As TreeView = CType(Master.FindControl("rmArbol"), TreeView)
        'rmArbol.Visible = True
        'rmArbol.Nodes.Add(nodoporperiodos)
        nodos.Add(nodoporperiodos)
        'nodosArbolPrincipal.Add(nodoporperiodos)

        If False Then
            Dim temp = New TreeNode("por Obras")
            temp.SelectAction = TreeNodeSelectAction.None
            rmArbol.Nodes.Add(temp)
            'rmArbol.Nodes.Add(New TreeNode("a Liberar"))
            'rmArbol.Nodes.Add(New TreeNode("a Confirmar"))
            'rmArbol.Nodes.Add(New TreeNode("Todas"))
        End If

        rmArbol.CollapseAll()

        Dim filtroano = Request.QueryString.Get("año")
        Dim filtromes = Request.QueryString.Get("mes")
        If filtromes Is Nothing Then filtromes = ""

        If If(filtroano, "") = "" Then filtroano = Now.Year

        Dim nodoelegido As TreeNode
        If filtromes = "" Then
            nodoelegido = rmArbol.FindNode("por Períodos/" & filtroano & " ")
            nodoelegido.Select()
            nodoelegido.Expand()
            nodoelegido.Parent.Expand()
        Else
            nodoelegido = rmArbol.FindNode("por Períodos/" & filtroano & " /" & filtroano & " " & filtromes)
            nodoelegido.Select()
            nodoelegido.Expand()
            nodoelegido.Parent.Expand()
            nodoelegido.Parent.Parent.Expand()
        End If









    End Sub

    Protected Sub ArbolSiteMap_DataBinding(sender As Object, e As System.EventArgs) Handles ArbolSiteMap.DataBinding

    End Sub

    Protected Sub ArbolSiteMap_DataBound(sender As Object, e As System.EventArgs) Handles ArbolSiteMap.DataBound

    End Sub



End Class




