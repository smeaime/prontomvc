<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Tablas.aspx.vb" Inherits="Tablas" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" BackColor="CornflowerBlue" CssClass="t1">
        <HeaderStyle ForeColor="White" Wrap="True" CssClass="header" />
        <AlternatingRowStyle BackColor="LightBlue" ForeColor="Black" />
    </asp:GridView>
</asp:Content>

