<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Admin_AsignarEmpresa, App_Web_usbvu22e" title="Pronto Web" theme="Azul" %>

<%@ PreviousPageType VirtualPath="~/Admin/ListadoUsuarios.aspx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div align="center">
                <br />
                <table style="width: 500px" class="t1">
                    <tr>
                        <td class="header" colspan="3">
                            Asignar usuario a empresa
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td valign="top" align="right">
                            <br />
                            <table style="width: 240px" class="t1">
                                <tr>
                                    <td align="left" class="header">
                                        <strong>Usuario WEB</strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 15px" align="center">
                                        <span style="color: #000000"><strong>Nombre:
                                            <asp:DropDownList ID="DDLUser" runat="server" Width="160px" CssClass="imp" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </strong></span>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table style="width: 240px" class="t1">
                                <tr>
                                    <td align="left" class="header">
                                        <strong>Empresa</strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 15px" align="center">
                                        <span style="color: #000000"><strong>Nombre:
                                            <asp:DropDownList ID="DDLEmpresas" runat="server" Width="160px" CssClass="imp" AutoPostBack="True"
                                                DataSourceID="ObjDsEmpresasDes" DataTextField="Descripcion" DataValueField="Id">
                                            </asp:DropDownList>
                                        </strong></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="visibility: hidden; display: none">
                                        Nombre
                                        <asp:TextBox ID="txtNombreEmpresaNueva" runat="server"></asp:TextBox><br />
                                        Usar el mismo servidor que el resto de las bases o poner conexion manual Conexión
                                        <asp:TextBox ID="txtConexionEmpresaNueva" runat="server"></asp:TextBox><br />
                                        <asp:Button ID="Button1" runat="server" CssClass="but" Text="Agregar empresa" /></strong></span>
                                    </td>
                        </td>
                    </tr>
                </table>
                <br />
                <table style="width: 240px">
                    <tr>
                        <td style="height: 15px" align="center">
                            <span style="color: #000000"><strong>
                                <asp:Button ID="ButAsisgnar" runat="server" CssClass="but" Text="Asignar" /></strong></span>
                        </td>
                    </tr>
                </table>
                </td>
                <td valign="top">
                    &nbsp;&nbsp;
                </td>
                <td valign="top">
                    <br />
                    <table class="t1" style="width: 200px">
                        <tr>
                            <td class="header">
                                Empresas
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="LBEmpresas" runat="server" DataSourceID="ObjDSEmpresaPorUsuario"
                                    DataTextField="Descripcion" DataValueField="Id" ForeColor="White" Width="100%"
                                    BackColor="#507CBB" DataTextFormatString="{0}" Font-Bold="True" Height="88px">
                                </asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px; visibility: hidden; display: none;" align="center">
                                <span style="color: #000000"><strong>Usuario PRONTO vinculado:
                                    <asp:DropDownList ID="DropDownList1" runat="server" Width="160px" CssClass="imp"
                                        AutoPostBack="True" DataSourceID="ObjDsEmpresasDes" DataTextField="Descripcion"
                                        DataValueField="Id">
                                    </asp:DropDownList>
                                </strong></span>
                            </td>
                        </tr>
                    </table>
                    &nbsp; &nbsp;&nbsp;
                    <table style="width: 200px">
                        <tr>
                            <td style="height: 15px" align="center">
                                <span style="color: #000000"><strong>
                                    <asp:Button ID="ButDeleteUserInCompany" runat="server" CssClass="but" Text="Desasignar" /></strong></span>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr> </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="ObjDsEmpresasDes" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="EmpresasDesasociadasPorUsuario" TypeName="Pronto.ERP.Bll.EmpresaManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="DDLUser" Name="UserId" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjDSEmpresaPorUsuario" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetEmpresasPorUsuario" TypeName="Pronto.ERP.Bll.EmpresaManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="DDLUser" Name="UserId" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
