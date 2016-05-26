<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CtaCteDeudores.aspx.vb" Inherits="CtaCteDeudores" Title="Cta. Cte. Deudores" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" Font-Underline="False"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
                Visible="false">+   Nuevo</asp:LinkButton>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                margin-left: 0px;" Width="119px" Height="22px">
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Numero" Value="[Nro. interno]" />
                <asp:ListItem Text="Fecha" Value="[Fecha CtaCteD]" />
                <asp:ListItem Text="Cliente" Value="Cliente" />
                <asp:ListItem Text="Anulada" Value="Anulada" />
                <asp:ListItem Text="Total" Value="Total" />
            </asp:DropDownList>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:GridView ID="gvCuentas" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width="700px"
                PageSize="8">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:CommandField ShowSelectButton="true" EditText="Ver" />
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                        SortExpression="Id" Visible="False" />
                    <%--    <asp:BoundField DataField="A/B/E" HeaderText="" />--%>
                    <%--  <asp:BoundField DataField="Pto_vta_" HeaderText="" />--%>
                    <%--Eval("A/B/E") & " "& "-" &--%>
                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="Cant_Reg_" HeaderText="Registros" />
                    <asp:BoundField DataField="Saldo actual" HeaderText="Saldo actual" />
                
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.CtaCteDeudorManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCtaCteD" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCtaCteD" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.CtaCteDeudorManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCtaCteD" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCtaCteD" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/CtaCteDs" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\CtaCteDs.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvEstadoPorMayor" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCtaCte,IdTipoComprobante,IdComprobante"
                DataSourceID="" GridLines="Horizontal" AllowPaging="True" Width="700px"
                PageSize="8">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" EditText="Ver" />
                    <%--            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" Visible="False" />--%>
                    <%--    <asp:BoundField DataField="A/B/E" HeaderText="" />--%>
                    <%--  <asp:BoundField DataField="Pto_vta_" HeaderText="" />--%>
                    <%--Eval("A/B/E") & " "& "-" &--%>
                    <asp:BoundField DataField="Comp_" HeaderText="" ItemStyle-Width="15" />
                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--        <asp:BoundField DataField="Saldo actual" HeaderText="Saldo actual" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />--%>
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <%--              <asp:BoundField DataField="SaldoComp." HeaderText="Fecha" />--%>
                    <asp:BoundField DataField="Imp_Orig_" HeaderText="Imp.orig." />
                    <asp:BoundField DataField="Debe" HeaderText="Debe" />
                    <asp:BoundField DataField="Haber" HeaderText="Haber" />
                    <asp:BoundField DataField="Saldo" HeaderText="Saldo" />
                    
                  
                    
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            
            
            
            
            
            
            
            <asp:GridView ID="gvEstadoPorTrs" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCtaCte,IdTipoComp,IdComprobante"
                DataSourceID="ObjectDataSource4" GridLines="Horizontal" AllowPaging="True" Width="700px"
                PageSize="8">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" EditText="Ver" />
                    <%--            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" Visible="False" />--%>
                    <%--    <asp:BoundField DataField="A/B/E" HeaderText="" />--%>
                    <%--  <asp:BoundField DataField="Pto_vta_" HeaderText="" />--%>
                    <%--Eval("A/B/E") & " "& "-" &--%>
                    <asp:BoundField DataField="Comp_" HeaderText="" ItemStyle-Width="15" />
                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--        <asp:BoundField DataField="Saldo actual" HeaderText="Saldo actual" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />--%>
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                       
                       <asp:BoundField DataField="Imp_Orig_" HeaderText="Imp.Orig." />
                       <asp:BoundField DataField="Saldo Comp_" HeaderText="Saldo Comp." />
                       
                       <asp:BoundField DataField="Obra" HeaderText="Obra" />
                       <asp:BoundField DataField="Orden de Compra" HeaderText="OC" />
                       <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" />
                       
                       
                       
                    <asp:BoundField DataField="SaldoTrs" HeaderText="SaldoTrs" />
                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            
            
            
            
            
            
            
            
            
            
            
            
            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListTX" TypeName="Pronto.ERP.Bll.CtaCteDeudorManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="TX" DefaultValue="PorMayor" />
                    <%--  <asp:Parameter Name="Parametros" DefaultValue="" Type="Object"/>--%>
                    <%--                                    exec CtasCtesD_TXPorMayor 84, -1, 'Ene 12 2011 12:00AM', 'Ene  1 2000 12:00AM', -1
                                    exec CtasCtesD_TXPorTrs 84, -1, 'Ene 12 2011 12:00AM', 'Ene  1 2000 12:00AM', -1
--%>
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myrecibo" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myrecibo" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <br />
            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                cellpadding="1" cellspacing="1">
                <tr>
                    <td style="width: 101px; height: 24px;" class="EncabezadoCell" >
                        Cliente
                    </td>
                    <td style="width: 175px; height: 24px;">
                        <asp:Label ID="lblCliente" runat="server" ForeColor="White" Visible="true"></asp:Label>
                    </td>
                    <td class="EncabezadoCell">
                        Teléfono
                    </td>
                    <td>
                        <asp:Label ID="lblTelefono" runat="server" ForeColor="White" Visible="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 24px;" class="EncabezadoCell">
                        Mail
                    </td>
                    <td>
                        <asp:Label ID="lblMail" runat="server" ForeColor="White" Visible="true"></asp:Label>
                    </td>
                    <td class="EncabezadoCell">
                        Saldo
                    </td>
                    <td>
                        <asp:Label ID="lblSaldo" runat="server" ForeColor="White" Visible="true"></asp:Label>
                    </td>
                </tr>
                
                
                <tr >
                
                    <td class="EncabezadoCell">
                        Desde
                    </td>
                    <td class="EncabezadoCell" style="height: 18px">
                        <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" autocomplete="off"
                            TabIndex="2" AutoPostBack="False"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                            Enabled="True">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True">
                        </cc1:MaskedEditExtender>
                    </td>
                    <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                        Hasta
                    </td>
                    <td class="EncabezadoCell" style="height: 18px">
                        <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="2"
                            AutoPostBack="False"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta"
                            Enabled="True">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True">
                        </cc1:MaskedEditExtender>
                    </td>
                </tr>
                <tr>
                       <td class="EncabezadoCell">
                   Tipo
                    </td>
                       <td class="EncabezadoCell">
                           <asp:RadioButtonList ID="RadioButtonListTrans_O_Mayor" runat="server" 
                               AutoPostBack="True">
                            <asp:ListItem Text="por Transaccion" Selected=True />
                            <asp:ListItem Text="Por Mayor" />
                        </asp:RadioButtonList>
                        
                    </td>
                    <td class="EncabezadoCell">
                        Alcance
                    </td>
                    <td class="EncabezadoCell">
                        <asp:RadioButtonList ID="RadioButtonListAlcance" runat="server" 
                            AutoPostBack="True">
                            <asp:ListItem Text="todo"  Selected=True/>
                            <asp:ListItem Text="pendiente" />
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
            <asp:Button ID="Button3" runat="server" Text="Imprimir"  UseSubmitBehavior="false" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
            <asp:Label ID="Label3342" runat="server" Text="Actualizando datos..." ForeColor="White"
                Visible="true"></asp:Label>
        </ProgressTemplate>
    </asp:UpdateProgress>
<%--    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
        Height="500px" Width="700px" Visible="true">
    </rsweb:ReportViewer>--%>
</asp:Content>
