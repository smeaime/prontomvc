<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CreaUsuario.aspx.cs" Inherits="CreaUsuario" Title="Pronto Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" AnswerLabelText="Respuesta de seguridad:"
        AnswerRequiredErrorMessage="Se requiere respuesta de seguridad." AutoGeneratePassword="True"
        BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="1px"
        CancelButtonText="Cancelar" CompleteSuccessText="La cuenta ha sido exitosamente creada."
        ConfirmPasswordCompareErrorMessage="La contraseña y su confirmación deben coincidir."
        ConfirmPasswordLabelText="Confirme la contraseña:" ConfirmPasswordRequiredErrorMessage="Se requiere la confirmación de la contraseña."
        ContinueButtonText="Continuar" CreateUserButtonText="Crear Usuario" DuplicateEmailErrorMessage="El e-mail que ha ingresado está en uso. Por favor ingrese un e-mail diferente."
        DuplicateUserNameErrorMessage="Por favor ingrese un nombre de usuario diferente."
        EmailRegularExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
        EmailRegularExpressionErrorMessage="Por favor ingrese un  e-mail diferente."
        EmailRequiredErrorMessage="Se require un E-mail." FinishCompleteButtonText="Finalizar"
        FinishPreviousButtonText="Anterior" Font-Names="Verdana" Font-Size="0.8em" InvalidAnswerErrorMessage="Por favor ingrese una respuesta de seguridad diferente."
        InvalidEmailErrorMessage="Por favor ingrese un e-mail válido." InvalidPasswordErrorMessage="Longitud mínima de la contraseña: {0}. Caracteres no alfanuméricos requiridos: {1}."
        InvalidQuestionErrorMessage="Por favor ingrese una pregunta de seguridad diferente."
        PasswordLabelText="Contraseña:" PasswordRegularExpressionErrorMessage="Por favor ingrese una contraseña diferente."
        PasswordRequiredErrorMessage="Se require una contraseña." QuestionLabelText="Pregunta de seguridad:"
        QuestionRequiredErrorMessage="Se requiere una pregunta de seguridad." StartNextButtonText="Próximo"
        StepNextButtonText="Próximo" StepPreviousButtonText="Anterior" UnknownErrorMessage="Su cuenta no fue creada. Por favor inténtelo nuevamente."
        UserNameLabelText="Nombre de usuario:" UserNameRequiredErrorMessage="Se require un nombre de usuario." Height="154px" OnCreatedUser="CreateUserWizard1_CreatedUser">
        <WizardSteps>
            <asp:CreateUserWizardStep runat="server" Title="Registre su cuenta Pronto Web">
                <ContentTemplate>
                    <table border="0" style="font-size: 100%; font-family: Verdana; height: 154px">
                        <tr>
                            <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #5d7b9d; height: 18px;">
                                Registre su cuenta Pronto</td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 175px">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Nombre de usuario:</asp:Label></td>
                            <td style="width: 179px">
                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ErrorMessage="Se require un nombre de usuario." ToolTip="Se require un nombre de usuario."
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 175px">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label></td>
                            <td style="width: 179px; height: 26px">
                                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                    ErrorMessage="Se require un E-mail." ToolTip="Se require un E-mail." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2" style="width: 166px; height: 13px">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #5d7b9d">
                                Por si se olvida su contraseña</td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 175px">
                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Pregunta de seguridad:</asp:Label></td>
                            <td style="width: 179px">
                                <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                    ErrorMessage="Se requiere una pregunta de seguridad." ToolTip="Se requiere una pregunta de seguridad."
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 175px">
                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Respuesta de seguridad:</asp:Label></td>
                            <td style="width: 179px">
                                <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                    ErrorMessage="Se requiere respuesta de seguridad." ToolTip="Se requiere respuesta de seguridad."
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color: red; height: 18px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #5d7b9d; height: 18px;">
                                Seleccione la empresa</td>
                        </tr>
                        <tr>
                            <td align="center" style="width: 179px; height: 24px;" colspan="2">
                                &nbsp;
                                <asp:DropDownList ID="IdProveedor" runat="server">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Answer"
                                    ErrorMessage="Se requiere respuesta de seguridad." ToolTip="Se requiere respuesta de seguridad."
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color: red; height: 18px">
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color: red; height: 18px">
                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep runat="server" Title="Registro completo">
            </asp:CompleteWizardStep>
        </WizardSteps>
        <SideBarStyle BackColor="#5D7B9D" BorderWidth="0px" Font-Size="0.9em" VerticalAlign="Top" />
        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
        <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
        <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em"
            ForeColor="White" HorizontalAlign="Center" />
        <CreateUserButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
        <MailDefinition BodyFileName="~/CreaUsuario-email.txt" CC="fido@acm.org"
            From="fido@garciastrauss.com" Subject="Pronto Web: Cuenta registrada">
        </MailDefinition>
        <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
        <StepStyle BorderWidth="0px" />
    </asp:CreateUserWizard>
    &nbsp;
</asp:Content>

