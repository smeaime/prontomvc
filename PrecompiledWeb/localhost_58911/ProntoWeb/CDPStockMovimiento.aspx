<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CDPStockMovimiento, App_Web_y4lmf2kj" title="Untitled Page" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
            //var porccertif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtPorcentajeCertificacion").value);
            //alert("2");

            var bonif = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetBonif").value);

            var total = getObj("ctl00_ContentPlaceHolder1_txtDetTotal");

            //        if (getObj("ctl00_ContentPlaceHolder1_txtDetIVA") != null)
            //            iva = parseFloat(getObj("ctl00_ContentPlaceHolder1_txtDetIVA").value);
            //        else
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
                <table style="padding: 0px; border: none #FFFFFF; width: 699px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr style="">
                        <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                            font-size: large;" align="left" valign="top">
                            Movimiento
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
                    <%--        <tr>
                <td class= "EncabezadoCell" style=" visibility: hidden;" colspan="4">
                </td>
                
          
        </tr>--%>
                    <tr>
                        <td class="EncabezadoCell" style="width: ;">
                            Ingreso
                        </td>
                        <td class="EncabezadoCell" style="width: ;">
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
                        <%--boton de agregar--%>
                        <td class="EncabezadoCell" style="width: 15%; height: 23px;">
                            Punto venta
                        </td>
                        <td class="EncabezadoCell " style="width: 35%; height: 23px;">
                            <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssCombo" TabIndex="2"
                                Width="50px" />
                                    <asp:HyperLink ID="linkFactura" Target="_blank" runat="server" Text="Ir a" visible=true></asp:HyperLink>
                                    <asp:LinkButton ID="butVerLog" Text="Historial"  runat="server" CausesValidation=false visible=false />
                                         
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 15%;">
                            Tipo
                        </td>
                        <td class="EncabezadoCell" style="width: 35%;">
                            <asp:DropDownList ID="cmbTipoMovimiento" runat="server" CssClass="CssCombo" AutoPostBack="true">
                                <%--- PRESTAMO: ES CUANDO UN EXPORTADOR LE PRESTA MERCADERIA DE SU STOCK A OTRO DENTRO DE LA TERMINAL.
- TRANSFERENCIA: ES CUANDO UN EXPORTADOR LE TRANSFIERE A OTRO MERCADERIA.
- DEVOLUCION: ES CUANDO UN EXPORTADOR LE DEVUELVE A OTRO EL PRESTAMO QUE LE HABIA HECHO CON ANTERIORIDAD.
- EMBARQUE: ES CUANDO UN EXPORTADOR EMBARCA MERCADERIA EN UN BUQUE.
- VENTA: ES CUANDO UN EXPOTADOR RELIZA UNA VENTA A OTRO DENTRO DE UNA TERMINAL.
                                --%>
                                <asp:ListItem Text="Préstamo" Value="1" />
                                <asp:ListItem Text="Transferencia" Value="2" />
                                <asp:ListItem Text="Devolución" Value="3" />
                                <asp:ListItem Text="Embarque" Value="4" />
                                <asp:ListItem Text="Venta" Value="5" />
                            </asp:DropDownList>
                        </td>
                        <td class="EncabezadoCell" style="width: ;">
                        </td>
                        <td class="EncabezadoCell" style="">
                            <asp:RadioButtonList ID="RadioButtonListEntradaSalida" ForeColor="White" runat="server"
                                Style="margin-left: 0px" AutoPostBack="True" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1" Selected="True">Entrada  </asp:ListItem>
                                <asp:ListItem Value="2">Salida</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <tr>
                            <td class="EncabezadoCell" style="width: ;">
                                De exportador
                            </td>
                            <td class="EncabezadoCell" style="width: ;">
                                <asp:TextBox ID="txtDeExportador" runat="server" autocomplete="off" CssClass="CssTextBox"
                                    AutoPostBack="false"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12"
                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                    TargetControlID="txtDeExportador" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDeExportador"
                                    ErrorMessage="* Ingrese un cliente" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    ValidationGroup="Encabezado" Style="display: none" />
                                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                                    Enabled="True" TargetControlID="RequiredFieldValidator2" CssClass="CustomValidatorCalloutStyle" />
                            </td>
                            <td class="EncabezadoCell" style="width: 90px;">
                                A exportador
                            </td>
                            <td class="EncabezadoCell" style="">
                                <asp:TextBox ID="txtAExportador" runat="server" autocomplete="off" CssClass="CssTextBox"
                                    AutoPostBack="false"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                    TargetControlID="txtAExportador" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                    FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAExportador"
                                    ErrorMessage="* Ingrese un cliente" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    ValidationGroup="Encabezado" Style="display: none" />
                                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                                    Enabled="True" TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                                <asp:Button ID="btnTraerDatosClientes" runat="server" Text="YA" Width="30px" Height="22px"
                                    CausesValidation="False" Style="visibility: hidden;" />
                            </td>
                            </td>
                        </tr>
                        <tr style="visibility: hidden; display: none;">
                            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                            <td class="EncabezadoCell" style="width: ;">
                            </td>
                            <td class="EncabezadoCell" style="width: ;">
                            </td>
                            <%--style="visibility:hidden;"/>--%>
                            <td class="EncabezadoCell" style="width: ;">
                            </td>
                            <td class="EncabezadoCell">
                            </td>
                        </tr>
                </table>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="padding: 0px; border: none #FFFFFF; width: 698px; margin-right: 0px;"
                            cellpadding="3" cellspacing="3">
                            <tr>
                                <td class="EncabezadoCell" style=" width: 15% ;">
                                    Contrato
                                </td>
                                <td class="EncabezadoCell" style="width: 35% ;">
                                    <asp:TextBox ID="txtContrato" runat="server" Width="110px" Enabled="true"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15% ;">
                                    Puerto
                                </td>
                                <td class="EncabezadoCell" style="">
                                    <asp:TextBox ID="txtPuerto" runat="server" CssClass="CssTextBox" Enabled="true"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender8" runat="server" CompletionSetCount="12"
                                        EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceWilliamsDestinos.asmx" TargetControlID="txtPuerto" UseContextKey="true"
                                        CompletionListCssClass="AutoCompleteScroll" FirstRowSelected="true" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtPuerto"
                                        ErrorMessage="* Ingrese un puerto" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator9" CssClass="CustomValidatorCalloutStyle" />
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15% ;">
                                    Vapor
                                </td>
                                <td class="EncabezadoCell" style="width:35%  ;">
                                    <asp:TextBox ID="txtVapor" runat="server" Width="110px" Enabled="true"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width:15%  ;">
                                    Número
                                </td>
                                <td class="EncabezadoCell" style="">
                                    <asp:TextBox ID="txtNumero" runat="server" Width="110px" Enabled="true"></asp:TextBox>
                                </td>
                            </tr>
                            
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="padding: 0px; border: none #FFFFFF; width: 703px; margin-right: 0px;
                    display: none;" cellpadding="1" cellspacing="3">
                    <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                    <tr>
                        <td class="EncabezadoCell" style="width: 15%; display: none;">
                        </td>
                        <td class="EncabezadoCell" style="width: 200px;">
                            <asp:DropDownList ID="cmbMoneda" runat="server" CssClass="CssCombo" Visible="False" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px;">
                            <asp:Label ID="Label344" runat="server" Text="Mostrar en Pronto" ForeColor="White"
                                Font-Size="Small" Visible="False"></asp:Label>
                        </td>
                        <td style="" class="EncabezadoCell">
                            <asp:CheckBox ID="chkConfirmadoDesdeWeb" runat="server" ForeColor="White" Text=""
                                TextAlign="right" Font-Size="Small" Visible="False" />
                        </td>
                    </tr>
                </table>
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
    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto; width: 702px">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="Transparent"
                    BorderColor="White" BorderWidth="1px" DataKeyNames="IdCDPMovimiento" GridLines="Horizontal"
                    Width="702px" class="DetalleGrilla" CellPadding="3">
                    <FooterStyle BackColor="#507CBB" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="CodigoArticulo" HeaderText="Producto" Visible="false" />
                        <asp:TemplateField HeaderText="Producto" SortExpression="Articulo" HeaderStyle-HorizontalAlign="Left">
                            <ItemStyle Wrap="True" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Articulo" runat="server" Text='<%# Eval("IdArticulo") %>'
                                    Width="400" AutoPostBack="false" Enabled="true" />
                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender200" runat="server"
                                    CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                    ServicePath="WebServiceArticulos.asmx" TargetControlID="txtGrillaDetAC_Articulo"
                                    UseContextKey="true" CompletionListElementID='ListDivisor2' CompletionListCssClass="AutoCompleteScroll" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtGrillaDetAC_Articulo"
                                    ErrorMessage="* Ingrese producto" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                    Style="display: none" />
                                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender100" runat="server"
                                    Enabled="True" TargetControlID="RequiredFieldValidator6" CssClass="CustomValidatorCalloutStyle" />
                                <div id="ListDivisor2">
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Kilos" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Cantidad" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("Cantidad")  %>' Width="100" Enabled="true" />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla" runat="server" TargetControlID="txtGrillaDetAC_Cantidad"
                                    ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                            Visible="false" HeaderStyle-Font-Size="X-Small">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado"
                            Visible="false">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
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
                Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;" Visible="false"
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
                        <table style="height: 97px; width: 632px; color: white">
                            <tr>
                                <td style="width: 80px; height: 32px; position: relative;">
                                    Item
                                </td>
                                <td style="width: 159px">
                                    <asp:TextBox ID="txtDetItem" runat="server" Enabled="False" Width="31px"></asp:TextBox>
                                </td>
                                <td colspan="2" title="Forma de cancelación">
                                    <asp:RadioButtonList ID="RadioButtonListFormaCancelacion" ForeColor="White" runat="server"
                                        Style="margin-left: 0px" AutoPostBack="True" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1" Selected="True">por Cantidad</asp:ListItem>
                                        <asp:ListItem Value="2">por Certificación</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <%----fecha               ----%>
                            <tr style="visibility: visible; display: none;">
                                <td style="width: 15%;">
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
                            <tr style="visibility: visible">
                                <td style="width: 15%">
                                    Artículo
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtCodigo" runat="server" Width="71px" AutoPostBack="True" Enabled="true"></asp:TextBox>
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_AC_Articulo"
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
                        <asp:Label ID="lblArticulo" runat="server" Text="Artículo" ForeColor="White"></asp:Label>
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
                                <td style="width: 15%; height: 16px;">
                                    Observacion
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetObservaciones" runat="server" Width="298px" Height="48px"
                                        TextMode="MultiLine"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonListDescripcion" ForeColor="White" runat="server"
                                        Style="margin-left: 0px" AutoPostBack="True">
                                        <asp:ListItem Value="1" Selected="True">Solo el material</asp:ListItem>
                                        <asp:ListItem Value="2">Solo las observaciones</asp:ListItem>
                                        <asp:ListItem Value="3">Material mas observaciones</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanelDetallePreciosYCantidades" runat="server">
                    <ContentTemplate>
                        <table style="height: 29px; width: 632px; color: #FFFFFF;">
                            <%----               ----%>
                            <tr>
                                <td style="width: 15%; height: 16px;">
                                    Cantidad
                                </td>
                                <td style="height: 16px;" colspan="1">
                                    <asp:TextBox ID="txtDetCantidad" runat="server" Width="65px" Style="text-align: right;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtDetCantidad"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
                                </td>
                                <td colspan="2" style="height: 16px;" align="left">
                                    <asp:UpdatePanel ID="Updatepanel11" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cmbDetUnidades" runat="server" AutoPostBack="True" Enabled="true"
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
                                <td style="width: 15%; height: 10px;">
                                    Partida
                                </td>
                                <td style="height: 10px; width: 78px">
                                    <asp:TextBox ID="txtDetPartida" runat="server" Width="65px" Style="text-align: right;"
                                        AutoPostBack="True"></asp:TextBox>
                                </td>
                                <td style="height: 10px; width: 69px">
                                    Ubicación
                                </td>
                                <td style="height: 10px; width: 78px;">
                                    <asp:DropDownList ID="cmbUbicacion" runat="server" AutoPostBack="True" Enabled="true"
                                        Width="73px" Height="22px" />
                                </td>
                            </tr>
                            <tr style="visibility: hidden; display: none">
                                <td style="width: 15%; height: 10px;">
                                    Precio Unitario
                                </td>
                                <td style="height: 10px; width: 78px">
                                    <asp:TextBox ID="txtDetPrecioUnitario" runat="server" Width="65px" Style="text-align: right;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtDetCantidad"
                                        ValidChars=".1234567890">
                                    </cc1:FilteredTextBoxExtender>
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
                                <td style="height: 10px; width: 68px" colspan="2">
                                    IVA %
                                </td>
                                <td style="height: 10px; width: 96px">
                                    <asp:TextBox ID="txtDetIVA" runat="server" Style="text-align: right;" Width="70px"></asp:TextBox>
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
                        <asp:AsyncPostBackTrigger ControlID="txtDetCantidad" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetPrecioUnitario" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetIVA" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtDetBonif" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <%----    Adjuntos           ----%>
                <table style="height: 24px; width: 632px">
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
                    <tr style="display: none">
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
                    <tr>
                        <td style="width: 15%; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="Detalle" />
                            <asp:Button ID="btnCancelItem" runat="server" Text="Cancelar" CssClass="butCancela"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px" CausesValidation="False" />
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
        Font-Underline="False">
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
                Visible="False"> Ver RMs a comprar</asp:LinkButton>
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
                ForeColor="White" CausesValidation="true" Font-Size="Small" Height="20px" Visible="false"
                ValidationGroup="Encabezado"> Asignar item de orden de compra</asp:LinkButton>
            <br />
            <asp:Button ID="dummy" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="dummy"
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
                        <asp:TextBox ID="TextBox3" runat="server" Style="text-align: right; margin-top: 10px;
                            margin-left: 10px" Text="buscar" AutoPostBack="True"></asp:TextBox>
                        <br />
                        <br />
                        <div style="width: 720px; height: 380px; overflow: auto" align="center">
                            <asp:Button ID="Button200" runat="server" Text="..." Font-Bold="False" Visible="False" />
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdOrdenCompra,IdDetalleOrdenCompra"
                                DataSourceID="ObjectDataSource2" GridLines="Horizontal" AllowPaging="True" Height="85%"
                                CssClass="t1" Width="700px">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="false" />
                                    <asp:BoundField DataField="IdOrdenCompra" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <asp:TemplateField HeaderText="">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdOrdenCompra" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <asp:TemplateField HeaderText="Número" SortExpression="Numero" ItemStyle-Width="50">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Orden de compra") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Orden de compra") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha" SortExpression="Fecha" ItemStyle-Width="50">
                                        <EditItemTemplate>
                                            &nbsp;&nbsp;
                                            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("Fecha") %>'>
                                            </asp:Calendar>
                                        </EditItemTemplate>
                                        <ControlStyle Width="100px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Fecha", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cliente" SortExpression="Cliente" HeaderStyle-Width="50"
                                        ItemStyle-Width="50">
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle Wrap="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Cliente") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Articulo" HeaderText="Articulo" InsertVisible="False"
                                        ReadOnly="True" SortExpression="Articulo" Visible="true" />
                                    <asp:BoundField DataField="Cant_" HeaderText="Cant." InsertVisible="False" ReadOnly="True"
                                        SortExpression="Cant." Visible="true" />
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
                                SelectMethod="GetListTX" TypeName="Pronto.ERP.Bll.OrdenCompraManager" DeleteMethod="Delete"
                                UpdateMethod="Save">
                                <SelectParameters>
                                    <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:Parameter Name="TX" DefaultValue="_ItemsPendientesDeRemitirPorIdCliente" />
                                    <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
                                    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.CDPStockMovimientoManager"
                                DeleteMethod="Delete" UpdateMethod="Save">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                    <asp:Parameter Name="id" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="SC" Type="String" />
                                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:HiddenField ID="HFIdObra" runat="server" />
                            <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                </div>
                <table style="height: 24px; width: 720px">
                    <tr>
                        <td style="width: 15%; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="Button3" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                            <asp:Button ID="Button4" runat="server" Text="Cancelar" CssClass="butCancela" UseSubmitBehavior="False"
                                Style="margin-left: 28px; margin-right: 14px" CausesValidation="False" />
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
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
    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
    <div style="border: none; width: 700px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="margin: 0px 0px 0px 500px; padding: 0px; border-style: none; border-width: thin;
                    width: 200px; border-spacing: 0px; color: white; visibility: hidden; display: none;"
                    id="TablaResumen" cellpadding="0" cellspacing="0">
                    <%--                    <tr>
                        <td style="height: 26px; width: 191px;">
                            SUBTOTAL
                        </td>
                        <td align="right" style="height: 26px;">
                            <asp:Label ID="txtSubtotal" runat="server" ForeColor="White" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px; height: 16px;">
                            <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Bonif por item"></asp:Label>
                        </td>
                        <td style="height: 16px;" align="right">
                            <asp:Label ID="txtBonificacionPorItem" runat="server" ForeColor="White" Width="74px"
                                Height="16px"></asp:Label>
                        </td>
                    </tr>
                    --%>
                    <tr>
                        <td style="width: 191px; height: 16px;">
                            Valor declarado
                        </td>
                        <td align="right" style="height: 16px;">
                            <asp:TextBox ID="txtValorDeclarado" runat="server" AutoPostBack="false" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right;" Width="40px" Height="16px"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtValorDeclarado"
                                ValidChars=".1234567890">
                            </cc1:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtValorDeclarado"
                                ErrorMessage="* Ingrese el valor declarado" Font-Size="Small" ForeColor="#FF3300"
                                Font-Bold="True" ValidationGroup="" Style="display: none" />
                            <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server"
                                Enabled="True" TargetControlID="RequiredFieldValidator7" CssClass="CustomValidatorCalloutStyle"
                                PopupPosition="TopLeft" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px; height: 16px;">
                            Total bultos
                        </td>
                        <td align="right" style="height: 16px;">
                            <asp:TextBox ID="txtBultos" runat="server" AutoPostBack="false" OnTextChanged="RecalcularTotalComprobante"
                                Style="text-align: right;" Width="40px" Height="16px"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="txtBultos"
                                ValidChars=".1234567890">
                            </cc1:FilteredTextBoxExtender>
                        </td>
                    </tr>
                    <%--                    <tr>
                        <td style="width: 191px; height: 16px;">
                            <asp:Label ID="Label27" runat="server" ForeColor="White" Text="Subtotal Gravado"></asp:Label>
                        </td>
                        <td align="right" style="height: 16px">
                            <asp:Label ID="lblTotSubGravado" runat="server" ForeColor="White" Width="76px" Height="16px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 16px; width: 191px;">
                            <asp:Label ID="Label15" runat="server" ForeColor="White" Text="IVA"></asp:Label>
                        </td>
                        <td align="right" style="height: 16px;">
                            <asp:Label ID="lblTotIVA" runat="server" ForeColor="White" Width="80px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 191px">
                            <asp:Label ID="Label35" runat="server" ForeColor="White" Text="TOTAL"></asp:Label>
                        </td>
                        <td align="right" style="height: 26px;">
                            <asp:Label ID="txtTotal" runat="server" ForeColor="White" Width="80px" Style="margin-left: 6px"></asp:Label>
                        </td>
                    </tr>--%>
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
                <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick="if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                    UseSubmitBehavior="False" Style="margin-left: 0px; margin-right: 30px" ValidationGroup="Encabezado">
                </asp:Button>
                <%--le saqué el CssClass="but"--%>
                <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="butcancela"
                    Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Style="margin-right: 30px">
                </asp:Button>
                <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                    Width="82px" UseSubmitBehavior="False" Font-Bold="False" Style="" Font-Size="Small">
                </asp:Button>
                <br />
                <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
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
                                    <asp:Button ID="ButVolverSinImprimir" runat="server" CssClass="imp" Text="No" /><br />
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
                    <div align="center" style="height: 170px; width: 35%">
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
