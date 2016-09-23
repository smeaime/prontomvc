<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Asientos.aspx.vb" Inherits="Asientos" Title="Asientos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" Font-Underline="False"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
                Visible="true">+   Nuevo</asp:LinkButton>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: left; background-image: url(imagenes/lupita.jpg);
                background-position: right; background-repeat: no-repeat;" Text="" AutoPostBack="True"  BorderStyle="None" ></asp:TextBox>
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" >
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Fecha" Value="[Fecha Asiento]" />
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
            <table width="700">
                <tr>
                    <td align="left">
                        <div style="width: 700px; overflow: auto;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderColor="#507CBB"
                                BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="ObjectDataSource1"
                                GridLines="Horizontal" AllowPaging="True" Width="700px" PageSize="8">
                                <Columns>
                                    <asp:CommandField ShowEditButton="True" EditText="Ver" />
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <%--<asp:BoundField DataField="A/B/E" HeaderText="" />--%>
                                    <%--            <asp:BoundField DataField="Pto_vta_" HeaderText="" />
--%>
                                    <%--Eval("A/B/E") & " "& "-" &--%>
                                    <%--<asp:BoundField DataField="Tipo comp_" HeaderText="Tipo" />--%>
                                    <%--"Id, Numero asiento, IdAsi, Fecha asiento, Tipo, Subdiario, Apertura, Concepto, Total debe, Total haber, Diferencia, Ingreso, Fecha ingreso, Modifico, Fecha ult_mod_, Vector_T, Vector_X, "--%>
                                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("[Numero asiento]") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("[Numero asiento]")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
    <%--                                <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                                    <asp:BoundField DataField="Apertura" HeaderText="Apertura" />
    --%>                                <asp:BoundField DataField="Concepto" HeaderText="Concepto"  ItemStyle-Wrap=false/>
                                    <asp:BoundField DataField="Total debe" HeaderText="Total debe" />
                                    <asp:BoundField DataField="Total haber" HeaderText="Total haber" />
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("[Fecha asiento]") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Fecha asiento]", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--     <asp:BoundField DataField="Proveedor / Cuenta" HeaderText="Proveedor / Cuenta" />
                                  --%>
                                    <%--                                    <asp:BoundField DataField="Proveedor FF" HeaderText="Proveedor FF" />
--%>
                                    <%--& Eval("[]") --%>
                                    <%--<asp:BoundField DataField="Anulada" HeaderText="Anulada" />--%>
                                    <%-- <asp:BoundField DataField="Total Asiento" HeaderText="Total" />--%>
                                    <%--            <asp:BoundField DataField="Anulada" HeaderText="Anulada" />--%>
                                    <%--            <asp:TemplateField HeaderText="Obra" SortExpression="Obra">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1" DataTextField="Titulo" DataValueField="IdObra" SelectedValue='<%# Bind("IdObra") %>'>
                    </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ObraManager"></asp:ObjectDataSource>
                </EditItemTemplate>
                <ItemStyle Wrap="True" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Obra") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC"
                                                BorderStyle="None" BorderWidth="1px" ShowHeader="False" Width="300" CellPadding="3">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="left">
                                                        <ItemStyle Wrap="True" Width="200" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("Detalle de cuenta") %>'>
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="Imputaciones" HeaderStyle-HorizontalAlign="left">
                            <ItemStyle Wrap="True" Width="300" />
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("TipoComprobanteImputado") &  "-" &  Eval("NumeroComprobanteImputado")  %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                                                    <%--                          <asp:BoundField DataField="IdImputacion" HeaderText="Imputacion"   ItemStyle-Width="300" >
                                <ItemStyle Font-Size="X-Small" Wrap="False" />
                                <HeaderStyle Font-Size="X-Small" />
                            </asp:BoundField>--%>
                                                    <asp:BoundField DataField="Debe" HeaderText="Debe">
                                                        <ItemStyle Font-Size="X-Small" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Haber" HeaderText="Haber">
                                                        <ItemStyle Font-Size="X-Small" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <RowStyle ForeColor="#000066" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ControlStyle BorderStyle="None" />
                                    </asp:TemplateField>
                                    <%-- <asp:BoundField DataField="Condicion IVA" HeaderText="Condicion IVA" />--%>
                                    <%--

            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
            <asp:BoundField DataField="Cod_Cli_" HeaderText="Cod cli" />
            <asp:BoundField DataField="Mon_" HeaderText="Mon." />
            <asp:BoundField DataField="Deudores" HeaderText="Deudores" />
            <asp:BoundField DataField="Total valores" HeaderText="Total valores" />
            <asp:BoundField DataField="Ret_IVA" HeaderText="RetIVA" />
            <asp:BoundField DataField="Ret_Ganancias" HeaderText="RetGanancias" />
            <asp:BoundField DataField="Otros conceptos" HeaderText="Otros conceptos" />
            <asp:BoundField DataField="Ingreso" HeaderText="Ingreso" />
            <asp:BoundField DataField="Fecha ingreso" HeaderText="Fecha ingreso" />
            <asp:BoundField DataField="Modifico" HeaderText="Modifico" />
            <asp:BoundField DataField="Fecha modif_" HeaderText="Fecha modif" />
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" />
            <asp:BoundField DataField="Cobrador" HeaderText="Cobrador" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />--%>
                                    <%--            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
--%>
                                </Columns>
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                                <%--                                <AlternatingRowStyle  CssClass="TablaTransparente" />--%>
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
                    <asp:Parameter Name="myAsiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myAsiento" Type="Object" />
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
                    <asp:Parameter Name="myAsiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myAsiento" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/Asientos" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\Asientos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
</asp:Content>
