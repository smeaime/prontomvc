<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CartaDePorteAnalisisTarifa, App_Web_2raejehb" title="Análisis de Tarifas" validaterequest="false" enableeventvalidation="false" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <div style="color: white">
        <asp:UpdatePanel ID="UpdatePanelResumen" runat="server">
            <ContentTemplate>
                <br />
                <div class="titulos">
                    Análisis de Tarifas
                </div>
                <br />
                <br />
                <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                    cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Button ID="btnRefrescar" Text="VER INFORME" runat="server" Visible="True" CssClass="btn btn-primary"
                                Width="150" Height="40" />
                            <td>
                    </tr>
                </table>
                <br />

<%--                <%@ If (false)
                {
                  http://localhost:48391/ProntoWeb/ProntoWeb/CartaDePorteAnalisisTarifa.aspx?desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos&min=1.44&max=30.77
                }
                %>
--%>              

                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" style="height: 50px" />
                        <asp:Label ID="Label342" runat="server" Text="Espere por favor..." ForeColor="White"
                            Visible="true"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>


                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                            ForeColor="" CausesValidation="False" Font-Size="16px" Height="20px" BorderStyle="None"
                            Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; display: none"
                            BorderWidth="5px" Width="127px"></asp:LinkButton>
                        <asp:Panel ID="Panel4" runat="server">
                            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                                cellpadding="1" cellspacing="1">
                                <tr>
                                    <td class="EncabezadoCell" style="width: 162px; height: 18px;">Fecha de Descarga
                                    </td>
                                    <td class="EncabezadoCell" style="width: 500px; height: 18px;">
                                        <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                                            Visible="true">
                                            <asp:ListItem Text="Hoy" />
                                            <asp:ListItem Text="Ayer" />
                                            <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                                            <asp:ListItem Text="Este mes" />
                                            <asp:ListItem Text="Mes anterior" />
                                            <asp:ListItem Text="Cualquier fecha" />
                                            <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                                            <asp:ListItem Text="Personalizar" Selected="True" />
                                        </asp:DropDownList>

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


                                <%--               <tr>
                                    <td class="EncabezadoCell" style="width: 160px; height: 18px;">Punto venta
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="200px" />
                                    </td>
                                </tr>
                                <tr>
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
                                </tr>--%>
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
                                </tr>
                                <%--   <tr>
                                    <td class="EncabezadoCell" style="width: 15%;">Subcontr.
                                    </td>
                                    <td class="EncabezadoCell" style="width: 35%;">
                                        <asp:TextBox ID="txtSubcontr1" runat="server" autocomplete="off" Width="300px" TabIndex="21"
                                            AutoPostBack="false">
                                        </asp:TextBox>
                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender9" runat="server" CompletionSetCount="12"
                                            MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                            TargetControlID="txtSubcontr1" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True" OnClientItemSelected="autoCompleteEx_ItemSelected"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <script type="text/javascript">
                                            //                                         http: //stackoverflow.com/questions/12838552/detect-autocompleteextender-select-event
                                            function autoCompleteEx_ItemSelected(sender, args) {
                                                __doPostBack(sender.get_element().name, "");
                                            }
                                        </script>
                                        </script>
                                    </td>
                                </tr>--%>
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
                <div class="">
                    <%--<asp:Button ID="Button2" Text="Enviar correos" runat="server" CssClass="btn " />--%>
                    <%--                    <asp:LinkButton ID="lnkEnviarVistaPrevia" runat="server" Font-Bold="false" Font-Underline="True"
                        ForeColor="White" CausesValidation="false" Font-Size="Small" Height="23px" Style="margin-top: 0px">Enviar correo a</asp:LinkButton>
                    <asp:TextBox ID="txtRedirigirA" runat="server" Width="400px"></asp:TextBox>
                    <span>&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp &nbsp &nbsp&nbsp &nbsp&nbsp &nbsp </span>--%>
                    <%--<asp:Button ID="Button1" Text="Grabar" runat="server" CssClass="btn btn-default" />--%>

                    <div class="row">
                        <div class="col-md-2">
                            Tarifa minima
                        </div>
                        <div class="col-md-10">

                            <asp:TextBox
                                ID="txtConcepto1Importe" runat="server" Width="100px"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                            Tarifa maxima
                        </div>
                        <div class="col-md-10">
                            <asp:TextBox
                                ID="txtConcepto2Importe" runat="server" Width="100px"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="95%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True" BackColor="White">
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
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblErrores" CssClass="Alerta" runat="server" Font-Size="12pt" Enabled="false"></asp:Label>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Visible="true" ZoomMode="Percent" ZoomPercent="100" Height="1200px" SizeToReportContent="True">
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
</asp:Content>
