<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="NotasDePedido.aspx.cs" Inherits="NotasDePedido" Title="Pronto Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="Proveedor" 
        ForeColor="White"></asp:Label><asp:GridView
        ID="gridComprobantes" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" GridLines="Horizontal" OnPageIndexChanging="gridComprobantes_PageIndexChanging"
        OnSelectedIndexChanged="gridComprobantes_SelectedIndexChanged" OnSorted="gridComprobantes_Sorted"
        OnSorting="gridComprobantes_Sorting" Width="419px">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
        <asp:TemplateField HeaderText="Numero" ControlStyle-Width="100" SortExpression="Pedido">
            <ItemTemplate>
                <asp:LinkButton ID="lbPedido" runat="server" OnCommand="lbPedido_Command" CommandArgument='<%# Eval("Pedido") %>' PostBackUrl="DocumentoWord.aspx" Enabled="true"> 
                <asp:Image runat="server" ImageUrl="Printer.png"/> <%# Eval("Pedido") %> </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" SortExpression="Fecha" HtmlEncode="False" />
            <asp:BoundField DataField="Bonificacion" DataFormatString="${0:C}" HeaderText="Bonificacion"
                SortExpression="Bonificacion" />
            <asp:BoundField DataField="NetoGravado" DataFormatString="${0:C}" HeaderText="Neto Gravado"
                SortExpression="NetoGravado" />
            <asp:BoundField DataField="TotalIva" DataFormatString="${0:C}" HeaderText="Total Iva"
                SortExpression="TotalIva" />
            <asp:BoundField ApplyFormatInEditMode="True" DataField="TotalPedido" DataFormatString="${0:C}"
                HeaderText="Total Pedido" SortExpression="TotalPedido" />
            <asp:BoundField DataField="Moneda" HeaderText="Moneda" SortExpression="Moneda" />
            <asp:BoundField DataField="Items" HeaderText="Cantidad Items" SortExpression="Items" />
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    
    <asp:HiddenField ID="pedido" runat="server" EnableViewState="true" />
</asp:Content>

