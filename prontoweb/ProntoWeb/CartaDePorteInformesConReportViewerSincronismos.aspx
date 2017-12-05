<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CartaDePorteInformesConReportViewerSincronismos.aspx.vb" Inherits="CartaDePorteInformesConReportViewerSincronismos"
    Title="Informes" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton runat="server" ID="lala" href="http://localhost:48391/ProntoWeb/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?sincro=YPF&Destinatario=Y.P.F. S.A&desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos">
        http://localhost:48391/ProntoWeb/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?sincro=YPF&Destinatario=Y.P.F. S.A&desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos
    </asp:LinkButton>


    <asp:UpdatePanel ID="UpdatePanelResumen" runat="server">
        <ContentTemplate>
            <br />
            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                cellpadding="0" cellspacing="0">
                <%--          <tr>
                    <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; font-size: large;
                        height: 32px;" align="left" valign="top">
                        Informes y Sincronismos
                        <asp:Label ID="lblAnulado0" runat="server" BackColor="#CC3300" BorderColor="White"
                            BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                            Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                            Visible="False" Width="120px"></asp:Label>
                    </td>
                    <td style="height: 32px;" valign="top" align="right" colspan="3" class="style7">
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                            <ProgressTemplate>
                                <img src="Imagenes/25-1.gif" alt="" style="height: 22px" />
                                <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                    Visible="true"></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>--%>
                <tr>
                    <%--
                    <td style="width: 101px; height: 24px;" class="EncabezadoCell">
                        Informe 
                    </td>--%>
                    <td style="width: 175px; height: 24px;" align="right">
                        <%--<asp:ListBox ID="ListBox1" runat="server" Width="500px" AutoPostBack="true" Font-Size="14px"
                            Height="650px" Style="margin-left: 0px;">--%>
                        <asp:DropDownList ID="cmbInforme" runat="server" Width="400px" AutoPostBack="true"
                            Font-Size="18px" Height="32px" Style="margin-left: 0px; max-height: 300px;">
                            <asp:ListItem>-- Elija un informe --</asp:ListItem>
                            <asp:ListItem>Descargar imágenes</asp:ListItem>
                            <asp:ListItem>Descargar imágenes en PDF</asp:ListItem>
                            <asp:ListItem>Descargar imágenes en TIFF</asp:ListItem>
                            <asp:ListItem Selected="True">Listado general de cartas de porte (solo originales)</asp:ListItem>
                            <asp:ListItem>Listado general de cartas de porte (con imagen)</asp:ListItem>
                            <asp:ListItem>Listado general de cartas de porte + copias</asp:ListItem>
                            <asp:ListItem>Listado general de cartas de porte sin copias ni originales copiados</asp:ListItem>
                            <asp:ListItem>Listado general de Cartas de Porte - Con Recibidor Oficial</asp:ListItem>
                            <asp:ListItem>Listado general de Cartas de Porte - Con tipo de movimiento</asp:ListItem>
                            <asp:ListItem>Listado general formato Cresud</asp:ListItem>
                            <asp:ListItem>Notas de entrega (a matriz de puntos)</asp:ListItem>
                            <asp:ListItem>NotasEntregaCONVERTIR</asp:ListItem>
                            <asp:ListItem>Notas de entrega (a laser)</asp:ListItem>
                            <asp:ListItem>-------------------------------------------------------------------------------------</asp:ListItem>
                            <asp:ListItem>Descargas por Titular compactado</asp:ListItem>
                            <%--                    <asp:ListItem>Notas de entrega continuo</asp:ListItem>
                    <asp:ListItem>Notas de entrega automático:</asp:ListItem>
                            --%>
                            <asp:ListItem>Descargas por Titular detallado</asp:ListItem>
                            <%--                    <asp:ListItem>Descargas por Cargador compactado</asp:ListItem>
                            --%>
                            <asp:ListItem>Descargas por Corredor compactado</asp:ListItem>
                            <asp:ListItem>Descargas por Corredor detallado</asp:ListItem>
                            <asp:ListItem>Descargas por Contrato compactado</asp:ListItem>
                            <asp:ListItem>Descargas por Contrato detallado</asp:ListItem>
                            <asp:ListItem>Totales generales por puerto</asp:ListItem>
                            <asp:ListItem>Totales generales por mes</asp:ListItem>
                            <asp:ListItem>Taras por Camiones</asp:ListItem>
                            <asp:ListItem>Liquidación de Subcontratistas</asp:ListItem>
                            <asp:ListItem>Control Kilos de Descarga</asp:ListItem>
                            <%--                    <asp:ListItem>Totales por puerto y por fábrica</asp:ListItem>
                            --%>
                            <asp:ListItem Enabled="false">Comisiones por puerto y por cereal</asp:ListItem>
                            <asp:ListItem>-------------------------------------------------------------------------------------</asp:ListItem>
                            <asp:ListItem>Cartas Duplicadas</asp:ListItem>
                            <asp:ListItem>Cartas Duplicadas pendientes de asignar</asp:ListItem>
                            <asp:ListItem>Planilla de movimientos</asp:ListItem>
                            <%--                            <asp:ListItem>Listado de Tarifas</asp:ListItem>--%>
                            <%--
                            <asp:ListItem>Resumen de facturación</asp:ListItem>
                            <asp:ListItem>Proyección de facturación</asp:ListItem>
                            <asp:ListItem>Ranking de Cereales</asp:ListItem>
                            <asp:ListItem>Ranking de Clientes</asp:ListItem>
                            <asp:ListItem>Totales generales por mes por sucursal</asp:ListItem>
                            <asp:ListItem>Totales generales por mes por modo</asp:ListItem>
                            <asp:ListItem>Totales generales por mes por modo y sucursal</asp:ListItem>
                            <asp:ListItem>Estadísticas de Toneladas descargadas (Modo-Sucursal)</asp:ListItem>
                            <asp:ListItem>Estadísticas de Toneladas descargadas (Sucursal-Modo)</asp:ListItem>
                            <asp:ListItem>Volumen de Carga</asp:ListItem>
                            <asp:ListItem>Diferencias por Destino por Mes</asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnRefrescar" Text="refrescar" runat="server" Visible="True" CssClass="butcancela"
                            Height="32" Width="100" />
                        <asp:Button ID="btnExcel" Text="Descargar excel" runat="server" Visible="false" />
                        <asp:Button ID="btnTexto" Text="Descargar Notas de Entrega" runat="server" Visible="false" />
                        <asp:Button ID="Button1" Text="SubcontratistaFix" runat="server" Height="30" Visible="false" />
                    </td>
                    <td class="EncabezadoCell" style="width: 200px; height: 18px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%--Sincronismo--%>
                    </td>
                    <td>
                        <asp:DropDownList ID="cmbSincronismo" runat="server" Width="307px" AutoPostBack="true"
                            Font-Size="18px" Height="32" Style="margin-left: 0px">
                            <asp:ListItem Enabled="False">-- Elija un informe --</asp:ListItem>
                            <asp:ListItem Enabled="False" Selected="False">Listado general de cartas de porte</asp:ListItem>
                            <asp:ListItem Enabled="False">Notas de entrega (a matriz de puntos)</asp:ListItem>
                            <asp:ListItem Enabled="False">Descargas por Titular compactado</asp:ListItem>
                            <%--                    <asp:ListItem>Notas de entrega continuo</asp:ListItem>
                    <asp:ListItem>Notas de entrega automático:</asp:ListItem>
                            --%>
                            <asp:ListItem Enabled="False">Descargas por Titular detallado</asp:ListItem>
                            <%--                    <asp:ListItem>Descargas por Cargador compactado</asp:ListItem>
                            --%>
                            <asp:ListItem Enabled="False">Descargas por Corredor compactado</asp:ListItem>
                            <asp:ListItem Enabled="False">Descargas por Corredor detallado</asp:ListItem>
                            <asp:ListItem Enabled="False">Descargas por Contrato compactado</asp:ListItem>
                            <asp:ListItem Enabled="False">Descargas por Contrato detallado</asp:ListItem>
                            <asp:ListItem Enabled="False">Totales generales por puerto</asp:ListItem>
                            <asp:ListItem Enabled="False">Totales generales por mes</asp:ListItem>
                            <asp:ListItem Enabled="False">Taras por Camiones</asp:ListItem>
                            <asp:ListItem Enabled="False">Liquidación de Subcontratistas</asp:ListItem>
                            <%--                    <asp:ListItem>Totales por puerto y por fábrica</asp:ListItem>
                            --%>
                            <asp:ListItem Enabled="False">Comisiones por puerto y por cereal</asp:ListItem>
                            <asp:ListItem Enabled="False">Resumen de facturación</asp:ListItem>
                            <asp:ListItem Enabled="False">Planilla de movimientos</asp:ListItem>
                            <asp:ListItem Enabled="False"> </asp:ListItem>
                            <asp:ListItem>--- elija un Sincronismo ----</asp:ListItem>
                            <asp:ListItem Enabled="true">A.C.A.</asp:ListItem>
                            <asp:ListItem Enabled="False">ADM</asp:ListItem>
                            <asp:ListItem Enabled="True">Agrosur</asp:ListItem>
                            <asp:ListItem Enabled="True">Alabern</asp:ListItem>
                            <asp:ListItem Enabled="True">Alabern (calidades)</asp:ListItem>
                            <asp:ListItem Enabled="True">Alea</asp:ListItem>
                            <asp:ListItem Enabled="True">Aibal</asp:ListItem>
                            <asp:ListItem Enabled="True">AJNari</asp:ListItem>
                            <asp:ListItem Enabled="True">Amaggi (descargas) [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="True">Amaggi (calidades) [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="True">Andreoli</asp:ListItem>
                            <asp:ListItem Enabled="True">Argencer</asp:ListItem>
                            <asp:ListItem Enabled="True">Beraza</asp:ListItem> <%-- [Algoritmo]--%>
                            <asp:ListItem Enabled="True">BLD</asp:ListItem>
                            <asp:ListItem Enabled="True">BLDCONVERTIR</asp:ListItem>
                            <asp:ListItem Enabled="True">BLD (calidades)</asp:ListItem>
                            <asp:ListItem Enabled="True">BLD (posición demorados)</asp:ListItem>
                            <asp:ListItem Enabled="True">BTG PACTUAL [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="True">Bunge</asp:ListItem>
                            <asp:ListItem Enabled="True">CGG</asp:ListItem>
                            <asp:ListItem Enabled="True">CGG (calidades)</asp:ListItem>
                            <asp:ListItem Enabled="True">Chiambretto</asp:ListItem>
                            <asp:ListItem Enabled="true">Diaz Forti [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="true">Diaz Riganti</asp:ListItem>
                            <asp:ListItem Enabled="true">DOW</asp:ListItem>
                            <asp:ListItem Enabled="true">DOW formato anterior</asp:ListItem>
                            <asp:ListItem Enabled="true">Dukarevich</asp:ListItem>
                            <asp:ListItem Enabled="true">El Enlace</asp:ListItem>
                            <asp:ListItem Enabled="false">El Tejar</asp:ListItem>
                            <asp:ListItem Enabled="true">Estanar</asp:ListItem>
                            <asp:ListItem Enabled="True">Lartirigoyen</asp:ListItem>
                            <asp:ListItem Enabled="True">La Biznaga</asp:ListItem>
                            <asp:ListItem Enabled="True">La Bragadense</asp:ListItem>
                            <asp:ListItem Enabled="True">Leiva</asp:ListItem>
                            <asp:ListItem Enabled="True">Lelfun</asp:ListItem>
                            <asp:ListItem Enabled="True">Los Grobo [Algoritmo]</asp:ListItem>
                            <asp:ListItem Enabled="true">FYO</asp:ListItem>
                            <asp:ListItem Enabled="true">FYO (posición)</asp:ListItem>
                            <asp:ListItem Enabled="true">Gesagro</asp:ListItem>
                            <asp:ListItem Enabled="true">Granar</asp:ListItem>
                            <asp:ListItem Enabled="true">Granos del Parana</asp:ListItem>
                            <asp:ListItem Enabled="true">Granos del Litoral</asp:ListItem>
                            <asp:ListItem Enabled="true">Grimaldi Grassi</asp:ListItem>
                            <asp:ListItem Enabled="True">Gualeguay</asp:ListItem>
                            <asp:ListItem Enabled="true">Miguel Cinque</asp:ListItem>
                            <asp:ListItem Enabled="true">Monsanto</asp:ListItem>
                            <asp:ListItem Enabled="True">Morgan (descargas) [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="True">Morgan (calidades) [BIT]</asp:ListItem>
                            <asp:ListItem Enabled="true">Nidera</asp:ListItem>
                            <asp:ListItem Enabled="true">Noble</asp:ListItem>
                            <asp:ListItem Enabled="true">Noble (anexo calidades)</asp:ListItem>
                            <asp:ListItem Enabled="true">Ojeda</asp:ListItem>
                            <asp:ListItem Enabled="true">Pelayo</asp:ListItem>
                            <asp:ListItem Enabled="true">PetroAgro</asp:ListItem>
                            <asp:ListItem Enabled="true">PSA La California</asp:ListItem>
                            <asp:ListItem Enabled="true">PSA La California (calidades)</asp:ListItem>
                            <asp:ListItem Enabled="true">Rivara</asp:ListItem>
                            <asp:ListItem Enabled="true">Roagro</asp:ListItem>
                            <asp:ListItem Enabled="true">Santa Catalina</asp:ListItem>
                            <asp:ListItem Enabled="true">Syngenta</asp:ListItem>
                            <asp:ListItem Enabled="true">Syngenta Facturación</asp:ListItem>
                            <asp:ListItem Enabled="true">Tomas Hnos</asp:ListItem> <%-- [Algoritmo]--%>
                            <asp:ListItem Enabled="True">Tecnocampo</asp:ListItem>
                            <asp:ListItem Enabled="True">Terra Verde</asp:ListItem>
                            <asp:ListItem Enabled="true">YPF</asp:ListItem>
                            <asp:ListItem Enabled="false">YPF 2</asp:ListItem>
                            <asp:ListItem Enabled="false">YPF 3</asp:ListItem>
                            <asp:ListItem Enabled="true">ZENI</asp:ListItem>
                            <%--ssasdasd
                            asdasdad
                            
                            Bit (amaggi)
                            Algoritmo (grobo, tomashnos,
                            SOLVER (argencer)
                            tecnocampo,dukarevich
                            formato 1 (zeni, syngenta
                            csv interno (bld)
                            internos (
                            --%>
                        </asp:DropDownList>
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnDescargaSincro" Text="descargar" runat="server" CssClass="butcancela"
                            Height="32" Width="100" />
                    </td>
                </tr>
                <%--       <tr>
                    <td colspan="4">
                        <hr />
                    </td>
                </tr>--%>
            </table>
            <br />
            <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                cellpadding="1" cellspacing="1">
                <tr>
                    <td class="EncabezadoCell" style="width: 100px; height: 18px;">Estado
                    </td>
                    <td class="EncabezadoCell" style="width: 222px; height: 18px;">
                        <asp:DropDownList ID="cmbEstado" runat="server" Style="text-align: right; margin-left: 0px;"
                            CssClass="CssCombo" ToolTip="Estado de la carta de porte" Font-Size="Small" Height="22px">
                            <asp:ListItem Text="Todas (menos las rechazadas)" Value="TodasMenosLasRechazadas" />
                            <asp:ListItem Text="Incompletas" Value="Incompletas" />
                            <asp:ListItem Text="Posición" Value="Posición" />
                            <asp:ListItem Text="Descargas" Value="Descargas" />
                            <asp:ListItem Text="Facturadas" Value="Facturadas" />
                            <asp:ListItem Text="No facturadas" Value="NoFacturadas" />
                            <asp:ListItem Text="Rechazadas" Value="Rechazadas" />
                            <asp:ListItem Text="sin liberar en Nota de crédito" Value="EnNotaCredito" />
                        </asp:DropDownList>
                    </td>
                    <td class="EncabezadoCell" style="width: 162px; height: 18px;">Fecha de Descarga
                    </td>
                    <td class="EncabezadoCell" style="width: 300px; height: 18px;">
                        <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px"
                            Visible="true">
                            <asp:ListItem Text="Hoy" />
                            <asp:ListItem Text="Ayer" Selected="True" />
                            <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                            <asp:ListItem Text="Este mes" />
                            <asp:ListItem Text="Mes anterior" />
                            <asp:ListItem Text="Cualquier fecha" />
                            <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                            <asp:ListItem Text="Personalizar" />
                        </asp:DropDownList>
                        <br />
                        <asp:TextBox ID="txtFechaDesde" runat="server" Width="72px" MaxLength="1" autocomplete="off"
                            TabIndex="2" AutoPostBack="false"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                            Enabled="True">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            UserDateFormat="DayMonthYear" Enabled="True">
                        </cc1:MaskedEditExtender>
                        <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                            WatermarkText="desde" WatermarkCssClass="watermarked" />
                        <asp:TextBox ID="txtFechaHasta" runat="server" Width="72px" MaxLength="1" TabIndex="2"
                            AutoPostBack="false"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta"
                            Enabled="True">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                            Enabled="True">
                        </cc1:MaskedEditExtender>
                        <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                            WatermarkText="hasta" WatermarkCssClass="watermarked" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                        ForeColor="" CausesValidation="False" Font-Size="16px" Height="20px" BorderStyle="None"
                        Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                        BorderWidth="5px" Width="127px"></asp:LinkButton>
                    <asp:Panel ID="Panel4" runat="server">
                        <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
                            cellpadding="1" cellspacing="1">
                            <tr>
                                <td class="EncabezadoCell" style="height: 18px;">Contrato
                                </td>
                                <td>
                                    <asp:TextBox ID="txtContrato" runat="server" TabIndex="13" Style="margin-left: 0px;" />
                                </td>
                                <td class="EncabezadoCell" style="width: 160px; height: 18px;">Punto venta
                                </td>
                                <td>
                                    <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="60px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Origen
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtProcedencia" runat="server" CssClass="CssTextBox" Text='<%# Bind("ProcedenciaDesc") %>'
                                        AutoPostBack="false"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender27" runat="server"
                                        CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtProcedencia" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Destino
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>' AutoPostBack="false"
                                        autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                        CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                        UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Producto
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txt_AC_Articulo" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                        autocomplete="off" CssClass="CssTextBox" AutoPostBack="false"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                        CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td class="EncabezadoCell" style="width: 90px; height: 18px;">Corredor
                                </td>
                                <td class="EncabezadoCell" style="height: 18px">
                                    <asp:TextBox ID="txtCorredor" runat="server" CssClass="CssTextBox" autocomplete="off"
                                        Text='<%# Bind("CorredorDesc") %>' AutoPostBack="false"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender24" runat="server"
                                        CompletionListCssClass="AutoCompleteScroll" CompletionSetCount="12" DelimiterCharacters=""
                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceVendedores.asmx" TargetControlID="txtCorredor" UseContextKey="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;"></td>
                                <td></td>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Destinatario
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtDestinatario" runat="server" Text='<%# Bind("EntregadorDesc") %>'
                                        AutoPostBack="false" autocomplete="off" CssClass="CssTextBox"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender25" runat="server"
                                        CompletionSetCount="12" TargetControlID="txtDestinatario" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                        Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>

                            <tr>
                                <td class="EncabezadoCell">Camion
                                </td>
                                <td>
                                    <asp:DropDownList ID="optCamionVagon" runat="server" AutoPostBack="false" CssClass="CssTextBox"
                                        Width="110px">
                                        <asp:ListItem Selected="True">Todos</asp:ListItem>
                                        <asp:ListItem>Camiones</asp:ListItem>
                                        <asp:ListItem>Vagones</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell">Modo
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="false" CssClass="CssTextBox"
                                        Width="110px">
                                        <asp:ListItem Selected="True">Entregas</asp:ListItem>
                                        <asp:ListItem>Export</asp:ListItem>
                                        <asp:ListItem>Ambos</asp:ListItem>
                                        <asp:ListItem>Buques</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell">Excepciones
                                </td>
                                <td>
                                    <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="6">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                        <asp:ListItem Text="Ambas" Selected="True" />
                                        <asp:ListItem Text="Acopio 1 ACA" Value="ACA401" />
                                        <asp:ListItem Text="Acopio 2 ACA" Value="ACA401" />
                                        <asp:ListItem Text="Acopio 3 ACA" Value="ACA402" />
                                    </asp:DropDownList>
                                </td>
                                <%--                    <td class="EncabezadoCell" style="width: 90px; height: 18px;" visible="false">
                        Filtros
                    </td>
                    <td class="EncabezadoCell" style="height: 18px" visible="false">
                        <asp:RadioButtonList ID="CriterioWHERE" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">todos</asp:ListItem>
                            <asp:ListItem>alguno</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>--%>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Vagón
                                </td>
                                <td class="EncabezadoCell" style="height: 18px;">
                                    <asp:TextBox runat="server" ID="txtVagon" CssClass="CssTextBox" />
                                </td>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Patente
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPatente" CssClass="CssTextBox" />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                                    <asp:Label runat="server" ID="lblTopClientes" Text="Top clientes" />
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtTopClientes" runat="server" TabIndex="13" Style="margin-left: 0px;"
                                        autocomplete="off" CssClass="CssTextBox" AutoPostBack="false"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="height: 18px;">
                                    <asp:Label runat="server" ID="lblMinimoNeto" Text="Minimo neto" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMinimoNeto" runat="server" TabIndex="13" Style="margin-left: 0px;" />
                                </td>
                            </tr>
                            <tr style="border-top: 1px; margin-top: 5px;">
                                <td colspan="2">
                                    <asp:DropDownList ID="cmbCriterioWHERE" runat="server" ToolTip="" Height="21px" Style="visibility: visible; overflow: auto;"
                                        CssClass="CssCombo" TabIndex="6">
                                        <asp:ListItem Text="y TODOS estos" Value="todos" />
                                        <asp:ListItem Text="y ALGUNO de estos" Value="alguno" Selected="True" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 18px;">Titular
                                </td>
                                <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                                    <asp:TextBox ID="txtTitular" runat="server" CssClass="CssTextBox" Text='<%# Bind("VendedorDesc") %>'
                                        autocomplete="off" AutoPostBack="false"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                        CompletionSetCount="12" TargetControlID="txtTitular" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" UseContextKey="True"
                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                        Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td class="EncabezadoCell" style="width: 90px">Intermed.
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtIntermediario" runat="server" autocomplete="off" Text='<%# Bind("IntermediarioDesc") %>'
                                        CssClass="CssTextBox" AutoPostBack="false" TabIndex="7"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                        TargetControlID="txtIntermediario" UseContextKey="True" FirstRowSelected="True"
                                        CompletionListCssClass="AutoCompleteScroll" CompletionInterval="100" DelimiterCharacters=""
                                        Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 90px">R. Comercial
                                </td>
                                <td class="EncabezadoCell" style="width: 220px">
                                    <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" AutoPostBack="false"
                                        Text='<%# Bind("RComercialDesc") %>' CssClass="CssTextBox" TabIndex="8"></asp:TextBox><cc1:AutoCompleteExtender
                                            ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx" TargetControlID="txtRcomercial"
                                            UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                </td>


                                <td class="EncabezadoCell" style="width: 90px">Cliente Obs.
                                </td>
                                <td class="EncabezadoCell">



                                    <asp:TextBox ID="txtPopClienteAuxiliar" runat="server" CssClass="CssTextBox" autocomplete="off"
                                        Width="" TabIndex="20"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender11" runat="server"
                                        CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceClientes.asmx" TargetControlID="txtPopClienteAuxiliar"
                                        UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>

                                </td>
                            </tr>
                            <tr>
                                <td style="width: 101px">
                                    <asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="false" Font-Underline="True"
                                        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False"
                                        ToolTip="Descarga el ReportBuilder3">Editar informe</asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="false" Font-Underline="True"
                                        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton6" runat="server" Font-Bold="false" Font-Underline="True"
                                        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False"
                                        ToolTip="Descarga el ReportBuilder3" PostBackUrl="http://www.microsoft.com/downloads/details.aspx?displaylang=es&amp;FamilyID=9f783224-9871-4eea-b1d5-f3140a253db6">Descargar ReportBuilder2</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 190px">Omitir errores?</td>
                                <td class="EncabezadoCell">
                                    <asp:CheckBox runat="server" ID="chkOmitirErrores" value="false" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                        TargetControlID="Panel4" ExpandControlID="btnMasPanel" CollapseControlID="btnMasPanel"
                        CollapsedText="más filtros..." ExpandedText="ocultar" TextLabelID="btnMasPanel"
                        Collapsed="false">
                    </ajaxToolkit:CollapsiblePanelExtender>
                </ContentTemplate>
            </asp:UpdatePanel>
            <%--Problemas que me hacen acordar a crystal
                    http://forums.asp.net/p/1426336/3211939.aspx
                    http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/8287e1cd-767e-463c-8cb0-60c275fe5ed6

                    Creo que en el VS2008, el ReportViewer10 no se muestra bien en la vista diseño


                    http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/e609a329-58cd-4f30-b8d6-a912657d8eba
                    The reports that are created with ReportBuilder 3.0 use the RDL 2010 schema but the 
                    ReportViewer in local mode can only process/render reports that use the 2005 or 2008 schema. 
                    If you publish the 2010 report to a report server and use the ReportViewer in remote mode 
                    you can render the 2010 RDL Report.

            --%>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: ">
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
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Label ID="lblErrores" CssClass="Alerta" runat="server" Font-Size="12pt" Enabled="false"></asp:Label>
            <div style="background-color: #FFFFFF; width: ">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="100%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True">
                    <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                    --%>
                </rsweb:ReportViewer>
                <span>
                    <%--<div>--%>
                    <%--botones de alta y excel--%>
                    <%--</div>--%>
                </span>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
