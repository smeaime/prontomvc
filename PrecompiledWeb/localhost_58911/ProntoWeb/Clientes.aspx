<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Clientes, App_Web_n3o5dvs1" title="Clientes" theme="Azul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<br />
<br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="false" CssClass="butCrear but"
                Font-Underline="False" ForeColor="White" CausesValidation="true" Font-Size="Small">+ Nuevo Cliente</asp:LinkButton>
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" Height="22px">
                <asp:ListItem Text="Razon Social" Value="[Razon Social]" Selected="True" />
                <asp:ListItem Text="Direccion" Value="Direccion" />
                <asp:ListItem Text="CUIT" Value="CUIT" />
                <asp:ListItem Text="Localidad" Value="Localidad" />
                <asp:ListItem Text="Provincia" Value="Provincia" />
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList1" runat="server" Style="text-align: right; margin-left: 0px;"
                Width="119px" Height="22px" AutoPostBack="True">
                <asp:ListItem Text="Normales" Value="[Razon Social]" Selected="True" />
                <asp:ListItem Text="Provisorios" Value="Provisorios" />
            </asp:DropDownList>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table width="700">
                        <tr>
                            <td align="left">
                                <div style="width: 850px; overflow: auto;">
                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BorderStyle="None" 
                                        CellPadding="3" DataKeyNames="Id" Width="99%" GridLines="none" EnableSortingAndPagingCallbacks="True"
                                        PageSize="20">
                                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                        <Columns>
                                            <asp:CommandField ShowEditButton="True" />
                                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                                SortExpression="Id" />
                                            <%--<asp:BoundField DataField="Razon Social" HeaderText="RazonSocial" SortExpression="Razon Social">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>--%>
                                          
                                          <asp:BoundField DataField="RazonSocial" HeaderText="RazonSocial" SortExpression="RazonSocial">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>

                                            <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                          
                                            <asp:BoundField DataField="CUIT" HeaderText="CUIT" SortExpression="Direccion">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Localidad" HeaderText="Localidad" SortExpression="Localidad">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Provincia" HeaderText="Provincia" SortExpression="Provincia">
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" />
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
                </ContentTemplate>
            </asp:UpdatePanel>
            <%--    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ClienteManager" DeleteMethod="Delete">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
        </SelectParameters>
                       <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
    </asp:ObjectDataSource>--%>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
