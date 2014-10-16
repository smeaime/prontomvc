Imports System.Data.SqlClient
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.IO
Imports System.Diagnostics 'para usar Debug.Print
Imports Microsoft.Reporting.WebForms
Imports System.Data

Imports OfficeOpenXml 'EPPLUS, no confundir con el OOXML
Imports Pronto.ERP.Bll.CartaDePorteManager

Imports System.Linq


Partial Class CartasDePortes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HFSC.Value = GetConnectionString(Server, Session)
        'HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////



            BindTypeDropDown() 'combos


            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("Id") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("Id") 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If

            bind(HFTipoFiltro.Value)


       
        End If

        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkExcelDescarga)
        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkZipDescarga)
        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkButton2)

        'AutoCompleteExtender3.ContextKey = HFSC.Value

        Permisos()
    End Sub

    Private Sub BindTypeDropDown()




    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

       
    End Sub





    Function generarWHERE() As String
        'Dim idVendedor = BuscaIdClientePreciso(txtBuscar.Text, HFSC.Value)
        'Dim idCorredor = BuscaIdVendedorPreciso(txtBuscar.Text, HFSC.Value)

        'Dim strWHERE As String = "1=1  "

        'If idVendedor <> -1 Or idCorredor <> -1 Then
        '    strWHERE += "  " & _
        '     "           AND (Vendedor = " & idVendedor & _
        '    "           OR CuentaOrden1 = " & idVendedor & _
        '    "           OR CuentaOrden2 = " & idVendedor & _
        '    "             OR Corredor=" & idCorredor & _
        '    "             OR Entregador=" & idVendedor & ")"
        'End If

        'If cmbPuntoVenta.SelectedValue > 0 Then
        '    strWHERE += "AND (PuntoVenta=" & cmbPuntoVenta.SelectedValue & ")"   ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
        'End If


        'Select Case DropDownList1.Text  '
        '    Case "Todas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas)
        '    Case "Incompletas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Incompletas)
        '    Case "Posición"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Posicion)
        '    Case "Descargas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)
        '    Case "Facturadas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Facturadas)
        '    Case "NoFacturadas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.NoFacturadas)
        '    Case "Rechazadas"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Rechazadas)
        '    Case "EnNotaCredito"
        '        strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito, , HFSC.Value)
        'End Select

        ''strWHERE += " ORDER BY " & facturarselaA & " ASC,NumeroCartaDePorte ASC "

        'Return strWHERE
    End Function


    Sub bind(ByVal ids As Long)


        Dim slinks As String


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))


        'metodo 1: me traigo lo de la tabla temporal generada
        Dim delaTablatemporal = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                    Where i.IdSesion = ids).ToList

        ''metodo 2: recalculo la facturacion automatica
        'Dim regenerandoElautomatico = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica(CInt(puntoVenta)) _
        '          Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
        '                Or (cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaOriginal, -1))) _
        '          ).ToList





        LogicaCopiada_MIGRAR.LinksDeCartasConflictivasDelAutomaticoSobreElTempDirecto(delaTablatemporal, slinks, HFSC.Value)
        'LogicaCopiada_MIGRAR.LinksDeCartasConflictivasDelAutomatico(regenerandoElautomatico, slinks, HFSC.Value)








        lblErrores.Text = slinks
    End Sub

End Class




Class LogicaCopiada_MIGRAR
    Public Const IDEMBARQUES = -2






    Shared Function MostrarConflictivasEnPaginaAparte(ByVal l As Generic.List(Of wCartasDePorte_TX_FacturacionAutomaticaResult), ByRef sLinks As String, ByVal sc As String) As String
        Dim cartasrepetidas = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) < 1 _
                         And Group.Count() > 1 _
                         And Id <> IDEMBARQUES _
                Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        Dim cartasconflic = From i In l _
                     Where cartasrepetidas.Contains(i.IdCartaDePorte)

        sErr = "TOTAL " & cartasconflic.Count & " <br/> "

        For Each dr In cartasconflic
            sErr &= "<br/> <a href=""CartaDePorte.aspx?Id=" & dr.IdCartaDePorte & """ target=""_blank"">" & dr.NumeroCartaDePorte & " " & dr.SubNumeroVagon & "</a>   "
            's &= "<a href=""Cliente.aspx?Id=" & dr.id & """ target=""_blank"">" & dr.Numero & " " & dr.SubnumeroVagon & "</a>; "



            sErr &= " ("
            sErr &= "<a href=""Cliente.aspx?Id=" & dr.IdFacturarselaA & """ target=""_blank"">" & dr.FacturarselaA & "   </a> "
            sErr &= " )"

        Next

        Return sErr
    End Function


    Shared Function LinksDeCartasConflictivasDelAutomaticoSobreElTempDirecto(ByVal l As Generic.List(Of wTempCartasPorteFacturacionAutomatica), ByRef sLinks As String, ByVal sc As String) As Generic.List(Of wTempCartasPorteFacturacionAutomatica)

        'Filtra las conflictivas, y tambien las muestra en un texto.



        Dim cartasrepetidas = (From i In l _
                Group By Id = i.IdCartaDePorte, _
                                 Numero = i.NumeroCartaDePorte, _
                         SubnumeroVagon = i.SubNumeroVagon, _
                         SubNumeroFacturacion = i.SubnumeroDeFacturacion _
                    Into Group _
                Where iisNull(SubNumeroFacturacion, 0) < 1 _
                         And Group.Count() > 1 _
                         And Id <> IDEMBARQUES _
                Select Id).ToList ' new with {.id = Id , .Numero = Numero, .SubnumeroVagon = SubnumeroVagon}).ToList

        Dim sErr As String

        ' Debug.Print(dt.Rows.Count)
        Debug.Print(cartasrepetidas.Count)



        sErr = "TOTAL " & cartasrepetidas.Count & " <br/> "



        Dim LasNoRepetidas = (From i In l Where Not cartasrepetidas.Contains(i.IdCartaDePorte) Order By i.NumeroCartaDePorte, i.FacturarselaA).ToList



        sLinks = "" ' sErr
        Return LasNoRepetidas
    End Function
End Class
