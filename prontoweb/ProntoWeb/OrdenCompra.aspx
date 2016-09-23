<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="OrdenCompra.aspx.vb" Inherits="OrdenCompra" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
 
 
<%-- http://stackoverflow.com/questions/3855047/set-always-focus-on-textbox-asp-net-updatepanel
--%> 
<%--  <script>
    
    function SetEnd(TB){
    if (TB.createTextRange){
        var FieldRange = TB.createTextRange();
        FieldRange.moveStart('character', TB.value.length);
        FieldRange.collapse();
        FieldRange.select();
    }
}
    </script> --%>
    
     <script type="text/javascript" language="javascript">
//         Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

//         function EndRequestHandler(sender, args) {
//             if (args.get_error() != undefined) {
//                 var errorMessage = args.get_error().message;
//                 args.set_errorHandled(true);
//                 ToggleAlertDiv('visible');
//                 $get(messageElem).innerHTML = errorMessage;
//             }
//         }
            </script>
    
    
    <script type="text/javascript">



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
            //var costo = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetCosto").value);
            //var porccertif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtPorcentajeCertificacion").value);
            //alert("2");

            var bonif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetBonif").value);

            var total = getObj("ctl00_ContentPlaceHolder1_txtDetTotal");

//            if (getObj("ctl00_ContentPlaceHolder1_txtDetIVA") != null)
//                iva = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetIVA").value);
//            else
                iva = 0;

            var mBonificacion;
            var mImporte;
            var mIVA;
            /////////////////////////////////////////////////////////////////////////////////

            //alert(costo +' '+ porccertif);
            //if (!isNaN(porccertif) && !isNaN(costo))
            //    if (porccertif > 0) getObj("ctl00_ContentPlaceHolder1_txtDetPrecioUnitario").value = costo * porccertif / 100; //las certificaciones usan cantidad=1, y van haciendo porcentajes del precio total de un articulo único

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
    
    <div style="border: thin solid #FFFFFF; width: 700px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
            <ContentTemplate>
                <table style="padding: 0px; border: none #FFFFFF; width: 699px;margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                            font-size: large;" align="left" valign="top">
                            ORDEN DE COMPRA
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
                                    <%--            <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnLiberarOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnLiberarOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
--%></ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <%--        <tr>
                <td class= "EncabezadoCell" style=" visibility: hidden;" colspan="4">
                </td>
                
          
        </tr>--%>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            N° interno
                        </td>
                        <td class="EncabezadoCell" style="width: 220px;">
                            <asp:TextBox ID="txtLetra" runat="server" Width="15px" MaxLength="1" Enabled="False"
                                Visible="False"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtLetra"
                                Mask="L" MaskType="None" AutoComplete="False">
                            </cc1:MaskedEditExtender>
                            <asp:DropDownList ID="cmbPuntoVenta" runat="server" Width="54px" Height="22px" Enabled="False"
                                Visible="False">
                            </asp:DropDownList>
                            <asp:TextBox ID="txtNumeroOrdenCompra2" runat="server" Width="70px" Style="text-align: right;"
                                AutoPostBack="True" Enabled="False"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="txtNumeroOrdenCompra2_MaskedEditExtender" runat="server"
                                TargetControlID="txtNumeroOrdenCompra2" Mask="99999999" MaskType="Number" InputDirection="RightToLeft"
                                AutoCompleteValue="0">
                            </cc1:MaskedEditExtender>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                    ControlToValidate="txtNumeroOrdenCompra1" 
                    ErrorMessage="*Número" Font-Size="Small" ForeColor="#FF3300" 
                    Font-Bold="True" ValidationGroup="Encabezado" style="display:none"></asp:RequiredFieldValidator>
                                                    
                                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender4"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator15"/>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNumeroOrdenCompra2"
                                ErrorMessage="* Número" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                ValidationGroup="Encabezado" Style="display: none" />
                            <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator9" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 90px;">
                            Ingreso
                        </td>
                        <td style="" class="EncabezadoCell">
                            <asp:TextBox ID="txtFechaIngreso" runat="server" Width="110px" MaxLength="1" Style="margin-left: 0px"></asp:TextBox>&nbsp;&nbsp;
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
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            n° OC de Cliente
                        </td>
                        <td class="EncabezadoCell" style="width: 220px;">
                            <asp:TextBox ID="txtNumeroOrdenCompraEnElCliente" runat="server" Width="70px" Style="text-align: right;"
                                AutoPostBack="True"></asp:TextBox>
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtNumeroOrdenCompraEnElCliente"
                                ErrorMessage="* Ingrese número de OC del cliente" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                ValidationGroup="Encabezado" Style="display: none" />
                                     <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender6" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator14" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 90px;">
                        </td>
                        <td style="" class="EncabezadoCell">
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; ">
                            Obra
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; " colspan="3">
                            <asp:DropDownList ID="cmbObra" runat="server" CssClass="CssCombo" TabIndex="3" ValidationGroup="Encabezado"
                                Height="19px" Width="500px">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="cmbObra"
                                ErrorMessage="Elija una Obra" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                InitialValue="-1" Style="display: none" ValidationGroup="Encabezado" />
                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" Enabled="True"
                                TargetControlID="RequiredFieldValidator2" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            Lista
                        </td>
                        <td class="EncabezadoCell" style="width: 220px;">
                            <asp:DropDownList ID="cmbListaPrecios" runat="server" CssClass="CssCombo" TabIndex="3"
                                ValidationGroup="Encabezado" Height="19px">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cmbListaPrecios"
                                ErrorMessage="Elija una Obra" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                InitialValue="-1" Style="display: none" ValidationGroup="Encabezado" />
                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" Enabled="True"
                                TargetControlID="RequiredFieldValidator7" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 90px; visibility: hidden;">
                            Dirección entrega
                        </td>
                        <td class="EncabezadoCell" style="visibility: hidden;">
                            <asp:DropDownList ID="cmbDireccionEntrega" runat="server" CssClass="CssCombo" TabIndex="3"
                                ValidationGroup="Encabezado" Height="19px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            Cliente
                        </td>
                        <td class="EncabezadoCell" style="width: 220px;">
                            <asp:TextBox ID="txtAutocompleteCliente" runat="server" autocomplete="off" TabIndex="6"
                                OnTextChanged="btnTraerDatosClientes_Click" AutoPostBack="True" CssClass="CssTextBox"></asp:TextBox>
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                TargetControlID="txtAutocompleteCliente" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAutocompleteCliente"
                                ErrorMessage="* Ingrese un cliente" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                ValidationGroup="Encabezado" Style="display: none" />
                            <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                            <asp:Button ID="btnTraerDatosClientes" runat="server" Text="YA" Width="30px" Height="22px"
                                CausesValidation="False" Style="visibility: hidden;" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px;" visible="false">
                            Liberó
                        </td>
                        <td class="EncabezadoCell" style="" visible="false">
                            <asp:TextBox ID="txtLibero" runat="server" Enabled="False" Style="margin-left: 0px"
                                CssClass="CssTextBox" TabIndex="6" Visible="true"></asp:TextBox>
                            <asp:LinkButton ID="btnLiberar" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="White" Font-Size="Small" Height="16px" Width="72px" ValidationGroup="Encabezado"
                                Visible="true">Liberar</asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="visibility: hidden; display: none;">
                        <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 18px;">
                        </td>
                        <%--style="visibility:hidden;"/>--%>
                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                            Vendedor
                        </td>
                        <td class="EncabezadoCell" style="height: 18px">
                            <asp:DropDownList ID="cmbVendedor" runat="server" CssClass="CssCombo">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="padding: 0px; border: none #FFFFFF; width: 698px; height: 62px; margin-right: 0px;"
                            cellpadding="3" cellspacing="3">
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px; height: 10px;">
                                    CUIT
                                </td>
                                <td class="EncabezadoCell" style="width: 220px; height: 10px;">
                                    <asp:TextBox ID="txtCUIT" runat="server" Width="110px" Enabled="False"></asp:TextBox>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                                        ErrorTooltipEnabled="True" Mask="99\-99999999\-9" MaskType="Number" TargetControlID="txtCUIT">
                                    </cc1:MaskedEditExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCUIT"
                                        ErrorMessage="* Ingrese CUIT" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" Enabled="false" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator6" CssClass="CustomValidatorCalloutStyle" />
                                </td>
                                <td class="EncabezadoCell" style="width: 90px; height: 10px;">
                                    Condición
                                </td>
                                <td class="EncabezadoCell" style="height: 4px;">
                                    <asp:DropDownList ID="cmbCondicionIVA" runat="server" CssClass="CssCombo" Enabled="False" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="cmbCondicionIVA"
                                        ErrorMessage="* Ingrese una condicion" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none"
                                        Enabled="false" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender9" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator10" CssClass="CustomValidatorCalloutStyle" />
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 100px;">
                                    Cond. de compra
                                </td>
                                <td class="EncabezadoCell" style="width: 220px;">
                                    <asp:DropDownList ID="cmbCondicionCompra" runat="server" CssClass="CssCombo" Visible="true" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="cmbCondicionCompra"
                                        ErrorMessage="* Ingrese una condicion de compra" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none"
                                        Enabled="false" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender8" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator12" CssClass="CustomValidatorCalloutStyle" />
                                </td>
                                <td class="EncabezadoCell" style="width: 90px;">
                                    Moneda
                                </td>
                                <td style="" class="EncabezadoCell">
                                    <asp:DropDownList ID="cmbMoneda" runat="server" CssClass="CssCombo" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="cmbMoneda"
                                        ErrorMessage="* Ingrese una moneda" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        InitialValue="-1" ValidationGroup="Encabezado" Style="display: none" Enabled="false" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender10" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator11" CssClass="CustomValidatorCalloutStyle" />
                                </td>
                            </tr>
                            <%--
            <tr>
                <td style=" width: 70px; height: 9px;">
                    <asp:Label ID="Label13" runat="server" Text="CAI" ForeColor="White"></asp:Label>
                </td>
                <td style=" width: 210px; height: 9px;">
                    <asp:TextBox ID="txtCAI" runat="server" Width="150px" MaxLength="13"></asp:TextBox>
                </td>
                <td style=" width: 70px; height: 9px;">

                
                <asp:Label ID="Label14" runat="server" Text="Fecha vto. CAI" ForeColor="White"></asp:Label>
                </td>
                <td style=" width: 185px; height: 9px;">
      
                        
      
                    <asp:TextBox ID="txtFechaVtoCAI" runat="server" MaxLength="1" Width="72px"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                        TargetControlID="txtFechaVtoCAI">
                    </cc1:CalendarExtender>
                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" 
                        AcceptNegative="Left" DisplayMoney="Left" ErrorTooltipEnabled="True" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaVtoCAI">
                    </cc1:MaskedEditExtender>
                
                    <asp:RangeValidator ID="RangeValidator1" runat="server" 
                        ErrorMessage="* CAI Vencido"
                        Font-Size="XX-Small" ForeColor="#FF9900" 
                        ControlToValidate="txtFechaVtoCAI" Enabled="False" 
                        MaximumValue="ZZZZZZZZZZZZZZ" MinimumValue="1/1/2000" />
                
                
                </td>
            
            </tr>                    
            --%>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="padding: 0px; border: none #FFFFFF; width: 703px; height: 94px; margin-right: 0px;
                    display: none;" cellpadding="3" cellspacing="3">
                    <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 53px; display: none;">
                        </td>
                        <td class="EncabezadoCell" style="width: 200px; height: 53px;">
                        </td>
                        <td class="EncabezadoCell" style="width: 90px; height: 53px;">
                            <asp:Label ID="Label344" runat="server" Text="Mostrar en Pronto" ForeColor="White"
                                Font-Size="Small" Visible="False"></asp:Label>
                        </td>
                        <td style="height: 53px" class="EncabezadoCell">
                            <asp:CheckBox ID="chkConfirmadoDesdeWeb" runat="server" ForeColor="White" Text=""
                                TextAlign="right" Font-Size="Small" Visible="False" />
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <br />
                        <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                            ForeColor="White" CausesValidation="False" Font-Size="X-Small" Height="20px"
                            BorderStyle="None" Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px;
                            margin-left: 5px;" BorderWidth="5px" Width="127px"></asp:LinkButton>
                        <asp:Panel ID="Panel4" runat="server">
                            <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 86px; margin-right: 0px;"
                                cellpadding="1" cellspacing="3">
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px;">
                                        Observ.
                                    </td>
                                    <td class="EncabezadoCell" style="width: 220px;">
                                        <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Width="180px"
                                            Height="52px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 90px;">
                                        &nbsp;
                                    </td>
                                    <td style="" class="EncabezadoCell">
                                    </td>
                                </tr>
                                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                                <%----------------------------------------------%>
                                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                            </table>
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                            TargetControlID="Panel4" ExpandControlID="btnMasPanel" CollapseControlID="btnMasPanel"
                           CollapsedText="más..." ExpandedText="ocultar" TextLabelID="btnMasPanel"
                            Collapsed="True">
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
                TabIndex="8" OnClientClick="BrowseFile()" CausesValidation="False" Visible="False"
                Style="margin-right: 0px" Enabled="False">Adjuntar</asp:LinkButton>
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
    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                    GridLines="Horizontal" Width="702px" class="DetalleGrilla" CellPadding="3">
                    <FooterStyle BackColor="#507CBB" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                                                <asp:BoundField DataField="NumeroItem" HeaderText="n°">
                            <ItemStyle Wrap="True" Width="20" />
                        </asp:BoundField>
                        <%-- <asp:BoundField DataField="Concepto" HeaderText="Concepto" />--%>
                        <%--  <asp:BoundField DataField="gravado" HeaderText="Gravado" />--%>
                        <%--<asp:BoundField DataField="Precio" HeaderText="Precio"  />
           --%>
                        <asp:TemplateField HeaderText="Artículo" SortExpression="Articulo">
                            <ItemStyle Wrap="True" Width="400" />
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." ItemStyle-HorizontalAlign="Right"
                            DataFormatString="{0:F2}">
                            <HeaderStyle Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" ItemStyle-HorizontalAlign="Right"
                            DataFormatString="{0:F2}">
                            <HeaderStyle Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ImporteTotalItem" HeaderText="Total" />
                        <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Font-Size="X-Small" Visible="true">
                            <ControlStyle Font-Size="Small" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado"
                            Visible="true">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />
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
            <%--boton que dispara la actualizacion de la grilla--%>
            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <%--AUTOCOMPLETE--%>
    <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%--boton de agregar--%>
            <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="Small" Height="20px" Width="122px" ValidationGroup="Encabezado" BorderStyle="None"
                Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;" TabIndex="10"
                Font-Underline="False" Enabled="true">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label31" runat="server" ForeColor="White" Text="Agregar item" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button1" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>

            <script type="text/javascript">
                // Disparando el modalpopup explícitamente para poder ejecutar cosas antes de que aparezca
                // (No lo estoy usando)
                // http://stackoverflow.com/questions/1277045/to-show-modalpopup-in-javascript
                function fnModalShow() {
                    var modalDialog = $find("ModalPopupExtender3");
                    // get reference to modal popup using the AJAX api $find() function

                    if (modalDialog != null) {
                        modalDialog.show();
                    }
                }
            </script>

            <%----------------------------------------------%>
            <asp:Panel ID="PanelDetalle" runat="server" Width="636px" CssClass="modalPopup">
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
                            <tr>
                                <td style="width: 80px; height: 32px; position: relative;">
                                    Item
                                </td>
                                <td style="width: 159px">
                                    <asp:TextBox ID="txtDetItem" runat="server" Width="31px" Enabled="False" TabIndex="101"></asp:TextBox>
                                </td>
                                <td colspan="2" title="Forma de cancelación">
                                    <asp:RadioButtonList ID="RadioButtonListFormaCancelacion" runat="server" 
                                        AutoPostBack="True" ForeColor="White" RepeatDirection="Horizontal" 
                                        Style="margin-left: 0px" TabIndex="105">
                                        <asp:ListItem Value="1">por Cantidad</asp:ListItem>
                                        <asp:ListItem Value="2">por Certificación</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                                        ControlToValidate="RadioButtonListFormaCancelacion" Display="Dynamic" 
                                        ErrorMessage="* Ingrese forma de cancelación" Font-Bold="True" 
                                        Font-Size="Small" ForeColor="#FF3300" ValidationGroup="Detalle" />
                                </td>
                                <tr>
                                    <td style="width: 100px">
                                        Fecha de Entrega
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetFechaEntrega" runat="server" Width="72px"
                                            Enabled="true" TabIndex="106"></asp:TextBox>
                                        <cc1:CalendarExtender ID="CalendarExtender10" runat="server" 
                                            Format="dd/MM/yyyy" TargetControlID="txtDetFechaEntrega">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender10" runat="server" 
                                            AcceptNegative="Left" DisplayMoney="Left" ErrorTooltipEnabled="True" 
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtDetFechaEntrega">
                                        </cc1:MaskedEditExtender>
                                    </td>
                                    <td style="width: 100px">
                                        Fecha de necesidad
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetFechaNecesidad" runat="server" Enabled="true"  TabIndex="106"
                                            Width="72px"></asp:TextBox>
                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                                            TargetControlID="txtDetFechaNecesidad">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" 
                                            AcceptNegative="Left" DisplayMoney="Left" ErrorTooltipEnabled="True" 
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtDetFechaNecesidad">
                                        </cc1:MaskedEditExtender>
                                    </td>
                                    <tr style="visibility: visible">
                                        <td style="width: 100px">
                                            <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Artículo"></asp:Label>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" Enabled="true" 
                                                TabIndex="107" Width="71px"></asp:TextBox>
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
                                            <asp:TextBox ID="txt_AC_Articulo" runat="server" autocomplete="off" 
                                                AutoCompleteType="None" AutoPostBack="false" Enabled="true" 
                                                OnTextChanged="btnTraerDatosArti_Click" Style="margin-left: 0px" Width="400px" TabIndex="107" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                                                ControlToValidate="txt_AC_Articulo" Display="Dynamic" 
                                                ErrorMessage="* Ingrese artículo" Font-Bold="True" Font-Size="Small" 
                                                ForeColor="#FF3300" ValidationGroup="Detalle" />
                                            <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" 
                                                CompletionInterval="100" CompletionListCssClass="AutoCompleteScroll" 
                                                CompletionListElementID="ListDivisor" CompletionSetCount="12" 
                                                EnableCaching="true" MinimumPrefixLength="1" 
                                                OnClientItemSelected="SetSelectedAutoCompleteIDArticulo" 
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" 
                                                TargetControlID="txt_AC_Articulo" UseContextKey="true">
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

                                            <div ID="ListDivisor">
                                            </div>
                                            <%-- Por si la lista se renderea atrás   http://forums.asp.net/t/1079711.aspx--%>
                                            <input id="SelectedAutoCompleteIDArticulo" runat="server" type="hidden" />
                                            <%--el hidden que guarda el id--%>
                                            <asp:Button ID="btnTraerDatosArti" runat="server" CausesValidation="False" 
                                                Height="22px" Style="visibility: hidden;" Text="YA" Width="30px" />
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
                        <asp:DropDownList ID="cmbCuentaGasto" runat="server" Width="400px" 
                            Font-Overline="False" ></asp:DropDownList>
                    </td>
                </tr>--%> <%----               ----%>
                                    <tr>
                                        <td style="width: 100px; height: 16px; ">
                                            <asp:Label ID="Label2" runat="server" ForeColor="White" Text="Observacion"></asp:Label>
                                        </td>
                                        <td style="height: 16px;">
                                            <asp:TextBox ID="txtDetObservaciones" runat="server" Height="48px"  TabIndex="108" 
                                                TextMode="MultiLine" Width="298px"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:RadioButtonList ID="RadioButtonListDescripcion" runat="server" AutoPostBack="True" 
                                                ForeColor="White" Style="margin-left: 0px" TabIndex="109">
                                                <asp:ListItem Selected="True" Value="1">Solo el material</asp:ListItem>
                                                <asp:ListItem Value="2">Solo las observaciones</asp:ListItem>
                                                <asp:ListItem Value="3">Material mas observaciones</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </tr>
                                </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanelDetallePreciosYCantidades" runat="server">
                    <ContentTemplate>
                        <table style=" width: 632px; color: #FFFFFF;">
                            <%----               ----%>
                            <tr>
                                <td style="width: 100px;">
                                    Cantidad
                                </td>
                                <td style="height: 16px;" colspan="1">
                                    <asp:TextBox ID="txtDetCantidad" runat="server" Width="65px" Style="text-align: right;"  TabIndex="110" 
                                       ></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtDetCantidad"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
                                </td>
                                <td colspan="2" style="">
                                    <asp:UpdatePanel ID="Updatepanel11" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cmbDetUnidades" runat="server" AutoPostBack="True" Enabled="true"
                                                Width="73px" Height="22px">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td colspan="4" style="">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDetCantidad"
                                        ErrorMessage="* Ingrese Cantidad" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                        ValidationGroup="Detalle" Display="Dynamic" />
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator"
                                ControlToValidate="txtDetCantidad" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                Enabled="true" Operator="GreaterThan" ValueToCompare="0" Display="Dynamic" ValidationGroup="Detalle">* Debe ser mayor que 0</asp:CompareValidator>
                                    <cc1:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                                        runat="server" Enabled="True" TargetControlID="RequiredFieldValidator3" CssClass="CustomValidatorCalloutStyle" />
                                        
                                </td>
                            </tr>
                            <%----               ----%>
                            <tr>
                                <td style="width: 100px;">
                                    Precio Unitario
                                </td>
                                <td style=" width: 78px">
                                    <asp:TextBox ID="txtDetPrecioUnitario" runat="server" Width="65px" Style="text-align: right;" TabIndex="111" 
                                        ></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDetCantidad"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
                                </td>
                                <td style="height: 10px; width: 69px">
                                    Bonif. %
                                </td>
                                <td style="height: 10px; width: 78px;">
                                    <asp:TextBox ID="txtDetBonif" runat="server" 
                                        Style="text-align: right; margin-right: 0px;" Width="63px" TabIndex="112" ></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtDetBonif"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
                                </td>
                                <td style="height: 10px; width: 68px; display: none" colspan="2">
                                    IVA %
                                </td>
                                <td style="height: 10px; width: 96px; display: none">
                                    <asp:TextBox ID="txtDetIVA" runat="server"  TabIndex="113" 
                                        Style="text-align: right;" Width="70px"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" TargetControlID="txtDetIVA"
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
                        <asp:AsyncPostBackTrigger ControlID="txtDetCantidad" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetPrecioUnitario" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetIVA" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <%----    Adjuntos           ----%>
                <table style="height: 24px; width: 632px">
                    <tr style="display: none">
                        <td style="width: 100px; height: 20px;">
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
                    <tr style="display: none">
                        <td style="width: 100px; height: 20px;">
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
                    <tr>
                        <td style="width: 100px; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" ValidationGroup="Detalle" />
                            <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px" Font-Bold="False"
                                CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="Button1"
                PopupControlID="PanelDetalle" CancelControlID="btnCancelItem" DropShadow="False"
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
            <asp:AsyncPostBackTrigger ControlID="txtDetPrecioUnitario" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetIVA" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />--%>
        </Triggers>
    </asp:UpdatePanel>
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
        Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
        TabIndex="10" Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
        <asp:Label ID="Label29" runat="server" ForeColor="White" Text="Imprimir" Font-Underline="True"></asp:Label></asp:LinkButton>
    <%--<asp:Parameter Name="Parametros(0)"  DefaultValue="P"  />
                       --%>
    <br />
    <asp:UpdatePanel ID="UpdatePanelGrillaConsulta" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" Font-Underline="True"
                ForeColor="White" CausesValidation="False" Font-Size="Small" Height="30px" ValidationGroup="Encabezado"
                Visible="false"> Ver RMs a comprar</asp:LinkButton>
            <asp:LinkButton ID="LinkButton3" runat="server" Font-Bold="False" Font-Underline="True"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False"> ....   Popup Onda Contactos Gmail?</asp:LinkButton>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button5" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>
            <br />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button5"
                PopupControlID="PopUpGrillaConsulta" OkControlID="btnAceptarPopupGrilla" CancelControlID="btnCancelarPopupGrilla"
                DropShadow="False" BackgroundCssClass="modalBackground" />
            <asp:Panel ID="PopUpGrillaConsulta" runat="server" Height="443px" Width="847px" CssClass="modalPopup">
                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                <div style="width: 99%; height: 92%; overflow: auto" align="center">
                    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="buscar"
                        onfocus="select();"></asp:TextBox>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GVGrillaConsulta" DataSourceID="ObjGrillaConsulta" runat="server"
                                AutoGenerateColumns="False" Height="123px" Width="465px" CssClass="t1" DataKeyNames="IdDetalleRequerimiento"
                                AllowPaging="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdDetalleRequerimiento" HeaderText="ID" />
                                    <asp:BoundField DataField="F.entrega" HeaderText="F.entrega" />
                                    <asp:BoundField DataField="Req.Nro." HeaderText="Req.Nro." />
                                    <asp:BoundField DataField="Item" HeaderText="Item" />
                                    <asp:BoundField DataField="Cant_" HeaderText="Cant." />
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
                            <asp:ObjectDataSource ID="ObjGrillaConsulta" runat="server" DeleteMethod="Delete"
                                InsertMethod="SaveBlock" OldValuesParameterFormatString="original_{0}" SelectMethod="GetListTX"
                                TypeName="Pronto.ERP.Bll.RequerimientoManager">
                                <SelectParameters>
                                    <asp:Parameter Name="TX" DefaultValue="_Pendientes1" />
                                    <%-- revisar ObjGrillaConsulta_Selecting para pasar parametros--%>
                                    <%--<asp:Parameter Name="Parametros(0)"  DefaultValue="P"  />
                       --%>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <%--                        <asp:ControlParameter ControlID="HFSC" Name="Usuario" PropertyName="Value"
                            Type="String" />--%>
                                </SelectParameters>
                                <DeleteParameters>
                                    <%--                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="myFirmaDocumento" Type="Object" />--%>
                                </DeleteParameters>
                                <InsertParameters>
                                    <%--                        <asp:Parameter Name="SC" Type="String" />
                        <asp:Parameter Name="BDs" Type="String" />
                        <asp:Parameter Name="IdFormularios" Type="String" />
                        <asp:Parameter Name="IdComprobantes" Type="String" />
                        <asp:Parameter Name="NumerosOrden" Type="String" />
                        <asp:Parameter Name="Autorizo" Type="String" />--%>
                                </InsertParameters>
                            </asp:ObjectDataSource>
                            <asp:HiddenField ID="HFSC" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <br />
                <asp:RadioButton ID="RadioButtonPendientes" runat="server" Text="Pendientes" Visible="False" />
                <asp:RadioButton ID="RadioButtonAlaFirma" runat="server" Text="a la Firma" Visible="False" />
                <asp:Button ID="btnAceptarPopupGrilla" runat="server" Font-Size="Small" Text="Aceptar"
                    CssClass="but" UseSubmitBehavior="False" CausesValidation="False" />
                <asp:Button ID="btnCancelarPopupGrilla" runat="server" Font-Size="Small" Text="Cancelar"
                    CssClass="but" UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px"
                    Font-Bold="False" CausesValidation="False" />
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="False" Font-Underline="True"
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="20px" Visible="true"> 
                Copiar Orden de compra existente
            </asp:LinkButton>
            <br />
            <asp:Button ID="Button2" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="Button2"
                PopupControlID="PopupGrillaSolicitudes" OkControlID="Button3" CancelControlID="Button4"
                DropShadow="False" BackgroundCssClass="modalBackground" />
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
                        <asp:TextBox ID="TextBox3" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
                        <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" 
                Style="text-align: right; margin-left: 0px;"  Width="119px" Height="22px" >
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Numero interno" Value="[Nro_ interno]" />
                <asp:ListItem Text="Fecha" Value="Fecha" />
                <asp:ListItem Text="Cliente" Value="Cliente" />
                <asp:ListItem Text="Anulada" Value="Anulada" />
            
                </asp:DropDownList>
                        <div style="width: 720px; height: 400px; overflow: auto" align="center">
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
                                DataSourceID="ObjectDataSource2" GridLines="Horizontal" AllowPaging="True" Height="85%"
                                CssClass="t1" Width="700px">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="true" />
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <%--                                    <asp:TemplateField HeaderText="">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" 
                                        Checked='<%# Eval("ColumnaTilde") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
--%>
                                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <%--<asp:TemplateField HeaderText="Número" SortExpression="Numero" ItemStyle-Width="50">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Numero") & "/" &  Eval("SubNumero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Numero") & "/" &  Eval("SubNumero")  %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha" ItemStyle-Width="50">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaIngreso") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaIngreso", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Proveedor" SortExpression="Proveedor" HeaderStyle-Width="50"
                                        ItemStyle-Width="50">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                                DataTextField="Titulo" DataValueField="IdProveedor" SelectedValue='<%# Bind("IdProveedor") %>'>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetListCombo" TypeName="Pronto.ERP.Bll.ProveedorManager"></asp:ObjectDataSource>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle Wrap="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Proveedor") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    --%>
                                    <asp:TemplateField HeaderText="Numero" SortExpression="Numero">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Numero") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%#   Eval("Numero")  %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--            
            Period (or Dot) in Column Name Error in C#
            http://www.victorchen.info/period-or-dot-in-column-name-error-in-c/--%>
                                    <asp:TemplateField HeaderText="Interno">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%#  Bind("[Nro_ Interno]") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%#  Bind("[Nro_ Interno]") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("[Fecha]") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Fecha]", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                    <%--& Eval("[]") --%>
                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" />
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id"
                                        ItemStyle-Width="300">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo">
                                                        <ItemStyle Font-Size="X-Small" Wrap="False" />
                                                        <HeaderStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Cant_" HeaderText="Cantidad">
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
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="ImporteTotal" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                                        DataFormatString="{0:F2}" HeaderStyle-Wrap="False">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>

                            <script type="text/javascript">
                                //variable that will store the id of the last clicked row
                                var previousRow;

                                function ChangeRowColor(row) {
                                    //If last clicked row and the current clicked row are same
                                    if (previousRow == row)
                                        return; //do nothing
                                    //If there is row clicked earlier
                                    else if (previousRow != null)
                                    //change the color of the previous row back to white
                                        document.getElementById(previousRow).style.backgroundColor = "#ffffff";

                                    //change the color of the current row to light yellow

                                    document.getElementById(row).style.backgroundColor = "#ffffda";
                                    //assign the current row id to the previous row id 
                                    //for next row to be clicked
                                    previousRow = row;

                                    document.getElementById('ctl00_ContentPlaceHolder1_HiddenIdGrillaPopup') = row;
                                }
                            </script>

                            <asp:HiddenField ID="HiddenIdGrillaPopup" runat="server" />
                            <%--//////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////--%>
                            <%--    datasource de grilla principal--%>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.OrdenCompraManager" DeleteMethod="Delete"
                                UpdateMethod="Save">
                                <SelectParameters>
                                    <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <%--<asp:Parameter Name="TX" DefaultValue="" />--%>
                                    <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
                                    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myOrdenCompra" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myOrdenCompra" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.OrdenCompraManager" DeleteMethod="Delete"
                                UpdateMethod="Save">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:Parameter Name="id" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myOrdenCompra" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myOrdenCompra" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:HiddenField ID="HFIdObra" runat="server" />
                            <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <asp:Button ID="Button3" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                    UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
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
    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
    <div style="border: none; width: 700px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="margin: 0px 0px 0px 500px; padding: 0px; border-style: none; border-width: thin;
                    width: 200px; border-spacing: 0px; color: #FFFFFF;" id="TablaResumen" cellpadding="2" cellspacing="3">
                    <tr>
                        <td style="width: 191px;">
                            SUBTOTAL
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtSubtotal" runat="server" ForeColor="White" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            Bonif por item
                        </td>
                        <td style="" align="right">
                            <asp:Label ID="txtBonificacionPorItem" runat="server" ForeColor="White" Width="74px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px;">
                            Bonif
                            <asp:TextBox ID="txtTotBonif" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right;" Width="40px" Font-Size="X-Small"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtTotBonif"
                                ValidChars=".1234567890">
                            </cc1:FilteredTextBoxExtender>
                            <asp:Label ID="Label28" runat="server" ForeColor="White" Text="%"></asp:Label>
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotBonif" runat="server" ForeColor="White" Width="84px"></asp:Label>
                        </td>
                    </tr>
                    <tr style="visibility: hidden; display: none">
                        <td style="width: 191px;">
                            Subtotal Gravado
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotSubGravado" runat="server" ForeColor="White" Width="76px"></asp:Label>
                        </td>
                    </tr>
                    <tr style="visibility: hidden; display: none">
                        <td style="width: 191px;">
                            IVA
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="lblTotIVA" runat="server" ForeColor="White" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px">
                            TOTAL
                        </td>
                        <td align="right" style="">
                            <asp:Label ID="txtTotal" runat="server" ForeColor="White" Width="80px" Style="margin-left: 6px"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
    --%>
        <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
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
                    UseSubmitBehavior="False" Width="82px" Style="margin-right: 30px" ValidationGroup="Encabezado"
                    Height="23px"></asp:Button>
                <%--le saqué el CssClass="but"--%>
                <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="but"
                    Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Width="79px"
                    Font-Bold="False" Style="margin-right: 30px" Font-Size="Small"></asp:Button>
                <%--ni los OrdenCompras ni las comparativas se anulan--%>
                <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                    UseSubmitBehavior="False" Width="63px" Font-Bold="False"  Height="23px" Font-Size="Small" TabIndex="13"></asp:Button>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        
        
        
        
        
        
        
        
        
        
        
        <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
        <asp:UpdatePanel ID="UpdatePanelPreRedirectMsgbox" runat="server">
            <ContentTemplate>
                <ajaxToolkit:ModalPopupExtender ID="PreRedirectMsgbox" runat="server" 
                TargetControlID="btnPreRedirectMsgbox"
                    PopupControlID="PanelInfoNum" DropShadow="false">
                </ajaxToolkit:ModalPopupExtender>
                <asp:Button ID="btnPreRedirectMsgbox" runat="server" Text="invisible" Font-Bold="False"
                    Style="visibility: hidden; display: none" />
                <%--style="visibility:hidden;"/>--%>
                <asp:Panel ID="PanelInfoNum" runat="server" Height="107px" Style="display: none;
                    " CssClass="modalPopup">
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
                <asp:Panel ID="Panel3" runat="server" Height="87px" Visible="false" >
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
                        <asp:Button ID="btnLiberarOk" runat="server" Text="Ok" Width="80px" CausesValidation="False" />
                        <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtender4" runat="server" TargetControlID="Button10"
                    PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="btnLiberarOk"
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
