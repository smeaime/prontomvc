<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CDPFacturacion, App_Web_clj4gonl" title="Facturación de Cartas de Porte" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
        rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <style>
        body
        {
            
            line-height: 16px;
        }
    </style>
    --%>
    <div class="EncabezadoCell">
        <%--  class="cssLogin">--%>
        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
            <ContentTemplate>
                <table style="visibility: hidden; display: none; padding: 0px; border: none; width: 80%;
                    height: 40px; margin-right: 0px;" cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="3" style="border: thin none; font-weight: bold; color: ; font-size: medium;
                            height: ;" align="left" valign="top">
                            <asp:Label ID="lblTitulo" ForeColor="" runat="server" Text="Facturación de Cartas de Porte"
                                Font-Size="Large" Height="22px" Width="356px" Font-Bold="True" Visible="false"></asp:Label>
                        </td>
                        <td style="height: ;" valign="top" align="right">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                    <asp:Label ID="lblUpdateProgress" runat="server" Text="Actualizando datos ..." Font-Size="Small"
                                        CssClass="Alerta"></asp:Label></ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
                <cc1:TabContainer ID="TabContainer2" runat="server" Height="500px" Width="90%" ActiveTabIndex="0"
                    CssClass="AsistenteTab" AccessKey="p">
                    <%--  CssClass="SimpleTab"        CssClass="AsistenteTab"--%>
                    <cc1:TabPanel ID="TabPanel1" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div style="border: 0 solid; width: 100%; margin-top: 5px;">
                                <table style="padding: 0px; border: none; width: 100%; height: 62px; margin-right: 0px;"
                                    cellpadding="1" cellspacing="3">
                                    <tr>
                                        <td class="EncabezadoCell" style="height: 18px;" colspan="2" >
                                            PASO 1 de 3: Filtrar Cartas Porte a facturar
                                        </td>
                                        <td colspan="5">
                                            <div align="right">
                                                <asp:Button ID="Button2" runat="server" CssClass="but" Text="Siguiente &gt;&gt;"
                                                    UseSubmitBehavior="False" Width="145px" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                                            Que contenga
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBuscar" runat="server" AutoPostBack="True" CssClass="CssTextBox"></asp:TextBox>
                                            <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                                                Enabled="False" TargetControlID="txtBuscar" WatermarkText="elegir clientes" WatermarkCssClass="watermarkedBuscar" />
                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                                TargetControlID="txtBuscar" UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell">
                                            Pto Venta
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="44px"
                                                AutoPostBack="True" />
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                                            Período
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="True" Height="22px"
                                                CssClass="CssTextBox">
                                                <asp:ListItem Text="Hoy" />
                                                <asp:ListItem Text="Ayer" />
                                                <asp:ListItem Text="Este mes" />
                                                <asp:ListItem Text="Mes anterior" Selected="True" />
                                                <asp:ListItem Text="Cualquier fecha" />
                                                <asp:ListItem Text="Personalizar" />
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" autocomplete="off"
                                                TabIndex="2"></asp:TextBox>
                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                                                Enabled="True">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True">
                                            </cc1:MaskedEditExtender>
                                            <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="2"></asp:TextBox>
                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta"
                                                Enabled="True">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Origen
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtProcedencia" runat="server" CssClass="CssTextBox" Text='<%# Bind("ProcedenciaDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtProcedencia" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                                            Destino
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>' autocomplete="off"
                                                CssClass="CssTextBox"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Producto
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txt_AC_Articulo" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                                autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Corredor
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtCorredor" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                AutoPostBack="True" Text='<%# Bind("CorredorDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceVendedores.asmx" TargetControlID="txtCorredor" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                         </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                         
                                        </td>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Corredor Obs
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtCorredorObs" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                AutoPostBack="True" Text='<%# Bind("CorredorObsDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender8" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceVendedores.asmx" TargetControlID="txtCorredorObs" UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Destinatario
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtDestinatario" runat="server" Text='<%# Bind("EntregadorDesc") %>'
                                                AutoPostBack="True" autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender25" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtDestinatario" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell">
                                            Modo
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbModo" runat="server" CssClass="CssTextBox" Width="110px"
                                                AutoPostBack="True">
                                                <asp:ListItem Selected="True">Entregas</asp:ListItem>
                                                <asp:ListItem>Export</asp:ListItem>
                                                <asp:ListItem>Ambos</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell">
                                            Excepciones
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
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
                                    <tr>
                                        <td colspan="4">
                                            <hr />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="EncabezadoCell" style="height: 18px" visible="false">
                                            <asp:DropDownList ID="cmbCriterioWHERE" runat="server" ToolTip="Elija la División de Syngenta"
                                                Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                                TabIndex="6">
                                                <asp:ListItem Text="y TODOS estos" Value="todos" />
                                                <asp:ListItem Text="y ALGUNO de estos" Value="alguno" Selected="True" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                            Titular
                                        </td>
                                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                            <asp:TextBox ID="txtTitular" runat="server" CssClass="CssTextBox" Text='<%# Bind("VendedorDesc") %>'
                                                AutoPostBack="True" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px">
                                            Intermediario
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtIntermediario" runat="server" autocomplete="off" CssClass="CssTextBox"
                                                AutoPostBack="True" TabIndex="7"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                                TargetControlID="txtIntermediario" UseContextKey="True" FirstRowSelected="True"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionInterval="100" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 90px">
                                            R. Comercial
                                        </td>
                                        <td class="EncabezadoCell" style="width: 220px">
                                            <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" AutoPostBack="True"
                                                Text='<%# Bind("RComercialDesc") %>' CssClass="CssTextBox" TabIndex="8"></asp:TextBox><cc1:AutoCompleteExtender
                                                    ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" TargetControlID="txtRcomercial"
                                                    UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                    DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                        </td>
                                        <td>
                                            Cliente Observaciones
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPopClienteAuxiliar" runat="server" CssClass="CssTextBox" autocomplete="off" TabIndex="20"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender11" runat="server"
                                                CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopClienteAuxiliar"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td colspan="4">
                                            <hr />
                                        </td>
                                    </tr>
                                      <tr>
                                        <td>
                                            Anexar sí o sí cartas explícitas de
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFacturarA" runat="server" CssClass="CssTextBox" autocomplete="off" TabIndex="20"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender7" runat="server"
                                                CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientes.asmx" TargetControlID="txtFacturarA"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr style="margin-top: 40px; height: 40px;">
                                        <td>
                                            <asp:Button ID="btnRefrescar" Text="Refrescar" runat="server" Width="70px" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnQuitarFiltros" Text="Limpiar filtros" runat="server" />
                                        </td>
                                        <td>
                                        </td>
                                        <td td align="right">
                                            <asp:UpdateProgress ID="UpdateProgress12" runat="server">
                                                <ProgressTemplate>
                                                    <img src="Imagenes/25-1.gif" style="height: 17px; width: 17px" />
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblGrilla1Info" runat="server"></asp:Label>
                                            <asp:Button ID="btnPaginaRetrocede" Text="<" runat="server" />
                                            <asp:Button ID="btnPaginaAvanza" Text=">" runat="server" />
                                            <asp:LinkButton ID="LinkExcelDescarga" runat="server" Font-Bold="False" Font-Underline="True"
                                                Visible="False" Font-Size="Small">Excel</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div style="overflow: auto; width: 100%">
                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor=""
                                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCartaDePorte"
                                                EmptyDataText="No se encontraron cartas" EmptyDataRowStyle-BackColor="Transparent"
                                                EmptyDataRowStyle-ForeColor="Black" EnableSortingAndPagingCallbacks="True" GridLines="Horizontal"
                                                PageSize="10" Width="100%" AllowPaging="True" EnableViewState="True">
                                                <Columns>
                                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                                        SortExpression="Id" Visible="False" />
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="hCheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged"
                                                                Checked="true" />
                                                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                                        </HeaderTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox></EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Numero" SortExpression="NumeroCartaDePorte" ItemStyle-Width="80px"
                                                        ItemStyle-Wrap="false">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NumeroCartaDePorte") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="HyperLink14" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte") %>'
                                                                Text='<%# Eval("NumeroCartaDePorte" ) & " " & iisnull(Eval("SubnumeroVagon")) & " " & iisnull(Eval("SubnumeroDeFacturacion"))  %>'
                                                                Style="vertical-align: middle;"> </asp:HyperLink>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Descarga" SortExpression="FechaDescarga">
                                                        <EditItemTemplate>
                                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaDescarga") %>'>
                                                            </asp:Calendar>
                                                        </EditItemTemplate>
                                                        <ControlStyle Width="100px" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaDescarga", "{0:d}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Titular" HeaderText="Titular" />
                                                    <asp:BoundField DataField="Corredor " HeaderText="Corredor" />
                                                    <asp:BoundField DataField="Destinatario" HeaderText="Destinatario" />
                                                    <asp:BoundField DataField="Intermediario" HeaderText="Interm." />
                                                    <asp:BoundField DataField="R. Comercial" HeaderText="RCom." />
                                                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                                                    <asp:BoundField DataField="Procedcia." HeaderText="Procedencia" />
                                                </Columns>
                                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" Wrap="true" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                            <br />
                                            <br />
                                            <asp:GridView ID="gvBuques" runat="server" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                                GridLines="None" Width="" EnableSortingAndPagingCallbacks="True" ShowHeader="true"
                                                PageSize="10" DataKeyNames="IdCDPMovimiento" EmptyDataText="No se encontraron embarques"
                                                AutoGenerateColumns="false">
                                                <Columns>
                                                    <%-- <asp:TemplateField HeaderText="Embarques" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Right">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTarifa" runat="server" Width="60" Text='<%# Bind("IdCDPMovimiento","{0:I}") %>'
                                                                Style="text-align: right"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewTarifa" runat="server" Width="60" Text=""></asp:TextBox>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTarifa" runat="server" Width="60" Text='<%# Bind("IdCDPMovimiento","{0:I}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:BoundField DataField="IdCDPMovimiento" HeaderText="Embarques" />
                                                    <asp:BoundField DataField="RazonSocial" />
                                                    <%-- <asp:BoundField DataField="IdExportadorDestino" />--%>
                                                    <asp:BoundField DataField="Producto" />
                                                    <asp:BoundField DataField="Cantidad" />
                                                    <%--<asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Label  runat="server" Width="60" Text='<%# Bind("Cantidad","{0:F3}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                </Columns>
                                                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <br />
                                <asp:Label ID="Label3" runat="server"></asp:Label>
                                <br />
                                <div align="right">
                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                    <asp:Button ID="btnIrAlPaso2" runat="server" CssClass="but" Text="Siguiente &gt;&gt;"
                                        UseSubmitBehavior="False" Width="145px" />
                                </div>
                            </div>
                            <br />
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel2" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div style="border: none solid; width: 100%; margin-top: 5px;">
                                <table style="padding: 0px; border: none; width: 100%; height: 62px; margin-right: 0px;"
                                    cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="height: 18px;" colspan="3">
                                            PASO 2 de 3: Elegir a quién facturar y edición de facturas a generar
                                        </td>
                                    </tr>
                                    <tr style="height: 5px;">
                                    </tr>
                                    <tr style="border-color: ; border-style: solid;">
                                        <td class="EncabezadoCell" style="width: 80px; height: 18px;">
                                            Facturar a
                                        </td>
                                        <%--                                    
                                    Ayuda
                                    1-LAS FACTURAS se agrupan por corredor si no se le factura a un corredor, y por titular si se le factura a un corredor
                                                     
                 2-EL DETALLE de factura se agrupa por Cereal y además, si es...: 
                            TITULAR:   
                                    agrupar por Destinatario + Destino

                            DESTINATARIO: 
                                    agrupar por Titular + Destino

                            CORREDOR:
                                    agrupar por Destino + Titular + Destinatario

                            A TERCERO default: 
                                    agrupar por Destino + Destinatario 

                            A TERCERO con EXPORTA='SI': 
                                    agrupar por Destino

                            A TERCERO excepcion loca: 
                                    agrupar por Destino + Titular


                                        --%>
                                        <td class="EncabezadoCell" style="height: 18px; width: 400px;" colspan="1">
                                            <asp:RadioButtonList ID="optFacturarA" ForeColor="" runat="server" Style="margin-left: 0px"
                                                AutoPostBack="True" TabIndex="105" Width="100%" ToolTip="">
                                                <asp:ListItem Value="5">Automático (una carta puede facturarse a varios)</asp:ListItem>
                                                <asp:ListItem Value="1">Titular de c/CDP</asp:ListItem>
                                                <asp:ListItem Value="2">Destinatario de c/CDP</asp:ListItem>
                                                <asp:ListItem Value="3">Corredor de c/CDP (separando por Titular) </asp:ListItem>
                                                <asp:ListItem Value="4" Selected="True">Todas a un mismo tercero:</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td class="EncabezadoCell" style="height: 18px; width: 80px;" colspan="1">
                                        </td>
                                        <td class="EncabezadoCell" style="height: 18px; width: 200px;">
                                            Agrupar renglones de cereales por
                                            <asp:DropDownList runat="server" ID="cmbAgruparArticulosPor">
                                                <asp:ListItem Value="1" Enabled="false">TITULAR: Destinatario + Destino</asp:ListItem>
                                                <asp:ListItem Value="2" Enabled="false">DESTINATARIO: Destino + Titular + Destinatario</asp:ListItem>
                                                <asp:ListItem Value="3">Destino</asp:ListItem>
                                                <asp:ListItem Value="4">Destino+Titular</asp:ListItem>
                                                <asp:ListItem Value="5">Destino+Destinatario</asp:ListItem>
                                                <asp:ListItem Value="6">Destino+RComercial/Interm+Destinat(CANJE)</asp:ListItem>
                                            </asp:DropDownList>
                                            <br />
                                            <br />
                                            <br />
                                            <asp:Panel ID="PanelAdvertenciaPagaCorredor" runat="server" Visible="false">
                                                <img src="../Imagenes/error-icon.png" alt="" id="imageUnicidadError" style="border-style: none;
                                                    border-color: inherit; border-width: medium; vertical-align: middle; text-decoration: none;
                                                    margin-left: 5px; height: 30px; width: 30px;" visible="true" title="Este número ya existe en la base!" />
                                                Paga el corredor?
                                                <asp:CheckBox ID="chkPagaCorredor" runat="server" Checked="true" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr style="border-color: ; border-style: solid;">
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                        <td valign="top">
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:TextBox ID="txtFacturarATerceros" runat="server" CssClass="CssTextBox" AutoPostBack="True" />
                                            <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server"
                                                TargetControlID="txtFacturarATerceros" WatermarkText="elegir 'a Tercero'" />
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender1" runat="server"
                                                CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientes.asmx" TargetControlID="txtFacturarATerceros"
                                                UseContextKey="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkMostrarCorredoresApartadosEnObservaciones" runat="server" Visible="false"
                                                Checked="true" Text="Mostrar corredores separados en observaciones" />
                                            <asp:CheckBox ID="chkSeparar" runat="server" Visible="false" Checked="true" Text="Separar por corredor/titular" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <table style="padding: 0px; border: none; width: 100%; margin-right: 0px;" cellpadding="0"
                                            cellspacing="0">
                                            <tr style="height: 40px;">
                                                <td colspan="1">
                                                    <asp:Button ID="btnRefrescarPaso2" Text="Refrescar" runat="server" Width="70px" Visible="true" />
                                                    <asp:TextBox ID="txtNuevaTarifa" Text="1.0" runat="server" Width="40px" Visible="false" />
                                                    <asp:Button ID="btnTarifaCero" Text="Cambiar" runat="server" Visible="false" />
                                                    <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" Checked="false" Text="Sólo mostrar tarifas en 0" />
                                                </td>
                                                <td style="width: 50px;">
                                                    <asp:UpdateProgress ID="UpdateProgress5" runat="server">
                                                        <ProgressTemplate>
                                                            <img src="Imagenes/25-1.gif" style="height: 17px; width: 17px" />
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBuscarEnGrilla2" Text="" runat="server" Width="70px" AutoPostBack="true" />
                                                    <asp:LinkButton ID="lnkBuscarEnGrilla2" runat="server" Font-Underline="false" Visible="true"
                                                        ForeColor="" CausesValidation="true" Font-Size="Small">Buscar</asp:LinkButton>
                                                    &nbsp;
                                                </td>
                                                <td align="right">
                                                    <%--1 a 8 de un gran número--%>
                                                    <asp:Label ID="lblGrilla2Info" runat="server"></asp:Label>
                                                    <asp:Button ID="btnPaginaRetrocede2" Text="<" runat="server" Visible="true" />
                                                    <asp:Button ID="btnPaginaAvanza2" Text=">" runat="server" Visible="true" />
                                                    <%--///////////////////////--%>
                                                    <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="false" Font-Underline="true"
                                                        Visible="false" ForeColor="" CausesValidation="true" Font-Size="Small">Excel</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <div style="overflow: auto; width: 100%">
                                            <asp:GridView ID="GridView2" runat="server" BackColor="" BorderColor="#507CBB" BorderStyle="None"
                                                BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AllowPaging="True" ShowFooter="True"
                                                Width="100%" EnableSortingAndPagingCallbacks="True" PageSize="10" DataKeyNames="IdCartaDePorte,IdFacturarselaA"
                                                EmptyDataText="No hay registros que cumplan el criterio" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <%--<asp:CheckBox ID="hCheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />--%>
                                                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                                        </HeaderTemplate>
                                                        <EditItemTemplate>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Visible="true" />
                                                            <%--    Checked='<%# iisnull(Eval("ColumnaTilde"),true) %>'    --%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <EditItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                                Text="Aplicar"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                Text="Cancel"></asp:LinkButton>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="AddNew"
                                                                Text="Agregar"></asp:LinkButton>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                Text="Editar"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                                        SortExpression="Id" Visible="False" />
                                                    <asp:TemplateField HeaderText="CDP" SortExpression="NumeroCartaDePorte" ItemStyle-Wrap="false">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="HyperLink14" Target='_blank' runat="server" NavigateUrl='<%#  iif( iisnull(Eval("IdCartaDePorte"),0)=-2,   "CDPStockMovimiento.aspx?Id=" & iisnull(Eval("SubnumeroVagon"),0)  ,   "CartaDePorte.aspx?Id=" & iisnull(Eval("IdCartaDePorte"),0)            )          %>'
                                                                Text='<%# HighlightText(iisnull(Eval("NumeroCartaDePorte"))) & " " & iisnull(Eval("SubnumeroVagon")) & " " & iisnull(Eval("SubnumeroDeFacturacion"))  %>'
                                                                Style="vertical-align: middle;"> </asp:HyperLink>
                                                            <%-- <asp:Label ID="Label2" runat="server" Text='<%# Bind("NumeroCartaDePorte") %>'></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Facturarle a">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTitular" runat="server" Text='<%# Bind("FacturarselaA") %>' Enabled="false"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                                                CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                                Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewVendedor" runat="server" autocomplete="off"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender1" runat="server"
                                                                CompletionSetCount="12" TargetControlID="txtNewVendedor" MinimumPrefixLength="1"
                                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                                Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "Cliente.aspx?Id=" & iisnull(Eval("IdFacturarselaA")) %>'
                                                                Text='<%# HighlightText(iisnull(Eval("FacturarselaA")))   %>' Style="vertical-align: middle;"> </asp:HyperLink>
                                                            <%-- <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("FacturarselaA") %>'></asp:Label>--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="FechaArribo" HeaderText="Arribo" DataFormatString="{0:d}"
                                                        ReadOnly="True" />
                                                    <asp:BoundField DataField="DestinoDesc" HeaderText="Destino" ReadOnly="True" />
                                                    <asp:TemplateField HeaderText="Producto">
                                                        <HeaderStyle Width="200px" />
                                                        <ItemStyle Width="200px" />
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtArticulo" runat="server" Text='<%# Bind("Producto") %>'></asp:TextBox>
                                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                                                CompletionSetCount="12" TargetControlID="txtArticulo" MinimumPrefixLength="1"
                                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" UseContextKey="True"
                                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                                Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewArticulo" runat="server" autocomplete="off" Text="CAMBIO DE CARTA DE PORTE"
                                                                Width="180"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender4" runat="server"
                                                                CompletionSetCount="12" TargetControlID="txtNewArticulo" MinimumPrefixLength="1"
                                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" UseContextKey="True"
                                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                                Enabled="True">
                                                            </cc1:AutoCompleteExtender>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblArticulo" runat="server" Text='<%# Bind("Producto") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Kg pagados" ItemStyle-HorizontalAlign="Right">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtKilos" runat="server" Width="80" Text='<%# Bind("KgNetos") %>'
                                                                Enabled="false"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewKilos" runat="server" Width="80"></asp:TextBox>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblKilos" runat="server" Width="80" Text='<%# Bind("KgNetos") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="80px" />
                                                        <ItemStyle Width="80px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Tarifa" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"
                                                        HeaderStyle-HorizontalAlign="Right">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTarifa" runat="server" Width="60" Text='<%# Bind("TarifaFacturada","{0:F3}") %>'
                                                                Style="text-align: right"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewTarifa" runat="server" Width="60" Text=""></asp:TextBox>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTarifa" runat="server" Width="60" Text='<%# Bind("TarifaFacturada","{0:F3}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Middle" Height="35px" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div align="right">
                                    <asp:LinkButton ID="lnkVistaPrevia" runat="server" Font-Bold="False" Font-Underline="True"
                                        ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                        Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                        BorderWidth="5px" TabIndex="38">Vista resumida</asp:LinkButton>
                                    <asp:LinkButton ID="lnkVistaDetallada" runat="server" Font-Bold="False" Font-Underline="True"
                                        ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                        Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                        BorderWidth="5px" TabIndex="38">Vista detallada</asp:LinkButton>
                                    <asp:LinkButton ID="lnkEnviarCorreo" runat="server" Font-Bold="False" Font-Underline="True"
                                        ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                        Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                        BorderWidth="5px" TabIndex="38">Enviar correo al cliente</asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </div>
                                <div>
                                    <asp:Label ID="lblGastoAdministrativo" Text="Tarifa de Gasto administrativo" runat="server"
                                        Visible="false" />
                                    <asp:TextBox ID="txtTarifaGastoAdministrativo" Text="1.0" runat="server" Width="40px"
                                        Visible="false" />
                                </div>
                                <div style="overflow: auto; width: 100%">
                                    <br />
                                    <asp:GridView ID="gvGastosAdmin" runat="server" BorderStyle="None" BorderWidth="1px"
                                        CellPadding="3" GridLines="None" Width="" EnableSortingAndPagingCallbacks="True"
                                        ShowHeader="true" PageSize="10" DataKeyNames="IdCartaDePorte,IdFacturarselaA"
                                        EmptyDataText="No se encontraron gastos administrativos" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Gastos administrativos">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTitular" runat="server" Text='<%# Bind("FacturarselaA") %>' Enabled="false"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                                        CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtNewVendedor" runat="server" autocomplete="off"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender1" runat="server"
                                                        CompletionSetCount="12" TargetControlID="txtNewVendedor" MinimumPrefixLength="1"
                                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "Cliente.aspx?Id=" & iisnull(Eval("IdFacturarselaA")) %>'
                                                        Text='<%# HighlightText(iisnull(Eval("FacturarselaA")))   %>' Style="vertical-align: middle;"> </asp:HyperLink>
                                                    <%-- <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("FacturarselaA") %>'></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtKilos" runat="server" Width="80" Text='<%# Bind("KgNetos") %>'
                                                        Enabled="false"></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtNewKilos" runat="server" Width="80"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblKilos" runat="server" Width="80" Text='<%# Bind("KgNetos") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="80px" />
                                                <ItemStyle Width="80px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"
                                                HeaderStyle-HorizontalAlign="Right">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTarifa" runat="server" Width="60" Text='<%# Bind("TarifaFacturada","{0:F3}") %>'
                                                        Style="text-align: right"></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtNewTarifa" runat="server" Width="60" Text=""></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTarifa" runat="server" Width="60" Text='<%# Bind("TarifaFacturada","{0:F3}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                        Text="Aplicar"></asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancel"></asp:LinkButton>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="AddNew"
                                                        Text="Agregar"></asp:LinkButton>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                        Text="Editar"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                        <AlternatingRowStyle BackColor="#F7F7F7" />
                                    </asp:GridView>
                                </div>
                                <br />
                                Próximo número de factura:
                                <asp:Label ID="lblProximoNumeroTalonario" runat="server"></asp:Label>
                                <br />

                                Orden de Compra:
                                <asp:TextBox ID="txtOrdenCompra" runat="server"></asp:TextBox>
                                  <br />
                                <asp:LinkButton runat="server" ID="lnkErrores" Text="Ver conflictos del automático"></asp:LinkButton>
                                <asp:Label ID="lblErrores" runat="server"></asp:Label>
                                <br />
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <div align="left">
                                                <asp:Button ID="Button4" runat="server" CssClass="butcancela" Text="<< Atrás" UseSubmitBehavior="False" />
                                            </div>
                                        </td>
                                        <td>
                                            <div align="right">
                                                <asp:Button ID="btnGenerarFacturas" runat="server" CssClass="but" Text="Generar Facturas >>"
                                                    Width="150px" OnClientClick="this.disabled = true;" UseSubmitBehavior="False" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel3" runat="server">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="padding: 0px; border: none; width: 100%; height: 62px; margin-right: 0px;"
                                        cellpadding="3" cellspacing="3">
                                        <tr>
                                            <td class="EncabezadoCell" style="height: 18px;" colspan="2">
                                                PASO 3 de 3: Impresión de facturas generadas
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <div style="overflow: auto; width: ">
                                        <asp:GridView ID="gvFacturasGeneradas" runat="server" AllowPaging="False" AutoGenerateColumns="false"
                                            BackColor="" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" Font-Size="Medium"
                                            CellPadding="3" CellSpacing="3" EmptyDataText="No hay registros que cumplan el criterio"
                                            EnableSortingAndPagingCallbacks="True" GridLines="Horizontal" PageSize="6">
                                            <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <AlternatingRowStyle BackColor="#F7F7F7" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Facturas generadas" ShowHeader="False" ControlStyle-Width="30px"
                                                    Visible="true" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <%--http://forums.asp.net/t/1120329.aspx--%>
                                                        <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" Text='<%# Eval("tipoabc") & "-" &  Eval("puntoventa", "{0:0000}") & "-" & Eval("NumeroFactura", "{0:00000000}")    %>'
                                                            NavigateUrl='<%#Eval("URLgenerada")%>'></asp:HyperLink>
                                                    </ItemTemplate>
                                                    <ControlStyle Width="30px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="tipoabc" HeaderText="" SortExpression="tipoabc" Visible="false" />
                                                <asp:BoundField DataField="puntoventa" HeaderText="" SortExpression="puntoventa"
                                                    Visible="false" />
                                                <asp:BoundField DataField="NumeroFactura" HeaderText="Facturas generadas" Visible="false" />
                                                <asp:BoundField DataField="RazonSocial" HeaderText="     Cliente    " />
                                                <asp:BoundField DataField="ImporteTotal" HeaderText="Total" />
                                                <asp:BoundField DataField="ImporteIva1" HeaderText="IVA" />
                                                <%--     <asp:BoundField DataField="IVANoDiscriminado"   HeaderText="IVANoDiscriminado"/>--%>
                                                <asp:BoundField DataField="RetencionIBrutos1" HeaderText="IBrutos1" />
                                                <asp:BoundField DataField="RetencionIBrutos2" HeaderText="IBrutos2" />
                                                <asp:BoundField DataField="RetencionIBrutos3" HeaderText="IBrutos3" />
                                                <%--                                                <asp:BoundField DataField="IdCodigoIVA"   HeaderText="IdCodigoIVA"/>
                                                <asp:BoundField DataField="IBcondicion"   HeaderText="IBcondicion"/>
                                                --%>
                                                <asp:BoundField DataField="NumeroCertificadoPercepcionIIBB" HeaderText="Certif IIBB" />
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <asp:Button runat="server" Text="Imprimir Fact 'A'" UseSubmitBehavior="False" CssClass="but"
                                            ToolTip="Descarga un excel con todas las facturas elegidas, y las imprime" Width="145px"
                                            Height="50" ID="Button6" Visible="false"></asp:Button>
                                        <asp:LinkButton runat="server" Text="Imprimir Fact 'A'" UseSubmitBehavior="False"
                                            CssClass="but" Visible="false" ToolTip="Descarga un excel con todas las facturas elegidas, y las imprime"
                                            Width="145px" Height="50" ID="lnkImprimir"></asp:LinkButton>
                                        <%--   ////////////////////////////////////////////////////////////////////////////
                                         ////////////////////////////////////////////////////////////////////////////
                                           ////////////////////////////////////////////////////////////////////////////
                                              ////////////////////////////////////////////////////////////////////////////--%>
                                        <asp:HyperLink ID="hlImprimir" runat="server" CssClass="but" Width="145px" Height="50"
                                            Text="Imprimir Fact 'A'" Target="_blank" Visible="false" Style="font-size: small;
                                            line-height: 50px;"> </asp:HyperLink>
                                        <%--  esto funciona, pero desaparece de la pantalla
                                             onclick="document.getElementById('ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_hlImprimir').style.display = 'none' "--%>
                                        <script type="text/javascript">
                                            $("#hlImprimir").click(function () {
                                                //var chk = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_hlImprimir');
                                                //chk.style.display = "none";
                                                var id = '#' + this.id;
                                                $(id).removeAttr("href");
                                            });
                                        </script>
                                        <%--   ////////////////////////////////////////////////////////////////////////////
                                         ////////////////////////////////////////////////////////////////////////////
                                           ////////////////////////////////////////////////////////////////////////////
                                              ////////////////////////////////////////////////////////////////////////////--%>
                                        <asp:HyperLink ID="hlImprimirLaser" runat="server" CssClass="but" Width="145px" Height="50"
                                            Text="Imprimir Laser" Target="_blank" Visible="false" Style="font-size: small; 
                                            line-height: 50px;"> </asp:HyperLink>
                                        <asp:LinkButton runat="server" Text="Imprimir Fact 'A'" UseSubmitBehavior="False"
                                            CssClass="but" Visible="false" ToolTip="Descarga un excel con todas las facturas elegidas, y las imprime"
                                            Width="145px" Height="50" ID="lnkImprimirLaser"></asp:LinkButton>
                                        <asp:Button runat="server" Text="Imprimir Fact 'B'" UseSubmitBehavior="False" CssClass="but"
                                            ToolTip="Descarga un excel con todas las facturas elegidas, y las imprime" Width="145px"
                                            Visible="false" ID="Button7"></asp:Button>
                                        <br />
                                        <br />
                                        <asp:LinkButton ID="lnkExcelDelPaso2Resumido" runat="server" Font-Bold="False" Font-Underline="True"
                                            ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                            Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                            BorderWidth="5px" TabIndex="38">Vista resumida</asp:LinkButton>
                                        <asp:LinkButton ID="lnkExcelDelPaso2Detallada" runat="server" Font-Bold="False" Font-Underline="True"
                                            ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                            Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                            BorderWidth="5px" Width="250px" TabIndex="38">Vista detallada</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="False" Font-Underline="True"
                                            ForeColor="" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                                            Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                                            Visible="false" BorderWidth="5px" TabIndex="38">Enviar correo al cliente</asp:LinkButton>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <asp:Button ID="lnkReintentarPaso2" runat="server" CssClass="butcancela" Text="&lt;&lt; Anular facturas y reintentar"
                                            UseSubmitBehavior="False" Width="250px" Visible="false" />
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                                <asp:Label ID="lblUpdateProgress48" ForeColor="" runat="server" Text="Actualizando datos ..."
                                                    Font-Size="Small"></asp:Label></ProgressTemplate>
                                        </asp:UpdateProgress>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                </cc1:TabContainer>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
        <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
        <span>
            <%--<div>--%>
            <%--botones de alta y excel--%>
            <%--</div>--%>
        </span>
        <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
        <%--  campos hidden --%>
        <asp:HiddenField ID="HFSC" runat="server" />
        <asp:HiddenField ID="HFIdObra" runat="server" />
        <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    </div>
</asp:Content>
