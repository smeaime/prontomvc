<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="~/ProntoWeb/Pedidos.aspx.vb" Inherits="Pedidos" Title="Pedidos" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <br />
            <br />
            <div style="vertical-align: middle">
                <asp:HyperLink ID="lnkNuevo" Target='_blank' runat="server" Font-Bold="false" Font-Underline="False"
                    Width="130" Height="30" CssClass="but" ForeColor="White" CausesValidation="true"
                    NavigateUrl="Pedido.aspx?Id=-1" Font-Size="Small" Style="vertical-align: middle;
                    display: inline; padding: 6px; padding-left: 12px; padding-right: 12px;" Text="+ Nuevo Pedido" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="False"
                    Width="120" Height="30" CssClass="but" ForeColor="White" CausesValidation="true"
                    Font-Size="Small" Style="vertical-align: middle" Text="+ Nuevo Pedido" OnClientClick="window.document.forms[0].target='_blank';"
                    PostBackUrl="Pedido.aspx?Id=-1" Visible="false" />
                <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: left;" Text="" Font-Size="Small"
                    Width="200" Height="20px" AutoPostBack="True" CssClass="txtBuscar"></asp:TextBox>
                <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                    WatermarkText="Buscar en pedidos" WatermarkCssClass="watermarkedBuscar" />
                <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                    margin-left: 0px;" Width="119px" Height="24px">
                    <asp:ListItem Text="Numero" Value="NumeroPedido" />
                    <asp:ListItem Text="Fecha" Value="[Fecha]" />
                    <asp:ListItem Text="Proveedor" Value="[Proveedor]" />
                    <asp:ListItem Text="Salida" Value="[Salida]" />
                    <asp:ListItem Value="Cump" Text="Cump" />
                    <asp:ListItem Value="Fecha_salida" Text="Salida" />
                    <asp:ListItem Value="RMs" Text="RMs" />
                    <asp:ListItem Value="Obras" Text="Obras" />
                    <asp:ListItem Value="NetoGravado" Text="NetoGravado" />
                    <asp:ListItem Value="Bonificacion" Text="Bonificacion" />
                    <asp:ListItem Value="Total_Iva" Text="Total Iva" />
                    <asp:ListItem Value="Otros_Conceptos" Text="Otros Conceptos" />
                    <asp:ListItem Value="Total_pedido" Text="Total pedido" />
                    <asp:ListItem Value="Moneda" Text="Moneda" />
                    <asp:ListItem Value="Comprador" Text="Comprador" />
                    <asp:ListItem Value="Liberado_por" Text="Liberado" />
                    <asp:ListItem Value="CantidadItems" Text="CantidadItems" />
                    <%--<asp:ListItem Value="IdAux" Text="salida" />--%>
                    <%--<asp:ListItem Value="Aclaracion s/condicion de compra" Text="salida" />--%>
                    <%--  <asp:ListItem Value="Ext_" Text="salida" />--%>
                    <asp:ListItem Value="Pedido_abierto" Text="Pedido abierto" />
                    <asp:ListItem Value="Nro_Licitacion" Text="Nro_Licitacion" />
                    <asp:ListItem Value="Impresa" Text="Impresa" />
                    <asp:ListItem Value="Fecha_anulacion" Text="anulacion" />
                    <asp:ListItem Value="Motivo_anulacion" Text="Motivo" />
                    <asp:ListItem Value="Imp_Internos" Text="Imp_Internos" />
                    <asp:ListItem Value="Equipo_destino" Text="Equipo destino" />
                    <asp:ListItem Value="Circuito_de_firmas_completo" Text="Circuito de firmas completo" />
                    <asp:ListItem Value="Condicion_IVA" Text="Condicion IVA" />
                </asp:DropDownList>
            
                <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" autocomplete="off" Visible=false
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
                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtFechaDesde"
                    WatermarkText="desde" WatermarkCssClass="watermarked" />
                <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="2"  Visible=false
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
            </div>
            <br />
            <br />
            <table id="comandogrilla" width="99%" cellspacing="0" cellpadding="0" style="">
                <tr>
                    <td align="left">
                        <asp:Button ID="btnRefresca" Text="Refrescar" runat="server" CssClass="butcancela" />&nbsp;&nbsp;
                        <%--style="background:url(//ssl.gstatic.com/ui/v1/icons/mail/sprite_black2.png) -63px -21px no-repeat; width: 22px;
                                    height: 22px;  min-width: 32px;    " --%>
                        <asp:Button ID="btnExcel" Text="Excel" runat="server" CssClass="butcancela" />&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White" CausesValidation="true" Visible=false
                            Font-Size="x-Small">Ver informe</asp:LinkButton>
                        <div style="visibility: hidden; display: none">
                            -
                            <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="false" Font-Underline="true"
                                Visible="false" ForeColor="White" CausesValidation="true" Font-Size="x-Small">Excel</asp:LinkButton>
                            -
                            <asp:LinkButton ID="LinkZipDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                                Visible="false" ForeColor="White" CausesValidation="true" Font-Size="x-Small">Zip</asp:LinkButton>
                        </div>
                    </td>
                    <td align="right">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="Imagenes/25-1.gif" alt="" style="height: 16px" />
                                <asp:Label ID="Label342" runat="server" Text="Cargando..." Visible="true"></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblGrilla1Info" runat="server"></asp:Label>
                        <%--1 a 8 de un gran número--%>
                        <asp:Button ID="btnPaginaRetrocede" Text="<" Font-Size="Small" CssClass="butcancela"
                            Width="32px" runat="server" Style="width: 32px; min-width: 32px; height: 26px;" />
                        <asp:Button ID="btnPaginaAvanza" Text=">" Font-Size="Small" runat="server" CssClass="butcancela"
                            Width="32px" Style="width: 32px; min-width: 32px; height: 26px;" />
                        <%--///////////////////////--%>
                        <asp:LinkButton ID="LinkExcelDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                            Visible="false" ForeColor="White" CausesValidation="true" Font-Size="Small">Excel</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <br />
            <script language="javascript" type="text/javascript">
                // http: //stackoverflow.com/questions/8067721/how-to-make-a-gridview-with-maxmimum-size-set-to-the-containing-div

                function grillasize() {
                    var w = $(window).width() - (2 + 182 + 2 + 0 + 2 + 15);
                    var h = $(window).height() - 200;
                    $("#divGrid").width(w);
                    $("#comandogrilla").width(w);
                    // $("#divcontentplaceholder").width(w);

                    $("#divGrid").height(h);
                }

                // http: //blog.dreamlabsolutions.com/post/2009/02/24/jQuery-document-ready-and-ASP-NET-Ajax-asynchronous-postback.aspx
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    if (args.get_error() == undefined) {
                        grillasize();
                    }
                }


                $(function () {
                    $(window).resize(function () {
                        grillasize();
                    });
                });

                $(document).ready(function () {
                    grillasize();

                });
            </script>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left">
                        <div id="divGrid" style="overflow: auto;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                                DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width="99%"
                                PageSize="8" EnableViewState="False" CssClass="grillaListado">
                                <Columns>
                                    <asp:CommandField ShowEditButton="false" />
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <%--            <asp:TemplateField HeaderText="Ref." SortExpression="Numero">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                                    --%>
                                    <asp:TemplateField HeaderText="Número" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "Pedido.aspx?Id=" & Eval("Id") %>'
                                                Text='<%# Eval("Numero")   %>' Font-Bold="True" Font-Underline="false"> </asp:HyperLink>
                                            <br />
                                            <%--<asp:Label ID="Label2" runat="server" Text='<%# Bind("Numero") %>'></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("Fecha") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fecha", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Cumplido" HeaderText="Cump." />
                                    <%--            <asp:TemplateField HeaderText="Cuenta" SortExpression="Cuenta">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Proveedor" SortExpression="Proveedor" HeaderStyle-Width="50"
                                        ItemStyle-Width="50">
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle Wrap="true" />
                                        <%--Wrap!!!!!--%>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Proveedor") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--subgrilla--%>
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id"
                                        ItemStyle-Width="430">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" GridLines="none"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="1" CellSpacing="0"
                                                SkinID="NewSkin" Font-Size="Small" ShowHeader="false" Width="430px">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo" ItemStyle-Width="350"
                                                        ControlStyle-Width="350" HeaderStyle-Width="350" ItemStyle-CssClass="GrillaAnidadContenidoQueCorta">
                                                        <ItemStyle Wrap="false" />
                                                        <HeaderStyle />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ItemStyle-Width="80" ItemStyle-HorizontalAlign="Right">
                                                        <ItemStyle />
                                                        <HeaderStyle />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                                <RowStyle ForeColor="#4A3C8C" BorderColor="#CBCBCB" VerticalAlign="middle" Width="430px" />
                                                <%--  <AlternatingRowStyle BackColor="#FFFFFF" Font-Bold="false" ForeColor="#4A3C8C" Wrap="False" />--%>
                                                <FooterStyle BackColor="#F7F7F7" Font-Bold="false" ForeColor="#4A3C8C" Wrap="False"
                                                    BorderColor="transparent" />
                                                <PagerStyle CssClass="Pager" />
                                                <PagerStyle BackColor="#F7F7F7" ForeColor="#4A3C8C" HorizontalAlign="Left" BorderColor="transparent" />
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ControlStyle BorderStyle="None" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TotalPedido" HeaderText="Total" HeaderStyle-Width="80"
                                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}" HeaderStyle-Wrap="False">
                                        <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Fecha_salida" HeaderText="Salida" />
                                    <asp:BoundField DataField="RMs" HeaderText="RMs" />
                                    <asp:BoundField DataField="Obras" HeaderText="Obras" />
                                    <asp:BoundField DataField="NetoGravado" HeaderText="NetoGravado" />
                                    <asp:BoundField DataField="Bonificacion" HeaderText="Bonificacion" />
                                    <asp:BoundField DataField="Total_Iva" HeaderText="Total Iva" />
                                    <asp:BoundField DataField="Otros_Conceptos" HeaderText="Otros Conceptos" />
                                    <asp:BoundField DataField="Total_pedido" HeaderText="Total pedido" />
                                    <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
                                    <asp:BoundField DataField="Comprador" HeaderText="Comprador" />
                                    <asp:BoundField DataField="Liberado_por" HeaderText="Liberado" />
                                    <asp:BoundField DataField="CantidadItems" HeaderText="CantidadItems" />
                                    <%--<asp:BoundField DataField="IdAux" HeaderText="salida" />--%>
                                    <%--<asp:BoundField DataField="Aclaracion s/condicion de compra" HeaderText="salida" />--%>
                                    <%--  <asp:BoundField DataField="Ext_" HeaderText="salida" />--%>
                                    <asp:BoundField DataField="Pedido_abierto" HeaderText="Pedido abierto" />
                                    <asp:BoundField DataField="Nro_Licitacion" HeaderText="Nro_Licitacion" />
                                    <asp:BoundField DataField="Impresa" HeaderText="Impresa" />
                                    <asp:BoundField DataField="Fecha_anulacion" HeaderText="anulacion" />
                                    <asp:BoundField DataField="Motivo_anulacion" HeaderText="Motivo" />
                                    <asp:BoundField DataField="Imp_Internos" HeaderText="Imp_Internos" />
                                    <asp:BoundField DataField="Equipo_destino" HeaderText="Equipo destino" />
                                    <asp:BoundField DataField="Circuito_de_firmas_completo" HeaderText="Circuito de firmas completo" />
                                    <asp:BoundField DataField="Condicion_IVA" HeaderText="Condicion IVA" />
                                    <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--            <asp:TemplateField HeaderText="Listo" SortExpression="Listo">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
                                    <%--            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
                                    --%>
                                </Columns>
                            </asp:GridView>
                            <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                            <%--    datasource de grilla principal--%>
                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.PedidoManager" DeleteMethod="Delete"
                                UpdateMethod="Save" EnableViewState="False" StartRowIndexParameterName="startRowIndex"
                                EnablePaging="true" MaximumRowsParameterName="maximumRows" SelectCountMethod="GetTotalNumberOfPedidos">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:ControlParameter ControlID="txtBuscar" Name="txtBuscar" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="cmbBuscarEsteCampo" Name="cmbBuscarEsteCampo" PropertyName="Text"
                                        Type="String" />
                                    <asp:ControlParameter ControlID="txtFechaDesde" Name="fDesde" PropertyName="Text"
                                        Type="DateTime" DefaultValue="#1/1/1900#" />
                                    <asp:ControlParameter ControlID="txtFechaHasta" Name="fHasta" PropertyName="Text"
                                        Type="DateTime" DefaultValue="#1/1/2100#" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myPedido" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myPedido" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:GridView runat="server" DataSourceID="ObjectDataSource1" AutoGenerateColumns="true"
                                EmptyDataText="alllalalla" AllowPaging="true" Visible="false">
                            </asp:GridView>
                            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.PedidoManager" DeleteMethod="Delete"
                                UpdateMethod="Save" EnableViewState="False">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:Parameter Name="id" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myPedido" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myPedido" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                        </div>
                    </td>
                </tr>
            </table>
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
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--combo para filtrar cuenta--%>
    <table style="width: 503px; margin-right: 0px; height: 122px; visibility: hidden;
        display: none;">
        <tr>
            <td style="width: 132px; height: 32px;">
                <asp:Label ID="Label15" runat="server" Text="Filtrar por Cuenta" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 32px;">
                <asp:DropDownList ID="cmbCuenta" runat="server" Width="218px" AutoPostBack="True"
                    Height="22px" Style="margin-left: 0px" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label2" runat="server" Text="Reposicion Solicitada" ForeColor="White">
                </asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtReposicionSolicitada" runat="server" Width="80px" ForeColor="White">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label4" runat="server" Text="Fondos asignados" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtTotalAsignados" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label5" runat="server" Text="Pendientes de reintegrar" ForeColor="White"
                    Width="145px" Height="16px"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtPendientesReintegrar" runat="server" Width="80px" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px; height: 20px;">
                <asp:Label ID="Label6" runat="server" Text="SALDO" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 20px;">
                <asp:Label ID="txtSaldo" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 27px" />
        </tr>
    </table>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
