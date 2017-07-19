<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CDPStockMovimientos.aspx.vb" Inherits="CDPStockMovimientos" Title="Movimientos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel  runat="server" Wrap="False">
                <div style="vertical-align: middle; height: 100%; margin-top: 15px;">
                    <asp:LinkButton ID="lnkNuevo" runat="server"  Font-Underline="False"  CssClass="butCrear but"
                        ForeColor="White" CausesValidation="true" Font-Size="Small" 

                        Visible="true">+   Nuevo</asp:LinkButton>

                   
                    <asp:Button ID="Button1" Text="exportar" runat="server" Visible="true" Height="27" />

                    <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                        Visible="False"></asp:Label>
                    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
                    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                        margin-left: 0px;" Width="119px" Height="22px">
                        <asp:ListItem Text="Numero" Value="IdCDPMovimiento" />
                        <asp:ListItem Text="Fecha" Value="[FechaIngreso]" />
                        <asp:ListItem Text="de Exportador" Value="ExportadorOrigen" />
                        <asp:ListItem Text="a Exportador" Value="ExportadorDestino" />
                        <asp:ListItem Text="Tipo" Value="Tipo" />
                        <asp:ListItem Text="Contrato" Value="Contrato" />
                        <asp:ListItem Text="Puerto" Value="MovDestinoDesc" />
                        <asp:ListItem Text="Vapor" Value="Vapor" />
                    </asp:DropDownList>
                    <cc1:TextBoxWatermarkExtender ID="TBWE1" runat="server" TargetControlID="txtBuscar"
                        WatermarkText="buscar" WatermarkCssClass="watermarkedbuscar" />
                    <asp:TextBox ID="txtFechaDesde" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                        AutoPostBack="True" />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                        TargetControlID="txtFechaDesde" />
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtFechaDesde" />
                    <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                        WatermarkText="desde" WatermarkCssClass="watermarkedbuscar" />
                    <asp:TextBox ID="txtFechaHasta" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                        AutoPostBack="True" />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                        TargetControlID="txtFechaHasta" />
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtFechaHasta" />
                    <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                        WatermarkText="hasta" WatermarkCssClass="watermarkedbuscar" />
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                            <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                Visible="true"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
            </asp:Panel>
               <br />
    <br />
            <%--<hr style="border-color: #FFFFFF; width: 160px; color: #FFFFFF;" align="left" size="1" />--%>
            <table width="700">
                <tr>
                    <td align="left">
                        <div style="width: 700px; overflow: auto; margin-top: 4px;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCDPMovimiento"
                                DataSourceID="SqlDataSource1" GridLines="none" AllowPaging="True" Width="700px"
                                PageSize="8" EnableModelValidation="True">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <%--<asp:CommandField ShowEditButton="True" EditText="Ver" />--%>
                                    <asp:BoundField DataField="IdCDPMovimiento" HeaderText="Número" InsertVisible="False"
                                        ReadOnly="True" Visible="true" SortExpression="IdCDPMovimiento" />
                                    <%--   <asp:BoundField DataField="NumeroCDPMovimiento" 
                                        HeaderText="Numero" SortExpression="NumeroCDPMovimiento" Visible="false" />
                                    --%>
                                    <asp:TemplateField HeaderText="Fecha" HeaderStyle-HorizontalAlign="Right">
                                        <%--<ItemStyle Width="120px" HorizontalAlign="right" />--%>
                                        <ItemTemplate>
                                            <asp:Label ID="Fecha" Text='<%#   Eval( "FechaIngreso", "{0:d MMM}" )  %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="MovProductoDesc" HeaderText="Destino" SortExpression="MovProductoDesc" />
                                    <asp:BoundField DataField="ExportadorOrigen" HeaderText="  " SortExpression="ExportadorOrigen" />
                                    <asp:BoundField DataField="ExportadorDestino" HeaderText="Origen" SortExpression="ExportadorDestino" />
                                    <%--<asp:BoundField DataField="Tipo" HeaderText="Tipo" SortExpression="Tipo" />--%>
                                    <asp:BoundField DataField="Contrato" HeaderText="Contrato" SortExpression="Contrato" />
                                    <asp:BoundField DataField="MovDestinoDesc" HeaderText="Producto" SortExpression="Puerto" />
                                    <asp:BoundField DataField="Vapor" HeaderText="Vapor" SortExpression="Vapor" />
                                       <asp:BoundField DataField="IdStock" HeaderText="PVenta" SortExpression="IdStock" />
                                    <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" />
                                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" />
                                    <asp:BoundField DataField="IdUsuarioIngreso" HeaderText="IdUsuarioIngreso" Visible="false"
                                        SortExpression="IdUsuarioIngreso" />
                                    <%--Eval("A/B/E") & " "& "-" &--%>
                                    <%--& Eval("[]") --%>
                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" Visible="false" SortExpression="Anulada" />
                                    <asp:BoundField DataField="IdUsuarioAnulo" HeaderText="IdUsuarioAnulo" Visible="false"
                                        SortExpression="IdUsuarioAnulo" />
                                
                                    <asp:BoundField DataField="FechaAnulacion" HeaderText="FechaAnulacion" SortExpression="FechaAnulacion"
                                        Visible="false" />
                                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" SortExpression="Obs."
                                        Visible="false" />
                                    <asp:BoundField DataField="IdAjusteStock" HeaderText="IdAjusteStock" SortExpression="IdAjusteStock"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdCartaDePorte" HeaderText="IdCartaDePorte" SortExpression="IdCartaDePorte"
                                        Visible="false" />
                                    <%--            <asp:BoundField DataField="Ordenes de compra" HeaderText="Ordenes de compra" />--%>
                                    <%--            <asp:BoundField DataField="Remitos" HeaderText="Remitos" />--%>
                                    <%--  <asp:BoundField DataField="Neto gravado" HeaderText="Neto gravado" />--%>
                                    <asp:BoundField DataField="IdStock" HeaderText="IdStock" SortExpression="IdStock"
                                        Visible="false" />
                                    <asp:BoundField DataField="Partida" HeaderText="Partida" SortExpression="Partida"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdUnidad" HeaderText="IdUnidad" SortExpression="IdUnidad"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdUbicacion" HeaderText="IdUbicacion" SortExpression="IdUbicacion"
                                        Visible="false" />
                                    <%--            <asp:BoundField DataField="Grupo CDPStockMovimientocion automatica" HeaderText="Grupo CDPStockMovimientocion automatica" />
            <asp:BoundField DataField="Act_Rec_Gtos_" HeaderText="Act_Rec_Gtos_" />
            <asp:BoundField DataField="Fecha Contab_" HeaderText="Fecha Contab_" />--%>
                                </Columns>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="false" ForeColor="#F7F7F7" Wrap="False" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.CDPStockMovimientoManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.CDPStockMovimientoManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/CDPStockMovimientos" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\CDPStockMovimientos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
</asp:Content>
