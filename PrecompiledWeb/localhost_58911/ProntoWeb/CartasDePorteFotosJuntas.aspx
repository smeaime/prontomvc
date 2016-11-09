<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CartasDePorteFotosJuntas, App_Web_aph5zxwq" title="Importar Excel" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
        <ContentTemplate>
            <span><a id="linkimagenlabel" runat="server" href=" ">
                <img id="imgFotoCarta" runat="server" style=" max-width: 40% " />
            </a>
                <asp:HyperLink ID="linkImagen" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
                <a id="linkimagenlabel2" runat="server" href=" ">
                    <img id="imgFotoCarta2" runat="server" style=" max-width: 40% "  />
                </a>
                <asp:HyperLink ID="linkImagen_2" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
            </span>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
