<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="ImportacionInformacionImpositiva, App_Web_zl51qgz3" title="ImportacionInformacionImpositiva" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-right: 32px"
        Visible="False">Exportar a Excel</asp:LinkButton>
    <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar como en Pronto</asp:LinkButton>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--<asp:UpdatePanel ID="UpdatePanelResumen" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
    --%>
    <%--combo para filtrar cuenta--%>
    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
        cellpadding="3" cellspacing="3">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                font-size: medium; height: 37px;" align="left" valign="top">
                <asp:Label ID="lblTitulo" ForeColor="White" runat="server" Text="Importación de información impositiva"
                    Font-Size="Large" Height="22px" Font-Bold="True"></asp:Label>
            </td>
            <td style="height: 37px;" valign="top" align="right">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                        <asp:Label ID="lblUpdateProgress" ForeColor="White" runat="server" Text="Actualizando datos ..."
                            Font-Size="Small"></asp:Label></ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <%--    En Pronto: Utilidades >> Generar/Importar informacion impositiva--%>
    <asp:Panel ID="panelAdjunto" runat="server">
        <script type="text/javascript">

            //    http: //forums.asp.net/t/1048832.aspx

            function BrowseFile() {
                var fileUpload = document.getElementById("<%=FileUpLoad2.ClientID %>");

                var btnUpload = document.getElementById("<%=btnAdjuntoSubir.ClientID %>"); //linea mia

                fileUpload.click();

                var filePath = fileUpload.value;

                btnUpload.click();  //linea mia

                /*
                // esto lo usa para grabar una lista de archivos
        
                var filePath = fileUpload.value;

                var j = listBox.options.length;
                listBox.options[j] = new Option();
                listBox.options[j].text = filePath.substr(filePath.lastIndexOf("\\") + 1);
                listBox.options[j].value = filePath;
                */
            }
        </script>
        <%--    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
        <%--        <img src="../Imagenes/GmailAdjunto2.png" alt="" style="border-style: none; border-color: inherit;
            border-width: medium; vertical-align: middle; text-decoration: none; margin-left: 5px;" visible="false" />--%>
        <asp:LinkButton ID="lnkAdjunto1" runat="server" ForeColor="White" Visible="False"></asp:LinkButton>
        <%--                        </ContentTemplate>
    </asp:UpdatePanel>--%>
        <%--<asp:ListBox ID="ListBox1" runat="server" Visible="False"></asp:ListBox>
        --%>
        <%--        
DONDE ESTA EL DICHOSO AsyncFileUpload de AJAX?????????????????????????????
-Necesita 3.5.... mmmmm, mejor segui con el FileUpload
<ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" UploadingBackColor="Yellow"
            OnUploadedComplete="ProcessUpload" OnClientUploadComplete="showUploadConfirmation" ThrobberID="spanUploading"  />
        --%>
        <%--OJO SI LO METES EN UN UPDATEPANEL NO ANDA!!!!!!   --%>
        <%--CssClass="imp"--%>
        <asp:FileUpload ID="FileUpLoad2" runat="server" Width="402px" Height="22px" CssClass="button-link"
            Font-Underline="False" />
        <%--style="visibility:hidden"--%>
        <asp:LinkButton ID="lnkBorrarAdjunto" runat="server" ForeColor="White" Visible="False">borrar</asp:LinkButton>
        <asp:Button ID="btnAdjuntoSubir" runat="server" Font-Bold="False" Height="19px" Text="Adjuntar"
            CausesValidation="False" />
        <br />
        <br />
    </asp:Panel>
    
    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
        margin-left: 0px;" Height="22px">
        
        <%-- http://robirosa.wikispaces.com/Factura+Electronica+RECE --%>
        <asp:ListItem Text="Importar CAE Ventas (desde un archivo recibido de la AFIP)" Value="NumeroCartaDePorte"  />
        <%--                <asp:ListItem Text="RG 830" Value="FechaCarga" />
                <asp:ListItem Text="RG 17" Value="VendedorDesc" />
                <asp:ListItem Text="ReproWeb" Value="CuentaOrden1Desc" />
                <asp:ListItem Text="SUSS" Value="CuentaOrden1Desc" />
                <asp:ListItem Text="Embargos rentas" Value="CuentaOrden1Desc" />
                <asp:ListItem Text="Norm 70/07 BsAs" Value="CuentaOrden1Desc" />--%>
    </asp:DropDownList>
    <asp:Button ID="Button3" runat="server" Text="Importar" Visible="false" />
    <asp:Button ID="Button2" runat="server" Text="Bajar asldkalds" CssClass="but" Width="145px"
        Visible="false" />
    <br />
    <br />
    <br />
    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="buscar"
        Visible="False"></asp:TextBox>
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <%--    <div style="OVERFLOW: auto;width:100%">
            --%>
            <%--    </div>
            --%>
            <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
            <%--    datasource de grilla principal--%>
            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <span>
        <%--<div>--%>
        <%--botones de alta y excel--%>
        <%--</div>--%>
    </span>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
