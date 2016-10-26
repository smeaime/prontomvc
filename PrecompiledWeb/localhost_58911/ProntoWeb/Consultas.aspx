<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Consultas, App_Web_jgdhli0d" title="Consultas" theme="Azul" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <br />
    
    <asp:ListBox ID="ListBox1" runat="server" Height="57px" AutoPostBack="True">
        <asp:ListItem Value="/Report Project2/Balance_porDatasourceDirecto">Balance</asp:ListItem>
        <asp:ListItem Value="/Report Project2/StockPorArticuloSinAS">Stock por Artículo</asp:ListItem>
        <asp:ListItem Value="/Report Project2/StockPorCuentaSinAS">Stock por Cuenta</asp:ListItem>
        <asp:ListItem Value="/Requerimientos">Requerimientos</asp:ListItem>
    </asp:ListBox>

    


    <asp:LinkButton ID="Button1" runat="server" Font-Bold="True" 
        Font-Underline="False" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="22px" style="margin-left: 28px" Width="55px">Diseñar</asp:LinkButton>

    <asp:LinkButton ID="Button2" runat="server" Font-Bold="True" 
        Font-Underline="False" ForeColor="White" CausesValidation="true" 
        Font-Size="Small" Height="21px" style="margin-left: 28px" Width="131px">Explorar en Web</asp:LinkButton>

    
    <br />
    <br />
        
    <%--este usa el servidor de informes--%>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="600px" ProcessingMode="Remote" Width="1000px" ShowZoomControl="True">
        
        </rsweb:ReportViewer>
    <br />
    
    <%--este NO--%>
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px" Visible="False">
        <LocalReport ReportPath="ProntoWeb\Informes\Requerimientos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>

    <asp:HiddenField ID="HFSC" runat="server" />
    
</asp:Content>

