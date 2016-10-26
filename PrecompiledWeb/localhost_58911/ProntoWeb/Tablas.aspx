<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Tablas, App_Web_ujcp202p" title="Untitled Page" theme="Azul" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" BackColor="CornflowerBlue" CssClass="t1">
        <HeaderStyle ForeColor="White" Wrap="True" CssClass="header" />
        <AlternatingRowStyle BackColor="LightBlue" ForeColor="Black" />
    </asp:GridView>
</asp:Content>

