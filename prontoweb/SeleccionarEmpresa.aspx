<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SeleccionarEmpresa.aspx.vb"
    Inherits="SeleccionarEmpresa" Title="BDL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />
    <style type="text/css">
        .style1
        {
            background-color: #4A3C8C;
            font-weight: bold;
            vertical-align: middle;
            text-align: center;
            color: #F0FFFF;
            width: 546px;
        }
        .style2
        {
            width: 546px;
        }
    </style>
</head>
<body class="cssLogin" style="height: 100%; overflow: hidden; " >


        <%--https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag--%>
    <meta name="viewport" content="width=300px, initial-scale=1">


  <%--  <script src="../JavaScript/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/JavaScript/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <form id="form1" runat="server" defaultbutton="ButContinuar">
    <div align="center">
        <br />
        <br />
        <asp:Image ID="LogoImage" runat="server" BorderColor="Black" BorderWidth="1px" BorderStyle="None"
            Height="" ImageUrl="~/Imagenes/loguito/0bak.gif" Style="margin-top: 5px"
            Width="" />
    </div>
    <div>
           <asp:LoginView ID="LoginView" runat="server">
                                <LoggedInTemplate>
                                    <asp:LoginName ID="LoginName1" runat="server" Font-Bold="false" CssClass="margender" />
                                    |
                                                    <asp:LoginStatus ID="LoginStatus1" runat="server" Font-Bold="false" ForeColor="white"
                                                        LogoutAction="RedirectToLoginPage" LogoutPageUrl="~/Login.aspx" OnLoggedOut="LoginStatus1_LoggedOut"
                                                        TabIndex="-1" LogoutText="Salir" Font-Underline="False" CssClass="margender" />
                                </LoggedInTemplate>
                            </asp:LoginView>

        <br />
    </div>
    <%--    
       <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
                        EnablePageMethods="False" AsyncPostBackTimeout="360000" />--%>
    <div align="center">
        <table style="width: " class="t1">
            <tr>
                <td style="width: 300px; background-color: #4A3C8C; font-size: medium;" align="center">
                    <span style="color: #f0ffff; font-size: 12pt">Seleccionar empresa</span>
                </td>
            </tr>
            <tr>
                <td align="center" class="" style="font-size: medium">
                    &nbsp;&nbsp;
                    <asp:Panel ID="PanelListEmpresas" runat="server" Height="">
                        <asp:ListBox ID="DDLEmpresas" runat="server" Width="300" TabIndex="1" Font-Size="20">
                        </asp:ListBox>
                        <br /> <br />
                        <asp:Button ID="ButContinuar" runat="server" Text="Continuar" CssClass="but" TabIndex="2"  Width="250" Height="50"/>
                        <%-- <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>
                        <%--                    <asp:ObjectDataSource ID="ObjDSEmpresas" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetEmpresasPorUsuario" TypeName="Pronto.ERP.Bll.EmpresaManager">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HFSC" DefaultValue="" Name="SC" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HFIdUser" DefaultValue="" Name="UserId" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>--%>
                        <%--<asp:HiddenField ID="HFSC" runat="server" />--%>
                        <asp:HiddenField ID="HFIdUser" runat="server" />
                        &nbsp;&nbsp;</asp:Panel>
                    <asp:Panel ID="PanelInfo" runat="server" Width="300px" Height="16px">
                        <br />
                        <asp:Label ID="LblTextInfo" runat="server" Font-Bold="True" ForeColor="Red" Text="Comuníquese con el administrador del sistema para que le asigne una empresa"></asp:Label></asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="center" class="style2">
                    &nbsp;
                    <br />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
