<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="ProntoWeb_Principal, App_Web_ujcp202p" title="Pronto Web" enableviewstate="False" theme="Azul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <center style="">
        <strong><span style=" font-size: 16pt; color: gray">Bienvenido</span></strong>
    </center>
    <br />
    <br />
    <br />
    <%--http://www.bestbusinesssoftware.info/accounting-billing-software/microsoft-office-accounting-express-2008/--%>
    <%--                   Informes      <asp:DropDownList ID="DropDownList2" runat="server" >
                       <asp:ListItem>Almacen</asp:ListItem>
                       <asp:ListItem>Compras</asp:ListItem>
        </asp:DropDownList>
                   <asp:DropDownList ID="DropDownList1" runat="server" >
                       <asp:ListItem>Vales Emitidos no Retirados</asp:ListItem>
                       <asp:ListItem>Notas de Pedido Pendientes</asp:ListItem>
                       <asp:ListItem>Requerimientos y Listas de Acopio</asp:ListItem>
        </asp:DropDownList>--%>
    <br />
    <br />
    <table width="700">
        <tr>
            <td align="left">
                <div style="width: 850px; overflow: auto;">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" BackColor="White"
                        DataKeyNames="Id,Tipo" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
                        CellPadding="3" GridLines="Horizontal" AllowPaging="false" Width="99%" PageSize="8"
                        Visible="false">
                        <Columns>
                            <asp:CommandField ShowEditButton="True" EditText="Ver" HeaderStyle-HorizontalAlign="Left"
                                HeaderText="Actividad reciente " />
                            <asp:TemplateField>
                                <ItemStyle Width="120px" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="tipo" Text='<%# Eval("Tipo") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Numero">
                                <ItemStyle Width="120px" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="Numero" Text='<%# Eval("Numero") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="A/B/M">
                                <ItemStyle Width="120px" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%--  <asp:Label ID="Numero" Text='<%# HighlightText(Eval("Numero")) %>' runat="server" />--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Usuario">
                                <ItemStyle Width="120px" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%-- <asp:Label ID="Numero" Text='<%# HighlightText(Eval("Numero")) %>' runat="server" />--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha" HeaderStyle-HorizontalAlign="Right">
                                <ItemStyle Width="120px" HorizontalAlign="right" />
                                <ItemTemplate>
                                    <asp:Label ID="Fecha" Text='<%#   Eval( "Fecha", "{0:d MMM}" )  %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--      <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                </Columns>
                                                <RowStyle ForeColor="#000066" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ControlStyle BorderStyle="None" />
                                    </asp:TemplateField>--%>
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                </div>
            </td>
        </tr>
    </table>
    <table style="border-style: none; border-color: inherit; border-width: medium; width: 555px;
        height: 523px; display: none; visibility: hidden;" class="t1" cellpadding="4"
        cellspacing="5" align="center">
        <tr>
            <td style="width: 2049px; height: 5px;">
            </td>
            <td style="width: 6843px; height: 5px;">
            </td>
            <td style="height: 5px;" colspan="2">
            </td>
            <td style="height: 5px;" colspan="4">
            </td>
            <td style="height: 5px; width: 85px;">
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="White">Nueva RM</asp:LinkButton>
            </td>
            <td style="width: 6843px; height: 24px;">
            </td>
            <td style="border: thin groove #000000; height: 67px; width: 2193px;" align="center">
                <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White">Nueva Solicitud</asp:LinkButton>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="center" valign="bottom" colspan="2" style="height: 24px">
            </td>
            <td style="width: 243px; height: 24px;">
            </td>
            <td style="height: 24px;">
            </td>
            <td style="width: 85px; height: 24px;">
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 71px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 70px; height: 59px" />
            </td>
            <td style="height: 71px; width: 6843px;">
            </td>
            <td style="height: 71px;" align="right" colspan="2" class="style7">
                &nbsp;<img src="../Imagenes/Bottom-arrow-48-con%20derecha.png" style="width: 64px;
                    height: 55px" />
            </td>
            <td style="border: thin groove #000000; height: 71px; width: 672px;" align="center">
                <asp:LinkButton ID="LinkButton4" runat="server" ForeColor="White">Nueva Comparativa</asp:LinkButton>
            </td>
            <td style="height: 71px; width: 460px;">
            </td>
            <td class="style7" style="height: 71px;" colspan="2">
            </td>
            <td class="style7" style="height: 71px; width: 85px;">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: thin groove #000000; height: 94px;" align="center">
                <asp:LinkButton ID="LinkButton2" runat="server" ForeColor="White">Asignar Requerimientos Pendientes</asp:LinkButton>
            </td>
            <td colspan="4" style="height: 94px" align="center">
                <img src="../Imagenes/Right-arrow-48.png" style="width: 111px; height: 72px" />
            </td>
            <td colspan="3" style="border: thin groove #000000; height: 94px;" align="center">
                <asp:LinkButton ID="LinkButton5" runat="server" ForeColor="White">Nuevo Pedido</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 29px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 65px; height: 48px" alt="esq" />
            </td>
            <td style="height: 29px;" align="center" colspan="3">
                <img src="../Imagenes/Top-arrow-48%20esquina%20derecha.png" style="width: 75px; height: 43px"
                    alt="esq" />
            </td>
            <td style="border: thin groove #000000; height: 67px; width: 672px;" align="center">
                Nueva Recepcion
            </td>
            <td style="width: 460px" />
            <td colspan="2" style="height: 29px">
                <img src="../Imagenes/Top-arrow-48%20esquina%20derecha2.png" style="width: 51px;
                    height: 50px" />
            </td>
            <td style="height: 29px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 50px; height: 49px" />
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                Nuevo Vale
            </td>
            <td style="height: 67px;" colspan="4" align="center">
                &nbsp;
            </td>
            <td style="height: 67px; width: 460px;">
            </td>
            <td>
            </td>
            <td>
            </td>
            <td style="border: thin groove #000000; width: 85px; height: 67px;" align="center">
                Nuevo Comprobante de Proveedor
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 34px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 59px; height: 48px" />
            </td>
            <td style="width: 6843px; height: 34px;">
            </td>
            <td style="height: 34px;" colspan="2">
            </td>
            <td style="height: 34px;" colspan="4">
            </td>
            <td style="width: 85px; height: 34px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 48px; height: 48px" />
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 51px;" align="center" />
            Nueva Salida de Material
            <td style="width: 6843px; height: 51px;">
                <td style="height: 51px;" colspan="2">
                </td>
                <td style="height: 51px;" align="center" colspan="4">
                </td>
                <td style="border: thin groove #000000; width: 85px; height: 51px; font-weight: bold;"
                    align="center">
                    Nueva Orden de Pago
                </td>
        </tr>
    </table>
    <br />
    <div style="visibility: hidden; display: none;">
        <table style="width: 565px; height: 111px;" class="t1" cellpadding="5" cellspacing="5">
            <tr>
                <td style="width: 100px">
                    Nuevo Proveedor
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Buscar Proveedor
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <asp:Button ID="Button1" runat="server" Text="Test Firmas" />
        <asp:Button ID="Button2" runat="server" Text="Test FF" />
        <asp:Button ID="Button3" runat="server" Text="Test Cotiz" />
        <asp:Button ID="Button8" runat="server" Text="Todos" />
    </div>
    <asp:Panel ID="panelcito"  runat="server" Visible="false">
        <asp:Button ID="Button4" runat="server" Text="Importar Articulos" />
        <asp:Button ID="Button5" runat="server" Text="Importar Establecimientos Grobo" />
        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" 
            CompleteBackColor="Lime" ErrorBackColor="Red" />
    </asp:Panel>
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
