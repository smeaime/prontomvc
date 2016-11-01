﻿<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Localidades, App_Web_y4lmf2kj" title="Localidades" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right; margin-left: 28px;
        margin-top: 10px;" Text=""  AutoPostBack="True"></asp:TextBox>
                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" 
                Style="text-align: right; margin-left: 0px;"  Width="119px" Height="22px" >
                <asp:ListItem Text="Localidad" Value="Localidad" Selected="True" />
                <asp:ListItem Text="Codigo postal" Value="[Codigo postal]" />
                <asp:ListItem Text="Provincia" Value="Provincia" />

                </asp:DropDownList>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="True"
            
                DataKeyNames="IdLocalidad"
                AllowPaging="True" AllowSorting="True" PageSize="25"
                >
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
                    
                    <asp:TemplateField HeaderText="Localidad">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLocalidad" runat="server" Text='<%# Bind("Localidad") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewLocalidad" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLocalidad" runat="server" Text='<%# Bind("Localidad") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    
                    
                    <asp:TemplateField HeaderText="Codigo postal"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoPostal" Width="30" runat="server" Text='<%# Bind("[Codigo postal]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoPostal" Width="30" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoPostal" Width="30" runat="server" Text='<%# Bind("[Codigo postal]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                 
                   
                    
                    
                    
                    <asp:TemplateField HeaderText="Provincia">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbProvincia" runat="server"   >
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblProvincia" runat="server"  Text='<%# IIF(Eval("Provincia") Is DBNull.Value,"",Eval("Provincia"))					 %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewProvincia" runat="server">
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    
                    
                    <asp:TemplateField HeaderText="Codigo ONCCA"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoONCAA" Width="30" runat="server" Text='<%# Bind("[CodigoONCAA]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoONCAA" Width="30" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoONCAA" Width="30" runat="server" Text='<%# Bind("[CodigoONCAA]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    
                    <asp:TemplateField HeaderText="Codigo Williams"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoWilliams" Width="80" runat="server" Text='<%# Bind("[CodigoWilliams]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoWilliams" Width="80" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoWilliams" Width="30" runat="server" Text='<%# Bind("[CodigoWilliams]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    
                    <asp:TemplateField HeaderText="Codigo LosGrobo"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoLosGrobo" Width="80" runat="server" Text='<%# Bind("[CodigoLosGrobo]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoLosGrobo" Width="80" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoLosGrobo" Width="30" runat="server" Text='<%# Bind("[CodigoLosGrobo]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                           
                    
                    <asp:TemplateField HeaderText="Codigo AFIP"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoAFIP" Width="80" runat="server" Text='<%# Bind("[CodigoAFIP]")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoAFIP" Width="80" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoAFIP" Width="30" runat="server" Text='<%# Bind("[CodigoAFIP]")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

<%--                    <asp:TemplateField HeaderText="Partido"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPartido" Width="80" runat="server" Text='<%# Bind("[Partido]") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPartido" Width="80" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblPartido" Width="30" runat="server" Text='<%# Bind("[Partido]") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>


                    
                    <asp:TemplateField HeaderText="Partido">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbPartido" Width="200"  runat="server"   >
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPartido"  Width="200" runat="server"  Text='<%# IIF(Eval("Partido") Is DBNull.Value,"",Eval("Partido"))					 %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewPartido" Width="200"  runat="server">
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Codigo CGG"  >
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCodigoCGG" Width="80" runat="server" Text='<%# Bind("[CodigoCGG]")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCodigoCGG" Width="80" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate >
                            <asp:Label ID="lblCodigoCGG" Width="30" runat="server" Text='<%# Bind("[CodigoCGG]")%>'></asp:Label>
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
