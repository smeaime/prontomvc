<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoginMobile.aspx.vb" Inherits="Login"
    Title="ProntoWeb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>




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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">


<body style="height: ; overflow: ; background-color: #9ec3e8; margin: 0 0 0 0;" class="">

    <%--esto del onload para lo de revisar si esta habilitado javascript--%>
    <center>
        <form id="form1" runat="server">
            <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
                EnablePageMethods="False" AsyncPostBackTimeout="360000">
            </ajaxToolkit:ToolkitScriptManager>

            <table style="border-style: none; font-family: arial,sans-serif;">
                <tr>

                    <td align="centre" width="300px" style="margin-left: 0px">

                        <asp:Panel ID="PanelWilliams" runat="server">
                            <div>


                                <style>
                                    .LoginLogo2 {
                                        width: 300px;
                                        margin-left: 1px;
                                    }
                                </style>
                                <div align="left">
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagenes/williamslogin.gif" CssClass="LoginLogo LoginLogo2" />
                                    <%--Williams Entregas S.A.--%>
                                </div>


                                <div style="text-align: center; font-size: 14px; font-family: Tahoma;">
                                    <%--<div style="font-size: x-large; width: 400px; margin-left: 50px; font-family: Tahoma;">--%>
                                    <b>Junto a nuestros clientes</b><br />
                                    Williams Entregas S.A. nació en 1989 de la mano de
                                    nuestros clientes con un objetivo
                                bien definido: estar junto a ellos brindándole el mejor servicio.
                                </div>
                                <br />


                            </div>
                        </asp:Panel>

                    </td>

                </tr>
                <tr>
                    <td align="center">
                        <div align="center" class="" style="border: ; background-color: ; color: ; vertical-align: middle;">

                            <%--         http://stackoverflow.com/questions/4891655/why-doesnt-the-password-recovery-link-show-up-in-my-login-control--%>
                            <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/SeleccionarEmpresa.aspx"
                                ForeColor="Black" TitleText="" Font-Size="18" LoginButtonText="Entrar" RememberMeText="Recordar contraseña"
                                UserNameLabelText="Usuario" PasswordLabelText="Contraseña " Font-Bold="False"
                                PasswordRecoveryUrl="OlvidoPassword.aspx" PasswordRecoveryText="Forgot Your Password?" BackColor="">
                                <LayoutTemplate>
                                    <div style="text-align: left;">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Font-Size="16"
                                            Font-Bold="false">Usuario</asp:Label>
                                    </div>
                                    <asp:TextBox ID="UserName" Width="285" runat="server" Font-Size="20" Style="padding: 5px;"></asp:TextBox>
                                    <br />
                                    <div style="text-align: left; margin-top: 10px;">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Font-Size="16">Contraseña</asp:Label><br />
                                    </div>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" Font-Size="20"
                                        Style="padding: 5px;" Width="285"></asp:TextBox><br />
                                    <br />
                                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text=" Entrar " Height="60"
                                        Font-Size="20" Font-Bold="true" Width="300" CssClass="but" ValidationGroup="LoginUserValidationGroup"
                                        Font-Names="'Lucida Grande', Tahoma" Style="margin-left: 0px; background-color: #4F6AA3; color: White; border: 1px solid #2F5BB7;" />
                                    <loginbuttonstyle cssclass="but" />
                                    <br />
                                    <br />
                                    <asp:CheckBox ID="RememberMe" runat="server" TextAlign="Left"
                                        Style="margin-left: 0px; vertical-align: middle" Font-Size="15" />
                                    <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline"
                                        Font-Size="15" Style="text-align: right; vertical-align: middle">No cerrar sesión</asp:Label>
                                    <br />
                                    <br />
                                    <asp:LinkButton runat="server" Style="margin-top: 10px; font-size: 18px" PostBackUrl="OlvidoPassword.aspx">¿Olvidaste tu contraseña?</asp:LinkButton>
                                    <div style="text-align: left;">
                                        <br />
                                        <asp:Label ID="FailureText" runat="server" EnableViewState="false" Width="230" Font-Bold="true"
                                            ForeColor="#DD4B39" BackColor="transparent" CssClass="Alerta" BorderWidth="0" />
                                    </div>
                                </LayoutTemplate>
                                <FailureTextStyle ForeColor="White" BackColor="" Wrap="true" Width="230"></FailureTextStyle>
                            </asp:Login>
                            <script>                            $(document).ready(function () { $('div:empty').remove(); });  // para no mostrar la celda vacía del FailureText....
                            </script>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblMensajeErrorSuplementario" runat="server" ForeColor="#FF0066"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
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
                        var str = "Podés seguir usando Explorer y ver mejor el sistema con el plugin de Chrome Frame";
                        document.write(str.link("http://www.google.com/chromeframe/eula.html?extra=betachannel&hl=es&quickenable=true"));
                        //                           
                    }






                    function Loguearse(u, p) {
                        var d = {
                            user: u,  // si viene en undefined es porque no se puso ningun filtro
                            pass: p
                        }

                        $.ajax({
                            type: "POST",
                            //method: "POST",
                            url: "Login.aspx/LoginCookie",
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",

                            data: JSON.stringify(d),

                            success: function (data) {
                                alert(data.d);
                                //window.open(data.d);
                            }


                            ,
                            beforeSend: function () {
                                //$('.loading').html('some predefined loading img html');
                                $("#loading").show();
                                $('#grabar2').attr("disabled", true).val("Espere...");

                            },
                            complete: function () {
                                $("#loading").hide();
                            }


                        })
                    }



                    $(document).ready(function () {

                        //alert("hola");

                        $('#btnLoguearse').click(function () {
                            Loguearse();

                        })




                    });



                </script>
            </div>




     <table align="center" style="font-size: x-small; text-align: center">
                <tr>
                    <td>

                        <br />
                        <asp:Label ID="lblAvisoTipoDeSitio" runat="server" Font-Size="X-Large" CssClass="Alerta"
                            Width="150px"></asp:Label>
                    </td>
                </tr>
                <tr>
                </tr>
                <td valign="bottom" style="height: 15px; text-align: center" align="center">
                    <asp:HyperLink NavigateUrl="http://www.bdlconsultores.com.ar/" Text="©2017 BDL" runat="server"
                        Font-Bold="false" Font-Underline="false" ForeColor="#4F6AA3" Font-Size="Small"
                        ID="lnkBDL" CssClass="linkHoverSubrayado"></asp:HyperLink>
                    <asp:Label ID="lblVersion" runat="server"></asp:Label>
                </td>
                <td valign="bottom" style="position: absolute; bottom: 0 !important; height: 15px;"></td>
                </tr>
            </table>





            <%--http://www.4guysfromrolla.com/webtech/082400-1.shtml--%>
            <input type="hidden" name="cookieexists" value="false">
            <div style="visibility: hidden; display: none">
                Haga clic en Herramientas, luego en Opciones de Internet. Haga clic en la carpeta
            de Seguridad. Haga clic en el botón Nivel personalizado. Vaya a la sección de Automatización.
            Seleccione Activar en Automatización de los subprogramas de Java, Permitir operaciones
            de pegado por medio de una secuencia de comandos y Secuencias de comandos ActiveX.
            Haga clic en el botón Aceptar. Internet Explorer 6: Haga clic en Herramientas, luego
            en Opciones de Internet. Haga clic en la carpeta de Seguridad. Haga clic en el botón
            Nivel personalizado. Vaya a la sección de Automatización. Seleccione: *Activar en
            Automatización de los subprogramas de Java, *Permitir operaciones de pegado por
            medio de una secuencia de comandos *y Secuencias de comandos ActiveX. Haga clic
            en el botón Aceptar. Activar la rama de ActiveX !!!!! En Herramientas->Opciones
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

Revisá el IsLockedOut!!!!!!!


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
