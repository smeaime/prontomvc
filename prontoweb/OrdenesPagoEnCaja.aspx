<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OrdenesPagoEnCaja.aspx.cs" Inherits="OrdenesPagoEnCaja" Title="Pronto Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="Proveedor" 
        ForeColor="White"></asp:Label>
        
        
        <asp:GridView
        ID="gridComprobantes" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White"  BorderStyle="None" BorderWidth="1px"
        CellPadding="3" GridLines="Horizontal" OnPageIndexChanging="gridComprobantes_PageIndexChanging"
        OnSelectedIndexChanged="gridComprobantes_SelectedIndexChanged" OnSorted="gridComprobantes_Sorted"
        OnSorting="gridComprobantes_Sorting" Width="419px"
        
        
        BorderColor="#507CBB"   

        
        >
        
                
        
        
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
            <asp:BoundField DataField="IdOrdenPago" HeaderText="Numero" SortExpression="IdOrdenPago" />
            <asp:BoundField DataField="Fecha Pago" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" SortExpression="Fecha Pago" HtmlEncode="False" />
            <asp:BoundField DataField="Documentos" DataFormatString="${0:C}" HeaderText="Documento"
                SortExpression="Documentos" />
            <asp:BoundField DataField="Acreedores" DataFormatString="${0:C}" HeaderText="Acreedores"
                SortExpression="Acreedores" />
                
            <asp:TemplateField  HeaderText="Retenci&#243;n IVA" SortExpression="RetIVA">
                <ItemTemplate>
                    <asp:Label ID="Label44" runat="server" Text='<%# "$" + Eval("RetIVA") %>' Visible='<%# !GetVisibility(Eval("RetIVA"))%>' />
                        <table>
                            <tr>
                                <td valign="middle">
                                    <asp:LinkButton ID="Label2" runat="server" Visible='<%# GetVisibility(Eval("RetIVA"))%>'  
                                    PostBackUrl='<%# "CertificadoIVA.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Label ID="Label3" runat="server" Text='<%# "$" + Eval("RetIVA") %>' />
                                    </asp:LinkButton>
                                </td>
                                <td valign="middle">
                                    <asp:LinkButton ID="LinkButton1" runat="server" Visible='<%# GetVisibility(Eval("RetIVA"))%>'  
                                    PostBackUrl='<%# "CertificadoIVA.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Image ID="Image1" runat="server" ImageUrl="Printer.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                </ItemTemplate>
            </asp:TemplateField>
            
<%-- OnCommand='lbRetencion_Command' CommandArgument='<%# Eval("IdOrdenPago") %>'
--%>

            <asp:TemplateField HeaderText="Retenci&#243;n Ganancias" SortExpression="RetGan">
                <ItemTemplate>
                    <asp:Label ID="Label41" runat="server" Text='<%# "$" + Eval("RetGan") %>' Visible='<%# !GetVisibility(Eval("RetGan"))%>' />
                        <table>
                            <tr>
                                <td valign="middle">
                                    <asp:LinkButton ID="Label21" runat="server" Visible='<%# GetVisibility(Eval("RetGan"))%>'  
                                    PostBackUrl='<%# "CertificadoGanancias.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Label ID="Label31" runat="server" Text='<%# "$" + Eval("RetGan") %>' />
                                    </asp:LinkButton>
                                </td>
                                <td valign="middle">
                                    <asp:LinkButton ID="LinkButton11" runat="server" Visible='<%# GetVisibility(Eval("RetGan"))%>'  
                                    PostBackUrl='<%# "CertificadoGanancias.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Image ID="Image11" runat="server" ImageUrl="Printer.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Retenci&#243;n Ingresos Brutos" SortExpression="RetIngB">
                <ItemTemplate>
                    <asp:Label ID="Label42" runat="server" Text='<%# "$" + Eval("RetIngB") %>' Visible='<%# !GetVisibility(Eval("RetIngB"))%>' />
                        <table>
                            <tr>
                                <td valign="middle">
                                    <asp:LinkButton ID="Label22" runat="server" Visible='<%# GetVisibility(Eval("RetIngB"))%>'  
                                    PostBackUrl='<%# "CertificadoIngresosBrutos.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Label ID="Label32" runat="server" Text='<%# "$" + Eval("RetIngB") %>' />
                                    </asp:LinkButton>
                                </td>
                                <td valign="middle">
                                    <asp:LinkButton ID="LinkButton12" runat="server" Visible='<%# GetVisibility(Eval("RetIngB"))%>'  
                                    PostBackUrl='<%# "CertificadoIngresosBrutos.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Image ID="Image12" runat="server" ImageUrl="Printer.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Retenci&#243;n SUSS" SortExpression="RetSUSS">
                <ItemTemplate>
                    <asp:Label ID="Label43" runat="server" Text='<%# "$" + Eval("RetSUSS") %>' Visible='<%# !GetVisibility(Eval("RetSUSS"))%>' />
                        <table>
                            <tr>
                                <td valign="middle">
                                    <asp:LinkButton ID="Label23" runat="server" Visible='<%# GetVisibility(Eval("RetSUSS"))%>'  
                                    PostBackUrl='<%# "CertificadoSUSS.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Label ID="Label33" runat="server" Text='<%# "$" + Eval("RetSUSS") %>' />
                                    </asp:LinkButton>
                                </td>
                                <td valign="middle">
                                    <asp:LinkButton ID="LinkButton13" runat="server" Visible='<%# GetVisibility(Eval("RetSUSS"))%>'  
                                    PostBackUrl='<%# "CertificadoSUSS.aspx?idOP=" + Eval("IdOrdenPago") %>'>
                                        <asp:Image ID="Image13" runat="server" ImageUrl="Printer.png" />
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="Dev.F.F." DataFormatString="${0:C}" HeaderText="Gastos Generales"
                SortExpression="Dev.F.F." />
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    <asp:HiddenField ID="idOrdenPago" runat="server" EnableViewState="true" />
</asp:Content>

