<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Buscador, App_Web_d4k2rr1t" title="Buscador" theme="Azul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" Font-Underline="False"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
                Visible="false">+   Nuevo</asp:LinkButton>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
            <asp:TextBox ID="txtBuscar" runat="server" Visible="False" Style="text-align: right;
                background-image: url(imagenes/lupita.jpg); background-position: right; background-repeat: no-repeat;"
                Text="" AutoPostBack="True"></asp:TextBox>
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" Height="22px" Visible="False">
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Fecha" Value="[Fecha ComprobantePrv]" />
                <asp:ListItem Text="Cliente" Value="Cliente" />
                <asp:ListItem Text="Anulada" Value="Anulada" />
                <asp:ListItem Text="Total" Value="Total" />
            </asp:DropDownList>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            
<%--            agregar filtro--%>
            
            <br />
            <br />
            <br />
            <table width="700" style="font-size: medium">
                <tr>
                    <td align="left">
                        <div style="width: 700px; overflow: auto;">
                            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#507CBB"
                                BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="ObjectDataSource1"
                                GridLines="Horizontal" AllowPaging="true" Width="700px" PageSize="30" AutoGenerateColumns="false"
                                EmptyDataText="No se encontraron resultados">
                                
                                <Columns>
                                                        <asp:CommandField ShowEditButton="True" EditText="Ver" />

                                    
                                    <asp:TemplateField HeaderText="Numero">
                                        <ItemStyle Width="120px" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:Label ID="Numero" Text='<%# HighlightText(Eval("Numero")) %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
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
                                    </asp:TemplateField>


                                    <asp:BoundField  DataField="ID" />
                                    <asp:BoundField  DataField="Numero" />
                                    <asp:BoundField  DataField="Tipo" />
                                    <asp:BoundField  DataField="Fecha" />
                                    <asp:BoundField  DataField="item1" />
                                    

                                    <%--

     
      
      
--%>
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
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ComprobanteProveedorManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="txtFechaDesde" Name="dtDesde" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtFechaHasta" Name="dtHasta" PropertyName="Text"
                        Type="DateTime" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobantePrv" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobantePrv" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.ComprobanteProveedorManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobantePrv" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobantePrv" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    
    <style type="text/css">
   .highlight {text-decoration: none;color:black;background:yellow;}
</style>
    
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/ComprobantePrvs" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\ComprobantePrvs.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
</asp:Content>
