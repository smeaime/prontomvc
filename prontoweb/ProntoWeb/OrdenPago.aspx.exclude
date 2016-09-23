<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="OrdenPago.aspx.vb" Inherits="OrdenPagoABM" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">

        //       http: //stackoverflow.com/questions/4494552/change-enter-from-submission-to-tab

        $(document).ready(function() {
            var focusables = $(":input").not('[type="image"]').not('[type="submit"]');

            focusables.keydown(function(e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    var current = focusables.index(this),
              next = focusables.eq(current + 1).length ? focusables.eq(current + 1) : focusables.eq(0);
                    next.focus();
                }
            });
        });
    
    
    </script>

    <div style="border: thin solid #FFFFFF; width: 850px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
            <ContentTemplate>
                <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="2" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                            font-size: large;" align="left" valign="top">
                            ORDEN DE PAGO
                        </td>
                        <td valign="top">
                            <%--BackColor="#4A3C8C"--%>
                            <asp:Label ID="lblLetra" runat="server" BackColor="" BorderColor="White" BorderStyle="Solid"
                                BorderWidth="1px" Font-Bold="True" Font-Size="X-Large" ForeColor="White" Style="text-align: center;
                                margin-left: 0px; vertical-align: top" Text="A" Visible="false" Width="34px"></asp:Label>
                        </td>
                        <td style="height: 37px;" valign="top" align="right">
                            <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="White"
                                BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                                Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                                Visible="False" Width="120px"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" alt="" />
                                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                        Visible="False"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 15%;">
                            Tipo
                        </td>
                        <td class="EncabezadoCell" style="width: 35%;">
                            <asp:RadioButtonList ID="RadioButtonListEsInterna" ForeColor="White" runat="server"
                                Style="margin-left: 0px" AutoPostBack="True" RepeatDirection="Horizontal" Font-Size="X-Small">
                                <asp:ListItem Value="1" Selected="True">Proveedor</asp:ListItem>
                                <asp:ListItem Value="2">Otros</asp:ListItem>
                                <asp:ListItem Value="3">F. fijo</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 15%;">
                            Número
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtLetra" runat="server" Width="15px" MaxLength="1" Enabled="False"
                                Visible="False"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtLetra"
                                Mask="L" MaskType="None" AutoComplete="False">
                            </cc1:MaskedEditExtender>
                            <cc1:ComboBox RenderMode="Block" ID="cmbPuntoVenta" Visible="false" runat="server"
                                Width="54px" Height="22px" AutoPostBack="True">
                            </cc1:ComboBox>
                            <asp:TextBox ID="txtNumeroOrdenPago2" runat="server" Width="70px" Style="text-align: right;"
                                AutoPostBack="True" Enabled="true"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="txtNumeroOrdenPago2_MaskedEditExtender" runat="server"
                                TargetControlID="txtNumeroOrdenPago2" Mask="99999999" MaskType="Number" InputDirection="RightToLeft"
                                AutoCompleteValue="0">
                            </cc1:MaskedEditExtender>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                    ControlToValidate="txtNumeroOrdenPago1" 
                    ErrorMessage="*Número" Font-Size="Small" ForeColor="#FF3300" 
                    Font-Bold="True" ValidationGroup="Encabezado" style="display:none"></asp:RequiredFieldValidator>
                                                    
                                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender4"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator15"/>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNumeroOrdenPago2"
                                ErrorMessage="* Número" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                ValidationGroup="Encabezado" Style="display: none" />
                            <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator9" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell">
                            Exterior
                        </td>
                        <td style="" class="EncabezadoCell">
                            <asp:CheckBox runat="server" ID="chkExterior" AutoPostBack="true" />
                            <asp:CheckBox runat="server" ID="chkCalcularDiferenciaCambio" AutoPostBack="true"
                                Visible="false" /><br />
                        </td>
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 15%;">
                            Ingreso
                        </td>
                        <td style="" class="EncabezadoCell">
                            <asp:TextBox ID="txtFechaIngreso" runat="server" Width="70px" MaxLength="1" Style="margin-left: 0px"></asp:TextBox>&nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaIngreso">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtFechaIngreso">
                            </cc1:MaskedEditExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtFechaIngreso"
                                ErrorMessage="* Ingrese la fecha de ingreso" Font-Size="Small" ForeColor="#FF3300"
                                Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                            <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator5" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="PanelEncabezadoCliente" runat="server" Width="100%">
                    <table style="width: 100%; padding: 0px; border: none #FFFFFF; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" style="width: 15%;">
                                Proveedor
                            </td>
                            <td class="EncabezadoCell" style="width: 35%;">
                                <asp:TextBox ID="txtAutocompleteProveedor" runat="server" autocomplete="off" CssClass="CssTextBox"
                                    AutoPostBack="True"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceProveedores.asmx"
                                    TargetControlID="txtAutocompleteProveedor" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtAutocompleteProveedor"
                                    ErrorMessage="* Ingrese un proveedor" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                        ID="ValidatorCalloutExtender13" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator15"
                                        CssClass="CustomValidatorCalloutStyle" />
                            </td>
                            <td class="EncabezadoCell" style="width: 15%;" visible="false">
                            </td>
                            <td class="EncabezadoCell" style="" visible="false">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="PanelEncabezadoCuenta" runat="server" Width="100%">
                    <table style="width: 100%; padding: 0px; border: none #FFFFFF; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" style="width: 15%;">
                                Cuenta
                            </td>
                            <td class="EncabezadoCell" style="width: 35%;">
                                <asp:TextBox ID="txtAutocompleteCuenta" runat="server" autocomplete="off" CssClass="CssTextBox"
                                    AutoPostBack="True"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceCuentas.asmx"
                                    TargetControlID="txtAutocompleteCuenta" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAutocompleteCuenta"
                                    ErrorMessage="* Ingrese una cuenta" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    ValidationGroup="Encabezado" Style="display: none" />
                                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                                    Enabled="True" TargetControlID="RequiredFieldValidator2" CssClass="CustomValidatorCalloutStyle" />
                            </td>
                            <td class="EncabezadoCell" style="width: 15%;" visible="">
                            </td>
                            <td class="EncabezadoCell" style="" visible="">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Panel ID="PanelEncabezadoFondoFijo" runat="server" Width="100%">
                                    <table style="width: 100%; padding: 0px; border: none #FFFFFF; margin-right: 0px;"
                                        cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 15%;">
                                                N° Rendicion
                                            </td>
                                            <td class="EncabezadoCell" style="width: 35%;">
                                                <asp:TextBox ID="txtNumeroRendicionFondoFijo" runat="server" />
                                            </td>
                                            <td class="EncabezadoCell" style="width: 15%;">
                                                <%--Destinatario--%>
                                                Es Inicial?
                                            </td>
                                            <td class="EncabezadoCell">
                                                <asp:CheckBox ID="chkInicialFondoFijo" runat="server" />
                                                <cc1:ComboBox RenderMode="Block" ID="cmbDestinatarioFondoFijo" runat="server" AutoPostBack="False"
                                                    DropDownStyle="DropDownList" AutoCompleteMode="SuggestAppend" CaseSensitive="False"
                                                    ItemInsertLocation="Append" CssClass="CssCombo" Visible="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr style="visibility: hidden; display: none;">
                        <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                        <td class="EncabezadoCell" style="width: 15%; height: 18px;">
                        </td>
                        <td class="EncabezadoCell" style="width: 200px; height: 18px;">
                        </td>
                        <%--style="visibility:hidden;"/>--%>
                        <td class="EncabezadoCell" style="width: 15%; height: 18px;">
                            Vendedor
                        </td>
                        <td class="EncabezadoCell" style="height: 18px">
                            <cc1:ComboBox RenderMode="Block" ID="cmbVendedor" runat="server" CssClass="CssCombo">
                            </cc1:ComboBox>
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%; padding: 0px; border: none #FFFFFF; margin-right: 0px;"
                            cellpadding="3" cellspacing="3">
                            <tr style="visibility: hidden; display: none">
                                <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                    CUIT
                                </td>
                                <td class="EncabezadoCell" style="width: 35%; height: 10px;">
                                    <asp:TextBox ID="txtCUIT" runat="server" CssClass="CssTextBox" Enabled="False"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                                        ErrorTooltipEnabled="True" Mask="99\-99999999\-9" MaskType="Number" TargetControlID="txtCUIT">
                                    </cc1:MaskedEditExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCUIT"
                                        ErrorMessage="* Ingrese CUIT" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" Enabled="False" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator6" />
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                    Condición
                                </td>
                                <td class="EncabezadoCell" style="height: 4px;">
                                    <cc1:ComboBox RenderMode="Block" ID="cmbCondicionIVA" runat="server" CssClass="CssCombo"
                                        Enabled="False" Height="22px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="cmbCondicionIVA"
                                        ErrorMessage="* Ingrese una condicion" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none"
                                        Enabled="False" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender9" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator10" />
                                </td>
                            </tr>
                            <tr style="visibility: hidden; display: none">
                                <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                    Lista de precios
                                </td>
                                <td class="EncabezadoCell" style="width: 35%; height: 10px;">
                                    <cc1:ComboBox RenderMode="Block" ID="cmbListaPrecios" runat="server" CssClass="CssCombo" />
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                    Vencimiento
                                </td>
                                <td class="EncabezadoCell" style="height: 4px;">
                                    <asp:TextBox ID="txtFechaVencimiento" runat="server" Width="110px" MaxLength="1"
                                        Style="margin-left: 0px"></asp:TextBox>&nbsp;&nbsp;
                                    <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaVencimiento">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtFechaVencimiento">
                                    </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                    Obra
                                </td>
                                <td class="EncabezadoCell" style="width: 35%; height: 10px;">
                                    <%--<cc1:ComboBox RenderMode="Block" ID="cmbObra" runat="server" CssClass="CssCombo" />--%>
                                    <cc1:ComboBox RenderMode="Block" ID="cmbObra" runat="server" AutoPostBack="False"
                                        DropDownStyle="DropDownList" AutoCompleteMode="SuggestAppend" CaseSensitive="False"
                                        ItemInsertLocation="Append" CssClass="WindowsStyle" />
                                </td>
                                <td class="EncabezadoCell" style="width: 15%;">
                                    Moneda
                                </td>
                                <td style="" class="EncabezadoCell" style="">
                                    <cc1:ComboBox RenderMode="Block" ID="cmbMoneda" runat="server" CssClass="CssCombo" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="cmbMoneda"
                                        ErrorMessage="* Ingrese una moneda" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        InitialValue="-1" ValidationGroup="Encabezado" Style="display: none" Enabled="False" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender10" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator11" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <asp:UpdatePanel ID="UpdatePanelEncabezadoExtension" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                            ForeColor="White" CausesValidation="False" Font-Size="X-Small" Height="20px"
                            BorderStyle="None" Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px;
                            margin-left: 5px;" BorderWidth="5px" Width="100%"></asp:LinkButton>
                        <asp:Panel ID="Panel4" runat="server" Width="100%">
                            <table style="padding: 0px; border: none #FFFFFF; width: 100%; height: 86px; margin-right: 0px;"
                                cellpadding="3" cellspacing="3">
                                <tr>
                                    <td class="EncabezadoCell" style="width: 15%;">
                                        Observ.
                                    </td>
                                    <td class="EncabezadoCell" style="width: 35%;">
                                        <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Width="180px"
                                            CssClass="CssTextBox" Height="52px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" colspan="2" style="font-size: x-small" class="EncabezadoCell">
                                        <asp:UpdatePanel ID="UpdatePanelRubros" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div style="overflow: auto;">
                                                    <asp:GridView ID="gvRubrosContables" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                        BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                                                        Width="300px" class="DetalleGrilla" CellPadding="3" EmptyDataText="sdfgsdfgsdfgs"
                                                        FooterStyle-CssClass="FooterStyle">
                                                        <FooterStyle />
                                                        <Columns>
                                                            <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                                                            <asp:BoundField DataField="DescripcionRubroContable" HeaderText="Rubro contable"
                                                                HeaderStyle-HorizontalAlign="Left" />
                                                            <asp:BoundField DataField="ImporteTotalItem" HeaderText="Importe" />
                                                            <asp:ButtonField ButtonType="Image" CommandName="Eliminar" Text="X" ItemStyle-HorizontalAlign="Right"
                                                                HeaderText="" ImageUrl="../Imagenes/borrar.png" HeaderStyle-Font-Size="X-Small"
                                                                Visible="true">
                                                                <ControlStyle Font-Size="Small" />
                                                                <ItemStyle Font-Size="Small" />
                                                                <HeaderStyle Width="20px" />
                                                            </asp:ButtonField>
                                                            <asp:ButtonField ButtonType="Image" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Right"
                                                                ImageUrl="../Imagenes/editar.png" CausesValidation="true" ValidationGroup="Encabezado"
                                                                HeaderText="" Visible="true">
                                                                <ControlStyle Font-Size="Small" Font-Underline="True" />
                                                                <ItemStyle Font-Size="X-Small" />
                                                                <HeaderStyle Width="20px" />
                                                            </asp:ButtonField>
                                                        </Columns>
                                                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                        <AlternatingRowStyle BackColor="#F7F7F7" />
                                                    </asp:GridView>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdatePanel ID="UpdatePanel17" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <%--boton de agregar--%>
                                                <asp:LinkButton ID="LinkButtonRubro" runat="server" Font-Bold="False" ForeColor="White"
                                                    Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                                                    BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                                                    Font-Underline="False" Enabled="true">
                                                    <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                                        text-decoration: none;" width="16" height="16" />
                                                    <asp:Label ID="Label12" runat="server" ForeColor="White" Text="Agregar rubro" Font-Underline="True"> </asp:Label>
                                                </asp:LinkButton>
                                                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                                                <asp:Button ID="Button13" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                                                    display: none" />
                                                <%--style="visibility:hidden;"/>--%>
                                                <%----------------------------------------------%>
                                                <asp:Panel ID="PanelRubro" runat="server" Width="636px" CssClass="modalPopup">
                                                    <asp:UpdatePanel ID="UpdatePanel18" runat="server">
                                                        <ContentTemplate>
                                                            <table style="height: 97px; width: 632px; color: #FFFFFF;">
                                                                <%----fecha               ----%>
                                                                <tr style="visibility: hidden; display: none">
                                                                    <td style="width: 100px">
                                                                        <asp:Label ID="Label13" runat="server" ForeColor="White" Text="Fecha de Entrega"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="TextBox10" runat="server" Width="72px" Enabled="False"></asp:TextBox>
                                                                        <%--                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                                        TargetControlID="txtDetFechaEntrega">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtDetFechaEntrega">
                                    </cc1:MaskedEditExtender>--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100px; height: 16px;">
                                                                        Rubro
                                                                    </td>
                                                                    <td style="height: 16px;">
                                                                        <asp:DropDownList ID="cmbDetRubroRubro" runat="server" Width="400px" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100px; height: 16px;">
                                                                        Importe
                                                                    </td>
                                                                    <td style="height: 16px;">
                                                                        <asp:TextBox ID="txtDetRubroImporte" runat="server" Width="72px" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <table style="width: 632px;">
                                                        <tr>
                                                            <td style="width: 100px; height: 46px;">
                                                            </td>
                                                            <td align="right" style="height: 46px">
                                                                <asp:Button ID="btnSaveItemRubro" runat="server" Font-Size="Small" Text="Aceptar"
                                                                    CausesValidation="False" CssClass="but" UseSubmitBehavior="False" Width="82px"
                                                                    Height="25px" ValidationGroup="" />
                                                                <asp:Button ID="Button15" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                                                    UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                                                    Height="25px" CausesValidation="False" Width="78px" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                                                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderRubro" runat="server" TargetControlID="Button13"
                                                    PopupControlID="PanelRubro" CancelControlID="Button15" DropShadow="False" BackgroundCssClass="modalBackground" />
                                                <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="visibility: hidden; display: none">
                                    <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                        Direccion
                                    </td>
                                    <td class="EncabezadoCell" style="width: 35%; height: 10px;">
                                        <asp:TextBox ID="TextBox7" runat="server" Width="180px" Enabled="False"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 15%; height: 10px;">
                                        Telefono
                                    </td>
                                    <td class="EncabezadoCell" style="height: 4px;">
                                        <asp:TextBox ID="txtCUIT0" runat="server" CssClass="CssTextBox" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="visibility: hidden; display: none">
                                    <td class="EncabezadoCell" style="width: 15%;">
                                    </td>
                                    <td class="EncabezadoCell" style="width: 35%;">
                                    </td>
                                    <%--boton de agregar--%>
                                    <td class="EncabezadoCell" style="width: 15%;">
                                        Cat. IIBB 1
                                    </td>
                                    <td style="" class="EncabezadoCell">
                                        <cc1:ComboBox RenderMode="Block" ID="cmbCategoriaIIBB1" runat="server" CssClass="CssCombo" />
                                    </td>
                                </tr>
                                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                                <%----------------------------------------------%>
                                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                            </table>
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                            TargetControlID="Panel4" ExpandControlID="btnMasPanel" CollapseControlID="btnMasPanel"
                            CollapsedText="más..." ExpandedText="ocultar" TextLabelID="btnMasPanel" Collapsed="True">
                        </ajaxToolkit:CollapsiblePanelExtender>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <%--        hay problemas con el panel de adjuntos. Si lo habilitas, los popups de consulta desaparecen en el postback
hay problemas con el panel de adjuntos. Si lo habilitas, los popups de consulta desaparecen en el postback
--%>
        <asp:Panel ID="panelAdjunto" runat="server" Enabled="False" Visible="False">
            <%--hay problemas con el panel de adjuntos. Si lo habilitas, los popups de consulta desaparecen en el postback
hay problemas con el panel de adjuntos. Si lo habilitas, los popups de consulta desaparecen en el postback--%>

            <script type="text/javascript">

                //    http: //forums.asp.net/t/1048832.aspx

                function BrowseFile() {
                    var fileUpload = document.getElementById("<%=FileUpLoad2.ClientID %>");

                    var btnUpload = document.getElementById("<%=btnAdjuntoSubir.ClientID %>"); //linea mia

                    fileUpload.click();

                    var filePath = fileUpload.value;

                    btnUpload.click();  //linea mia

                    /*
                    // esto lo usa para grabar una lista de archivos
        
        var filePath = fileUpload.value;

        var j = listBox.options.length;
                    listBox.options[j] = new Option();
                    listBox.options[j].text = filePath.substr(filePath.lastIndexOf("\\") + 1);
                    listBox.options[j].value = filePath;
                    */
                }
            </script>

            <img src="../Imagenes/GmailAdjunto2.png" alt="" style="border-style: none; border-color: inherit;
                border-width: medium; vertical-align: middle; text-decoration: none; margin-left: 5px;" />
            <asp:LinkButton ID="lnkAdjuntar" runat="server" Font-Bold="False" Font-Size="Small"
                Font-Underline="True" ForeColor="White" Height="16px" Width="63px" ValidationGroup="Encabezado"
                OnClientClick="BrowseFile()" CausesValidation="False" Visible="False" Style="margin-right: 0px">Adjuntar</asp:LinkButton>
            <asp:Button ID="btnAdjuntoSubir" runat="server" Font-Bold="False" Height="19px" Style="margin-left: 0px;
                margin-right: 23px; text-align: left;" Text="Adjuntar" Width="58px" CssClass="button-link"
                CausesValidation="False" />
            <asp:LinkButton ID="lnkAdjunto1" runat="server" ForeColor="White" Visible="False"></asp:LinkButton>
            <%--<asp:ListBox ID="ListBox1" runat="server" Visible="False"></asp:ListBox>
--%>
            <%--        
DONDE ESTA EL DICHOSO AsyncFileUpload de AJAX?????????????????????????????
-Necesita 3.5.... mmmmm, mejor segui con el FileUpload
<ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" UploadingBackColor="Yellow"
            OnUploadedComplete="ProcessUpload" OnClientUploadComplete="showUploadConfirmation" ThrobberID="spanUploading"  />
--%>
            <%--OJO SI LO METES EN UN UPDATEPANEL NO ANDA!!!!!!   --%>
            <%--CssClass="imp"--%>
            <asp:FileUpload ID="FileUpLoad2" runat="server" Width="402px" Height="22px" CssClass="button-link"
                Font-Underline="False" />
            <%--style="visibility:hidden"--%>
            <asp:LinkButton ID="lnkBorrarAdjunto" runat="server" ForeColor="White">borrar</asp:LinkButton>
            <br />
            <br />
        </asp:Panel>
    </div>
    <br />
    <table style="padding: 0px; border: none #FFFFFF; width: 852px; margin-right: 0px;"
        cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="4" style="border: thin none #FFFFFF; color: #FFFFFF;" align="left" valign="top">
                <asp:UpdatePanel ID="UpdatePanelImputaciones" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="PanelImputaciones" runat="server">
                            <div style="overflow: auto; width: 100%;">
                                <asp:GridView ID="gvImputaciones" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                                    Width="100%" class="DetalleGrilla" CellPadding="3" ShowFooter="True" OnRowDataBound="gvImputaciones_RowDataBound"
                                    OnRowCancelingEdit="gvImputaciones_RowCancelingEdit" OnRowEditing="gvImputaciones_RowEditing"
                                    OnRowUpdating="gvImputaciones_RowUpdating">
                                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Right" Font-Bold="True" Font-Size="Small"
                                        ForeColor="#CC0000" />
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                                        <asp:TemplateField HeaderText="Imputaciones" HeaderStyle-HorizontalAlign="left">
                                            <ItemStyle Wrap="True" Width="400" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label17" runat="server" Text='<%# Eval("ComprobanteImputadoNumeroConDescripcionCompleta")  %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="FechaComprobanteImputado" HeaderText="Fecha" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:dd/M/yyyy}" Visible="true" ReadOnly="True" />
                                        <asp:BoundField DataField="SaldoParteEnPesosAnterior" HeaderText="Saldo" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" ReadOnly="True" />
                                        <asp:BoundField DataField="TotalComprobanteImputado" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" Visible="true" ReadOnly="True" />
                                        <asp:BoundField DataField="ImportePagadoSinImpuestos" HeaderText="Sin imp." ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" Visible="true" ReadOnly="True" />
                                        <asp:BoundField DataField="IVA" HeaderText="IVA" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" Visible="true" ReadOnly="True" />
                                        <asp:BoundField DataField="ImporteRetencionIVA" HeaderText="RetIVA" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" Visible="true" ReadOnly="True" />
                                        <asp:BoundField DataField="ImporteRetencionIngresosBrutos" HeaderText="RetIIBB" ReadOnly="True"
                                            Visible="false" />
                                        <asp:BoundField DataField="GravadoIVA" HeaderText="Grav.IVA" ItemStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" Visible="true" ReadOnly="True" />
                                        <asp:TemplateField HeaderText="Importe" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="Right"
                                            FooterText="0.00">
                                            <ItemStyle Wrap="True" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label417" runat="server" Text='<%# Eval("Importe","{0:F2}")  %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtGvImputacionesImporte" Style="text-align: right;" runat="server"
                                                    Text='<%# Eval("Importe","{0:F2}")  %>' Width="70" OnTextChanged="txtGvImputacionesImporte_TextChanged"
                                                    CommandName="cmdCambioImporte" Font-Size="X-Small" CausesValidation="False" AutoPostBack="True">
                                                </asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:ButtonField ButtonType="Image" CommandName="Eliminar" Text="X" ItemStyle-HorizontalAlign="Right"
                                            HeaderText="" ImageUrl="../Imagenes/borrar.png" HeaderStyle-Font-Size="X-Small"
                                            Visible="true">
                                            <ControlStyle Font-Size="Small" />
                                            <ItemStyle Font-Size="Small" />
                                            <HeaderStyle Width="20px" />
                                        </asp:ButtonField>
                                        <asp:ButtonField ButtonType="Image" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Right"
                                            ImageUrl="../Imagenes/editar.png" CausesValidation="true" ValidationGroup="Encabezado"
                                            HeaderText="" Visible="true">
                                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                                            <ItemStyle Font-Size="X-Small" />
                                            <HeaderStyle Width="20px" />
                                        </asp:ButtonField>
                                    </Columns>
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:LinkButton ID="LinkButtonImputacion" runat="server" Font-Bold="False" ForeColor="White"
                                        Font-Size="X-Small" Height="20px" ValidationGroup="Encabezado" BorderStyle="None"
                                        Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px; margin-right: 50px;"
                                        Font-Underline="False" Enabled="true">
                                        <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />
                                        <asp:Label ID="Label1" runat="server" ForeColor="White" Text="Agregar imputación"
                                            Font-Underline="True"> </asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LinkButtonAplicacionAutomatica" runat="server" Font-Bold="False"
                                        ForeColor="White" Font-Size="X-Small" Height="20px" ValidationGroup="Encabezado"
                                        BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                                        Font-Underline="False" Enabled="true" Visible="false">
                                        <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />
                                        <asp:Label ID="Label44135" runat="server" ForeColor="White" Text="Aplicacion automatica"
                                            Font-Underline="True"> </asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LinkButtonImputacionPagoAnticipado" runat="server" Font-Bold="False"
                                        ForeColor="White" Font-Size="X-Small" Height="20px" ValidationGroup="Encabezado"
                                        BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;
                                        margin-right: 50px;" Font-Underline="False" Enabled="true">
                                        <%--<img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />--%>
                                        <asp:Label ID="Label135" runat="server" ForeColor="White" Text="Agregar anticipo"
                                            Font-Underline="True"> </asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LinkButtonAplicarDiferenciaDeCambio" runat="server" Font-Bold="False"
                                        ForeColor="White" Font-Size="X-Small" Height="20px" ValidationGroup="Encabezado"
                                        BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;
                                        margin-right: 50px;" Font-Underline="False" Enabled="true">
                                        
                                        <asp:Label runat="server" ForeColor="White" Text="Aplicar dif. cambio"
                                            Font-Underline="True"> </asp:Label>
                                    </asp:LinkButton>
                                    <%--Dif. cambio--%>
                                    <asp:Label ID="txtTotalDiferenciaCambio" runat="server" Enabled="false" Width="60px"
                                        Visible="false" />
                                    <asp:LinkButton ID="LinkButtonEnsancharGrillaImputaciones" runat="server" Font-Bold="False"
                                        Font-Underline="True" ForeColor="White" CausesValidation="False" Font-Size="X-Small"
                                        Height="20px" Text="más..." BorderStyle="None" Style="text-align: right; margin-right: 0px;
                                        margin-top: 0px; margin-bottom: 0px; margin-left: 5px;" BorderWidth="5px" Width="90px"
                                        Visible="false"></asp:LinkButton>
                                    <br />
                                    <asp:Button ID="Button16" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                                        display: none" />
                                    <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderImputacion" runat="server"
                                        TargetControlID="button16" PopupControlID="PopupGrillaSolicitudes" OkControlID="btnSaveItemImputacionAux"
                                        CancelControlID="Button4" DropShadow="False" BackgroundCssClass="modalBackground" />
                                    <asp:Panel ID="PopupGrillaSolicitudes" runat="server" Height="480px" Width="720px"
                                        CssClass="modalPopup">
                                        <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox ID="txtBuscaGrillaImputaciones" runat="server" Style="text-align: right;"
                                                    Text="" AutoPostBack="true"></asp:TextBox>
                                                <div style="width: 720px; height: 400px; overflow: auto" align="center">
                                                    <asp:GridView ID="gvAuxPendientesImputar" runat="server" AutoGenerateColumns="False"
                                                        BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
                                                        CellPadding="3" DataKeyNames="IdCtaCte,Nro_comp_,Numero,Comp_,Saldo Comp_,Fecha,Imp_orig_"
                                                        DataSourceID="ObjectDataSource2" GridLines="Horizontal" AllowPaging="True" Height="85%"
                                                        CssClass="t1" Width="700px">
                                                        <FooterStyle CssClass="FooterStyle" />
                                                        <Columns>
                                                            <%--<asp:CommandField ShowSelectButton="true" />--%>
                                                            <asp:BoundField DataField="IdCtaCte" HeaderText="IdCtaCte" InsertVisible="False"
                                                                ReadOnly="True" SortExpression="IdCtaCte" Visible="False" />
                                                            <asp:TemplateField HeaderText="">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>'
                                                                        Visible='<%# IIf(Eval("SaldoTrs").ToString() = "" , true , false) %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Comp_" HeaderText="" ItemStyle-Width="20" />
                                                            <asp:BoundField DataField="Nro_comp_" HeaderText="" ItemStyle-Wrap="false" />
                                                            <asp:TemplateField HeaderText="Número" SortExpression="Numero" ItemStyle-Width="200"
                                                                ItemStyle-Wrap="False">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Numero") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Numero")   %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="50px" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/M/yyyy}" />
                                                            <asp:BoundField DataField="Imp_Orig_" HeaderText="Imp.Orig." />
                                                            <asp:BoundField DataField="Saldo Comp_" HeaderText="Saldo Comp." />
                                                            <asp:BoundField DataField="SaldoTrs" HeaderText="Saldo Trs" />
                                                            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                                                        </Columns>
                                                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                        <AlternatingRowStyle BackColor="#F7F7F7" />
                                                    </asp:GridView>
                                                    <asp:HiddenField ID="HiddenIdGrillaPopup" runat="server" />
                                                    <%--//////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////--%>
                                                    <%--    datasource de grilla principal--%>
                                                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                                        SelectMethod="GetListTX" TypeName="Pronto.ERP.Bll.CtaCteAcreedorManager" DeleteMethod="Delete"
                                                        UpdateMethod="Save">
                                                        <SelectParameters>
                                                            <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                                            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                                            <asp:Parameter Name="TX" DefaultValue="ParaImputar" />
                                                            <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
                                                            <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
                                                        </SelectParameters>
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="SC" Type="String" />
                                                            <asp:Parameter Name="myOrdenPago" Type="Object" />
                                                        </DeleteParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="SC" Type="String" />
                                                            <asp:Parameter Name="myOrdenPago" Type="Object" />
                                                        </UpdateParameters>
                                                    </asp:ObjectDataSource>
                                                    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    <asp:HiddenField ID="HFIdObra" runat="server" />
                                                    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        </div>
                                        <br />
                                        <asp:Button ID="btnSaveItemImputacionAux" runat="server" Font-Size="Small" Text="Aceptar"
                                            CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                                        <asp:Button ID="Button4" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                            UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px" Font-Bold="False"
                                            Height="25px" CausesValidation="False" Width="78px" />
                                        <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
    --%></asp:Panel>
                                    <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                                    <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <%--boton que dispara la actualizacion de la grilla--%>
                        <asp:AsyncPostBackTrigger ControlID="btnSaveItemValor" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <%--<asp:Parameter Name="Parametros(0)"  DefaultValue="P"  />
                       --%>
    <asp:UpdatePanel ID="UpdatePanelValores" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto; width: 852px;">
                <asp:GridView ID="gvValores" runat="server" AutoGenerateColumns="False" BackColor="White"
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                    Width="100%" class="DetalleGrilla" CellPadding="3" ShowFooter="True">
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Right" Font-Bold="True" Font-Size="Small" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                        <asp:BoundField DataField="Tipo" HeaderText="Valores" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="NumeroInterno" HeaderText="n° int" HeaderStyle-HorizontalAlign="left"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="NumeroValor" HeaderText="n° cheque" HeaderStyle-HorizontalAlign="left"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="FechaVencimiento" HeaderText="Vence" DataFormatString="{0:dd/M/yyyy}"
                            ItemStyle-Wrap="False" ItemStyle-Width="60" HeaderStyle-HorizontalAlign="Right"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="Importe" HeaderText="Importe" ItemStyle-HorizontalAlign="Right"
                            HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:F2}" ItemStyle-Wrap="False"
                            FooterText="0.00" />
                        <asp:ButtonField ButtonType="Image" CommandName="Eliminar" Text="X" ItemStyle-HorizontalAlign="Right"
                            HeaderText="" ImageUrl="../Imagenes/borrar.png" HeaderStyle-Font-Size="X-Small"
                            Visible="true">
                            <ControlStyle Font-Size="Small" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="20px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Image" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Right"
                            ImageUrl="../Imagenes/editar.png" CausesValidation="true" ValidationGroup="Encabezado"
                            HeaderText="" Visible="true">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="20px" />
                        </asp:ButtonField>
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
    <%--AUTOCOMPLETE--%>
    <asp:UpdatePanel ID="UpdatePanellValorAux" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%--boton de agregar--%>
            <asp:LinkButton ID="LinkButtonValor" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                Font-Underline="False" Enabled="true">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label31" runat="server" ForeColor="White" Text="Agregar valor" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkAgregarCaja" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                Font-Underline="False" Enabled="true">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Agregar caja" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <asp:LinkButton ID="LinkButtonValorChequeDeTercero" runat="server" Font-Bold="False"
                ForeColor="White" Font-Size="X-Small" Height="20px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;
                margin-right: 50px;" Font-Underline="False" Enabled="true">
                                        <%--<img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />--%>
                                        <asp:Label  runat="server" ForeColor="White" Text="Buscar en cartera"
                                            Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <asp:TextBox ID="txtPopupRetorno" runat="server" Width="327px" AutoPostBack="True"
                Style="visibility: hidden"></asp:TextBox>

            <script type="text/javascript">
                function OpenPopup() {
                    window.open("popupGrid.aspx", "List", "scrollbars=no,resizable=no,width=620,height=400,left=0,top=0,toolbar=No,status=No,fullscreen=No");

                    return false;
                }
            </script>

            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button1" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>

            <script type="text/javascript">
                // Disparando el modalpopup explícitamente para poder ejecutar cosas antes de que aparezca
                // (No lo estoy usando)
                // http://stackoverflow.com/questions/1277045/to-show-modalpopup-in-javascript
                function fnModalShow() {
                    var modalDialog = $find("ModalPopupExtenderValor");
                    // get reference to modal popup using the AJAX api $find() function

                    if (modalDialog != null) {
                        modalDialog.show();
                    }
                }
            </script>

            <%----------------------------------------------%>
            <asp:Panel ID="PanelValor" runat="server" Width="636px" CssClass="modalPopup">
                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                <%--            style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
--%>
                <%--cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                    <ContentTemplate>
                        <table style="height: 97px; width: 632px; color: #FFFFFF;">
                            <%----fecha               ----%>
                            <tr style="visibility: hidden; display: none">
                                <td style="width: 20%">
                                    Tipo valor
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetFechaEntrega" runat="server" Width="72px" Enabled="False"></asp:TextBox>
                                    <cc1:CalendarExtender ID="CalendarExtender10" runat="server" Format="dd/MM/yyyy"
                                        TargetControlID="txtDetFechaEntrega">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender10" runat="server" AcceptNegative="Left"
                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtDetFechaEntrega">
                                    </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                            <tr style="visibility: hidden; display: none;">
                                <td style="width: 20%">
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCodigo" runat="server" Width="71px" Height="22px" AutoPostBack="True"
                                        TabIndex="101" Enabled="False"></asp:TextBox>
                                    <%--AUTOCOMPLETE--%>
                                    <%--
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    TEXTBOX+AUTOCOMPLETE del popup
                    truquitos autocomplete
                    http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106
                    (Ajax Extender has to be in the same UpdatePanel as its TargetControlID!!!)
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////


                --%>
                                    <asp:TextBox ID="txt_AC_Articulo" runat="server" autocomplete="off" AutoCompleteType="None"
                                        Width="400px" OnTextChanged="btnTraerDatosArti_Click" AutoPostBack="false" Style="margin-left: 0px"
                                        Height="21px" Enabled="False"></asp:TextBox>
                                    <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="3" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="true"
                                        OnClientItemSelected="SetSelectedAutoCompleteIDArticulo" CompletionListElementID='ListDivisor'
                                        CompletionListCssClass="AutoCompleteScroll">
                                        <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                                        <%--                    
                        <Animations>
                            <OnHide>
                               <ScriptAction Script="ClearHiddenIDField()" />  
                            </OnHide>
                        </Animations>
                        --%>
                                    </cc1:AutoCompleteExtender>

                                    <script type="text/javascript">
                                        function checkFocusOnExtender() {
                                            //check if focus is on productcode extender

                                            var AutoCompleteExtender = $find('<%=AutoCompleteExtender2.ClientID%>');

                                            if (AutoCompleteExtender == null) return false; //para que IE6 no explote por un null

                                            if (AutoCompleteExtender._flyoutHasFocus)
                                                return false;
                                            else
                                                return true;

                                        }
                                    </script>

                                    <%--tiene que haber un SetSelectedxxxxxx por cada Autocomplete--%>

                                    <script type="text/javascript">

                                        function SetSelectedAutoCompleteIDArticulo(source, eventArgs) {
                                            //en eventArgs le pasan el get_text y el get_value
                                            //en la linea siguiente pego el ID en el control <input> hidden
                                            var a = eventArgs.get_value();
                                            var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedAutoCompleteIDArticulo');
                                            //comento esta linea pues el proveedor no tiene codigo.... -podrías traer el CUIT... 
                                            //-uf,tambien podría traer la condicion de IVA...
                                            //var cod = document.getElementById('ctl00_ContentPlaceHolder1_txtCodigo');
                                            var s = new Array();
                                            s = a.split('^'); //separo la informacion que me pasa el web service
                                            id.value = s[0]; //le aviso a clearhidden que no me pise el dato
                                            //id.value = id.value + ' Che_ClearHiddenIDField_esto_es_nuevo'; //le aviso a clearhidden que no me pise el dato
                                            //cod.value = s[1];

                                            ///////////////////////////////
                                            //deshabilitar el cuit y la condicion ..... (pues solo son editables si el alta se hace al vuelo)
                                            ///////////////////////////////
                                            //document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = true;
                                            //document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = true;

                                            //                            //.... , y llenarlos (debiera llamar al server?)
                                            ///////////////////////////////



                                            // opcional: fuerzo click al "go button (http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106)
                                            // si el boton no está visible, getElementById devuelve null 
                                            var but = document.getElementById('ctl00_ContentPlaceHolder1_btnTraerDatosArti');
                                            but.click(); // .onclick();

                                            //alert(a);
                                            //alert(b.value);
                                        }

                                    </script>

                                    <div id="ListDivisor">
                                    </div>
                                    <%-- Por si la lista se renderea atrás   http://forums.asp.net/t/1079711.aspx--%>
                                    <input id="SelectedAutoCompleteIDArticulo" runat="server" type="hidden" />
                                    <%--el hidden que guarda el id--%>
                                    <asp:Button ID="btnTraerDatosArti" runat="server" Text="YA" Width="30px" Height="22px"
                                        CausesValidation="False" Style="visibility: hidden;" />
                                    <%--el que trae los datos del proveedor--%>
                                    <%--                
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
                    FIN DE TEXTBOX+AUTOCOMPLETE
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
--%>
                                </td>
                            </tr>
                            <%---- Combo              ----%>
                            <%--               <tr>
                    <td style=" width: 130px; height: 22px;">
                        <asp:Label ID="lblArticulo" runat="server" Text="Artículo" ForeColor="White"></asp:Label>
                    </td>
                    <td colspan="3" style="height: 22px">
                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" Width="80px" 
                            Visible="False"></asp:TextBox>
                        <cc1:ComboBox RenderMode="Block" ID="cmbCuentaGasto" runat="server" Width="400px" 
                            Font-Overline="False" ></cc1:ComboBox>
                    </td>
                </tr>--%>
                            <%----               ----%>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Tipo
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetValorTipo" runat="server" CssClass="CssCombo" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    N° interno
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetValorNumeroInterno" runat="server" Width="72px" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Banco cuenta
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetValorBancoCuenta" runat="server" Width="400px" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Chequera
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetValorChequeras" runat="server" Width="400px" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator331" runat="server" ControlToValidate="cmbDetValorChequeras"
                                        ErrorMessage="* Ingrese chequera" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="Detalle" InitialValue="-1" Display="Dynamic" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    N° de cheque
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetValorCheque" runat="server" Width="72px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator33331" runat="server" ControlToValidate="txtDetValorCheque"
                                        ErrorMessage="* Ingrese cheque" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="Detalle" InitialValue="" Display="Dynamic" />
                                    Vencimiento
                                    <asp:TextBox ID="txtDetValorVencimiento" runat="server" Width="110px" MaxLength="1"
                                        Style="margin-left: 0px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtDetValorVencimiento">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtDetValorVencimiento">
                                    </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanellValorPreciosYCantidades" runat="server">
                    <ContentTemplate>
                        <table style="height: 29px; width: 632px; color: #FFFFFF;">
                            <%----               ----%>
                            <tr style="visibility: hidden; display: none">
                                <td style="width: 15%; height: 16px;">
                                    <asp:Label ID="lblCantidad" runat="server" ForeColor="White" Text="Cantidad"></asp:Label>
                                </td>
                                <td style="height: 16px;" colspan="1">
                                    <%--                                    <asp:TextBox ID="txtDetCantidad" runat="server" Width="65px" Style="text-align: right;"
                                        OnTextChanged="btnRecalcularTotal_Click" AutoPostBack="True" Height="22px"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtDetCantidad"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>--%>
                                </td>
                                <td colspan="2" style="height: 16px;">
                                    <asp:UpdatePanel ID="Updatepanel11" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cmbDetUnidades" runat="server" AutoPostBack="True" Enabled="False"
                                                Width="73px" Height="22px">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td colspan="4" style="height: 16px;">
                                    <%--                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDetCantidad"
                                        ErrorMessage="* Ingrese Cantidad" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="Detalle" />
                                    <cc1:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                                        runat="server" Enabled="True" TargetControlID="RequiredFieldValidator3"  CssClass="CustomValidatorCalloutStyle" />
--%>
                                </td>
                            </tr>
                            <%----               ----%>
                            <tr>
                                <td style="width: 15%; height: 10px;">
                                    Importe
                                </td>
                                <td style="height: 10px;">
                                    <asp:TextBox ID="txtDetValorImporte" runat="server" Width="65px" Style="text-align: right;"
                                        OnTextChanged="btnRecalcularTotal_Click" AutoPostBack="True"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDetValorImporte"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDetValorImporte"
                                        ErrorMessage="* Ingrese Importe" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="Detalle" Display="Dynamic" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    A la orden de
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetValorAlaOrden" runat="server" Width="110px"></asp:TextBox>
                                    <asp:CheckBox ID="chkDetNoAlaOrden" Text="No a la Orden" runat="server" />
                                </td>
                            </tr>
                            <%----               ----%>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                </td>
                                <td style="height: 16px;" colspan="8">
                                    <asp:Button ID="btnRecalcularTotal" runat="server" Height="25px" Text="Recalcular Total"
                                        Width="102px" Style="visibility: hidden;" />
                                </td>
                            </tr>
                            <%---- Obra Destino  ----%>
                            <%--                
                <tr>
                    <td style="width: 130px; height: 11px;">
                        <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Destino"></asp:Label>
                    </td>
                    <td style=" width: 185px; height: 11px;" colspan="3">
                        <asp:DropDownList ID="cmbDestino" runat="server" Width="200px"/>
                    </td>
                </tr>
--%>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <%--                        <asp:AsyncPostBackTrigger ControlID="txtDetCantidad" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetValorImporte" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetIVA" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
                <%----    Adjuntos           ----%>
                <table style="width: 632px;">
                    <tr style="visibility: hidden; display: none;">
                        <td style="width: 15%; height: 20px;">
                            <asp:Label ID="Label24" runat="server" Text="Adjunto" ForeColor="White"></asp:Label>
                        </td>
                        <td style="height: 20px">
                            <%--'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON!!!!--%>
                            <asp:LinkButton ID="lnkDetAdjunto1" runat="server" CausesValidation="False">LinkButton</asp:LinkButton>
                            <%--http://www.elguruprogramador.com.ar/articulos/upload-de-archivos-en-aspnet.htm--%>
                            <%--                        <asp:Button id="btnDetAdjuntoSubir" Text="Upload File" runat="server" 
                            Width="73px" Height="26px" />
                        <asp:FileUpLoad id="FileUpLoad2" runat="server" />--%>
                            <%--<asp:RegularExpressionValidator id="FileUpLoadValidator" runat="server" 
                            ErrorMessage="Upload Gifs only." 
                            ValidationExpression="^(([a-zA-Z]:)|({2}w+)$?)((w[w].*))(.gif|.GIF)$"
                            ControlToValidate="FileUpload2" />--%>
                        </td>
                    </tr>
                    <tr style="visibility: hidden; display: none;">
                        <td style="width: 15%; height: 20px;">
                            <asp:Label ID="Label14" runat="server" ForeColor="White"></asp:Label>
                        </td>
                        <td style="height: 20px">
                            <%--'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON!!!!--%>
                            <asp:LinkButton ID="lnkDetAdjunto2" runat="server" CausesValidation="False">LinkButton</asp:LinkButton>
                        </td>
                    </tr>
                    <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
    --%>
                </table>
                <table style="width: 632px;">
                    <tr>
                        <td style="width: 15%; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItemValor" runat="server" Font-Size="Small" Text="Aceptar"
                                CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="Detalle" />
                            <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                Height="25px" CausesValidation="False" Width="78px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderValor" runat="server" TargetControlID="Button1"
                PopupControlID="PanelValor" CancelControlID="btnCancelItem" DropShadow="False"
                BackgroundCssClass="modalBackground" />
            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
        </ContentTemplate>
        <Triggers>
            <%--el FileUpload y el de descarga no funcionan si no se refresca el UpdatePanel 
             http://forums.asp.net/t/1403316.aspx
             note that it is not an AsyncPostBackTrigger
             http://mobiledeveloper.wordpress.com/2007/05/15/file-upload-with-aspnet-ajax-updatepanel/
             --%>
            <asp:PostBackTrigger ControlID="lnkDetAdjunto1" />
            <asp:PostBackTrigger ControlID="lnkDetAdjunto2" />
            <asp:PostBackTrigger ControlID="btnRecalcularTotal" />
            <%--            <asp:AsyncPostBackTrigger ControlID="txtDetCantidad" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetValorImporte" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetIVA" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />--%>
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelCaja" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%--boton de agregar--%>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button2" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>
            <%----------------------------------------------%>
            <asp:Panel ID="PanelCaja" runat="server" Width="636px" CssClass="modalPopup">
                <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                    <ContentTemplate>
                        <table style="height: 97px; width: 632px; color: #FFFFFF;">
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Caja
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetCaja" runat="server" Width="400px">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="cmbDetCaja"
                                        ErrorMessage="* Ingrese caja" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="DetalleCaja" InitialValue="-1" Display="Dynamic" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Importe
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetCajaImporte" runat="server" Width="72px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="width: 632px;">
                    <tr>
                        <td style="width: 15%; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItemCaja" runat="server" Font-Size="Small" Text="Aceptar"
                                CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="DetalleCaja" />
                            <asp:Button ID="Button11" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                Height="25px" CausesValidation="False" Width="78px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderCaja" runat="server" TargetControlID="Button2"
                PopupControlID="PanelCaja" CancelControlID="Button11" DropShadow="False" BackgroundCssClass="modalBackground" />
            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
        Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
        TabIndex="10" Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
        <asp:Label ID="Label29" runat="server" ForeColor="White" Text="Imprimir" Font-Underline="True"></asp:Label></asp:LinkButton>
    <div style="border: none; width: 850px; margin-top: 5px;" align="right">
        <form autocomplete="off">
        <table style="margin: 0px 0px 0px 0px; padding: 0px; border-style: none; border-width: thin;
            width: 850px; border-spacing: 0px; color: #FFFFFF;" id="TablaResumen" cellpadding="0"
            cellspacing="0">
            <tr>
                <td style="width: 500px">
                    <div style="width: 500px; overflow: auto;">
                        <asp:UpdatePanel ID="UpdatePanelImpuestos" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvImpuestosCalculados" runat="server" AutoGenerateColumns="False"
                                    BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
                                    DataKeyNames="Id" Width="500px" class="DetalleGrilla" CellPadding="3" EmptyDataText="Ingrese una imputación para que se calculen sus impuestos"
                                    FooterStyle-CssClass="FooterStyle">
                                    <FooterStyle />
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                                        <asp:BoundField DataField="TipoImpuesto" HeaderText="Impuesto calculado" HeaderStyle-Font-Bold="true"
                                            HeaderStyle-HorizontalAlign="Left" HeaderStyle-Wrap="true" />
                                        <asp:BoundField DataField="Categoria" HeaderText="Categoria" HeaderStyle-HorizontalAlign="Left"
                                            ItemStyle-Wrap="False" />
                                        <asp:BoundField DataField="ImportePagado" HeaderText="Pago s/imp" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="ImpuestoRetenido" HeaderText="Retenido" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="PagosMes" HeaderText="Pagos mes" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="ImporteTopeMinimoIIBB" HeaderText="MinimoIIBB" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="AlicuotaIIBB" HeaderText="Alic.IIBB" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="AlicuotaConvenioIIBB" HeaderText="Al.Conven.IIBB" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="PorcentajeATomarSobreBase" HeaderText="% s/base" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="PorcentajeAdicional" HeaderText="% adic" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="ImpuestoAdicional" HeaderText="Imp.adic" HeaderStyle-HorizontalAlign="Right"
                                            DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:BoundField DataField="NumeroCertificadoRetencionGanancias" HeaderText="Cert gananc."
                                            HeaderStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="NumeroCertificadoRetencionIIBB" HeaderText="Cert IIBB"
                                            HeaderStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="ImporteTotalFacturasMPagadasSujetasARetencion" HeaderText="Tot.fact a Ret"
                                            HeaderStyle-HorizontalAlign="Left" />
                                    </Columns>
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <EmptyDataRowStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <br />
                    <div style="width: 500px; overflow: auto;">
                        <asp:UpdatePanel ID="UpdatePanelAsiento" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="gvCuentas" runat="server" AutoGenerateColumns="False" BackColor="White"
                                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                                    Width="500px" class="DetalleGrilla" CellPadding="3" ShowFooter="True">
                                    <FooterStyle HorizontalAlign="Right" CssClass="FooterStyle" BorderStyle="None" />
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                                        <%--                           <asp:BoundField DataField="CodigoCuenta" HeaderText="Asiento contable" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="DescripcionCuenta" HeaderText="" />--%>
                                        <asp:TemplateField HeaderText="Asiento contable" HeaderStyle-HorizontalAlign="Left"
                                            ItemStyle-Wrap="False">
                                            <ItemStyle Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("CodigoCuenta") &  "  " &  Eval("DescripcionCuenta")  %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Debe" HeaderText="Debe" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:F2} " FooterText="0.00" />
                                        <asp:BoundField DataField="Haber" HeaderText="Haber" ItemStyle-HorizontalAlign="Right"
                                            HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:F2}" FooterText="0.00" />
                                        <asp:ButtonField ButtonType="Image" CommandName="Eliminar" Text="X" ItemStyle-HorizontalAlign="Right"
                                            HeaderText="" ImageUrl="../Imagenes/borrar.png" HeaderStyle-Font-Size="X-Small"
                                            Visible="true">
                                            <ControlStyle Font-Size="Small" />
                                            <ItemStyle Font-Size="Small" />
                                            <HeaderStyle Width="20px" />
                                        </asp:ButtonField>
                                        <asp:ButtonField ButtonType="Image" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Right"
                                            ImageUrl="../Imagenes/editar.png" CausesValidation="true" ValidationGroup="Encabezado"
                                            HeaderText="" Visible="true">
                                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                                            <ItemStyle Font-Size="X-Small" />
                                            <HeaderStyle Width="20px" />
                                        </asp:ButtonField>
                                    </Columns>
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel15" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%--boton de agregar--%>
                            <table width="">
                                <tr>
                                    <td align="left">
                                        <asp:LinkButton ID="LinkButtonAsiento" runat="server" Font-Bold="False" ForeColor="White"
                                            Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                                            BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                                            Font-Underline="False" Enabled="true">
                                            <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                                text-decoration: none;" width="16" height="16" />
                                            <asp:Label ID="Label7" runat="server" ForeColor="White" Text="Agregar registro" Font-Underline="True"> </asp:Label>
                                        </asp:LinkButton>
                                    </td>
                                    <td valign="top" align="left">
                                        <asp:CheckBox ID="chkRecalculoAutomatico" runat="server" AutoPostBack="True" Text="Manual"
                                            Checked="false" ForeColor="White" Style="vertical-align: top; margin-top: 0px;"
                                            Visible="true" />
                                        <asp:Button ID="btnRecalcularAsiento" runat="server" Font-Bold="False" Height="20px"
                                            Font-Size="X-Small" Style="vertical-align: bottom; margin-left: 0px; margin-right: 23px;
                                            text-align: left;" Text="Recalcular" Width="58px" CssClass="button-link" CausesValidation="False"
                                            Visible="False" />
                                    </td>
                                </tr>
                            </table>
                            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                            <asp:Button ID="Button6" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                                display: none" />
                            <%--style="visibility:hidden;"/>--%>
                            <%----------------------------------------------%>
                            <asp:Panel ID="PanelAsiento" runat="server" Width="636px" CssClass="modalPopup">
                                <asp:UpdatePanel ID="UpdatePanel16" runat="server">
                                    <ContentTemplate>
                                        <table style="height: 97px; width: 632px; color: #FFFFFF;">
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Obra
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoObra" runat="server" Width="400px" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Cuenta
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoCuentaGrupo" runat="server" Width="80" AutoPostBack="True" />
                                                    <asp:TextBox ID="txtDetAsientoCodigoCuenta" runat="server" Enabled="true" Width="60"
                                                        AutoPostBack="True"></asp:TextBox>
                                                    <asp:TextBox ID="txtAsientoAC_Cuenta" runat="server" autocomplete="off" TabIndex="6"
                                                        CssClass="CssTextBox" AutoPostBack="True"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender20" runat="server" CompletionSetCount="12"
                                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceCuentas.asmx"
                                                        TargetControlID="txtAsientoAC_Cuenta" CompletionListElementID='ListDivisor10'
                                                        UseContextKey="True" CompletionListCssClass="AutoCompleteScroll" FirstRowSelected="True"
                                                        CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                                    </cc1:AutoCompleteExtender>
                                                    <div id="ListDivisor10">
                                                    </div>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtAsientoAC_Cuenta"
                                                        ErrorMessage="* Ingrese una cuenta" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                                        InitialValue="" ValidationGroup="" Enabled="true" Display="Dynamic" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Cuenta Gasto
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoCuentaGasto" runat="server" Width="400px" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="butLimpiaCuentaGasto" runat="server" Width="18px" Text="x" ToolTip="Resetear cuentas"
                                                        ForeColor="#FF3300" Font-Bold="True" CausesValidation="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Cuenta banco
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoCuentaBanco" runat="server" Width="400px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Caja
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoCaja" runat="server" Width="400px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Moneda destino
                                                </td>
                                                <td style="height: 16px;">
                                                    <asp:DropDownList ID="cmbDetAsientoMoneda" runat="server" Width="400px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%; height: 16px;">
                                                    Debe
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDetAsientoDebe" runat="server" Width="72px"></asp:TextBox>
                                                    Haber
                                                    <asp:TextBox ID="txtDetAsientoHaber" runat="server" Width="72px"></asp:TextBox>
                                                </td>
                                                <td style="height: 16px;">
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <table style="">
                                    <tr>
                                        <td style="width: 20%; height: 46px;">
                                        </td>
                                        <td align="right" style="height: 46px">
                                            <asp:Button ID="btnSaveItemAsiento" runat="server" Font-Size="Small" Text="Aceptar"
                                                CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="" />
                                            <asp:Button ID="Button12" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                                Height="25px" CausesValidation="False" Width="78px" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderAsiento" runat="server" TargetControlID="Button6"
                                PopupControlID="PanelAsiento" CancelControlID="Button12" DropShadow="False" BackgroundCssClass="modalBackground" />
                            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                </td>
                <td style="" align="right" valign="top">
                    <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <table style="margin: 0px 0px 0px 0px; padding: 0px; border-style: none; border-width: thin;
                                width: 230px; border-spacing: 0px; color: #FFFFFF;" id="TablaResumen" cellpadding="0"
                                cellspacing="3">
                                <tr style="" id="trOPcompl">
                                    <td style="width: 130px;">
                                        N°OP compl
                                        <asp:TextBox ID="txtNumeroOPcomplementariaFF" runat="server" AutoPostBack="true"
                                            OnTextChanged="RecalcularTotalComprobante" Style="text-align: right;" Width="40px"
                                            Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                    <td align="right" style="">
                                        <asp:Label ID="txtTotalOPComplementariaFF" runat="server" Text="0.00" AutoPostBack="true"
                                            OnTextChanged="RecalcularTotalComprobante" Enabled="false" Style="text-align: right;"
                                            Width="60px" Font-Size="X-Small" />
                                    </td>
                                </tr>
                                <tr style="visibility: hidden; display: none">
                                    <td style="">
                                        SUBTOTAL
                                    </td>
                                    <td align="right" style="">
                                        <asp:Label ID="txtSubtotal" runat="server" ForeColor="White" Width="60px"></asp:Label>
                                    </td>
                                </tr>
                                <%--<tr>
                        <td style="width: 241px; height: 16px;">
                            <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Bonif por item"></asp:Label>
                        </td>
                        <td style="height: 16px;" align="right">
                            <asp:Label ID="txtBonificacionPorItem" runat="server" ForeColor="White" Width="74px"
                                Height="16px"></asp:Label>
                        </td>
                    </tr>--%>
                                <tr style="visibility: hidden; display: none">
                                    <td style="">
                                        Bonif
                                        <asp:TextBox ID="txtTotBonif" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                            Style="text-align: right;" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtTotBonif"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                        %
                                    </td>
                                    <td align="right" style="">
                                        <%--                            <asp:Label ID="txtTotalRetencionIVA" runat="server" ForeColor="White" Width="84px" Height="16px"></asp:Label>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Ret. IVA
                                    </td>
                                    <td align="right" style="">
                                        <asp:LinkButton ID="lnkCertificarIVA" runat="server" Font-Bold="False" ForeColor="White"
                                            Font-Size="Small" Height="15px" Width="15px" ValidationGroup="Encabezado" BorderStyle="None"
                                            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
                                            Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
                                        </asp:LinkButton>
                                        <asp:TextBox ID="txtTotalRetencionIVA" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobanteSinRecalcularRetenciones"
                                            Style="text-align: right;" Width="60px" Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Ret. Ganancias
                                    </td>
                                    <td align="right" style="">
                                        <asp:LinkButton ID="lnkCertificarGanancias" runat="server" Font-Bold="False" ForeColor="White"
                                            Font-Size="Small" Height="15px" Width="15px" ValidationGroup="Encabezado" BorderStyle="None"
                                            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
                                            Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
                                        </asp:LinkButton>
                                        <asp:TextBox ID="txtTotalRetencionGanancias" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobanteSinRecalcularRetenciones"
                                            Style="text-align: right;" Width="60px" Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Ret. IIBB
                                    </td>
                                    <td align="right" style="">
                                        <asp:LinkButton ID="lnkCertificarIIBB" runat="server" Font-Bold="False" ForeColor="White"
                                            Font-Size="Small" Height="15px" Width="15px" ValidationGroup="Encabezado" BorderStyle="None"
                                            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
                                            Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
                                        </asp:LinkButton>
                                        <asp:TextBox ID="txtTotalRetencionIIBB" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobanteSinRecalcularRetenciones"
                                            Style="text-align: right;" Width="60px" Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Ret. SUSS
                                    </td>
                                    <td align="right" style="">
                                        <asp:LinkButton ID="lnkCertificarSSUS" runat="server" Font-Bold="False" ForeColor="White"
                                            Font-Size="Small" Height="15px" Width="15px" ValidationGroup="Encabezado" BorderStyle="None"
                                            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
                                            Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
                                        </asp:LinkButton>
                                        <asp:TextBox ID="txtTotalRetencionSUSS" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobanteSinRecalcularRetenciones"
                                            Style="text-align: right;" Width="60px" Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Descuentos
                                    </td>
                                    <td align="right" style="">
                                        <form autocomplete="off">
                                        <asp:TextBox ID="txtTotalDescuentos" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                            autocomplete="off" Style="text-align: right;" Width="60px" Font-Size="X-Small"
                                            Wrap="False"></asp:TextBox>
                                        </form>
                                    </td>
                                </tr>
                                <%--                    <tr>
                        <td style="">
                            Otros conceptos
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotalOtrosConceptos" runat="server" ForeColor="White" Width="76px"
                                Height="16px"></asp:Label>
                        </td>
                    </tr>--%>
                                <tr style="margin: 10px 0px 0px 0px; border-color: #FFFFFF; border-top-style: solid;
                                    border-width: thin; clip: rect(10px, auto, auto, auto);">
                                    <td style="" height="30">
                                        DIFERENCIA
                                    </td>
                                    <td align="right" style="">
                                        <asp:Label ID="lblTotalDiferencia" runat="server" ForeColor="White" Style="margin-left: 6px"
                                            ToolTip="Diferencia entre las imputaciones y el pago" Font-Bold="True" Font-Size="Small"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        </form>
        <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
    --%>
        <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
    </div>
    <div style="border: none; width: 850px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick="if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                    UseSubmitBehavior="False" Width="82px" Style="margin-right: 30px" ValidationGroup="Encabezado">
                </asp:Button>
                <%--le saqué el CssClass="but"--%>
                <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="but"
                    Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Width="79px"
                    Font-Bold="False" Style="margin-right: 30px" Font-Size="Small"></asp:Button>
                <%--ni los Facturas ni las comparativas se anulan--%>
                <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                    UseSubmitBehavior="False" Width="63px" Font-Bold="False" Style="" Font-Size="Small"
                    TabIndex="13"></asp:Button>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
        <asp:UpdatePanel ID="UpdatePanelPreRedirectMsgbox" runat="server">
            <ContentTemplate>
                <ajaxToolkit:ModalPopupExtender ID="PreRedirectMsgbox" runat="server" TargetControlID="btnPreRedirectMsgbox"
                    PopupControlID="PanelInfoNum" DropShadow="false">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Button ID="btnPreRedirectMsgbox" runat="server" Text="invisible" Font-Bold="False"
                    Style="visibility: hidden; display: none" />
                <%--style="visibility:hidden;"/>--%>
                <asp:Panel ID="PanelInfoNum" runat="server" Height="107px" Style="display: none;"
                    CssClass="modalPopup">
                    <table style="" align="center" width="100%">
                        <tr>
                            <td align="center" style="font-weight: bold; color: white; background-color: green">
                                Información
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 37px" align="center">
                                <span style="color: #ffffff">
                                    <br />
                                    <asp:Label ID="LblPreRedirectMsgbox" runat="server" ForeColor="White"></asp:Label><br />
                                    <br />
                                    <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="Sí" />
                                    <asp:Button ID="ButVolverSinImprimir" runat="server" CssClass="imp" Text="No" />
                                    <br />
                                </span>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="Panel3" runat="server" Height="87px" Visible="false" Width="395px">
                    <table style="" class="t1">
                        <tr>
                            <td align="center" style="font-weight: bold; color: white; background-color: red;
                                height: 14px;">
                                Información
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 37px" align="center">
                                <strong><span style="color: #ffffff">
                                    <br />
                                    El RM no se ha creado correctamente&nbsp;<br />
                                    <br />
                                </span></strong>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="PanelInfo" runat="server" Height="87px" Visible="false" Width="815px">
            <table style="" class="t1">
                <tr>
                    <td align="center" style="font-weight: bold; color: white; background-color: red;
                        height: 14px;">
                        Información
                    </td>
                </tr>
                <tr>
                    <td style="height: 37px" align="center">
                        <strong><span style="color: #ffffff">
                            <br />
                            El RM no se ha creado correctamente&nbsp;<br />
                            <br />
                        </span></strong>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                <asp:Button ID="Button10" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                    display: none" Height="16px" Width="66px" />
                <%--style="visibility:hidden;"/>--%>
                <asp:Panel ID="Panel1" runat="server" Height="119px" Width="221px" BorderColor="Transparent"
                    CssClass="modalPopup" Style="vertical-align: middle; text-align: center" ForeColor="White">
                    <div align="center">
                        Ingrese usuario y password
                        <br />
                        <br />
                        <asp:DropDownList ID="cmbLibero" runat="server" CssClass="CssCombo">
                        </asp:DropDownList>
                        <br />
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                            Width="177px"></asp:TextBox><br />
                        <br />
                        <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False" />
                        <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtender4" runat="server" TargetControlID="Button10"
                    PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="btnOk"
                    DropShadow="false" CancelControlID="btnCancelarLibero">
                </cc1:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanelAnulacion" runat="server">
            <ContentTemplate>
                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                    display: none" Height="16px" Width="66px" />
                <%--style="visibility:hidden;"/>--%>
                <asp:Panel ID="Panel5" runat="server" Height="172px" Style="vertical-align: middle;
                    text-align: center" Width="220px" BorderColor="Transparent" ForeColor="White"
                    CssClass="modalPopup">
                    <div align="center" style="height: 170px; width: 30%">
                        Ingrese usuario, password y motivo
                        <br />
                        <br />
                        <asp:DropDownList ID="cmbUsuarioAnulo" runat="server" CssClass="CssCombo" />
                        <br />
                        <asp:TextBox ID="txtAnularPassword" runat="server" TextMode="Password" CssClass="CssTextBox"></asp:TextBox><br />
                        <div align="center">
                            <asp:TextBox ID="txtAnularMotivo" runat="server" CssClass="CssTextBox" Height="49px"
                                Width="174px" Style="text-align: center;" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAnularMotivo"
                            ErrorMessage="* Ingrese motivo" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                            ValidationGroup="Anulacion" Enabled="true" />
                        <br />
                        <asp:Button ID="btnAnularOk" runat="server" Text="Ok" Width="80px" ValidationGroup="Anulacion" />
                        <asp:Button ID="btnAnularCancel" runat="server" Text="Cancelar" Width="72px" />
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupAnular" runat="server" TargetControlID="Button7"
                    PopupControlID="Panel5" BackgroundCssClass="modalBackground" OkControlID="" DropShadow="false"
                    CancelControlID="btnAnularCancel">
                    <%-- OkControlID se lo saqué porque no estaba llamando al codigo del servidor--%>
                </cc1:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--style="visibility:hidden;"/>--%>

        <script type="text/javascript">

            function fnClickOK(sender, e) {
                __doPostBack(sender, e)
            }
        </script>

        <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
        <%--style="visibility:hidden;"/>--%>
        <asp:TextBox ID="TextBox1" runat="server" Width="48px" Enabled="False" Visible="False"
            Height="27px"></asp:TextBox>
    </div>
</asp:Content>
