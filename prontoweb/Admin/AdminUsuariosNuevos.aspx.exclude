<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AdminUsuariosNuevos.aspx.cs" Inherits="AdminUsuariosNuevos" Title="Pronto Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp; &nbsp; &nbsp;&nbsp;
    <table style="width: 591px">
        <tr>
            <td style="width: 576px">
    <asp:CheckBox ID="CheckBox2" runat="server" Text="Borra todas las cuentas de Proveedores existentes y las crea nuevamente" /></td>
        </tr>
        <tr>
            <td style="width: 576px">
    <asp:CheckBox ID="CheckBox1" runat="server" Text="Envía email al Proveedor (si no semarca esta casilla envía sólo al Administrador del sistema)" /></td>
        </tr>
        <tr>
            <td style="width: 576px">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Crear usuarios de la base de Proveedores" Width="322px" /></td>
        </tr>
    </table>
                    <asp:GridView ID="grdUsuariosNuevos" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AllowSorting="True" Width="591px" AllowPaging="True" OnPageIndexChanging="grdUsuariosNuevos_PageIndexChanging" OnSelectedIndexChanged="grdUsuariosNuevos_SelectedIndexChanged" OnSorted="grdUsuariosNuevos_Sorted" OnSorting="grdUsuariosNuevos_Sorting" PageSize="20">
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="Username" HeaderText="Nombre de Usuario" SortExpression="Username" />
                            <asp:BoundField DataField="Email" HeaderText="E-mail" SortExpression="Email" />
                            <asp:BoundField DataField="CreationDate" HeaderText="Fecha de creaci&#243;n" DataFormatString="{0:dd/MM/yyyy}" SortExpression="CreationDate" />
                        </Columns>
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
    &nbsp;
</asp:Content>

