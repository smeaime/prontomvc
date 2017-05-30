<%--<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Oops.aspx.vb" Inherits="ProntoWeb_Principal" Title="Pronto Web"
    EnableViewState="False" %>--%>

<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Oops.aspx.vb" Inherits="ProntoWeb_Principal"
    Title="Pronto Web" EnableViewState="False" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server" />
<body style="margin: 20px; background-color: #507CBB; height: 90%; width: 90%; font-family: Lucida Bright;
    background-image: url('<%= imgPath %>'); font-size: 16pt; background-repeat: repeat-x;
    background-attachment: scroll; text-align: center">
    <form id="Form1" runat="server">
    <%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    --%>
    <br />
    <br />
    <br />
    <br />
    <br />
    <span style="color: #f0ffff; font-size: 20pt; font-weight: bold;">Disculpame, tuve un
        problema </span>
    <br />
    <br />
    <br />
    <br />
    <%-- Por favor, llamanos al (011) 4983-0976 --%>
    <br />
    <br />
    El administrador ya recibió detalles del error con tu nombre y la hora <%--con el t�tulo "Usuario Hora"--%>
    <br />
    <br /><br /><br />
    BDL Consultores


       <%-- http://blog.codinghorror.com/crash-responsibly/
           
           
           Let users know that it's our fault, not theirs.
Inform the user that the error was logged and dispatched.
If possible, suggest some workarounds and troubleshooting options.
Perhaps even provide direct contact information if they're really stuck and desperately need to get something done.
           
           
           --%>

<%--    bdlconsultores@
    <br />
    detalles--%>
    <%--Pod�s indicarselo con la descripcion ""
    Usuario   hora
    pagina
    Informacion
    Detalles del error--%>
    <br />
    <br />
    <br />
    <br />
<%--    <asp:HyperLink NavigateUrl="../ProntoWeb/Principal.aspx" Text="Volver a la p�gina principal"
        runat="server" TabIndex="-1" ForeColor="#2200C1" Font-Size="" ID="lnkBDL"></asp:HyperLink>--%>

        <a href='javascript:history.go(-1)'  >Volver a la p�gina anterior</a>
        

<%--        volve a intentar lo que hiciste

        podes ir a nuestra web de reclamos--%>
    <br />
    <br />
    <br />

     <asp:LoginView ID="LoginView" runat="server">
                                                <LoggedInTemplate>
                                                  <%--  <asp:LoginName ID="LoginName1" runat="server" Font-Bold="false" CssClass="margender" />
                                                    |--%>
                                                    <asp:LoginStatus ID="LoginStatus1" runat="server" Font-Bold="false" ForeColor="white"
                                                        LogoutAction="RedirectToLoginPage" LogoutPageUrl="~/Login.aspx" OnLoggedOut="LoginStatus1_LoggedOut"
                                                        TabIndex="-1" LogoutText="Salir" Font-Underline="False" CssClass="margender" />
                                                </LoggedInTemplate>
                                            </asp:LoginView>

     
     <asp:LinkButton runat="server"  ID="lnkLogOut" visible=false> Salir del sistema</asp:LinkButton>

    <%--si no eligi� empresa, no hay que redirigirlo al principal!!!--%>


    <%--http://www.bestbusinesssoftware.info/accounting-billing-software/microsoft-office-accounting-express-2008/--%>
    <%--                   Informes      <asp:DropDownList ID="DropDownList2" runat="server" >
                       <asp:ListItem>Almacen</asp:ListItem>
                       <asp:ListItem>Compras</asp:ListItem>
        </asp:DropDownList>
                   <asp:DropDownList ID="DropDownList1" runat="server" >
                       <asp:ListItem>Vales Emitidos no Retirados</asp:ListItem>
                       <asp:ListItem>Notas de Pedido Pendientes</asp:ListItem>
                       <asp:ListItem>Requerimientos y Listas de Acopio</asp:ListItem>
        </asp:DropDownList>--%>
    <br />
    <br />
    <br />
    <asp:HiddenField ID="HFSC" runat="server" />
    <%--</asp:Content>--%>
    </form>
</body>
</html>
