<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Cliente.aspx.vb" Inherits="ClienteABM" Title="Cliente" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">


        function OnChanged(sender, args) {
            sender.get_clientStateField().value = sender.saveClientState();
        }
    </script>




    <div class="container" style="overflow: hidden; margin: 0">
        <br />
        <table class="col-md-12" style="padding: 0px; border: none; width: ; margin-right: 0px; color: White"
            cellpadding="1" cellspacing="1">
            <tr>
                <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; font-size: large; height: 34px;"
                    align="left" valign="top">CLIENTE
                    <asp:Label ID="nombrecli" runat="server"></asp:Label>
                    <asp:Label ID="lblAnulado0" runat="server" BackColor="#CC3300" BorderColor="White"
                        BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                        Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                        Visible="False" Width="120px"></asp:Label>
                </td>
                <td class="EncabezadoCell" style="height: 34px;" valign="top" align="right" colspan="3">
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                            <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                Visible="true"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>



        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
            <ContentTemplate>
                <cc1:TabContainer ID="TabContainer1" runat="server" OnClientActiveTabChanged="OnChanged"
                    ActiveTabIndex="0" Height="" BackColor="#6699FF" Width="" CssClass="NewsTab">
                    <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="TabPanel1">
                        <ContentTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Width="40px" Visible="False"></asp:TextBox>
                            <div style="text-align: left">
                                <table class="col-md-12" style="padding: 0px; border: none #FFFFFF; width: ; height: 202px; margin-right: 5px; margin-top: 5px"
                                    cellpadding="1" cellspacing="1">
                                    <tr class="">
                                        <td class="col-md-7">
                                            <table>
                                                <tr class="col-md-12">
                                                    <td>
                                                        <asp:LinkButton ID="butVerLog" Text="Historial" runat="server" CausesValidation="false" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnImprimiSobreChicoXML" runat="server" Text="Sobre chico" class="btn  btn-link pull-right"
                                                            UseSubmitBehavior="False" />
                                                        <asp:Button ID="btnImprimiSobreGrandeXML" runat="server" Text="Sobre mediano" class="btn  btn-link pull-right" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                </tr>
                                                <tr class="col-md-12">
                                                    <td class="EncabezadoCell" style="">Codigo
                                                    </td>
                                                    <td class="EncabezadoCell" style="">
                                                        <asp:TextBox ID="txtCodigoEmpresa" runat="server" Width=""></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoEmpresa"
                                                            ErrorMessage="Ingrese un código" Font-Size="Small" Font-Bold="True" ValidationGroup="Encabezado"
                                                            Style="display: none"></asp:RequiredFieldValidator>
                                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                                                            Enabled="True" TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px; height: 21px">Razon social
                                                    </td>
                                                    <td style="height: 21px">
                                                        <asp:TextBox ID="txtRazonSocial" runat="server" Width="300px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtRazonSocial"
                                                            ErrorMessage="Ingrese una Razon social" Font-Size="Small" ForeColor="#FF3300"
                                                            Font-Bold="True" ValidationGroup="Encabezado" Style="display: none"></asp:RequiredFieldValidator>
                                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                                                            Enabled="True" TargetControlID="RequiredFieldValidator2" CssClass="CustomValidatorCalloutStyle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px; height: 21px">Nombre comercial
                                                    </td>
                                                    <td colspan="3" style="height: 21px">
                                                        <asp:TextBox ID="txtNombreFantasia" runat="server" Width="408px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px; height: 21px">Direccion
                                                    </td>
                                                    <td colspan="3" style="height: 21px">
                                                        <asp:TextBox ID="txtDireccion" runat="server" Width="408px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px">Localidad
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLocalidad" runat="server" Width="180px" TabIndex="19" autocomplete="off"
                                                            AutoCompleteType="None"></asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender7"
                                                                runat="server" CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1"
                                                                FirstRowSelected="true" ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx"
                                                                TargetControlID="txtLocalidad" UseContextKey="true" CompletionListCssClass="AutoCompleteScroll"
                                                                CompletionInterval="100">
                                                            </cc1:AutoCompleteExtender>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocalidad"
                                                            ErrorMessage="Ingrese una localidad" Font-Size="Small" Font-Bold="True" ValidationGroup="Encabezado"
                                                            Style="display: none"></asp:RequiredFieldValidator>
                                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                                                            Enabled="True" TargetControlID="RequiredFieldValidator3" CssClass="CustomValidatorCalloutStyle" />
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 100px">Codigo postal
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 156px">
                                                        <asp:TextBox ID="txtCodigoPostal" runat="server" Width="96px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px">
                                                        <asp:Label ID="lblMailFacturaElectronica" runat="server" Width="96px"> EMail Factura Electronica</asp:Label>
                                                    </td>
                                                    <td class="EncabezadoCell" colspan="3">
                                                        <asp:TextBox ID="txtMailFacturaElectronica" runat="server" Width="252px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 100px">Autorizador Syngenta
                                                    </td>
                                                    <td class="EncabezadoCell" colspan="3">
                                                        <asp:TextBox ID="txtAutorizadorSyngenta" runat="server" Width="252px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px">Provincia
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 200px">
                                                        <asp:DropDownList ID="cmbProvincia" runat="server" Width="152px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 100px">Pais
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 156px">
                                                        <asp:DropDownList ID="cmbPais" runat="server" Width="152px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EncabezadoCell" style="width: 131px">Condicion IVA
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 200px">
                                                        <asp:DropDownList ID="cmbCondicionIVA" runat="server" Width="152px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 100px">CUIT
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 156px">
                                                        <asp:TextBox ID="txtCUIT" runat="server" Width="120px"></asp:TextBox>
                                                        <cc1:MaskedEditExtender TargetControlID="txtCUIT" ID="ext" runat="server" Mask="99C99999999C9"
                                                            Filtered="-" />
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 131px; visibility: hidden">Eventual
                                                    </td>
                                                    <td class="EncabezadoCell" style="width: 200px; visibility: hidden">
                                                        <asp:CheckBox ID="chkEventual" runat="server" Text="" TextAlign="Left" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="col-md-4">
                                            <div class="">
                                                --------------------- BA - SA - AS - BB ----
                                                <br />
                                                --------------------------------------------
                                                <br />
                                                <div class="col-md-12">
                                                    Facturar cuando esté como:
                                                </div>
                                                <br />
                                                <div class="col-md-6">
                                                    Titular
                                                </div>
                                                <asp:CheckBox ID="chkComoTitular" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoTitular2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoTitular3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoTitular4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Intermediario
                                                </div>
                                                <asp:CheckBox ID="chkComoIntermediario" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoIntermediario2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoIntermediario3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoIntermediario4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Rem Comercial
                                                </div>
                                                <asp:CheckBox ID="chkComoRComercial" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoRComercial2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoRComercial3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoRComercial4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Corredor
                                                </div>
                                                <asp:CheckBox ID="chkComoCorredor" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoCorredor2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoCorredor3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoCorredor4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Destinatario Local
                                                </div>
                                                <asp:CheckBox ID="chkComoDestinatarioLocal" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioLocal2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioLocal3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioLocal4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Destinatatio Exp.
                                                </div>
                                                <asp:CheckBox ID="chkComoDestinatarioExportador" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioExportador2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioExportador3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoDestinatarioExportador4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                <div class="col-md-6">
                                                    Cliente Obs.
                                                </div>
                                                <asp:CheckBox ID="chkComoClienteAuxiliar" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoClienteAuxiliar2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoClienteAuxiliar3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkComoClienteAuxiliar4" runat="server" Text="" TextAlign="right" />
                                                <br />
                                                ---------------------------------------------
                                                <br />
                                                <div class="col-md-6">
                                                    A su corredor
                                                </div>
                                                <asp:CheckBox ID="chkDerivarleSuFacturaAlCorredorDeLaCarta" runat="server" />
                                                <asp:CheckBox ID="chkDerivarleSuFacturaAlCorredorDeLaCarta2" runat="server" />
                                                <asp:CheckBox ID="chkDerivarleSuFacturaAlCorredorDeLaCarta3" runat="server" />
                                                <asp:CheckBox ID="chkDerivarleSuFacturaAlCorredorDeLaCarta4" runat="server" />
                                                <br />
                                                <br />
                                                <div class="col-md-6">
                                                    Es Entregador?
                                                </div>
                                                <asp:CheckBox ID="chkEsEntregador" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkEsEntregador2" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkEsEntregador3" runat="server" Text="" TextAlign="right" />
                                                <asp:CheckBox ID="chkEsEntregador4" runat="server" Text="" TextAlign="right" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table class="col-md-12" style="padding: 0px; border: none #FFFFFF; width: ; height: 202px; margin-right: 5px; margin-top: 5px"
                                    cellpadding="1" cellspacing="1">
                                    <tr class="">
                                        <tr>
                                            <td colspan="4">
                                                <br />
                                                <strong>Datos de correos</strong>
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px; height: 21px">Direccion
                                            </td>
                                            <td colspan="3" style="height: 21px">
                                                <asp:TextBox ID="txtDireccionDeCorreos" runat="server" Width="408px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Localidad
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLocalidadDeCorreos" runat="server" Width="180px" TabIndex="19"
                                                    autocomplete="off" AutoCompleteType="None"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                                    EnableCaching="true" MinimumPrefixLength="1" FirstRowSelected="true" ServiceMethod="GetCompletionList"
                                                    ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtLocalidadDeCorreos"
                                                    UseContextKey="true" CompletionListCssClass="AutoCompleteScroll" CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px">Codigo postal
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px">
                                                <asp:TextBox ID="txtCodigoPostalDeCorreos" runat="server" Width="96px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Provincia
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:DropDownList ID="cmbProvinciaDeCorreos" runat="server" Width="152px">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px">Observaciones
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px">
                                                <asp:TextBox ID="txtObservacionesDeCorreos" runat="server" Width="150px" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                            <br />
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <br />
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Adjunto de facturacion
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DropDownList7" runat="server" Width="200px" Style="margin-left: 5px">
                                                    <asp:ListItem>SIN ENVIO</asp:ListItem>
                                                    <asp:ListItem>TEXTO A4</asp:ListItem>
                                                    <asp:ListItem Selected="True" >EXCEL ORIGINAL</asp:ListItem>
                                                    <asp:ListItem>EXCEL LISTADO GENERAL</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">Cond.Compra Std.
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:DropDownList ID="cmbCondicionCompra" runat="server" Width="152px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 100px">Lista de Precios
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px" colspan="3">
                                                <asp:DropDownList ID="cmbListaDePrecios" runat="server" Width="408px">
                                                </asp:DropDownList>
                                                <asp:LinkButton ID="lnkEditarListaPrecio" runat="server">Editar</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Cuenta contable
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:TextBox ID="txtAutocompleteCuenta" runat="server" autocomplete="off" CssClass="CssTextBox"
                                                    AutoPostBack="True"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceCuentas.asmx"
                                                    TargetControlID="txtAutocompleteCuenta" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                                </cc1:AutoCompleteExtender>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px">Moneda Std.
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px">
                                                <asp:DropDownList ID="cmbMoneda" runat="server" Width="152px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Telefono(s)
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:TextBox ID="txtTelefono1" runat="server" Width="144px" MaxLength="30"></asp:TextBox>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px">Fax
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px">
                                                <asp:TextBox ID="txtFax" runat="server" Width="144px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Email
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:TextBox ID="txtEmail" runat="server" Width="144px"></asp:TextBox>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px">Pagina Web
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px">
                                                <asp:TextBox ID="txtPaginaWeb" runat="server" Width="144px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:Label ID="Label1" runat="server" Text="Separarle en facturas aparte estos clientes o corredores"
                                                    ToolTip="Al facturar, separar sus corredores que contengan (expresion regular, separar con |)"></asp:Label>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px" colspan="3">
                                                <asp:TextBox ID="txtAutoCompleteCorredor" runat="server" autocomplete="off" Width="180px"
                                                    TabIndex="9" AutoPostBack="True"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" CompletionSetCount="12"
                                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                                    TargetControlID="txtAutoCompleteCorredor" UseContextKey="True" FirstRowSelected="True"
                                                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                                                    CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TBWE1" runat="server" TargetControlID="txtAutoCompleteCorredor"
                                                    WatermarkText="buscar cliente/corredor" WatermarkCssClass="watermarked" />
                                                <br />
                                                <asp:TextBox ID="TextBox4" runat="server" Width="400px" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <asp:Button ID="btnVaciarCorredoresSeparados" runat="server" Text="x" ToolTip="Vaciar separados" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Exige 'Carta de Porte' completa
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:CheckBox ID="chkExigirValidacionCompletaDeCartaDePorte" runat="server" Text=""
                                                    TextAlign="Left" />
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">Incluye tarifa en factura
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:CheckBox ID="chkIncluyeTarifaEnFactura" runat="server" Text="" TextAlign="Left" />
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">Habilitado
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px">
                                                <asp:CheckBox ID="chkHabilitadoParaCartaPorte" runat="server" Text="" Checked="true"
                                                    TextAlign="Left" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Es acondicionadora?
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:CheckBox ID="chkEsAcondicionadora" runat="server" Text="" TextAlign="right" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Es exportador?
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:CheckBox ID="chkEsExportador" runat="server" Text="" TextAlign="right" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">Se le cobran gastos administrativos?
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:CheckBox ID="chkUsaGastosAdmin" runat="server" Text="" TextAlign="right"   data-icon1="SI" data-icon2="NO" />
                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:Label ID="lblHabilitadoCobranzas" runat="server" Width="96px">Habilitado por Cobranzas?</asp:Label>
                                                
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:CheckBox ID="chkHabilitadoCobranzas" runat="server" Text=""  Checked="true"
                                                     TextAlign="right"   data-icon1="SI" data-icon2="NO"  />
                                            
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:Label ID="Label2" runat="server" Width="96px">Circuito de facturación de ClienteObservaciones</asp:Label>
                                                
                                            </td>
                                            <td class="EncabezadoCell" style="width: 131px">
                                                <asp:CheckBox ID="chkClienteObservacionesFacturadoComoCorredor" runat="server" Text=""  Checked="false"
                                                     TextAlign="right"   data-icon1="SI" data-icon2="NO"  />
                                            
                                            </td>
                                        </tr>


                                        <tr style="visibility: hidden; display: none;">
                                            <td class="EncabezadoCell" style="width: 131px; height: 47px;">Provee
                                            </td>
                                            <td class="EncabezadoCell" style="width: 200px; height: 47px;">
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                    TextAlign="Left">
                                                    <asp:ListItem Value="B">Bienes</asp:ListItem>
                                                    <asp:ListItem Value="S">Servicios</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td class="EncabezadoCell" style="width: 100px; height: 47px;">Calificacion
                                            </td>
                                            <td class="EncabezadoCell" style="width: 156px; height: 47px;">
                                                <asp:TextBox ID="txtCalificacion" runat="server" Width="24px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="EncabezadoCell" style="width: 131px"></td>
                                            <td colspan="3">&nbsp;
                                            </td>
                                        </tr>
                                </table>
                            </div>
                            <br />
                            &nbsp;&nbsp;
                        </ContentTemplate>
                        <HeaderTemplate>
                            Datos generales
                        </HeaderTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                        <HeaderTemplate>
                            Retenciones
                        </HeaderTemplate>
                        <ContentTemplate>
                            <table style="width: 690px">
                                <%--<tr>
                                <td align="center" bgcolor="#ffffff" colspan="4" style="height: 21px; color: #000000;">
                                    <strong>Ingresos Brutos </strong>
                                </td>
                            </tr>
                                --%><tr>
                                    <td>
                                        <strong>Ingresos Brutos </strong>
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 187px">Condición
                                    </td>
                                    <td class="EncabezadoCell" style="width: 161px">
                                        <asp:RadioButtonList ID="RadioButtonList3" runat="server" AutoPostBack="True">
                                            <asp:ListItem Value="1">Exento</asp:ListItem>
                                            <asp:ListItem Value="3">Inscripto</asp:ListItem>
                                            <asp:ListItem Value="2">Inscripto Conv.Mult.</asp:ListItem>
                                            <asp:ListItem Value="4">No Alcanzado</asp:ListItem>
                                            <asp:ListItem Value="5">No Inscripto</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 187px">Numero de inscripcion
                                    </td>
                                    <td colspan="2" style="width: 234px">
                                        <asp:TextBox ID="txtIBNumeroInscripcion" runat="server" Width="152px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 187px">Categoria p/defecto 1
                                    </td>
                                    <td colspan="2" style="width: 234px">
                                        <asp:DropDownList ID="cmbCategoriaIIBB" runat="server" Width="264px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 187px">Categoria p/defecto 2
                                    </td>
                                    <td colspan="2" style="width: 234px">
                                        <asp:DropDownList ID="DropDownList4" runat="server" Width="264px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 187px">Categoria p/defecto 3
                                    </td>
                                    <td colspan="2" style="width: 234px">
                                        <asp:DropDownList ID="DropDownList5" runat="server" Width="264px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr visible="false">
                                    <td class="EncabezadoCell" style="width: 187px">% IB directo:
                                    </td>
                                    <td class="EncabezadoCell" style="width: 137px">
                                        <asp:TextBox ID="txtIBDdirecto" runat="server" Width="40px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 140px">Grupo
                                    </td>
                                    <td class="EncabezadoCell" style="width: 270px">
                                        <asp:TextBox runat="server" Width="40px" ID="txtGrupoIB"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 187px">Fecha inic.vigencia
                                    </td>
                                    <td class="EncabezadoCell" style="width: 190px">
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
                                    <td class="EncabezadoCell" style="width: 18px">Fecha fin vigencia
                                    </td>
                                    <td class="EncabezadoCell" style="width: 65px">
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
                            <table width="100%" style="height: 118px">
                                <%--<tr>
                                <td align="center" bgcolor="#ffffff" colspan="4" style="height: 21px; color: #000000;">
                                    <strong>Percepcion IVA </strong>
                                </td>
                            </tr>--%>
                                <tr>
                                    <td>
                                        <hr />
                                        <strong>Percepcion IVA </strong>
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 131px" colspan="2">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="El cliente es agente de retencion IVA:"
                                            TextAlign="Left" />
                                    </td>
                                    <td class="EncabezadoCell" style="width: 147px">Base minima para calcular percepcion
                                    </td>
                                    <td class="EncabezadoCell" style="width: 186px">
                                        <asp:TextBox ID="txtBaseMinima" runat="server" Width="112px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 231px">Porcentaje a aplicar
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtPorcentajeAplicar" runat="server" Width="49px" Height="21px"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                <td align="center" bgcolor="#ffffff" colspan="4" style="height: 21px; color: #000000;">
                                    <strong>Impuesto a las ganancias</strong>
                                </td>

                            </tr>--%>
                                <tr>
                                    <td>
                                        <strong>Impuesto a las ganancias</strong>
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 131px">Condicion ganancias
                                    </td>
                                    <td colspan="2">
                                        <asp:DropDownList ID="DropDownList6" runat="server" Width="264px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel5" runat="server" HeaderText="TabPanel5" Visible="false">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td colspan="4">&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 234px; height: 24px">Numero de inscripcion
                                    </td>
                                    <td class="EncabezadoCell" style="height: 24px" colspan="3">
                                        <asp:TextBox ID="TextBox2" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 234px; height: 67px;">Denominacion inscripcion
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TextBox3" runat="server" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 234px"></td>
                                    <td class="EncabezadoCell" style="width: 92px"></td>
                                    <td class="EncabezadoCell" style="width: 105px"></td>
                                    <td class="EncabezadoCell" style="width: 103px"></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <HeaderTemplate>
                            Exportaciones
                        </HeaderTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel6" runat="server" HeaderText="TabPanel6" Visible="false">
                        <ContentTemplate>
                            <table style="visibility: hidden; display: none;">
                                <tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Exceptuado 100%" TextAlign="Left"
                                            AutoPostBack="True" />
                                    </td>
                                    <td class="EncabezadoCell" style="width: 114px"></td>
                                    <td class="EncabezadoCell" style="width: 222px"></td>
                                </tr>
                                <tr>
                                    <td colspan="2">% de excepcion
                                    </td>
                                    <td class="EncabezadoCell" style="width: 114px">
                                        <asp:TextBox ID="txtIvaPorcentajeExencion" runat="server" Width="40px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 222px"></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Fecha vencimiento excepcion
                                    </td>
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
                                    <td colspan="2">Cod.situacion retencion IVA
                                    </td>
                                    <td class="EncabezadoCell" style="width: 114px">
                                        <asp:TextBox ID="txtCodigoSituacionRetencionIVA" runat="server" Width="16px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 222px"></td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px"></td>
                                    <td class="EncabezadoCell" style="width: 100px"></td>
                                    <td class="EncabezadoCell" style="width: 114px"></td>
                                    <td class="EncabezadoCell" style="width: 222px"></td>
                                </tr>
                            </table>
                            <br />
                            <table>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 252px">Cuentas contables para operaciones en pesos
                                    </td>
                                    <td class="EncabezadoCell" style="width: 286px">
                                        <asp:DropDownList ID="DropDownList2" runat="server" Width="152px">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 14px" class="style5"></td>
                                    <td class="EncabezadoCell" style="width: 254px"></td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 252px">Cuentas contables para operaciones en moneda extranjera
                                    </td>
                                    <td class="EncabezadoCell" style="width: 286px">
                                        <asp:DropDownList ID="DropDownList1" runat="server" Width="152px">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 14px" class="style5"></td>
                                    <td class="EncabezadoCell" style="width: 254px"></td>
                                </tr>
                                <tr>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 252px">Informacion para servicios de cobranza bancaria<br />
                                    </td>
                                    <td class="EncabezadoCell" style="width: 286px" colspan="3">
                                        <asp:CheckBox ID="chkDebitoBancario" runat="server" Text="Activar débito bancario" />
                                        <br />
                                        Banco
                                        <asp:DropDownList ID="DropDownList3" runat="server" Width="152px" Style="margin-left: 5px">
                                        </asp:DropDownList>
                                        <br />
                                        CBU
                                        <asp:TextBox ID="txtCBU" runat="server" Width="167px" Style="margin-left: 14px" Height="21px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 252px">&nbsp;
                                    </td>
                                    <td class="EncabezadoCell" style="width: 286px"></td>
                                    <td class="EncabezadoCell" style="width: 14px" class="style5"></td>
                                    <td class="EncabezadoCell" style="width: 254px"></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <HeaderTemplate>
                            Datos contables
                        </HeaderTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel4" runat="server" HeaderText="TabPanel4" Visible="false">
                        <HeaderTemplate>
                            Lugares de Entrega
                        </HeaderTemplate>
                        <ContentTemplate>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel8" runat="server" HeaderText="TabPanel8" Visible="false">
                        <HeaderTemplate>
                            Contactos
                        </HeaderTemplate>
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td colspan="2">Contacto principal
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtContactoPrincipal" runat="server" Width="408px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4"></td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="height: 22px" colspan="4">
                                        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF"
                                            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AutoGenerateColumns="False">
                                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                            <AlternatingRowStyle BackColor="#F7F7F7" />
                                            <Columns>
                                                <asp:BoundField DataField="Id" HeaderText="Id" />
                                                <asp:BoundField DataField="Contacto" HeaderText="Contacto">
                                                    <ItemStyle Wrap="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Puesto" HeaderText="Puesto">
                                                    <ItemStyle Wrap="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Telefono" HeaderText="Telefono">
                                                    <ItemStyle Wrap="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Email" HeaderText="Email">
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
                                                <asp:ButtonField ButtonType="Button" CommandName="Eliminar" Text="Eliminar">
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
                                                <td class="EncabezadoCell" style="width: 100px">
                                                    <asp:Label ID="lblContacto" runat="server" Text="Contacto :"></asp:Label>
                                                </td>
                                                <td class="EncabezadoCell" style="width: 401px">
                                                    <asp:TextBox ID="txtContacto" runat="server" Width="384px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="EncabezadoCell" style="width: 100px">
                                                    <asp:Label ID="lblPuesto" runat="server" Text="Puesto :"></asp:Label>
                                                </td>
                                                <td class="EncabezadoCell" style="width: 401px">
                                                    <asp:TextBox ID="txtContactoPuesto" runat="server" Width="384px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="EncabezadoCell" style="width: 100px; height: 26px">
                                                    <asp:Label ID="lblTelefono" runat="server" Text="Telefono :"></asp:Label>
                                                </td>
                                                <td class="EncabezadoCell" style="width: 401px; height: 26px">
                                                    <asp:TextBox ID="txtContactoTelefono" runat="server" Width="384px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="EncabezadoCell" style="width: 100px">
                                                    <asp:Label ID="lblEmail" runat="server" Text="Email :"></asp:Label>
                                                </td>
                                                <td class="EncabezadoCell" style="width: 401px">
                                                    <asp:TextBox ID="txtContactoEmail" runat="server" Width="384px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnSaveItem" runat="server" Font-Size="XX-Small" OnClick="btnSave_Click"
                                                        Text="Guardar item" UseSubmitBehavior="False" /><asp:Button ID="btnCancelItem" runat="server"
                                                            CausesValidation="False" Font-Size="XX-Small" OnClick="btnCancel_Click" Text="Cancelar"
                                                            UseSubmitBehavior="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px"></td>
                                    <td class="EncabezadoCell" style="width: 59px"></td>
                                    <td class="EncabezadoCell" style="width: 100px"></td>
                                    <td class="EncabezadoCell" style="width: 297px"></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="TabPanel8" Visible="true">
                        <HeaderTemplate>
                            Auxiliares
                        </HeaderTemplate>
                        <ContentTemplate>
                            <table style="" class="col-md-12">
                                <tr>
                                    <td style="width: " class="col-md-2">Contactos
                                    </td>
                                    <td class="col-md-8" style="width: ">
                                        <asp:TextBox ID="txtContactos" runat="server" Width="100%" Height="150px" TextMode="MultiLine"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" ControlToValidate="txtContactos"
                                            ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Máximo de 400 letras" Display="Dynamic">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: " class="col-md-2">Correos Electronicos
                                    </td>
                                    <td style="width: " class="col-md-8">
                                        <asp:TextBox ID="txtCorreosElectronicos" runat="server" Width="100%" Height="150px"
                                            TextMode="MultiLine"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ControlToValidate="txtCorreosElectronicos"
                                            ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Máximo de 400 letras" Display="Dynamic">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: " class="col-md-2">Telefonos Fijos Oficina
                                    </td>
                                    <td style="width: " class="col-md-8">
                                        <asp:TextBox ID="txtTelefonosFijosOficina" runat="server" Width="100%" Height="150px"
                                            TextMode="MultiLine"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ID="valInput" ControlToValidate="txtTelefonosFijosOficina"
                                            ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Máximo de 400 letras" Display="Dynamic">*</asp:RegularExpressionValidator>
                                        <script type="text/javascript">
                                            $(document).ready(function () {
                                                //$("textarea [id$='txtTelefonosFijosOficina']").maxLength(100);


                                                function maximo(e) {
                                                    //alert("aaa");
                                                    //list of functional/control keys that you want to allow always
                                                    var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];

                                                    if ($.inArray(e.keyCode, keys) == -1) {
                                                        //if (checkMaxLength(this.innerHTML, 15)) {
                                                        if (checkMaxLength(this.value, 400)) {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            alert("Maximo de 400 letras");
                                                        }
                                                    }
                                                }


                                                $("[id$='ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txtContactos']").keydown(function (e) {

                                                    //alert("aaa");
                                                    //list of functional/control keys that you want to allow always
                                                    var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];

                                                    if ($.inArray(e.keyCode, keys) == -1) {
                                                        //if (checkMaxLength(this.innerHTML, 15)) {
                                                        if (checkMaxLength(this.value, 400)) {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            alert("Maximo de 400 letras");
                                                        }
                                                    }
                                                });

                                                $("[id$='ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txtCorreosElectronicos']").keydown(function (e) {
                                                    //alert("aaa");
                                                    //list of functional/control keys that you want to allow always
                                                    var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];

                                                    if ($.inArray(e.keyCode, keys) == -1) {
                                                        //if (checkMaxLength(this.innerHTML, 15)) {
                                                        if (checkMaxLength(this.value, 400)) {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            alert("Maximo de 400 letras");
                                                        }
                                                    }

                                                });



                                                $("[id$='ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txtTelefonosFijosOficina']").keydown(function (e) {

                                                    //alert("aaa");
                                                    //list of functional/control keys that you want to allow always
                                                    var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];

                                                    if ($.inArray(e.keyCode, keys) == -1) {
                                                        //if (checkMaxLength(this.innerHTML, 15)) {
                                                        if (checkMaxLength(this.value, 400)) {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            alert("Maximo de 400 letras");
                                                        }
                                                    }
                                                });

                                                $("[id$='ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txtTelefonosCelulares']").keydown(function (e) {

                                                    //alert("aaa");
                                                    //list of functional/control keys that you want to allow always
                                                    var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];

                                                    if ($.inArray(e.keyCode, keys) == -1) {
                                                        //if (checkMaxLength(this.innerHTML, 15)) {
                                                        if (checkMaxLength(this.value, 400)) {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            alert("Maximo de 400 letras");
                                                        }
                                                    }
                                                });



                                                function checkMaxLength(text, max) {
                                                    return (text.length >= max);
                                                }
                                            });
                                        </script>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: " class="col-md-2">Telefonos Celulares
                                    </td>
                                    <td style="width: " class="col-md-8">
                                        <asp:TextBox ID="txtTelefonosCelulares" runat="server" Width="100%" Height="150px"
                                            TextMode="MultiLine"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator3" ControlToValidate="txtTelefonosCelulares"
                                            ValidationExpression="^[\s\S]{0,400}$" ErrorMessage="Máximo de 400 letras" Display="Dynamic">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </cc1:TabPanel>
                </cc1:TabContainer>
                <br />
                <br />
                <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <%--  <div valign="bottom" style="position: absolute; bottom: 0 !important; height: 30px; 
        text-align: center;  background-color:White; margin: 10 10 10 0; margin-top: 10px;padding-top: 10px;padding-right: 10px;">--%>
                <asp:Button ID="btnSave" runat="server" ValidationGroup="Encabezado" OnClick="btnSave_Click"
                    Text="Aceptar" UseSubmitBehavior="False" CssClass="but" Style="margin-right: 50px" />
                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" OnClick="btnCancel_Click"
                    Text="Cancelar" UseSubmitBehavior="False" CssClass="butcancela" /><br />
                <%--</div>--%>
                <asp:Label ID="lblLog" Width="1000px" runat="server" ForeColor="white"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br /><br />


    <style>
        label {
            /* font-size: 10pt; */
            font-size: 10pt;
            line-height: 14px;
            font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;
            color: #9C0000 !important;
        }
    </style>





<%--    <style>
        /*http://jodacame.com/cambiar-estilo-checkbox-con-css3-estilo-switch-onoff.html*/


        html {
            font: 62.5%/1 "Lucida Sans Unicode","Lucida Grande",Verdana,Arial,Helvetica,sans-serif;
            background-color: hsl(0,0%,16%);
            background-size: 5px 5px;
            background-image: -webkit-linear-gradient( 90deg, hsla(0,0%,0%,0) 0px, hsla(0,0%,0%,.12) 50%, hsla(0,0%,0%,0) 100% );
        }

        body {
            padding: 50px;
            max-width: 600px;
            margin: 0 auto;
            background-image: -webkit-linear-gradient( 0deg, hsla(0,0%,100%,0) 0px, hsla(0,0%,100%,.03) 50%, hsla(0,0%,100%,0) 100% );
        }

        h1 {
            color: #FFFFFF;
        }

        input[type="checkbox"] {
            -webkit-appearance: none; /* Remove Safari default */
            outline: none;
            width: 120px;
            height: 40px;
            position: relative;
            border-radius: 6px;
            background-color: #000;
            -webkit-background-clip: padding-box;
            border: 0;
            border-bottom: 1px solid transparent;
            -webkit-perspective: 200;
        }

            input[type="checkbox"]:before, input[type="checkbox"]:after {
                font: bold 22px/32px sans-serif;
                text-align: center;
                position: absolute;
                z-index: 1;
                width: 56px;
                height: 30px;
                top: 4px;
                border: 0;
                border-top: 1px solid rgba(255,255,255,0.15);
            }

            input[type="checkbox"]:before {
                content: attr(data-icon1);
                left: 4px;
                border-radius: 3px 0 0 3px;
            }

            input[type="checkbox"]:after {
                content: attr(data-icon2);
                right: 4px;
                border-radius: 0 3px 3px 0;
            }


        /* ----------- checked/unchecked */

        /* unchecked */
        input[type="checkbox"] {
            -webkit-border-image: -webkit-gradient(linear, 100% 0%, 0% 0%, from(rgba(255,255,255,0)), to(rgba(255,255,255,0)), color-stop(.1,rgba(255,255,255,.05)), color-stop(.3,rgba(5,137,200,0.4)), color-stop(.45,rgba(255,255,255,.05)), color-stop(.9,rgba(255,255,255,.1)) )100% 100%;
            background-image: -webkit-gradient( linear, right top, left top, color-stop( 0, hsl(0,0%,0%) ), color-stop( 0.14, hsl(0,0%,50%) ), color-stop( 0.15, hsl(0,0%,0%) ) );
            -webkit-box-shadow: inset #000 -7px 0 1px, inset #000 0 -5px 10px, inset #000 0 3px 3px;
        }

            input[type="checkbox"]:after {
                background-image: -webkit-gradient(linear, 70% top, 40% bottom, from( hsl(0,0%,17%) ),to( hsl(0,0%,12%) ) );
                border-right: 1px solid transparent;
                -webkit-border-image: -webkit-gradient(linear, left bottom, left top, from(rgba(255,255,255,0)), color-stop(.2,rgba(255,255,255,0)), color-stop(.4,rgba(255,255,255,.5)), to(rgba(255,255,255,.05)) )10% 100%;
                -webkit-box-shadow: rgba(0,0,0,.6) 8px 3px 10px;
                -webkit-transform: rotateY(-30deg) scaleX(.9) scaleY(1.1) translateX(-8px);
            }


            /* checked */
            input[type="checkbox"]:checked {
                -webkit-border-image: -webkit-gradient(linear, 0% 0%, 100% 0%, from(rgba(255,255,255,0)), to(rgba(255,255,255,0)), color-stop(.1,rgba(255,255,255,.05)), color-stop(.3,rgba(5,137,200,0.4)), color-stop(.45,rgba(255,255,255,.05)), color-stop(.9,rgba(255,255,255,.1)) )100% 100%;
                background-image: -webkit-gradient( linear, left top, right top, color-stop( 0, hsl(0,0%,0%) ), color-stop( 0.14, hsl(0,0%,50%) ), color-stop( 0.15, hsl(0,0%,0%) ) );
                -webkit-box-shadow: inset #000 7px 0 1px, inset #000 0 -5px 10px, inset #000 0 3px 3px;
            }

                input[type="checkbox"]:checked:before {
                    background-image: -webkit-gradient( linear, 30% top, 60% bottom, from( hsl(0,0%,17%) ),to( hsl(0,0%,12%) ) );
                    border-left: 1px solid transparent;
                    -webkit-border-image: -webkit-gradient(linear, left bottom, left top, from(rgba(255,255,255,0)), color-stop(.2,rgba(255,255,255,0)), color-stop(.4,rgba(255,255,255,.5)), to(rgba(255,255,255,.05)) )10% 100%;
                    -webkit-box-shadow: rgba(0,0,0,.6) -8px 3px 10px;
                    -webkit-transform: rotateY(30deg) scaleX(.9) scaleY(1.1) translateX(8px);
                }


                /* ----------- active/inactve */

                /* Active */
                input[type="checkbox"]:before, input[type="checkbox"]:checked:after {
                    color: hsl(200,100%,50%);
                    text-shadow: rgba(0,0,0,.5) 0 1px 1px, #0589c8 0 0 10px;
                    -webkit-transform: none;
                    background-image: -webkit-gradient( linear, left top, left bottom, from( hsl(0,0%,20%) ), to( hsl(0,0%,15%) ) );
                    -webkit-border-image: none;
                    -webkit-box-shadow: none;
                    z-index: 2;
                    -webkit-box-reflect: below -4px -webkit-gradient(linear, left top, left bottom, from(transparent), color-stop(0.3, transparent), to( rgba(255,255,255,0.2) ));
                }

                /* Inactive */
                input[type="checkbox"]:after, input[type="checkbox"]:checked:before {
                    color: #000;
                    text-shadow: rgba(255,255,255,.1) 0 -1px 0;
                    -webkit-box-reflect: none;
                    z-index: 1;
                }




            /* ----------- hover */

            input[type="checkbox"]:hover {
                cursor: pointer;
            }

                input[type="checkbox"]:hover:before {
                    background-image: -webkit-gradient( linear, left top, left bottom, from( hsl(0,0%,19%) ), to( hsl(0,0%,15%) ) );
                }

                input[type="checkbox"]:hover:after {
                    background-image: -webkit-gradient(linear, 70% top, 40% bottom, from( hsl(0,0%,16%) ),to( hsl(0,0%,11%) ) );
                }

            input[type="checkbox"]:checked:hover:before {
                background-image: -webkit-gradient( linear, 30% top, 60% bottom, from( hsl(0,0%,16%) ),to( hsl(0,0%,12%) ) );
            }

            input[type="checkbox"]:checked:hover:after {
                background-image: -webkit-gradient( linear, left top, left bottom, from( hsl(0,0%,19%) ), to( hsl(0,0%,15%) ) );
            }
    </style>--%>




</asp:Content>



