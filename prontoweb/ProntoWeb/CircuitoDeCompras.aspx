<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CircuitoDeCompras.aspx.vb" Inherits="CircuitoDeCompras" Title="Pronto Web"
    EnableViewState="False" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center style="height: 654px">
        <br />
        <strong><span style="color: #f0ffff; font-size: 16pt">Bienvenido</span></strong>
        <br />
        <br />
        <br />
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
        <fieldset>
            <legend>AsyncPage Demo</legend>url:<asp:TextBox ID="txtUrl" runat="server" Width="200px">http://msdn.microsoft.com</asp:TextBox>
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" /><br />
            <span style="color: Blue; font-weight: bold">Show hrefs in url &nbsp;
                <asp:Label ID="lblUrl" runat="server">

                </asp:Label></span>:<br>
            <asp:Label ID="Output" runat="server"></asp:Label>
        </fieldset>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:LinkButton ID="lnkTest_CP3_OP_Equimac" runat="server" ForeColor="White">Test CP3-OP Equimac</asp:LinkButton>
                <asp:LinkButton ID="LinkButton6" runat="server" ForeColor="White">Test de timeout</asp:LinkButton>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <table style="border-style: none; border-color: inherit; border-width: medium; width: 555px;
            height: 523px;" class="t1" cellpadding="4" cellspacing="5" align="center">
            <tr>
                <td style="width: 2049px; height: 5px;">
                </td>
                <td style="width: 6843px; height: 5px;">
                </td>
                <td style="height: 5px;" colspan="2">
                </td>
                <td style="height: 5px;" colspan="4">
                </td>
                <td style="height: 5px; width: 85px;">
                </td>
            </tr>
            <tr>
                <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                    <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="White">Nueva RM</asp:LinkButton>
                </td>
                <td style="width: 6843px; height: 24px;">
                </td>
                <td style="border: thin groove #000000; height: 67px; width: 2193px;" align="center">
                    <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White">Nuevo Solicitud</asp:LinkButton>
                </td>
                <td>
                    &nbsp;
                </td>
                <td align="center" valign="bottom" colspan="2" style="height: 24px">
                </td>
                <td style="width: 243px; height: 24px;">
                </td>
                <td style="height: 24px;">
                </td>
                <td style="width: 85px; height: 24px;">
                </td>
            </tr>
            <tr>
                <td style="width: 2049px; height: 71px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 70px; height: 59px" />
                </td>
                <td style="height: 71px; width: 6843px;">
                </td>
                <td style="height: 71px;" align="right" colspan="2" class="style7">
                    &nbsp;<img src="../Imagenes/Bottom-arrow-48-con%20derecha.png" style="width: 64px;
                        height: 55px" />
                </td>
                <td style="border: thin groove #000000; height: 71px; width: 672px;" align="center">
                    <asp:LinkButton ID="LinkButton4" runat="server" ForeColor="White">Nueva Comparativa</asp:LinkButton>
                </td>
                <td style="height: 71px; width: 460px;">
                </td>
                <td class="style7" style="height: 71px;" colspan="2">
                </td>
                <td class="style7" style="height: 71px; width: 85px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: thin groove #000000; height: 94px;" align="center">
                    <asp:LinkButton ID="LinkButton2" runat="server" ForeColor="White">Asignar Requerimientos Pendientes</asp:LinkButton>
                </td>
                <td colspan="4" style="height: 94px" align="center">
                    <img src="../Imagenes/Right-arrow-48.png" style="width: 111px; height: 72px" />
                </td>
                <td colspan="3" style="border: thin groove #000000; height: 94px;" align="center">
                    <asp:LinkButton ID="LinkButton5" runat="server" ForeColor="White">Nuevo Pedido</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="width: 2049px; height: 29px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 65px; height: 48px" alt="esq" />
                </td>
                <td style="height: 29px;" align="center" colspan="3">
                    <img src="../Imagenes/Top-arrow-48%20esquina%20derecha.png" style="width: 75px; height: 43px"
                        alt="esq" />
                </td>
                <td style="border: thin groove #000000; height: 67px; width: 672px;" align="center">
                    Nueva Recepcion
                </td>
                <td style="width: 460px" />
                <td colspan="2" style="height: 29px">
                    <img src="../Imagenes/Top-arrow-48%20esquina%20derecha2.png" style="width: 51px;
                        height: 50px" />
                </td>
                <td style="height: 29px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 50px; height: 49px" />
                </td>
            </tr>
            <tr>
                <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                    Nuevo Vale
                </td>
                <td style="height: 67px;" colspan="4" align="center">
                    &nbsp;
                </td>
                <td style="height: 67px; width: 460px;">
                </td>
                <td>
                </td>
                <td>
                </td>
                <td style="border: thin groove #000000; width: 85px; height: 67px;" align="center">
                    Nuevo Comprobante de Proveedor
                </td>
                <td style="border: thin groove #000000; width: 85px; height: 67px;" align="center">
                    Nuevo Fondo fijo
                </td>
            </tr>
            <tr>
                <td style="width: 2049px; height: 34px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 59px; height: 48px" />
                </td>
                <td style="width: 6843px; height: 34px;">
                </td>
                <td style="height: 34px;" colspan="2">
                </td>
                <td style="height: 34px;" colspan="4">
                </td>
                <td style="width: 85px; height: 34px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 48px; height: 48px" />
                </td>
            </tr>
            <tr>
                <td style="border: thin groove #000000; width: 2049px; height: 51px;" align="center" />
                Nueva Salida de Material
                <td style="width: 6843px; height: 51px;">
                    <td style="height: 51px;" colspan="2">
                    </td>
                    <td style="height: 51px;" align="center" colspan="4">
                    </td>
                    <td style="border: thin groove #000000; width: 85px; height: 51px; font-weight: bold;"
                        align="center">
                        Nueva Orden de Pago
                    </td>
            </tr>
        </table>
        <br />
        <div style="visibility: hidden; display: none;">
            <table style="width: 565px; height: 111px;" class="t1" cellpadding="5" cellspacing="5">
                <tr>
                    <td style="width: 100px">
                        Nuevo Proveedor
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        Buscar Proveedor
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <asp:Button ID="Button1" runat="server" Text="Test Firmas" />
            <asp:Button ID="Button2" runat="server" Text="Test FF" />
            <asp:Button ID="Button3" runat="server" Text="Test Cotiz" />
            <asp:Button ID="Button8" runat="server" Text="Todos" />
            <asp:Button ID="Button4" runat="server" Text="Importar Articulos" />
        </div>
    </center>
</asp:Content>
