<%@ page language="VB" autoeventwireup="false" inherits="CDPStockMovimientos, App_Web_d4k2rr1t" title="Seguimiento de bugs y desarrollo" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server" />
<body style="margin: 20px; background-repeat: repeat-x; background-attachment: scroll;">
    <form id="form1" runat="server">
    <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
        EnablePageMethods="False" AsyncPostBackTimeout="360000" ScriptMode="Release">
    </ajaxToolkit:ToolkitScriptManager>
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:Panel Height="62px" runat="server" Wrap="False" Visible="false">
                </asp:Panel>
                <%--<hr style="border-color: #FFFFFF; width: 160px; color: #FFFFFF;" align="left" size="1" />--%>
                <table>
                    <tr>
                        <td align="left">
                            <div style="overflow: auto; margin-top: 4px;">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    DataKeyNames="IdReclamo" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
                                    CellPadding="15" DataSourceID="SqlDataSource1" GridLines="Horizontal" AllowPaging="True"
                                    Width="1000px" PageSize="50" EnableModelValidation="True" Font-Size="Medium">
                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                    <Columns>
                                        <asp:BoundField DataField="IdReclamo" HeaderText="Prioridad" Visible="false" />


                                        <asp:ButtonField CommandName="ver" Text="..." visible=false />

                                                <asp:ButtonField CommandName="arriba" Text="↑" visible=true   ControlStyle-Font-Underline=false/>

                                        <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="NUMERO" SortExpression="NumeroCartaDePorte"
                                             ItemStyle-Wrap="true" >
                                            <ItemTemplate>
                                        
                                                <%--http://forums.asp.net/t/1120329.aspx--%>
                                                <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" 
                                                NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdReclamo") %>'
                                                    Text='<%# Eval("IdReclamo")   %>'> </asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:ButtonField CommandName="abajo" Text="↓" visible=true  ControlStyle-Font-Underline=false/>
                                        <%--                                        <asp:BoundField DataField="IdReclamo" HeaderText="En desarrollo" ItemStyle-Font-Bold="true" />--%>
                                     
                                        <asp:TemplateField HeaderText="DEAD LINE" SortExpression="FechaNecesidad" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3331" runat="server" Text='<%# Bind("FechaNecesidad",  "{0:d MMM}" ) %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TituloReclamo" />
                                        <asp:BoundField DataField="TituloReclamo" HeaderText="Obs.               Obs    .        Obs   . Obs_________________________________________ "
                                            ItemStyle-Width="400" ControlStyle-Width="400" HeaderStyle-Width="400" />
                                        <asp:BoundField DataField="Producto" Visible="false" />
                                        <asp:BoundField DataField="Descripcion" Visible="false" />
                                        <asp:BoundField DataField="Empresa" HeaderText="Dificultad" />
                                        <asp:BoundField DataField="Empresa" Visible="false" />
                                        <asp:BoundField DataField="FechaAlta" HeaderText="hace 2d" Visible="false" />
                                        <asp:ButtonField CommandName="SubeDias" Text="bug/dev +dias" HeaderText="Bug o Request" />
                                        <asp:BoundField DataField="Prioridad" Visible="false" />
                                        <asp:BoundField DataField="Estado" Visible="false" />
                                        <asp:BoundField DataField="SectorAsignado" Visible="true" HeaderText="Hs estimadas / Hs usadas"
                                            HeaderStyle-Width="30px" />
                                        <asp:BoundField DataField="Responsable" Visible="false" />
                                        <asp:BoundField DataField="Diferencia" Visible="false" />
                                        <asp:ButtonField CommandName="SubePrioridad" Text="+" />
                                    </Columns>
                                    <RowStyle BackColor="white" ForeColor="#4A3C8C" VerticalAlign="Middle" Font-Names="Arial"
                                        Font-Size="Large" HorizontalAlign="Center" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                    <HeaderStyle BackColor="white" Font-Bold="false" ForeColor="black" Wrap="true" BorderWidth="0" />
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
    </div>
    </form>
</body>
</html>
