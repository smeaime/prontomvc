<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CartasDePortesMovil.aspx.vb" Inherits="CartasDePortesMovil" Title="Cartas de Porte" %>

<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>--%>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--   <script src="../JavaScript/custom-form-elements.js" type="text/javascript"></script>
    --%>
    <%--<script src="../JavaScript/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../JavaScript/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>
        <script src="../JavaScript/daterangepicker.jQuery.js" type="text/javascript"></script>
        <link href="../CSS/redmond/jquery-ui-1.8.custom.css" rel="stylesheet" type="text/css">
        <link href="../CSS/ui.daterangepicker.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .ui-daterangepicker
            {
                font-size: 10px;
            }
        </style>
    <div>--%>
    <%--
Para usar el controlcito de rango de fechas, en jQuery
http://weblogs.asp.net/alaaalnajjar/archive/2010/05/04/how-to-use-jquery-date-range-picker-plugin-in-asp-net.aspx
http://weblogs.asp.net/alaaalnajjar/attachment/7469405.ashx
    --%>

    <%--https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag--%>
    <meta name="viewport" content="width=400px, initial-scale=1">


    <div style="width: 100%; table-layout: fixed">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <br />
                <br />
                <div style="vertical-align: middle; width: 98%">
                    <asp:Panel Style="vertical-align: middle;" Width="100%" Height="100%" runat="server"
                        CssClass="cssTextoComun">

                        <asp:Button ID="lnkNuevo" runat="server" Font-Bold="false" Font-Underline="False" Width="120" Height="30"
                            CssClass="but" ForeColor="White" CausesValidation="true" Font-Size="Small" Style="vertical-align: middle" Text="+ Nueva Carta" />


                        <br />
                        <br />
                        <br />
                        <%--Estado--%>
                        <asp:Label ID="Label12" runat="server" Style="text-align: right" CssClass="cssTextoComun"
                            Visible="false">Buscar en cartas que contengan</asp:Label>
                        <asp:TextBox ID="txtBuscar" runat="server" Text="" Font-Size="Small"
                            Width="200" Height="20px" AutoPostBack="True"
                            CssClass="txtBuscar"></asp:TextBox>
                        <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                            TargetControlID="txtBuscar" WatermarkText="Buscar en cartas" WatermarkCssClass="watermarkedBuscar" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                            MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                            TargetControlID="txtBuscar" UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                            CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                        </ajaxToolkit:AutoCompleteExtender>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


                        <asp:DropDownList ID="DropDownList1" runat="server" Style="text-align: right; margin-left: 0px;"
                            CssClass="styled" AutoPostBack="True" ToolTip="Estado de la carta de porte" Font-Size="Small"
                            Height="22px">
                            <asp:ListItem Text="Todos los estados" Value="Todas" />
                            <asp:ListItem Text="Incompletas" Value="Incompletas" />
                            <asp:ListItem Text="Posición" Value="Posición" />
                            <asp:ListItem Text="Descargas" Value="Descargas" />
                            <asp:ListItem Text="Facturadas" Value="Facturadas" />
                            <asp:ListItem Text="No facturadas" Value="NoFacturadas" />
                            <asp:ListItem Text="Rechazadas" Value="Rechazadas" />
                            <%--<asp:ListItem Text="sin liberar en Nota de crédito" Value="EnNotaCredito"   visible=false />--%>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%--    Descarga/Arribo--%>
                        <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                            CssClass="styled">
                            <asp:ListItem Text="Hoy" Selected="True" />
                            <asp:ListItem Text="Ayer" />
                            <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                            <asp:ListItem Text="Este mes" />
                            <asp:ListItem Text="Mes anterior" />
                            <asp:ListItem Text="Cualquier fecha" />
                            <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                            <asp:ListItem Text="Personalizar" />
                        </asp:DropDownList>
                        <asp:TextBox ID="txtFechaDesde" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                            AutoPostBack="True" />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                            TargetControlID="txtFechaDesde" />
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaDesde" />
                        <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                            WatermarkText="desde" WatermarkCssClass="watermarked" />
                        <asp:TextBox ID="txtFechaHasta" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                            AutoPostBack="True" />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                            TargetControlID="txtFechaHasta" />
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaHasta" />
                        <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                            WatermarkText="hasta" WatermarkCssClass="watermarked" />
                        <asp:Button ID="Button1" runat="server" Text="Ordenar por titular" Visible="false" />
                        <asp:Button ID="Button2" runat="server" Text="Ordenar por Corredor" Visible="false" />
                        <%--FILTRAR las cartas donde aparezca el cliente [vacío ] en el período [default]. VER
                el listado general, y ENVIARLO al email [default].--%>
                                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right; margin-left: 0px;"
                            Width="119px" Height="22px" Visible="false">
                            <asp:ListItem Text="Numero" Value="NumeroCartaDePorte" />
                            <asp:ListItem Text="Arribo" Value="FechaArribo" />
                            <asp:ListItem Text="Titular" Value="VendedorDesc" />
                            <asp:ListItem Text="Intermediario" Value="CuentaOrden1Desc" />
                            <asp:ListItem Text="R.Comercial" Value="CuentaOrden2Desc" />
                            <asp:ListItem Text="Corredor" Value="CorredorDesc" />
                            <asp:ListItem Text="Destinatario" Value="EntregadorDesc" />
                            <asp:ListItem Text="Producto" Value="Producto" />
                            <asp:ListItem Text="Origen" Value="ProcedenciaDesc" />
                            <asp:ListItem Text="Destino" Value="DestinoDesc" />
                            <asp:ListItem Text="Descarga" Value="FechaDescarga" />
                            <asp:ListItem Text="Neto" Value="NetoFinal" />
                            <asp:ListItem Text="Exporta" Value="Export" />
                        </asp:DropDownList>
                        <%--Punto de venta--%>
                        <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="styled" Height="22px"
                            Width="" AutoPostBack="True" ToolTip="Puntos de Venta" />
                        <div>
                            <asp:TextBox ID="TextBox1" runat="server" Style="margin-left: 0px;" Width="119px"
                                Height="22px" Text="Acciones" Visible="false" />
                            <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="TextBox1"
                                DropDownControlID="DropPanel" />
                            <asp:Panel ID="DropPanel" runat="server" Visible="false">
                                <a>aklakak </a>
                            </asp:Panel>
                        </div>
                    </asp:Panel>
                    <br />
                    <br />
                    <table width="100%" cellspacing="0" cellpadding="0" style="">
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnRefresca" Text="Refrescar" runat="server" CssClass="butcancela" />&nbsp;&nbsp;
                                 <%--style="background:url(//ssl.gstatic.com/ui/v1/icons/mail/sprite_black2.png) -63px -21px no-repeat; width: 22px;
                                    height: 22px;  min-width: 32px;    " --%>

                                <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White" CausesValidation="true"
                                    Font-Size="x-Small">Ver informe</asp:LinkButton>
                                <div style="visibility: hidden; display: none">
                                    -
                                    <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="false" Font-Underline="true"
                                        Visible="false" ForeColor="White" CausesValidation="true" Font-Size="x-Small">Excel</asp:LinkButton>
                                    -
                                    <asp:LinkButton ID="LinkZipDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                                        Visible="false" ForeColor="White" CausesValidation="true" Font-Size="x-Small">Zip</asp:LinkButton>
                                </div>
                            </td>
                            <td align="right">
                                <%--1 a 8 de un gran número--%>
                                <asp:Button ID="btnPaginaRetrocede" Text="<" Font-Size="Small" CssClass="butcancela" Width="32px"
                                    runat="server" Style="width: 32px; min-width: 32px; height: 26px;" />
                                <asp:Button ID="btnPaginaAvanza" Text=">" Font-Size="Small" runat="server" CssClass="butcancela" Width="32px"
                                    Style="width: 32px; min-width: 32px; height: 26px;" />
                                <%--///////////////////////--%>
                                <asp:LinkButton ID="LinkExcelDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                                    Visible="false" ForeColor="White" CausesValidation="true" Font-Size="Small">Excel</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <div style="overflow: auto; width: 98%">
                    <asp:Panel runat="server" Width="100%">
                        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#507CBB"
                            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Width="100%"
                            AutoGenerateColumns="False" DataKeyNames="Id" PageSize="8" DataSourceID="ObjectDataSource1"
                            AllowPaging="True" AllowSorting="True" EnableSortingAndPagingCallbacks="True"
                            EnableModelValidation="True" EmptyDataText="No se encontraron registros">
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:TemplateField ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="hCheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                    </HeaderTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="hCheckBox1" runat="server" />
                                        <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                        --%>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" />
                                        <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="NUMERO" SortExpression="NumeroCartaDePorte"
                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="left">
                                    <ItemTemplate>
                                        <%--http://forums.asp.net/t/1120329.aspx--%>
                                        <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("Id") %>'
                                            Text='<%# Eval("NumeroCartaDePorte")   %>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />
                                        <asp:Label ID="Label334431" Visible="true" runat="server" Font-Bold="True" Text='<%# iif(iisnull(Eval("NumeroSubfijo"),"0") <>0, " /" & Eval("NumeroSubfijo"),"")   %>'></asp:Label>
                                        <asp:Label ID="Label15454" Visible="true" runat="server" Font-Bold="false" Text='<%#  iif(iisnull(Eval("SubnumeroVagon"),"0") <>0, " /" & Eval("SubnumeroVagon"),"") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SUBF" Visible="false" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <asp:Label ID="Label332231" runat="server" Text='<%# iif(iisnull(Eval("NumeroSubfijo"),"0") <>0, "" & Eval("NumeroSubfijo"),"")   %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="VAG" Visible="false" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <asp:Label ID="Label333331" runat="server" Text='<%# iif(iisnull(Eval("SubnumeroVagon"),"0") <>0, "" & Eval("SubnumeroVagon"),"")   %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ARRIBO" SortExpression="FechaArribo" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3331" runat="server" Text='<%# Bind("FechaArribo",  "{0:d MMM}" ) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MODIF" HeaderStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <%--<asp:Label ID="FechaModifico" Text='<%# Eval("MinutosModifico") & " min" %>' runat="server" "{0:H}" />--%>
                                        <%--<asp:Label ID="Label1" Text='<%# Eval("UsuarioIngreso") & " " & Eval("FechaModificacion","{0: H:mm}") %>'  runat="server" />--%>
                                        <asp:Label ID="Label3" Text='<%# Eval("FechaModificacion","{0: H:mm}") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TitularDesc" HeaderText="TITULAR" ItemStyle-CssClass="ColumnaConWrapAunqueNoHayaEspacios"
                                    SortExpression="TitularDesc" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="IntermediarioDesc" HeaderStyle-Width="40px" HeaderText="INTERMED"
                                    SortExpression="IntermediarioDesc" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="RComercialDesc" HeaderText="REMITENTE" SortExpression="RComercialDesc"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="CorredorDesc" HeaderText="CORREDOR" SortExpression="CorredorDesc"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="DestinatarioDesc" HeaderText="DESTINATARIO" SortExpression="DestinatarioDesc"
                                    ItemStyle-HorizontalAlign="Center" />
                                <%--<asp:BoundField DataField="Subcontr1Desc" HeaderText="SubCont1" SortExpression="Subcontr1Desc"
                                    ItemStyle-HorizontalAlign="Center" Visible="False" />
                                <asp:BoundField DataField="Subcontr2Desc" HeaderText="SubCont2" SortExpression="Subcontr2Desc"
                                    ItemStyle-HorizontalAlign="Center" Visible="False" />--%>
                                <asp:BoundField DataField="Producto" HeaderText="PROD" SortExpression="Producto"
                                    HeaderStyle-Font-Underline="false" />
                                <asp:BoundField DataField="ProcedenciaDesc" HeaderText="ORIGEN" SortExpression="ProcedenciaDesc"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="DestinoDesc" HeaderText="DESTINO" SortExpression="DestinoDesc"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="DESC" SortExpression="FechaDescarga" Visible="true">
                                    <EditItemTemplate>
                                        &nbsp;&nbsp;
                                        <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaDescarga") %>'></asp:Calendar>
                                    </EditItemTemplate>
                                    <%--<ControlStyle Width="100px" />--%>
                                    <ItemTemplate>
                                        <asp:Label ID="Label234521" runat="server" Text='<%# Bind("FechaDescarga", "{0:d MMM}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="NetoFinal" HeaderText="NETO" SortExpression="NetoFinal"
                                    DataFormatString="{0:G5}" />
                                <asp:TemplateField HeaderText="Usuario" Visible="false">
                                    <ItemStyle Width="120px" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="Usuario" Text='<%# Eval("UsuarioIngreso") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <%--
                             <PagerTemplate>
            <table width="100%">
                <tr>
                    <td style="text-align: right">
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
                    </td>               </tr>
            </table>
        </PagerTemplate>--%>
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Middle" Font-Size="X-Small"
                                Height="60" CssClass="grillarow" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle HorizontalAlign="Left" CssClass="Pager" />
                            <%--                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            --%>
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" Font-Underline="false" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <EmptyDataRowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Middle"
                                Font-Size="X-Small" Height="60" CssClass="grillarow" HorizontalAlign="Center" />
                        </asp:GridView>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
                                    Width="100%" Visible="false">
                                </rsweb:ReportViewer>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </div>
                <br />
                <br />
                <asp:LinkButton ID="lnkBorrarPosiciones" runat="server" ForeColor="White" CausesValidation="False"
                    Font-Size="x-Small" Height="18px" BorderStyle="None" Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                    BorderWidth="5px" Width="250px"
                    TabIndex="38" Visible="false">Eliminar posiciones no descargadas</asp:LinkButton>
                <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="White" CausesValidation="False" Font-Size="Small" Height="18px" BorderStyle="None"
                    Style="margin-right: 0px; margin-top: 3px; margin-bottom: 0px; margin-left: 5px;"
                    BorderWidth="5px" Width="250px" TabIndex="38" Visible="False">>>> confirmar</asp:LinkButton>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--///////////////////////////////////EL ASUNTO DEL JQUERY Y EL DIALOG //////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--<script src="../JavaScript/jquery-1.4.1.js" type="text/javascript"></script>--%>
                <%--<script type="text/javascript">
    //http: //stackoverflow.com/questions/757232/jquery-ui-dialog-with-asp-net-button-postback
    jQuery(function() {
        var dlg = jQuery("#dialog").dialog({
            draggable: true,
            resizable: true,
            show: 'Transfer',
            hide: 'Transfer',
            width: 320,
            autoOpen: false,
            minHeight: 10,
            minwidth: 10
        });
        dlg.parent().appendTo(jQuery("form:first"));
    });
</script>--%>
                <%--               
    <script type="text/javascript">
        $(document).ready(function() {
        $("#lnkBorrarPosiciones").click(function() {
                alert("Hello world!");
            });
        });
    </script>--%>
                <%--http://stackoverflow.com/questions/757232/jquery-ui-dialog-with-asp-net-button-postback--%>
                <%--http://stackoverflow.com/questions/757232/jquery-ui-dialog-with-asp-net-button-postback--%>
                <%--    <script type="text/javascript">
      jQuery(function() {
   var dlg = jQuery("#dialog").dialog({ 
                        draggable: true, 
                        resizable: true, 
                        show: 'Transfer', 
                        hide: 'Transfer', 
                        width: 320, 
                        autoOpen: false, 
                        minHeight: 10, 
                        minwidth: 10 
          });
  dlg.parent().appendTo(jQuery("form:first"));
});
    </script>


<input id="Button5" type="button" value="Open 1" onclick="javascript:openModalDiv('Div1');" visible="false"  style="display: none;"/>

                <div id="dialog" style="text-align: left;display: none;">
    <asp:Button ID="btnButton" runat="server" Text="Button" visible="false"  style="display: none;"/>       
</div>

                --%>
                <%--http://stackoverflow.com/questions/757232/jquery-ui-dialog-with-asp-net-button-postback--%>
                <%--http://stackoverflow.com/questions/757232/jquery-ui-dialog-with-asp-net-button-postback--%>
                <%--<script type="text/javascript">

    function openModalDiv(divname) {
        $('#' + divname).dialog({ autoOpen: false, bgiframe: true, modal: true });
        $('#' + divname).dialog('open');
        $('#' + divname).parent().appendTo($("form:first"));
    }

    function closeModalDiv(divname) {
        $('#' + divname).dialog('close');
    }
    </script>

<input id="Button3" type="button" value="Open 1" onclick="javascript:openModalDiv('Div1');" visible="false" style="display: none;"/>

<div id="Div1" title="Basic dialog" style="display: none;">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
       <ContentTemplate>
          postback test<br />
          <asp:Button ID="but_OK" runat="server" Text="Send request" /><br />
          <asp:TextBox ID="tb_send" runat="server"></asp:TextBox><br />
          <asp:Label ID="lbl_result" runat="server" Text="prova" ></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <input id="Button4" type="button" value="cancel" onclick="javascript:closeModalDiv('Div1');" visible="false" style="display: none;"/>
</div>--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
http://blog.roonga.com.au/2009/07/using-jquery-ui-dialog-with-aspnet-and.html
//////////////////////////////////////////////////////////////////////////////////////
                --%>
                <%--    <script type="text/javascript">
        $(document).ready(function() {
            //setup new person dialog
            $('#newPerson').dialog({
                autoOpen: false,
                draggable: true,
                title: "Add New Person",
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });

            //setup edit person dialog
            $('#editPerson').dialog({
                autoOpen: false,
                draggable: true,
                title: "Edit Person",
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });
        });

        function showDialog(id) {
            $('#' + id).dialog("open");
        }

        function closeDialog(id) {
            $('#' + id).dialog("close");
        }
              
    </script>

        <input id="btnAdd" type="button" onclick="showDialog('newPerson');" value="Add New Person" visible="false"  style="display: none;"/>
        <div id='newPerson' style="display: none;">
            <asp:UpdatePanel ID="upNewUpdatePanel" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblNewName" runat="server" AssociatedControlID="txtNewName" Text="Name"></asp:Label>
                <asp:TextBox ID="txtNewName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqName1" ControlToValidate="txtNewName" ValidationGroup="Add" runat="server" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                <asp:Button ID="btnAddSave"  runat="server" Text="Save"  style="display: none;"/>
            </ContentTemplate>
            </asp:UpdatePanel>
        </div>--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
                --%>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetListDataset" TypeName="CartaDePorteManager" DeleteMethod="Delete"
                    SortParameterName="sortExpression" UpdateMethod="Save">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                        <asp:Parameter Name="sortExpression" Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myCartaDePorte" Type="Object" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myCartaDePorte" Type="Object" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetListItems" TypeName="CartaDePorteManager" DeleteMethod="Delete"
                    UpdateMethod="Save">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                        <asp:Parameter Name="id" Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myCartaDePorte" Type="Object" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myCartaDePorte" Type="Object" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:HiddenField ID="HFSC" runat="server" />
                <%--grilla para debug del sort--%>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="true" PageSize="8"
                    AllowPaging="True" AllowSorting="True" EnableSortingAndPagingCallbacks="True"
                    EmptyDataText="sdfsdf" Caption="fbfxb">
                    <EmptyDataRowStyle BorderStyle="Dashed" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
            <ProgressTemplate>
                <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                    Visible="true"></asp:Label>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--Problemas que me hacen acordar a crystal
http://forums.asp.net/p/1426336/3211939.aspx
http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/8287e1cd-767e-463c-8cb0-60c275fe5ed6

    --%>
    <%--    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
        Height="299px" Width="770px" Visible="true">
        <LocalReport ReportPath="C:\ProntoWeb\Proyectos\Pronto\ProntoWeb\Informes\CartasDePorteTodas.rdl">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="2971b6e0-e791-40e0-a6bb-f4e0717e1d14" Name="DataSource1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>--%>




    <script>
        $(function () {
        
            $('#MenuPrincipal').hide();
        })
    </script>







</asp:Content>
