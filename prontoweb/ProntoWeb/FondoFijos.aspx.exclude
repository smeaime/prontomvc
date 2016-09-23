<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="FondoFijos.aspx.vb" Inherits="ComprobantesProveedor" Title="Fondos Fijos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="True" Font-Underline="False"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" Font-Underline="False"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-left: 28px">Exportar a Excel</asp:LinkButton>
    <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="True" Font-Underline="False"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-left: 53px">Informe Completo</asp:LinkButton>
    <%--botones de alta y excel--%>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA, grilla anidada y datasources
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                    DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width="770px"
                    PageSize="8">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                            SortExpression="Id" Visible="False" />
                        <asp:TemplateField HeaderText="Ref." SortExpression="Numero">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Número" SortExpression="Numero">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Numero") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                            <EditItemTemplate>
                                &nbsp;&nbsp;
                                <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaComprobante") %>'>
                                </asp:Calendar>
                            </EditItemTemplate>
                            <ControlStyle Width="100px" />
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaComprobante", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cuenta" SortExpression="Cuenta">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Subtotal" HeaderText="Total" HeaderStyle-Width="200"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}" HeaderStyle-Wrap="False" />
                        <%--<asp:TemplateField HeaderText="Proveedor" SortExpression="Proveedor" HeaderStyle-Width="50"
                            ItemStyle-Width="50">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                    DataTextField="Titulo" DataValueField="IdProveedor" SelectedValue='<%# Bind("IdProveedorEventual") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ProveedorManager"></asp:ObjectDataSource>
                            </EditItemTemplate>
                            <HeaderStyle Width="50px"></HeaderStyle>
                            <ItemStyle Wrap="true" />
                        
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ProveedorEventual") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <%--subgrilla--%>
                        <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                            <ItemTemplate>
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <Columns>
                                        <asp:BoundField DataField="CuentaGastoDescripcion" HeaderText="Cuenta de Gasto">
                                            <ItemStyle Font-Size="X-Small" Wrap="False" Width="100" />
                                            <%--Wrap!!!!!--%>
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
                        <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Listo" SortExpression="Listo">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </div>
            <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
            <%--    datasource de grilla principal--%>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetList_FondosFijos" TypeName="Pronto.ERP.Bll.ComprobanteProveedorManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
                    <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="cmbCuenta" Name="IdCuentaFF" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="txtRendicion" Name="Rendicion" PropertyName="Text"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="txtFechaDesde" Name="dtDesde" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtFechaHasta" Name="dtHasta" PropertyName="Text"
                        Type="DateTime" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobanteProveedor" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobanteProveedor" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.ComprobanteProveedorManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobanteProveedor" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComprobanteProveedor" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <div style="height: 25px">
    </div>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--<asp:UpdatePanel ID="UpdatePanelResumen" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
--%>
    <%--combo para filtrar cuenta--%>
    <table style="width: 423px; height: 246px;" class="t1" cellpadding="5" cellspacing="5">
        <tr>
            <td class="header" colspan="2">
                <span style="color: #ffffff">Resumen de Cuenta</span>
            </td>
        </tr>
        <tr>
            <td style="width: 196px; height: 24px;">
                <asp:Label ID="Label15" runat="server" Text="Filtrar por Cuenta" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 175px; height: 24px;" align="right">
                <asp:DropDownList ID="cmbCuenta" runat="server" Width="218px" AutoPostBack="True"
                    Height="22px" Style="margin-left: 0px" />
            </td>
        </tr>
        <tr>
            <td style="width: 196px; height: 22px;">
                <asp:Label ID="Label7" runat="server" Text="Filtrar por Rendición" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 175px; height: 22px;" align="right">
                <asp:TextBox ID="txtRendicion" runat="server" Height="21px" Width="53px" AutoPostBack="True"></asp:TextBox>
                <asp:DropDownList ID="cmbRendicion" runat="server" Width="63px" AutoPostBack="True"
                    Height="22px" Style="margin-left: 0px" Visible="False" />
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label2" runat="server" Text="Reposicion Solicitada" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 175px" align="right">
                <asp:Label ID="txtReposicionSolicitada" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label4" runat="server" Text="Fondos asignados" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 175px" align="right">
                <asp:Label ID="txtTotalAsignados" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 196px">
                <asp:Label ID="Label5" runat="server" Text="Pendientes de reintegrar" ForeColor="White"
                    Width="145px" Height="16px"></asp:Label>
            </td>
            <td style="width: 175px" align="right">
                <asp:Label ID="txtPendientesReintegrar" runat="server" Width="80px" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td style="width: 196px; height: 14px;">
                <asp:Label ID="Label6" runat="server" Text="SALDO" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 175px; height: 14px;" align="right">
                <asp:Label ID="txtSaldo" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right" style="height: 25px">
                <asp:Button ID="Button1" runat="server" Text="Cerrar Rendición" CssClass="but" Width="145px" />
            </td>
        </tr>
    </table>
    <br />
    <%--   </ContentTemplate>
</asp:UpdatePanel>
--%>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
