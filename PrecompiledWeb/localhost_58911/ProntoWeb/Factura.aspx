<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" enableeventvalidation="false" inherits="FacturaABM, App_Web_tsoyddnw" title="Untitled Page" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
            var costo = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetCosto").value);
            var porccertif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtPorcentajeCertificacion").value);
            //alert("2");

            var bonif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetBonif").value);

            var total = getObj("ctl00_ContentPlaceHolder1_txtDetTotal");

            if (getObj("ctl00_ContentPlaceHolder1_txtDetIVA") != null)
                iva = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetIVA").value);
            else
                iva = 0;

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
    <div class="EncabezadoCell">
        <div class="CssABM" style="width: 700px; margin-top: 5px;">
            <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
                <ContentTemplate>
                    <table style="padding: 0px; width: 699px; margin-right: 0px;" cellpadding="3" cellspacing="3">
                        <tr>
                            <td colspan="2" style="border: thin none; font-weight: bold; font-size: large;" align="left"
                                valign="top" class="EncabezadoCell">
                                FACTURA
                            </td>
                            <td valign="top">
                                <%--BackColor="#4A3C8C"--%>
                                <asp:Label ID="lblLetra" runat="server" BackColor="" BorderStyle="Solid" class="EncabezadoCell"
                                    BorderWidth="1px" Font-Bold="True" Font-Size="X-Large" Style="text-align: center;
                                    margin-left: 0px; vertical-align: top" Text="A" Visible="true" Width="34px"></asp:Label>
                            </td>
                            <td style="height: 37px;" valign="top" align="right">
                                <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="" class="EncabezadoCell"
                                    BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor=""
                                    Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                                    Visible="False" Width="120px"></asp:Label>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <img src="Imagenes/25-1.gif" alt="" />
                                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." Visible="False"></asp:Label>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <%--        <tr>
                <td class= "EncabezadoCell" style=" visibility: hidden;" colspan="4">
                </td>
                
          
        </tr>--%>
                        <tr>
                            <td class="EncabezadoCell" style="width: 100px;">
                                Número
                            </td>
                            <td class="EncabezadoCell" style="width: 220px;">
                                <asp:TextBox ID="txtLetra" runat="server" Width="15px" MaxLength="1" Enabled="False"
                                    Visible="False"></asp:TextBox>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtLetra"
                                    Mask="L" MaskType="None" AutoComplete="False">
                                </cc1:MaskedEditExtender>
                                <asp:DropDownList ID="cmbPuntoVenta" runat="server" Width="54px" Height="22px" Enabled="True"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:TextBox ID="txtNumeroFactura2" runat="server" Width="70px" Style="text-align: right;"
                                    Enabled="False" AutoPostBack="True"></asp:TextBox>
                                <cc1:MaskedEditExtender ID="txtNumeroFactura2_MaskedEditExtender" runat="server"
                                    TargetControlID="txtNumeroFactura2" Mask="99999999" MaskType="Number" InputDirection="RightToLeft"
                                    AutoCompleteValue="0">
                                </cc1:MaskedEditExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNumeroFactura2"
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
                                Cliente
                            </td>
                            <td class="EncabezadoCell" style="width: 220px;">
                                <asp:TextBox ID="txtAutocompleteCliente" runat="server" autocomplete="off" TabIndex="6"
                                    CssClass="CssTextBox" AutoPostBack="True"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                    TargetControlID="txtAutocompleteCliente" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtAutocompleteCliente"
                                    ErrorMessage="* Ingrese un cliente" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                        ID="ValidatorCalloutExtender13" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator15"
                                        CssClass="CustomValidatorCalloutStyle" />
                            </td>
                            <td class="EncabezadoCell" style="width: 90px;" visible="false">
                            </td>
                            <td class="EncabezadoCell" style="" visible="false">
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
                                        <asp:TextBox ID="txtCUIT" runat="server" CssClass="CssTextBox" Enabled="False"></asp:TextBox>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                                            ErrorTooltipEnabled="True" Mask="99\-99999999\-9" MaskType="Number" TargetControlID="txtCUIT">
                                        </cc1:MaskedEditExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCUIT"
                                            ErrorMessage="* Ingrese CUIT" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                            ValidationGroup="Encabezado" Style="display: none" Enabled="False" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server"
                                            Enabled="True" TargetControlID="RequiredFieldValidator6" CssClass="CustomValidatorCalloutStyle" />
                                    </td>
                                    <td class="EncabezadoCell" style="width: 90px; height: 10px;">
                                        Condición
                                    </td>
                                    <td class="EncabezadoCell" style="height: 4px;">
                                        <asp:DropDownList ID="cmbCondicionIVA" runat="server" CssClass="CssCombo" Enabled="False"
                                            Height="22px" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="cmbCondicionIVA"
                                            ErrorMessage="* Ingrese una condicion" Font-Size="Small" ForeColor="#FF3300"
                                            Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none"
                                            Enabled="False" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender9" runat="server"
                                            Enabled="True" TargetControlID="RequiredFieldValidator10" CssClass="CustomValidatorCalloutStyle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px; height: 10px;">
                                        Lista de precios
                                    </td>
                                    <td class="EncabezadoCell" style="width: 220px; height: 10px;">
                                        <asp:DropDownList ID="cmbListaPrecios" runat="server" CssClass="CssCombo" />
                                    </td>
                                    <td class="EncabezadoCell" style="width: 90px; height: 10px;">
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
                                    <td class="EncabezadoCell" style="width: 100px;">
                                        Cond. de venta
                                    </td>
                                    <td class="EncabezadoCell" style="width: 220px;">
                                        <asp:DropDownList ID="cmbCondicionVenta" runat="server" CssClass="CssCombo" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="cmbCondicionVenta"
                                            ErrorMessage="* Ingrese una condicion de compra" Font-Size="Small" ForeColor="#FF3300"
                                            Font-Bold="True" InitialValue="-1" ValidationGroup="Encabezado" Style="display: none"
                                            Enabled="False" />
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
                                            InitialValue="-1" ValidationGroup="Encabezado" Style="display: none" Enabled="False" />
                                        <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender10" runat="server"
                                            Enabled="True" TargetControlID="RequiredFieldValidator11" CssClass="CustomValidatorCalloutStyle" />
                                    </td>
                                </tr>
                                <%--
            <tr>
                <td style=" width: 70px; height: 9px;">
                    <asp:Label ID="Label13" runat="server" Text="CAI" ForeColor=""></asp:Label>
                </td>
                <td style=" width: 210px; height: 9px;">
                    <asp:TextBox ID="txtCAI" runat="server" Width="150px" MaxLength="13"></asp:TextBox>
                </td>
                <td style=" width: 70px; height: 9px;">

                
                <asp:Label ID="Label14" runat="server" Text="Fecha vto. CAI" ForeColor=""></asp:Label>
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
                            <td class="EncabezadoCell" style="width: 220px; height: 53px;">
                            </td>
                            <td class="EncabezadoCell" style="width: 90px; height: 53px;">
                                <asp:Label ID="Label344" runat="server" Text="Mostrar en Pronto" ForeColor="" Font-Size="Small"
                                    Visible="False"></asp:Label>
                            </td>
                            <td style="height: 53px" class="EncabezadoCell">
                                <asp:CheckBox ID="chkConfirmadoDesdeWeb" runat="server" ForeColor="" Text="" TextAlign="right"
                                    Font-Size="Small" Visible="False" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="butVerLog" Text="Historial" runat="server" CausesValidation="false" />
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                        <ContentTemplate>
                            <asp:LinkButton ID="btnMasPanel" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="" CausesValidation="False" Font-Size="X-Small" Height="20px" BorderStyle="None"
                                Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                                BorderWidth="5px" Width="127px"></asp:LinkButton>
                            <asp:Panel ID="Panel4" runat="server">
                                <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 86px; margin-right: 0px;"
                                    cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px;">
                                            Observ.
                                        </td>
                                        <td class="EncabezadoCell" style="width: 220px;">
                                            <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Width="180px"
                                                Height="52px"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px;">
                                            Corredor
                                        </td>
                                        <td style="" class="EncabezadoCell">
                                            <asp:TextBox ID="txtVendedor" runat="server" Width="180px" Enabled="False" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px; height: 10px;">
                                            Direccion
                                        </td>
                                        <td class="EncabezadoCell" style="width: 220px; height: 10px;">
                                            <asp:TextBox ID="TextBox7" runat="server" Width="180px" Enabled="False"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 90px; height: 10px;">
                                            Telefono
                                        </td>
                                        <td class="EncabezadoCell" style="height: 4px;">
                                            <asp:TextBox ID="txtCUIT0" runat="server" CssClass="CssTextBox" Enabled="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 100px;">
                                            Cat. IIBB 1
                                        </td>
                                        <td class="EncabezadoCell" style="width: 220px;">
                                            <asp:DropDownList ID="cmbCategoriaIIBB1" runat="server" CssClass="CssCombo" AutoPostBack="True" />
                                        </td>
                                        <%--boton de agregar--%>
                                        <td class="EncabezadoCell" style="width: 90px;">
                                            n° cert. percep ing. brut
                                        </td>
                                        <td style="" class="EncabezadoCell">
                                            <asp:TextBox ID="txtNumeroCertificadoIIBB" runat="server" Width="180px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                                    <%----------------------------------------------%>
                                    <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                                </table>
                                <asp:Label ID="lblLog" Width="500px" runat="server"></asp:Label>
                            </asp:Panel>
                            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                                TargetControlID="Panel4" ExpandControlID="btnMasPanel" CollapseControlID="btnMasPanel"
                                CollapsedText="más..." ExpandedText="ocultar" TextLabelID="btnMasPanel" Collapsed="false">
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
                    Font-Underline="True" ForeColor="" Height="16px" Width="63px" ValidationGroup="Encabezado"
                    TabIndex="8" OnClientClick="BrowseFile()" CausesValidation="False" Visible="False"
                    Style="margin-right: 0px">Adjuntar</asp:LinkButton>
                <asp:Button ID="btnAdjuntoSubir" runat="server" Font-Bold="False" Height="19px" Style="margin-left: 0px;
                    margin-right: 23px; text-align: left;" Text="Adjuntar" Width="58px" CssClass="button-link"
                    CausesValidation="False" />
                <asp:LinkButton ID="lnkAdjunto1" runat="server" ForeColor="" Visible="False"></asp:LinkButton>
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
                <asp:LinkButton ID="lnkBorrarAdjunto" runat="server" ForeColor="">borrar</asp:LinkButton>
                <br />
                <br />
            </asp:Panel>
        </div>
        <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div style="overflow: auto;">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor=""
                        BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                        GridLines="Horizontal" Width="702px" class="DetalleGrilla" CellPadding="3">
                        <FooterStyle BackColor="#507CBB" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                            <%--            <asp:TemplateField HeaderText="Artículo" SortExpression="Articulo">
                <ItemStyle Wrap="True" Width="400"/>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" 
                    Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>'>
                    </asp:Label>

            </ItemTemplate>
                
                
            </asp:TemplateField>
                            --%>
                            <%-- <asp:BoundField DataField="Articulo" HeaderText="Articulo" />--%>
                            <asp:TemplateField HeaderText="Artículo" SortExpression="Articulo">
                                <ItemStyle Wrap="True" Width="400" />
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("Articulo") &  " " & left( Eval("Observaciones"),50) %>'>
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
                            <%--            <asp:BoundField DataField="PrecioUnitarioTotal" HeaderText="PrecioUnitarioTotal" />
                            --%>
                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="Label337" runat="server" Text='<%# Eval("Precio")*Eval("Cantidad")  %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="ImporteTotalItem" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                            Visible="false" />--%>
                            <%--                        <asp:BoundField DataField="Unidad" HeaderText=""  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" dataformatstring="{0:F2}" > 
                <HeaderStyle Width="30px" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>--%>
                            <%--            <asp:BoundField DataField="Precio" HeaderText="Precio"  ItemStyle-HorizontalAlign="Right" dataformatstring="{0:c}">
                <HeaderStyle Width="60px" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>--%>
                            <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                                Visible="true" HeaderStyle-Font-Size="X-Small">
                                <ControlStyle Font-Size="Small" Font-Underline="True" />
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
        <%----fecha               ----%>
        <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <%--boton de agregar--%>
                <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="False" ForeColor=""
                    Font-Size="Small" Height="20px" Width="122px" ValidationGroup="Encabezado" BorderStyle="None"
                    Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;" TabIndex="10"
                    Font-Underline="False" Enabled="true">
                    <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                        text-decoration: none;" />
                    <asp:Label ID="Label31" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True"> </asp:Label>
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
                                        Forma de cancelación
                                    </td>
                                    <td colspan="2" title="Forma de cancelación">
                                        <asp:RadioButtonList ID="RadioButtonListFormaCancelacion" ForeColor="" runat="server"
                                            Style="margin-left: 0px" AutoPostBack="True" TabIndex="105" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="1" Selected="True">por Cantidad</asp:ListItem>
                                            <asp:ListItem Value="2">por Certificación</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <img src="Imagenes/25-1.gif" alt="" />
                                                <%--<asp:Label ID="Label364" runat="server" Text="Actualizando datos..." ForeColor=""
                                        Visible="False"></asp:Label>--%>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px">
                                        Fecha de Entrega
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDetFechaEntrega" runat="server" Width="72px" Enabled="true"></asp:TextBox>
                                        <cc1:CalendarExtender ID="CalendarExtender10" runat="server" Format="dd/MM/yyyy"
                                            TargetControlID="txtDetFechaEntrega">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender10" runat="server" AcceptNegative="Left"
                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                            TargetControlID="txtDetFechaEntrega">
                                        </cc1:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr style="">
                                    <td style="width: 100px">
                                        Artículo
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtCodigo" runat="server" Width="71px" AutoPostBack="True" TabIndex="101"
                                            Enabled="true"></asp:TextBox>
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
                                            Enabled="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txt_AC_Articulo"
                                            ErrorMessage="* Ingrese artículo" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                            ValidationGroup="Detalle" Display="Dynamic" />
                                        <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                        <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                            CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
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
                        <asp:Label ID="lblArticulo" runat="server" Text="Artículo" ForeColor=""></asp:Label>
                    </td>
                    <td colspan="3" style="height: 22px">
                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" Width="80px" 
                            Visible="False"></asp:TextBox>
                        <asp:DropDownList ID="cmbCuentaGasto" runat="server" Width="400px" 
                            Font-Overline="False" ></asp:DropDownList>
                    </td>
                </tr>--%>
                                <%----               ----%>
                                <tr>
                                    <td style="width: 100px; height: 16px;">
                                        Observacion
                                    </td>
                                    <td style="height: 16px;">
                                        <asp:TextBox ID="txtDetObservaciones" runat="server" Width="400px" Height="48px"
                                            TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="RadioButtonListDescripcion" ForeColor="" runat="server"
                                            Style="margin-left: 0px" AutoPostBack="True" TabIndex="105">
                                            <asp:ListItem Value="1" Selected="True">Solo el material</asp:ListItem>
                                            <asp:ListItem Value="2">Solo las observaciones</asp:ListItem>
                                            <asp:ListItem Value="3">Material mas observaciones</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100px; height: 16px;">
                                        Porc. de certificacion
                                    </td>
                                    <td style="height: 16px;">
                                        <asp:TextBox ID="txtPorcentajeCertificacion" Width="65px" runat="server" Style="text-align: right;"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="txtPorcentajeCertificacion"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:UpdatePanel ID="UpdatePanelDetallePreciosYCantidades" runat="server">
                        <ContentTemplate>
                            <table style="height: 29px; width: 632px; color: ">
                                <%----               ----%>
                                <tr>
                                    <td style="width: 100px; height: 16px;">
                                        Cantidad
                                    </td>
                                    <td style="height: 16px;" colspan="1">
                                        <asp:TextBox ID="txtDetCantidad" runat="server" Width="65px" Style="text-align: right;"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtDetCantidad"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
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
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator"
                                            ControlToValidate="txtDetCantidad" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                            Enabled="true" Operator="GreaterThan" ValueToCompare="0" Display="Dynamic" ValidationGroup="Detalle">* Debe ser mayor que 0</asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDetCantidad"
                                            ErrorMessage="* Ingrese Cantidad" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                            ValidationGroup="Detalle" />
                                        <cc1:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator3" CssClass="CustomValidatorCalloutStyle" />
                                    </td>
                                </tr>
                                <%----               ----%>
                                <tr>
                                    <td style="width: 100px; height: 10px;">
                                        Precio Unitario
                                    </td>
                                    <td style="height: 10px; width: 78px">
                                        <asp:TextBox ID="txtDetPrecioUnitario" runat="server" Width="65px" Style="text-align: right;"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDetCantidad"
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
                                        <asp:TextBox ID="txtDetIVA" runat="server" Style="text-align: right;" Width="70px"
                                            Visible="False" />
                                    </td>
                                    <td style="height: 10px; width: 69px">
                                        Bonif. %
                                    </td>
                                    <td style="height: 10px; width: 78px;">
                                        <asp:TextBox ID="txtDetBonif" runat="server" Style="text-align: right; margin-right: 0px;"
                                            Width="63px"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtDetBonif"
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
                        <asp:Label ID="Label5" runat="server" ForeColor="" Text="Destino"></asp:Label>
                    </td>
                    <td style=" width: 185px; height: 11px;" colspan="3">
                        <asp:DropDownList ID="cmbDestino" runat="server" Width="200px"/>
                    </td>
                </tr>
                                --%>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <%--<asp:AsyncPostBackTrigger ControlID="txtDetCantidad" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetPrecioUnitario" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetCosto" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                    <%----    Adjuntos           ----%>
                    <table style="width: 632px; visibility: hidden; display: none;">
                        <tr>
                            <td style="width: 100px; height: 20px;">
                                <asp:Label ID="Label24" runat="server" Text="Adjunto" ForeColor=""></asp:Label>
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
                        <tr>
                            <td style="width: 100px; height: 20px;">
                                <asp:Label ID="Label14" runat="server" ForeColor=""></asp:Label>
                            </td>
                            <td style="height: 20px">
                                <%--'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON!!!!--%>
                                <asp:LinkButton ID="lnkDetAdjunto2" runat="server" CausesValidation="False">LinkButton</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 632px; color: #FFFFFF;">
                        <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
                        --%>
                        <tr>
                            <td>
                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <div style="width: 632px; overflow: auto; height: 100px;" align="left">
                                                <asp:GridView ID="gvAuxOCsPendientes" runat="server" AutoGenerateColumns="False"
                                                    BackColor="" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                                    DataKeyNames="IdDetalleOrdenCompra,IdArticulo,Articulo,Precio,Cant_,Pendfacturar"
                                                    DataSourceID="odsOCsPendientes" GridLines="Horizontal" AllowPaging="True" Height="85%"
                                                    CssClass="t1" Width="600px">
                                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="true" SelectText=">>>" />
                                                        <asp:BoundField DataField="IdOrdenCompra" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                                            SortExpression="Id" Visible="False" />
                                                        <asp:BoundField DataField="IdDetalleOrdenCompra" HeaderText="Id" InsertVisible="False"
                                                            ReadOnly="True" SortExpression="Id" Visible="False" />
                                                        <asp:TemplateField HeaderText="Orden compra" SortExpression="Numero" ItemStyle-Width="50">
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Orden de compra") %>'></asp:TextBox>
                                                            </EditItemTemplate>
                                                            <ItemTemplate>
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("OCompra") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Articulo" HeaderText="Articulo" InsertVisible="False"
                                                            ReadOnly="True" SortExpression="Articulo" Visible="true" />
                                                        <asp:BoundField DataField="Cant_" HeaderText="Cant." InsertVisible="False" ReadOnly="True"
                                                            SortExpression="Cant_" Visible="true" />
                                                        <asp:BoundField DataField="Pendfacturar" HeaderText="Pend.facturar" InsertVisible="False"
                                                            ReadOnly="True" SortExpression="Pendfacturar" Visible="true" />
                                                        <asp:BoundField DataField="Importe" HeaderText="Importe" InsertVisible="False" ReadOnly="True"
                                                            SortExpression="Importe" Visible="true" />
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
                                                        //change the color of the previous row back to 
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
                                                <asp:ObjectDataSource ID="odsOCsPendientes" runat="server" OldValuesParameterFormatString="original_{0}"
                                                    SelectMethod="GetListTX" TypeName="Pronto.ERP.Bll.OrdenCompraManager" DeleteMethod="Delete"
                                                    UpdateMethod="Save">
                                                    <SelectParameters>
                                                        <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                                        <asp:Parameter Name="TX" DefaultValue="_DetallesPendientesDeFacturarPorIdCliente" />
                                                        <asp:Parameter Name="Parametros" DefaultValue="100" />
                                                        <%--Guarda con los parametros que le mete de prepo el odsRemitosPendientes_Selecting--%>
                                                    </SelectParameters>
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="SC" Type="String" />
                                                        <asp:Parameter Name="myRemito" Type="Object" />
                                                    </DeleteParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="SC" Type="String" />
                                                        <asp:Parameter Name="myRemito" Type="Object" />
                                                    </UpdateParameters>
                                                </asp:ObjectDataSource>
                                                <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                <asp:HiddenField ID="HFIdObra" runat="server" />
                                                <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                                                <br />
                                                <table style="height: 24px; width: 632px; visibility: hidden; display: none;">
                                                    <tr>
                                                        <td style="width: 100px; height: 46px;">
                                                        </td>
                                                        <td align="right" style="height: 46px">
                                                            <asp:Button ID="Button3" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                                                UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                                                            <asp:Button ID="Button4" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px" Font-Bold="False"
                                                                Height="25px" CausesValidation="False" Width="78px" />
                                                        </td>
                                                    </tr>
                                                </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <div style="width: 632px; overflow: auto; height: 100px;" align="left">
                                            <asp:GridView ID="gvAuxRemitosPendientes" DataSourceID="odsRemitosPendientes" runat="server"
                                                AutoGenerateColumns="False" Width="600px" GridLines="Horizontal" CssClass="t1"
                                                DataKeyNames="IdDetalleRemito" AllowPaging="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="IdDetalleRemito" HeaderText="ID" Visible="False" />
                                                    <asp:BoundField DataField="Remito" HeaderText="Remito" />
                                                    <asp:BoundField DataField="Item" HeaderText="Item" />
                                                    <asp:BoundField DataField="Cant_" HeaderText="Cant." />
                                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo" />
                                                    <asp:BoundField DataField="Pendiente" HeaderText="Pendiente" />
                                                    <asp:BoundField DataField="AFacturar" HeaderText="a Facturar" />
                                                </Columns>
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                            <asp:ObjectDataSource ID="odsRemitosPendientes" runat="server" DeleteMethod="Delete"
                                                InsertMethod="SaveBlock" OldValuesParameterFormatString="original_{0}" SelectMethod="GetListTX"
                                                TypeName="Pronto.ERP.Bll.RemitoManager">
                                                <SelectParameters>
                                                    <asp:Parameter Name="TX" DefaultValue="_DetallesPendientesDeFacturarPorIdCliente" />
                                                    <%--o por _DetallesPendientesDeFacturarPorIdDetalleOrdenCompra--%>
                                                    <%-- revisar odsRemitosPendientes_Selecting para pasar parametros--%>
                                                    <%--<asp:Parameter Name="Parametros(0)" DefaultValue="500" />--%>
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
                                        </div>
                                        <asp:DropDownList ID="cmbFiltrarRemitosPendientes" runat="server" AutoPostBack="true">
                                            <asp:ListItem Text="Los del cliente" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Los de la orden"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <table style="width: 632px;">
                        <tr>
                            <td style="width: 200px; height: 46px;" align="left">
                            </td>
                            <td align="right" style="height: 46px">
                                <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                    UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="Detalle" />
                                <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                    UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                    Height="25px" CausesValidation="False" Width="78px" />
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
            <asp:AsyncPostBackTrigger ControlID="txtDetCosto" EventName="TextChanged" />
            <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />--%>
            </Triggers>
        </asp:UpdatePanel>
        
        <asp:LinkButton ID="LinkImprimirXMLFactElectronica" runat="server" Font-Bold="False" ForeColor="" Font-Size="Small"
            Height="20px" Width="150px" ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
            margin-top: 0px; margin-bottom: 6px;" CausesValidation="False" TabIndex="10" Visible=false
            Font-Underline="False">
            <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
                text-decoration: none;" />
            <asp:Label ID="Label5" runat="server" ForeColor="" Text="PDF" Font-Underline="True"></asp:Label></asp:LinkButton>



        <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="" Font-Size="Small"
            Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
            margin-top: 0px; margin-bottom: 6px;" CausesValidation="False" TabIndex="10" Visible=false
            Font-Underline="False">
            <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
                text-decoration: none;" />
            <asp:Label ID="Label29" runat="server" ForeColor="" Text="Texto" Font-Underline="True"></asp:Label></asp:LinkButton>


        <asp:LinkButton ID="LinkImprimirXML" runat="server" Font-Bold="False" ForeColor=""  Visible=true
            Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
            TabIndex="10" Font-Underline="False">
            <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
                text-decoration: none;" />
            <asp:Label ID="Label3" runat="server" ForeColor="" Text="DOCX" Font-Underline="True"></asp:Label></asp:LinkButton>



        <asp:LinkButton ID="LinkEditarXML" runat="server" Font-Bold="False" ForeColor=""
            Font-Size="Small" Height="20px" Width="" ValidationGroup="Encabezado" BorderStyle="None"
            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
            TabIndex="10" Font-Underline="False" Text="Descargar plantilla" />
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton3" runat="server" Font-Bold="False" ForeColor="" Enabled=true
            Font-Size="Small" Height="20px" Width="" ValidationGroup="Encabezado" BorderStyle="None"
            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
            TabIndex="10" Font-Underline="False" Text="Exportar a Amaggi" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="False" ForeColor="" Enabled=true
            Font-Size="Small" Height="20px" Width="" ValidationGroup="Encabezado" BorderStyle="None"
            Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" CausesValidation="False"
            TabIndex="10" Font-Underline="False" Text="Cartas Imputadas" />

        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete=""
            CompleteBackColor="Lime" ErrorBackColor="Red" />
        <%--puse AutoID por los problemas de Server Response Error. No se cuales son las consecuencias--%>
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

                //f.click();
            }

        </script>
        <%-- revisar odsRemitosPendientes_Selecting para pasar parametros--%>
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" ForeColor="" Text="Adjuntos Williams" Font-Underline="false"></asp:Label>
        <asp:Button runat="server" ID="btnDescargaAdjuntosDeFacturacionWilliams" Text="Texto" />
        <asp:Button runat="server" ID="btnDescargaAdjuntosDeFacturacionWilliamsA4" Text="Texto A4" />
        <asp:Button runat="server" ID="btnDescargaAdjuntosDeFacturacionWilliamsFormatoAcondicionadoras"
            Text="Adjuntos Acondicionadoras" Visible="false" />
        <asp:Button runat="server" ID="Button6" Text="EXCEL" />
        <asp:Button runat="server" ID="btnEnvioMailAdjuntosWilliams" Text="Enviar mail a " />
        <asp:TextBox runat="server" ID="txtDireccionMailAdjuntoWilliams" Width="200px" autocomplete="off"></asp:TextBox>
        <asp:Button runat="server" ID="btnAdjuntosBLD" Text="Formato BLD" />
        <br />
        <div class="EncabezadoCell" style="border: none; width: 700px; margin-top: 5px;">
            Cartas porte imputadas:
            <asp:Label ID="lblLinksAcartasImputadas" runat="server" ForeColor="" Text="" Font-Underline="false"></asp:Label>
            <br />
        </div>
        <asp:UpdatePanel ID="UpdatePanelGrillaConsulta" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="False" Font-Size="Small" ValidationGroup="Encabezado"
                    Visible="false" Height="20"> Items de remitos</asp:LinkButton>
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
                            onfocus="select();" AutoPostBack="True"></asp:TextBox>
                    </div>
                    <br />
                    <asp:RadioButton ID="RadioButtonPendientes" runat="server" Text="Pendientes" Visible="False" />
                    <asp:RadioButton ID="RadioButtonAlaFirma" runat="server" Text="a la Firma" Visible="False" />
                    <asp:Button ID="btnAceptarPopupGrilla" runat="server" Font-Size="Small" Text="Aceptar"
                        CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                    <asp:Button ID="btnCancelarPopupGrilla" runat="server" Font-Size="Small" Text="Cancelar"
                        CssClass="but" UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px"
                        Font-Bold="False" Height="25px" CausesValidation="False" Width="78px" />
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
                    ForeColor="" CausesValidation="true" Font-Size="Small" Visible="false" Height="20"
                    ValidationGroup="Encabezado"> Asignar item de orden de compra</asp:LinkButton>
                <br />
                <%--            <asp:Button ID="dummy" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />--%>
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="LinkButton2"
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
                    <asp:TextBox ID="TextBox3" runat="server" Style="text-align: right; margin-top: 10px;
                        margin-left: 10px" Text="" AutoPostBack="True"></asp:TextBox>
                    <br />
                    <br />
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
        <asp:UpdatePanel ID="UpdatePanel9" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:LinkButton ID="LinkButton10" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="False" Font-Size="Small" Height="30px" ValidationGroup="Encabezado"
                    Visible="true"> Devolucion de anticipos </asp:LinkButton>
                <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                <asp:Button ID="Button2" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                    display: none" />
                <%--style="visibility:hidden;"/>--%>
                <br />
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender5" runat="server" TargetControlID="Button2"
                    PopupControlID="Panel2" OkControlID="" CancelControlID="" DropShadow="False"
                    BackgroundCssClass="modalBackground" />
                <asp:Panel ID="Panel2" runat="server" CssClass="modalPopup" Width="300">
                    <table style="color: #FFFFFF; width: 300px">
                        <tr>
                            <td style="width: 80px;">
                                Aplicar devolucion
                            </td>
                            <td>
                                <asp:TextBox ID="txtPorcentajeDevolucionAnticipo" runat="server" AutoPostBack="false"
                                    Style="text-align: right;" Width="40px" Font-Size="X-Small"></asp:TextBox>%
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 80px;">
                                Articulo
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbArticulosDevolucion" runat="server" CssClass="CssCombo">
                                </asp:DropDownList>
                                <%--                                    <asp:TextBox ID="txtAutoCompleteDevolucionArticulo" runat="server" autocomplete="off" AutoCompleteType="None"
                                        Width="400px" AutoPostBack="false" Style="margin-left: 0px"
                                        Enabled="true"></asp:TextBox>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender3" runat="server"
                                        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceArticulos.asmx" TargetControlID="txtAutoCompleteDevolucionArticulo" UseContextKey="true"
                                        OnClientItemSelected="SetSelectedAutoCompleteIDArticulo" CompletionListElementID='ListDivisorDev'
                                        CompletionListCssClass="AutoCompleteScroll" />
                                                                            <div id="ListDivisorDev" /> --%>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 80px;">
                            </td>
                            <td align="right">
                                <asp:Button ID="btnAceptaDevolucion" runat="server" Font-Size="Small" Text="Aceptar"
                                    CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" />
                                <asp:Button ID="Button8" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                    UseSubmitBehavior="False" Style="margin-left: 28px;" Font-Bold="False" Height="25px"
                                    CausesValidation="False" Width="78px" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
        <%--Guarda con los parametros que le mete de prepo el odsRemitosPendientes_Selecting--%>
        <div style="border: none; width: 700px; margin-top: 5px;">
            <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <table style="margin: 0px 0px 0px 500px; padding: 0px; border-style: none; border-width: thin;
                        width: 200px; border-spacing: 0px; color: #FFFFFF;" id="TablaResumen" cellpadding="2"
                        cellspacing="3">
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
                                Bonif
                                <asp:TextBox ID="txtTotBonif" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                    Style="text-align: right;" Width="40px" Font-Size="X-Small"></asp:TextBox>
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
                                IVA
                            </td>
                            <td align="right" style="">
                                <asp:Label ID="lblTotIVA" runat="server" ForeColor="" Width="80px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 191px;">
                                Percep IIBB
                            </td>
                            <td align="right" style="">
                                <asp:Label ID="lblTotIngresosBrutos" runat="server" ForeColor="" Width="76px" Height="16px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 191px;">
                                Percep IVA
                            </td>
                            <td align="right" style="">
                                <asp:Label ID="lblTotPercepcionIVA" runat="server" ForeColor="" Width="76px" Height="16px"></asp:Label>
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
            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
            <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
            --%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" />
                            <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor=""
                                Visible="False"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick="if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                        UseSubmitBehavior="False" Width="82px" Style="margin-right: 30px" ValidationGroup="Encabezado">
                    </asp:Button>
                    <%--le saqué el CssClass="but"--%>
                    <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="butcancela"
                        Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Width="79px"
                        Font-Bold="False" Style="margin-right: 30px" Font-Size="Small"></asp:Button>
                    <%--ni los Facturas ni las comparativas se anulan--%>
                    <asp:Button ID="btnAnular" runat="server" CssClass="butcancela" Text="Anular" CausesValidation="False"
                        UseSubmitBehavior="False" Width="63px" Font-Bold="False" Style="" Font-Size="Small"
                        TabIndex="13"></asp:Button>
                    <br />
                </ContentTemplate>
            </asp:UpdatePanel>
            <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
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
                                    <span style="color: #ffffff">
                                        <br />
                                        <asp:Label ID="LblPreRedirectMsgbox" runat="server" ForeColor=""></asp:Label><br />
                                        <br />
                                        <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="Sí" />
                                        <asp:Button ID="ButVolverSinImprimir" runat="server" CssClass="imp" Text="No" />
                                        <br />
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel3" runat="server" Height="87px" Visible="false">
                        <table style="" class="t1">
                            <tr>
                                <td align="center" style="font-weight: bold; color: ; background-color: red; height: 14px;">
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
                        <td align="center" style="font-weight: bold; color: ; background-color: red; height: 14px;">
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
                        CssClass="modalPopup" Style="vertical-align: middle; text-align: center" ForeColor="">
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
                    <asp:Panel ID="Panel5" runat="server" Height="250px" Style="vertical-align: middle;
                        text-align: center" Width="220px" BorderColor="Transparent" ForeColor="" CssClass="modalPopup">
                        <div align="center" style="height: 200px; width: 220px">
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
                            <asp:CheckBox runat="server" ID="chkLiberarCDPs" Text="Liberar CDPs incluidas" Checked="true" />
                            <br />
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
            <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
            <script type="text/javascript">

                function fnClickOK(sender, e) {
                    __doPostBack(sender, e)
                }
            </script>
            <%--style="visibility:hidden;"/>--%>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:TextBox ID="TextBox1" runat="server" Width="48px" Enabled="False" Visible="False"
                Height="27px"></asp:TextBox>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel10" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:reportviewer id="ReporteLocal" runat="server" font-names="Verdana" font-size="8pt"
                    width="95%" visible="true" zoommode="PageWidth" height="1200px" sizetoreportcontent="True"
                    backcolor="White">
                    <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                    --%>
                </rsweb:reportviewer>
                <span>
                    <%--<div>--%>
                    <%--botones de alta y excel--%>
                    <%--</div>--%>
                </span>
            </div>
            <asp:Label ID="Label4" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
