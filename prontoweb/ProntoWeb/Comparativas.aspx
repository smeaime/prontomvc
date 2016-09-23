<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Comparativas.aspx.vb" Inherits="Comparativas" Title="Comparativas"   ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
    
    
    
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  &nbsp;<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" 
        Font-Underline="True" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="30px" Width="95px" style="margin-top: 0px">+   Nuevo</asp:LinkButton>

    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" 
        Font-Underline="True" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="30px">Exportar a Excel</asp:LinkButton>
        
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA, grilla anidada y datasources
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%><asp:TextBox 
        ID="txtBuscar" runat="server" 
        style="text-align: right; margin-left: 357px; margin-top: 10px;" Text=""></asp:TextBox>  
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

    
<%--    <div style="OVERFLOW: auto;width:100%">
--%>        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
        BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
        DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" 
        Width="700px" PageSize="8" AllowSorting="False">
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" Visible="False" />
            
<%--            <asp:TemplateField HeaderText="Ref." SortExpression="Numero">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("NumeroReferencia") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
--%>            

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
                    <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaAprobacion") %>'>
                    </asp:Calendar>
                </EditItemTemplate>
                <ControlStyle Width="100px" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaAprobacion", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="Tipo seleccion" HeaderText="Tipo seleccion" />

<%--            <asp:TemplateField HeaderText="Cuenta" SortExpression="Cuenta">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Cuenta") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>

            
<%--            <asp:TemplateField HeaderText="Proveedor" SortExpression="Proveedor" HeaderStyle-Width="50" ItemStyle-Width="50">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="Titulo" DataValueField="IdProveedor" SelectedValue='<%# Bind("IdProveedor") %>'>
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ProveedorManager"></asp:ObjectDataSource>
                </EditItemTemplate>

                <HeaderStyle Width="50px"></HeaderStyle>

                <ItemStyle Wrap="true" /> 
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Proveedor") %>'></asp:Label>
                
                
                </ItemTemplate>
                
            </asp:TemplateField>--%>
            
            
            <%--subgrilla--%>
            
            <asp:TemplateField  HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                <ItemTemplate>
                    <%--la grilla anidada del listado de comparativas sí tiene puesto el AutoGenerateColumns--%>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="true" BackColor="White"
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <HeaderStyle CssClass="GrillaAnidadaHeaderStyle"/>
                    </asp:GridView>
                </ItemTemplate>
                <ControlStyle BorderStyle="None" />
            </asp:TemplateField>

<%--            <asp:BoundField DataField="MontoPrevisto" HeaderText="Monto Previsto"    HeaderStyle-Width="80"  ItemStyle-HorizontalAlign="Right" dataformatstring="{0:F2}" HeaderStyle-Wrap="False" />
--%>

            <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

<%--            <asp:TemplateField HeaderText="Listo" SortExpression="Listo">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ConfirmadoPorWeb") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>


<%--            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
--%>            

            <asp:BoundField DataField="Confecciono" HeaderText="Confecciono" />
            <asp:BoundField DataField="Aprobo" HeaderText="Aprobo" />
            <asp:BoundField DataField="Monto previsto" HeaderText="Monto previsto" />
            <asp:BoundField DataField="MontoParaCompra" HeaderText="Monto p/cmpra" />
            <%--<asp:BoundField DataField="Cant_Sol_" HeaderText="Cant_Sol_" />--%>
            

            
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"  Wrap="False" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
<%--    </div>
--%>    
    
    
    
<%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    
    <%--    datasource de grilla principal--%>
    
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ComparativaManager"
        DeleteMethod="Delete" UpdateMethod="Save">
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
        DeleteMethod="Delete" UpdateMethod="Save"  >
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

</div></td></tr></table>
</ContentTemplate></asp:UpdatePanel>
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
                <asp:Label ID="Label15" runat="server" Text="Filtrar por Cuenta" 
                    ForeColor="White"></asp:Label>
            </td>

            <td style="width: 197px; height: 32px;">
                <asp:DropDownList ID="cmbCuenta" runat="server" Width="218px" 
                    AutoPostBack="True" Height="22px" style="margin-left: 0px" />
            </td>
            </tr>

        <tr>
        
        <td style="width: 132px">
            <asp:Label ID="Label2" runat="server" Text="Reposicion Solicitada" 
                    ForeColor="White" ></asp:Label>
        </td>            
        <td style="width: 197px">
            
            <asp:Label ID="txtReposicionSolicitada" runat="server" Width="80px" ForeColor="White" ></asp:Label>
                
        </td>
        </tr>

        <tr>
        <td style="width: 132px">
        <asp:Label ID="Label4" runat="server" Text="Fondos asignados" 
                ForeColor="White" ></asp:Label>
        </td>            
        
        <td style="width: 197px">
            <asp:Label ID="txtTotalAsignados" runat="server" Width="80px" ForeColor="White" ></asp:Label>
        </td>            
        
        </tr>

        <tr>
        <td style="width: 132px">

        <asp:Label ID="Label5" runat="server" Text="Pendientes de reintegrar" 
                ForeColor="White" Width="145px" Height="16px"></asp:Label>
        </td>
            <td style="width: 197px">
        <asp:Label ID="txtPendientesReintegrar" runat="server" Width="80px"  ForeColor="White" />
        </td>
        </tr>

        <tr>
        <td style="width: 132px; height: 20px;">
        <asp:Label ID="Label6" runat="server" Text="SALDO" ForeColor="White"></asp:Label>
        </td>
        <td style="width: 197px; height: 20px;">
        <asp:Label ID="txtSaldo" runat="server" Width="80px" ForeColor="White" ></asp:Label>
            
        </td>
        </tr>
        
        <tr> <td style="height: 27px" /></tr>
    </table>
       
    
        


    <%--  campos hidden --%>   
    <asp:HiddenField ID="HFSC" runat="server" /> 
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
  
</asp:Content>
