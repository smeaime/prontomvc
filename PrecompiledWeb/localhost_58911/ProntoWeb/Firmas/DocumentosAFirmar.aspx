<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" enableviewstatemac="false" debug="true" inherits="Firmas_DocumentosAFirmar, App_Web_l2ocoatd" title="BDL Consultores" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" Font-Underline="False"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
                Visible="false">+   Nuevo</asp:LinkButton>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
                
            <asp:TextBox ID="txtBuscar" runat="server" Visible="true" Style="text-align: right;
                background-image: url(imagenes/lupita.jpg); background-position: right; background-repeat: no-repeat;"
                Text="" AutoPostBack="True"></asp:TextBox>
                      <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                                                    WatermarkText="Buscar" WatermarkCssClass="watermarked" />
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" Height="22px" Visible="true">
                
                <asp:ListItem Text="Tipo" Value="Tipo" />
                <asp:ListItem Text="Numero" Value="[Numero]" />
                <asp:ListItem Text="Fecha" Value="Fecha" />
                <asp:ListItem Text="Proveedor" Value="Proveedor" />
                <asp:ListItem Text="Base" Value="BD" />
                
                <asp:ListItem Value="[Monto compra]" Text="Monto" />
                <asp:ListItem Value="[Obra]" Text="Obra" />
                <asp:ListItem Value="[Sector]" Text="Sector" />
                <asp:ListItem Value="[Libero]" Text="Libero" />
                
                
                
                
                
                
                
                
            </asp:DropDownList>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <img src="../Imagenes/25-1.gif" alt="" style="height: 26px" width="20" height="20" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            
            
            


    <script type="text/javascript">
        elPrg = "showProgress";
        elPed = "PedidoData";
        elReq = "RequerimientoData";
    </script>

    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFUserName" runat="server" />
    &nbsp;
    <table width="100%">
        <tr>
            <td>
            <div style="width: 850px; overflow: auto;">
                <asp:Label ID="lblVacio" runat="server" Text="No se encontraron resultados" 
                    ForeColor="White" Style="text-align: right"
                Visible="False" Font-Size="Medium"></asp:Label>
                <asp:GridView ID="GVFirmas" runat="server" AutoGenerateColumns="False" DataKeyNames="BD,IdFormulario,IdComprobante,Orden"
                    DataSourceID="ObjDsFirmas" EmptyDataText="No hay firmas disponibles" BackColor="White"
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal"
                    Width="99%" AllowPaging="true" PageSize=20>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <EmptyDataRowStyle Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle"
                        BorderStyle="None" Font-Size="Large" />
                    <Columns>
                       <asp:ButtonField  CommandName="Ver" Text="ver" />

                        <asp:ButtonField  CommandName="Ver2" Text="ver original" Visible="False" />
                        <asp:TemplateField HeaderText="Firmar">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Firma") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Firma") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--                        <asp:ImageField DataImageUrlField="BD" DataImageUrlFormatString="~/Imagenes/Empresas/{0}.jpg"
                            HeaderText="BD" AlternateText="" NullDisplayText="  " >
                            <ControlStyle Height="20px" Width="40px" />
                        </asp:ImageField>--%>
                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                        <asp:BoundField DataField="Numero" HeaderText="Numero" />
                        <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fecha", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Proveedor" HeaderText="Proveedor">
                            <ItemStyle Wrap="true" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BD" HeaderText="Base" />
                        <asp:BoundField DataField="Monto compra" HeaderText="Monto" />
                        <asp:BoundField DataField="Orden" HeaderText="Orden" />
                        <asp:BoundField DataField="Mon." HeaderText="Mon." />
                        <asp:BoundField DataField="Obra" HeaderText="Obra">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Sector" HeaderText="Sector" />
                        <asp:BoundField DataField="Libero" HeaderText="Libero" />
                        <asp:BoundField DataField="IdComprobante" HeaderText="IdComprobante" Visible="False" />
                        <asp:BoundField DataField="IdFormulario" HeaderText="IdFormulario" Visible="False" />
                        <asp:TemplateField ShowHeader="False" Visible="False">
                            <ItemTemplate>
                                <asp:Button ID="ButVer" runat="server" CausesValidation="False" CommandName="Ver"
                                    CssClass="but" Text="Ver" UseSubmitBehavior="False" />
                            </ItemTemplate>
                            <ControlStyle CssClass="but" Font-Size="XX-Small" />
                            <ItemStyle Font-Size="XX-Small" />
                        </asp:TemplateField>
                                             
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <HeaderStyle CssClass="header" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjDsFirmas" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetDocumetosAFirmar" TypeName="Pronto.ERP.Bll.FirmaDocumentoManager"
                    DeleteMethod="Delete" InsertMethod="SaveBlock">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                        <asp:ControlParameter ControlID="HFUserName" Name="Usuario" PropertyName="Value"
                            Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myFirmaDocumento" Type="Object" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="BDs" Type="String" />
                        <asp:Parameter Name="IdFormularios" Type="String" />
                        <asp:Parameter Name="IdComprobantes" Type="String" />
                        <asp:Parameter Name="NumerosOrden" Type="String" />
                        <asp:Parameter Name="Autorizo" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;<asp:Panel ID="PanelAction" runat="server" Width="407px">
                    <asp:Button ID="btnMarcar" runat="server" CssClass="but" Text="Marcar todo" Visible="False"
                        Width="110px" />
                    <asp:Button ID="btnDesmarcar" runat="server" CssClass="but" Text="Desmarcar todo"
                        Visible="False" Width="130px" />
                    <asp:Button ID="btnFirmar" runat="server" CssClass="but" Text="Firmar" /></asp:Panel>
            </td>
        </tr>
    </table>
    &nbsp;
    <!-- div -->
    <div style="display: none; visibility: hidden" id="bkgDark" class="backgroundPopUp">
    </div>
    <div id="showProgress" style="width: 250px" class="progressBar">
    </div>
    <!-- end div -->
    <!-- Pedido -->
    <div style="display: none; visibility: hidden; left: 0px; width: 500px; position: absolute;
        top: 1500px; height: 500px;" id="PedidoData">
    </div>
    <asp:Panel ID="PanelPed" runat="server" Visible="false">
        <div onmousedown="dragStart(event,'PedidoData')">
            <table cellpadding="0" cellspacing="0" class="t1" style="background-color: #507CBB">
                <tr>
                    <td align="left" style="font-weight: bold; color: White; background-color: Blue;
                        height: 12px;">
                        Nota de pedido
                    </td>
                    <td align="right" style="font-weight: bold; color: White; background-color: Blue;
                        height: 12px;">
                        <a href="#" onclick="javascript:closePed();return false;">
                            <img height="16" src="../../Imagenes/action_delete.png" alt="Cerrar" border="0" /></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" valign="top" align="center" rowspan="5">
                        <table style="border-right: thin solid; border-top: thin solid; border-left: thin solid;
                            border-bottom: thin solid" width="700">
                            <tbody>
                                <tr>
                                    <td style="width: 35%" valign="top" align="center" colspan="2">
                                        <table class="t1" width="99%">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Nro.Pedido:
                                                            <asp:Label ID="lblNumero" runat="server" ForeColor="White" Font-Bold="True" Font-Size="Medium"></asp:Label></b>
                                                    </td>
                                                    <td>
                                                        <b>Fecha:
                                                            <asp:Label ID="lblFecha" runat="server" ForeColor="White" Font-Bold="True" Font-Size="Medium"></asp:Label></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <hr style="width: 100%; color: white" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Comprador:</b>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="LblCompador" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Email-Comprador:</b>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="LblEmailComprador" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Teléfono:</b>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="LblTelComprador" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Liberador por:</b>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="LlblLiberado" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Cond. compra:</b>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Label ID="LblCondCompra" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 188px">
                                                        <b>Aclaración sobre la cond.
                                                            <br />
                                                            de compra:&nbsp;</b>
                                                    </td>
                                                    <td valign="top" align="left">
                                                        <asp:Label ID="LblAclaracion" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <br />
                                    </td>
                                    <td style="width: 421px" valign="top" align="center" colspan="1">
                                        <table class="t1" width="99%">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 75px; height: 15px">
                                                        <b>Proveedor:&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000; height: 15px" align="left">
                                                        <asp:Label ID="LblProveedor" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px; height: 15px">
                                                        <b>Direeción:&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000" align="left">
                                                        <asp:Label ID="LblDirecProveedor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px">
                                                        <b>Localidad:&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000" align="left">
                                                        <asp:Label ID="LblLocacProveedor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px">
                                                        <b>Provincia:&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000" align="left">
                                                        <asp:Label ID="LblProvProveedor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px">
                                                        <b>Teléfono:&nbsp;&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000; height: 18px" align="left">
                                                        <asp:Label ID="LblTelProvredor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px">
                                                        <b>E-mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px; color: #000000" align="left">
                                                        <asp:Label ID="LblEmailProvredor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="color: #000000">
                                                    <td style="width: 75px; height: 15px">
                                                        <b>Cond Iva:&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px" align="left">
                                                        <asp:Label ID="LblIVAProvredor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 75px">
                                                        <b>CUIT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
                                                    </td>
                                                    <td style="width: 200px" align="left">
                                                        <asp:Label ID="LblCuitProvredor" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 75px">
                                                        <strong>Contacto:</strong>
                                                    </td>
                                                    <td style="width: 200px" align="left">
                                                        <asp:Label ID="LblContacto" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style="width: 35%" valign="top" align="center" colspan="3">
                                        <table class="t1" width="99%">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 129px; height: 15px">
                                                        <strong>Obras</strong>
                                                    </td>
                                                    <td style="height: 15px" align="left">
                                                        <asp:Label ID="lblObra" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 5px" colspan="2">
                                                        <hr style="width: 100%; color: white" />
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 129px; height: 15px">
                                                        <strong>Moneda :</strong>
                                                    </td>
                                                    <td style="height: 15px" align="left">
                                                        <asp:Label ID="LblMoneda" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 129px">
                                                        <strong>Nro. Compratativa</strong>
                                                    </td>
                                                    <td valign="top" align="left">
                                                        <asp:Label ID="LblNroComparativa" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 129px; height: 15px">
                                                        <strong>Observaciones :</strong>
                                                    </td>
                                                    <td style="height: 15px" align="left">
                                                        <asp:Label ID="lblObservaciones" runat="server" ForeColor="White" Font-Bold="True"
                                                            EnableViewState="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style="width: 35%" valign="top" align="center" colspan="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:Panel ID="PanelGrillaPed" runat="server" CssClass="panelGrillaPed">
                                            <asp:GridView ID="GVPedidoItems" runat="server" AutoGenerateColumns="False" CssClass="t1"
                                                EnableViewState="False">
                                                <RowStyle Font-Bold="True" ForeColor="White"></RowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="NumeroItem" HeaderText="Item"></asp:BoundField>
                                                    <asp:BoundField DataField="Codigo" HeaderText="Codigo"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="Articulo">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Articulo") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Width="300px" Text='<%# Bind("Articulo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Cantidad" HeaderText="Cant."></asp:BoundField>
                                                    <asp:BoundField DataField="Unidad" HeaderText="Un."></asp:BoundField>
                                                    <asp:BoundField DataField="Precio" DataFormatString="{0:#,#.00}" HeaderText="Precio">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PorcentajeBonificacion" HeaderText="%Bn."></asp:BoundField>
                                                    <asp:BoundField DataField="ImporteBonificacion" DataFormatString="{0:#,#.00}" HeaderText="Bonif.">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PorcentajeIVA" HeaderText="% IVA"></asp:BoundField>
                                                    <asp:BoundField DataField="ImporteIVA" DataFormatString="{0:#,#.00}" HeaderText="Imp.IVA">
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ImporteTotalItem" DataFormatString="{0:#,#.00}" HeaderText="Total">
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Observaciones">
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" Text='<%# Bind("Observaciones") %>' ID="TextBox2"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Width="200px" Text='<%# Bind("Observaciones") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Cumplido" HeaderText="Cum"></asp:BoundField>
                                                    <asp:TemplateField HeaderText="F.Entrega" SortExpression="Fecha entrega">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaEntrega", "{0:d}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="F.Necesidad" SortExpression="Fecha necesidad">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaNecesidad", "{0:d}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="header"></HeaderStyle>
                                            </asp:GridView>
                                        </asp:Panel>
                                        &nbsp;&nbsp;
                                    </td>
                                    <td colspan="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 68px; height: 5px">
                                    </td>
                                    <td style="width: 18px; height: 5px">
                                    </td>
                                    <td style="width: 421px; height: 5px">
                                    </td>
                                    <td style="width: 305px; height: 5px" align="right">
                                        <strong>Subtotal :</strong>
                                    </td>
                                    <td style="width: 176px; height: 5px" align="right">
                                        <asp:Label ID="lblSubtotal" runat="server" ForeColor="White" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td style="width: 249px; height: 5px">
                                    </td>
                                    <td style="width: 249px; height: 5px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 68px; height: 13px">
                                    </td>
                                    <td style="width: 18px; height: 13px">
                                    </td>
                                    <td style="width: 421px; height: 13px">
                                    </td>
                                    <td style="width: 305px; height: 13px" align="right">
                                        <strong>IVA :</strong>
                                    </td>
                                    <td style="width: 176px; height: 13px" align="right">
                                        <asp:Label ID="lblIVA" runat="server" ForeColor="White" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td style="width: 249px; height: 13px">
                                    </td>
                                    <td style="width: 249px; height: 13px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 68px; height: 5px">
                                    </td>
                                    <td style="width: 18px; height: 5px">
                                    </td>
                                    <td style="width: 421px; height: 5px">
                                    </td>
                                    <td style="width: 305px; height: 5px" align="right">
                                        <strong>Impuestos internos :</strong>
                                    </td>
                                    <td style="width: 176px; height: 5px" align="right">
                                        <asp:Label ID="lblImpInt" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                    </td>
                                    <td style="width: 249px; height: 5px" align="left">
                                    </td>
                                    <td style="width: 249px; height: 5px" align="left">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 68px; height: 5px">
                                    </td>
                                    <td style="width: 18px; height: 5px">
                                    </td>
                                    <td style="width: 421px; height: 5px">
                                    </td>
                                    <td style="width: 305px; height: 5px" align="right">
                                        <strong>TOTAL PEDIDO&nbsp;:</strong>
                                    </td>
                                    <td style="width: 176px; height: 5px" align="right">
                                        <asp:Label ID="lblMon4" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" ForeColor="White" Font-Bold="True" EnableViewState="False"></asp:Label>
                                    </td>
                                    <td style="width: 249px; height: 5px" align="left">
                                    </td>
                                    <td style="width: 249px; height: 5px" align="left">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <!-- End Pedido -->
    <!-- Requerimiento -->
    <div style="display: none; visibility: hidden; left: 0px; width: 500px; position: absolute;
        top: 600px; height: 400px;" id="RequerimientoData">
    </div>
    <asp:Panel ID="PanelReq" runat="server" Visible="false">
        <div onmousedown="dragStart(event,'RequerimientoData')">
            <table style="background-color: #507cbb" class="t1" cellspacing="0" cellpadding="0"
                width="100%">
                <tbody>
                    <tr>
                        <td style="font-weight: bold; color: white; height: 21px; background-color: blue"
                            align="left">
                            Requerimiento de materiales
                        </td>
                        <td style="font-weight: bold; color: white; height: 21px; background-color: blue"
                            align="right">
                            <a href="#" onclick="javascript:closeReq();return false;">
                                <img height="16" src="../../Imagenes/action_delete.png" alt="Cerrar" border="0" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" align="center" colspan="2" rowspan="5">
                            <table style="border-right: thin solid; border-top: thin solid; border-left: thin solid;
                                border-bottom: thin solid" width="100%">
                                <tbody>
                                    <tr>
                                        <td style="font-weight: bold; width: 105px; height: 15px" align="right">
                                            Nro. Req:
                                        </td>
                                        <td style="width: 200px; color: #000000; height: 15px" align="left">
                                            <asp:Label ID="lblNumero2" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; width: 180px; color: #000000; height: 15px" align="right">
                                            Fecha:&nbsp;
                                        </td>
                                        <td style="width: 155px; color: #000000; height: 15px" align="left">
                                            <asp:Label ID="lblFecha2" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; width: 105px; height: 15px" align="right">
                                            Obra:
                                        </td>
                                        <td style="width: 200px; color: #000000; height: 15px" align="left">
                                            <asp:Label ID="lblObra2" runat="server" Font-Bold="True" ForeColor="White" align="right"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; width: 180px; color: #000000; height: 15px" align="right">
                                            Confecciono:&nbsp;
                                        </td>
                                        <td style="width: 155px; color: #000000; height: 15px" align="left">
                                            <asp:Label ID="lblConfecciono" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; width: 105px" align="right">
                                            &nbsp;Sector:
                                        </td>
                                        <td style="width: 200px" align="left">
                                            <asp:Label ID="lblSector" runat="server" Font-Bold="True" ForeColor="White" align="right"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; width: 180px; color: #000000" align="right">
                                            &nbsp; Lugar entrega:&nbsp;
                                        </td>
                                        <td style="width: 155px" align="left">
                                            <asp:Label ID="LblLugarEntrega" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; width: 105px" align="right">
                                            &nbsp;Liberada por:
                                        </td>
                                        <td style="width: 200px" align="left">
                                            <asp:Label ID="LblLiberada" runat="server" Font-Bold="True" ForeColor="White" align="right"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; width: 180px" align="right">
                                            Equipo destino:&nbsp;
                                        </td>
                                        <td style="width: 155px" align="left">
                                            <asp:Label ID="LblEqDestino" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; width: 105px" align="right">
                                            &nbsp;Fecha de lib:
                                        </td>
                                        <td style="width: 200px" align="left">
                                            <asp:Label ID="LblFechaLib" runat="server" Font-Bold="True" ForeColor="White" align="right"></asp:Label>
                                        </td>
                                        <td style="font-weight: bold; width: 180px" align="right">
                                        </td>
                                        <td style="width: 155px">
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; width: 105px" align="right">
                                            Detalle:
                                        </td>
                                        <td align="left" colspan="3">
                                            <asp:Label ID="LblDetalle" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td style="font-weight: bold; height: 40px" valign="top" align="right" colspan="2">
                                            Observaciones generales:&nbsp;
                                        </td>
                                        <td style="font-weight: bold; height: 40px" align="left" colspan="2" valign="top">
                                            <asp:Label ID="LblObs" runat="server" align="right" Font-Bold="True" ForeColor="White"
                                                Height="40px" Width="215px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="color: #000000">
                                        <td align="center" colspan="4">
                                            <asp:Panel ID="PanelGrillaReq" runat="server" CssClass="panelGrilla">
                                                <asp:GridView AutoGenerateColumns="False" CssClass="t1" EnableViewState="False" ID="GVRequerimientoItems"
                                                    runat="server">
                                                    <RowStyle Font-Bold="True" ForeColor="White" />
                                                    <Columns>
                                                        <asp:BoundField DataField="Codigo" HeaderText="C&#243;digo" />
                                                        <asp:TemplateField HeaderText="Articulo">
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Articulo") %>' Width="300px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Observaciones">
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Observaciones") %>' Width="200px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                                                        <asp:BoundField DataField="Unidad" HeaderText="Un." />
                                                        <asp:TemplateField HeaderText="FechaEntrega" SortExpression="Fecha entrega">
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("FechaEntrega", "{0:d}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Cumplido" HeaderText="Cum." />
                                                    </Columns>
                                                    <HeaderStyle CssClass="header" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </asp:Panel>
    <!-- END Requerimiento-->
    
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
