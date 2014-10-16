<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="RequerimientosB.aspx.vb" Inherits="Requerimientos" Title="Requerimientos"
    ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <br />
            <br />
            <div id="columns">
                <div class="" draggable="true">
                    <header></header>
                </div>
                <%-- <div class="column" draggable="true">
            <header>B</header>
        </div>--%>
                <%--    <div class="column" draggable="true">
            <header>C</header>
        </div>--%>
            </div>
            <div style="vertical-align: middle">
                <asp:HyperLink ID="lnkNuevo" Target='_blank' runat="server" Font-Bold="false" Font-Underline="False"
                    Width="150" Height="30" CssClass="but" ForeColor="White" CausesValidation="true"
                    NavigateUrl="RequerimientoB.aspx?Id=-1" Font-Size="Small" Style="vertical-align: middle;
                    display: inline; padding: 6px; padding-left: 12px; padding-right: 12px;" Text="+ Nuevo RM" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label12" runat="server" Text="Buscar en requerimientos" ForeColor="White"
                    Style="text-align: right" Visible="False"></asp:Label>
                <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: left;" Text="" Font-Size="Small"
                    Width="200" Height="20px" AutoPostBack="True" CssClass="txtBuscar"></asp:TextBox>
                <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                    WatermarkText="Buscar en requerimientos" WatermarkCssClass="watermarkedBuscar" />
                <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                    margin-left: 0px;" Width="119px" Height="24px">
                    <asp:ListItem Text="Numero" Value="Numero_Req_" />
                    <asp:ListItem Text="Fecha" Value="[Fecha]" />
                    <asp:ListItem Text="Recibido" Value="[Recibido]" />
                    <asp:ListItem Text="Entregado" Value="[Entregado]" />
                    <asp:ListItem Text="Impresa" Value="[Impresa]" />
                    <asp:ListItem Text="Detalle" Value="[Detalle]" />
                    <asp:ListItem Text="Cant.Items" Value="[Cant_Items]" />
                    <asp:ListItem Text="Liberada por" Value="[Liberada por]" />
                    <asp:ListItem Text="Solicitada por" Value="[Solicitada por]" />
                    <asp:ListItem Text="Obra" Value="[Obra]" />
                    <asp:ListItem Text="Sector" Value="[Sector]" />
                    <asp:ListItem Text="Origen" Value="[Origen]" />
                    <asp:ListItem Text="Equipo destino" Value="[Equipo destino]" />
                    <asp:ListItem Text="Anulo" Value="[Anulo]" />
                    <asp:ListItem Text="Fecha anulacion" Value="[Fecha anulacion]" />
                    <asp:ListItem Text="Motivo anulacion" Value="[Motivo anulacion]" />
                    <asp:ListItem Text="Tipo compra" Value="[Tipo compra]" />
                    <asp:ListItem Text="2da.Firma" Value="[2da_Firma]" />
                    <asp:ListItem Text="Fecha 2da.Firma" Value="[Fecha 2da_Firma]" />
                    <asp:ListItem Text="Comprador" Value="[Comprador]" />
                    <asp:ListItem Text="Importada por" Value="[Importada por]" />
                    <asp:ListItem Text="Fec.llego SAT" Value="[Fec_llego SAT]" />
                    <asp:ListItem Text="Fechas de liberacion" Value="[Fechas de liberacion para compras por item]" />
                    <asp:ListItem Text="Detalle imputacion" Value="[Detalle imputacion]" />
                    <asp:ListItem Text="Observaciones" Value="[Observaciones]" />
                    <asp:ListItem Text="Elim.Firmas" Value="[Elim_Firmas]" />
                </asp:DropDownList>
                <asp:DropDownList ID="cmbMesFiltro" runat="server" Style="text-align: right; margin-left: 0px;"
                    Width="80px" Height="24px" AutoPostBack="True" Visible="false">
                    <asp:ListItem Text="Elija mes" Selected="True" />
                    <asp:ListItem Text="Marzo    2011" />
                    <asp:ListItem Text="Febrero  2011" />
                    <asp:ListItem Text="Enero    2011" />
                </asp:DropDownList>
            </div>
            <br />
            <br />
            <table id="comandogrilla" width="99%" cellspacing="0" cellpadding="0" style="">
                <tr>
                    <td align="left">
                        <asp:Button ID="btnRefresca" Text="Refrescar" runat="server" CssClass="butcancela" />&nbsp;&nbsp;
                        <asp:Button ID="btnExcel" Text="Excel" runat="server" CssClass="butcancela" />&nbsp;&nbsp;
                        <%--style="background:url(//ssl.gstatic.com/ui/v1/icons/mail/sprite_black2.png) -63px -21px no-repeat; width: 22px;
                                    height: 22px;  min-width: 32px;    " --%>
                        <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White" CausesValidation="true" Visible=false
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
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                            <ProgressTemplate>
                                <img src="Imagenes/25-1.gif" alt="" style="height: 16px" />
                                <asp:Label ID="Label342" runat="server" Text="Cargando..." Visible="true"></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblGrilla1Info" runat="server"></asp:Label>
                        <%--1 a 8 de un gran número--%>
                        <asp:Button ID="btnPaginaRetrocede" Text="<" Font-Size="Small" CssClass="butcancela"
                            Width="32px" runat="server" Style="width: 32px; min-width: 32px; height: 26px;" />
                        <asp:Button ID="btnPaginaAvanza" Text=">" Font-Size="Small" runat="server" CssClass="butcancela"
                            Width="32px" Style="width: 32px; min-width: 32px; height: 26px;" />
                        <%--///////////////////////--%>
                        <asp:LinkButton ID="LinkExcelDescarga" runat="server" Font-Bold="false" Font-Underline="true"
                            Visible="false" ForeColor="White" CausesValidation="true" Font-Size="Small">Excel</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <br />
            <script language="javascript" type="text/javascript">
                // http: //stackoverflow.com/questions/8067721/how-to-make-a-gridview-with-maxmimum-size-set-to-the-containing-div

                function grillasize() {


                    alturaprimerrenglon = 40;   // $("#divMasterMargenIzquierdo").height(h)
                    var w = $(window).width() - 210;
                    var h = $(window).height() - alturaprimerrenglon;
                
                         
                
                    $("#divGrid").height(h - 150);
                    $("#divprop").height(0);
                    $("#divsupercontenedor").height(h);
                    $("#divcontentplaceholder").height(h-5);
                //    $("#divsupercontenedor").css("max-height", (h+0)  + 'px !important');
                    //                    $("#gridview1").height(h);


                    $("#divGrid").width(w);
                    $("#comandogrilla").width(w);
                }

                // http: //blog.dreamlabsolutions.com/post/2009/02/24/jQuery-document-ready-and-ASP-NET-Ajax-asynchronous-postback.aspx
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    if (args.get_error() == undefined) {
                        grillasize();
                    }
                }


                $(function () {
                    $(window).resize(function () {
                        grillasize();
                    });
                });

                $(document).ready(function () {
                    grillasize();

                });
            </script>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left">
                        <div id="divGrid" style="overflow: auto;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderStyle="None" BorderWidth="3px" CellPadding="15" CellSpacing="5" DataKeyNames="Id"
                                DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width="99%"
                                CssClass="grillaListado" PageSize="8">
                                <%-- <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />--%>
                                <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                       <div class="column" draggable="true">
                                            <header>*</header>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="false" EditText="Editar" />
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <asp:TemplateField HeaderText="Número" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "RequerimientoB.aspx?Id=" & Eval("Id") %>'
                                                Text='<%# Eval("Numero")   %>' Font-Bold="True" Font-Underline="false"> </asp:HyperLink>
                                            <br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("Fecha") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fecha", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id"
                                        ItemStyle-Width="430">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                                GridLines="none" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="1"
                                                CellSpacing="0" SkinID="NewSkin" Font-Size="Small" ShowHeader="false" Width="430px">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo" ItemStyle-Width="350"
                                                        ItemStyle-CssClass="GrillaAnidadContenidoQueCorta">
                                                        <ItemStyle Wrap="false" />
                                                        <HeaderStyle />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cant_" HeaderText="Cantidad" ItemStyle-Width="80" ItemStyle-HorizontalAlign="Right">
                                                        <ItemStyle />
                                                        <HeaderStyle />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                                <RowStyle  ForeColor="#4A3C8C" BorderColor="#CBCBCB" VerticalAlign="middle"
                                                    Width="430px" />
                                              <%--  <AlternatingRowStyle BackColor="#FFFFFF" Font-Bold="false" ForeColor="#4A3C8C" Wrap="False" />--%>
                                                <FooterStyle BackColor="#F7F7F7" Font-Bold="false" ForeColor="#4A3C8C" Wrap="False"
                                                    BorderColor="transparent" />
                                                <PagerStyle CssClass="Pager" />
                                                <PagerStyle BackColor="#F7F7F7" ForeColor="#4A3C8C" HorizontalAlign="Left" BorderColor="transparent" />
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ControlStyle BorderStyle="None" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Cump_" HeaderText="Cump" />
                                    <asp:BoundField DataField="Recibido" HeaderText="Recibido" />
                                    <asp:BoundField DataField="Entregado" HeaderText="Entregado" />
                                    <asp:BoundField DataField="Impresa" HeaderText="Impresa" />
                                    <asp:BoundField DataField="Detalle" HeaderText="Detalle" Visible="false" />
                                    <asp:TemplateField HeaderText="Obra" SortExpression="Obra"   ItemStyle-CssClass="GrillaAnidadContenido">
                                        <EditItemTemplate>
                                            <%--<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1" DataTextField="Titulo" DataValueField="IdObra" SelectedValue='<%# Bind("IdObra") %>'>
                    </asp:DropDownList><asp:ObjectDataSource ID="" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ObraManager"></asp:ObjectDataSource>--%>
                                        </EditItemTemplate>
                                        <ItemStyle Wrap="True" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Obra") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Presupuestos" HeaderText="Presupuestos" />
                                    <asp:BoundField DataField="Comparativas" HeaderText="Comparativas" />
                                    <asp:BoundField DataField="Pedidos" HeaderText="Pedidos" />
                                    <asp:BoundField DataField="Recepciones" HeaderText="Recepciones" />
                                    <asp:BoundField DataField="Salidas" HeaderText="Salidas" />
                                    <asp:BoundField DataField="Cant_Items" HeaderText="Cant.Items" />
                                    <asp:BoundField DataField="Liberada_por" HeaderText="Liberada por" />
                                    <asp:BoundField DataField="Solicitada_por" HeaderText="Solicitada por" />
                                    <asp:BoundField DataField="Sector" HeaderText="Sector" />
                                    <asp:BoundField DataField="Origen" HeaderText="Origen" />
                                    <%--   <asp:BoundField DataField="Fecha imp_transm" HeaderText="Cump" />--%>
                                    <asp:BoundField DataField="Equipo_destino" HeaderText="Equipo destino" />
                                    <asp:BoundField DataField="Anulo" HeaderText="Anulo" />
                                    <asp:BoundField DataField="Fecha_anulacion" HeaderText="Fecha anulacion" />
                                    <asp:BoundField DataField="Motivo_anulacion" HeaderText="Motivo anulacion" />
                                    <asp:BoundField DataField="Tipo_compra" HeaderText="Tipo compra" />
                                    <asp:BoundField DataField="_2da_Firma" HeaderText="2da.Firma" />
                                    <asp:BoundField DataField="Fecha_2da_Firma" HeaderText="Fecha 2da.Firma" />
                                    <asp:BoundField DataField="Comprador" HeaderText="Comprador" />
                                    <asp:BoundField DataField="Importada_por" HeaderText="Importada por" />
                                    <asp:BoundField DataField="Fec_llego_SAT" HeaderText="Fec.llego SAT" />
                                    <asp:BoundField DataField="Fechas_de_liberacion_para_compras_por_item" HeaderText="Fecha lib." />
                                    <asp:BoundField DataField="Detalle_imputacion" HeaderText="Detalle imputacion" />
                                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                                    <asp:BoundField DataField="Elim_Firmas" HeaderText="Elim.Firmas" />
                                    <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
                                </Columns>
                                <RowStyle BackColor="#F7F7F7" ForeColor="#4A3C8C" VerticalAlign="middle" BorderColor="#CBCBCB" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#E7E7FF" Font-Bold="True" ForeColor="#4A3C8C" Wrap="False" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetList" TypeName="Pronto.ERP.Bll.RequerimientoManager"
                                DeleteMethod="Delete" UpdateMethod="Save" EnablePaging="true" StartRowIndexParameterName="startRowIndex"
                                MaximumRowsParameterName="maximumRows" SelectCountMethod="GetTotalNumberOfRMs">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myRequerimiento" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myRequerimiento" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.RequerimientoManager" DeleteMethod="Delete"
                                UpdateMethod="Save">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:Parameter Name="id" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myRequerimiento" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myRequerimiento" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:HiddenField ID="HFSC" runat="server" />
                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/requerimientos" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\Requerimientos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
</asp:Content>
