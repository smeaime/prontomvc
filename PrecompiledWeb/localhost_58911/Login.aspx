<%@ page language="VB" autoeventwireup="false" inherits="Login, App_Web_o5iuukpz" title="ProntoWeb" theme="Azul" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />
    <%--<link rel="shortcut icon" type="image/ico" href="Imagenes/favicon.ico" />--%>
    <link rel="shortcut icon" type="image/ico" href="favicon.png" />
    <%--<script language="JavaScript">
//http://4guysfromrolla.com/webtech/082400-1.shtml


function cc()
{
 /* check for a cookie */
  if (document.cookie == "") 
  {
    /* if a cookie is not found - alert user -
     change cookieexists field value to false */
    alert("COOKIES need to be enabled!");

    /* If the user has Cookies disabled an alert will let him know 
        that cookies need to be enabled to log on.*/ 

    document.Form1.cookieexists.value ="false"  
  } else {
   /* this sets the value to true and nothing else will happen,
       the user will be able to log on*/
    document.Form1.cookieexists.value ="true"
  }
}

/* Set a cookie to be sure that one exists.
   Note that this is outside the function*/
document.cookie = 'killme' + escape('nothing')

    </script>--%>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-12882984-2']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

    </script>
</head>
<%--<body class="cssLogin" style="background-image: url('<%= imgPath %>'); height: 95%" onload="cc()" >--%>
<body class="cssLogin" style="height: 100%; overflow: hidden;" onload="cc()">
    <%--esto del onload para lo de revisar si esta habilitado javascript--%>
    <center>
        <form id="form1" runat="server">
        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
            EnablePageMethods="False" AsyncPostBackTimeout="360000">
        </ajaxToolkit:ToolkitScriptManager>
        <br />
        <br />
        <br />
        <table style="border-style: none; font-family: arial,sans-serif;" width="980px">
            <tr>
                <td width="20">
                </td>
                <td align="centre" width="" style="margin-left: 0px">
                    <asp:Panel ID="PanelBDL" runat="server" HorizontalAlign="Center">
                        <div>
                            <%--                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    bdl
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////--%>
                            <div align="centre">
                                <asp:Image ID="LogoImage" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                    Height="130px" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 0px"
                                    Visible="false" Width="400px" />
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 200px">
                                            <asp:Image ID="Image13" runat="server" Width="200px" ImageUrl="~/Imagenes/logosolo.gif"
                                                CssClass="LoginLogo" />
                                        </td>
                                        <td style="width: 200px">
                                            <div style="text-align: left; font-size: 32px; width: 200px; font-family: Verdana, Arial, Helvetica, sans-serif;
                                                color: #CC3300; font-weight: bold; text-shadow: #6374AB 3px 3px 5px;">
                                                BDL
                                                <br />
                                                Consultores</div>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <br />
                            <div style="text-align: center; font-size: x-large; width: ; margin-left: 50px; font-family: Tahoma;
                                width: 400px; text-shadow: 0 1px 1px white;">
                                <b>BDL Consultores es la fusi�n de la experiencia</b></div>
                            <div style="text-align: center; font-size: large; width: 400px; margin-left: 50px;
                                font-family: Tahoma;">
                                <br />
                                BDL Consultores es la fusi�n de la experiencia de 5 a�os de trabajo en implementaci�n
                                de sistemas en empresas representantes de soluciones para el �rea T�cnica y Desarrolladores
                                de Sistemas</div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <table style="display: none; text-align: center;">
                            <tr>
                                <td>
                                    <asp:Image ID="Image2" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                    <asp:Image ID="premio" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Representantes de Soluciones</b>
                                    <br />
                                    <br />
                                    para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                    RRHH, Contables y Financieros
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Image ID="Image1" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Representantes de Soluciones</b> para el �rea T�cnica y Desarrolladores de Sistemas
                                    Administrativos, de Producci�n, RRHH, Contables y Financieros
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <%-- <tr style="display:none;">--%>
                                <td>
                                    <asp:Image ID="premio3" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/ProntoWeb/Imagenes/images (1).jpg" Style="margin-top: 5px"
                                        Width="50px" Visible="true" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Casi listo</b>
                                    <br />
                                    <br />
                                    para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                    RRHH, Contables y Financieros
                                </td>
                            </tr>
                        </table>
                        </div>
                    </asp:Panel>
                    <%--                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    esuco
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////--%>
                    <asp:Panel ID="PanelWilliams" runat="server">
                        <div>
                            
                            
                            <style>
                                .LoginLogo2
                                {
                                    width: 489px;
                                    margin-left: 1px;
                                }
                            </style>
                            <div align="left">
                                <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagenes/williamslogin.gif" CssClass="LoginLogo LoginLogo2" />
                                <%--Williams Entregas S.A.--%>
                            </div>
                            
                            <div style="text-align: center; font-size: 28px; width: ; margin-left: 50px; font-family: Tahoma;
                                width: 400px; text-shadow: 0 1px 1px white;">
                                <%--<div style="font-size: x-large; width: 400px; margin-left: 50px; font-family: Tahoma;">--%>
                                Junto a nuestros clientes</b></div>
                            <div style="text-align: center; font-size: 16px; width: 400px; margin-left: 50px;
                                font-family: Tahoma;">
                                <br />
                                Williams Entregas S.A. naci� en 1989 de la mano de nuestros clientes con un objetivo
                                bien definido: estar junto a ellos brind�ndole el mejor servicio.</div>
                            <br />
                            <br />
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image4" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                        <asp:Image ID="Image10" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image11" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <%-- <tr style="display:none;">--%>
                                    <td>
                                        <asp:Image ID="Image12" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/ProntoWeb/Imagenes/images (1).jpg" Style="margin-top: 5px"
                                            Width="50px" Visible="true" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td style="font-size: small">
                                        <b>Casi listo</b>
                                        <br />
                                        para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                        RRHH, Contables y Financieros
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="PanelEsuco" runat="server">
                        <div>
                            <div align="left">
                                <asp:Image ID="Image5" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                    Height="79px" ImageUrl="~/Imagenes/esuco.gif" Style="margin-top: 5px" Width="235px" />
                            </div>
                            <br />
                            <div style="font-size: large">
                                Construir, una pasi�n</div>
                            <div style="font-size: small">
                                <br />
                                ESUCO es una empresa de capitales nacionales, con una trayectoria de m�s de cincuenta
                                a�os de trabajo ininterrumpido en el Pa�s. Con gran participaci�n en el dise�o y
                                construcci�n de obras de infraestructura social y econ�mica</div>
                            <br />
                            <br />
                            <br />
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image6" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                        <asp:Image ID="Image7" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td style="font-size: small">
                                        <b>Representantes de Soluciones</b>
                                        <br />
                                        Tiene presencia en el proceso de apertura al capital privado a trav�s de concesiones
                                        de servicios operando corredores viales en Argentina, Uruguay y Brasil, servicios
                                        de potabilizaci�n y suministro de agua y verificaci�n t�cnica automotriz construcci�n,
                                        operaci�n y mantenimiento de interconexi�n el�ctrica.
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image8" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                            Width="50px" Visible="false" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td style="font-size: small">
                                        <b>Representantes de Soluciones</b>
                                        <br />
                                        para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                        RRHH, Contables y Financieros
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <%-- <tr style="display:none;">--%>
                                    <td>
                                        <asp:Image ID="Image9" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                            Height="50px" ImageUrl="~/ProntoWeb/Imagenes/images (1).jpg" Style="margin-top: 5px"
                                            Width="50px" Visible="true" />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td style="font-size: small">
                                        <b>Casi listo</b>
                                        <br />
                                        para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                        RRHH, Contables y Financieros
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="PanelAutotrol" runat="server" HorizontalAlign="Center">
                        <br />
                        <br />
                        <div>
                            <%--                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    bdl
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////
                    /////////////////////////////////////////////////--%>
                            <div align="centre">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Image ID="Image15" runat="server" Width="420px" ImageUrl="~/Imagenes/autotrolgrande.png"
                                                CssClass="LoginLogo" />
                                        </td>
                                        <td>
                                            <div style="text-align: left; font-size: 32px; font-family: Verdana, Arial, Helvetica, sans-serif;
                                                color: #CC3300; font-weight: bold;">
                                                <br />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <div style="text-align: centre; font-size: x-large; width: 400px; margin-left: 50px;
                            font-family: Tahoma;">
                            <b></b>
                        </div>
                        <div style="text-align: centre; font-size: 16px; width: 400px; margin-left: 50px;
                            font-family: Tahoma;">
                            <br />
                            AUTOTROL S.A. es una empresa argentina que naci� el 10 de octubre de 1962 y que
                            ha hecho realidad la meta fijada en sus comienzos: Desempe�ar un rol protag�nico
                            en el campo de la ingenier�a de la Informaci�n y Control.</div>
                        <br />
                        <br />
                        <br />
                        <table style="display: none;">
                            <tr>
                                <td>
                                    <asp:Image ID="Image16" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                    <asp:Image ID="Image17" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Representantes de Soluciones</b>
                                    <br />
                                    <br />
                                    para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                    RRHH, Contables y Financieros
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Image ID="Image18" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/Imagenes/it-works-award1.png" Style="margin-top: 5px"
                                        Width="50px" Visible="false" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Representantes de Soluciones</b> para el �rea T�cnica y Desarrolladores de Sistemas
                                    Administrativos, de Producci�n, RRHH, Contables y Financieros
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <%-- <tr style="display:none;">--%>
                                <td>
                                    <asp:Image ID="Image19" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
                                        Height="50px" ImageUrl="~/ProntoWeb/Imagenes/images (1).jpg" Style="margin-top: 5px"
                                        Width="50px" Visible="true" />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="font-size: small">
                                    <b>Casi listo</b>
                                    <br />
                                    <br />
                                    para el �rea T�cnica y Desarrolladores de Sistemas Administrativos, de Producci�n,
                                    RRHH, Contables y Financieros
                                </td>
                            </tr>
                        </table>
                        </div>
                    </asp:Panel>
                </td>
                <td>
                </td>
                <td align="right">
                    <div align="center" class="boxLogin" style="border: 1px solid #CCCCFF; width: 290px;
                        height: 245px; background-color: #F0F0FF; color: #000000; vertical-align: middle;">
                        <br />
                        <%--         http://stackoverflow.com/questions/4891655/why-doesnt-the-password-recovery-link-show-up-in-my-login-control--%>
                        <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/SeleccionarEmpresa.aspx"
                            ForeColor="Black" TitleText="" Font-Size="Small" LoginButtonText="Entrar" RememberMeText="Recordar contrase�a"
                            UserNameLabelText="Usuario" PasswordLabelText="Contrase�a " Font-Bold="False"
                            PasswordRecoveryUrl="OlvidoPassword.aspx" PasswordRecoveryText="Forgot Your Password?">
                            <LayoutTemplate>
                                <div style="text-align: left;">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Font-Size=""
                                        Font-Bold="true">Usuario</asp:Label>
                                </div>
                                <asp:TextBox ID="UserName" Width="240" runat="server" Font-Size="Medium" Style="padding: 5px;"></asp:TextBox>
                                <br />
                                <br />
                                <div style="text-align: left;">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Font-Size="Small"
                                        Font-Bold="true">Contrase�a</asp:Label><br />
                                </div>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" Font-Size="Medium"
                                    Style="padding: 5px;" Width="240"></asp:TextBox><br />
                                <br />
                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text=" Entrar " Height="30"
                                    Font-Size="11" Font-Bold="true" Width="100" CssClass="but" ValidationGroup="LoginUserValidationGroup"
                                    Font-Names="'Lucida Grande', Tahoma" Style="margin-left: 0px; background-color: #4F6AA3;
                                    color: White; border: 1px solid #2F5BB7;" />
                                <loginbuttonstyle cssclass="but" />
                                <asp:CheckBox ID="RememberMe" runat="server" TextAlign="Left" Style="margin-left: 30px;
                                    vertical-align: middle" />
                                <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline"
                                    Font-Size="Small" Style="text-align: right; vertical-align: middle">No cerrar sesi�n</asp:Label>
                                <br />
                                <br />
                                <asp:LinkButton runat="server" Style="margin-top: 10px;" PostBackUrl="OlvidoPassword.aspx">�Olvidaste tu contrase�a?</asp:LinkButton>
                                <div style="text-align: left;">
                                    <br />
                                    <asp:Label ID="FailureText" runat="server" EnableViewState="false" Width="230" Font-Bold="true"
                                        ForeColor="#DD4B39" BackColor="transparent" CssClass="Alerta" BorderWidth="0" />
                                </div>
                            </LayoutTemplate>
                            <FailureTextStyle ForeColor="White" BackColor="#6E7E91" Wrap="true" Width="230">
                            </FailureTextStyle>
                        </asp:Login>
                        <script>                            $(document).ready(function () { $('div:empty').remove(); });  // para no mostrar la celda vac�a del FailureText....
                        </script>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Label ID="lblMensajeErrorSuplementario" runat="server" ForeColor="#FF0066"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
                <td style="width: 40px">
                </td>
            </tr>
        </table>
        <div>
            <%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"> </script>
            <script type="text/javascript">
                CFInstall.check();
            </script>--%>
            <script type="text/javascript">


                if (navigator.appName == 'Microsoft Internet Explorer') {
                    var str = "Pod�s seguir usando Explorer y ver mejor el sistema con el plugin de Chrome Frame";
                    document.write(str.link("http://www.google.com/chromeframe/eula.html?extra=betachannel&hl=es&quickenable=true"));
                    //                           
                }
        
            </script>
        </div>
        <table align="center" style="font-size: x-small; text-align: center">
            <tr>
                <td>
                    <%--                                    <td style="vertical-align: top; text-align: left;" >
                    &nbsp;
                </td>
                <td style="vertical-align: top; text-align: left;" class="style4" rowspan="100%"
                    height="2000" width="300px"></td>--%>
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Label ID="lblAvisoTipoDeSitio" runat="server" Font-Size="X-Large" CssClass="Alerta"
                        Width="150px"></asp:Label>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
            </tr>
            <td valign="bottom" style="height: 15px; text-align: center" align="center">
                <asp:HyperLink NavigateUrl="http://www.bdlconsultores.com.ar/" Text="�2013 BDL" runat="server"
                    Font-Bold="false" Font-Underline="false" ForeColor="#4F6AA3" Font-Size="Small"
                    ID="lnkBDL" CssClass="linkHoverSubrayado"></asp:HyperLink>
                <asp:Label ID="lblVersion" runat="server"></asp:Label>
            </td>
            <td valign="bottom" style="position: absolute; bottom: 0 !important; height: 15px;">
            </td>
            <%--            <br />
            <br />
            <br />--%>
            </tr>
        </table>
        <%--http://www.4guysfromrolla.com/webtech/082400-1.shtml--%>
        <input type="hidden" name="cookieexists" value="false">
        <div style="visibility: hidden; display: none">
            Haga clic en Herramientas, luego en Opciones de Internet. Haga clic en la carpeta
            de Seguridad. Haga clic en el bot�n Nivel personalizado. Vaya a la secci�n de Automatizaci�n.
            Seleccione Activar en Automatizaci�n de los subprogramas de Java, Permitir operaciones
            de pegado por medio de una secuencia de comandos y Secuencias de comandos ActiveX.
            Haga clic en el bot�n Aceptar. Internet Explorer 6: Haga clic en Herramientas, luego
            en Opciones de Internet. Haga clic en la carpeta de Seguridad. Haga clic en el bot�n
            Nivel personalizado. Vaya a la secci�n de Automatizaci�n. Seleccione: *Activar en
            Automatizaci�n de los subprogramas de Java, *Permitir operaciones de pegado por
            medio de una secuencia de comandos *y Secuencias de comandos ActiveX. Haga clic
            en el bot�n Aceptar. Activar la rama de ActiveX !!!!! En Herramientas->Opciones
            de Internet-> Seguridad->Nivel Personalizado , marcar como Enabled o Prompt todas
            las opciones de: rama Automatizacion (o \\\"Scripts\\\" en ingles) esten las tres
            opciones prendidas. rama ActiveX https://jira.jboss.org/browse/RF-8429?focusedCommentId=12515525
            Unfortunately, this is Microsoft-related issue. Up to IE8 they implement XMLHttpRequest,
            that is necessary for AJAX transport, as ActiveX control, so it generates warnings
            for any AJAX-enabled RichFaces component - and anything else that uses the standard
            IE Ajax transport. At most all known AJAX libraries use the same XMLHttpRequest
            object. ActiveX controls are enabled by default, so it oblivious result of custom
            policy in the customer\\*s domain. They have to ask domain admin to setup appropriate
            security restrictions. There are many options for those changes. You can setup whitelists,
            allow administrator approved controls, or place their internal site in a security
            zone where this will not be a problem. And they can push all of this down as a domain
            policy template...any MCSE should be able to lock this down.
        </div>
        </form>
    </center>
    <%--http://dotnet.itags.org/dotnet-security/37902/

PROBLEMAS CON EL LOGIN, "TRY AGAIN"

Revis� el IsLockedOut!!!!!!!


AHHHHHHH!
I had a login control that worked perfectly and then all of a sudden decided to stop. I cant understand what I did or if I did anything to break it. I did some experiments and found that if I created my own two texboxes with a login button and called membership.validateuser it worked - for a time. Because I was testing the admin section I set the login page to login automaticaly. This is important because I know therefore that the User name and Password are correct. I decided it was time to tidy the textboxes up tried to login and it failed! I re-instated the automatic login and it failed but the credentials are definately correct!
What on earth is going on. Does anyone have a solid work arround or even a solution!
Danny (going grey rapidly!)
codescribler | Sat, 05 Jan 2008 20:25:00 GMT |    
I have the same problem! I just came back after storing my solution in source control application and it started giving me the same error. I will let you know if I find a solution. I'm assuming it has something to do with a part of my solution not linking to the SQL database. What do you mean by "tidy the textboxes" though?
noah | Sat, 05 Jan 2008 20:26:00 GMT |    
After some twenty minutes of utter frustration I have little to conclude to what I did to get my solution. I first disabled the two features I had attempted to add under the web config file (I set EnablePasswordRetrieval="false" and passwordFormat="Hashed"). I originally had passwordFormat="Encrypted". I assume that the login tried using a decrypt method for the password assuming all the database passwords were "Encrypted" when they were infact "Hashed". I then created a user through the ASP .Net Web Site Administration Tool. After that I used my original login page to login my new user.
I'm extremely confused to why that all my past logins would suddenly stop working merely because I changed the format to "Encrypted". I don't suppose I will be able to use those old logins. I'm going to continue with the debugging and hopefully we will be able to compare our problems to conclude the real solution to this mess. Good luck!
    --%>
</body>
</html>
