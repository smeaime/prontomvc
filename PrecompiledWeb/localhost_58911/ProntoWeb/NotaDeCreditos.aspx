<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="NotasDeCredito, App_Web_jwihcld1" title="Notas de Credito" theme="Azul" %>

<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" 
tagprefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
        
    
   
          <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
    
    <asp:LinkButton ID="lnkNuevo" runat="server" Font-Bold="True" 
        Font-Underline="False" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="30px" Width="95px" Visible="true">+   Nuevo</asp:LinkButton>
    
                    <asp:Label ID="Label12" runat="server" Text="Buscar " 
        ForeColor="White" style="text-align: right" Visible="False"></asp:Label>
                                     <asp:TextBox ID="txtBuscar" runat="server" 
        style="text-align: right; " Text="" AutoPostBack="True"></asp:TextBox>  
   
    
    
        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Height="22px" 
            Style="text-align: right; margin-left: 0px;" Width="119px">
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Fecha" Value="[Fecha credito]" />
                <asp:ListItem Text="Cliente" Value="Cliente" />
                <asp:ListItem Text="Anulada" Value="Anulada" />
                <asp:ListItem Text="Total" Value="Total" />
        </asp:DropDownList>
   
    
                <table width="700">
                <tr>
                    <td align="left">
                        <div style="width: 700px; overflow: auto;">
    <asp:GridView ID="GridView1"  
        runat="server" AutoGenerateColumns="False" BackColor="White"
        BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" 
        CellPadding="3" DataKeyNames="Id"
        DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" 
        Width="700px" PageSize="8" >
               
        
        
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <Columns>
            
                        <asp:CommandField ShowEditButton="True" EditText="Ver" />

            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" Visible="False" />
            
            
            
            
            
                        <asp:BoundField DataField="A/B/E" HeaderText="" />
            <asp:BoundField DataField="Pto_vta_" HeaderText="" />

            <%--Eval("A/B/E") & " "& "-" &--%>

            <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                </EditItemTemplate>
                
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                <EditItemTemplate>
                    &nbsp;&nbsp;
                    <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("[Fecha credito]") %>'></asp:Calendar>
                </EditItemTemplate>
                <ControlStyle Width="100px" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Fecha credito]", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            

            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            
                 <%--& Eval("[]") --%>
            
            <asp:BoundField DataField="Anulada" HeaderText="Anulada" />
            <asp:BoundField DataField="Total credito" HeaderText="Total" />
            
            
            

            
<%--                        <asp:BoundField DataField="Cump." HeaderText="Cump." />

            
            <asp:TemplateField HeaderText="Obra" SortExpression="Obra">
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
            <asp:TemplateField  HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                <ItemTemplate>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <Columns>
                            <asp:BoundField DataField="Concepto" HeaderText="Concepto" ItemStyle-Width="300">
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
                        <HeaderStyle CssClass="GrillaAnidadaHeaderStyle"/>
                    </asp:GridView>
                </ItemTemplate>
                <ControlStyle BorderStyle="None" />
            </asp:TemplateField>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
            
            <asp:BoundField DataField="Tipo" HeaderText="Tipo"  />

            <asp:BoundField DataField="Cod_Cli_" HeaderText="Cod.Cli."  />
            <asp:BoundField DataField="Condicion IVA" HeaderText="Condicion IVA"  />
            <asp:BoundField DataField="Cuit"  HeaderText="Cuit" />
            <asp:BoundField DataField="Neto gravado"  HeaderText="Neto gravado"   />
            <asp:BoundField DataField="Iva"   HeaderText="Iva"  />
            <asp:BoundField DataField="Perc_IVA" HeaderText="Perc_IVA"  />
            <asp:BoundField DataField="Total credito" HeaderText="Total credito"  />
            <asp:BoundField DataField="Mon_" HeaderText="Mon_"  />
            <asp:BoundField DataField="Obra"  HeaderText="Obra" />
            <asp:BoundField DataField="Provincia destino"  HeaderText="Provincia destino" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones"  />
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor"  />
            <asp:BoundField DataField="Fecha anulacion"  HeaderText="Fecha anulacion" />
            <asp:BoundField DataField="Ingreso"  HeaderText="Ingreso" />
            <asp:BoundField DataField="Fecha ingreso"  HeaderText="Fecha ingreso" />
            
            
            
        </Columns>
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"  Wrap="False" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    </asp:GridView>
    
    </div></td></tr></table>
    
    
    
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.NotaDeCreditoManager" DeleteMethod="Delete" UpdateMethod="Save">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="SC" Type="String" />
            <asp:Parameter Name="myNotaDeCredito" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SC" Type="String" />
            <asp:Parameter Name="myNotaDeCredito" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.NotaDeCreditoManager" DeleteMethod="Delete" UpdateMethod="Save">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="SC" Type="String" />
            <asp:Parameter Name="myNotaDeCredito" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SC" Type="String" />
            <asp:Parameter Name="myNotaDeCredito" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="HFSC" runat="server" />
    </ContentTemplate></asp:UpdatePanel>
    
        <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    
<%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/NotaDeCreditos" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\NotaDeCreditos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>


</asp:Content>

