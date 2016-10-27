<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Proveedor, App_Web_bvot1ars" title="Untitled Page" theme="Azul" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
    function OnChanged(sender, args)
    {
    sender.get_clientStateField().value = sender.saveClientState();
    }
    </script>

    <cc1:TabContainer ID="TabContainer1" runat="server" 
        OnClientActiveTabChanged="OnChanged" ActiveTabIndex="2" Height="450px" 
        BackColor="#6699FF" Width="584px" CssClass="NewsTab">
        <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="TabPanel1">
            <ContentTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Width="40px"></asp:TextBox>
                <br />
                <div style="text-align: left">
                    <table>
                        <tr>
                            <td style="width: 131px">
                                Codigo :</td>
                            <td style="width: 157px">
                                <asp:TextBox ID="txtCodigoEmpresa" runat="server" Width="96px"></asp:TextBox></td>
                            <td style="width: 100px">
                                </td>
                            <td style="width: 156px">
                                </td>
                        </tr>
                        <tr>
                            <td style="width: 131px; height: 21px">
                                Razon social :</td>
                            <td colspan="3" style="height: 21px">
                                <asp:TextBox ID="txtRazonSocial" runat="server" Width="408px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px; height: 21px">
                                Nombre comercial :</td>
                            <td colspan="3" style="height: 21px">
                                <asp:TextBox ID="txtNombreFantasia" runat="server" Width="408px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px; height: 21px">
                                Direccion :
                            </td>
                            <td colspan="3" style="height: 21px">
                                <asp:TextBox ID="txtDireccion" runat="server" Width="408px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Localidad :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbLocalidad" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                                Codigo postal :</td>
                            <td style="width: 156px">
                                <asp:TextBox ID="txtCodigoPostal" runat="server" Width="96px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Provincia :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbProvincia" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                                Pais :
                            </td>
                            <td style="width: 156px"><asp:DropDownList ID="cmbPais" runat="server" Width="152px">
                            </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Condicion IVA :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbCondicionIVA" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                                CUIT :</td>
                            <td style="width: 156px">
                                <asp:TextBox ID="txtCUIT" runat="server" Width="96px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Cond.Compra Std. :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbCondicionCompra" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 156px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Cuenta contable :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbCuentaContable" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                                Moneda Std. :</td>
                            <td style="width: 156px">
                                <asp:DropDownList ID="cmbMoneda" runat="server" Width="152px">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Telefono(s) :
                            </td>
                            <td style="width: 157px">
                                <asp:TextBox ID="txtTelefono1" runat="server" Width="144px"></asp:TextBox></td>
                            <td style="width: 100px">
                                Fax :</td>
                            <td style="width: 156px">
                                <asp:TextBox ID="txtFax" runat="server" Width="144px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Email :
                            </td>
                            <td style="width: 157px">
                                <asp:TextBox ID="txtEmail" runat="server" Width="144px"></asp:TextBox></td>
                            <td style="width: 100px">
                                Pagina Web :</td>
                            <td style="width: 156px">
                                <asp:TextBox ID="txtPaginaWeb" runat="server" Width="144px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                Estado actual :</td>
                            <td style="width: 157px">
                                <asp:DropDownList ID="cmbEstadoActual" runat="server" Width="152px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                                Actividad ppal.:</td>
                            <td style="width: 156px">
                                <asp:DropDownList ID="cmbActividad" runat="server" Width="152px">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td style="width: 131px; height: 47px;">
                                Provee :</td>
                            <td style="width: 157px; height: 47px;">
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                    TextAlign="Left">
                                    <asp:ListItem Value="B">Bienes</asp:ListItem>
                                    <asp:ListItem Value="S">Servicios</asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td style="width: 100px; height: 47px;">
                                Calificacion :</td>
                            <td style="width: 156px; height: 47px;">
                                <asp:TextBox ID="txtCalificacion" runat="server" Width="24px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 131px">
                                </td>
                            <td colspan="3">
                                &nbsp;</td>
                        </tr>
                    </table>
                </div>
                <br />
                &nbsp;&nbsp;
            </ContentTemplate>
            <HeaderTemplate>
                Datos generales 1
            </HeaderTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="TabPanel2">
            <HeaderTemplate>
                Datos generales 2
            </HeaderTemplate>
            <ContentTemplate>
                <div style="text-align: left">
                    <table>
                        <tr>
                            <td colspan="2">
                                Informacion auxiliar :</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtInformacionAuxiliar" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                Cheques a la orden :</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtChequesALaOrdenDe" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" style="height: 49px">
                                Observaciones :</td>
                            <td colspan="2" style="height: 49px">
                                <asp:TextBox ID="txtObservaciones" runat="server" Height="50px" TextMode="MultiLine"
                                    Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4" style="background-color: #ffffcc">
                                <strong><span style="background-color: #ffffcc">Datos para importaciones</span></strong></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                Numero inscripcion :</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtImportaciones_NumeroInscripcion" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                Denominacion inscrip. :</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtImportaciones_DenominacionInscripcion" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="4" style="font-weight: bold; background-color: #ffffcc">
                                Datos adicionales</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                Datos adicionales 1</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtNombre1" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                Datos adicionales 2</td>
                            <td colspan="2">
                                <asp:TextBox ID="txtNombre2" runat="server" Width="408px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: #ffffcc; text-align: center;" colspan="4">
                                <strong>Documentacion adicional</strong></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 42px">
                                Fecha de ult. presentacion de doc. :</td>
                            <td style="width: 253px; height: 42px;">
                                <asp:TextBox ID="txtFechaUltimaPresentacionDocumentacion" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                <cc1:CalendarExtender ID="CalendarExtender6" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtFechaUltimaPresentacionDocumentacion">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender6" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaUltimaPresentacionDocumentacion">
                                </cc1:MaskedEditExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 48px">
                                Observaciones de la presentcion :</td>
                            <td style="width: 253px; height: 48px;">
                                <asp:TextBox ID="txtObservacionesPresentacionDocumentacion" runat="server" Height="50px" TextMode="MultiLine" Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 62px">
                            </td>
                            <td style="width: 151px">
                            </td>
                            <td style="width: 253px">
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
            <HeaderTemplate>
                IIBB
            </HeaderTemplate>
            <ContentTemplate>
                <table>
                    <tr>
                        <td colspan="4">
                            <asp:RadioButtonList ID="RadioButtonList3" runat="server" RepeatDirection="Horizontal"
                                    TextAlign="Left" AutoPostBack="True">
                                <asp:ListItem Value="1">Exento</asp:ListItem>
                                <asp:ListItem Value="3">Inscripto</asp:ListItem>
                                <asp:ListItem Value="2">Inscripto Conv.Mult.</asp:ListItem>
                                <asp:ListItem Value="4">No alcanzado</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 516px">
                            Fecha limite para cond. exento :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtFechaLimiteExentoIIBB" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtFechaLimiteExentoIIBB">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaLimiteExentoIIBB">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 516px">
                            Numero de inscripcion :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtIBNumeroInscripcion" runat="server" MaxLength="1" Width="152px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 516px">
                            Categoria standar :</td>
                        <td colspan="2">
                            <asp:DropDownList ID="cmbCategoriaIIBB" runat="server" Width="264px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 516px">
                            Coeficiente unificado (% opcional) :</td>
                        <td style="width: 102px">
                            <asp:TextBox ID="txtCoeficienteIIBBUnificado" runat="server" MaxLength="1" Width="40px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 516px">
                            Detalle de retenciones p/conv. mult. :</td>
                        <td colspan="2">
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="center" bgcolor="#ffffcc" colspan="3" style="height: 21px">
                            <strong>Embargos</strong></td>
                    </tr>
                    <tr>
                        <td style="width: 231px">
                            <asp:CheckBox ID="CheckBox1" runat="server" Text="Sujeto embargado :" TextAlign="Left" />
                        </td>
                        <td style="width: 146px">
                            Saldo embargo :</td>
                        <td style="width: 188px">
                            <asp:TextBox ID="txtSaldoEmbargo" runat="server" MaxLength="1" Width="112px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 231px">
                            Detalle embargo :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtDetalleEmbargo" runat="server" MaxLength="1" Width="256px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="center" bgcolor="#ffffcc" colspan="4">
                            <strong>Aplicacion porcentual directa</strong></td>
                    </tr>
                    <tr>
                        <td style="width: 129px">
                            Porcentaje :</td>
                        <td style="width: 100px">
                            <asp:TextBox ID="txtPorcentajeIBDirecto" runat="server" MaxLength="1" Width="40px"></asp:TextBox>
                        </td>
                        <td style="width: 144px">
                            Grupo :</td>
                        <td style="width: 186px">
                            <asp:TextBox ID="txtGrupoIIBB" runat="server" MaxLength="1" Width="40px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Fecha inic.vigencia :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtFechaInicioVigenciaIBDirecto" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtFechaInicioVigenciaIBDirecto">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaInicioVigenciaIBDirecto">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Fecha fin vigencia :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtFechaFinVigenciaIBDirecto" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtFechaFinVigenciaIBDirecto">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaFinVigenciaIBDirecto">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel5" runat="server" HeaderText="TabPanel5">
            <ContentTemplate>
                    <table>
                        <tr>
                            <td colspan="4"><asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Horizontal"
                                    TextAlign="Left" AutoPostBack="True">
                                <asp:ListItem Value="1">Exento</asp:ListItem>
                                <asp:ListItem Value="2">Inscripto</asp:ListItem>
                            </asp:RadioButtonList>&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 234px; height: 24px">
                                Categoria standar :</td>
                            <td style="height: 24px" colspan="3"><asp:DropDownList ID="cmbCategoriaGanancias" runat="server" Width="296px">
                            </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 234px; height: 67px;">
                                Fecha limite para condicion exento :</td>
                            <td style="height: 67px;" colspan="3">
                                <asp:TextBox ID="txtFechaLimiteExentoGanancias" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                                &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtFechaLimiteExentoGanancias">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaLimiteExentoGanancias">
                                </cc1:MaskedEditExtender>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 234px">
                            </td>
                            <td style="width: 92px">
                            </td>
                            <td style="width: 105px">
                            </td>
                            <td style="width: 103px">
                            </td>
                        </tr>
                    </table>
            </ContentTemplate>
            <HeaderTemplate>
                Ganancias
            </HeaderTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel6" runat="server" HeaderText="TabPanel6">
            <ContentTemplate>
                <table>
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="CheckBox2" runat="server" Text="Exceptuado 100%" TextAlign="Left" AutoPostBack="True" />
                        </td>
                        <td style="width: 114px">
                        </td>
                        <td style="width: 222px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            % de excepcion :</td>
                        <td style="width: 114px">
                            <asp:TextBox ID="txtIvaPorcentajeExencion" runat="server" Width="40px"></asp:TextBox>
                        </td>
                        <td style="width: 222px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Fecha vencimiento excepcion :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtIvaFechaCaducidadExencion" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender5" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtIvaFechaCaducidadExencion">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtIvaFechaCaducidadExencion">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Cod.situacion retencion IVA :</td>
                        <td style="width: 114px">
                            <asp:TextBox ID="txtCodigoSituacionRetencionIVA" runat="server" Width="16px"></asp:TextBox>
                        </td>
                        <td style="width: 222px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 114px">
                        </td>
                        <td style="width: 222px">
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <HeaderTemplate>
                IVA
            </HeaderTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel4" runat="server" HeaderText="TabPanel4">
            <HeaderTemplate>
                SUSS
            </HeaderTemplate>
            <ContentTemplate>
                <table>
                    <tr>
                        <td colspan="4">
                            <asp:RadioButtonList ID="RadioButtonList4" runat="server" RepeatDirection="Horizontal"
                                    TextAlign="Left" AutoPostBack="True">
                                <asp:ListItem Value="EX">Exento</asp:ListItem>
                                <asp:ListItem Value="SI">Alcanzado</asp:ListItem>
                                <asp:ListItem Value="NO">No alcanzado</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Fecha limite para cond. exento :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtSUSSFechaCaducidadExencion" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender7" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                    TargetControlID="txtSUSSFechaCaducidadExencion">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender7" runat="server" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtSUSSFechaCaducidadExencion">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 21px" colspan="2">
                            Categoria standar :</td>
                        <td style="height: 21px" colspan="2"><asp:DropDownList ID="cmbCategoriaSUSS" runat="server" Width="264px">
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 254px">
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel8" runat="server" HeaderText="TabPanel8">
            <HeaderTemplate>
                Contactos
            </HeaderTemplate>
            <ContentTemplate>
                <table>
                    <tr>
                        <td colspan="2">
                            Contacto principal :</td>
                        <td colspan="2">
                            <asp:TextBox ID="txtContactoPrincipal" runat="server" Width="408px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 22px" colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AutoGenerateColumns="False">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="Id" />
                                    <asp:BoundField DataField="Contacto" HeaderText="Contacto" >
                                        <ItemStyle Wrap="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Puesto" HeaderText="Puesto" >
                                        <ItemStyle Wrap="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Telefono" HeaderText="Telefono" >
                                        <ItemStyle Wrap="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Email" HeaderText="Email" >
                                        <ItemStyle Wrap="True" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Elim.">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Eliminado") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            &nbsp;<asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Eliminado") %>'
                                                Enabled="False" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:ButtonField ButtonType="Button" CommandName="Eliminar"
                                        Text="Eliminar" >
                                        <ControlStyle Font-Size="XX-Small" />
                                        <ItemStyle Font-Size="XX-Small" />
                                    </asp:ButtonField>
                                    <asp:ButtonField ButtonType="Button" CommandName="Editar" Text="Editar">
                                        <ControlStyle Font-Size="XX-Small" />
                                        <ItemStyle Font-Size="XX-Small" />
                                    </asp:ButtonField>
                                </Columns>
                            </asp:GridView>
                            <asp:Button ID="btnNuevoItem" runat="server" Font-Size="XX-Small" Text="Nuevo item"
                                UseSubmitBehavior="False" /><br />
                            <table>
                                <tr>
                                    <td style="width: 100px">
                                        <asp:Label ID="lblContacto" runat="server" Text="Contacto :"></asp:Label></td>
                                    <td style="width: 401px">
                                        <asp:TextBox ID="txtContacto" runat="server" Width="384px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        <asp:Label ID="lblPuesto" runat="server" Text="Puesto :"></asp:Label></td>
                                    <td style="width: 401px">
                                        <asp:TextBox ID="txtContactoPuesto" runat="server" Width="384px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 26px">
                                        <asp:Label ID="lblTelefono" runat="server" Text="Telefono :"></asp:Label></td>
                                    <td style="width: 401px; height: 26px">
                                        <asp:TextBox ID="txtContactoTelefono" runat="server" Width="384px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email :"></asp:Label></td>
                                    <td style="width: 401px">
                                        <asp:TextBox ID="txtContactoEmail" runat="server" Width="384px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnSaveItem" runat="server" Font-Size="XX-Small" OnClick="btnSave_Click"
                                            Text="Guardar item" UseSubmitBehavior="False" /><asp:Button ID="btnCancelItem" runat="server"
                                                CausesValidation="False" Font-Size="XX-Small" OnClick="btnCancel_Click" Text="Cancelar"
                                                UseSubmitBehavior="False" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 59px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 297px">
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </cc1:TabPanel>
    </cc1:TabContainer>
    
    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Grabar" UseSubmitBehavior="False" cssclass="but"/><asp:Button
                    ID="btnCancel" runat="server" CausesValidation="False" OnClick="btnCancel_Click"
                    Text="Cancelar" UseSubmitBehavior="False"  cssclass="but"/><br />
</asp:Content>

