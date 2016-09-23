<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="ArchivosLosGrobo.aspx.vb" Inherits="ArchivosLosGrobo" Title="Configuración" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <asp:Panel ID="panelcito" runat="server" Visible="false">
        PASO 1:<br />
        <asp:ListBox ID="tipo" runat="server" Width=200px Height= 200px>
            <asp:ListItem>-- Elija una importación --        </asp:ListItem>
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>establecimientos grobo</asp:ListItem>
            <asp:ListItem>partidos ypf</asp:ListItem>
            <asp:ListItem>localidades ypf</asp:ListItem>
            <asp:ListItem>localidades bld afip</asp:ListItem>
            <asp:ListItem>centros ypf</asp:ListItem>
        </asp:ListBox>
        <br />
        PASO 2:<br />
        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload2" runat="server" CompleteBackColor="Lime"
            ErrorBackColor="Red" />
        <br />
        <asp:Button ID="Button5" runat="server" Text="Importar Articulos"  Visible="false"/>
        <asp:Button ID="Button6" runat="server" Text="Importar Establecimientos Grobo" Visible="false"/>
        <asp:Button ID="Button7" runat="server" Text="Importar Partidos ONCCA" Visible="false"/>
        <asp:Button ID="Button9" runat="server" Text="Importar Centros YPF" Visible="false"/>
    </asp:Panel>
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
        <asp:Button ID="Button1" runat="server" Text="Test Firmas"  />
        <asp:Button ID="Button2" runat="server" Text="Test FF" />
        <asp:Button ID="Button3" runat="server" Text="Test Cotiz" />
        <asp:Button ID="Button8" runat="server" Text="Todos" />
        <asp:Button ID="Button4" runat="server" Text="Importar Articulos" />
    </div>
    </center>
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
