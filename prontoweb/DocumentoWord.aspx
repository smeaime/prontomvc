<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DocumentoWord.aspx.cs" Inherits="DocumentoWord" Title="Untitled Page" %>

<%@ PreviousPageType VirtualPath="~/NotasDePedido.aspx" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<script type="text/javascript">
<!--
function Imprime()
{
    var word = new ActiveXObject('Word.Application');
    if (word != null)
    {
        word.Visible=false;
        word.Documents.Add('<%= GetUrlDoc()%>');
        word.PrintOut();
    }
}
-->
</script>

<input type="button" value="Volver" onclick="history.back()"><br /><br />
<input type="button" value="Imprimir el documento en la impresora predeterminada" onclick="javascript:Imprime(); return false;" />
<br/>
<br/>
<iframe src="Documentos/<%=GetDocName()%>" style="height: 807px; width: 811px">
</iframe>

<%--Para agregar al men� la opci�n de impresi�n:<br>

1) Con el bot�n derecho hacer click en el c�rculo rojo que indica la figura de abajo
2) Seleccionar la opci�n "Est�ndar"
3) Aparecer� en el men� de Word la opci�n de Impresi�n

<asp:Image ID="Image1" runat="server" ImageUrl="aclaraWord.jpg" />
--%>

<asp:HiddenField ID="pedido" runat="server" EnableViewState="true" />
<rsweb:ReportViewer ID="ReportViewer1" runat="server" ProcessingMode="Remote">
</rsweb:ReportViewer>
</asp:Content>

