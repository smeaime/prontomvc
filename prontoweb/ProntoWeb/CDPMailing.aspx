<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CDPMailing.aspx.vb" Inherits="CDPMailing" Title="Envío de correos"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="../JavaScript/jquery-1.4.1.js" type="text/javascript"></script>--%>
    <%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">--%>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
    <div class="container" style="overflow: hidden; padding: ; margin: 0">
        <div class="row" style="visibility: ; display: ">
            <script type="text/javascript">
                //    http: //stackoverflow.com/questions/2420513/how-to-align-columns-in-multiple-gridviews


                //        $(function () {
                //            var maxWidth = 0;
                //            $('TBODY TR:first TD.col1').each(function () {
                //                maxWidth = $(this).width > maxWidth ? $(this).width : maxWidth;
                //            });
                //            $('TBODY TR:first TD.col1').width(maxWidth);
                //        });


                $(document).ready(function () {
                    // $("#TablaPrincipal").css({ width: $(window).width() });
                    //$("#TablaPrincipal").width ($(window).width());
                });

            </script>
            <div id="TablaPrincipal">
                <table style="padding: 0px; border: none #FFFFFF; width: 100%; height: 30px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF; font-size: medium; height: 37px;"
                            align="left" valign="top">
                            <asp:Label ID="lblTitulo" ForeColor="White" runat="server" Text="Envío de Mails"
                                Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>
                        </td>
                        <td style="height: 30px;" valign="top" align="right">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                    <asp:Label ID="lblUpdateProgress" ForeColor="White" runat="server" Text="Actualizando datos ..."
                                        Font-Size="Small"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
                <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" Interval="60000" Enabled="true">
                        </asp:Timer>
                        <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="False"
                            CssClass="butCrear but" ForeColor="White" CausesValidation="true" Font-Size="Small">+ Nuevo Filtro</asp:LinkButton>
                        <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
                            ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
                        <asp:TextBox ID="txtBuscar" runat="server" Width="200px" Style="margin-left: 64px; margin-top: 10px;"
                            Text="" Visible="True" AutoPostBack="True"></asp:TextBox>
                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" AutoPostBack="True" Style="text-align: right; margin-left: 0px;"
                            Height="22px">
                            <asp:ListItem Text="en cualquier campo de cliente" Value="Todos los clientes" />
                            <asp:ListItem Text="Emails" Value="Emails" />
                            <asp:ListItem Text="Titular" Value="VendedorDesc" />
                            <asp:ListItem Text="Intermediario" Value="CuentaOrden1Desc" />
                            <asp:ListItem Text="R.Comercial" Value="CuentaOrden2Desc" />
                            <asp:ListItem Text="Corredor" Value="CorredorDesc" />
                            <asp:ListItem Text="Destinatario" Value="EntregadorDesc" />
                            <asp:ListItem Text="Producto" Value="Producto" />
                            <asp:ListItem Text="Origen" Value="ProcedenciaDesc" />
                            <asp:ListItem Text="Destino" Value="DestinoDesc" />
                            <asp:ListItem Text="Cliente Obs." Value="ClienteAuxiliarDesc" />

                        </asp:DropDownList>
                        <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="false" Font-Underline="True"
                            Visible="false" ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px"
                            Width="95px" CssClass="butBuscar" Style="margin-top: 0px">Buscar filtro</asp:LinkButton>
                        <br />
                        <br />
                        <%-- <div style="overflow-x: scroll; width: 80%">--%>
                        <asp:Panel ID="Panel1" runat="server" Width="" Style="overflow-x: scroll;">
                            <table width="100%">
                                <tr>
                                    <td align="left">
                                        <asp:Button ID="btnRefresca" Text="Refrescar" runat="server" />
                                        <asp:Label ID="lblAlerta" runat="server" CssClass="Alerta" Font-Size="small"></asp:Label>
                                        <asp:Button ID="btnCancelarTrabajos" Text="Cancelar trabajos" runat="server" />
                                        <%--<asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="false" Font-Underline="true"
                                ForeColor="White" CausesValidation="true" Font-Size="x-Small">Ver informe</asp:LinkButton>
                            -
                            <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="false" Font-Underline="true"
                                ForeColor="White" CausesValidation="true" Font-Size="x-Small">Excel</asp:LinkButton>
                            -
                            <asp:LinkButton ID="LinkZipDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                                ForeColor="White" CausesValidation="true" Font-Size="x-Small">Zip</asp:LinkButton>--%>
                                    </td>


                                    <td align="right">
                                        <%--1 a 8 de un gran número--%>
                                        <asp:Button ID="Button1" Text="test de mail y hit a testcachetimeout" runat="server" Visible="false" />
                                        <asp:Label ID="lblGrilla1Info" runat="server"></asp:Label>
                                        <asp:Button ID="btnPaginaRetrocede" Text="<" runat="server" />
                                        <asp:Button ID="btnPaginaAvanza" Text=">" runat="server" />
                                        <%--///////////////////////--%>
                                        <asp:LinkButton ID="LinkExcelDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                                            Visible="false" ForeColor="White" CausesValidation="true" Font-Size="Small">Excel</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="IdWilliamsMailFiltro"
                                ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" ShowFooter="false"
                                Font-Size="X-Small" AllowPaging="True" EmptyDataText="La lista está vacía" GridLines="Horizontal"
                                CellPadding="5" PageSize="6" BorderWidth="0" Width="100%" Height="60%">
                                <%--                OnRowDataBound="GridView1_RowDataBound" 
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing" 
                OnRowUpdating="GridView1_RowUpdating" 
                OnRowCommand="GridView1_RowCommand"
                OnRowDeleting="GridView1_RowDeleting" 
                                --%>
                                <Columns>
                                    <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="hCheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                        </HeaderTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                                            <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                            --%>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--                    <asp:CommandField ShowEditButton="True" />
                                    --%>
                                    <asp:TemplateField HeaderText="" ShowHeader="False" ItemStyle-VerticalAlign="Middle"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%--este link necesita asignar EXPLICITO el commandArgument http://www.experts-exchange.com/Programming/Languages/.NET/ASP.NET/Q_23247223.html --%>
                                            <asp:LinkButton ID="lnkPopupEditar" runat="server" CausesValidation="False" CommandName="EditPopup"
                                                CommandArgument='<%# Container.DataItemIndex %>' Text="Editar"></asp:LinkButton>
                                            <%--este link necesita asignar EXPLICITO el commandArgument--%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:LinkButton ID="lnkPopupAgregar" runat="server" CausesValidation="False" CommandName="AddNewPopup"
                                                Text="Agregar"></asp:LinkButton>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:ButtonField runat="server" Text="Excel" ItemStyle-VerticalAlign="Middle" CommandName="Excel"
                                        Visible="false" />
                                    <asp:TemplateField HeaderText="" ShowHeader="False" Visible="False">
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
                                    <asp:BoundField DataField="IdWilliamsMailFiltro" HeaderText="n°" Visible="true" HeaderStyle-Width="30px" ItemStyle-VerticalAlign="Middle" />

                                    <asp:TemplateField HeaderText="Titular" ItemStyle-Wrap="true" HeaderStyle-Width="100">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtVendedor" runat="server" Text='<%# Bind("VendedorDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtVendedor" MinimumPrefixLength="1"
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
                                            <asp:Label ID="lblVendedor" runat="server" Text='<%# Bind("VendedorDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Emails" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios"
                                        ItemStyle-VerticalAlign="Middle" HeaderStyle-Width="200px" ItemStyle-Width="200px"
                                        ControlStyle-Width="200px">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEmails" runat="server" Text='<%# Bind("Emails") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewEmails" runat="server"></asp:TextBox>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmails" runat="server" Text='<%# Bind("Emails") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ultimo Resultado" SortExpression="UltimoResultado"
                                        HeaderStyle-Width="200px" ItemStyle-Width="200px" ControlStyle-Width="200px"
                                        ItemStyle-VerticalAlign="Middle" ItemStyle-Wrap="true">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUltimoResultado" runat="server" Text='<%# Bind("UltimoResultado") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--                    <asp:TemplateField HeaderText="Pos./Desc.">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbPosicion" runat="server">
                                <asp:ListItem Text="Posicion" />
                                <asp:ListItem Text="Descarga" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewPosicion" runat="server">
                                <asp:ListItem Text="Posicion" />
                                <asp:ListItem Text="Descarga" />
                            </asp:DropDownList>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# iif( IIf(Eval("EsPosicion") Is DBNull.Value, False, Eval("EsPosicion")) , "Posicion","Descarga")        %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="P.V." SortExpression="P.V." HeaderStyle-Width="10px"
                                        ItemStyle-Width="10px" ControlStyle-Width="10px" ItemStyle-VerticalAlign="Middle"
                                        ItemStyle-Wrap="true">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PuntoVenta") %>'></asp:Label>
                                            <asp:Label ID="lblPV" runat="server" Text='<%# Bind("AuxiliarString1") %>' Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Modo">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="cmbModo" runat="server">
                                                <asp:ListItem Text="Entregas" />
                                                <asp:ListItem Text="Export" />
                                                <asp:ListItem Text="Ambas" />
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:DropDownList ID="cmbNewModo" runat="server">
                                                <asp:ListItem Text="Entregas" />
                                                <asp:ListItem Text="Export" />
                                                <asp:ListItem Text="Ambas" />
                                            </asp:DropDownList>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label311" runat="server" Text='<%# Bind("Modo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Orden">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtOrden" Width="30" runat="server" Text='<%# Bind("Orden") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewOrden" Width="30" runat="server"></asp:TextBox>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label325" Width="30" runat="server" Text='<%# Bind("Orden") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Intermediario">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCuentaOrden1" runat="server" Text='<%# Bind("CuentaOrden1Desc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender22" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtCuentaOrden1" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewCuentaOrden1" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewCuentaOrden1" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblCuentaOrden1" runat="server" Text='<%# Bind("CuentaOrden1Desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="R.Comercial">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCuentaOrden2" runat="server" Text='<%# Bind("CuentaOrden2Desc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender23" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtCuentaOrden2" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewCuentaOrden2" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender3" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewCuentaOrden2" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblCuentaOrden2" runat="server" Text='<%# Bind("CuentaOrden2Desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Corredor">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCorredor" runat="server" Text='<%# Bind("CorredorDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtCorredor" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewCorredor" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender4" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewCorredor" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblCorredor" runat="server" Text='<%# Bind("CorredorDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Destinatario">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEntregador" runat="server" Text='<%# Bind("EntregadorDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender25" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtEntregador" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewEntregador" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender5" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewEntregador" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEntregador" runat="server" Text='<%# Bind("EntregadorDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contrato" Visible="false">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtContrato" runat="server" Text='<%# Bind("Contrato") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewContrato" runat="server"></asp:TextBox>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label343" runat="server" Text='<%# Bind("Contrato") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--                    <asp:TemplateField HeaderText="Desde">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" TabIndex="3"
                                Text='<%# Bind("FechaDesde") %>'></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                                Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender11" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewFechaDesde" runat="server" Width="72px" MaxLength="1" TabIndex="3"
                                Text='<%# Bind("FechaDesde") %>'></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender8" runat="server" Format="dd/MM/yyyy" TargetControlID="txtNewFechaDesde"
                                Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtNewFechaDesde" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2523" runat="server" Text='<%# Bind("FechaDesde") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Hasta">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="3"
                                Text='<%# Bind("FechaHasta") %>'></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender333" runat="server" Format="dd/MM/yyyy"
                                TargetControlID="txtFechaHasta" Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender122" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="3"
                                Text='<%# Bind("FechaHasta") %>'></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender23" runat="server" Format="dd/MM/yyyy"
                                TargetControlID="txtNewFechaHasta" Enabled="True">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1233" runat="server" ErrorTooltipEnabled="True"
                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtNewFechaHasta" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True">
                            </cc1:MaskedEditExtender>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label53533" runat="server" Text='<%# Bind("FechaHasta") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Producto" Visible="false">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="cmbArticulo" runat="server">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Producto") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:DropDownList ID="cmbNewArticulo" runat="server">
                                            </asp:DropDownList>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Origen" Visible="false">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtProcedencia" runat="server" Text='<%# Bind("ProcedenciaDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtProcedencia" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewProcedencia" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender7" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewProcedencia" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx" UseContextKey="True"
                                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblProcedencia" runat="server" Text='<%# Bind("ProcedenciaDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Destino">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>'></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtNewDestino" runat="server" autocomplete="off"></asp:TextBox>
                                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender6" runat="server"
                                                CompletionSetCount="12" TargetControlID="txtNewDestino" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDestino" runat="server" Text='<%# Bind("DestinoDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- --%>
                                    <%-- --%>
                                    <%-- --%>
                                    <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" />
                                    <%--                    <asp:ButtonField ButtonType="Link" CommandName="Excel" Text="Excel" ItemStyle-HorizontalAlign="Center"
                        ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                        <ControlStyle Font-Size="Small" Font-Underline="True" />
                        <ItemStyle Font-Size="X-Small" />
                        <HeaderStyle Width="40px" />
                    </asp:ButtonField>--%>
                                </Columns>
                                <%--//////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////--%>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                        </asp:Panel>
                        <%-- </div>--%>
                        <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                        <%--    datasource de grilla principal--%>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ComparativaManager" DeleteMethod="Delete"
                            UpdateMethod="Save">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                <%--            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="cmbCuenta" Name="IdProveedor" PropertyName="SelectedValue" Type="Int32" />--%>
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myComparativa" Type="Object" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myComparativa" Type="Object" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetListItemsParaGrilla" TypeName="Pronto.ERP.Bll.ComparativaManager"
                            DeleteMethod="Delete" UpdateMethod="Save">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                <asp:Parameter Name="id" Type="Int32" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myComparativa" Type="Object" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myComparativa" Type="Object" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <br />
                        <%--<div style="color: White">
        Filtros suplementarios</div>
                        --%><asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <%--    <div style="OVERFLOW: auto;width:100%">
                                --%>
                                <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
                                    cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px;">Estado
                                        </td>
                                        <td style="width: 160px;">
                                            <asp:DropDownList ID="cmbEstado" runat="server" Style="text-align: right; margin-left: 0px;"
                                                Width="300px" Height="22px" AutoPostBack="true">
                                                <%--<asp:ListItem Text="DESCARGAS de hoy + todas las POSICIONES" Value="DescargasDeHoyMasTodasLasPosiciones"
                                            Selected="True" />--%>
                                                <asp:ListItem Text="DESCARGAS de hoy + POSICIONES filtradas" Value="DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                                                    Selected="True" />
                                                <asp:ListItem Text="Posición" Value="Posición" />
                                                <asp:ListItem Text="Descargas" Value="Descargas" />
                                                <asp:ListItem Text="Rechazos" Value="Rechazos" />
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 100px;">Punto venta
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="60px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px;">Período
                                            <%--Ultima modificación--%>
                                        </td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                                                Visible="true">
                                                <asp:ListItem Text="Hoy" />
                                                <asp:ListItem Text="Ayer" Selected="True" />
                                                <asp:ListItem Text="Este mes" />
                                                <asp:ListItem Text="Mes anterior" />
                                                <asp:ListItem Text="Cualquier fecha" />
                                                <asp:ListItem Text="Personalizar" />
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtFechaDesde" runat="server" MaxLength="1" TabIndex="2" Width="90px"></asp:TextBox>
                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                TargetControlID="txtFechaDesde">
                                            </cc1:MaskedEditExtender>
                                            <asp:TextBox ID="txtFechaHasta" runat="server" MaxLength="1" TabIndex="2" Width="90px"></asp:TextBox>
                                            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                TargetControlID="txtFechaHasta">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <%--  <tr>
                                        <td colspan="4">
                                            <hr />
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td colspan="4">
                                            <asp:LinkButton ID="lnkEnviarAClientes" runat="server" Font-Bold="false" Font-Underline="True"
                                                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="23px" Style="margin-top: 0px; margin-left: 0px;">Enviar a clientes,</asp:LinkButton>
                                            <asp:Label ID="Label1" ForeColor="White" runat="server" Text=" o " Font-Bold="false"
                                                Font-Size="Small"></asp:Label>
                                            <asp:LinkButton ID="lnkEnviarVistaPrevia" runat="server" Font-Bold="false" Font-Underline="True"
                                                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="23px" Style="margin-top: 0px">enviar vista previa a</asp:LinkButton>
                                            <asp:TextBox ID="txtRedirigirA" runat="server" Width="200px"></asp:TextBox>
                                            <asp:CheckBox ID="chkConLocalReport" runat="server" Text="usar nuevo formato" Checked="true"
                                                ForeColor="white" Visible="false" />
                                            <br />
                                            <asp:LinkButton ID="LinkButton6" runat="server" Font-Bold="false" Font-Underline="True"
                                                ForeColor="White" CausesValidation="true" Font-Size="x-Small" Height="30px" Width="200"
                                                Style="margin-top: 0px; margin-left: 0px;">Verificar rechazos de correo</asp:LinkButton>
                                            <asp:CheckBox ID="chkVistaPrevia" runat="server" Text="Vista previa (mandar mail a casilla propia)"
                                                ToolTip="Enviar a mi propia casilla de Outlook, donde una regla le hará forward automatico"
                                                Font-Size="Small" ForeColor="White" Visible="False" Style="margin-left: 0px; visibility: hidden; display: none;" />
                                            <asp:HyperLink ID="lnkCuentaGMail" Target="_blank" runat="server" Text="Ir a Cuenta"
                                                Font-Bold="False" Font-Underline="True" ForeColor="White" CausesValidation="true"
                                                Font-Size="Small" Height="30px" Visible="False" Style="margin-left: 0px; visibility: hidden; display: none;"></asp:HyperLink>
                                            <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                                <ProgressTemplate>
                                                    <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                                    <asp:Label ID="lblUpdateProgress3" ForeColor="White" runat="server" Text="Actualizando datos ..."
                                                        Font-Size="Small"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server">
                    <ContentTemplate>
                        <%--boton de agregar--%>
                        <asp:LinkButton ID="LinkButton3" runat="server" Font-Bold="False" ForeColor="White"
                            Font-Size="Small" Height="20px" Width="122px" ValidationGroup="Encabezado" BorderStyle="None"
                            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px; display: none"
                            TabIndex="10" Font-Underline="False" Enabled="False">
                            <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none; text-decoration: none;" />
                            <asp:Label ID="Label31" runat="server" ForeColor="White" Text="Agregar item" Font-Underline="True"> </asp:Label>
                        </asp:LinkButton>
                        <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                        <asp:Button ID="Button3" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;" />
                        <%--style="visibility:hidden;"/>--%>
                        <%----------------------------------------------%>
                        <asp:Panel ID="PanelDetalle" runat="server" Width="700px" CssClass="modalPopup">
                            <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                            <%--            style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
                            --%>
                            <%--cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
                            --%>
                            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                <ContentTemplate>
                                    <table style="padding: 0px; border: none #FFFFFF; margin-right: 5px; margin-top: 5px; width: 100%"
                                        cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">Emails
                                            </td>
                                            <td class="EncabezadoCell" colspan="3">
                                                <asp:TextBox ID="txtPopEmails" runat="server" autocomplete="off" Width="580px" Height="80px"
                                                    TabIndex="11" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="visibility: hidden; display: none;">
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">Que contenga
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px" colspan="3">
                                                <asp:TextBox ID="txtQueContenga" runat="server" CssClass="CssTextBox" TabIndex="12"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender10" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtQueContenga" UseContextKey="True"
                                                    CompletionListCssClass="AutoCompleteScroll" FirstRowSelected="True" DelimiterCharacters=""
                                                    CompletionListElementID="Div1" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="Div1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">Contrato
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopContrato" runat="server" CssClass="CssTextBox" TabIndex="12"></asp:TextBox>
                                            </td>
                                            <td class="EncabezadoCell" style="visibility: hidden">Orden
                                            </td>
                                            <td class="EncabezadoCell" style="visibility: hidden">
                                                <asp:TextBox ID="txtPopOrden" runat="server" Width="72px" MaxLength="1" TabIndex="13"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCellOculto">Desde
                                            </td>
                                            <td class="EncabezadoCell" style="visibility: hidden; display: none">
                                                <asp:TextBox ID="txtPopFechaDesde" runat="server" Width="72px" MaxLength="1" TabIndex="15"
                                                    Text='<%# Bind("FechaDesde") %>' Visible="False"></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtPopFechaDesde"
                                                    Enabled="True">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender11" runat="server" ErrorTooltipEnabled="True"
                                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtPopFechaDesde" CultureAMPMPlaceholder=""
                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                    Enabled="True">
                                                </cc1:MaskedEditExtender>
                                            </td>
                                        </tr>
                                        <tr style="visibility: hidden; display: none">
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">PosDesc
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:DropDownList ID="cmbPopPosicion" runat="server" Visible="False" TabIndex="16">
                                                    <asp:ListItem Text="Posicion" />
                                                    <asp:ListItem Text="Descarga" />
                                                </asp:DropDownList>
                                                &nbsp;
                                            </td>
                                            <td class="EncabezadoCell">Hasta
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="17"
                                                    Visible="False"></asp:TextBox>
                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtPopFechaHasta"
                                                    Enabled="True">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtPopFechaHasta" CultureAMPMPlaceholder=""
                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                    Enabled="True">
                                                </cc1:MaskedEditExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px">Titular
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopTitular" runat="server" autocomplete="off" CssClass="CssTextBox"
                                                    TabIndex="18" Width=""></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender1" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopTitular" UseContextKey="True"
                                                    CompletionListCssClass="AutoCompleteScroll" FirstRowSelected="True" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor1" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor1" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px">Intermediario
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopIntermediario" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="19"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender3" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopIntermediario" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor2" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor2" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px">R. Comercial
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopRComercial" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="20"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender4" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopRComercial" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor3" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor3" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px">Corredor
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopCorredor" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="21"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender5" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceVendedores.asmx" TargetControlID="txtPopCorredor" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor4" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor4" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                        </tr>
                                        <tr style="visibility: hidden; display: none">
                                            <td class="EncabezadoCell" style="width: 90px"></td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <div id="Div2" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px">Corredor 2
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopCorredor2" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="21"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender13" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceVendedores.asmx" TargetControlID="txtPopCorredor2" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor4222" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor4222" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                        </tr>

                                        <tr>

                                            <td class="EncabezadoCell" style="width: 90px">Destinatario
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopDestinatario" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="22"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender6" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopDestinatario" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    CompletionListElementID="ListDivisor5" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor5" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px">Clien Obs.
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopClienteAuxiliar" runat="server" CssClass="CssTextBox" autocomplete="off"
                                                    Width="" TabIndex="20"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender11" runat="server"
                                                    CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopClienteAuxiliar"
                                                    UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                    DelimiterCharacters="" CompletionListElementID="ListDivisor23" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor23" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px">Origen
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopProcedencia" runat="server" CssClass="CssTextBox" TabIndex="24"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                                    CompletionSetCount="12" TargetControlID="txtPopProcedencia" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    Enabled="True" CompletionListElementID="ListDivisor7">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor7" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px">Destino
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:TextBox ID="txtPopDestino" runat="server" autocomplete="off" CssClass="CssTextBox"
                                                    TabIndex="23"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender8" runat="server"
                                                    CompletionSetCount="12" TargetControlID="txtPopDestino" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                    UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                                    DelimiterCharacters="" CompletionListElementID="ListDivisor6" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor6" />
                                                <%-- Por si la lista se renderea atrás, se usa con CompletionListElementID="ListDivisor", uno por ac   http://forums.asp.net/t/1079711.aspx--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell">Producto
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:TextBox ID="txtPopArticulo" runat="server" CssClass="CssTextBox" TabIndex="25"></asp:TextBox>
                                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender9" runat="server"
                                                    CompletionSetCount="12" TargetControlID="txtPopArticulo" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" UseContextKey="True"
                                                    FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                                    Enabled="True" CompletionListElementID="ListDivisor8">
                                                </cc1:AutoCompleteExtender>
                                                <div id="ListDivisor8" />
                                            </td>
                                            <td class="EncabezadoCell" style="width: 90px; height: 18px;" visible="false">Filtros
                                            </td>
                                            <td class="EncabezadoCell" style="height: 18px" visible="false">
                                                <asp:RadioButtonList ID="CriterioWHERE" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="1">todos</asp:ListItem>
                                                    <asp:ListItem Value="2">alguno</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">Modo
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:DropDownList ID="cmbPopModo" runat="server" TabIndex="14">
                                                    <asp:ListItem Text="Entregas" />
                                                    <asp:ListItem Text="Export" />
                                                    <asp:ListItem Text="Ambas" />
                                                </asp:DropDownList>
                                            </td>
                                            <td class="EncabezadoCell">Excepciones
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta"
                                                    Width="" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                                    TabIndex="6">
                                                    <asp:ListItem Text="Ambas" />
                                                    <asp:ListItem Text="Agro" />
                                                    <asp:ListItem Text="Seeds" />
                                                    <asp:ListItem Text="Acopio 1 ACA" Value="ACA401" />
                                                    <asp:ListItem Text="Acopio 2 ACA" Value="ACA401" />
                                                    <asp:ListItem Text="Acopio 3 ACA" Value="ACA402" />
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 90px; height: 26px;">Formato
                                            </td>
                                            <td class="EncabezadoCell" style="width: 197px">
                                                <asp:DropDownList ID="cmbPopModoImpresion" runat="server" TabIndex="14">
                                                    <%--eInformesGeneralFormatos--%>
                                                   <%-- Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!--%>
                                                    <asp:ListItem Value="Excel"     Text="Excel" />
                                                    <asp:ListItem Value="Imagen"    Text="Excel con imágenes " />
                                                    <asp:ListItem Value="ExcRec"    Text="Excel con n°recibo" />
                                                    <asp:ListItem Value="Grobo"     Text="Excel GroboCuits" />
                                                    <asp:ListItem Value="GrbRec"     Text="Excel Grobo + n°recibo" />
                                                    <asp:ListItem Value="Speed"     Text="Excel SpeedAgro" />
                                                    <asp:ListItem Value="Amaggi"    Text="Excel Amaggi" />
                                                    <asp:ListItem Value="ExcHtm"    Text="Excel + Html ancho"       Enabled="true" />
                                                    <asp:ListItem Value="Html"      Text="Html"                     Enabled="false" />
                                                    <asp:ListItem Value="HtmlIm"    Text="Html con imágenes "       Enabled="false" />
                                                    <asp:ListItem Value="HImag2"    Text="Html con imágenes 2 " />
                                                    <asp:ListItem Value="EHOlav"    Text="Html corto" />

                                                    <asp:ListItem Value="GrobHc"    Text="Excel GroboCuits + Html corto" />
                                                    <asp:ListItem Value="ExcHc"     Text="Excel + Html corto" />

                                                 <%--   Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!
                                                    Si agregas un informe nuevo, agregalo tambien en el array informesHtml!!!!!!!!--%>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="EncabezadoCell"></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="">
                                                <asp:LinkButton ID="btnVerLog" runat="server" Text="Ver Log" UseSubmitBehavior="False"
                                                    ValidationGroup="Detalle" TabIndex="26" />
                                            </td>
                                            <td colspan="2" align="right">

                                                <asp:Button ID="btnSaveItem" runat="server" Text="Aceptar" CssClass="but" UseSubmitBehavior="False"
                                                    ValidationGroup="Detalle" TabIndex="26" Height="33px" Width="100px" />
                                                <asp:Button ID="btnCancelItem" runat="server" Text="Cancelar" CssClass="butcancela"
                                                    UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px" CausesValidation="False"
                                                    TabIndex="27" Height="32px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:Label ID="log" runat="server"></asp:Label>
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" colspan="4" style="border-style: none; border-width: none; font-size: x-small">
                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="lnkEnviarYa" runat="server" Font-Bold="false" Font-Underline="True"
                                                            ForeColor="White" CausesValidation="true" Font-Size="x-small" Height="30px" Width="60px"
                                                            Style="margin-top: 0px">ENVIAR YA</asp:LinkButton>

                                                        <asp:LinkButton ID="lnkEnviarYaVistaPrevia" runat="server" Font-Bold="false" Font-Underline="True"
                                                            ForeColor="White" CausesValidation="true" Font-Size="x-small" Height="30px" Width="60px"
                                                            Style="margin-top: 0px">v.previa</asp:LinkButton>

                                                        <asp:DropDownList ID="cmbEstadoPopup" runat="server" Style="text-align: right; margin-left: 0px;"
                                                            AutoPostBack="true" Width="250px" Height="22px" Font-Size="X-Small">
                                                            <%--<asp:ListItem Text="DESCARGAS de hoy + todas las POSICIONES" Value="DescargasDeHoyMasTodasLasPosiciones"
                                                        Selected="True" />--%>
                                                            <asp:ListItem Text="DESCARGAS de hoy + POSICIONES filtradas" Value="DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                                                                Selected="True" />
                                                            <asp:ListItem Text="Posición" Value="Posición" />
                                                            <asp:ListItem Text="Descargas" Value="Descargas" />
                                                            <asp:ListItem Text="Rechazos" Value="Rechazos" />
                                                        </asp:DropDownList>
                                                        Período
                                                        <asp:DropDownList ID="cmbPeriodoPopup" runat="server" AutoPostBack="true" Height="22px"
                                                            Visible="true">
                                                            <asp:ListItem Text="Hoy" />
                                                            <asp:ListItem Text="Ayer" Selected="True" />
                                                            <asp:ListItem Text="Este mes" />
                                                            <asp:ListItem Text="Mes anterior" />
                                                            <asp:ListItem Text="Cualquier fecha" />
                                                            <asp:ListItem Text="Personalizar" />
                                                        </asp:DropDownList>
                                                        <asp:TextBox ID="txtFechaDesdePopup" runat="server" MaxLength="1" TabIndex="2" Width="72px"></asp:TextBox>
                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesdePopup">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                            TargetControlID="txtFechaDesdePopup">
                                                        </cc1:MaskedEditExtender>
                                                        <asp:TextBox ID="txtFechaHastaPopup" runat="server" MaxLength="1" TabIndex="2" Width="72px"></asp:TextBox>
                                                        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                        <cc1:CalendarExtender ID="CalendarExtender6" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHastaPopup">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                            TargetControlID="txtFechaHastaPopup">
                                                        </cc1:MaskedEditExtender>
                                                        <asp:UpdateProgress ID="UpdateProgress5" runat="server">
                                                            <ProgressTemplate>
                                                                <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                                                <asp:Label ID="lblUpdateProgress5" ForeColor="White" runat="server" Text="Actualizando datos ..."
                                                                    Font-Size="Small"></asp:Label>
                                                            </ProgressTemplate>
                                                        </asp:UpdateProgress>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                        <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="Button3"
                            PopupControlID="PanelDetalle" CancelControlID="btnCancelItem" DropShadow="False"
                            BackgroundCssClass="modalBackground" />
                        <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div style="background-color: #FFFFFF; width: 800px">
                            <rsweb:ReportViewer ID="ReportViewerEscondido" runat="server" Font-Names="Verdana"
                                Font-Size="8pt" Width="100%" Visible="false" ZoomMode="PageWidth" Height="1200px"
                                SizeToReportContent="True">
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
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                <%--  campos hidden --%>
            </div>
        </div>
    </div>
    <asp:GridView ID="gridParaEmbeberEnMail" runat="server" BackColor="White" BorderColor=""
        BorderStyle="None" BorderWidth="0px" CellPadding="3" GridLines="None" Width="100%"
        AutoGenerateColumns="False" DataKeyNames="" DataSourceID="" AllowPaging="False"
        AllowSorting="False" EnableSortingAndPagingCallbacks="false" EnableModelValidation="True"
        EmptyDataText="No se encontraron registros">
        <FooterStyle BackColor="" ForeColor="" />
        <Columns>
            <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="NUMERO" HeaderStyle-HorizontalAlign="Left"
                ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="left">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("F2") %>'
                        Text='<%# Eval("F2")   %>' Font-Size="Small" Font-Bold="True" Font-Underline="false"
                        Style="vertical-align: middle;"> </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="NUMERO" HeaderStyle-HorizontalAlign="Left"
                ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="left">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" Target='_blank' runat="server" NavigateUrl='<%# Eval("F3") %>'
                        Text='<%# Eval("F3")   %>' Font-Size="Small" Font-Bold="True" Font-Underline="false"
                        Style="vertical-align: middle;"> </asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="F3" HeaderText="TITULAR" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F4" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F5" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F6" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F7" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F8" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F9" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F10" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F11" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F12" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F13" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F14" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F15" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F16" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F17" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F18" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F19" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F20" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F21" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F22" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F23" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F24" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F25" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="F26" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios" ItemStyle-HorizontalAlign="Center" />
        </Columns>
        <%--         <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Middle" Font-Size="X-Small"
            Height="60" CssClass="grillarow" HorizontalAlign="Center" />--%>
        <%--        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle HorizontalAlign="Left" CssClass="Pager" />--%>
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" Font-Underline="false" />
        <AlternatingRowStyle BackColor="#111111" />
        <%--        <EmptyDataRowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Middle"
            Font-Size="X-Small" Height="60" CssClass="grillarow" HorizontalAlign="Center" />--%>
    </asp:GridView>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
