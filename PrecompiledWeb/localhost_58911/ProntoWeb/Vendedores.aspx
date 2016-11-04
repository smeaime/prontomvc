﻿<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Vendedores, App_Web_hpwltzg2" title="Vendedores" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" 
                Style="text-align: right; margin-left: 0px;"  Width="119px" Height="22px" >
                <asp:ListItem Text="Codigo" Value="[Codigo Vendedor]" />
                <asp:ListItem Text="Razon Social" Value="[Razon Social]" Selected="True" />
                <asp:ListItem Text="Direccion" Value="Direccion" />
                <asp:ListItem Text="CUIT" Value="CUIT" />
                <asp:ListItem Text="Localidad" Value="Localidad" />


                </asp:DropDownList>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>

       <asp:Label ID="lblAlerta" runat="server" CssClass="Alerta" Font-Size="small"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True"
            
                DataKeyNames="IdVendedor"
                
                AllowPaging="True" AllowSorting="True" PageSize="10"
                >
                <%--                OnRowDataBound="GridView1_RowDataBound" 
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing" 
                OnRowUpdating="GridView1_RowUpdating" 
                OnRowCommand="GridView1_RowCommand"
                OnRowDeleting="GridView1_RowDeleting" 
--%>
                <Columns>
                    <asp:TemplateField  Visible="false">
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
                    
                    <asp:TemplateField HeaderText="Codigo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigo" runat="server" Text='<%# Bind("[Codigo Vendedor]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigo" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCodigo" runat="server" Text='<%# Bind("[Codigo Vendedor]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    
                    

                    <asp:TemplateField HeaderText="Razon Social">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRazonSocial" runat="server" Text='<%# Bind("[Razon Social]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewRazonSocial" runat="server">
                            </asp:TextBox>
                            
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblRazonSocial" runat="server" Text='<%# Bind("[Razon Social]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    
                    <asp:TemplateField HeaderText="Direccion"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Bind("Direccion") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewDireccion" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblDireccion"  runat="server" Text='<%# Bind("Direccion") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    


                    
                                        <asp:TemplateField HeaderText="CUIT"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCUIT" runat="server" Text='<%# Bind("CUIT") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCUIT" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCUIT"  runat="server" Text='<%# Bind("CUIT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    

                    
                    <asp:TemplateField HeaderText="Localidad">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLocalidad" runat="server" Text='<%# Bind("Localidad") %>'></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server" CompletionSetCount="12"
                                TargetControlID="txtLocalidad" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                ServicePath="WebServiceLocalidades.asmx" UseContextKey="True" FirstRowSelected="True"
                                CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewLocalidad" runat="server" autocomplete="off"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender7" runat="server" CompletionSetCount="12"
                                TargetControlID="txtNewLocalidad" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                ServicePath="WebServiceLocalidades.asmx" UseContextKey="True" FirstRowSelected="True"
                                CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLocalidad" runat="server" Text='<%# Bind("Localidad") %>'></asp:Label>
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
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
