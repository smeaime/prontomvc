<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Proveedores, App_Web_g424db5w" title="Untitled Page" theme="Azul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
                  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
    <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" 
        Font-Underline="False" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="30px" Width="95px">+   Nuevo</asp:LinkButton>
    
    <asp:TextBox ID="txtBuscar" runat="server" 
        style="text-align: right; " Text="buscar" AutoPostBack="True"></asp:TextBox> 
    


    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
        CellPadding="3" DataKeyNames="Id" DataSourceID="ObjectDataSource1" 
            GridLines="Horizontal" EnableSortingAndPagingCallbacks="True" PageSize="20">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" />
            <asp:BoundField DataField="RazonSocial" HeaderText="RazonSocial" SortExpression="RazonSocial" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Localidad" HeaderText="Localidad" SortExpression="Localidad" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Provincia" HeaderText="Provincia" SortExpression="Provincia" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ProveedorManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="HFSC" runat="server" />
 </ContentTemplate></asp:UpdatePanel>
</asp:Content>

