<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="MascarasDefinicionArticulos.aspx.vb" Inherits="Obras" Title="Obras" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <div>
        <asp:button id="lnkNuevo" runat="server" font-bold="false" font-underline="False"
            width="120" height="30" cssclass="but" forecolor="White" causesvalidation="true"
            font-size="Small" style="vertical-align: middle" text="+ Nueva obra" />
        <asp:linkbutton id="LinkAgregarRenglon" runat="server" font-bold="false" font-underline="True"
            forecolor="White" causesvalidation="true" font-size="Small" height="30px" width="95px"
            style="margin-top: 0px" visible="true">+   Nuevo</asp:linkbutton>
        <asp:linkbutton id="LinkButton1" runat="server" font-bold="false" font-underline="True"
            forecolor="White" causesvalidation="true" font-size="Small" height="30px" visible="False">Exportar a Excel</asp:linkbutton>
        <asp:textbox id="txtBuscar" runat="server" style="text-align: right; margin-left: 0px;
            " text="" autopostback="True">
        </asp:textbox>
        <asp:dropdownlist id="cmbBuscarEsteCampo" runat="server" style="text-align: right;
            margin-left: 0px;" width="119px" height="22px">
            <asp:listitem text="Obra" value="NumeroObra" />
            <asp:listitem text="Descripcion" value="Descripcion" />
            <asp:listitem text="Cliente" value="Cliente" />
        </asp:dropdownlist>
    </div>
    <br />
    <br />
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:updatepanel id="UpdatePanel2" runat="server">
        <contenttemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                DataKeyNames="idobra" AllowPaging="True" AllowSorting="True" PageSize="10">
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


                    
                     <asp:TemplateField HeaderText="Obra">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNumeroObra" runat="server" Text='<%# Bind("NumeroObra") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewNumeroObra" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblNumeroObra" runat="server" Text='<%# Bind("NumeroObra") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                     <asp:TemplateField HeaderText="Tipo" visible=false>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTipoObra" runat="server" Text='<%# Bind("TipoObra") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewTipoObra" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTipoObra" runat="server" Text='<%# Bind("TipoObra") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Descripcion">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewDescripcion" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblEmails" runat="server" Text='<%# Bind("Descripcion") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
       


                           <asp:TemplateField HeaderText="Cliente" Visible="true">
                      <EditItemTemplate>
                            <asp:TextBox ID="txtCliente" runat="server" Text='<%# Bind("RazonSocial") %>'></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                CompletionSetCount="12" TargetControlID="txtCliente" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCliente" runat="server" autocomplete="off"></asp:TextBox>
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" CompletionInterval="100" runat="server"
                                CompletionSetCount="12" TargetControlID="txtNewCliente" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCliente" runat="server" Text='<%# Bind("RazonSocial") %>'></asp:Label>
                        </ItemTemplate>
                          </asp:TemplateField>

                    <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" />
                    <%--                    <asp:ButtonField ButtonType="Link" CommandName="Excel" Text="Excel" ItemStyle-HorizontalAlign="Center"
                        ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                        <ControlStyle Font-Size="Small" Font-Underline="True" />
                        <ItemStyle Font-Size="X-Small" />
                        <HeaderStyle Width="40px" />
                    </asp:ButtonField>--%>
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <%--<SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />--%>
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
        </contenttemplate>
    </asp:updatepanel>
    <br />
    <asp:button id="Button2" runat="server" text="Mandar factura electronica" visible="False" />
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
                <asp:label id="Label15" runat="server" text="Filtrar por Cuenta" forecolor="White"></asp:label>
            </td>
            <td style="width: 197px; height: 32px;">
                <asp:dropdownlist id="cmbCuenta" runat="server" width="218px" autopostback="True"
                    height="22px" style="margin-left: 0px" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:label id="Label2" runat="server" text="Reposicion Solicitada" forecolor="White">
                </asp:label>
            </td>
            <td style="width: 197px">
                <asp:label id="txtReposicionSolicitada" runat="server" width="80px" forecolor="White">
                </asp:label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:label id="Label4" runat="server" text="Fondos asignados" forecolor="White"></asp:label>
            </td>
            <td style="width: 197px">
                <asp:label id="txtTotalAsignados" runat="server" width="80px" forecolor="White"></asp:label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:label id="Label5" runat="server" text="Pendientes de reintegrar" forecolor="White"
                    width="145px" height="16px"></asp:label>
            </td>
            <td style="width: 197px">
                <asp:label id="txtPendientesReintegrar" runat="server" width="80px" forecolor="White" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px; height: 20px;">
                <asp:label id="Label6" runat="server" text="SALDO" forecolor="White"></asp:label>
            </td>
            <td style="width: 197px; height: 20px;">
                <asp:label id="txtSaldo" runat="server" width="80px" forecolor="White"></asp:label>
            </td>
        </tr>
        <tr>
            <td style="height: 27px" />
        </tr>
    </table>
    <%--  campos hidden --%>
    <asp:hiddenfield id="HFSC" runat="server" />
    <asp:hiddenfield id="HFIdObra" runat="server" />
    <asp:hiddenfield id="HFTipoFiltro" runat="server" />
</asp:content>
