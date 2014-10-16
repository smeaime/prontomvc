<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="OrdenesPago.aspx.vb" Inherits="OrdenesPago" Title="Ordenes de pago" %>

<%--<%@ Register Assembly="DevExpress.Web.ASPxGridView.v10.1, Version=10.1.5.0, Culture=neutral, PublicKeyToken=940CFCDE86F32EFD"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" Font-Underline="False"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
                Visible="true">+   Nuevo</asp:LinkButton>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" Height="22px">
                <asp:ListItem Value="[Cod]" Text="Cod" />
                <asp:ListItem Value="[Fecha Pago]" Text="Pago" />
                <asp:ListItem Value="[Tipo]" Text="Tipo" />
                <asp:ListItem Value="[Estado]" Text="Estado" />
                <asp:ListItem Value="[Proveedor]" Text="Proveedor" />
                <asp:ListItem Value="[Cuenta]" Text="Cuenta" />
                <asp:ListItem Value="[Mon_]" Text="Mon." />
                <asp:ListItem Value="[Efectivo]" Text="Efectivo" />
                <asp:ListItem Value="[Descuentos]" Text="Descuentos" />
                <asp:ListItem Value="[Valores]" Text="Valores" />
                <asp:ListItem Value="[Documentos]" Text="Documentos" />
                <asp:ListItem Value="[Acreedores]" Text="Acreedores" />
                <asp:ListItem Value="[Ret_IVA]" Text="Ret IVA" />
                <asp:ListItem Value="[Ret_gan_]" Text="Ret Gan." />
                <asp:ListItem Value="[Ret_ing_b_]" Text="RetIIBB" />
                <asp:ListItem Value="[Ret_SUSS]" Text="RetSUSS" />
                <asp:ListItem Value="[Dev_F_F_]" Text="Dev FF" />
                <asp:ListItem Value="[Dif_ Balanceo]" Text="Dif Balanceo" />
                <asp:ListItem Value="[OP complem_ FF]" Text="OP compl FF" />
                <asp:ListItem Value="[Cotiz_ dolar]" Text="Dolar" />
                <asp:ListItem Value="[Destinatario fondo fijo" />
                <asp:ListItem Value="[Confecciono]" Text="Confecciono" />
                <asp:ListItem Value="[Fecha ing_]" Text="Ingreso" />
                <asp:ListItem Value="[Modifico]" Text="Modifico" />
                <asp:ListItem Value="[Fecha modif_]" Text="Fecha" />
                <asp:ListItem Value="[Observaciones]" Text="Observaciones" />
                <asp:ListItem Value="[Anulo]" Text="Anulo" />
                <asp:ListItem Value="[Fecha anulacion]" Text="anulacion" />
                <asp:ListItem Value="[Motivo anulacion]" Text="Motivo" />
                <asp:ListItem Value="[Nro_Rend_FF]" Text="Rend. FF" />
                <asp:ListItem Value="[FF acreditado]" Text="Acred." />
                <asp:ListItem Value="[Concepto OP otros]" Text="Concepto" />
                <asp:ListItem Value="[Clasificacion s/canc_]" Text="Clasif." />
                <asp:ListItem Value="[Detalle]" Text="Detalle" />
                <asp:ListItem Value="[Obra]" Text="Obra" />
                <asp:ListItem Value="[Nro_ Recibo Proveedor]" Text="Recibo" />
                <asp:ListItem Value="[Fecha Recibo Proveedor]" Text="Fecha Recibo" />
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
                        <div style="width: 850px; overflow: auto;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdOrdenPago"
                                DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width="99%"
                                PageSize="8">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <asp:CommandField ShowEditButton="True" EditText="Ver" />
                                    <asp:BoundField DataField="IdOrdenPago" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="IdOrdenPago" Visible="False" />
                                    <%--<asp:BoundField DataField="A/B/E" HeaderText="" />--%>
                                    <%--<asp:BoundField DataField="Pto_vta_" HeaderText="" />--%>
                                    <%--Eval("A/B/E") & " "& "-" &--%>
                                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdOPComplementariaFF" HeaderText="IdOPComplementariaFF"
                                        Visible="false" />
                                    <asp:BoundField DataField="Cod" HeaderText="Cod" />
                                    <asp:BoundField DataField="Fecha Pago" HeaderText="Pago" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                                    <asp:TemplateField HeaderText="Valores" InsertVisible="False" SortExpression="Id">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" ShowHeader="False">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Tipo" HeaderText="Articulo" ItemStyle-Width="300">
                                                        <ItemStyle Font-Size="X-Small" Wrap="False" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Numero" HeaderText="Articulo" ItemStyle-Width="300">
                                                        <ItemStyle Font-Size="X-Small" Wrap="False" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Banco / Caja" HeaderText="Articulo" ItemStyle-Width="300">
                                                        <ItemStyle Font-Size="X-Small" Wrap="False" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Importe" HeaderText="Importe">
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
                                    <asp:BoundField DataField="Cuenta" HeaderText="Cuenta" />
                                    <asp:BoundField DataField="Mon_" HeaderText="Mon." />
                                    <asp:BoundField DataField="Efectivo" HeaderText="Efectivo" />
                                    <asp:BoundField DataField="Descuentos" HeaderText="Descuentos" />
                                    <asp:BoundField DataField="Valores" HeaderText="Valores" />
                                    <asp:BoundField DataField="Documentos" HeaderText="Documentos" />
                                    <asp:BoundField DataField="Acreedores" HeaderText="Acreedores" />
                                    <asp:BoundField DataField="Ret_IVA" HeaderText="Ret IVA" />
                                    <asp:BoundField DataField="Ret_gan_" HeaderText="Ret Gan." />
                                    <asp:BoundField DataField="Ret_ing_b_" HeaderText="RetIIBB" />
                                    <asp:BoundField DataField="Ret_SUSS" HeaderText="Ret_SUSS" />
                                    <asp:BoundField DataField="Dev_F_F_" HeaderText="Dev FF" />
                                    <asp:BoundField DataField="Dif_ Balanceo" HeaderText="Dif Balanceo" />
                                    <asp:BoundField DataField="OP complem_ FF" HeaderText="OP compl FF" />
                                    <asp:BoundField DataField="Cotiz_ dolar" HeaderText="Dolar" />
                                    <asp:BoundField DataField="Destinatario fondo fijo" HeaderText="Dest. FF" />
                                    <asp:BoundField DataField="Confecciono" HeaderText="Confecciono" />
                                    <asp:BoundField DataField="Fecha ing_" HeaderText="Ingreso" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="Modifico" HeaderText="Modifico" />
                                    <asp:BoundField DataField="Fecha modif_" HeaderText="Fecha" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                                    <asp:BoundField DataField="Anulo" HeaderText="Anulo" />
                                    <asp:BoundField DataField="Fecha anulacion" HeaderText="anulacion" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="Motivo anulacion" HeaderText="Motivo" />
                                    <asp:BoundField DataField="Nro_Rend_FF" HeaderText="Rend. FF" />
                                    <asp:BoundField DataField="FF acreditado" HeaderText="Acred." />
                                    <asp:BoundField DataField="Concepto OP otros" HeaderText="Concepto" />
                                    <asp:BoundField DataField="Clasificacion s/canc_" HeaderText="Clasif." />
                                    <asp:BoundField DataField="Detalle" HeaderText="Detalle" />
                                    <asp:BoundField DataField="Obra" HeaderText="Obra" />
<%--                                    <asp:BoundField DataField="Nro_ Recibo Proveedor" HeaderText="Recibo" />
                                    <asp:BoundField DataField="Fecha Recibo Proveedor" HeaderText="Fecha Recibo" DataFormatString="{0:d}" />
--%>                                    <%--                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("[Fecha]") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Fecha]", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <%--<asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                    <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />--%>
                                    <%--& Eval("[]") --%>
                                    <%--<asp:BoundField DataField="Anulada" HeaderText="Anulada" />--%>
                                    <%-- <asp:BoundField DataField="Total OrdenPago" HeaderText="Total" />--%>
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
                                    <%--            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
--%>
                                    <%-- <asp:BoundField DataField="Anulado" HeaderText="Anulado" />--%>
                                    <%--            <asp:BoundField DataField="Obras" HeaderText="Obras" />--%>
                                    <%--            <asp:BoundField DataField="Ordenes de compra" HeaderText="Ordenes de compra" />
            <asp:BoundField DataField="Facturas" HeaderText="Facturas" />--%>
                                    <%--   <asp:BoundField DataField="Tipo de OrdenPago" HeaderText="Tipo de OrdenPago" />
                                    <asp:BoundField DataField="Condicion de venta" HeaderText="Condicion de venta" />
                                    <asp:BoundField DataField="Transportista" HeaderText="Transportista" />
                                    <asp:BoundField DataField="Bultos" HeaderText="Bultos" />
                                    <asp:BoundField DataField="Valor decl_" HeaderText="Valor decl." />
                                    <asp:BoundField DataField="Cant_Items" HeaderText="Cant.Items" />
                                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />--%>
                                </Columns>
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
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.OrdenPagoManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myOrdenPago" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myOrdenPago" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.OrdenPagoManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myOrdenPago" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myOrdenPago" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/OrdenesPago" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\OrdenesPago.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>


<%--    <dx:ASPxGridView ID="gvDEVEX" runat="server" KeyFieldName="IdOrdenPago" Width="100%">
        <Styles>
        <CommandColumn CssClass="DevXGVCmmnd">
        </CommandColumn>
    </Styles>
        <Columns>
            <dx:GridViewDataColumn FieldName="IdOrdenPago" />
            <dx:GridViewDataColumn FieldName="Numero" />
            <dx:GridViewDataColumn FieldName="Proveedor" />
        </Columns>
    </dx:ASPxGridView>--%>
    
    
</asp:Content>
