<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Facturas, App_Web_xfaclkjq" title="Facturas" enableeventvalidation="false" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <asp:Panel ID="paneldebug" runat="server">
        <asp:LinkButton ID="LinkButton4" runat="server" href="    http://localhost:48391/ProntoWeb/ProntoWeb/FacturaElectronicaEncriptada.aspx?Id=PVlNDYiqghI=">
         http://localhost:48391/ProntoWeb/ProntoWeb/FacturaElectronicaEncriptada.aspx?Id=PVlNDYiqghI=
        </asp:LinkButton>
        <br />
        <asp:LinkButton ID="LinkButton2" runat="server" href="http://190.2.243.16/prontotesting/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=m3h+rvkaLUw=">
     http://190.2.243.16/prontotesting/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFactura&Id=m3h+rvkaLUw=
        </asp:LinkButton>
        <br />
        <br />
        <a>http://localhost:48391/ProntoWeb/ProntoWeb/Cliente.aspx?id=21287 </a>
        <br />
        <asp:LinkButton ID="LinkButton3" runat="server" href="http://190.2.243.16/prontotesting/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFacturaDOCX&Id=m3h+rvkaLUw=">
     http://190.2.243.16/prontotesting/ProntoWeb/FacturaElectronicaEncriptada.aspx?Modo=DescargaFacturaDOCX&Id=m3h+rvkaLUw=
        </asp:LinkButton>
        <br />
        <asp:LinkButton runat="server" ID="lala" href="http://localhost:48391/ProntoWeb/ProntoWeb/Facturas.aspx?Modo=DOCX&ImprimirDesde=20000&ImprimirHasta=20001">
        http://localhost:48391/ProntoWeb/ProntoWeb/Facturas.aspx?Modo=DOCX&ImprimirDesde=20000&ImprimirHasta=20001
        </asp:LinkButton>
        <br />
        <asp:LinkButton runat="server" ID="LinkButton1" href="http://localhost:48391/ProntoWeb/ProntoWeb/Facturas.aspx?Modo=FacturaElectronica&ImprimirDesde=64674&ImprimirHasta=64676&Cliente=CRESUD SACIF Y A&">
        <%--   
3) Impresión de facturas:
a- Por impresión se entiende la descarga del PDF o el envío de los PDF por mail.
b- No se podrá imprimir facturas que no tengan el CAE ingresado.
c- Ajuste formato de impresión (ahora se emitirá toda la factura, incluido el número)
d- 
i) En el listado de facturas, sacar el botón "Facturas (Word)" y cambiarlo por "Enviar Facturas a clientes".
ii) Este botón enviará para cada factura tildada (o el lote seleccionado) un mail al cliente con un link.
iii) Al abrir el link el cliente verá directamente la factura en PDF (sin login) y si correspondiese un link al adjunto de la factura.
iv) Parametrizar en los clientes el tipo de adjunto que se les envía.
Las opciones son: 
"SIN ENVIO DE ADJUNTOS"
"TEXTO" (lo que se descarga de TEXTO A4)
"EXCEL" 
"EXCEL COMPLETO" (el excel con el mismo formato del listado general, que hoy se descarga desde "Cartas Imputadas")


--%>
        http://localhost:48391/ProntoWeb/ProntoWeb/Facturas.aspx?Modo=FacturaElectronica&ImprimirDesde=64674&ImprimirHasta=64676&Cliente=CRESUD SACIF Y A
        </asp:LinkButton>
    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <asp:DropDownList ID="DropDownList2" runat="server" Style="text-align: right; margin-left: 0px;"
                            Height="22px" Visible="false">
                            <asp:ListItem Text="X" />
                        </asp:DropDownList>
                        <asp:LinkButton ID="lnkNuevo" runat="server" CausesValidation="true" CssClass="butCrear but"
                            ForeColor="White" Font-Underline="false" Visible="false">+   Nuevo</asp:LinkButton>
                        <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                            Visible="False"></asp:Label>
                        <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
                        <cc1:TextBoxWatermarkExtender ID="TBWE1" runat="server" TargetControlID="txtBuscar"
                            WatermarkText="buscar" WatermarkCssClass="watermarkedbuscar" />
                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                            margin-left: 0px;" Width="119px" Height="22px">
                            <asp:ListItem Text="Numero" Value="Numero" />
                            <asp:ListItem Text="Fecha" Value="[Fecha Factura]" />
                            <asp:ListItem Text="Cliente" Value="Cliente" />
                            <asp:ListItem Text="Corredor" Value="Vendedor" />
                            <asp:ListItem Text="Anulada" Value="Anulada" />
                            <asp:ListItem Text="Total" Value="[Total factura]"  />
                            <asp:ListItem Text="Enviada" Value="FueEnviadoCorreoConFacturaElectronica"                                />
                        </asp:DropDownList>
                        <asp:TextBox ID="txtFechaDesde" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                            AutoPostBack="false" />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                            TargetControlID="txtFechaDesde" />
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaDesde" />
                        <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                            WatermarkText="desde" WatermarkCssClass="watermarked" />
                        <asp:TextBox ID="txtFechaHasta" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"
                            AutoPostBack="false" />
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                            TargetControlID="txtFechaHasta" />
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaHasta" />
                        <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                            WatermarkText="hasta" WatermarkCssClass="watermarked" />
                        
                        <asp:Button ID="btnRefrescar" runat="server" Text="Refrescar" Visible="true" />

                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir" Visible="true" />

                        
                    </td>
                    <td align="right">
                        <div>
                            <asp:TextBox ID="DropDownList1" runat="server" Style="margin-left: 0px;" Width="119px"
                                Height="22px" Text="Acciones" Visible="false" />
                            <ajaxToolkit:DropDownExtender runat="server" ID="DDE" TargetControlID="DropDownList1"
                                DropDownControlID="DropPanel" />
                            <asp:Panel ID="DropPanel" runat="server" Visible="false">
                                <a>aklakak </a>
                            </asp:Panel>
                        </div>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="true"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <table style="overflow: auto; width: 100%;">
                <tr>
                    <td align="left">
                        <div style="overflow: auto; width: 100%; max-width: 1000px">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                                DataSourceID="ObjectDataSource1" GridLines="Horizontal" AllowPaging="True" Width=""
                                PageSize="8">
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
                                    <asp:ButtonField CommandName="Ver" Text="ver" Visible="false" />
                                    <asp:TemplateField ShowHeader="true" Visible="true" HeaderText="NUMERO" SortExpression="NumeroCartaDePorte"
                                        HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="true" ItemStyle-HorizontalAlign="left">
                                        <ItemTemplate>
                                            <%--http://forums.asp.net/t/1120329.aspx--%>
                                            <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "Factura.aspx?Id=" & Eval("Id") %>'
                                                Text="ver" Font-Size="Small" Font-Bold="True" Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                            <br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:CommandField ShowEditButton="True" EditText="Ver" />--%>
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <asp:BoundField DataField="A/B/E" HeaderText="" />
                                    <asp:BoundField DataField="Pto_vta_" HeaderText="" />
                                    <%--Eval("A/B/E") & " "& "-" &--%>
                                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("[Fecha Factura]") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Fecha Factura]", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                    <asp:BoundField DataField="FueEnviadoCorreoConFacturaElectronica" HeaderText="Enviada" />
                                    <%--& Eval("[]") --%>
                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" />
                                    <asp:BoundField DataField="Total factura" HeaderText="Total" />
                                    <%--            <asp:BoundField DataField="Anulada" HeaderText="Anulada" />--%>
                                    <%--            <asp:TemplateField HeaderText="Obra" SortExpression="Obra">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1" DataTextField="Titulo" DataValueField="IdObra" SelectedValue='<%# Bind("IdObra") %>'>
                    </asp:DropDownList><asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ObraManager"></asp:ObjectDataSource>
                </EditItemTemplate>
                <ItemStyle Wrap="True" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Obra") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Articulo" HeaderText="" ItemStyle-Width="300">
                                                        <ItemStyle Font-Size="X-Small" Wrap="False" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Cantidad" HeaderText="cant.">
                                                        <ItemStyle Font-Size="X-Small" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <RowStyle ForeColor="#000066" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ControlStyle BorderStyle="None" />
                                    </asp:TemplateField>
                                    <%--            <asp:BoundField DataField="IdObra" HeaderText="IdObra" Visible="False" />
                                    --%>
                                    <asp:BoundField DataField="Cod_Cli_" HeaderText="Cod_Cli_" />
                                    <asp:BoundField DataField="Condicion IVA" HeaderText="Condicion IVA" />
                                    <asp:BoundField DataField="Cuit" HeaderText="Cuit" />
                                    <asp:BoundField DataField="Fecha Factura" HeaderText="Fecha Factura" />
                                    <%--            <asp:BoundField DataField="Ordenes de compra" HeaderText="Ordenes de compra" />--%>
                                    <%--            <asp:BoundField DataField="Remitos" HeaderText="Remitos" />--%>
                                    <%--  <asp:BoundField DataField="Neto gravado" HeaderText="Neto gravado" />--%>
                                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" />
                                    <asp:BoundField DataField="Iva" HeaderText="Iva" />
                                    <asp:BoundField DataField="IIBB" HeaderText="IIBB" />
                                    <asp:BoundField DataField="Perc_IVA" HeaderText="Perc_IVA" />
                                    <asp:BoundField DataField="Total factura" HeaderText="Total factura" />
                                    <asp:BoundField DataField="Mon_" HeaderText="Mon_" />
                                    <asp:BoundField DataField="Telefono del cliente" HeaderText="Telefono del cliente" />
                                    <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" />
                                    <asp:BoundField DataField="Ingreso" HeaderText="Ingreso" />
                                    <asp:BoundField DataField="Fecha ingreso" HeaderText="Fecha ingreso" />
                                    <asp:BoundField DataField="Obra (x defecto)" HeaderText="Obra (x defecto)" />
                                    <asp:BoundField DataField="Provincia destino" HeaderText="Provincia destino" />
                                    <asp:BoundField DataField="Cant_Items" HeaderText="Cant_Items" />
                                    <asp:BoundField DataField="Cant_Abonos" HeaderText="Cant_Abonos" />
                                    <%--            <asp:BoundField DataField="Grupo facturacion automatica" HeaderText="Grupo facturacion automatica" />
            <asp:BoundField DataField="Act_Rec_Gtos_" HeaderText="Act_Rec_Gtos_" />
            <asp:BoundField DataField="Fecha Contab_" HeaderText="Fecha Contab_" />--%>
                                    <asp:BoundField DataField="CAE" HeaderText="CAE" />
                                    <asp:BoundField DataField="Rech_CAE" HeaderText="Rech_CAE" />
                                    <asp:BoundField DataField="Fecha vto_CAE" HeaderText="Fecha vto_CAE" />
                                    <asp:BoundField DataField="Ingreso" HeaderText="Ingreso" />
                                </Columns>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                        </div>
                        <br />
                        <br />
                        <br /><br />
                        <div style="color: White">
                            Imprimir lote</div>
                        <asp:TextBox ID="txtFacturaDesde" runat="server" Width="110px" CssClass="UpperCase"
                            Style="margin-left: 10px" />
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="A-9999-99999999" MaskType="Date"
                            TargetControlID="txtFacturaDesde" />
                        <%--       <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtFacturaDesde"
             WatermarkText="desde" WatermarkCssClass="watermarked" />--%>
                        <asp:TextBox ID="txtFacturaHasta" runat="server" Width="110px" CssClass="UpperCase"
                            Style="margin-left: 10px" />
                        
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="A-9999-99999999" MaskType="Date"
                            TargetControlID="txtFacturaHasta" />
                        
                        <asp:Button ID="btnImprimirLoteFacturas" runat="server" Text="Facturas" Visible="false" />
                        <asp:Button ID="btnImprimirLoteFacturasNET" runat="server" Text="Facturas (Word)"
                            Visible="false" />
                        <br />
                        <asp:Button ID="Button1" runat="server" Text="Factura electronicas por mail al cliente (PDF)" />
                        <asp:Button ID="Button2" runat="server" Text="Vista previa por mail (PDF)" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimirLoteFacturasNETzip" runat="server" Text="ZIP" Visible="false" />
                        <asp:Button ID="btnImprimirLoteFacturasAdjuntoWilliams" runat="server" Text="Adjuntos (texto)" />
                        <asp:Button ID="btnImprimirLoteFacturasAdjuntoWilliamsA4" runat="server" Text="Adjuntos A4 (texto)" />
                        <asp:Button ID="btnMandarAdjuntosMails" runat="server" Text="Adjuntos por mail (Excel)" />

                        <asp:Button ID="btnFacturasNoEnviadas" runat="server" Text="Facturas no enviadas " />


                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                                <asp:Label ID="Label32242" runat="server" Text="Actualizando datos..." ForeColor="White"
                                    Visible="true"></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.FacturaManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myFactura" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myFactura" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.FacturaManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myFactura" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myFactura" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="95%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True" BackColor="White">
                    <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                    --%>
                </rsweb:ReportViewer>
                <span>
                    <%--<div>--%>
                    <%--botones de alta y excel--%>
                    <%--</div>--%>
                </span>
            </div>
            <asp:Label ID="Label3" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/Facturas" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\Facturas.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:ReportViewer ID="ReporteLocal" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="95%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True"
                    BackColor="White">
                    <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                    --%>
                </rsweb:ReportViewer>
                <span>
                    <%--<div>--%>
                    <%--botones de alta y excel--%>
                    <%--</div>--%>
                </span>
            </div>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
