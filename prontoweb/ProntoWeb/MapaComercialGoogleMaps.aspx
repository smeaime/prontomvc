<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MapaComercialGoogleMaps.aspx.vb"
    Inherits="ProntoMVC.Reportes.MapaComercialGoogleMaps" Title="Informe"
    EnableEventValidation="false" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanelResumen" runat="server">
        <ContentTemplate>
            <br />
      
            
            <br />

            <a href="GoogleMapsHtml.html?modoExportacion=Ambas&idprocedencia=-1&fechadesde=2017/1/1&fechahasta=2017/3/1&idarticulo=-1&idclientefacturado=-1&tonsdesde=0&tonshasta=999999" target="_blank">ver mapa  </a>


            <script>
                function sdfsfd()
                {
                    var link= $("#")


                }


            </script>

            <br />
            <br />
            reasignar geocode de localidades

            <br />
            <br />


            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width: 300px; height: 24px;" align="">
                        <asp:Button ID="btnRefrescar" Text="VER INFORME" runat="server" Visible="True" CssClass="butcancela"
                            Height="32" Width="" />
                    </td>
                    <td colspan="2">
                    </td>
                    <td class="EncabezadoCell" style="width: 200px; height: 18px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%--Sincronismo--%>
                    </td>
                    <td colspan="2" style="display: none">
                        <asp:Button ID="btnDescargaSincro" Text="descargar" runat="server" CssClass="butcancela"
                            Height="32" Width="100" />
                    </td>
                </tr>
            </table>
            <br />
            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                cellpadding="1" cellspacing="1">
            </table>
            <br />




            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                        ForeColor="" CausesValidation="False" Font-Size="16px" Height="20px" BorderStyle="None"
                        Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; display: none"
                        BorderWidth="5px" Width="127px"></asp:LinkButton>
                    <asp:Panel ID="Panel4" runat="server">
                        <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                            cellpadding="1" cellspacing="1">


                            <%--  <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Que contenga
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="CssTextBox" autocomplete="off"
                                        Width="" TabIndex="20"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender1" runat="server"
                                        CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceClientes.asmx" TargetControlID="TextBox1"
                                        UseContextKey="True" FirstRowSelected="False" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>

                            </tr>--%>

                               <tr>
                                    <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                </td>
                             
                                   </tr>
                            <tr>
                                  <td class="EncabezadoCell">Modo
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="false" CssClass="CssTextBox"
                                        Width="110px">
                                        <asp:ListItem>Entregas</asp:ListItem>
                                        <asp:ListItem>Export</asp:ListItem>
                                        <asp:ListItem Selected="True">Ambos</asp:ListItem>
                                        <asp:ListItem>Buques</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                           
                                <td class="EncabezadoCell" style="width: 162px; height: 18px;">Descarga
                                </td>
                                <td class="EncabezadoCell" style="width: 600px; height: 18px;">
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
                                    <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" autocomplete="off"
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
                                    <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="2"
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
                               
                            </tr>
                            
                            
                            
                            <tr style="display: none">
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
                            <tr>
                                <td></td>
                            </tr>
                         
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Cliente
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtTitular" runat="server" CssClass="CssTextBox" Text='<%# Bind("VendedorDesc") %>'
                                        autocomplete="off" AutoPostBack="false"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                        CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                        Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                
                            </tr>
                            

                            <tr></tr>
                            <tr style="visibility: ">
                                <td class="EncabezadoCell" colspan="">Tons Desde
                                </td>
                                <td class="EncabezadoCell" style="width: 50px">
                                    <asp:TextBox ID="txtTonsDesde" runat="server" autocomplete="off" AutoPostBack="false"
                                        CssClass="CssTextBox" TabIndex="8" Width="40px">5</asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" colspan="">Tons Hasta
                                </td>
                                <td class="EncabezadoCell" style="width: 50px">
                                    <asp:TextBox ID="txtTonsHasta" runat="server" autocomplete="off" AutoPostBack="false"
                                        CssClass="CssTextBox" TabIndex="8" Width="40px">5</asp:TextBox>
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">

                <asp:Label runat="server" ID="txtDebug" Text="" />

                <rsweb:ReportViewer ID="ReportViewerRemoto" runat="server" Height="1500" Width=""
                    ZoomMode="PageWidth"
                    OnReportRefresh="RefrescaInforme" AsyncRendering="false" BackColor="White"
                    SizeToReportContent="True">
                    <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />
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
</asp:Content>




