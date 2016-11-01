<%@ page language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="CambiaPassword, App_Web_beddljq5" title="Pronto Web" theme="Azul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
     <asp:ChangePassword ID="ChangePassword1" runat="server" BorderPadding="4" BorderStyle="Solid"
                                        BorderWidth="1px" CancelButtonText="Cancelar" ChangePasswordButtonText="Cambiar contraseña"
                                        ChangePasswordFailureText="Contraseña incorrecta o nueva contraseña inválida. Longitud mínima de la nueva contraseña: {0}. Se requieren caracteres no alfanuméricos: {1}."
                                        ChangePasswordTitleText="Cambie su contraseña" ConfirmNewPasswordLabelText="Confirme nueva contraseña:"
                                        ConfirmPasswordCompareErrorMessage="La nueva contraseña y su confirmación deben coincidir."
                                        ConfirmPasswordRequiredErrorMessage="Se requiere la confirmación de la nueva contraseña."
                                        ContinueButtonText="Continuar" Font-Names="Verdana" Font-Size="12px" NewPasswordLabelText="Nueva contraseña:"
                                        NewPasswordRegularExpressionErrorMessage="Por favor ingrese una contraseña diferente."
                                        NewPasswordRequiredErrorMessage="Se requiere una nueva contraseña." PasswordLabelText="Contraseña:"
                                        PasswordRequiredErrorMessage="Se requiere contraseña." SuccessText="Su contraseña ha sido cambiada!"
                                        SuccessTitleText="Cambio de contraseña finalizado" UserNameLabelText="Nombre de usuario:"
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

