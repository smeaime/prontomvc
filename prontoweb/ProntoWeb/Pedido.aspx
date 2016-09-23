<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Pedido.aspx.vb" Inherits="PedidoABM" Title="Untitled Page" EnableEventValidation="false" %>

<%--lo del enableeventvalidation lo puse porque tenia un problema con este abm. no copiarlo a los demas abms--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ListBox ID="ListBox1" runat="server" Visible="False"></asp:ListBox>
    --%>
    <script>

        //    $('#txtCodigo').keyup(function (event) {
        //        $('#txtCodigo').textc
        //  if (event.keyCode == 13) {
        //      var message = $('#txtCodigo').val();
        //    alert(message);
        //  } else {
        //    return true;
        //  }
        //}); //endTextMessage keyup
    </script>
    <script type="text/javascript">

        //    stackoverflow.com/questions/11795909/exclude-certain-buttons
        var warnMessage = "Se perderán los cambios hechos al pedido";
        var bSave = false;

        $(document).ready(function () {

            if (window.opener != null) {
                //alert('ocultar menu');
                $('#ctl00_PanelMenu').visible = false;  // si me abren de otra pestaña, oculto el menú de la izquierda
                $('#ctl00_Panel3').visible = false;
                $('#ctl00_PanelMenu').width(0);
            }







            $('input:not(:button,:submit),textarea,select').change(function () {
                window.onbeforeunload = function () {
                    if (warnMessage != null && !bSave) {
                        $('#ctl00_ContentPlaceHolder1_btnSave').removeAttr("disabled");
                        $('#ctl00_ContentPlaceHolder1_btnCancel').removeAttr("disabled");
                        $('#ctl00_ContentPlaceHolder1_btnCancel').click(function (e) {
                            //warnMessage = null;

                        });

                        return warnMessage;
                    }
                    bSave = false;
                }
            });

            $('input:submit').click(function (e) {
                warnMessage = null;
            });


            $('#ctl00_ContentPlaceHolder1_btnCancel').click(function (e) {
                //warnMessage = null;

            });

            $('#ctl00_ContentPlaceHolder1_btnSave').click(function (e) {
                //alert('sss');
                warnMessage = null;
                bSave = true;
            });




        });
    </script>
    <div class="EncabezadoComprobante">
        <asp:UpdatePanel ID="UpdatePanel22" runat="server" UpdateMode="always">
            <ContentTemplate>
                <table style="padding: 0px; border: none; width: 696px; height: 202px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="3" style="border: thin none; font-weight: bold; font-size: large;" align="left"
                            valign="top">
                            PEDIDO
                            <asp:TextBox ID="TextBox1" runat="server" Width="49px" Enabled="False" Visible="False"
                                Height="16px"></asp:TextBox>
                        </td>
                        <td style="height: 37px;" valign="top" align="right">
                            <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="" BorderStyle="Solid"
                                BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="" Style="text-align: center;
                                margin-left: 0px; vertical-align: top" Text=" ANULADO " Visible="False" Width="120px"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" alt="" />
                                    <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor=""
                                        Visible="true"></asp:Label>
                                    <%--            <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
                                    --%></ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            <asp:Label ID="Label21" runat="server" Text="Número" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell " style="width: 220px">
                            <asp:TextBox ID="txtNumeroPedido" runat="server" Width="56px"></asp:TextBox>
                            <asp:TextBox ID="txtSubnumeroPedido" runat="server" Width="30px"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            <asp:Label ID="Label5" runat="server" Text="Fecha" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtFechaPedido" runat="server" Width="72px" MaxLength="1"></asp:TextBox>&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaPedido">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtFechaPedido">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            <asp:Label ID="Label1" runat="server" Text="Proveedor" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell" colspan="3">
                            <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtDescArt" runat="server" autocomplete="off" AutoCompleteType="None"
                                        Width="507px" OnTextChanged="btnTraerDatos_Click" AutoPostBack="True"></asp:TextBox>
                                    <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceProveedores.asmx"
                                        TargetControlID="txtDescArt" UseContextKey="true" CompletionListCssClass="AutoCompleteScroll"
                                        FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True"
                                        OnClientItemSelected="SetSelectedValue" EnableCaching="true">
                                        <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                                        <%--                    
                        <Animations>
                            <OnHide>
                               <ScriptAction Script="ClearHiddenIDField()" />  
                            </OnHide>
                        </Animations>
                                        --%>
                                    </cc1:AutoCompleteExtender>
                                    <input id="SelectedReceiver" runat="server" type="hidden" />
                                    <%--el hidden que guarda el id--%>
                                    <asp:Button ID="btnTraerDatos" runat="server" Text="YA" Width="30px" Height="22px"
                                        CausesValidation="False" Style="visibility: hidden;" />
                                    <%--el que trae los datos del proveedor--%>
                                    <script type="text/javascript">

                                        function SetSelectedValue(source, eventArgs) {
                                            //en eventArgs le pasan el get_text y el get_value
                                            //en la linea siguiente pego el ID en el control <input> hidden
                                            var a = eventArgs.get_value();
                                            var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedReceiver');

                                            //comento esta linea pues el proveedor no tiene codigo.... -podrías traer el CUIT... 
                                            //-uf,tambien podría traer la condicion de IVA...
                                            //var cod = document.getElementById('ctl00_ContentPlaceHolder1_txtCodigo');

                                            var s = new Array();


                                            s = a.split('^');

                                            id.value = s[0]; //le aviso a clearhidden que no me pise el dato
                                            //id.value = id.value + ' Che_ClearHiddenIDField_esto_es_nuevo'; //le aviso a clearhidden que no me pise el dato
                                            //cod.value = s[1];

                                            ///////////////////////////////
                                            //deshabilitar el cuit y la condicion .....
                                            //document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = true;
                                            //document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = true;
                                            //                            //.... , y llenarlos (debiera llamar al server?)
                                            ///////////////////////////////

                                            // opcional: fuerzo click al "go button (http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106)
                                            // si el boton no está visible, getElementById devuelve null 
                                            //var but = document.getElementById('ctl00_ContentPlaceHolder1_btnTraerDatos');
                                            //but.click(); // .onclick();

                                            //alert(a);
                                            //alert(b.value);
                                        }

                                    </script>
                                    <%--                
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
                    FIN DE TEXTBOX+AUTOCOMPLETE
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
                                    --%>
                                    <%-- aSDFASDFASDFASDF --%>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDescArt"
                                        ErrorMessage="* Ingrese Proveedor" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none;" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender6" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator7" CssClass="CustomValidatorCalloutStyle" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td colspan="3">
                            <asp:Label ID="txtDatosProveedor" runat="server" CssClass="EncabezadoTexto" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            <asp:Label ID="Label2" runat="server" Text="Cond. Compra" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:DropDownList ID="cmbCondicionCompra" runat="server" CssClass="CssCombo" AutoPostBack=true>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="cmbCondicionCompra"
                                ErrorMessage="* Ingrese la condicion de compra" Font-Size="Small" ForeColor="#FF3300"
                                Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none" />
                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" Enabled="True"
                                TargetControlID="RequiredFieldValidator12" CssClass="CustomValidatorCalloutStyle" />
                            &nbsp;
                        </td>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            <asp:Label ID="Label4" runat="server" Text="Liberó" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtLibero" runat="server" Enabled="False" CssClass="CssTextBox"></asp:TextBox>
                            <asp:LinkButton ID="btnLiberar" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="Blue" Font-Size="Small" Height="16px" Width="51px" ValidationGroup="Encabezado">Liberar</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell">
                            Aclaración de condición de compra
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtAclaracionDeCondicionDeCompra" runat="server" TextMode="MultiLine"
                                Height="42px" CssClass="CssTextBox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            <asp:Label ID="Label10" runat="server" Text="Comparativa" CssClass="EncabezadoTexto" />
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:DropDownList ID="cmbComparativas" runat="server" CssClass="CssCombo" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:Label ID="lblErrorComparativa" runat="server" Font-Size="X-Small"></asp:Label>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Contacto
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtContacto" runat="server" CssClass="CssTextBox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            Comprador
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:DropDownList ID="cmbComprador" runat="server" CssClass="CssCombo" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                        </td>
                        <td class="EncabezadoCell">
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            Email comprador
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:Label ID="txtMailComprador" runat="server" CssClass="CssTextBox" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Tel
                        </td>
                        <td class="EncabezadoCell">
                            <asp:Label ID="txtTelefonoComprador" runat="server" CssClass="CssTextBox" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            Licitación
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:TextBox ID="txtLicitacion" runat="server" CssClass="CssTextBox"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Pedido abierto
                        </td>
                        <td class="EncabezadoCell">
                            <asp:DropDownList ID="cmbPedidoAbierto" runat="server" CssClass="CssCombo">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            Moneda
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:DropDownList ID="cmbMoneda" runat="server" CssClass="CssCombo">
                            </asp:DropDownList>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Subcontrato
                        </td>
                        <td class="EncabezadoCell">
                            <asp:DropDownList ID="cmbSubcontrato" runat="server" CssClass="CssCombo">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            Conv. Pesos
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:TextBox ID="txtConversionPesos" runat="server" CssClass="CssTextBox"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Cotiz Dólar
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtCotizacionDolar" runat="server" CssClass="CssTextBox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell">
                            Observaciones
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Height="42px"
                                CssClass="CssTextBox"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell">
                            Tipo de compra
                        </td>
                        <td class="EncabezadoCell">
                            <asp:DropDownList ID="cmbTipoCompra" runat="server" CssClass="CssCombo" Visible="true">
                                <asp:ListItem Value="1">Gestion por compra</asp:ListItem>
                                <asp:ListItem Value="2">Gestion por terceros</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 30px;">
                            Autorizaciones
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 30px;">
                            <asp:CheckBox ID="chkFirma0" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="true" Height="16px" Width="16" Enabled="False" />
                            <asp:CheckBox ID="chkFirma1" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="False" Height="16px" Width="16" Enabled="False" />
                            <asp:CheckBox ID="chkFirma2" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="False" Height="16px" Width="16" Enabled="False" />
                            <asp:CheckBox ID="chkFirma3" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="False" Height="16px" Width="16" Enabled="False" />
                            <asp:CheckBox ID="chkFirma4" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="False" Height="16px" Width="16" Enabled="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px">
                            &nbsp;
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; display: none;">
                            &nbsp;
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            &nbsp;
                        </td>
                        <td class="EncabezadoCell">
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <%--boton que dispara la actualizacion de la grilla--%>
                <asp:LinkButton ID="LinkButton7" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="False" Font-Size="Small" Height="20px" BorderStyle="None"
                    Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                    BorderWidth="5px" Width="127px">datos adicionales</asp:LinkButton>
                <asp:Panel ID="Panel4" runat="server" Height="94px" Width="690px">
                    <table style="padding: 0px; border: none; width: 684px; height: 53px; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                            </td>
                            <td class="EncabezadoCell" style="width: 220px">
                            </td>
                            <td class="EncabezadoCell" style="width: 90px">
                            </td>
                            <td class="EncabezadoCell">
                                Imprime?
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                00 - Importante
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtImportante" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkImportante" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                01 - Plazo de entrega
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtPlazoEntrega" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkPlazoEntrega" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                02 - Lugar de entrega
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtLugarEntrega" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkLugarEntrega" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                03 - Forma de pago
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtFormaPago" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkFormaPago" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                04 - Imputación contable
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtImputacionContable" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkImputacionContable" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                05 - Inspecciones
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtInspecciones" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkInspecciones" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                06 - Garantía
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtGarantia" runat="server" TextMode="MultiLine" Height="42px" Width="400"
                                    CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkGarantia" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                07 - Documentación
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:TextBox ID="txtDocumentacion" runat="server" TextMode="MultiLine" Height="42px"
                                    Width="400" CssClass="CssTextBox"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkDocumentacion" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px">
                                08 - Cláusula u$s
                            </td>
                            <td class="EncabezadoCell" colspan="2">
                                <asp:DropDownList ID="cmbClausulaDolar" runat="server" CssClass="CssCombo" Visible="true">
                                </asp:DropDownList>
                            </td>
                            <td class="EncabezadoCell">
                                <asp:CheckBox ID="chkClausulaDolar" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    TargetControlID="Panel4" ExpandControlID="LinkButton7" CollapseControlID="LinkButton7"
                    CollapsedText="datos adicionales" ExpandedText="Ocultar" TextLabelID="LinkButton7"
                    Collapsed="True">
                </ajaxToolkit:CollapsiblePanelExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <asp:Panel ID="panelAdjunto" runat="server">
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
                Font-Underline="True" ForeColor="" Height="16px" Width="63px" ValidationGroup="Encabezado"
                OnClientClick="BrowseFile()" CausesValidation="False" Visible="False" Style="margin-right: 0px">Adjuntar</asp:LinkButton>
            <asp:Button ID="btnAdjuntoSubir" runat="server" Font-Bold="False" Height="19px" Style="margin-left: 0px;
                margin-right: 23px; text-align: left;" Text="Adjuntar" Width="58px" CssClass="button-link"
                CausesValidation="False" />
            <asp:LinkButton ID="lnkAdjunto1" runat="server" ForeColor="" Visible="False"></asp:LinkButton>
            <%--style="visibility:hidden;"/>--%>
            <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
            --%>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
            <asp:FileUpload ID="FileUpLoad2" runat="server" Width="402px" Height="22px" CssClass="button-link"
                Font-Underline="False" />
            <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
            <asp:LinkButton ID="lnkBorrarAdjunto" runat="server" ForeColor="">borrar</asp:LinkButton>
            <br />
            <br />
        </asp:Panel>
    </div>
    <asp:Panel ID="Panel2" runat="server" Visible="false">
        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete="ClientUploadComplete"
            CompleteBackColor="Lime" ErrorBackColor="Red" />
        <%--puse AutoID por los problemas de Server Response Error. No se cuales son las consecuencias--%>
        <%--     
          OnClientUploadError="uploadError" OnClientUploadStarted="StartUpload" 

        --%>
        <asp:Button ID="btnVistaPrevia" runat="server" Text="cargar grilla" CssClass="Oculto" />
        <script type="text/javascript" language="javascript">
            //         http: //www.codeproject.com/KB/ajax/AsyncFileUpload.aspx
            function uploadError(sender, args) {
                //document.getElementById('lblStatus').innerText = args.get_fileName(), 	"<span style='color:red;'>" + args.get_errorMessage() + "</span>";
            }

            function StartUpload(sender, args) {
                //document.getElementById('lblStatus').innerText = 'Uploading Started.';
            }

            function ClientUploadComplete(sender, args) {
                //alert('subido');
                // var filename = args.get_fileName();
                // var contentType = args.get_contentType();
                // var text = "Size of " + filename + " is " + args.get_length() + " bytes";
                // if (contentType.length > 0)
                // {
                //  text += " and content type is '" + contentType + "'.";
                //}
                //
                //  document.getElementById('lblStatus').innerText = text;

                //    document.getElementById('lblStatus')


                var f = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia");
                //var f = $find('ctl00_ContentPlaceHolder1_btnVistaPrevia');

                f.click();
            }

        </script>
        <hr />
    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto; width: 702px;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor=""
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                    GridLines="Horizontal" class="DetalleGrilla">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <%--            <asp:BoundField DataField="Id" HeaderText="Id" />
                        --%>
                        <asp:TemplateField HeaderText="Artículo" SortExpression="Articulo">
                            <%-- ItemStyle-CssClass="GrillaAnidadContenido">--%>
                            <ItemStyle Wrap="True" Width="400" />
                            <ItemTemplate>
                                <asp:Panel ID="Panel2" runat="server" Height="50px" Style="position: relative; left: 0px;
                                    top: 0px;" Width="125px" ForeColor="#000000" BackColor="White" Visible="false">
                                    Editar Eliminar</asp:Panel>
                                <asp:Panel ID="Panel1" runat="server" Style="left: 0px; position: relative; top: 0px"
                                    Width="400">
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>'>
                                    </asp:Label>
                                </asp:Panel>
                                <ajaxToolkit:HoverMenuExtender ID="HoverMenuExtender1" runat="server" PopDelay="25"
                                    PopupControlID="Panel2" PopupPosition="left" TargetControlID="Panel1">
                                </ajaxToolkit:HoverMenuExtender>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." HeaderStyle-HorizontalAlign="right"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Font-Size="X-Small">
                            <ControlStyle Font-Size="Small" Font-Underline="false" ForeColor="blue" />
                            <%--CssClass="imp"--%>
                            <ItemStyle Font-Size="Small" ForeColor="blue" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" ForeColor="blue" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:BoundField DataField="FechaEntrega" HeaderText="Entrega" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:dd/MM/yy}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaNecesidad" HeaderText="Necesidad" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:dd/MM/yy}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Subtotal" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeBonificacion" HeaderText="%Bon" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ImporteBonificacion" HeaderText="Bonif" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="" HeaderText="Subtotal grav." HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeIVA" HeaderText="%IVA" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ImporteIVA" HeaderText="IVA" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ImporteTotalItem" HeaderText="Importe" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cumplido" HeaderText="Cum" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right">
                            <HeaderStyle Width="300px" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" Width="300px" Wrap="false" />
                        </asp:BoundField>
                        <%--  <asp:BoundField DataField="Unidad" HeaderText="n°acopio" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="IdDetalleAcopios" HeaderText="it LA" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="Obra" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Costo" HeaderText="Costo" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CostoAsignado" HeaderText="Costo Asig" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CostoAsignadoDolar" HeaderText="Costo Asig u$s" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IdUsuarioAsignoCosto" HeaderText="Costo asignado por"
                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaAsignacionCosto" HeaderText="Fecha asig costo" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:dd/MM/yy}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="RM solicitada por" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PlazoEntrega" HeaderText="Plazo entrega" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <%-- <asp:BoundField DataField="Unidad" HeaderText="Cod eq de" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="" HeaderText="Equipo destino" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
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
            <%--boton que dispara la actualizacion de la grilla--%>
            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:LinkButton ID="LinkButtonPopupDirectoCliente" runat="server" OnClientClick="AgregarItemDesdeCliente(); return false;"
                Font-Bold="False" ForeColor="" Font-Size="Small" Height="20px" Width="122px"
                CssClass="butcancelalink" ValidationGroup="Encabezado" Style="vertical-align: bottom;
                margin-top: 0px; margin-bottom: 11px;" Font-Underline="False">
                <img src="../Imagenes/AgregarNegro.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label14" runat="server" ForeColor="" Text="Agregar item" />
            </asp:LinkButton><asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="False"
                ForeColor="" Font-Size="Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                Font-Underline="False" Visible="False">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label31" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True" />
            </asp:LinkButton><asp:HiddenField runat="server" ID="hfIdItem" />
            <asp:HiddenField runat="server" ID="hfProxItem" />
            <asp:HiddenField runat="server" ID="hfFechaNecesidad" />
            <asp:HiddenField runat="server" ID="hfIdCalidadDefault" />
            <script type="text/javascript">



                function AgregarItemDesdeCliente() {


                    //$find('txt_AC_Articulo').value = '';

                    /*
                    ViewState("IdDetalleRequerimiento") = -1
        

                    txt_AC_Articulo.Text = ""
                    SelectedAutoCompleteIDArticulo.Value = 0
                    txtCodigo.Text = ""
                    txtDetCantidad.Text = 0
                    txtObservacionesItem.Text = ""
                    RadioButtonList1.SelectedIndex = 0
                    */

                    document.getElementById('<%= txt_AC_Articulo.ClientID %>').value = '';
                    document.getElementById('<%= SelectedAutoCompleteIDArticulo.ClientID %>').value = 0;
                    document.getElementById('<%= txtCodigo.ClientID %>').value = '';
                    document.getElementById('<%= txtDetCantidad.ClientID %>').value = 0;
                    document.getElementById('<%= txtObservacionesItem.ClientID %>').value = '';
                    document.getElementById('<%= RadioButtonList1.ClientID %>').value = 0;

                    document.getElementById('<%= hfIdItem.ClientID %>').value = -1; //es un alta






                    //www.dreamincode.net/forums/topic/29891-ajax-modalpopupextender-activation/
                    var validated = Page_ClientValidate('Encabezado');
                    if (validated) {
                        $find('ModalPopupExtender3').show(); //pinta que es importante que esté puesto el BehaviorID en el ModalPopupExtender         
                    }

                    /*
                    'traigo el requerimiento, todo para ver el proximo item......
                    Dim myRequerimiento As Pronto.ERP.BO.Requerimiento
                    If (Me.ViewState(mKey) IsNot Nothing) Then
                    myRequerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)
                    txtItem.Text = RequerimientoManager.UltimoItemDetalle(myRequerimiento) + 1
                    Else
                    txtItem.Text = 1
                    End If

                    Dim mvarAux As String = BuscarClaveINI("Dias default para fecha necesidad en RM", SC, Session)
                    If Len(mvarAux) > 0 Then
                    txtFechaNecesidad.Text = DateAdd("d", Val(mvarAux), txtFechaRequerimiento.Text)
                    Else
                    txtFechaNecesidad.Text = Today.ToString
                    End If
                    */


                }                
                
            </script>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button4" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>
            <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
            --%>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <script>
                function getObj(objID) {
                    return document.getElementById(objID);
                }

                function iisNull(obj, val) {
                    if (obj == null)
                        return val;
                    else
                        return obj;
                }


                function jsRecalcularItem() {


                    var cant = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetCantidad").value);
                    //alert("1");
                    var preciounit = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetPrecioUnitario").value);
                    var costo = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetCosto").value);
                    var porccertif = 0; //  parseFloat(getObj("ctl00_ContentPlaceHolder1_txtPorcentajeCertificacion").value);
                    //alert("2");

                    var bonif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetBonif").value);

                    var total = getObj("ctl00_ContentPlaceHolder1_txtDetTotal");

                    if (getObj("ctl00_ContentPlaceHolder1_txtDetIVA") != null)
                        iva = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetIVA").value);
                    else
                        iva = 21;

                    var mBonificacion;
                    var mImporte;
                    var mIVA;
                    /////////////////////////////////////////////////////////////////////////////////

                    //alert(costo +' '+ porccertif);
                    if (!isNaN(porccertif) && !isNaN(costo))
                        if (porccertif > 0) {
                            getObj("ctl00_ContentPlaceHolder1_txtDetPrecioUnitario").value = costo * porccertif / 100; //las certificaciones usan cantidad=1, y van haciendo porcentajes del precio total de un articulo único
                            //alert("Ajá!");
                        }

                    //alert(cant + ' ' + preciounit + ' ' + porccertif);
                    mImporte = cant * preciounit;

                    if (!isNaN(bonif))
                        mBonificacion = mImporte * bonif / 100;
                    else
                        mBonificacion = 0;


                    mIVA = (mImporte - mBonificacion) * iva / 100;


                    //alert(mImporte + ' ' + mBonificacion +  ' ' + mIVA);


                    /////////////////////////////////////////////////////////////////////////////////

                    var TotalTemp = mImporte - mBonificacion + mIVA;

                    if (!isNaN(TotalTemp))
                        total.value = TotalTemp
                    else
                        total.value = 0;



                    //alert(total);
                    //a=document.getElementById(objID)
                    //alert(a.value);


                    return false;
                } 

            </script>
            <asp:Panel ID="PanelDetalle" runat="server" Height="" Width="660px" Style="margin-left: 5px"
                CssClass="modalPopup">
                <div style="width: 100%;">
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        Item
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetItem" runat="server" Width="72px" CssClass="CssTextBox"></asp:TextBox>
                                    </td>
                                    <td>
                                        n° RM-item
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetRmImputada" runat="server" Width="72px" CssClass="CssTextBox"></asp:TextBox>
                                        <asp:TextBox ID="txtDetRmItemImputada" runat="server" Width="30px" CssClass="CssTextBox"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border-style: none; width: 136px">
                                        Fecha de entrega
                                    </td>
                                    <td style="width: 250px" colspan="1">
                                        <asp:TextBox ID="txtFechaEntrega" runat="server" Width="72px" CssClass="CssTextBox"></asp:TextBox><cc1:CalendarExtender
                                            ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaEntrega">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                            TargetControlID="txtFechaEntrega">
                                        </cc1:MaskedEditExtender>
                                    </td>
                                    <td style="border-style: none; width: 136px">
                                        Fecha de necesidad
                                    </td>
                                    <td style="width: 250px" colspan="2">
                                        <asp:TextBox ID="txtFechaNecesidad" runat="server" Width="72px" CssClass="CssTextBox"></asp:TextBox><cc1:CalendarExtender
                                            ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaNecesidad">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                            TargetControlID="txtFechaNecesidad">
                                        </cc1:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 120px">
                                        Articulo
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtCodigo" runat="server" Width="71px" AutoPostBack="True" TabIndex="101"
                                            CssClass="CssTextBox"></asp:TextBox><asp:TextBox ID="txt_AC_Articulo" runat="server"
                                                autocomplete="off" AutoCompleteType="None" AutoPostBack="false" Style="margin-left: 0px"
                                                Width="400px" CssClass="CssTextBox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                                    runat="server" ControlToValidate="txt_AC_Articulo" ErrorMessage="* Ingrese Artículo"
                                                    Font-Size="Small" ForeColor="#FF3300" Font-Bold="True" ValidationGroup="Detalle" />
                                        <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                            CompletionListElementID="ListDivisor" CompletionSetCount="12" EnableCaching="true"
                                            MinimumPrefixLength="1" OnClientItemSelected="SetSelectedAutoCompleteIDArticulo"
                                            CompletionListCssClass="AutoCompleteScroll" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="true">
                                            <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                                            <%--                    
                        <Animations>
                            <OnHide>
                               <ScriptAction Script="ClearHiddenIDField()" />  
                            </OnHide>
                        </Animations>
                                            --%></cc1:AutoCompleteExtender>
                                        <%--tiene que haber un SetSelectedxxxxxx por cada Autocomplete--%>
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
                                        <asp:Button ID="btnTraerDatosArti" runat="server" CausesValidation="False" Height="22px"
                                            Style="visibility: hidden;" Text="YA" Width="30px" />
                                        <%--el que trae los datos del proveedor--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 136px">
                                        <asp:Label ID="lblCantidad" runat="server" ForeColor="" Text="Cantidad"></asp:Label>
                                    </td>
                                    <td style="width: 14px">
                                        <asp:TextBox ID="txtDetCantidad" runat="server" Width="66px" CssClass="CssTextBox"></asp:TextBox><cc1:FilteredTextBoxExtender
                                            ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtDetCantidad"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                        <asp:DropDownList ID="cmbDetUnidades" runat="server" AutoPostBack="True" Enabled="False"
                                            Height="22px" Width="73px" CssClass="CssCombo">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="">
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDetCantidad"
                                            ErrorMessage="* Ingrese Cantidad" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                            Enabled="true" ValidationGroup="Detalle" />
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <%--class="Oculto">--%>
                                    <td style="width: 136px; height: 10px;">
                                        Control de calidad
                                    </td>
                                    <td style="height: 10px; width: 78px" colspan="5">
                                        <asp:DropDownList ID="cmbCalidad" runat="server" Enabled="true" CssClass="CssCombo"
                                            Width="242px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 136px; height: 10px;">
                                        Precio Unitario
                                    </td>
                                    <td style="height: 10px; width: 78px">
                                        <asp:TextBox ID="txtDetPrecioUnitario" runat="server" Width="65px" Style="text-align: right;"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDetPrecioUnitario"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td style="height: 10px; width: 68px" colspan="2">
                                        Costo
                                    </td>
                                    <td style="height: 10px; width: 96px">
                                        <asp:TextBox ID="txtDetCosto" runat="server" Style="text-align: right;" Width="70px" />
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" TargetControlID="txtDetCosto"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td style="height: 10px; width: 100px;">
                                        Bonif.
                                        <asp:TextBox ID="txtDetBonif" runat="server" Style="text-align: right; margin-right: 0px;"
                                            Width="30px"></asp:TextBox>
                                        %
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtDetBonif"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td style="height: 10px; width: 80px">
                                        IVA
                                        <asp:TextBox ID="txtDetIVA" runat="server" Style="text-align: right; margin-right: 0px;"
                                            Width="30px" />%
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="txtDetIVA"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                        <%--   Imp.Int.--%>
                                        <asp:TextBox ID="txtDetImpInt" runat="server" Style="text-align: right; margin-right: 0px;"
                                            Width="63px" Visible="false"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtDetImpInt"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                    <td style="height: 10px; width: 42px;">
                                        TOTAL
                                    </td>
                                    <td style="height: 10px" valign="middle">
                                        <asp:TextBox ID="txtDetTotal" runat="server" Style="text-align: right;" Visible="true"
                                            Width="52px" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <%----               ----%>
                                <tr>
                                    <td style="width: 100px; height: 16px;">
                                    </td>
                                    <td style="height: 16px;" colspan="8">
                                        <asp:Button ID="btnRecalcularTotal" runat="server" Height="25px" Text="Recalcular Total"
                                            Width="102px" Style="visibility: hidden;" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 136px;">
                                Plazo entrega
                            </td>
                            <td style="" colspan="2">
                                <asp:DropDownList ID="cmbPlazoEntrega" runat="server" CssClass="CssCombo" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 136px; height: 64px;">
                                Observaciones
                            </td>
                            <td style="height: 64px" valign="top" colspan="2">
                                <asp:TextBox ID="txtObservacionesItem" runat="server" Height="54px" TextMode="MultiLine"
                                    Width="288px"></asp:TextBox>
                            </td>
                            <td style="height: 64px;">
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" Height="16px" Style="margin-top: 0px"
                                    ForeColor="">
                                    <asp:ListItem Value="1">Solo el material</asp:ListItem>
                                    <asp:ListItem Value="2">Solo las observaciones</asp:ListItem>
                                    <asp:ListItem Value="3">Material mas observaciones</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr style="height: 20px; margin-top: 30px;">
                        </tr>
                        <tr style="height: ;">
                            <td>
                                <asp:Button ID="btnBuscarRMoLA" runat="server" CssClass="butcancela" Text="Buscar RM/LA"
                                    UseSubmitBehavior="False" Visible="false" />
                                <asp:TextBox ID="txtPopupRetorno" runat="server" Width="10px" AutoPostBack="True"
                                    Style="visibility: hidden"></asp:TextBox>
                            </td>
                            <td align="right" style="height: 42px;" colspan="3">
                                <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                    UseSubmitBehavior="False" ValidationGroup="Detalle" />
                                <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="butcancela"
                                    UseSubmitBehavior="False" CausesValidation="False" Font-Bold="False" Style="margin-left: 28px;" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BehaviorID="ModalPopupExtender3"
                TargetControlID="Button4" PopupControlID="PanelDetalle" CancelControlID="btnCancelItem"
                DropShadow="false" BackgroundCssClass="modalBackground" />
            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%></ContentTemplate>
    </asp:UpdatePanel>
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="" Font-Size="Small"
        Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
        margin-top: 0px; margin-bottom: 6px;" CausesValidation="False" TabIndex="10"
        Font-Underline="False">
        <img src="../Imagenes/GmailPrintNegro.png" alt="" style="vertical-align: middle;
            border: none; text-decoration: none;" />
        <%--  <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />--%>
        <asp:Label ID="Label12" runat="server" ForeColor="" Text="Imprimir" Font-Underline="True"></asp:Label></asp:LinkButton>
    <script type="text/javascript">
        function OpenPopup(q) {
            var w = 800;
            var h = 500;
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            window.open('popupGrid.aspx?q=' + q, 'List', 'scrollbars=no,resizable=no,width=' + w + ' ,height=' + h + ',toolbar=No,status=No, location=no, directories=no, menubar=no, copyhistory=no, fullscreen=No, top=' + top + ', left=' + left);

            return false;
        }
    </script>
    <br />
    <asp:LinkButton ID="LinkButtonValorChequeDeTercero" runat="server" Font-Bold="False"
        Height="20px" ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
        margin-top: 0px; margin-bottom: 11px; margin-right: 50px;" Font-Underline="False"
        Enabled="true" Visible="true" OnClientClick="return OpenPopup('ItemsRequerimientosLiberadosParaComprar');">
        <%--<img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />--%>
        <asp:Label ID="Label16" runat="server" Text="Ver RMs" Font-Underline="True" Font-Size="Small"
            Visible="true"></asp:Label>
    </asp:LinkButton>
    <asp:LinkButton ID="LinkButton3" runat="server" Font-Bold="False" Height="20px" ValidationGroup="Encabezado"
        BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;
        margin-right: 50px;" Font-Underline="False" Enabled="true" Visible="false" OnClientClick="return OpenPopup('Presupuestos');">
        <%--<img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                                            text-decoration: none;" height="16" />--%>
        <asp:Label ID="Label6" runat="server" Text="Buscar Presupuestos con popupgrid generica"
            Font-Underline="True" Font-Size="Small" Visible="true"></asp:Label>
    </asp:LinkButton>
    <div class="oculto" style="display: none;">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-left: 5px;
                    margin-top: 12px"> Ver RMs a comprar</asp:LinkButton><br />
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender6" runat="server" TargetControlID="LinkButton2"
                    PopupControlID="Panel3" OkControlID="Button1" CancelControlID="Button2" DropShadow="false"
                    BackgroundCssClass="modalBackground" />
                <asp:Panel ID="Panel3" runat="server" Height="500px" Width="847px" CssClass="modalPopup">
                    <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
                    --%>
                    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text=""></asp:TextBox><asp:LinkButton
                        ID="lnkActualizarPendientes" runat="server" Font-Bold="False" Font-Underline="True"
                        ForeColor="" CausesValidation="False" Font-Size="Small" Height="30px"> Actualizar</asp:LinkButton><div
                            style="width: 99%; height: 85%; overflow: auto" />
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gridRMsParaComprar" DataSourceID="ObjectDataSource3" runat="server"
                                AutoGenerateColumns="False" Height="100%" Width="100%" CssClass="t1" DataKeyNames="IdDetalleRequerimiento"
                                AllowPaging="True" PageSize="8">
                                <Columns>
                                    <asp:TemplateField HeaderText="">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox></EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdDetalleRequerimiento" HeaderText="ID" />
                                    <asp:BoundField DataField="F_entrega" HeaderText="F.entrega" />
                                    <asp:BoundField DataField="Req_Nro_" HeaderText="Req.Nro." />
                                    <asp:BoundField DataField="Item" HeaderText="Item" />
                                    <asp:BoundField DataField="Cant_" HeaderText="Cant." />
                                    <%--                            <asp:BoundField DataField="Unidad en" HeaderText="Unidad en" />
                                    --%>
                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo" />
                                    <asp:BoundField DataField="Solicito" HeaderText="Solicito" />
                                    <asp:BoundField DataField="Obra" HeaderText="Obra" />
                                    <asp:BoundField DataField="Observaciones item" HeaderText="Observaciones" />
                                </Columns>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" DeleteMethod="Delete"
                                InsertMethod="SaveBlock" OldValuesParameterFormatString="original_{0}" SelectMethod="GetListTX"
                                TypeName="Pronto.ERP.Bll.RequerimientoManager">
                                <SelectParameters>
                                    <asp:Parameter Name="TX" DefaultValue="_Pendientes1" />
                                    <%-- revisar ObjGrillaConsulta_Selecting para pasar parametros--%>
                                    <%--<asp:Parameter Name="Parametros(0)"  DefaultValue="P"  />
                                    --%>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <%--                        <asp:ControlParameter ControlID="HFSC" Name="Usuario" PropertyName="Value"
                            Type="String" />--%></SelectParameters>
                                <DeleteParameters>
                                    <%--                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myFirmaDocumento" Type="Object" />--%></DeleteParameters>
                                <InsertParameters>
                                    <%--                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="BDs" Type="String" />
                        <asp:Parameter Name="IdFormularios" Type="String" />
                        <asp:Parameter Name="IdComprobantes" Type="String" />
                        <asp:Parameter Name="NumerosOrden" Type="String" />
                        <asp:Parameter Name="Autorizo" Type="String" />--%></InsertParameters>
                            </asp:ObjectDataSource>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>
                    <br />
                    <asp:RadioButton ID="RadioButton1" runat="server" Text="Pendientes" Visible="False" />
                    <asp:RadioButton ID="RadioButton2" runat="server" Text="a la Firma" Visible="False" />
                    <asp:UpdateProgress ID="UpdateProgress442" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" />
                            <asp:Label ID="Label34332" runat="server" Text="" ForeColor="" Visible="true"></asp:Label></ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:Button ID="Button1" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                        UseSubmitBehavior="False" CausesValidation="False" />
                    <asp:Button ID="Button2" runat="server" Font-Size="Small" Text="Cancelar" CssClass="butcancela"
                        UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px" Font-Bold="False"
                        CausesValidation="False" />
                    <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
                    --%></asp:Panel>
                <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%></ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <div>
        <%--class="oculto" style="display: none;">--%>
        <asp:UpdatePanel ID="UpdatePanelGrillaConsulta" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-left: 0px">Buscar Presupuestos</asp:LinkButton><br />
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender4" runat="server" TargetControlID="LinkButton1"
                    PopupControlID="PopUpGrillaConsulta" OkControlID="btnAceptarPopupGrilla" CancelControlID="btnCancelarPopupGrilla"
                    DropShadow="false" BackgroundCssClass="modalBackground" />
                <asp:Panel ID="PopUpGrillaConsulta" runat="server" Height="500px" Width="847px" CssClass="modalPopup">
                    <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
                    --%>
                    <asp:TextBox ID="TextBox3" runat="server" Style="text-align: right;" Text=""></asp:TextBox><div
                        style="width: 99%; height: 85%; overflow: auto" align="center">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                                <%--    datasource de grilla principal--%>
                                <asp:GridView ID="gridPresupuestos" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    BackColor="" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                    DataKeyNames="IdPresupuesto" DataSourceID="ObjGrillaConsulta" GridLines="Horizontal"
                                    PageSize="8" Width="819px">
                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="IdPresupuesto" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                            SortExpression="Id" Visible="False" />
                                        <asp:TemplateField HeaderText="Número" SortExpression="Numero">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Numero") %>'></asp:Label></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                            <EditItemTemplate>
                                                &nbsp;&nbsp;
                                                <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaIngreso") %>'>
                                                </asp:Calendar>
                                            </EditItemTemplate>
                                            <ControlStyle Width="100px" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaIngreso", "{0:d}") %>'></asp:Label></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="50" HeaderText="Proveedor" ItemStyle-Width="50"
                                            SortExpression="Proveedor">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                                    DataTextField="Titulo" DataValueField="IdProveedor" SelectedValue='<%# Bind("IdProveedor") %>'>
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                                    SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ProveedorManager"></asp:ObjectDataSource>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="50px" />
                                            <ItemStyle Wrap="true" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Proveedor") %>'></asp:Label></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id">
                                            <ItemTemplate>
                                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor=""
                                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                    <FooterStyle BackColor="" ForeColor="#000066" />
                                                    <Columns>
                                                        <asp:BoundField DataField="Articulo" HeaderText="Artículo">
                                                            <ItemStyle Font-Size="X-Small" Width="100" Wrap="true" />
                                                            <%--Wrap!!!!!--%>
                                                            <HeaderStyle Font-Size="X-Small" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad">
                                                            <ItemStyle Font-Size="X-Small" />
                                                            <HeaderStyle Font-Size="X-Small" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <RowStyle ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="" />
                                                    <PagerStyle BackColor="" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <HeaderStyle CssClass="GrillaAnidadaHeaderStyle" />
                                                </asp:GridView>
                                            </ItemTemplate>
                                            <ControlStyle BorderStyle="None" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ImporteTotal" DataFormatString="{0:F2}" HeaderStyle-Width="80"
                                            HeaderStyle-Wrap="False" HeaderText="Total" ItemStyle-HorizontalAlign="Right">
                                            <HeaderStyle Width="80px" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:TextBox></EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label></ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                    <AlternatingRowStyle BackColor="#F7F7F7" />
                                </asp:GridView>
                                <asp:ObjectDataSource ID="ObjGrillaConsulta" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetListTX" TypeName="Pronto.ERP.Bll.PresupuestoManager" DeleteMethod="Delete"
                                    UpdateMethod="Save">
                                    <SelectParameters>
                                        <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                        <asp:Parameter Name="TX" DefaultValue="" />
                                        <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
                                        <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%></SelectParameters>
                                    <DeleteParameters>
                                        <asp:Parameter Name="SC" Type="String" />
                                        <asp:Parameter Name="myPresupuesto" Type="Object" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="SC" Type="String" />
                                        <asp:Parameter Name="myPresupuesto" Type="Object" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                                <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.PresupuestoManager" DeleteMethod="Delete"
                                    UpdateMethod="Save">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                        <asp:Parameter Name="id" Type="Int32" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:Parameter Name="SC" Type="String" />
                                        <asp:Parameter Name="myPresupuesto" Type="Object" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="SC" Type="String" />
                                        <asp:Parameter Name="myPresupuesto" Type="Object" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                                <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%></ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <asp:RadioButton ID="RadioButtonPendientes" runat="server" Text="Pendientes" Visible="False" />
                    <asp:RadioButton ID="RadioButtonAlaFirma" runat="server" Text="a la Firma" Visible="False" />
                    <asp:UpdateProgress ID="UpdateProgress43342" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" />
                            <asp:Label ID="Label34442" runat="server" Text="" ForeColor="" Visible="true"></asp:Label></ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:Button ID="btnAceptarPopupGrilla" runat="server" Font-Size="Small" Text="Aceptar"
                        CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                    <asp:Button ID="btnCancelarPopupGrilla" runat="server" Font-Size="Small" Text="Cancelar"
                        CssClass="butcancela" UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px;
                        margin-top: 16px;" Font-Bold="False" Height="25px" CausesValidation="False" Width="78px" />
                    <%--  campos hidden --%>
                    <asp:HiddenField ID="HFIdObra" runat="server" />
                    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                    <asp:HiddenField ID="HFSC" runat="server" />
                    <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
                    --%></asp:Panel>
                <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%></ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        //        var datos=new Array(); 

        //        function AbreVentanaModal(){ 
        //        datos[0]="Prueba 1"; 
        //        datos[1]="Prueba 2"; 
        //        datos[2]="Prueba 3"; 
        //        datos=showModalDialog('Firma.aspx', datos,'status:no;resizable:yes;toolbar:no;menubar:no;scrollbars:yes;help:no''); 
        //        DatoPadre1.value=datos[0]; 
        //        DatoPadre2.value=datos[1]; 
        //        DatoPadre3.value=datos[2]; 
        //        } 

        //        function okScript() {
        //            msg = 'ok';
        //        }

        //        function cancelScript() {
        //            msg = 'cancel';
        //        }

        function fnClickOK(sender, e) {
            __doPostBack(sender, e)
        }
    </script>
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
                        <td align="center" style="font-weight: bold; color: ; background-color: green">
                            Información
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 37px" align="center">
                            <span style="">
                                <br />
                                <asp:Label ID="LblPreRedirectMsgbox" runat="server" ForeColor=""></asp:Label><br />
                                <br />
                                <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="Sí" />
                                <asp:Button ID="ButVolverSinImprimir" runat="server" CssClass="imp" Text="No" />
                            </span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="PanelInfo" runat="server" Height="87px" Visible="false" Width="395px">
                <table style="" class="t1">
                    <tr>
                        <td align="center" style="font-weight: bold; color: ; background-color: red; height: 14px;">
                            Información
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 37px" align="center">
                            <strong><span style="">
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
    <br />
    <div style="border: none; width: 700px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="margin: 0px 0px 0px 500px; padding: 0px; border-style: none; border-width: thin;
                    width: 200px; border-spacing: 0px;" id="TablaResumen" cellpadding="2" cellspacing="3">
                    <tr>
                        <td style="width: 191px;">
                            SUBTOTAL
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtSubtotal" runat="server" ForeColor="" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <%--<tr>
                        <td style="width: 241px; height: 16px;">
                            <asp:Label ID="Label4" runat="server" ForeColor="" Text="Bonif por item"></asp:Label>
                        </td>
                        <td style="height: 16px;" align="right">
                            <asp:Label ID="txtBonificacionPorItem" runat="server" ForeColor="" Width="74px"
                                Height="16px"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="width: 191px;">
                            Bonif por item
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtBonificacionPorItem" runat="server" ForeColor="" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            Bonif
                            <asp:TextBox ID="txtTotBonif" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtTotBonif"
                                ValidChars=".1234567890">
                            </cc1:FilteredTextBoxExtender>
                            <asp:Label ID="Label28" runat="server" ForeColor="" Text="%"></asp:Label>
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotBonif" runat="server" ForeColor="" Width="84px" Height="16px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            Subtotal gravado
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblSubtotalGravado" runat="server" ForeColor="" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            IVA
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotIVA" runat="server" ForeColor="" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            Imp. internos
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotIngresosBrutos" runat="server" ForeColor="" Width="76px" Height="16px "
                                Visible="false"></asp:Label>
                            <asp:TextBox ID="txtImpuestosInternos" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            <asp:LinkButton ID="LinkButton5" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="" CausesValidation="False" Font-Size="X-Small" Height="20px" BorderStyle="None"
                                Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 0px;"
                                BorderWidth="5px" Width="" TabIndex="7">Otros conceptos</asp:LinkButton>
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtOtrosConceptosTotal" runat="server" ForeColor="" Width="76px" Height="16px"
                                Visible="true"></asp:Label>
                            <%-- <asp:TextBox ID="txtOtrosConceptosTotal" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                <ContentTemplate>
                                    <%--boton que dispara la actualizacion de la grilla--%>
                                    <%--   <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="False" Font-Underline="True"
                                        ForeColor="" CausesValidation="False" Font-Size="X-Small" Height="20px" BorderStyle="None" Visible=false
                                        Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                                        BorderWidth="5px" Width="127px" TabIndex="7">+</asp:LinkButton>--%>
                                    <asp:Panel ID="panelOtrosConceptos" runat="server">
                                        <table>
                                            <tr>
                                                <td style="width: 191px;">
                                                    <asp:Label ID="lblDescOtrosConceptos1" runat="server" ForeColor="" Width="76px" Height="16px"
                                                        Visible="true"></asp:Label>
                                                </td>
                                                <td align="right" style="">
                                                    <asp:TextBox ID="txtOtrosConceptos1" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                                        Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 191px;">
                                                    <asp:Label ID="lblDescOtrosConceptos2" runat="server" ForeColor="" Width="76px" Height="16px"
                                                        Visible="true"></asp:Label>
                                                </td>
                                                <td align="right" style="">
                                                    <asp:TextBox ID="txtOtrosConceptos2" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                                        Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 191px;">
                                                    <asp:Label ID="lblDescOtrosConceptos3" runat="server" ForeColor="" Width="76px" Height="16px"
                                                        Visible="true"></asp:Label>
                                                </td>
                                                <td align="right" style="">
                                                    <asp:TextBox ID="txtOtrosConceptos3" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                                        Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 191px;">
                                                    <asp:Label ID="lblDescOtrosConceptos4" runat="server" ForeColor="" Width="76px" Height="16px"
                                                        Visible="true"></asp:Label>
                                                </td>
                                                <td align="right" style="">
                                                    <asp:TextBox ID="txtOtrosConceptos4" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                                        Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 191px;">
                                                    <asp:Label ID="lblDescOtrosConceptos5" runat="server" ForeColor="" Width="76px" Height="16px"
                                                        Visible="true"></asp:Label>
                                                </td>
                                                <td align="right" style="">
                                                    <asp:TextBox ID="txtOtrosConceptos5" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                                        Style="text-align: right; autocomplete: off" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="server"
                                        TargetControlID="panelOtrosConceptos" ExpandControlID="LinkButton5" CollapseControlID="LinkButton5"
                                        CollapsedText="Otros conceptos" ExpandedText="Ocultar" TextLabelID="LinkButton5"
                                        Collapsed="True">
                                    </ajaxToolkit:CollapsiblePanelExtender>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            TOTAL
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtTotal" runat="server" ForeColor="" Width="80px" Style="margin-left: 6px"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div valign="bottom" style="position: absolute; bottom: 0 !important; height: 30px; 
        text-align: center;  background-color:White; margin: 10 10 10 0; margin-top: 10px;padding-top: 10px;padding-right: 10px;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor=""
                            Visible="False"></asp:Label></ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick=";if (Page_ClientValidate('Encabezado')) {  this.disabled = true;  this.value = 'Espere...'; };"
                    Width="80px" UseSubmitBehavior="False" Style="margin-left: 0px" Font-Size="Small"
                    ValidationGroup="Encabezado"></asp:Button>
                <asp:Button ID="btnCancel" runat="server" Text="Cancelar" Width="80px" CssClass="butcancela"
                    CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 30px;"
                    Font-Bold="False"></asp:Button>
                <asp:Button ID="btnAnular" runat="server" Text="Anular" CausesValidation="False"
                    UseSubmitBehavior="False" Width="80px" Font-Bold="False" Style="margin-left: 30px"
                    CssClass="butcancela" Font-Size="Small" TabIndex="13"></asp:Button>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:UpdatePanel ID="UpdatePanelAnulacion" runat="server">
        <ContentTemplate>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel5" runat="server" Height="172px" Style="vertical-align: middle;
                text-align: center; display: none;" Width="220px" BorderColor="Transparent" ForeColor=""
                CssClass="modalPopup">
                <div align="center" style="height: 170px; width: 220px">
                    Ingrese usuario, password y motivo
                    <br />
                    <br />
                    <asp:DropDownList ID="cmbUsuarioAnulo" runat="server" CssClass="CssCombo">
                    </asp:DropDownList>
                    <br />
                    <asp:TextBox ID="txtAnularPassword" runat="server" TextMode="Password" CssClass="CssTextBox"></asp:TextBox><br />
                    <div align="center">
                        <asp:TextBox ID="txtAnularMotivo" runat="server" CssClass="CssTextBox" Height="49px"
                            Width="174px" Style="text-align: center;" TextMode="MultiLine"></asp:TextBox></div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAnularMotivo"
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
                <%-- OkControlID se lo saqué porque no estaba llamando al codigo del servidor--%></cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelLiberar" runat="server">
        <ContentTemplate>
            <asp:Button ID="Button5" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel1" runat="server" Height="119px" Width="221px" BorderColor="Transparent"
                DefaultButton="btnOk" CssClass="modalPopup" Style="vertical-align: middle; text-align: center"
                ForeColor="">
                <div align="center">
                    Ingrese usuario y password
                    <br />
                    <br />
                    <asp:DropDownList ID="cmbLibero" runat="server" CssClass="CssCombo" Visible="true"
                        TabIndex="2">
                    </asp:DropDownList>
                    <%--   hacer foco en el textbox
                     http: //www.aspdotnetcodes.com/ModalPopup_Postback.aspx
                       http: //www.aspdotnetcodes.com/ModalPopup_Postback.aspx
                       http: //www.aspdotnetcodes.com/ModalPopup_Postback.aspx
                       http: //www.aspdotnetcodes.com/ModalPopup_Postback.aspx--%>
                    <%--  <asp:DropDownList ID="DropDownList2" runat="server" CssClass="CssCombo" Visible="true">
                    </asp:DropDownList>--%>
                    &nbsp;
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                        TabIndex="1" Width="177px"></asp:TextBox><br />
                    <br />
                    <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False"
                        TabIndex="3" />
                    <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" TabIndex="4" />
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button5"
                PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="btnOk"
                DropShadow="false" CancelControlID="btnCancelarLibero">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        // http: //www.aspdotnetcodes.com/ModalPopup_Postback.aspx

        var clientid;
        function fnSetFocus(txtClientId) {
            clientid = txtClientId;
            setTimeout("fnFocus()", 1000);

        }

        function fnFocus() {
            eval("document.getElementById('" + clientid + "').focus()");
        }

    </script>
    <script language="javascript" type="text/javascript">
        // http: //stackoverflow.com/questions/8067721/how-to-make-a-gridview-with-maxmimum-size-set-to-the-containing-div

        function grillasize() {
            alturaprimerrenglon = 45;   // $("#divMasterMargenIzquierdo").height(h)
            var w = $(window).width() - (2+182+2);
            var h = $(window).height() - alturaprimerrenglon;
            //              $("#divGrid").width(w);
            //              $("#divGrid").height(h - 90);
            //              $("#divprop").height(0);
            $("#divsupercontenedor").height(h);
            $("#divsupercontenedor").width(w);
            //$("#divcontentplaceholder").width(w)
            //              $("#divsupercontenedor").css("max-height", (h + 0) + 'px !important');
            //              //                    $("#gridview1").height(h);
            //              $("#comandogrilla").width(w);
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
</asp:Content>
