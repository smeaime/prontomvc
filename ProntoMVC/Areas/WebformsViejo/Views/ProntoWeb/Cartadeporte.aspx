<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Cartadeporte.aspx.vb" Inherits="CartadeporteABM" Title="Untitled Page"
    EnableEventValidation="false" %>

<%--lo del enableeventvalidation lo puse porque tenia un problema con este abm. no copiarlo a los demas abms--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>--%>
    <%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
        rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <style>a
        body
        {
            line-height: 16px;
        }
        
        input
        {
            display: inline-block;
            height: 12px !important;
            padding: 2px 2px;
        }
         select 
        {
            display: inline-block;
            height: 12px !important;
            padding: 2px 2px;
        }
        
        EncabezadoCell
        {
            line-height: 16px;
        }
    </style>--%>
    <script type="text/javascript">

        //        http: //stackoverflow.com/questions/680241/resetting-a-multi-stage-form-with-jquery
        function resetForm($form) {
            var f = $("#txtFechaArribo").val();
            var c = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbCosecha").value;
            var p = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbPuntoVenta").value;


            $form.find('input:text, input:password, input:file, select').val('');
            $form.find('input:radio, input:checkbox')
                .removeAttr('checked').removeAttr('selected');

            //emparcho la fecha de arribo que se arruina por el reseteo
            var myDate = new Date();
            var prettyDate = myDate.getDate() + '/' + (myDate.getMonth() + 1) + '/' + myDate.getFullYear();

            //  $("#txtFechaArribo").val(prettyDate);
            // $("#txtFechaArribo").datepicker('setDate', new Date()); //http://stackoverflow.com/questions/233553/how-do-i-pre-populate-a-jquery-datepicker-textbox-with-todays-date

            $("#txtFechaArribo").val(f);
            //alert(c);
            $("#cmbCosecha").val(c);
            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbCosecha").value = c;
            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbPuntoVenta").value = p;

            //var fechaArribo = getDateFromFormat(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo").value, "dd/MM/yyyy");
            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo").value = prettyDate; //  '1/1/2001';

            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtPorcentajeHumedad").value = 0;

            //            a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo");
            //            a.value = ;


            //  pongo el foco en el numero
            var tabContainer = $find('ctl00_ContentPlaceHolder1_TabContainer2');
            a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNumeroCDP");
            tabContainer.set_activeTabIndex(0);
            a.focus();



        }

    </script>
    <script type="text/javascript">



        //            http: //www.scottklarr.com/topic/126/how-to-create-ctrl-key-shortcuts-in-javascript/
        //            http: //www.scottklarr.com/topic/126/how-to-create-ctrl-key-shortcuts-in-javascript/

        var isCtrl = false;
        document.onkeyup = function (e) {
            var event = e || window.event;
            if (event.which == 18) isCtrl = false;
            //            if (event.which == 18) {
            //                event.preventDefault();
            //            }
        }

        document.onkeydown = function (e) {


            var event = e || window.event;
            var ccode = event.keyCode ? event.keyCode : event.which ? event.which : null;
            //alert(e.which);

            //guarda, que el preventdefault desactiva el tab!!! -Tambien el eco de caracteres normales!!!!!
            //if (event.preventDefault && ccode!=9) event.preventDefault(); //para evitar el comportamiento de la hotkey en el browser

            var tabdestino = -1;
            var tabContainer = $find('ctl00_ContentPlaceHolder1_TabContainer2');

            if (ccode == 18) { //estoy usando ALT en lugar de CTRL
                isCtrl = true;
                //alert(e.which);
                // event.preventDefault();
            }
            else {
                //alert(event);
            }



            if ((ccode == 49 || ccode == 49) && isCtrl == true) { // P (code 80) o 1
                //run code for CTRL+S -- ie, save!
                tabdestino = 0;
                //event.preventDefault();
            }

            if ((ccode == 50 || ccode == 50) && isCtrl == true) {  // D (code 68) o 2
                //run code for CTRL+O -- ie, open!
                tabdestino = 1;
                //event.preventDefault();
            }

            if ((ccode == 51 || ccode == 51) && isCtrl == true) { //C (code 67) o 3   
                //run code for CTRL+T -- ie, new tab!
                tabdestino = 2;
                //event.preventDefault();
            }

            if (ccode == 220 || ccode == 186 || ccode == 124) {
                if (tabContainer.get_activeTabIndex() < 2) {
                    tabdestino = tabContainer.get_activeTabIndex() + 1; //Sets to Tab 1
                }
                else tabdestino = 0;
            }


            //alert(e.which);


            if (tabdestino >= 0 && tabdestino <= 2) {


                if (tabdestino == 0) {
                    a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNumeroCDP");
                    //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNumeroCDP");
                }
                else if (tabdestino == 1) {
                    a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtFechaDescarga");
                    //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtFechaRequerimiento");
                    //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNRecibo");

                }
                else if (tabdestino == 2) {
                    a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox26");
                }


                tabContainer.set_activeTabIndex(tabdestino);
                a.focus();
                isCtrl = false;
                return false; //este es vital para que no haya eco de caracteres y no se despliegue el calendario
            }



        }
        //            http: //www.scottklarr.com/topic/126/how-to-create-ctrl-key-shortcuts-in-javascript/
        //            http: //www.scottklarr.com/topic/126/how-to-create-ctrl-key-shortcuts-in-javascript/
    </script>
    <div style="width: 700px; margin-top: 3px; height: auto;">
        <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;
            font-size: large;" cellpadding="1" cellspacing="1">
            <%--  <tr>
                <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                    font-size: large; height: 12px;" align="left" valign="top">
                    CARTA DE PORTE
                  
                </td>
               
            </tr>--%>
            <tr>
                <td class="EncabezadoCell" style="width: 210px; font-weight: bold; font-size: 20px;">
                    CARTA DE PORTE
                </td>
                <td class=" " colspan="3">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div>
                                    <a href="javascript:;" accesskey="f"></a>
                                    <asp:TextBox ID="txtNumeroCDP" runat="server" Width="120px" TabIndex="2" AutoPostBack="True"
                                        Font-Bold="true" Font-Size="24px" Height="24px" MaxLength="10" Style="font-weight: 900;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender441" runat="server" TargetControlID="txtNumeroCDP"
                                        ValidChars="1234567890" Enabled="True">
                                    </cc1:FilteredTextBoxExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtNumeroCDP"
                                        ErrorMessage="* Ingrese un n�mero de CDP" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender8" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator12" CssClass="CustomValidatorCalloutStyle" />
                                    <asp:TextBox ID="txtSubfijo" runat="server" Width="35px" TabIndex="2" ToolTip="Subfijo"
                                        MaxLength="5" Font-Size="24px" Height="24px" Style="font-weight: bolder;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender112" runat="server" TargetControlID="txtSubfijo"
                                        ValidChars="1234567890" Enabled="True" />
                                    <style>
                                        .aaa
                                        {
                                            color: rgb(235, 235, 235);
                                            font-weight: 100;
                                            font-size: 18px;
                                        }
                                    </style>
                                    <%-- <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtSubfijo"
                                        WatermarkText="Subf" WatermarkCssClass="watermarked aaa" Enabled="True" />--%>
                                    <asp:TextBox ID="txtSubNumeroVagon" runat="server" Width="60px" TabIndex="2" AutoPostBack="True"
                                        ToolTip="Vag�n" MaxLength="7" Font-Size="24px" Height="24px" Style="font-weight: bolder;">
                                        
                                        
                                    </asp:TextBox><asp:Label ID="lblFamiliaDuplicados" Style="width: 20px; font-weight: normal;
                                        font-size: 12px;" runat="server" />
                                    <asp:Label ID="lblErrorUnicidad" runat="server" BackColor="#CC3300" BorderStyle="None"
                                        Font-Size="Large" ForeColor="White" Height="18px" Style="text-align: center;
                                        visibility: hidden; display: none; margin-left: 0px; vertical-align: top" Text="X"
                                        Visible="False" Width="23px"></asp:Label>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender134" runat="server" TargetControlID="txtSubNumeroVagon"
                                        ValidChars="1234567890" Enabled="True" />
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="El n�mero debe tener 9 o 10 d�gitos"
                                        ControlToValidate="txtNumeroCDP" Height="16px" Width="255px" Style="display: inline"
                                        ValidationGroup="Encabezado" MaximumValue="9999999999" MinimumValue="100000000"
                                        Display="Dynamic"></asp:RangeValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender9" runat="server"
                                        Enabled="True" TargetControlID="RangeValidator1" CssClass="CustomValidatorCalloutStyle" />
                                    <%--  <ajaxToolkit:TextBoxWatermarkExtender ID="Textboxwatermarkextender1" runat="server"
                                        TargetControlID="txtSubNumeroVagon" WatermarkText="Vag�n" WatermarkCssClass="watermarked aaa"
                                        Enabled="True" />--%>
                                </div>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="upCartaDuplicada" runat="server">
                                    <ContentTemplate>
                                        <%--    <asp:Panel ID="PanelIconoOK" runat="server" Visible="false">
                                            OK
                                        </asp:Panel>--%>
                                        <%--    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="Imagenes/25-1.gif" alt="" style="height: 17px; width: 33px;" />
                                                
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>--%>
                                        <asp:Panel ID="PanelIconoErrorCartaDuplicada" runat="server" Visible="false">
                                            <img src="../Imagenes/error-icon.png" alt="" id="imageUnicidadError" style="border-style: none;
                                                border-color: inherit; border-width: medium; vertical-align: middle; text-decoration: none;
                                                margin-left: 5px; height: 24px; width: 24px;" visible="true" title="Este n�mero ya existe en la base!" />
                                            N�mero duplicado!
                                        </asp:Panel>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtNumeroCDP" EventName="TextChanged"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="txtSubfijo" EventName="TextChanged"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="txtSubNumeroVagon" EventName="TextChanged">
                                        </asp:AsyncPostBackTrigger>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="White"
                        BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                        Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" RECHAZADA "
                        Visible="False" Height="21px"></asp:Label>
                </td>
                <td style="height: 12px;" valign="top" align="right" colspan="3">
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 17px; width: 33px;" />
                            <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                Font-Size="Small" Visible="true"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
        <br />
        <cc1:TabContainer ID="TabContainer2" runat="server" Height="485px" Width="700px"
            Style="" ActiveTabIndex="0" CssClass="NewsTab" AccessKey="p">
            <%--  CssClass="SimpleTab"        CssClass="NewsTab"--%>
            <cc1:TabPanel ID="TabPanel2" runat="server" Height="550px">
                <HeaderTemplate>
                    <u>P</u>osici�n
                </HeaderTemplate>
                <ContentTemplate>
                    <div style="padding: 4px 0px 8px 2px;">
                        <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-left: 5px;
                            margin-right: 5px; margin-top: 5px" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">
                                    Fecha arribo
                                </td>
                                <td class="EncabezadoCell" style="width: 35%; height: 26px;">
                                    <asp:TextBox ID="txtFechaArribo" runat="server" Width="72px" MaxLength="1" TabIndex="2"
                                        Style="margin-right: 0px"></asp:TextBox>
                                    <asp:Button ID="Button4" runat="server" Style="margin-left: 0px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator229" runat="server" ControlToValidate="txtFechaArribo"
                                        ErrorMessage="* Ingrese una fecha de arribo" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                                    <asp:RangeValidator ID="RangeValidatorFechaArribo" runat="server" ErrorMessage="(Alerta: mas de 3 d�as de diferencia con hoy)"
                                        ControlToValidate="txtFechaArribo" Height="16px" Style="display: inline; color: Black;
                                        background: yellow" Display="Dynamic" MinimumValue="1/1/1900" MaximumValue="9/9/2100"
                                        Type="Date"></asp:RangeValidator>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaArribo"
                                        PopupButtonID="Button4" Enabled="True">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaArribo" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True" />
                                </td>
                                <td class="EncabezadoCell" style="height: 80px;" colspan="2">
                                    <table>
                                        <tr>
                                            <td style="width 70%">
                                                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                    <ContentTemplate>
                                                        <span><a id="linkimagenlabel" runat="server" href=" ">
                                                            <img id="imgFotoCarta" runat="server" style="height: 60px; max-width: 100px; background-image: ;
                                                                background-position: -0px -0px;" />
                                                            <asp:LinkButton Style="vertical-align: top" ID="quitarimagen1" CausesValidation="false"
                                                                Target="_blank" runat="server" Text="x" Visible="true"></asp:LinkButton>
                                                        </a>
                                                            <asp:HyperLink ID="linkImagen" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
                                                            <a id="linkimagenlabel2" runat="server" href=" ">
                                                                <img id="imgFotoCarta2" runat="server" style="height: 60px; max-width: 100px; background-image: ;
                                                                    background-position: -0px -0px;" />
                                                            </a>
                                                            <asp:LinkButton ID="quitarimagen2" Style="vertical-align: top" Target="_blank" CausesValidation="false"
                                                                runat="server" Text="x" Visible="true"></asp:LinkButton>
                                                            <asp:HyperLink ID="linkImagen_2" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
                                                        </span>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td class="" style="height: 80px;" colspan="1">
                                                <asp:Panel ID="Panel3" runat="server" Width="50px">
                                                    <style>
                                            .AFU
                                            {
                                                width: 150px;
                                               /* margin-left: 150px;*/
                                               
                                                /*position: relative;
                                                float: left;
                                                clear: both;
                                                top: 0px;
                                                padding-left: 0px;
                                                padding-right: 0px;
                                                width: 50px;
                                                border: thick;
                                                margin: 0px;
                                                font-size: 5px;*/ 
                                                background: /*url("imagenes/barato.png") no-repeat 100% 1px;*/
                                            }
                                            .AFU div
                                            {
                                                width: 150px !important;
                                                background-image: none  !important;
                                            }
                                            .AFU input
                                            {
                                                /*  opacity: 0; */
                                                border: none;
                                                width: 150px !important; /* visibility: hidden; */
                                                color: transparent;
                                                background: url("../imagenes/imagen1.png") no-repeat 100% 1px; 
                                                content: 'content is here';
                                                background-color: transparent; /*border:Dashed 2px #000000;*/ /* width: 150px;*/ /*visibility:hidden;*/ /*   background-color: transparent;
                                                    
                                                color: transparent;
                                                border: none;*/
                                            }
                                     
                                                 .AFU2 input
                                            {
                                              
                                                background: url("../imagenes/imagen2.png") no-repeat 100% 1px; 
                                     
                                            }
                                        </style>
                                                    <script>


                                                        //                                            $(document).ready(function () {
                                                        //                                                $('ctl00$ContentPlaceHolder1$TabContainer2$TabPanel2$AsyncFileUpload1$ctl02').width = 20;
                                                        //                                                $('ctl00$ContentPlaceHolder1$TabContainer2$TabPanel2$AsyncFileUpload1$ctl02').css({ width: 20 });

                                                        //                                            });


                                            
                                            
                                                    </script>
                                                    <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete="ClientUploadComplete"
                                                        UploaderStyle="Modern" CssClass="AFU" FailedValidation="False" />
                                                    <br />
                                                    <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload2" runat="server" OnClientUploadComplete="ClientUploadComplete"
                                                        UploaderStyle="Modern" CssClass="AFU AFU2" FailedValidation="False" />
                                                    <script>
                                                        //    $("#AsyncFileUpload2 :input").attr("background") = 'url("../imagenes/imagen1.png") no-repeat 100% 1px';
                                                        
                                                    </script>
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


                                                            //var f = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia");
                                                            //var f = $find('ctl00_ContentPlaceHolder1_btnVistaPrevia');

                                                            //f.click();
                                                        }

                                                    </script>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">
                                    Punto venta
                                </td>
                                <td class="EncabezadoCell " style="width: 35%; height: 23px;">
                                    <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssCombo" TabIndex="2"
                                        Width="50px" />
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 26px;">
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblFacturarleAesteCliente" runat="server" Text="Facturar a" Visible="False"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:HyperLink ID="linkFactura" Target="_blank" runat="server" Text="Ir a"></asp:HyperLink>
                                            <asp:TextBox ID="txtFacturarleAesteCliente" runat="server" autocomplete="off" TabIndex="6"
                                                Width="180px" Visible="False"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender30" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtFacturarleAesteCliente" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                            <asp:LinkButton ID="butVerLog" Text="Historial" runat="server" CausesValidation="false" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 26px;">
                                    CEE n�
                                </td>
                                <td class="EncabezadoCell " style="width: 35%; height: 26px;">
                                    <asp:TextBox ID="txtCEE" runat="server" Width="180px" TabIndex="2"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 26px;">
                                    Fecha carga
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtFechaCarga" runat="server" Width="72px" MaxLength="1" TabIndex="3"></asp:TextBox>
                                    <asp:Button ID="btnPopCalendar1" runat="server" Style="margin-left: 0px" />
                                    <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaCarga"
                                        PopupButtonID="btnPopCalendar1" Enabled="True">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaCarga" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True">
                                    </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">
                                    CTG n�
                                </td>
                                <td class="EncabezadoCell " style="width: 35%; height: 23px;">
                                    <asp:TextBox ID="txtCTG" runat="server" Width="100px" TabIndex="5"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">
                                    Vencimiento
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtFechaVencimiento" runat="server" Width="72px" MaxLength="1" TabIndex="5"
                                        Style="margin-right: 0px"></asp:TextBox>
                                    <asp:Button ID="Button2" runat="server" Style="margin-left: 0px" />
                                    <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaVencimiento"
                                        PopupButtonID="Button2" Enabled="True">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" ErrorTooltipEnabled="True"
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaVencimiento" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True" />
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Titular
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngenta();">
                                    <asp:HiddenField ID="HiddenCasosEspeciales" runat="server" />
                                    <script type="text/javascript">



//                                        $("#optDivisionSyngenta").change(function () {

//                                            $("#HiddenCasosEspeciales").val($("#optDivisionSyngenta").val());

//                                        });

                                        function comboCasosEspeciales(textbox, combo) {



                                            if (textbox.indexOf("SYNGENTA") != -1) {
                                                combo.style.visibility = "visible";
//                                                var temp = $(combo).val();
//                                                $(combo).empty();
//                                                $(combo).append('<option value="Agro">Agro</option>');
//                                                $(combo).append('<option value="Seeds">Seeds</option>');
//                                                $(combo).val(temp);

//                                                $("#theSelect option[value='Seeds']").attr('disabled', 'disabled')
//                                                $("#theSelect option[value='Agro']").attr('disabled', 'disabled')
                                                
                                                // $("#theSelect option[value='Agro']").removeAttr('disabled');
                                                // $("#theSelect option:selected").attr('disabled', 'disabled')

                                                // $(combo).("option[value='401']").remove();
                                                // document.getElementById('ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta').options[0].remove()
//                                                $(combo).empty();
//                                                $(combo).append('<option value="Agro">Agro</option>');
//                                                $(combo).append('<option value="Seeds">Seeds</option>');


                                                //                                                combo.options[2].remove()
//                                                combo.options[3].remove()
//                                                combo.options[4].remove()
                                                //combo.options[0].attr('disabled', 'disabled')
                                                //$("#" + combo.id + " option[value='401']").remove();
                                                $("#" + combo.id + " option").removeAttr('disabled');
                                                $("#" + combo.id + " option").not("[value='Agro']").not("[value='Seeds']").attr('disabled', 'disabled')


                                                if ($("#" + combo.id + " :selected").attr('disabled')) // qued� elegido uno deshabilitado
                                                {
                                                    $("#" + combo.id + " option:not([disabled]):first").attr('selected', 'selected')
                                                }

                                            }
                                            else if (textbox.indexOf("A.C.A") != -1) {
                                                combo.style.visibility = "visible";

                                                // http://stackoverflow.com/questions/740195/adding-options-to-a-select-using-jquery-javascript
                                                //                                                var o = new Option("option text", "value");
                                                //                                                /// jquerify the DOM object 'o' so we can use the html method
                                                //                                                $(o).html("option text");
                                                //                                                $("#selectList").append(o);

                                                //document.getElementById('ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta').options[0].remove()

                                                //$("#" + combo.id + " option[value='401']").remove();
                                                $("#" + combo.id + " option").removeAttr('disabled');
                                                $("#" + combo.id + " option[value='Agro']").attr('disabled', 'disabled')
                                                $("#" + combo.id + " option[value='Seeds']").attr('disabled', 'disabled')


                                                if ($("#" + combo.id + " :selected").attr('disabled')) // qued� elegido uno deshabilitado
                                                {
                                                    $("#" + combo.id + " option:not([disabled]):first").attr('selected', 'selected')
                                                }

//                                                $("#theSelect option[value=401]").attr('disabled', 'disabled')
//                                                $("#theSelect option[value=402]").attr('disabled', 'disabled')


//                                                var temp=$(combo).val();
//                                                $(combo).empty();
//                                                $(combo).append('<option value=401>1Acopio  A.C.A.</option>');
//                                                $(combo).append('<option value=402>2Acopio  A.C.A.</option>');
//                                                $(combo).append('<option value=403>3Acopio  A.C.A.</option>');
//                                                $(combo).val(temp);
                                            }
                                            else {
                                                //alert("a");
                                                combo.style.visibility = "hidden";
                                            }
                                        }


                                        function jsVerificarSyngenta() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTitular").value;
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta");


                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            //alert(txttitular);
                                            //                                            if (txttitular.indexOf("SYNGENTA") != -1) {
                                            //                                                optDivisionSyngenta.style.visibility = "visible";
                                            //                                            }
                                            //                                            else if (txttitular.indexOf("A.C.A") != -1) {
                                            //                                                optDivisionSyngenta.style.visibility = "visible";
                                            //                                            }
                                            //                                            else {
                                            //                                                //alert("a");
                                            //                                                optDivisionSyngenta.style.visibility = "hidden";
                                            //                                            }

                                            //return false;
                                        }


                                    
                                    
                                    

                                    </script>
                                    <asp:TextBox ID="txtTitular" runat="server" autocomplete="off" TabIndex="6" Width="180px"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                        TargetControlID="txtTitular" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                        FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitular"
                                        ErrorMessage="* Ingrese un titular" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ValidatorCalloutExtender1" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator1"
                                            CssClass="CustomValidatorCalloutStyle" />
                                    <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la Divisi�n de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="6">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                        <asp:ListItem Text="Acopio 1 ACA" Value="ACA401" />
                                        <asp:ListItem Text="Acopio 2 ACA"  Value="ACA401" />
                                        <asp:ListItem Text="Acopio 3 ACA"  Value="ACA402" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Intermediario
                                </td>
                                <td class="EncabezadoCell" onkeydown="return jsVerificarSyngentaIntermediario();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaIntermediario() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtIntermediario").value;
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaIntermediario");


                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            //alert(txttitular);
//                                            if (txttitular.indexOf("SYNGENTA") == -1) {
//                                                optDivisionSyngenta.style.visibility = "hidden";
//                                            }
//                                            else {
//                                                //alert("a");
//                                                optDivisionSyngenta.style.visibility = "visible";
//                                            }

                                            //return false;
                                        } 

                                        
                                    </script>
                                    <asp:TextBox ID="txtIntermediario" runat="server" autocomplete="off" Width="180px"
                                        TabIndex="7"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                        TargetControlID="txtIntermediario" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                        CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                    <asp:DropDownList ID="optDivisionSyngentaIntermediario" runat="server" ToolTip="Elija la Divisi�n de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="7">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Remit comerc
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngentaRemitente();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaRemitente() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtRcomercial").value;
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaRemitente");

                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
//                                            //alert(txttitular);
//                                            if (txttitular.indexOf("SYNGENTA") == -1) {
//                                                optDivisionSyngenta.style.visibility = "hidden";
//                                            }
//                                            else {
//                                                //alert("a");
//                                                optDivisionSyngenta.style.visibility = "visible";
//                                            }

                                            //return false;
                                        } 

                                        
                                    </script>
                                    <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" Width="180px" TabIndex="8"></asp:TextBox><cc1:AutoCompleteExtender
                                        ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtRcomercial"
                                        UseContextKey="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                        Enabled="True" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                    <asp:DropDownList ID="optDivisionSyngentaRemitente" runat="server" ToolTip="Elija la Divisi�n de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="8">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Corredor
                                </td>
                                <td class="EncabezadoCell" onkeydown="return jsVerificarSyngentaCorredor();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaCorredor() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtCorredor").value;
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaCorredor");
                                            optDivisionSyngenta.style.visibility = "hidden";
                                            //comboCasosEspeciales(txttitular, optDivisionSyngenta);

                                            //alert(txttitular);
//                                            if (txttitular.indexOf("SYNGENTA") == -1) {
//                                                optDivisionSyngenta.style.visibility = "hidden";
//                                            }
//                                            else {
//                                                //alert("a");
//                                                optDivisionSyngenta.style.visibility = "visible";
//                                            }

                                            //return false;
                                        } 

                                        
                                    </script>
                                    <asp:TextBox ID="txtCorredor" runat="server" autocomplete="off" Width="180px" TabIndex="9"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx"
                                        TargetControlID="txtCorredor" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCorredor"
                                        ErrorMessage="* Ingrese un corredor" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ValidatorCalloutExtender4" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator4"
                                            CssClass="CustomValidatorCalloutStyle" />
                                    <asp:DropDownList ID="optDivisionSyngentaCorredor" runat="server" ToolTip="Elija la Divisi�n de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="9">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Destinatario
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngentaDestinatario();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaDestinatario() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestinatario").value;
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaDestinatario");

                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
//                                            //alert(txttitular);
//                                            if (txttitular.indexOf("SYNGENTA") == -1) {
//                                                optDivisionSyngenta.style.visibility = "hidden";
//                                            }
//                                            else {
//                                                //alert("a");
//                                                optDivisionSyngenta.style.visibility = "visible";
//                                            }

                                            //return false;
                                        } 

                                        
                                    </script>
                                    <asp:TextBox ID="txtDestinatario" runat="server" autocomplete="off" Width="180px"
                                        TabIndex="10"></asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender6"
                                            runat="server" CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtDestinatario" UseContextKey="True"
                                            CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDestinatario"
                                        ErrorMessage="* Ingrese un destinatario" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ValidatorCalloutExtender2" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator2"
                                            CssClass="CustomValidatorCalloutStyle" />
                                    <asp:DropDownList ID="optDivisionSyngentaDestinatario" runat="server" ToolTip="Elija la Divisi�n de Syngenta"
                                        Width="40px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="10">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="TextBoxCorredorII" runat="server" autocomplete="off" Width="180px"
                                        TabIndex="10" Visible="False"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender13" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx"
                                        TargetControlID="TextBoxCorredorII" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Transportista
                                </td>
                                <td class="EncabezadoCell" style="width: 35%">
                                    <asp:TextBox ID="txtTransportista" runat="server" autocomplete="off" Width="180px"
                                        TabIndex="10"></asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender11"
                                            runat="server" CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                            ServicePath="WebServiceTransportistas.asmx" TargetControlID="txtTransportista"
                                            UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Chofer
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtChofer" runat="server" autocomplete="off" Width="180px" TabIndex="10"></asp:TextBox><cc1:AutoCompleteExtender
                                        ID="AutoCompleteExtender12" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceChoferes.asmx" TargetControlID="txtChofer"
                                        UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                        DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="border-color: #FFFFFF; border-style: none none none none; border-width: thin;
                            padding: 0px; width: 100%; margin-left: 5px; margin-right: 0px;" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td style="width: 15%; height: 9px;" class="EncabezadoCell">
                                    Producto
                                </td>
                                <td style="height: 9px; width: 35%;">
                                    <asp:TextBox ID="txt_AC_Articulo" runat="server" autocomplete="off" Style="margin-left: 0px"
                                        Width="180px" CssClass="CssTextBox" TabIndex="13"></asp:TextBox><cc1:AutoCompleteExtender
                                            ID="AutoCompleteExtender2" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo"
                                            UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txt_AC_Articulo"
                                        ErrorMessage="* Ingrese un grano" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                            ID="ValidatorCalloutExtender3" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator3"
                                            CssClass="CustomValidatorCalloutStyle" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 11px;" class="EncabezadoCell">
                                    Contrato
                                </td>
                                <td style="height: 11px; width: 35%;">
                                    <asp:TextBox ID="txtContrato" runat="server" TabIndex="14" Width="100px"></asp:TextBox>
                                </td>
                                <td style="width: 15%; height: 1px;" class="EncabezadoCell">
                                    Peso Bruto
                                </td>
                                <td style="height: 1px;">
                                    <asp:TextBox ID="txtBrutoPosicion" runat="server" CssClass="CssTextBoxChico" Style="text-align: right;"
                                        TabIndex="16"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4"
                                            runat="server" TargetControlID="txtBrutoPosicion" ValidChars=".1234567890" Enabled="True">
                                        </cc1:FilteredTextBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 1px;">
                                    Cosecha
                                </td>
                                <td style="height: 1px; width: 35%;">
                                    <asp:DropDownList ID="cmbCosecha" runat="server" CssClass="CssCombo" TabIndex="14">
                                        <asp:ListItem>2016/17</asp:ListItem>
                                        <asp:ListItem>2015/16</asp:ListItem>
                                        <asp:ListItem>2014/15</asp:ListItem>
                                        <asp:ListItem>2013/14</asp:ListItem>
                                        <asp:ListItem>2012/13</asp:ListItem>
                                        <asp:ListItem>2011/12</asp:ListItem>
                                        <asp:ListItem>2010/11</asp:ListItem>
                                        <asp:ListItem Selected="True">2009/10</asp:ListItem>
                                        <asp:ListItem>2008/09</asp:ListItem>
                                        <asp:ListItem>2007/08</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 15%;" class="EncabezadoCell">
                                    Peso Tara
                                </td>
                                <td style="height: 9px;">
                                    <asp:TextBox ID="txtTaraPosicion" runat="server" CssClass="CssTextBoxChico" Style="text-align: right;"
                                        TabIndex="17"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3"
                                            runat="server" TargetControlID="txtTaraPosicion" ValidChars=".1234567890" Enabled="True">
                                        </cc1:FilteredTextBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 9px;">
                                    Exportaci�n
                                </td>
                                <td style="height: 9px; width: 35%;">
                                    <asp:CheckBox ID="chkExporta" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                        TabIndex="14" />
                                    No facturar a subcontratistas
                                    <asp:CheckBox ID="chkNoFacturarASubcontratistas" runat="server" ForeColor="White"
                                        ToolTip="Para controlar el stock del cliente" TabIndex="14" />
                                    <td class="EncabezadoCell" style="width: 15%; height: 11px;">
                                        Peso Neto
                                    </td>
                                    <td style="height: 11px;">
                                        <asp:TextBox ID="txtNetoPosicion" runat="server" CssClass="CssTextBoxChico" Style="text-align: right;"
                                            TabIndex="18">0</asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2"
                                                runat="server" TargetControlID="txtNetoPosicion" ValidChars=".1234567890" Enabled="True">
                                            </cc1:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtNetoPosicion"
                                            ErrorMessage="* Ingrese el peso neto" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                            ValidationGroup="Encabezado" Style="display: none" InitialValue="0" /><ajaxToolkit:ValidatorCalloutExtender
                                                ID="ValidatorCalloutExtender7" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator8"
                                                CssClass="CustomValidatorCalloutStyle" />
                                    </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-left: 5px;
                                    margin-right: 0px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%; height: 12px;">
                                            Procedencia
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%; height: 12px;">
                                            <asp:TextBox ID="txtOrigen" runat="server" Width="180px" TabIndex="19" autocomplete="off"
                                                AutoCompleteType="None"></asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender7"
                                                    runat="server" CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1"
                                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx" TargetControlID="txtOrigen"
                                                    UseContextKey="true" FirstRowSelected="true" CompletionListCssClass="AutoCompleteScroll"
                                                    CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtOrigen"
                                                ErrorMessage="* Ingrese el origen" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                                InitialValue="" ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                                    ID="ValidatorCalloutExtender5" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator6"
                                                    CssClass="CustomValidatorCalloutStyle" />
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%; height: 12px;">
                                            Destino
                                        </td>
                                        <td class="EncabezadoCell" style="height: 12px">
                                            <asp:TextBox ID="txtDestino" runat="server" autocomplete="off" AutoCompleteType="None"
                                                Width="180px" TabIndex="20" AutoPostBack="false"></asp:TextBox><cc1:AutoCompleteExtender
                                                    ID="AutoCompleteExtender8" runat="server" CompletionSetCount="12" EnableCaching="true"
                                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                    TargetControlID="txtDestino" UseContextKey="true" CompletionListCssClass="AutoCompleteScroll"
                                                    FirstRowSelected="true" CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDestino"
                                                ErrorMessage="* Ingrese el destino" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                                InitialValue="" ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                                    ID="ValidatorCalloutExtender6" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator7"
                                                    CssClass="CustomValidatorCalloutStyle" />
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none">
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            Subcontr. 1
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSubcontr1" runat="server" autocomplete="off" Width="180px" TabIndex="21"></asp:TextBox><cc1:AutoCompleteExtender
                                                ID="AutoCompleteExtender9" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtSubcontr1"
                                                UseContextKey="True" FirstRowSelected="True" DelimiterCharacters="" Enabled="True"
                                                CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            Contrato
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:DropDownList ID="cmbTipoContrato1" runat="server" CssClass="CssCombo" TabIndex="21">
                                                <asp:ListItem Value="0" Selected="True">Calado</asp:ListItem>
                                                <asp:ListItem Value="1">Balanza</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none">
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Subcontr. 2
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSubcontr2" runat="server" autocomplete="off" Width="180px" TabIndex="22"
                                                CssClass="CssTextBox">
                                        
                                            </asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server"
                                                CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtSubcontr2" UseContextKey="True"
                                                FirstRowSelected="True" DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Contrato
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:DropDownList ID="cmbTipoContrato2" runat="server" CssClass="CssCombo" TabIndex="22">
                                                <asp:ListItem Value="0">Calado</asp:ListItem>
                                                <asp:ListItem Value="1" Selected="True">Balanza</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <table style="padding: 0px; border: none #FFFFFF; width: 100%; height: 53px; margin-left: 5px;
                            margin-right: 0px;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Pat cami�n
                                </td>
                                <td class="EncabezadoCell" style="width: 35%;">
                                    <asp:TextBox ID="txtPatenteCamion" runat="server" Width="66px" MaxLength="6" TabIndex="23"
                                        CssClass="UpperCase"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Pat acoplado
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtPatenteAcoplado" runat="server" Width="66px" MaxLength="6" TabIndex="24"
                                        CssClass="UpperCase"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Km a recorrer
                                </td>
                                <td class="EncabezadoCell" style="width: 35%;">
                                    <asp:TextBox ID="txtKmRecorrer" runat="server" CssClass="CssTextBoxChico" TabIndex="25"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Tarifa
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtTarifa" runat="server" CssClass="CssTextBoxChico" TabIndex="26"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Movimiento
                                </td>
                                <td>
                                    <asp:DropDownList ID="cmbMovimientoLosGrobo" runat="server" CssClass="CssCombo" TabIndex="26">
                                        <asp:ListItem Value="1">1. Egresos contratos de Venta</asp:ListItem>
                                        <asp:ListItem Value="2">2. Egreso Directo a Destino Productor</asp:ListItem>
                                        <asp:ListItem Value="3">3. Directo Destino contrato de Compra</asp:ListItem>
                                        <asp:ListItem Value="4">4. Ingreso Entregado Productor</asp:ListItem>
                                        <asp:ListItem Value="5">5. Ingreso Contrato de Compra</asp:ListItem>
                                        <asp:ListItem Value="6">6. Reingreso de Mercader�a</asp:ListItem>
                                        <asp:ListItem Value="7">7. Transferencia desde otra Planta</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">
                                    Establecmnto
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtEstablecimiento" runat="server" autocomplete="off" Width="180px"
                                        TabIndex="26"></asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender15"
                                            CompletionListCssClass="AutoCompleteScroll" runat="server" CompletionSetCount="12"
                                            MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceEstablecimientos.asmx"
                                            TargetControlID="txtEstablecimiento" UseContextKey="True" FirstRowSelected="True"
                                            DelimiterCharacters="" Enabled="True">
                                        </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </cc1:TabPanel>
            <cc1:TabPanel ID="TabPanel3" runat="server" BackColor="#6600FF">
                <HeaderTemplate>
                    <u>D</u>escarga
                </HeaderTemplate>
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server" Height="550px">
                                <br />
                                <table style="padding: 0px; border: none #FFFFFF; width: 696px; height: 202px; margin-left: 5px;
                                    margin-right: 0px;" cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Descarga
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <script>

                                                function jsVerificarFechaDescarga() {

                                                    return false;
                                                    // http: //www.datejs.com/   pinta q habra q poner esto

                                                    // como chuparse la fecha del texto
                                                    // http: //www.tek-tips.com/viewthread.cfm?qid=327010  
                                                    var fechaArribo = getDateFromFormat(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo").value, "dd/MM/yyyy");
                                                    var fechaDescarga = getDateFromFormat(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtFechaDescarga").value, "dd/MM/yyyy");

                                                    alert(fechaArribo);
                                                    alert(fechaDescarga);

                                                    // http: //stackoverflow.com/questions/1036742/date-difference-in-javascript-ignoring-time-of-day
                                                    var millisecondsPerDay = 1000 * 60 * 60 * 24;
                                                    var millisBetween = fechaDescarga.getTime() - fechaArribo.getTime();
                                                    var days = millisBetween / millisecondsPerDay;

                                                    //alert("La fecha de descarga tiene mas de 2 d�as de diferencia con el arribo");
                                                    if (days > 2) {
                                                        alert("La fecha de descarga tiene mas de 2 d�as de diferencia con el arribo");
                                                    }
                                                    else {

                                                    }

                                                    return false;

                                                }



                                            </script>
                                            <asp:TextBox ID="txtFechaDescarga" runat="server" MaxLength="1" Width="72px" TabIndex="27"
                                                onchange="" AutoPostBack="false"></asp:TextBox>&nbsp
                                            <asp:Button ID="Button1" runat="server" />
                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDescarga"
                                                PopupButtonID="Button1">
                                            </cc1:CalendarExtender>
                                            <asp:RangeValidator ID="RangeValidatorFechaDescarga" runat="server" ErrorMessage="(Alerta: mas de 3 d�as de diferencia con fecha de arribo)"
                                                ControlToValidate="txtFechaDescarga" Height="16px" Style="display: inline" Display="Dynamic"
                                                MaximumValue="9/9/2100" Type="Date" Enabled="false"></asp:RangeValidator>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                TargetControlID="txtFechaDescarga">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Hora
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtHoraDescarga" runat="server" MaxLength="1" Width="72px" TabIndex="28"></asp:TextBox><cc1:MaskedEditExtender
                                                ID="MaskedEditExtender66" TargetControlID="txtHoraDescarga" MaskType="Time" runat="server"
                                                Mask="99:99">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            N� recibo
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtNRecibo" runat="server" Width="66px" TabIndex="29"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%; visibility: hidden; display: none;">
                                            Factor
                                        </td>
                                        <td class="EncabezadoCell" style="visibility: hidden; display: none;">
                                            <asp:TextBox ID="txtFactor" runat="server" Width="56px" TabIndex="29"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Calidad
                                            <br />
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="TextBoxCalidad" runat="server" autocomplete="off" Style="margin-left: 0px"
                                                Width="180px" CssClass="CssTextBox" TabIndex="30"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender14" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServicecalidades.asmx"
                                                TargetControlID="TextBoxCalidad" UseContextKey="True" FirstRowSelected="True"
                                                CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                                                CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                            <%--                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <cc1:ComboBox ID="cmbCalidad" runat="server" RenderMode="Block" Height="18px" 
                                                     Width="100px"
                                                    AutoPostBack="True"
                                                        ToolTip="se llena con las calidades de la tabla" AutoCompleteMode="SuggestAppend">
                                                    </cc1:ComboBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            --%>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Peso Bruto
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtBrutoDescarga" runat="server" CssClass="CssNumBox" Width="66px"
                                                TabIndex="31"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender11"
                                                    runat="server" TargetControlID="txtBrutoDescarga" ValidChars=".1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Peso Tara
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtTaraDescarga" runat="server" CssClass="CssNumBox" Width="66px"
                                                TabIndex="32"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender10"
                                                    runat="server" TargetControlID="txtTaraDescarga" ValidChars=".1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Peso Neto
                                        </td>
                                        <%--
                                        C�mo manejar el recalculo por javascript
                                        http://www.desarrolloweb.com/articulos/1236.php
                                        http://benreichelt.net/blog/2006/3/2/Firing-javascript-events-when-textbox-changes/
                                        
                                        --%><td class="EncabezadoCell" style="width: 35%;" onkeyup="jsRecalcular">
                                            <asp:TextBox ID="txtNetoDescarga" runat="server" CssClass="CssNumBox" Width="66px"
                                                TabIndex="33"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender9"
                                                    runat="server" TargetControlID="txtNetoDescarga" ValidChars=".1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Hum
                                            <asp:TextBox ID="txtPorcentajeHumedad" runat="server" CssClass="CssNumBox" Width="30px"
                                                AutoPostBack="True" TabIndex="34" EnableViewState="false"></asp:TextBox>%
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:UpdatePanel ID="updatePanelHumedad" runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtHumedadTotal" runat="server" CssClass="CssNumBox" Width="66px"
                                                        TabIndex="34"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender8"
                                                            runat="server" TargetControlID="txtHumedadTotal" ValidChars="1234567890">
                                                        </cc1:FilteredTextBoxExtender>
                                                    Kg
                                                    <%--<asp:DropDownList ID="cmbHumedad" runat="server" CssClass="CssCombo" TabIndex="34"
                                                        ToolTip="se llena con las calidades de la tabla" Width="37px" AutoPostBack="True"
                                                        Visible="false">
                                                    </asp:DropDownList>--%>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Fumigada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtFumigada" runat="server" CssClass="CssTextBox" Width="66px" TabIndex="35"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtFumigada" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Secada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSecada" runat="server" CssClass="CssTextBox" Width="66px" TabIndex="36"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtSecada" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Otr. mermas
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtMerma" runat="server" CssClass="CssNumBox" Width="66px" TabIndex="37"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender5" runat="server" TargetControlID="txtMerma" ValidChars="1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Neto Final
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtNetoFinalTotalMenosMermas" runat="server" CssClass="CssNumBox"
                                                TabIndex="37" Width="66px"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                        </td>
                                        <td class="EncabezadoCell">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Cliente Observaciones
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%">
                                            <asp:TextBox ID="txtClienteAuxiliar" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="8" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender16" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClienteAuxiliar" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Entregador
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%">
                                            <asp:TextBox ID="txtClienteEntregador" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="8" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender17" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionListEntregadores" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClienteEntregador" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Pagador Flete
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%">
                                            <asp:TextBox ID="txtClientePagadorFlete" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="8" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender18" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClientePagadorFlete" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Observ
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" CssClass="CssTextBox"
                                                Width="526px" Height="42px" Style="margin-left: 0px" TabIndex="38"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Costo administrativo
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkConCostoAdministrativo" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Liquida viaje
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkLiquidaViaje" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            Cobra acarreo
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkCobraAcarreo" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" Checked="true" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
            <cc1:TabPanel ID="TabPanel4" runat="server" BackColor="#6600FF">
                <HeaderTemplate>
                    <u>C</u>alidad
                </HeaderTemplate>
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <br />
                            <asp:Panel ID="Panel4" runat="server" Height="550px">
                                <table style="padding: 0px; border: none #FFFFFF; width: 696px; height: 75px; margin-left: 5px;
                                    margin-right: 0px;" cellpadding="0" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            Resultado
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            Rebaja
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Cuerpos extra�os/ materias
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox26" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox26_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Granos negros
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox27" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox27_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox27"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Quebrados partidos
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox28" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox28_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox28"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Da�ados
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox29" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox29_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox29"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Semilla de chamico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox30" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox30_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox30"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="TextBox31" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox31_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox31"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Revolcado en tierra
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="TextBox32" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox32_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox32"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Olores objetables
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="TextBox33" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox33_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox33"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Granos amohosados
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="TextBox34" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox34_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox34"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Punta sombreada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtPuntaSombreada" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender15" runat="server" TargetControlID="txtPuntaSombreada"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Peso hectol�trico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox35" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox35_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox35"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Granos con carb�n
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox36" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox36_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox36"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Panza blanca
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox37" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox37_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox37"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Picados
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox38" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox38_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox38"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Materia grasa
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox39" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox39_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox39"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Acidez materia grasa
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox40" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox40_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox40"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Granos verdes
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox41" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox41_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox41"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                            &#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            Grado
                                            <asp:DropDownList ID="cmbNobleGrado" runat="server" CssClass="CssCombo" Width="59px">
                                                <asp:ListItem>0</asp:ListItem>
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Granos Quemados o de Aver�a
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender1" runat="server" TargetControlID="TextBox1" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Tierra
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender12" runat="server" TargetControlID="TextBox2" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList3" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Merma por Chamico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox3" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender13" runat="server" TargetControlID="TextBox3" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList4" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Mermas por Zarandeo
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox4" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender14" runat="server" TargetControlID="TextBox4" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList5" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">
                                            Descuento Final
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadDescuentoFinal" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender16" runat="server" TargetControlID="txtCalidadDescuentoFinal"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="Conforme (Solo soja)" ForeColor="White" />
                                            <asp:CheckBox ID="CheckBox2" runat="server" Text="A Camara" ForeColor="White" />
                                            <asp:CheckBox ID="CheckBox3" runat="server" Text="Fuera de estandar" ForeColor="White" />
                                            <asp:DropDownList ID="cmbBonifRebajGeneral" runat="server" CssClass="CssCombo">
                                                <asp:ListItem>Bonifica todos</asp:ListItem>
                                                <asp:ListItem>Rebaja todos</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Soja Sustentable (sincro BLD)
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            Condic.
                                            <asp:TextBox ID="SojaSustentableCodCondicion" runat="server" CssClass="CssTextBox"
                                                Width="30px"></asp:TextBox>
                                            <asp:TextBox ID="SojaSustentableCondicion" runat="server" CssClass="CssTextBox" Width="100px"></asp:TextBox>
                                            Estab.
                                            <asp:TextBox ID="SojaSustentableNroEstablecimientoDeProduccion" runat="server" CssClass="CssTextBox"
                                                Width="66px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
                --%>
                <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
                <asp:Panel ID="panelAdjunto" runat="server" Style="display: none">
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
                        Style="margin-right: 0px">Adjuntar</asp:LinkButton><asp:Button ID="btnAdjuntoSubir"
                            runat="server" Font-Bold="False" Height="19px" Style="margin-left: 0px; margin-right: 23px;
                            text-align: left;" Text="Adjuntar" Width="58px" CssClass="button-link" CausesValidation="False" />
                    <asp:LinkButton ID="lnkAdjunto1" runat="server" ForeColor="White" Visible="False"></asp:LinkButton><%--style="visibility:hidden;"/>--%>
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
                    <%--se dispara cuando se oculta la lista. me est� dejando una marca fea--%>
                    <asp:LinkButton ID="lnkBorrarAdjunto" runat="server" ForeColor="White">borrar</asp:LinkButton><br />
                    <br />
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <div style="display: inline;">
        <table style="vertical-align: middle">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick=" $find('ctl00_ContentPlaceHolder1_TabContainer2').set_activeTabIndex(0);   if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                                UseSubmitBehavior="False" Style="margin-left: 0px" ValidationGroup="Encabezado"
                                TabIndex="39"></asp:Button>
                            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="Cancelar"
                                CssClass="butcancela" CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px;
                                margin-right: 0px" Font-Bold="False" TabIndex="40"></asp:Button>
                            <asp:Button ID="btnAnular" runat="server" CssClass="butcancela" Text="Rechazar" CausesValidation="False"
                                UseSubmitBehavior="False" Style="margin-left: 28px" TabIndex="41"></asp:Button>
                            <asp:Button ID="btnDesfacturar" runat="server" CssClass="butcancela" Text="Desfacturar"
                                CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px;"
                                TabIndex="41"></asp:Button>
                            <asp:Button ID="btnDuplicarEscondido" runat="server" CssClass="butcancela" Text="Duplicar escondido"
                                CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px"
                                Visible="false" TabIndex="41"></asp:Button>
                            <asp:HyperLink ID="btnDuplicar" Target='_blank' runat="server" NavigateUrl='' onclick="jj()"
                                CssClass="butcancela" Width="50px" Height="16px" Font-Size="12px" Style="margin-left: 28px;
                                padding: 4px; text-align: center;" Text='Duplicar' Font-Underline="false"> </asp:HyperLink>
                            <br />
                            <script type="text/javascript">
                                function HandleIT() {

                                    PageMethods.btnDuplicar_Click();
                                    function onSucess(result) {
                                        alert(result);
                                    }
                                    function onError(result) {
                                        alert('Something wrong.');
                                    }
                                }

                                function aaa() {
                                    alert('ssss');
                                    $('HyperLink1').click();
                                }

                                // http://stackoverflow.com/questions/1305954/asp-net-postback-with-javascript
                                function jj() {
                                    __doPostBack('<%= btnDuplicarEscondido.UniqueID %>', '')

                                    //                                    $.ajax({
                                    //                                        type: "POST",
                                    //                                        url: "CartaDePorte.aspx/btnDuplicar_Click",
                                    //                                        data: "{}",
                                    //                                        contentType: "application/json; charset=utf-8",
                                    //                                        dataType: "json",
                                    //                                        success: function (msg) {
                                    //                                            // Do something interesting here.
                                    //                                        }
                                    //                                    });
                                }
                            </script>
                            <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" alt="" />
                                    <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                                        Visible="False"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <asp:Label ID="Label1" Width="1000px" runat="server" Font-Bold="true" ForeColor="LightGreen" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:LinkButton ID="lnkRepetirUltimaCDP" runat="server" Font-Bold="False" Font-Underline="false"
                        ForeColor="White" CausesValidation="False" Font-Size="X-Small" BorderStyle="None"
                        Visible="false" Style="margin-right: 0px; margin-left: 28px;" BorderWidth="5px"
                        TabIndex="41">Copiar la �ltima que edit�</asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel runat="server" ID="upLog" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="lblLog" Width="1000px" runat="server"></asp:Label></ContentTemplate>
    </asp:UpdatePanel>
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
        Style="vertical-align: bottom; margin-top: 5px; margin-bottom: 6px; visibility: hidden;"
        CausesValidation="False" TabIndex="39" Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
        <asp:Label ID="Label12" runat="server" ForeColor="White" Text="Imprimir" Font-Underline="True"></asp:Label>
    </asp:LinkButton>
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
    <script type="text/javascript">


        function getObj(objID) {
            return document.getElementById(objID);
        }

    </script>
    <script type="text/javascript">
        function isNumber(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }

        function toNumber(n) {
            if (isNumber(n)) return n;

            return 0;
        }

        function jsRecalcular() {

            //alert("a");
            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
            //a=document.getElementById(objID)
            //alert(a.value);


            //if (getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtBrutoPosicion").value > 0 && getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTaraPosicion").value > 0) {

            brutoposicion = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtBrutoPosicion").value
            taraposicion = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTaraPosicion").value;

            brutodescarga = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtBrutoDescarga").value;
            taradescarga = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtTaraDescarga").value;


            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////
            //PESTA�A POSICION
            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////

            brutoposicion = +parseFloat(brutoposicion);
            if (!isNumber(brutoposicion)) brutoposicion = 0;

            taraposicion = +parseFloat(taraposicion);
            if (!isNumber(taraposicion)) taraposicion = 0;

            if (!(brutoposicion == 0 && taraposicion == 0)) // para que no me modifique el neto si no hay datos en el bruto NI en la tara
            {
                getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNetoPosicion").value = brutoposicion - taraposicion;
                if (taraposicion > brutoposicion) getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNetoPosicion").value = 0;
            }

            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////
            //PESTA�A DESCARGA
            ///////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////

            brutodescarga = +parseFloat(brutodescarga);
            if (!isNumber(brutodescarga)) brutodescarga = 0;

            taradescarga = +parseFloat(taradescarga);
            if (!isNumber(taradescarga)) taradescarga = 0;

            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga").value = brutodescarga - taradescarga;
            if (taradescarga > brutodescarga) getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga").value = 0;


            ///////////////////////////////////////////////////////////////////////////////
            //neto final con mermas y sarasas
            ///////////////////////////////////////////////////////////////////////////////

            netodescarga = toNumber(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga").value);
            humedad = toNumber(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtHumedadTotal").value);
            fumigada = toNumber(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtFumigada").value);
            secada = toNumber(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtSecada").value);
            otrasmermas = toNumber(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtMerma").value);

            txtnetototal = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoFinalTotalMenosMermas");

            if (netodescarga > 0) {
                txtnetototal.value = Math.round(netodescarga - humedad - fumigada - secada - otrasmermas);
            }
            return false;
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
                <table style="font-size: small" align="center" width="100%">
                    <%-- <tr>
                        <td align="center" style="font-weight: bold; color: white; background-color: green">
                            Informaci�n
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="height: 37px;" align="center">
                            <span style="color: #ffffff">
                                <br />
                                <asp:Label ID="LblPreRedirectMsgbox" runat="server" Text="Hay clientes que no existen en la base. Desea crearlos como provisorios?"
                                    ForeColor="White"></asp:Label><br />
                                <br />
                                <asp:Button ID="ButMsgboxSI" runat="server" CssClass="but" Text="S�" />
                                <asp:Button ID="ButMsgboxNO" runat="server" CssClass="butcancela" Text="No" /><br />
                            </span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="PanelInfo" runat="server" Height="87px" Visible="false" Width="395px">
                <table style="" class="t1">
                    <tr>
                        <td align="center" style="font-weight: bold; color: white; background-color: red;
                            height: 14px;">
                            Informaci�n
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 37px" align="center">
                            <strong><span style="color: #ffffff">
                                <br />
                                El RM no se ha creado correctamente<br />
                                <br />
                            </span></strong>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="RespuestaMsgBox" runat="server" />
    <asp:UpdatePanel ID="UpdatePanelAnulacion" runat="server">
        <ContentTemplate>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none;" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel5" runat="server" Height="172px" Style="vertical-align: middle;
                text-align: center; display: none;" Width="220px" BorderColor="Transparent" ForeColor="White"
                CssClass="modalPopup">
                <div align="center" style="height: 170px;">
                    Ingrese usuario, password y motivo
                    <br />
                    <br />
                    <asp:DropDownList ID="cmbUsuarioAnulo" runat="server" CssClass="CssCombo" EnableViewState="true">
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
                <%-- OkControlID se lo saqu� porque no estaba llamando al codigo del servidor--%></cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelLiberar" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Button ID="Button5" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel1" runat="server" Height="119px" Width="221px" BorderColor="Transparent"
                CssClass="modalPopup" Style="vertical-align: middle; text-align: center" ForeColor="White">
                <div align="center">
                    Ingrese usuario y password
                    <br />
                    <br />
                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="CssCombo" EnableViewState="false">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                        Width="177px"></asp:TextBox><br />
                    <br />
                    <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False" />
                    <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button5"
                PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="btnOk"
                DropShadow="false" CancelControlID="btnCancelarLibero">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx--%>
</asp:Content>
