<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="SincronismosAutomaticos.aspx.vb" Inherits="SincronismosAutomaticos"
    Title="Informes" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--/////////////////////////////////////////////////////////////--%>
    <%--//////////       jquery    /////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     bootstrap    /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--////////////    jqgrid     //////////////////////////////////--%>
    <link href="//cdn.jsdelivr.net/jqgrid/4.5.2/css/ui.jqgrid.css" rel="stylesheet">
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.2/jquery.jqGrid.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <div class="container" style="overflow: hidden; padding: ; margin: 0; color: White">
        <div class="row titulos">
            Sincros Automáticos
        </div>
        <br />
        <div class="row" style="visibility: ; display: ">
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" style="height: 30px" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="UpdatePanelResumen" runat="server">
                <ContentTemplate>
                    <table style="padding: 0px; border: none #FFFFFF; width: ; margin-right: 0px;" cellpadding="1"
                        cellspacing="1">
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px; height: 18px;">Estado
                            </td>
                            <td class="EncabezadoCell" style="width: 222px; height: 18px;">
                                <asp:DropDownList ID="cmbEstado" runat="server" Style="text-align: right; margin-left: 0px;"
                                    CssClass="CssCombo" ToolTip="Estado de la carta de porte" Font-Size="Small" Height="22px">
                                    <asp:ListItem Text="Todas (menos las rechazadas)" Value="TodasMenosLasRechazadas" />
                                    <asp:ListItem Text="Incompletas" Value="Incompletas" />
                                    <asp:ListItem Text="Posición" Value="Posición" />
                                    <asp:ListItem Text="Descargas" Value="Descargas" />
                                    <asp:ListItem Text="Facturadas" Value="Facturadas" />
                                    <asp:ListItem Text="No facturadas" Value="NoFacturadas" />
                                    <asp:ListItem Text="Rechazadas" Value="Rechazadas" />
                                    <asp:ListItem Text="sin liberar en Nota de crédito" Value="EnNotaCredito" />
                                </asp:DropDownList>
                            </td>
                            <td class="EncabezadoCell" style="width: 162px; height: 18px;">Fecha de Descarga
                            </td>
                            <td class="EncabezadoCell" style="width: 300px; height: 18px;">
                                <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                                    Visible="true">
                                    <asp:ListItem Text="Hoy" />
                                    <asp:ListItem Text="Ayer" Selected="True" />
                                    <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                                    <asp:ListItem Text="Este mes" />
                                    <asp:ListItem Text="Mes anterior" />
                                    <asp:ListItem Text="Cualquier fecha" />
                                    <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                                    <asp:ListItem Text="Personalizar" />
                                </asp:DropDownList>
                                <br />
                                <asp:TextBox ID="txtFechaDesde" runat="server" Width="100px" MaxLength="1" autocomplete="off"
                                    TabIndex="2" AutoPostBack="false"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                                    Enabled="True">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    UserDateFormat="DayMonthYear" Enabled="True">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                                    WatermarkText="desde" WatermarkCssClass="watermarked" />
                                <asp:TextBox ID="txtFechaHasta" runat="server" Width="100px" MaxLength="1" TabIndex="2"
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
                            <td class="EncabezadoCell" style="height: 18px;">Contrato
                            </td>
                            <td>
                                <asp:TextBox ID="txtContrato" runat="server" TabIndex="13" Style="margin-left: 0px;" />
                            </td>
                            <td class="EncabezadoCell" style="width: 160px; height: 18px;">Punto venta
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="60px" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="" CausesValidation="False" Font-Size="16px" Height="20px" BorderStyle="None"
                                Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                                BorderWidth="5px" Width="127px"></asp:LinkButton>
                            <asp:Panel ID="Panel4" runat="server">
                                <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                                    cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Origen
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtProcedencia" runat="server" CssClass="CssTextBox" Text='<%# Bind("ProcedenciaDesc") %>'
                                                AutoPostBack="false"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtProcedencia" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Destino
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
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
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Producto
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txt_AC_Articulo" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                                autocomplete="off" CssClass="CssTextBox" AutoPostBack="false"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">Corredor
                                        </td>
                                        <td class="EncabezadoCell" style="height: 18px">
                                            <asp:TextBox ID="txtCorredor" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                Text='<%# Bind("CorredorDesc") %>' AutoPostBack="false" Enabled="false"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceVendedores.asmx" TargetControlID="txtCorredor" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Destinatario
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtDestinatario" runat="server" Text='<%# Bind("EntregadorDesc") %>'
                                                AutoPostBack="false" autocomplete="off" CssClass="CssTextBox" Enabled="false"> </asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender25" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtDestinatario" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
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
                                        <td class="EncabezadoCell">Excepciones
                                        </td>
                                        <td>
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
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            <asp:Label runat="server" ID="lblTopClientes" Text="Top clientes" />
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtTopClientes" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                                autocomplete="off" CssClass="CssTextBox" AutoPostBack="false"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="height: 18px;">
                                            <asp:Label runat="server" ID="lblMinimoNeto" Text="Minimo neto" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMinimoNeto" runat="server" TabIndex="13" Style="margin-left: 0px;" />
                                        </td>
                                    </tr>
                                    <tr style="border-top: 1px; margin-top: 5px;">
                                        <td colspan="2">
                                            <asp:DropDownList ID="cmbCriterioWHERE" runat="server" ToolTip="" Height="21px" Style="visibility: visible; overflow: auto;"
                                                CssClass="CssCombo" TabIndex="6">
                                                <asp:ListItem Text="y TODOS estos" Value="todos" />
                                                <asp:ListItem Text="y ALGUNO de estos" Value="alguno" Selected="True" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Titular
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtTitular" runat="server" CssClass="CssTextBox" Text='<%# Bind("VendedorDesc") %>'
                                                autocomplete="off" AutoPostBack="false" Enabled="false"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px">Intermed.
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtIntermediario" runat="server" autocomplete="off" Text='<%# Bind("IntermediarioDesc") %>'
                                                CssClass="CssTextBox" AutoPostBack="false" TabIndex="7" Enabled="false"></asp:TextBox>
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
                                            <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" AutoPostBack="false"
                                                Text='<%# Bind("RComercialDesc") %>' CssClass="CssTextBox" TabIndex="8" Enabled="false"></asp:TextBox><cc1:AutoCompleteExtender
                                                    ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" TargetControlID="txtRcomercial"
                                                    UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                    DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell">Cliente Observaciones
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPopClienteAuxiliar" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                Width="" TabIndex="20" Enabled="false"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender11" runat="server"
                                                CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopClienteAuxiliar"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
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
                                Collapsed="true">
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
                    <div class="nav nav-fixed">
                        <br />
                        <asp:Button ID="Button2" Text="Enviar correos" runat="server" CssClass="btn btn-primary" />
                        <asp:Label ID="Label1" ForeColor="White" runat="server" Text=" o " Font-Bold="false"
                            Font-Size="Small"></asp:Label>
                        <asp:LinkButton ID="lnkEnviarVistaPrevia" runat="server" Font-Bold="false" Font-Underline="True"
                            ForeColor="White" CausesValidation="true" Font-Size="Small" Height="23px" Style="margin-top: 0px">enviar vista previa a</asp:LinkButton>
                        <asp:TextBox ID="txtRedirigirA" runat="server" Width="200px"></asp:TextBox>
                        <span>&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp &nbsp &nbsp&nbsp &nbsp&nbsp &nbsp </span>
                        <asp:Button ID="Button1" Text="Grabar" runat="server" CssClass="btn btn-default" />
                        <br />
                        <br />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblErrores" CssClass="" ForeColor="White" runat="server" Font-Size="12pt"
                        Enabled="false"></asp:Label>
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
        </div>
        <br />
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBox32" runat="server" Checked="true" Visible="" />
                <script>
                    // http://stackoverflow.com/questions/9669005/jquery-toggle-select-all-checkboxes
                    $(document).ready(function () {
                        $('#ctl00_ContentPlaceHolder1_CheckBox32').click(function () {
                            //alert('ass');
                            var check = ($('#ctl00_ContentPlaceHolder1_CheckBox32').attr("checked") == undefined);
                            // alert(check );
                            //$(':checkbox').attr('checked', this.checked);
                            $(':checkbox').attr('checked', check);
                        });

                    })

                </script>
                Sincro
            </div>
            <div class="col-md-4">
                <div class="col-md-8">
                    Email
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="chkACA" runat="server" Checked="true" />
                A.C.A.
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailACA" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
                <%--corredor--%>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="chkAJNari" runat="server" Checked="true" />
                AJNari
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAJNari" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
                <%--corredor--%>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="chkAgrosur" runat="server" Checked="true" />
                Agrosur
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAgrosur" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
                <%--corredor--%>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAlabern" runat="server" Checked="true" />
                Alabern
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAlabern" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
                <%--corredor--%>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAlabernCal" runat="server" Checked="true" />
                Alabern (calidades)
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAlabernCal" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAlea" runat="server" Checked="true" />
                Alea
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAlea" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAibal" runat="server" Checked="true" />
                AIBAL Serv Agrop
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAibal" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAmaggi" runat="server" Checked="true" />
                Amaggi (descargas)
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAmaggi" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAmaggiCal" runat="server" Checked="true" />
                Amaggi (calidades)
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAmaggiCal" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAndreoli" runat="server" Checked="true" />
                Andreoli
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAndreoli" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxAreco" runat="server" Checked="true" />
                Areco Semillas
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailAreco" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>


        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxArgencer" runat="server" Checked="true" />
                Argencer
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailArgencer" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBeraza" runat="server" Checked="true" />
                Beraza
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBeraza" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBLD" runat="server" Checked="true" />
                BLD
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBLD" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBTGPactual" runat="server" Checked="true" />
                BTG PACTUAL [BIT]
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBTGPactual" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBunge" runat="server" Checked="true" />
                Bunge
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBunge" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxDiazForti" runat="server" Checked="true" />
                Diaz Forti
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailDiazForti" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxDiazRiganti" runat="server" Checked="true" />
                Diaz Riganti
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailDiazRiganti" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxDOW" runat="server" Checked="true" />
                DOW
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailDOW" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxDukarevich" runat="server" Checked="true" />
                Dukarevich
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailDukarevich" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxElEnlace" runat="server" Checked="true" />
                El Enlace
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailElEnlace" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxEstanar" runat="server" Checked="true" />
                Estanar
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailEstanar" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
    
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxLartirigoyen" runat="server" Checked="true" />
                Lartirigoyen
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailLartirigoyen" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"> </asp:TextBox>
            </div>
        </div>

          <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBiznaga" runat="server" Checked="true" />
                La Biznaga
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBiznaga" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxBragadense" runat="server" Checked="true" />
                La Bragadense
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailBragadense" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
            <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxLeiva" runat="server" Checked="true" />
                Leiva
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailLeiva" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxLelfun" runat="server" Checked="true" />
                Lelfun
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailLelfun" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGrobo" runat="server" Checked="true" />
                Los Grobo
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGrobo" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxFYO" runat="server" Checked="true" />
                FYO
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailFYO" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>

        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGranar" runat="server" Checked="true" />
                Granar
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGranar" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>

        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGranosdelParana" runat="server" Checked="true" />
                Granos del Parana
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGranosdelParana" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGranosdelLitoral" runat="server" Checked="true" />
                Granos del Litoral
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGranosdelLitoral" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"> </asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGrimaldi" runat="server" Checked="true" />
                Grimaldi Grassi
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGrimaldi" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
         <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxGualeguay" runat="server" Checked="true" />
                Gualeguay
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailGualeguay" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxCinque" runat="server" Checked="true" />
                Miguel Cinque
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailCinque" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxMonsanto" runat="server" Checked="true" />
                Monsanto
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailMonsanto" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxMorgan" runat="server" Checked="true" />
                Morgan
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailMorgan" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxNoble" runat="server" Checked="true" />
                Noble
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailNoble" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxNobleCalidad" runat="server" Checked="true" />
                Noble (calidades)
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailNobleCalidad" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"> </asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxOjeda" runat="server" Checked="true" />
                Ojeda
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailOjeda" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxPelayo" runat="server" Checked="true" />
                Pelayo
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailPelayo" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxPetroagro" runat="server" Checked="true" />
                PetroAgro
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailPetroagro" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxPSA" runat="server" Checked="true" />
                PSA La California
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailPSA" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxPSAcalid" runat="server" Checked="true" />
                PSA (calidades)
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailPSAcalid" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxRivara" runat="server" Checked="true" />
                Rivara
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailRivara" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxSantaCatalina" runat="server" Checked="true" />
                Santa Catalina
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailSantaCatalina" runat="server" Text=''
                    AutoPostBack="false" autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxSyngenta" runat="server" Checked="true" />
                Syngenta
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailSyngenta" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
                <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxTerraVerde" runat="server" Checked="true" />
                Terra Verde
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailTerraverde" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxTomas" runat="server" Checked="true" />
                Tomas Hnos
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailTomas" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxTecnocampo" runat="server" Checked="true" />
                Tecnocampo
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailTecnocampo" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <asp:CheckBox ID="CheckBoxZENI" runat="server" Checked="true" />
                ZENI
            </div>
            <div class="col-md-10">
                <asp:TextBox CssClass="col-md-8" ID="txtMailZENI" runat="server" Text='' AutoPostBack="false"
                    autocomplete="off"></asp:TextBox>
            </div>
            <%--corredor--%>
        </div>
        <br />
        <br />
        <div class="row">
        </div>
        <div class="row">
        </div>
    </div>
    <div>
        <%--       <table id="list9">
        </table>
        <div id="pager9" >
        </div>
        <br />
        <a href="javascript:void(0)" id="m1">Get Selected id's</a> <a href="javascript:void(0)"
            id="m1s">Select(Unselect) row 13</a>--%>
        <script>


            jQuery("#list9").jqGrid({
                url: 'Handler.ashx',
                datatype: "json",
                colNames: ['Inv No'
                , 'Date', 'Client', 'Amount',
                'Tax', 'Total', 'Notes'
                ],
                colModel: [
   		{ name: 'id', index: 'id', width: 55 },
   		{ name: 'invdate', index: 'invdate', width: 90 },
   		{ name: 'name', index: 'name', width: 100 },
   		{ name: 'amount', index: 'amount', width: 80, align: "right" },
   		{ name: 'tax', index: 'tax', width: 80, align: "right" },
   		{ name: 'total', index: 'total', width: 80, align: "right" },
   		{ name: 'note', index: 'note', width: 150, sortable: false }
                ],



                rowNum: 10,
                rowList: [10, 20, 30],
                //  pager: '#pager9', // http://stackoverflow.com/questions/16717794/jqgrid-undefined-integer-pager-not-loading
                sortname: 'id',
                recordpos: 'left',
                viewrecords: true,
                sortorder: "desc",
                multiselect: true,
                caption: "Multi Select Example",
                loadonce: true
            });
            jQuery("#list9").jqGrid('navGrid', '#pager9', { add: false, del: false, edit: false, position: 'right' });
            jQuery("#m1").click(function () {
                var s;
                s = jQuery("#list9").jqGrid('getGridParam', 'selarrrow');
                alert(s);
            });
            jQuery("#m1s").click(function () {
                jQuery("#list9").jqGrid('setSelection', "13");
            });
        </script>
    </div>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
