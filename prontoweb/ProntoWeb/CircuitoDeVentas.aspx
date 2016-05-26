<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CircuitoDeVentas.aspx.vb" Inherits="CircuitoDeVentas" Title="Pronto Web"
    EnableViewState="False" %>

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
        <br />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:LinkButton ID="LinkButton6" runat="server" ForeColor="White">Test OC-REM-FAC-REC CNSapag</asp:LinkButton>
                <br />
                <asp:LinkButton ID="lnkTest_OC_REM_FAC_REC_Equimac" runat="server" ForeColor="White">Test OC-REM-FAC-REC Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton38" runat="server" ForeColor="White">Test OC-REM Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton822" runat="server" ForeColor="White">Test OC Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton855" runat="server" ForeColor="White">Test REM Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="lnkTest_FAC_Equimac" runat="server" ForeColor="White">Test FAC Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton8243" runat="server" ForeColor="White">Test REC Equimac</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton7" runat="server" ForeColor="White">Test NC-ND CNSapag</asp:LinkButton>
                <br />
                <asp:LinkButton ID="LinkButton9" runat="server" ForeColor="White">Test NC-ND Equimac</asp:LinkButton>
                <br />
            <asp:Button ID="Button4" runat="server" Text="Importar Articulos" />
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
                    <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="White">Nueva Orden de compra</asp:LinkButton>
                </td>
                <td style="width: 6843px; height: 24px;">
                </td>
                <td style="border: thin groove #000000; height: 67px; width: 2193px;" align="center">
                    <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White">Nuevo Remito</asp:LinkButton>
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
                <td style="border: none; height: 71px; width: 672px;" align="center">
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
                    <asp:LinkButton ID="LinkButton2" runat="server" ForeColor="White">Nueva Factura</asp:LinkButton>
                </td>
                <td colspan="4" style="height: 94px" align="center">
                    <img src="../Imagenes/Right-arrow-48.png" style="width: 111px; height: 72px" />
                </td>
                <td colspan="3" style="border: thin groove #000000; height: 94px;" align="center">
                    <asp:LinkButton ID="LinkButton5" runat="server" ForeColor="White">Nuevo Recibo</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="width: 2049px; height: 29px;" align="center">
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 65px; height: 48px" alt="esq" />
                </td>
                <td style="height: 29px;" align="center" colspan="3">
                    <%-- 
                    <img 
                        src="../Imagenes/Top-arrow-48%20esquina%20derecha.png" 
                        style="width: 75px; height: 43px" alt="esq" />--%>
                </td>
                <%--              
                <td style="border: thin groove #000000; height: 67px; width: 672px;" 
                    align="center">
    
                     </td>--%>
                <%--                <td style="width: 460px" />
                <td colspan="2" style="height: 29px">
    
                    
                    <img src="../Imagenes/Top-arrow-48%20esquina%20derecha2.png" 
                        style="width: 51px; height: 50px" /></td>
                <td style=" height: 29px;" align="center">
    
                    
                    <img src="../Imagenes/Bottom-arrow-48.png" style="width: 50px; height: 49px" /></td>--%>
            </tr>
            <tr>
                <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                    Nuevo NC
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
                <%--                <td  style="border: thin groove #000000; width: 85px; height: 67px;" 
                    align="center">
    
                                        </td>
--%>
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
                Nueva ND
                <td style="width: 6843px; height: 51px;">
                    <td style="height: 51px;" colspan="2">
                    </td>
                    <td style="height: 51px;" align="center" colspan="4">
                    </td>
                    <%--    
                <td  style="border: thin groove #000000; width: 85px; height: 51px; font-weight: bold;" 
                    align="center">Nueva </td>--%>
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
        </div>
    </center>
</asp:Content>
