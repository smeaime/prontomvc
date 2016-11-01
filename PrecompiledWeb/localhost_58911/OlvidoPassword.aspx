<%@ page language="VB" autoeventwireup="true" inherits="OlvidoContrasena, App_Web_vgepxpq2" title="Pronto Web" theme="Azul" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
</head>
<body id="Body1" runat="server">
    <form id="form1" runat="server"  style="text-align:center; vertical-align: center; width: 95%; height: 95%">
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" BackColor="#F7F6F3" BorderColor="#E6E2D8"
        BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"
        Font-Size="0.8em" GeneralFailureText="Su intento de obtener la contraseña no fue exitoso.Por favor inténtelo nuevamente."
        QuestionFailureText="Su respuesta no pudo ser verificada. Por favor inténtelo nuevamente."
        QuestionInstructionText="Responda la siguiente pregunta para recibir su contraseña."
        QuestionLabelText="Pregunta:" QuestionTitleText="Confirmación de identidad" SubmitButtonText="Enviar"
        SuccessText="Su contraseña ya le fue enviada por e-mail." UserNameFailureText="No podemos acceder a su información. Por favor inténtelo nuevamente."
        UserNameInstructionText="Ingrese el nombre de usuario para obtener su contraseña." OnSendingMail="PasswordRecovery1_SendingMail"
        UserNameLabelText="Nombre de usuario:" UserNameRequiredErrorMessage="Se requiere el nombre de usuario."
        UserNameTitleText="Olvidó su contraseña?" AnswerLabelText="Respuesta:" AnswerRequiredErrorMessage="Se requiere la respuesta.">
        <%--     <maildefinition cc="fido@acm.org" from="fido@garciastrauss.com" subject="Recupero de Contrasena - Cedinsa - ProntowEB"
            bodyfilename="~/OlvidoPassword-email.txt">
        </maildefinition>--%>
        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
        <SuccessTextStyle Font-Bold="True" ForeColor="#5D7B9D" />
        <TextBoxStyle Font-Size="0.8em" />
        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
        <SubmitButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
    </asp:PasswordRecovery>
    </form>
</body>
</html>
