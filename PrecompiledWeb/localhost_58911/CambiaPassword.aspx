<%@ page language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="CambiaPassword, App_Web_qnramtbm" title="Pronto Web" theme="Azul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
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
                                        UserNameRequiredErrorMessage="Se requiere el nombre de usuario."
                                         
                                         OnChangedPassword="ChangePassword1_ChangedPassword"
                                        >
                                        <CancelButtonStyle BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" />
                                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                        <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
                                        <ChangePasswordButtonStyle BackColor="#FFFBFF" BorderWidth="1px" Font-Names="Verdana"
                                            Font-Size="0.8em" ForeColor="#284775" />
                                        <ContinueButtonStyle BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em"
                                            ForeColor="#284775" />
                                        <MailDefinition BodyFileName="~/CambioPassword-email.txt" From="soporte@bdlconsultores.com.ar"
                                            Subject="Cambio de contrase&#241;a - ProntoWEB">
                                        </MailDefinition>
                                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                                        <TextBoxStyle Font-Size="0.8em" />  
                                    </asp:ChangePassword>


                                   
</asp:Content>

