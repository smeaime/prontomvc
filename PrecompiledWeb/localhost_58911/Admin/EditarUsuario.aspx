<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Admin_EditarUsuario, App_Web_usbvu22e" title="Editar usuario" validaterequest="false" theme="Azul" %>

<%@ PreviousPageType VirtualPath="~/Admin/ListadoUsuarios.aspx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Conten" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <br />
        <table style="padding: 0px; border: none; width: 700px; height: 62px; margin-right: 0px;"
            cellpadding="3" cellspacing="3" class="EncabezadoCell">
            <tr>
                <td colspan="3" style="border: thin none; font-weight: bold; font-size: medium; height: 37px;"
                    align="left" valign="top">
                    <asp:Label ID="lblTitulo" ForeColor="" runat="server" Text="USUARIO" Font-Size="Large"
                        Height="22px" Width="356px" Font-Bold="True"></asp:Label>
                </td>
                <%--<tr >
                        <td class="" colspan="2">
                            Editar Usuario&nbsp;
                        </td>
                    </tr>
                --%></tr>
            <tr>
                <td style="width: 91px; height: 15px" align="right">
                    Usuario
                </td>
                <td style="height: 15px">
                    &nbsp;<asp:Label ID="LblNombre" runat="server" Font-Bold="True" Font-Size="10pt"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 91px" align="right">
                    Email
                </td>
                <td>
                    <asp:TextBox ID="TxTEmail" runat="server" CssClass="" ValidationGroup="Validate"
                        Width="225px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ControlToValidate="TxTEmail"
                        ErrorMessage="*" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="visibility: hidden; display: none;">
                <td style="width: 91px" align="right">
                    Cambiar contrase�a
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="" ValidationGroup="Validate"
                        Width="225px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxTEmail"
                        ErrorMessage="*" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div>
                                <br />
                                <table class="" style="width: 200px">
                                    <tr>
                                        <td class="">
                                            Empresas
                                            <asp:DropDownList ID="DDLEmpresas" runat="server" Width="160px" CssClass="" AutoPostBack="True"
                                                DataSourceID="ObjDsEmpresasDes" DataTextField="Descripcion" DataValueField="Id">
                                            </asp:DropDownList>
                                            <asp:Button ID="ButAsisgnar" runat="server" CssClass="butcancela" Text="Asignar" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="LBEmpresas" runat="server" DataSourceID="ObjDSEmpresaPorUsuario"
                                                DataTextField="Descripcion" DataValueField="Id" Width="100%" DataTextFormatString="{0}"
                                                Font-Bold="True" Height="88px"></asp:ListBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 15px; visibility: hidden; display: none;" align="center">
                                            <span style="color: #000000"><strong>Usuario PRONTO vinculado:
                                                <asp:DropDownList ID="DropDownLis" runat="server" Width="160px" CssClass="" AutoPostBack="True"
                                                    DataSourceID="ObjDsEmpresasDes" DataTextField="Descripcion" DataValueField="Id">
                                                </asp:DropDownList>
                                            </strong></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 15px" align="center">
                                            <span style="color: #000000"><strong>
                                                <asp:Button ID="ButDeleteUserInCompany" runat="server" CssClass="butcancela" Text="Desasignar" /></strong></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="width: 50px;">
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div>
                                <br />
                                <br />
                                <table class="" style="width: 200px">
                                    <tr>
                                        <td style="height: 15px" align="center">
                                            <span style="color: #000000"><strong>Rol:
                                                <asp:DropDownList ID="DropDownList3" runat="server" Width="160px" CssClass="" AutoPostBack="True">
                                                </asp:DropDownList>
                                                <asp:Button ID="btnAsignarRol" runat="server" CssClass="butcancela" Text="Asignar rol" />
                                            </strong></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="ListBox1" runat="server" Width="100%" DataTextFormatString="{0}"
                                                Font-Bold="True" Height="88px"></asp:ListBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 15px; visibility: hidden; display: none;" align="center">
                                            <span style="color: #000000"><strong>Usuario PRONTO vinculado:
                                                <asp:DropDownList ID="DropDownList4" runat="server" Width="160px" CssClass="" AutoPostBack="True"
                                                    DataSourceID="ObjDsEmpresasDes" DataTextField="Descripcion" DataValueField="Id">
                                                </asp:DropDownList>
                                            </strong></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 15px" align="center">
                                            <span style="color: #000000"><strong>
                                                <asp:Button ID="Button4" runat="server" CssClass="butcancela" Text="Desasignar rol" /></strong></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 91px" align="right">
                </td>
            </tr>
            <tr>
                <td style="width: 91px" align="right">
                </td>
            </tr>
            <tr>
                <td style="width: 91px" align="right">
                </td>
                <td>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:ChangePassword ID="ChangePassword1" runat="server" BorderPadding="4" BorderStyle="Solid"
                                BorderWidth="1px" CancelButtonText="Cancelar" ChangePasswordButtonText="Cambiar contrase�a"
                                ChangePasswordFailureText="Contrase�a incorrecta o nueva contrase�a inv�lida. Longitud m�nima de la nueva contrase�a: {0}. Se requieren caracteres no alfanum�ricos: {1}."
                                ChangePasswordTitleText="Cambie su contrase�a" ConfirmNewPasswordLabelText="Confirme nueva contrase�a:"
                                ConfirmPasswordCompareErrorMessage="La nueva contrase�a y su confirmaci�n deben coincidir."
                                ConfirmPasswordRequiredErrorMessage="Se requiere la confirmaci�n de la nueva contrase�a."
                                ContinueButtonText="Continuar" Font-Names="Verdana" Font-Size="12px" NewPasswordLabelText="Nueva contrase�a:"
                                NewPasswordRegularExpressionErrorMessage="Por favor ingrese una contrase�a diferente."
                                NewPasswordRequiredErrorMessage="Se requiere una nueva contrase�a." PasswordLabelText="Contrase�a:"
                                PasswordRequiredErrorMessage="Se requiere contrase�a." SuccessText="Su contrase�a ha sido cambiada!"
                                SuccessTitleText="Cambio de contrase�a finalizado" UserNameLabelText="Nombre de usuario:"
                                UserNameRequiredErrorMessage="Se requiere el nombre de usuario." Visible="false">
                                <CancelButtonStyle BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" />
                                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
                                <ChangePasswordButtonStyle BackColor="#FFFBFF" BorderWidth="1px" Font-Names="Verdana"
                                    Font-Size="0.8em" ForeColor="#284775" />
                                <ContinueButtonStyle BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
                                    ForeColor="#284775" />
                                <MailDefinition BodyFileName="~/CambioPassword-email.txt" CC="fido@acm.org" From="fido@garciastrauss.com"
                                    Subject="Cambio de contrase&#241;a - Cedinsa - ProntowEB">
                                </MailDefinition>
                                <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" />
                                <TextBoxStyle Font-Size="0.8em" />
                            </asp:ChangePassword>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr style="visibility: hidden; display: none;">
                <td style="width: 91px" align="right">
                    Confirmar contrase�a
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="" ValidationGroup="Validate"
                        Width="225px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxTEmail"
                        ErrorMessage="*" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr id="RenglonCliente" runat="server">
                <td style="width: 91px" align="right">
                    Cliente relacionado
                </td>
                <td>
                    <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="" ValidationGroup="Validate"
                        Width="225px"></asp:TextBox>
                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                        CompletionSetCount="12" TargetControlID="txtRazonSocial" MinimumPrefixLength="1"
                        ServiceMethod="GetCompletionList" ServicePath="~/ProntoWeb/WebServiceClientes.asmx"
                        UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                        DelimiterCharacters="" Enabled="True">
                    </cc1:AutoCompleteExtender>
                </td>
            </tr>
            <tr style="visibility: hidden; display: none;">
                <td style="width: 91px" align="right">
                    <strong><span style="color: #ffffff">Rol: &nbsp;</span></strong>
                </td>
                <td>
                    <asp:DropDownList ID="DDLRoles" runat="server" CssClass="" Width="230px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <br />
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="gvModulos" runat="server" AutoGenerateColumns="False" ShowFooter="false"
            DataKeyNames="IdDetalleUserPermisos" AllowPaging="False" AllowSorting="True"
            PageSize="10" Visible="true" HeaderStyle-CssClass="headerGrid" HeaderStyle-Wrap="true">
            <%--                OnRowDataBound="GridView1_RowDataBound" 
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing" 
                OnRowUpdating="GridView1_RowUpdating" 
                OnRowCommand="GridView1_RowCommand"
                OnRowDeleting="GridView1_RowDeleting" 
            --%>
            <Columns>
                <asp:TemplateField HeaderText="Modulo">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Bind("Modulo") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewDireccion" runat="server"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDireccion" runat="server" Text='<%# Bind("Modulo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="true">
                    <HeaderTemplate>
                        <asp:CheckBox ID="hCheckBox1" runat="server" Text="Leer" Enabled="false" />
                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                    </HeaderTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="hCheckBox1" runat="server" />
                        <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                        --%>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("PuedeLeer") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="true">
                    <HeaderTemplate>
                        <asp:CheckBox ID="hCheckBox2" runat="server" Text="Editar" Enabled="false" />
                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                    </HeaderTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="hCheckBox2" runat="server" />
                        <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                        --%>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("PuedeModificar") %>'
                            Visible='<%# IIf(Eval("Modulo") <> "CDPs VerHistorial" And Eval("Modulo") <> "CDPs VerFacturaImputada" And Eval("Modulo") <> "CDPs ImagenesDescarga", True, False)%>' />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="true">
                    <HeaderTemplate>
                        <asp:CheckBox ID="hCheckBox3" runat="server" Text="Eliminar" Enabled="false" />
                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                    </HeaderTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="hCheckBox3" runat="server" />
                        <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                        --%>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Eval("PuedeEliminar") %>'
                            Visible='<%# IIf(Eval("Modulo") <> "CDPs VerHistorial" And Eval("Modulo") <> "CDPs VerFacturaImputada" And Eval("Modulo") <> "CDPs ImagenesDescarga", True, False)%>' />  
                         
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="true">
                    <HeaderTemplate>
                        <asp:CheckBox ID="hCheckBox22" runat="server" Text="Instalado (solo Superadmin)"
                            Enabled="false" />
                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                    </HeaderTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="hCheckBox22" runat="server" Checked='<%# iisnull(Eval("Instalado"),false) %>' />
                        <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                        --%>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox22" runat="server" Checked='<%#  iisnull(Eval("Instalado"),false) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:GridView>
    </div>
    <asp:ObjectDataSource ID="ObjDsEmpresasDes" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="EmpresasDesasociadasPorUsuario" TypeName="Pronto.ERP.Bll.EmpresaManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="DDLUser" Name="UserId" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjDSEmpresaPorUsuario" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetEmpresasPorUsuario" TypeName="Pronto.ERP.Bll.EmpresaManager">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="DDLUser" Name="UserId" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <br />
    <div style="visibility: hidden; display: none">
        <asp:DropDownList ID="DDLUser" runat="server" Width="160px" CssClass="" AutoPostBack="True"
            Enabled="False" Visible="false" />
        Nombre
        <asp:TextBox ID="txtNombreEmpresaNueva" runat="server"></asp:TextBox><br />
        Usar el mismo servidor que el resto de las bases o poner conexion manual Conexi�n
        <asp:TextBox ID="txtConexionEmpresaNueva" runat="server"></asp:TextBox><br />
        <asp:Button ID="Button1" runat="server" CssClass="butcancela" Text="Agregar empresa" /></strong></span>
    </div>
    <div style="visibility: hidden; display: none">
        Nombre
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br />
        Usar el mismo servidor que el resto de las bases o poner conexion manual Conexi�n
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox><br />
        <asp:Button ID="Button2" runat="server" CssClass="butcancela" Text="Agregar empresa" /></strong></span>
    </div>
    <asp:Button ID="ButAceptar" runat="server" CssClass="but" Text="Aceptar" ValidationGroup="Validate" />
    <asp:Button ID="ButCancelar" runat="server" CssClass="butcancela" Text="Cancelar" /><br />
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
