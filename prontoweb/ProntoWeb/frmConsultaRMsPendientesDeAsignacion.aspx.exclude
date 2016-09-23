<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterPage.master"
    CodeFile="~/ProntoWeb/frmConsultaRMsPendientesDeAsignacion.aspx.vb" Inherits="ProntoWeb_frmConsultaRMsPendientesDeAsignacion"
    Title="Asignación de Requerimientos" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text=""
                            Visible="true"></asp:TextBox>
                        <asp:LinkButton ID="lnkActualizarPendientes" runat="server" Font-Bold="False" Font-Underline="True"
                            ForeColor="White" CausesValidation="False" Font-Size="Small" Height="30px"> Actualizar</asp:LinkButton>
                        &nbsp;
                    </td>
                    <td>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                <asp:Label ID="lblUpdateProgress" ForeColor="White" runat="server" Text="Actualizando datos ..."
                                    Font-Size="Small"></asp:Label></ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="HFSC" runat="server" />
            <asp:HiddenField ID="HFUserName" runat="server" />
            &nbsp;
            <div style="width: 700px; height: 550px; overflow: auto">
                <asp:ObjectDataSource ID="ObjDsFirmas" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetListTXDetallesPendientesDeAsignacion" TypeName="Pronto.ERP.Bll.RequerimientoManager"
                    DeleteMethod="Delete" InsertMethod="SaveBlock">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                        <%--                        <asp:ControlParameter ControlID="HFUserName" Name="Usuario" PropertyName="Value"
                            Type="String" />--%>
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <%--<asp:Parameter Name="myFirmaDocumento" Type="Object" />--%>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <%--                        <asp:Parameter Name="BDs" Type="String" />
                        <asp:Parameter Name="IdFormularios" Type="String" />
                        <asp:Parameter Name="IdComprobantes" Type="String" />
                        <asp:Parameter Name="NumerosOrden" Type="String" />
                        <asp:Parameter Name="Autorizo" Type="String" />--%>
                    </InsertParameters>
                </asp:ObjectDataSource>
                
                
                
                <asp:GridView ID="GVFirmas" runat="server" AutoGenerateColumns="False" CssClass="t1"
                    DataSourceID="ObjDsFirmas" DataKeyNames="IdAux1,IdAux2,IdAux3,IdAux4" AllowPaging="True"
                    EmptyDataText="No hay RMs disponibles" Width="700px" BorderStyle="None" Font-Size="Smaller"
                    BackColor="White" BorderColor="#507CBB" BorderWidth="1px" CellPadding="3" GridLines="Horizontal"
                    PageSize="6" RowStyle-Wrap="False">
                    <Columns>
                        <asp:TemplateField HeaderText="">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Req_Nro_" HeaderText="Req Nro" />
                        <asp:BoundField DataField="Item" HeaderText="Item" />
                        <asp:BoundField DataField="Cant_" HeaderText="Cant." />
                        <asp:BoundField DataField="Unidad en" HeaderText="Unidad en" />
                        <asp:BoundField DataField="Vales" HeaderText="Vales" />
                        <asp:BoundField DataField="Cant_Ped_" HeaderText="Cant.Ped." />
                        <asp:BoundField DataField="Recibido" HeaderText="Recibido" />
                        <asp:BoundField DataField="Recepcion" HeaderText="Recepcion" />
                        <asp:BoundField DataField="Ult_Recepcion" HeaderText="Ult.Recepcion" />
                        <asp:BoundField DataField="En stock" HeaderText="En stock" />
                        <asp:BoundField DataField="Stk_min_" HeaderText="Stk.min." />
                        <asp:BoundField DataField="Articulo" HeaderText="Articulo" />
                        <asp:BoundField DataField="F_entrega" HeaderText="F.entrega" />
                        <asp:BoundField DataField="Solicito" HeaderText="Solicito" />
                        <asp:BoundField DataField="Tipo Req_" HeaderText="Tipo Req." />
                        <asp:BoundField DataField="Obra" HeaderText="Obra" ItemStyle-Width="70" />
                        <asp:BoundField DataField="Cump_" HeaderText="Cump." />
                        <asp:BoundField DataField="Recibido" HeaderText="Recibido" />
                        <asp:BoundField DataField="Observaciones item" HeaderText="Obs.item" />
                        <asp:BoundField DataField="Deposito" HeaderText="Deposito" />
                        <%--                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                        <asp:BoundField DataField="Numero" HeaderText="Numero" />
                        <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fecha", "{0:dd/MM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Proveedor" HeaderText="Proveedor">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Monto compra" HeaderText="Monto compra" />
                        <asp:BoundField DataField="Orden" HeaderText="Orden" />
                        <asp:BoundField DataField="Mon." HeaderText="Mon." />
                        <asp:BoundField DataField="Obra" HeaderText="Obra">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Sector" HeaderText="Sector" />
                        <asp:BoundField DataField="Libero" HeaderText="Libero" />
                        <asp:BoundField DataField="IdComprobante" HeaderText="IdComprobante" Visible="False" />
                        <asp:BoundField DataField="IdFormulario" HeaderText="IdFormulario" Visible="False" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="ButVer" runat="server" CausesValidation="False" CommandName="Ver"
                        CssClass="but" Text="Ver" UseSubmitBehavior="False" />
                            </ItemTemplate>
                            <ControlStyle CssClass="but" Font-Size="XX-Small" />
                            <ItemStyle Font-Size="XX-Small" />
                        </asp:TemplateField>
--%>
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </div>
            <table width="700">
                <tr>
                    <td align="center">
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                        <asp:Panel ID="PanelAction" runat="server" Width="641px">
                            <asp:Button ID="btnMarcar" runat="server" CssClass="but" Text="Marcar Todos" Visible="true" />
                            <asp:Button ID="btnDesmarcar" runat="server" CssClass="but" Height="23px" Text="Desmarcar todos"
                                Visible="true" />
                            <br />
                            <asp:Button ID="btnGenerarVale" runat="server" CssClass="but" Text="Generar Vale (por Stock)"
                                Visible="true" />
                            <asp:Button ID="btnParaCompras" runat="server" CssClass="but" Text="Liberar para Compras"
                                Visible="true" />
                            <asp:Button ID="btnDarPorCumplido" runat="server" CssClass="but" Text="Dar por Cumplido" />
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
