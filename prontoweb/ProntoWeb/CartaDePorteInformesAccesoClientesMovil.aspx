<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false"
    CodeFile="CartaDePorteInformesAccesoClientesMovil.aspx.vb" Inherits="CartaDePorteInformesAccesoClientes"
    Title="Informes" %>




<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BDL Consultores</title>
    <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />
    <%--    <link rel="shortcut icon" type="image/ico" href="Imagenes/favicon.ico" />
 <link rel="shortcut icon" type="image/ico" href="favicon4.png" />--%>
    <link rel="shortcut icon" type="image/ico" href="favicon.png" />
    <%--google analytics--%>
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        //ga('create', 'UA-31129433-2', 'auto');
        ga('create', 'UA-31129433-2', { 'siteSpeedSampleRate': 100 });
        ga('send', 'pageview');

    </script>
</head>
<body class="bodyMasterPage">


    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <%-- El asuntito de la imagen del background http://www.daniweb.com/forums/thread57245.html# --%>
    <form id="form1" runat="server" defaultfocus="txtSuperbuscador" autocomplete="off"
        class="bodyMasterPage">
        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
            EnablePageMethods="true" AsyncPostBackTimeout="360000" ScriptMode="Release">
            <CompositeScript>
                <Scripts>
                    <%--<asp:ScriptReference Path="~/JavaScript/jquery-1.4.2.min.js" />--%>
                    <asp:ScriptReference Path="~/JavaScript/bdl.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamDragAndDrop.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamCore.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamSearchComboBox.js" />
                    <asp:ScriptReference Path="~/JavaScript/firmas.js" />
                    <asp:ScriptReference Path="~/JavaScript/dragAndDrop.js" />
                </Scripts>
            </CompositeScript>
            <Services></Services>
        </ajaxToolkit:ToolkitScriptManager>






        <br />
        <asp:UpdatePanel ID="UpdatePanelResumen" runat="server">
            <ContentTemplate>

                <asp:Button ID="btnRefrescar" Text="VER INFORME" runat="server" Visible="True" CssClass="but"
                    Width="150" Height="40" />
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" style="height: 30px" />
                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White" Font-Size="Medium"
                            Visible="true"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Button ID="btnImagenes" Text="Imágenes en JPG" runat="server" Visible="True" CssClass="but"
                    Width="" Height="40" />
                <asp:Button ID="btnImagenesPDF" Text="Imágenes en PDF reducido" runat="server" Visible="True" CssClass="but"
                    Width="" Height="40" />
                <asp:Button ID="btnImagenesTiffReducido" Text="Imágenes en TIFF reducido" runat="server" Visible="True" CssClass="but"
                    Width="" Height="40" />

                <table width="400px">
                    <tr>
                        <td style="width: 101px; height: 40px;" class="EncabezadoCell" colspan="2">
                            <asp:Label ID="lblRazonSocial" runat="server" Font-Size="Large" Font-Bold="true" />
                            <asp:Button ID="Button1" Text="importar" runat="server" Visible="false" Height="27" />
                        </td>
                    </tr>


                    <tr>
                        <td class="EncabezadoCell" style="width: 15%; height: 18px;">N° Carta porte
                        </td>
                        <td colspan="2" style="width: 50%; height: 18px;">
                            <asp:TextBox ID="txtQueContenga" runat="server" AutoPostBack="True" CssClass="CssTextBox"
                                Width="110px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Estado
                        </td>
                        <td>
                            <asp:DropDownList ID="cmbEstado" runat="server" Style="text-align: right; margin-left: 0px;"
                                Enabled="true" CssClass="CssCombo" ToolTip="Estado de la carta de porte" Font-Size="Small"
                                Height="22px">
                                <asp:ListItem Text="Todas (menos las rechazadas)" Value="TodasMenosLasRechazadas"
                                    Enabled="false" />
                                <asp:ListItem Text="Incompletas" Value="Incompletas" Enabled="false" />
                                <asp:ListItem Text="Posición" Value="Posición" />
                                <asp:ListItem Text="Descargas" Value="Descargas" Selected="true" />
                                <asp:ListItem Text="Facturadas" Value="Facturadas" Enabled="false" />
                                <asp:ListItem Text="No facturadas" Value="NoFacturadas" Enabled="false" />
                                <asp:ListItem Text="Rechazadas" Value="Rechazadas" Enabled="false" />
                                <asp:ListItem Text="sin liberar en Nota de crédito" Value="EnNotaCredito" Enabled="false" />
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 15%; height: 18px;">Descarga
                        </td>
                        <td class="EncabezadoCell">
                            <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                                Visible="true">
                                <asp:ListItem Text="Hoy" />
                                <asp:ListItem Text="Ayer" />
                                <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                                <asp:ListItem Text="Este mes" Selected="True" />
                                <asp:ListItem Text="Mes anterior" />
                                <asp:ListItem Text="Cualquier fecha" />
                                <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                                <asp:ListItem Text="Personalizar" />
                            </asp:DropDownList><br />
                            <asp:TextBox ID="txtFechaDesde" runat="server" Width="80px" MaxLength="1" autocomplete="off"
                                TabIndex="2" AutoPostBack="false"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                                Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                            <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                                WatermarkText="desde" WatermarkCssClass="watermarked" />
                            <asp:TextBox ID="txtFechaHasta" runat="server" Width="80px" MaxLength="1" TabIndex="2"
                                AutoPostBack="false"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta"
                                Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                            <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                                WatermarkText="hasta" WatermarkCssClass="watermarked" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                            ForeColor="" CausesValidation="False" Font-Size="X-Small" Height="20px" BorderStyle="None"
                            Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                            BorderWidth="5px" Width="127px"></asp:LinkButton>
                        <asp:Panel ID="Panel4" runat="server">
                            <table width="100%">
                                <tr>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Origen
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:TextBox ID="txtProcedencia" runat="server" CssClass="CssTextBox" Text='<%# Bind("ProcedenciaDesc") %>'
                                            AutoPostBack="false"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                            CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtProcedencia" UseContextKey="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Destino
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>' AutoPostBack="false"
                                            autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                            CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                            UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Producto
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:TextBox ID="txt_AC_Articulo" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                            autocomplete="off" CssClass="CssTextBox" AutoPostBack="false"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                            CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 90px; height: 18px;">Corredor (excluyente)
                                    </td>
                                    <td class="EncabezadoCell" style="height: 18px">
                                        <asp:CheckBox ID="chkCorredor" runat="server" Checked="false" />
                                        <asp:TextBox ID="txtCorredor" runat="server" CssClass="CssTextBox" autocomplete="off"
                                            Visible="false" Text='<%# Bind("CorredorDesc") %>' AutoPostBack="false"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                            CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                            Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceVendedores.asmx" TargetControlID="txtCorredor" UseContextKey="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <%--                    <td class="EncabezadoCell" style="width: 90px; height: 18px;" visible="false">
                        Filtros
                    </td>
                    <td class="EncabezadoCell" style="height: 18px" visible="false">
                        <asp:RadioButtonList ID="CriterioWHERE" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">todos</asp:ListItem>
                            <asp:ListItem>alguno</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>--%>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell">Modo
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="false" CssClass="CssTextBox"
                                            Width="110px">
                                            <asp:ListItem Selected="True">Entregas</asp:ListItem>
                                            <asp:ListItem>Export</asp:ListItem>
                                            <asp:ListItem>Ambos</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Destinatario (excluyente)
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:CheckBox ID="chkDestinatario" runat="server" Checked="false" />
                                        <asp:TextBox ID="txtEntregador" runat="server" Text='<%# Bind("EntregadorDesc") %>'
                                            Visible="false" AutoPostBack="false" autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender25" runat="server"
                                            CompletionSetCount="12" TargetControlID="txtEntregador" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                            FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                            Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <%--<td class="EncabezadoCell" style="visibility: hidden; overflow: auto;">
                                    Excepción Syngenta
                                </td>
                                <td>
                                    <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: hidden; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="6">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>--%>
                                    <%--                    <td class="EncabezadoCell" style="width: 90px; height: 18px;" visible="false">
                        Filtros
                    </td>
                    <td class="EncabezadoCell" style="height: 18px" visible="false">
                        <asp:RadioButtonList ID="CriterioWHERE" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">todos</asp:ListItem>
                            <asp:ListItem>alguno</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>--%>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 160px; height: 18px;">Punto venta
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="180px" />
                                    </td>
                                    <td class="EncabezadoCell">Cliente Obs. (excl.)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtClienteAuxiliar" runat="server" autocomplete="off" AutoPostBack="false"
                                            Visible="false" CssClass="CssTextBox" TabIndex="8" />
                                        <asp:CheckBox ID="chkClienteAuxiliar" runat="server" Checked="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Excepciones
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta"
                                            Width="" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                            TabIndex="6">
                                            <asp:ListItem Text="Agro" />
                                            <asp:ListItem Text="Seeds" />
                                            <asp:ListItem Text="Ambas" Selected="True" />
                                            <asp:ListItem Text="Acopio 1 ACA" Value="ACA401" />
                                            <asp:ListItem Text="Acopio 2 ACA" Value="ACA401" />
                                            <asp:ListItem Text="Acopio 3 ACA" Value="ACA402" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="height: 20px;">
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:DropDownList ID="cmbCriterioWHERE" runat="server" ToolTip="" Height="21px" Style="visibility: visible; overflow: auto;"
                                            CssClass="CssCombo" TabIndex="6">
                                            <asp:ListItem Text="y TODOS estos" Value="todos" />
                                            <asp:ListItem Text="y ALGUNO de estos" Value="alguno" Selected="True" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 15%; height: 18px;">Titular
                                    </td>
                                    <td class="EncabezadoCell" style="width: 30%; height: 18px;">
                                        <asp:CheckBox ID="chkTitular" runat="server" Checked="true" />
                                        <asp:TextBox ID="txtVendedor" runat="server" CssClass="CssTextBox" Text='<%# Bind("VendedorDesc") %>'
                                            Visible="false" autocomplete="off" AutoPostBack="false"></asp:TextBox>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                            CompletionSetCount="12" TargetControlID="txtVendedor" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                            FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                            Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 90px">Intermediario
                                    </td>
                                    <td class="EncabezadoCell">
                                        <asp:CheckBox ID="chkIntermediario" runat="server" Checked="true" />
                                        <asp:TextBox ID="txtIntermediario" runat="server" autocomplete="off" Text='<%# Bind("IntermediarioDesc") %>'
                                            Visible="false" CssClass="CssTextBox" AutoPostBack="false" TabIndex="7"></asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                            MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                            TargetControlID="txtIntermediario" UseContextKey="True" FirstRowSelected="True"
                                            CompletionListCssClass="AutoCompleteScroll" CompletionInterval="100" DelimiterCharacters=""
                                            Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 90px">R. Comercial
                                    </td>
                                    <td class="EncabezadoCell" style="width: 220px">
                                        <asp:CheckBox ID="chkRemComercial" runat="server" Checked="true" />
                                        <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" AutoPostBack="false"
                                            Visible="false" Text='<%# Bind("RComercialDesc") %>' CssClass="CssTextBox" TabIndex="8"></asp:TextBox><cc1:AutoCompleteExtender
                                                ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" TargetControlID="txtRcomercial"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 101px">
                                        <asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="false" Font-Underline="True"
                                            ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False"
                                            ToolTip="Descarga el ReportBuilder3">Editar informe</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="false" Font-Underline="True"
                                            ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton6" runat="server" Font-Bold="false" Font-Underline="True"
                                            ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False"
                                            ToolTip="Descarga el ReportBuilder3" PostBackUrl="http://www.microsoft.com/downloads/details.aspx?displaylang=es&amp;FamilyID=9f783224-9871-4eea-b1d5-f3140a253db6">Descargar ReportBuilder2</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                            TargetControlID="Panel4" ExpandControlID="btnMasPanel" CollapseControlID="btnMasPanel"
                            CollapsedText="más filtros..." ExpandedText="ocultar" TextLabelID="btnMasPanel"
                            Collapsed="false">
                        </ajaxToolkit:CollapsiblePanelExtender>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <%--Problemas que me hacen acordar a crystal
                    http://forums.asp.net/p/1426336/3211939.aspx
                    http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/8287e1cd-767e-463c-8cb0-60c275fe5ed6

                    Creo que en el VS2008, el ReportViewer10 no se muestra bien en la vista diseño


                    http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/e609a329-58cd-4f30-b8d6-a912657d8eba
                    The reports that are created with ReportBuilder 3.0 use the RDL 2010 schema but the 
                    ReportViewer in local mode can only process/render reports that use the 2005 or 2008 schema. 
                    If you publish the 2010 report to a report server and use the ReportViewer in remote mode 
                    you can render the 2010 RDL Report.

                --%>
                <br />
                <asp:Label ID="lblErrores" runat="server"></asp:Label>

                <iframe id="iframeAAAA" runat="server" src="" visible="false" width="800px" height="600px"></iframe>

                <div style="background-color: #FFFFFF; width: 800px">
                    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        Width="100%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True">
                        <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                        --%>
                    </rsweb:ReportViewer>
                    <span>
                        <%--<div>--%>
                        <%--botones de alta y excel--%>
                        <%--</div>--%>
                    </span>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div style="background-color: #FFFFFF; width: 800px">
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        Width="100%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True">
                        <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                        --%>
                    </rsweb:ReportViewer>
                    <span>
                        <%--<div>--%>
                        <%--botones de alta y excel--%>
                        <%--</div>--%>
                    </span>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
        <%--  campos hidden --%>
        <asp:HiddenField ID="HFSC" runat="server" />
        <asp:HiddenField ID="HFIdObra" runat="server" />
        <asp:HiddenField ID="HFTipoFiltro" runat="server" />




    </form>
</body>
