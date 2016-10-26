<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CartasConflictivas, App_Web_55qckufu" title="Cartas de Porte" theme="Azul" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; table-layout: fixed">
        <asp:Label ID="lblErrores" runat="server"></asp:Label>
    </div>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
