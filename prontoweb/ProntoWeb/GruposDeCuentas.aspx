<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="GruposDeCuentas.aspx.vb" Inherits="CotizacionesListado" Title="Cotizaciones" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right; margin-left: 22px;
        margin-top: 10px;" Text="" AutoPostBack="True"></asp:TextBox>
    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
        margin-left: 0px;" Width="119px" Height="22px">
        <asp:ListItem Text="Moneda" Value="[Moneda]" Selected="True" />
    </asp:DropDownList>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <%--            /////////////////////////////////////////////////////////////////////////        
            /////////////////////////////////////////////////////////////////////////        
            HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
            http://forums.asp.net/p/956540/1177923.aspx
            /////////////////////////////////////////////////////////////////////////        
            /////////////////////////////////////////////////////////////////////////        --%>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                DataKeyNames="IdCotizacion" PageSize="25" AllowPaging="True" AllowSorting="True">
                <%--                OnRowDataBound="GridView1_RowDataBound" 
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing" 
                OnRowUpdating="GridView1_RowUpdating" 
                OnRowCommand="GridView1_RowCommand"
                OnRowDeleting="GridView1_RowDeleting" 
--%>
                <Columns>
                    <asp:TemplateField Visible="false">
                        <HeaderTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </HeaderTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
--%>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--                    <asp:CommandField ShowEditButton="True" />
--%>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Aplicar"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="AddNew"
                                Text="Agregar"></asp:LinkButton>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Editar"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fecha">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFecha" runat="server" Text='<%# Bind("Fecha") %>'></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFecha">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtFecha">
                            </cc1:MaskedEditExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewFecha" runat="server"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            TargetControlID="txtNewFecha" />
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtNewFecha" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabelFecha" runat="server" Text='<%# Bind("Fecha", "{0:dd/MM/yyyy}") %>'  ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Moneda">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbMoneda" runat="server">
                            </asp:DropDownList>
                                                    </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewMoneda" runat="server">
                            </asp:DropDownList>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabeMoneda" runat="server" Text='<%# Bind("Moneda") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cotizacion">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCotizacion" runat="server" Text='<%# Bind("Cotizacion") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCotizacion" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCotizacion" runat="server" Text='<%# Bind("Cotizacion") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cotizacion libre">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCotLibre" runat="server" Text='<%# Bind("[Cotizacion libre]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCotLibre" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCotLibre" runat="server" Text='<%# Bind("[Cotizacion libre]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- --%>
                    <%-- --%>
                    <%-- --%>
                    <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" />
                    <%--                    <asp:ButtonField ButtonType="Link" CommandName="Excel" Text="Excel" ItemStyle-HorizontalAlign="Center"
                        ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                        <ControlStyle Font-Size="Small" Font-Underline="True" />
                        <ItemStyle Font-Size="X-Small" />
                        <HeaderStyle Width="40px" />
                    </asp:ButtonField>--%>
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
                
            </asp:GridView>
            <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
            <%--    datasource de grilla principal--%>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ComparativaManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <%--            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="cmbCuenta" Name="IdProveedor" PropertyName="SelectedValue" Type="Int32" />--%>
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItemsParaGrilla" TypeName="Pronto.ERP.Bll.ComparativaManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="Button2" runat="server" Text="Mandar factura electronica" Visible="False" />
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <span>
        <%--<div>--%>
        <%--botones de alta y excel--%>
        <%--</div>--%>
    </span>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--combo para filtrar cuenta--%>
    <table style="width: 503px; margin-right: 0px; height: 122px; visibility: hidden;">
        <tr>
            <td style="width: 132px; height: 32px;">
                <asp:Label ID="Label15" runat="server" Text="Filtrar por Cuenta" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 32px;">
                <asp:DropDownList ID="cmbCuenta" runat="server" Width="218px" AutoPostBack="True"
                    Height="22px" Style="margin-left: 0px" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label2" runat="server" Text="Reposicion Solicitada" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtReposicionSolicitada" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label4" runat="server" Text="Fondos asignados" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtTotalAsignados" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label5" runat="server" Text="Pendientes de reintegrar" ForeColor="White"
                    Width="145px" Height="16px"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtPendientesReintegrar" runat="server" Width="80px" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px; height: 20px;">
                <asp:Label ID="Label6" runat="server" Text="SALDO" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 20px;">
                <asp:Label ID="txtSaldo" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 27px" />
        </tr>
    </table>
    
    cotizacion dolar:
    
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
