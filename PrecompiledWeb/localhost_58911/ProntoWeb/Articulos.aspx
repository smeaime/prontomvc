<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Articulos, App_Web_bvot1ars" title="Articulos" theme="Azul" %>


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <div> 
        <asp:Button ID="lnkNuevo" runat="server" Font-Bold="false" Font-Underline="False"
            Width="120" Height="30" CssClass="but" ForeColor="White" CausesValidation="true"
            Font-Size="Small" Style="vertical-align: middle" Text="+ Nuevo" />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtBuscar" runat="server" Style="" Text="" AutoPostBack="True "
         Width="200"
          Font-Size="Small"  CssClass="txtBuscar"></asp:TextBox>
        <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                    WatermarkText="Buscar en artículos" WatermarkCssClass="watermarkedBuscar" />

        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
            margin-left: 0px;" Width="119px" Height="22px">
            <asp:ListItem Text="Codigo" Value="Codigo" />
            <asp:ListItem Text="Descripcion" Value="Descripcion" Selected="True" />
            <asp:ListItem Text="Rubro" Value="Rubro" />
            <asp:ListItem Text="Subrubro" Value="Subrubro" />
        </asp:DropDownList>
    </div>
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
              <table width="700" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left">
                        <div style="width: 850px; overflow: auto;">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CellPadding="3" DataKeyNames="Id" EnableSortingAndPagingCallbacks="True" PageSize="12"
                GridLines="None">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <%--            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" />--%>
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Rubro" HeaderText="Rubro">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Subrubro" HeaderText="Subrubro">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>



                    <asp:BoundField DataField="RegistrarStock" HeaderText="Registra stock">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>

                    <%--<asp:BoundField DataField="Stock rep_" HeaderText="Stock rep."         />--%>
                   <%-- <asp:BoundField DataField="Nro_inv_" HeaderText="Nro inv."         />--%>
                   <%-- <asp:BoundField DataField="% IVA" HeaderText="% IVA"         />
                    <asp:BoundField DataField="Costo PPP" HeaderText="Costo PPP"         />
                    <asp:BoundField DataField="Costo PPP u$s" HeaderText="Costo PPP u$s"         />
                    <asp:BoundField DataField="Costo Rep_" HeaderText="Costo Rep"         />
                    <asp:BoundField DataField="Costo Rep u$s" HeaderText="Costo Rep u$s"         />--%>
                    
               
                    <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" />
                    <%--            <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Localidad" HeaderText="Localidad" SortExpression="Localidad" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Provincia" HeaderText="Provincia" SortExpression="Provincia" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>--%>
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
             </div>
                    </td>
                </tr>
            </table>
            <%--                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ArticuloManager" DeleteMethod="Delete">
                    <selectparameters>
                    
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </selectparameters>
                               <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                </asp:ObjectDataSource>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
