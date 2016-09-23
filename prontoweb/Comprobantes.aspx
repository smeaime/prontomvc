<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Comprobantes.aspx.cs" Inherits="Comprobantes" Title="Pronto Web" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="Proveedor" 
        ForeColor="White"></asp:Label>
    <asp:GridView ID="gridComprobantes" runat="server" AllowPaging="True" AllowSorting="False"
        AutoGenerateColumns="False" CellPadding="3" GridLines="Horizontal"
        OnSorted="gridComprobantes_Sorted" Width="419px" OnSelectedIndexChanged="gridComprobantes_SelectedIndexChanged" OnPageIndexChanging="gridComprobantes_PageIndexChanging" OnSorting="gridComprobantes_Sorting" BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
            <asp:BoundField DataField="TipoComprobante" HeaderText="Tipo" SortExpression="TipoComprobante" />
            <asp:BoundField DataField="NumeroComprobante" HeaderText="Numero" SortExpression="NumeroComprobante" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" />
            <asp:BoundField DataField="Debe" HeaderText="Debe" SortExpression="Debe" DataFormatString="${0:C}" />
            <asp:BoundField DataField="Haber" HeaderText="Haber" SortExpression="Haber" DataFormatString="${0:C}" />
            <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" DataFormatString="${0:C}" />
            <asp:BoundField DataField="FechaComprobante" HeaderText="Fecha Comprobante" SortExpression="FechaComprobante" ApplyFormatInEditMode="True" />
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
</asp:Content>

