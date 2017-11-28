<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CartadeporteMovil.aspx.vb" Inherits="CartadeporteABMMovil" Title="Untitled Page"
    EnableEventValidation="false" %>

<%--lo del enableeventvalidation lo puse porque tenia un problema con este abm. no copiarlo a los demas abms--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">








    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     jquery          /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>





    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     bootstrap    /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--////////////    jqgrid     //////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.4/i18n/grid.locale-es.js"></script>



    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/i18n/grid.locale-es.js"></script>
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/css/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/ui.multiselect.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.contextmenu.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.searchFilter.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.tablednd.js"></script>
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/searchFilter.css" rel="stylesheet" type="text/css" />
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/ui.multiselect.css" rel="stylesheet" type="text/css" />

    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/jquery.jqGrid.min.js"></script>








    <title>BDL Consultores</title>

    <%--  <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />--%>

    <link rel="shortcut icon" type="image/ico" href="favicon.png" />


    <%--    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        //ga('create', 'UA-31129433-2', 'auto');
        ga('create', 'UA-31129433-2', { 'siteSpeedSampleRate': 100 });
        ga('send', 'pageview');

    </script>--%>
</head>


    <%--https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag--%>









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

            if (false) {
                $("#cmbCosecha").val(c);
                getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbCosecha").value = c;
            }
            else {
                //getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbCosecha").value = "-";
                getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbCosecha").selectedIndex = 0;

            }

            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbPuntoVenta").value = p;

            //var fechaArribo = getDateFromFormat(getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo").value, "dd/MM/yyyy");
            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo").value = prettyDate; //  '1/1/2001';

            getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtPorcentajeHumedad").value = 0;

            //            a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFechaArribo");
            //            a.value = ;


            //  pongo el foco en el numero
            var tabContainer = $find('ctl00_ContentPlaceHolder1_TabContainer2');
            a = getObj("ctl00_ContentPlaceHolder1_txtNumeroCDP");
            tabContainer.set_activeTabIndex(0);
            try {
                // a.focus();
            } catch (e) {

            }

            reasignarAutocomplete()


        }

    </script>
    <script type="text/javascript">


        function TabListo(sender, args) {
            //alert("salud")
            scrollToLastRow($("#Lista"))
        }



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
    <div style="width: ; margin-top: 3px; height: auto;">
        <table style="padding: 0px; border: none #FFFFFF; width: ; margin-right: 0px; font-size: large;"
            cellpadding="1" cellspacing="1">
            <%--  <tr>
                <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                    font-size: large; height: 12px;" align="left" valign="top">
                    CARTA DE PORTE
                  
                </td>
               
            </tr>--%>
            <tr>
                <td class="EncabezadoCell" style="width: 70px; font-weight: bold; font-size: 20px;">C.PORTE
                </td>
                <td class=" " colspan="3">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div>
                                    <a href="javascript:;" accesskey="f"></a>
                                    <asp:TextBox ID="txtNumeroCDP" runat="server" Width="120px" TabIndex="2" AutoPostBack="True"
                                        Font-Bold="true" Font-Size="24px" Height="24px" MaxLength="10" Style="font-weight: bolder;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender441" runat="server" TargetControlID="txtNumeroCDP"
                                        ValidChars="1234567890" Enabled="True">
                                    </cc1:FilteredTextBoxExtender>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtNumeroCDP"
                                        ErrorMessage="* Ingrese un número de CDP" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender8" runat="server"
                                        Enabled="True" TargetControlID="RequiredFieldValidator12" CssClass="CustomValidatorCalloutStyle" />
                                    <asp:TextBox ID="txtSubfijo" runat="server" Width="35px" TabIndex="2" ToolTip="Subfijo"
                                        MaxLength="5" Font-Size="24px" Height="24px" Style="font-weight: bolder;"></asp:TextBox>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender112" runat="server" TargetControlID="txtSubfijo"
                                        ValidChars="1234567890" Enabled="True" />
                                    <style>
                                        .aaa {
                                            color: rgb(235, 235, 235);
                                            font-weight: 100;
                                            font-size: 18px;
                                        }
                                    </style>
                                    <%-- <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtSubfijo"
                                        WatermarkText="Subf" WatermarkCssClass="watermarked aaa" Enabled="True" />--%>
                                    <asp:TextBox ID="txtSubNumeroVagon" runat="server" Width="80px" TabIndex="2" AutoPostBack="True"
                                        ToolTip="Vagón" MaxLength="7" Font-Size="24px" Height="24px" Style="font-weight: bolder;">
                                        
                                        
                                    </asp:TextBox><asp:Label ID="lblFamiliaDuplicados" Style="width: 20px; font-weight: normal; font-size: 12px;"
                                        runat="server" />
                                    <asp:Label ID="lblErrorUnicidad" runat="server" BackColor="#CC3300" BorderStyle="None"
                                        Font-Size="Large" ForeColor="White" Height="18px" Style="text-align: center; visibility: hidden; display: none; margin-left: 0px; vertical-align: top"
                                        Text="X"
                                        Visible="False" Width="23px"></asp:Label>
                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender134" runat="server" TargetControlID="txtSubNumeroVagon"
                                        ValidChars="1234567890" Enabled="True" />
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="El número debe tener 9 o 10 dígitos"
                                        ControlToValidate="txtNumeroCDP" Height="16px" Width="255px" Style="display: inline"
                                        ValidationGroup="Encabezado" MaximumValue="9999999999" MinimumValue="100000000"
                                        Display="Dynamic"></asp:RangeValidator>
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender9" runat="server"
                                        Enabled="True" TargetControlID="RangeValidator1" CssClass="CustomValidatorCalloutStyle" />
                                    <%--  <ajaxToolkit:TextBoxWatermarkExtender ID="Textboxwatermarkextender1" runat="server"
                                        TargetControlID="txtSubNumeroVagon" WatermarkText="Vagón" WatermarkCssClass="watermarked aaa"
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
                                            <img src="../Imagenes/error-icon.png" alt="" id="imageUnicidadError" style="border-style: none; border-color: inherit; border-width: medium; vertical-align: middle; text-decoration: none; margin-left: 5px; height: 24px; width: 24px;"
                                                visible="true" title="Este número ya existe en la base!" />
                                            Número duplicado!
                                        </asp:Panel>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtNumeroCDP" EventName="TextChanged"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="txtSubfijo" EventName="TextChanged"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="txtSubNumeroVagon" EventName="TextChanged"></asp:AsyncPostBackTrigger>
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
        <cc1:TabContainer ID="TabContainer2" runat="server" Height="" Width=""
            Style="" ActiveTabIndex="0" CssClass="NewsTab" AccessKey="p">
            <%--  CssClass="SimpleTab"        CssClass="NewsTab"--%>
            <cc1:TabPanel ID="TabPanel2" runat="server" Height="550px">
                <HeaderTemplate>
                    <u>P</u>osición
                </HeaderTemplate>
                <ContentTemplate>
                    <div style="padding: 4px 0px 8px 2px;">
                        <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-left: 5px; margin-right: 5px; margin-top: 5px"
                            cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">Fecha arribo
                                </td>
                                <td class="EncabezadoCell" style="width: 35%; height: 26px;">
                                    <asp:TextBox ID="txtFechaArribo" runat="server" Width="72px" MaxLength="1" TabIndex="2"
                                        Style="margin-right: 0px"></asp:TextBox>
                                    <asp:Button ID="Button4" runat="server" Style="margin-left: 0px" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator229" runat="server" ControlToValidate="txtFechaArribo"
                                        ErrorMessage="* Ingrese una fecha de arribo" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                                    <asp:RangeValidator ID="RangeValidatorFechaArribo" runat="server" ErrorMessage="(Alerta: mas de 3 días de diferencia con hoy)"
                                        ControlToValidate="txtFechaArribo" Height="16px" Style="display: inline; color: Black; background: yellow"
                                        Display="Dynamic" MinimumValue="1/1/1900" MaximumValue="9/9/2100"
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
                                                            <img id="imgFotoCarta" runat="server" style="height: 60px; max-width: 100px; background-image: ; background-position: -0px -0px;" />
                                                            <asp:LinkButton Style="vertical-align: top" ID="quitarimagen1" CausesValidation="false"
                                                                Target="_blank" runat="server" Text="x" Visible="true"></asp:LinkButton>
                                                        </a>
                                                            <asp:HyperLink ID="linkImagen" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
                                                            <a id="linkimagenlabel2" runat="server" href=" ">
                                                                <img id="imgFotoCarta2" runat="server" style="height: 60px; max-width: 100px; background-image: ; background-position: -0px -0px;" />
                                                            </a>
                                                            <asp:LinkButton ID="quitarimagen2" Style="vertical-align: top" Target="_blank" CausesValidation="false"
                                                                runat="server" Text="x" Visible="true"></asp:LinkButton>
                                                            <asp:HyperLink ID="linkImagen_2" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
                                                        </span>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>

                                                <asp:HyperLink ID="linkPDF" Target="_blank" runat="server" Text="PDF" Visible="true"></asp:HyperLink>
                                                <asp:HyperLink ID="linkTIF" Target="_blank" runat="server" Text="TIFF" Visible="true"></asp:HyperLink>
                                            </td>
                                            <td class="" style="height: 80px;" colspan="1">
                                                <asp:Panel ID="Panel3" runat="server" Width="50px">
                                                    <style>
                                                        .AFU {
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
                                                            background:; /*url("imagenes/barato.png") no-repeat 100% 1px;*/
                                                        }

                                                            .AFU div {
                                                                width: 150px !important;
                                                                background-image: none !important;
                                                            }

                                                            .AFU input {
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

                                                        .AFU2 input {
                                                            background: url("../imagenes/imagen2.png") no-repeat 100% 1px;
                                                        }

                                                        .AFU3 input {
                                                            background: url("../imagenes/imagen3.png") no-repeat 100% 1px;
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
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">Punto venta
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
                                <td class="EncabezadoCell" onkeydown="return jsVerificarAcopiosFacturarA();">
                                    <script type="text/javascript">


                                        function jsVerificarAcopiosFacturarA() {


                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtFacturarleAesteCliente");
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optAcopiosFacturarA");

                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            jsAcopiosPorCliente(txttitular, optDivisionSyngenta);

                                        }


                                    </script>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:HyperLink ID="linkFactura" Target="_blank" runat="server" Text="Ir a"></asp:HyperLink>
                                            <asp:TextBox ID="txtFacturarleAesteCliente" runat="server" autocomplete="off" TabIndex="2"
                                                Width="180px" Visible="False"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender30" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtFacturarleAesteCliente" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>



                                            <asp:DropDownList ID="optAcopiosFacturarA" runat="server" ToolTip="Elija el acopio"
                                                Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                                TabIndex="7">
                                                <asp:ListItem Text="Agro" />
                                                <asp:ListItem Text="Seeds" />
                                            </asp:DropDownList>

                                            <br />


                                            <asp:LinkButton ID="butVerLog" Text="Historial" runat="server" CausesValidation="false" />
                                            &nbsp;&nbsp;&nbsp;
                                            <asp:CheckBox ID="chkFacturarManual" runat="server" Text="manual" ForeColor="White" ToolTip="marcar si no se quiere calcular automáticamente el cliente"
                                                TabIndex="7" />

                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 26px;">CEE n°
                                </td>
                                <td class="EncabezadoCell " style="width: 35%; height: 26px;">
                                    <asp:TextBox ID="txtCEE" runat="server" Width="180px" TabIndex="2"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 26px;">Fecha carga
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
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">CTG n°
                                </td>
                                <td class="EncabezadoCell " style="width: 35%; height: 23px;">
                                    <asp:TextBox ID="txtCTG" runat="server" Width="100px" TabIndex="5"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%; height: 23px;">Vencimiento
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
                                <td class="EncabezadoCell" style="width: 15%">Titular
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngenta();">
                                    <asp:HiddenField ID="HiddenCasosEspeciales" runat="server" />
                                    <script type="text/javascript">



                                        //                                        $("#optDivisionSyngenta").change(function () {

                                        //                                            $("#HiddenCasosEspeciales").val($("#optDivisionSyngenta").val());

                                        //                                        });

                                        function addslashes(str) {
                                            return (str + '').replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
                                        }









                                        String.prototype.escapeSpecialChars = function () {
                                            return this.replace(/\\n/g, "\\n")
                                                       .replace(/\\'/g, "\\'")
                                                       .replace(/\\"/g, '\\"')
                                                       .replace(/\\&/g, "\\&")
                                                       .replace(/\\r/g, "\\r")
                                                       .replace(/\\t/g, "\\t")
                                                       .replace(/\\b/g, "\\b")
                                                       .replace(/\\f/g, "\\f");
                                        };








                                        function jsAcopiosPorCliente(textbox, combo) {
                                            //var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTitular");

                                            var $txttitular = $("#" + textbox.id + "")
                                            var $select = $("#" + combo.id + "")



                                            var myJSONString = JSON.stringify($("#ctl00_ContentPlaceHolder1_HFSC").val());
                                            var myEscapedJSONString = myJSONString.escapeSpecialChars();

                                            var aaa = addslashes($("#ctl00_ContentPlaceHolder1_HFSC").val())


                                            $.ajax({
                                                // url: "/CartaDePorte.aspx/AcopiosPorCliente",
                                                url: "WebServiceClientes.asmx/AcopiosPorCliente",
                                                type: 'POST',
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                //dataType: "xml",
                                                data: "{'NombreCliente':'" +
                                                       addslashes($txttitular.val()) +
                                                     "', 'SC':'" + aaa + "' }",


                                                //data: {
                                                //    NombreCliente: 'asdfasdf',
                                                //    SC:  'asdfsadfsa' // $("#HFSC").val()
                                                //},
                                                success: function (data) {

                                                    var x = data.d;

                                                    //var $select= $('select#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta');

                                                    var guardoelactualId = $select.val()
                                                    $select.find('option').remove();



                                                    $.each(x, function (i, val) {


                                                        $select.append('<option value=' + val.idacopio + '>' + val.desc + '</option>');

                                                        //$('select#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta').append(
                                                        //$("<option></option>")
                                                        //    .val(val.idacopio).text(val.desc));

                                                    });

                                                    $select.val(guardoelactualId)

                                                    if (x.length > 1) combo.style.visibility = "visible";
                                                    else combo.style.visibility = "hidden";

                                                },
                                                error: function (xhr) {
                                                    // alert("Something seems Wrong");
                                                }
                                            });

                                        }


                                        function comboCasosEspeciales(textbox, combo) {

                                            return

                                            if (textbox.value.indexOf("SYNGENTA") != -1) {
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


                                                if ($("#" + combo.id + " :selected").attr('disabled')) // quedó elegido uno deshabilitado
                                                {
                                                    $("#" + combo.id + " option:not([disabled]):first").attr('selected', 'selected')
                                                }

                                            }
                                            else if ((textbox.value.indexOf("A.C.A") != -1 || textbox.value.indexOf("LDC ARGENTINA S.A.") != -1) &&
                                                // http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11341
                                                    (textbox.id != "ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestinatario")) {





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


                                                if ($("#" + combo.id + " :selected").attr('disabled')) // quedó elegido uno deshabilitado
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

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTitular");
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta");


                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);

                                            jsAcopiosPorCliente(txttitular, optDivisionSyngenta);



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
                                    <asp:TextBox ID="txtTitular" runat="server" autocomplete="off" TabIndex="6" Width="180px"
                                        Style="font-size: 14px; font-weight: bold; font-family: 'Helvetica Narrow', 'Arial Narrow', Tahoma, Arial, Helvetica, sans-serif;"></asp:TextBox>
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
                                    <asp:DropDownList ID="optDivisionSyngenta" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="6">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                        <asp:ListItem Text="Acopio 1 ACA" Value="ACA401" />
                                        <asp:ListItem Text="Acopio 2 ACA" Value="ACA401" />
                                        <asp:ListItem Text="Acopio 3 ACA" Value="ACA402" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">Intermediario
                                </td>
                                <td class="EncabezadoCell" onkeydown="return jsVerificarSyngentaIntermediario();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaIntermediario() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtIntermediario");
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaIntermediario");


                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            jsAcopiosPorCliente(txttitular, optDivisionSyngenta);

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
                                        TabIndex="7"
                                        Style="font-size: 14px; font-weight: bold; font-family: 'Helvetica Narrow', 'Arial Narrow', Tahoma, Arial, Helvetica, sans-serif;"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" CompletionSetCount="12"
                                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                        TargetControlID="txtIntermediario" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                        CompletionInterval="100" DelimiterCharacters="" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                    <asp:DropDownList ID="optDivisionSyngentaIntermediario" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="7">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Remit comerc
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngentaRemitente();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaRemitente() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtRcomercial");
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaRemitente");

                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            jsAcopiosPorCliente(txttitular, optDivisionSyngenta);

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
                                    <asp:TextBox ID="txtRcomercial" runat="server" autocomplete="off" Width="180px" TabIndex="8"
                                        Style="font-size: 14px; font-weight: bold; font-family: 'Helvetica Narrow', 'Arial Narrow', Tahoma, Arial, Helvetica, sans-serif;"></asp:TextBox>
                                    <cc1:AutoCompleteExtender
                                        ID="AutoCompleteExtender4" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                        ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtRcomercial"
                                        UseContextKey="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                        Enabled="True" CompletionInterval="100">
                                    </cc1:AutoCompleteExtender>
                                    <asp:DropDownList ID="optDivisionSyngentaRemitente" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="8">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">Corredor
                                </td>
                                <td class="EncabezadoCell" onkeydown="return jsVerificarSyngentaCorredor();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaCorredor() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtCorredor");
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
                                    <asp:TextBox ID="txtCorredor" runat="server" autocomplete="off" Width="180px" TabIndex="9"
                                        Style="font-size: 14px; font-weight: bold; font-family: 'Helvetica Narrow', 'Arial Narrow', Tahoma, Arial, Helvetica, sans-serif;"></asp:TextBox>
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
                                    <asp:DropDownList ID="optDivisionSyngentaCorredor" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="9">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Destinatario
                                </td>
                                <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngentaDestinatario();">
                                    <script type="text/javascript">


                                        function jsVerificarSyngentaDestinatario() {

                                            //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                            //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                            //a=document.getElementById(objID)
                                            //alert(a.value);

                                            var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestinatario");
                                            var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngentaDestinatario");

                                            comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                            jsAcopiosPorCliente(txttitular, optDivisionSyngenta);

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
                                        TabIndex="10"
                                        Style="font-size: 14px; font-weight: bold; font-family: 'Helvetica Narrow', 'Arial Narrow', Tahoma, Arial, Helvetica, sans-serif;"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender6"
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
                                    <asp:DropDownList ID="optDivisionSyngentaDestinatario" runat="server" ToolTip="Elija la División de Syngenta"
                                        Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                        TabIndex="10">
                                        <asp:ListItem Text="Agro" />
                                        <asp:ListItem Text="Seeds" />
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%"></td>
                                <td class="EncabezadoCell"></td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Transportista
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
                                <td class="EncabezadoCell" style="width: 15%">Chofer
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
                        <table style="border-color: #FFFFFF; border-style: none none none none; border-width: thin; padding: 0px; width: 100%; margin-left: 5px; margin-right: 0px;"
                            cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td style="width: 15%; height: 9px;" class="EncabezadoCell">Producto
                                </td>
                                <td style="height: 9px; width: 35%;">
                                    <asp:TextBox ID="txt_AC_Articulo" runat="server" autocomplete="off" Style="margin-left: 0px"
                                        Width="180px" CssClass="CssTextBox" TabIndex="13"></asp:TextBox><cc1:AutoCompleteExtender
                                            ID="AutoCompleteExtender2" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                            ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo"
                                            UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                            DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>



                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="txt_AC_Articulo"
                                        ErrorMessage="* Ingrese un grano" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                        ValidationGroup="Encabezado" Style="display: none" />
                                    <ajaxToolkit:ValidatorCalloutExtender
                                        ID="ValidatorCalloutExtender3" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator3"
                                        CssClass="CustomValidatorCalloutStyle" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 15%; height: 11px;" class="EncabezadoCell">Contrato
                                </td>
                                <td style="height: 11px; width: 35%;">
                                    <asp:TextBox ID="txtContrato" runat="server" TabIndex="14" Width="100px"></asp:TextBox>
                                </td>
                                <td style="width: 15%; height: 1px;" class="EncabezadoCell">Peso Bruto
                                </td>
                                <td style="height: 1px;">
                                    <asp:TextBox ID="txtBrutoPosicion" runat="server" CssClass="CssTextBoxChico" Style="text-align: right;"
                                        TabIndex="16"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4"
                                            runat="server" TargetControlID="txtBrutoPosicion" ValidChars=".1234567890" Enabled="True">
                                        </cc1:FilteredTextBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 1px;">Cosecha
                                </td>
                                <td style="height: 1px; width: 35%;">
                                    <asp:DropDownList ID="cmbCosecha" runat="server" CssClass="CssCombo" TabIndex="14">
                                        <asp:ListItem Value="" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="2017/18">2017/18</asp:ListItem>
                                        <asp:ListItem Value="2016/17">2016/17</asp:ListItem>
                                        <asp:ListItem>2015/16</asp:ListItem>
                                        <asp:ListItem>2014/15</asp:ListItem>
                                        <asp:ListItem>2013/14</asp:ListItem>
                                        <asp:ListItem>2012/13</asp:ListItem>
                                        <asp:ListItem>2011/12</asp:ListItem>
                                        <asp:ListItem>2010/11</asp:ListItem>
                                        <asp:ListItem>2009/10</asp:ListItem>
                                        <asp:ListItem>2008/09</asp:ListItem>
                                        <asp:ListItem>2007/08</asp:ListItem>
                                    </asp:DropDownList>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator100" runat="server" ControlToValidate="cmbCosecha"
                                        InitialValue="" ErrorMessage="* Ingrese una cosecha" Font-Size="Small" ForeColor="#FF3300"
                                        Font-Bold="True" ValidationGroup="Encabezado" Style="display: none" />
                                    <ajaxToolkit:ValidatorCalloutExtender
                                        ID="ValidatorCalloutExtender10" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator100"
                                        CssClass="CustomValidatorCalloutStyle" />--%>
                                </td>
                                <td style="width: 15%;" class="EncabezadoCell">Peso Tara
                                </td>
                                <td style="height: 9px;">
                                    <asp:TextBox ID="txtTaraPosicion" runat="server" CssClass="CssTextBoxChico" Style="text-align: right;"
                                        TabIndex="17"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3"
                                            runat="server" TargetControlID="txtTaraPosicion" ValidChars=".1234567890" Enabled="True">
                                        </cc1:FilteredTextBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%; height: 9px;">Exportación
                                </td>
                                <td style="height: 9px; width: 35%;">
                                    <asp:CheckBox ID="chkExporta" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                        TabIndex="14" />
                                    No facturar a subcontratistas
                                    <asp:CheckBox ID="chkNoFacturarASubcontratistas" runat="server" ForeColor="White"
                                        ToolTip="Para controlar el stock del cliente" TabIndex="14" />
                                    <td class="EncabezadoCell" style="width: 15%; height: 11px;">Peso Neto
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
                                <table style="padding: 0px; border: none #FFFFFF; width: 100%; margin-left: 5px; margin-right: 0px;"
                                    cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%; height: 12px;">Procedencia
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
                                        <td class="EncabezadoCell" style="width: 15%; height: 12px;">Destino
                                        </td>
                                        <td class="EncabezadoCell" style="height: 12px">
                                            <asp:TextBox ID="txtDestino" runat="server" autocomplete="off" AutoCompleteType="None"
                                                Width="180px" TabIndex="20" AutoPostBack="false"></asp:TextBox>


                                            <%--<cc1:AutoCompleteExtender
                                                    ID="AutoCompleteExtender8" runat="server" CompletionSetCount="12" EnableCaching="true"
                                                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                                    TargetControlID="txtDestino" UseContextKey="true" CompletionListCssClass="AutoCompleteScroll"
                                                    FirstRowSelected="true" CompletionInterval="100">
                                                </cc1:AutoCompleteExtender>--%>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDestino"
                                                ErrorMessage="* Ingrese el destino" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                                InitialValue="" ValidationGroup="Encabezado" Style="display: none" /><ajaxToolkit:ValidatorCalloutExtender
                                                    ID="ValidatorCalloutExtender6" runat="server" Enabled="True" TargetControlID="RequiredFieldValidator7"
                                                    CssClass="CustomValidatorCalloutStyle" />
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%;">Subcontr. 1
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSubcontr1" runat="server" autocomplete="off" Width="180px" TabIndex="90" Enabled="false"></asp:TextBox><cc1:AutoCompleteExtender
                                                ID="AutoCompleteExtender9" runat="server" CompletionSetCount="12" MinimumPrefixLength="1"
                                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtSubcontr1"
                                                UseContextKey="True" FirstRowSelected="True" DelimiterCharacters="" Enabled="True"
                                                CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">Contrato
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:DropDownList ID="cmbTipoContrato1" runat="server" CssClass="CssCombo" TabIndex="90">
                                                <asp:ListItem Value="0" Selected="True">Calado</asp:ListItem>
                                                <asp:ListItem Value="1">Balanza</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%">Subcontr. 2
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSubcontr2" runat="server" autocomplete="off" Width="180px" TabIndex="90" Enabled="false"
                                                CssClass="CssTextBox">
                                        
                                            </asp:TextBox><cc1:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server"
                                                CompletionSetCount="12" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                                ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtSubcontr2" UseContextKey="True"
                                                FirstRowSelected="True" DelimiterCharacters="" Enabled="True">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">Contrato
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:DropDownList ID="cmbTipoContrato2" runat="server" CssClass="CssCombo" TabIndex="90">
                                                <asp:ListItem Value="0">Calado</asp:ListItem>
                                                <asp:ListItem Value="1" Selected="True">Balanza</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <table style="padding: 0px; border: none #FFFFFF; width: 100%; height: 53px; margin-left: 5px; margin-right: 0px;"
                            cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Pat camión
                                </td>
                                <td class="EncabezadoCell" style="width: 35%;">
                                    <asp:TextBox ID="txtPatenteCamion" runat="server" Width="66px" MaxLength="9" TabIndex="23"
                                        CssClass="UpperCase"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">Pat acoplado
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtPatenteAcoplado" runat="server" Width="66px" MaxLength="9" TabIndex="24"
                                        CssClass="UpperCase"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Km a recorrer
                                </td>
                                <td class="EncabezadoCell" style="width: 35%;">
                                    <asp:TextBox ID="txtKmRecorrer" runat="server" CssClass="CssTextBoxChico" TabIndex="25"></asp:TextBox>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">Tarifa
                                </td>
                                <td class="EncabezadoCell">
                                    <asp:TextBox ID="txtTarifa" runat="server" CssClass="CssTextBoxChico" TabIndex="26"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="EncabezadoCell" style="width: 15%">Movimiento
                                </td>
                                <td>
                                    <asp:DropDownList ID="cmbMovimientoLosGrobo" runat="server" CssClass="CssCombo" TabIndex="26">
                                        <asp:ListItem Value="1">1. Egresos contratos de Venta</asp:ListItem>
                                        <asp:ListItem Value="2">2. Egreso Directo a Destino Productor</asp:ListItem>
                                        <asp:ListItem Value="3">3. Directo Destino contrato de Compra</asp:ListItem>
                                        <asp:ListItem Value="4">4. Ingreso Entregado Productor</asp:ListItem>
                                        <asp:ListItem Value="5">5. Ingreso Contrato de Compra</asp:ListItem>
                                        <asp:ListItem Value="6">6. Reingreso de Mercadería</asp:ListItem>
                                        <asp:ListItem Value="7">7. Transferencia desde otra Planta</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="EncabezadoCell" style="width: 15%">Establecmnto
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
                                <table style="padding: 0px; border: none #FFFFFF; width: 696px; height: 202px; margin-left: 5px; margin-right: 0px;"
                                    cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Descarga
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

                                                    //alert("La fecha de descarga tiene mas de 2 días de diferencia con el arribo");
                                                    if (days > 2) {
                                                        alert("La fecha de descarga tiene mas de 2 días de diferencia con el arribo");
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
                                            <%--
                                            <asp:RangeValidator ID="RangeValidatorFechaDescarga" runat="server" ErrorMessage="(Alerta: mas de 3 días de diferencia con fecha de arribo)"
                                                ControlToValidate="txtFechaDescarga" Height="16px" Style="display: inline" Display="Dynamic"
                                                MaximumValue="9/9/2100" Type="Date" Enabled="false"></asp:RangeValidator>--%>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" AcceptNegative="Left"
                                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                TargetControlID="txtFechaDescarga">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">Hora
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtHoraDescarga" runat="server" MaxLength="1" Width="72px" TabIndex="28"></asp:TextBox><cc1:MaskedEditExtender
                                                ID="MaskedEditExtender66" TargetControlID="txtHoraDescarga" MaskType="Time" runat="server"
                                                Mask="99:99">
                                            </cc1:MaskedEditExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">N° recibo
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtNRecibo" runat="server" Width="66px" TabIndex="29"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%; visibility: hidden; display: none;">Factor
                                        </td>
                                        <td class="EncabezadoCell" style="visibility: hidden; display: none;">
                                            <asp:TextBox ID="txtFactor" runat="server" Width="56px" TabIndex="29"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Calidad
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
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Peso Bruto
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtBrutoDescarga" runat="server" CssClass="CssNumBox" Width="66px"
                                                TabIndex="31"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender11"
                                                    runat="server" TargetControlID="txtBrutoDescarga" ValidChars=".1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Peso Tara
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:TextBox ID="txtTaraDescarga" runat="server" CssClass="CssNumBox" Width="66px"
                                                TabIndex="32"></asp:TextBox><cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender10"
                                                    runat="server" TargetControlID="txtTaraDescarga" ValidChars=".1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Peso Neto
                                        </td>
                                        <%--
                                        Cómo manejar el recalculo por javascript
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
                                        <td class="EncabezadoCell" style="width: 15%">Hum
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
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%">Fumigada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtFumigada" runat="server" CssClass="CssTextBox" Width="66px" TabIndex="35"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtFumigada" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 15%">Secada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtSecada" runat="server" CssClass="CssTextBox" Width="66px" TabIndex="36"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtSecada" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Otr. mermas
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtMerma" runat="server" CssClass="CssNumBox" Width="66px" TabIndex="37"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender5" runat="server" TargetControlID="txtMerma" ValidChars="1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Neto Final
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%;">
                                            <asp:TextBox ID="txtNetoFinalTotalMenosMermas" runat="server" CssClass="CssNumBox"
                                                TabIndex="37" Width="66px"></asp:TextBox>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%"></td>
                                        <td class="EncabezadoCell"></td>
                                    </tr>





                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Cliente Observaciones
                                        </td>

                                        <td class="EncabezadoCell" style="width: 35%" onkeydown="return jsVerificarSyngentaCliobs();">
                                            <script type="text/javascript">


                                                function jsVerificarSyngentaCliobs() {

                                                    //a = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtCantidad4");
                                                    //a = getObj("ctl00_ContentPlaceHolder1_lblAnulado0");
                                                    //a=document.getElementById(objID)
                                                    //alert(a.value);

                                                    var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtClienteAuxiliar");
                                                    var optDivisionSyngenta = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_optDivisionSyngentaCliobs");

                                                    comboCasosEspeciales(txttitular, optDivisionSyngenta);
                                                    jsAcopiosPorCliente(txttitular, optDivisionSyngenta);

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

                                            <asp:TextBox ID="txtClienteAuxiliar" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="38" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender16" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClienteAuxiliar" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>

                                            <asp:DropDownList ID="optDivisionSyngentaCliobs" runat="server" ToolTip="Elija la División de Syngenta"
                                                Width="100px" Height="21px" Style="visibility: visible; overflow: auto;" CssClass="CssCombo"
                                                TabIndex="10">
                                                <asp:ListItem Text="Agro" />
                                                <asp:ListItem Text="Seeds" />
                                            </asp:DropDownList>
                                        </td>



                                        <td class="EncabezadoCell" style="width: 15%">Entregador
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%">
                                            <asp:TextBox ID="txtClienteEntregador" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="38" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender17" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionListEntregadores" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClienteEntregador" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Corredor Observaciones
                                        </td>
                                        <td class="EncabezadoCell" onkeydown="">
                                            <asp:TextBox ID="TextBoxCorredorII" runat="server" autocomplete="off" Width="180px" TabIndex="38"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender19" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx"
                                                TargetControlID="TextBoxCorredorII" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>

                                        <td></td>
                                        <td>
                                            <asp:Label ID="lblDiferenciaKilos" runat="server" autocomplete="off" Width="180px" TabIndex="38" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Pagador Flete
                                        </td>
                                        <td class="EncabezadoCell" style="width: 35%">
                                            <asp:TextBox ID="txtClientePagadorFlete" runat="server" autocomplete="off" Width="180px"
                                                TabIndex="38" />
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender18" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                                                TargetControlID="txtClientePagadorFlete" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Observ
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" CssClass="CssTextBox"
                                                Width="526px" Height="42px" Style="margin-left: 0px" TabIndex="38"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Costo administrativo
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkConCostoAdministrativo" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Liquida viaje
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkLiquidaViaje" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Cobra acarreo
                                        </td>
                                        <td class="EncabezadoCell" colspan="3">
                                            <asp:CheckBox ID="chkCobraAcarreo" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" Checked="true" />
                                        </td>
                                    </tr>


                                    <%--                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////--%>

                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Recibidor Of.
                                        </td>
                                        <td class="EncabezadoCell" colspan="1">
                                            <asp:CheckBox ID="chkTieneRecibidorOficial" runat="server" ForeColor="White" ToolTip="Para controlar el stock del cliente"
                                                TabIndex="14" Checked="true" />

                                        </td>


                                        <td class="EncabezadoCell" style="width: 15%">Estado
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="cmbEstadoRecibidor" runat="server" CssClass="CssCombo" TabIndex="26">
                                                <asp:ListItem Value="0">Recibo</asp:ListItem>
                                                <asp:ListItem Value="1">Rechazo</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 15%">Movimiento
                                        </td>
                                        <td class="EncabezadoCell">
                                            <asp:DropDownList ID="cmbMotivoRechazoRecibidor" runat="server" CssClass="CssCombo" TabIndex="26">
                                                <asp:ListItem Value="0" Text=""></asp:ListItem>
                                                <asp:ListItem Value="1">Regresa Origen</asp:ListItem>
                                                <asp:ListItem Value="2">Acondiciona</asp:ListItem>
                                                <asp:ListItem Value="3">Cambia CP</asp:ListItem>
                                                <asp:ListItem Value="4">Cambio de Destino/Destinatario</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>


                                        <td class="EncabezadoCell" style="width: 15%">Acondicionador
                                        </td>
                                        <td class="EncabezadoCell" onkeydown="">
                                            <asp:TextBox ID="txtClienteAcondicionador" runat="server" autocomplete="off" Width="180px" TabIndex="38"></asp:TextBox>
                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender40" runat="server" CompletionSetCount="12"
                                                MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                                TargetControlID="txtClienteAcondicionador" UseContextKey="True" CompletionListCssClass="AutoCompleteScroll"
                                                DelimiterCharacters="" Enabled="True" CompletionInterval="100">
                                            </cc1:AutoCompleteExtender>
                                        </td>


                                        <td class="EncabezadoCell" style="width: 15%">Entrega SAP
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%">
                                            <asp:TextBox ID="txtEntregaSAP" runat="server" CssClass="CssTextBox"></asp:TextBox>
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
                            <asp:Panel ID="Panel4" runat="server" Height="670px">
                                <table style="padding: 0px; border: none #FFFFFF; width: 696px; height: 75px; margin-left: 5px; margin-right: 0px;"
                                    cellpadding="0" cellspacing="1">
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;"></td>
                                        <td class="EncabezadoCell" style="width: 15%;">Resultado
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">Rebaja
                                        </td>
                                        <td class="EncabezadoCell" style="">Merma
                                        </td>
                                        <td class="EncabezadoCell" style="">Tipo merma
                                        </td>
                                    </tr>











                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Cuerpos extraños/ materias
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox26" runat="server" CssClass="CssTextBox" Width="66px">


                                             

                                            </asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox26_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGranosExtranosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGranosExtranosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaGranosExtranos" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>


                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">Granos negros
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox27" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox27_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox27"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style=""></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Quebrados partidos
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadQuebradosResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox28_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadQuebradosResultado"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadQuebradosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadQuebradosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaQuebrados" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Dañados
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox29" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox29_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox29"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGranosDanadosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>


                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGranosDanadosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>


                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaDaniados" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Semilla de chamico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadChamicoResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox30_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadChamicoResultado"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadChamicoRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox31_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadChamicoRebaja"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadChamicoMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>


                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaChamico" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Revolcado en tierra
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadRevolcadoResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadRevolcadoRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox32_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadRevolcadoRebaja"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadRevolcadoMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaRevolcado" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Olores objetables
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadObjetablesResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadObjetablesRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox33_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadObjetablesRebaja"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadObjetablesMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaObjetables" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Granos amohosados
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadAmohosadosResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadAmohosadosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="TextBox34_FilteredTextBoxExtender" runat="server" TargetControlID="txtCalidadAmohosadosRebaja"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadAmohosadosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaAmohosados" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Punta sombreada
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtPuntaSombreada" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPuntaSombreadaRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox><cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender15" runat="server" TargetControlID="txtCalidadPuntaSombreadaRebaja"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPuntaSombreadaMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaPuntaSombreada" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Peso hectolítrico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox35" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox35_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox35"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadHectolitricoRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadHectolitricoMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaHectolitrico" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Granos con carbón
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox36" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox36_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox36"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadCarbonRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadCarbonMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaCarbon" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Panza blanca
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox37" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox37_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox37"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPanzaBlancaRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPanzaBlancaMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaPanzaBlanca" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Picados
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox38" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox38_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox38"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPicadosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadPicadosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaPicados" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">Materia grasa
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox39" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox39_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox39"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style=""></td>


                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">Acidez materia grasa
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox40" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox40_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox40"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style=""></td>


                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Granos verdes
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox41" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="TextBox41_FilteredTextBoxExtender" runat="server" TargetControlID="TextBox41"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadVerdesRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadVerdesMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaVerdes" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Granos Quemados o de Avería
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender1" runat="server" TargetControlID="TextBox1" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadQuemadosRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadQuemadosMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaQuemados" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Tierra
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender12" runat="server" TargetControlID="TextBox2" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList3" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadTierraRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadTierraMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaTierra" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr style="visibility: hidden; display: none;">
                                        <td class="EncabezadoCell" style="width: 215px;">Merma por Chamico
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox3" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender13" runat="server" TargetControlID="TextBox3" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList4" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="asdasddasads" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="asdasd" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaChamico2" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Mermas por Zarandeo
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="TextBox4" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender14" runat="server" TargetControlID="TextBox4" ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="DropDownList5" runat="server" CssClass="CssCombo" Width="59px"
                                                Visible="false">
                                                <asp:ListItem>Bonifica</asp:ListItem>
                                                <asp:ListItem>Rebaja</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadZarandeoRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadZarandeoMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaZarandeo" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Humedad
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadHumedadResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender18" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadHumedadRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadHumedadMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaHumedad" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Gastos de fumigación
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadGastosFumigacionResultado" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender17" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGastosFumigacionRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGastosFumigacionMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaFumigacion" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>




                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Gastos de Secada
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadGastoDeSecada" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender19" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGastoDeSecadaRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadGastoDeSecadaMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaGastoDeSecada" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>


                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Merma Volatil
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadMermaVolatil" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender20" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadMermaVolatilRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadMermaVolatilMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaVolatil" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>


                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Fondo Nidera
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadFondoNidera" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender21" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadFondoNideraRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadFondoNideraMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaFondoNidera" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Merma Convenida
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadMermaConvenida" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender22" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadMermaConvenidaRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadMermaConvenidaMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaConvenida" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Tal Cual Vicentin
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadTalCualVicentin" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender23" runat="server" TargetControlID="TextBox26"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadTalCualVicentinRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadTalCualVicentinMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>

                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaTalCualVicentin" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>



                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Descuento Final
                                        </td>
                                        <td class="EncabezadoCell" style="width: 15%;">
                                            <asp:TextBox ID="txtCalidadDescuentoFinal" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>%<cc1:FilteredTextBoxExtender
                                                ID="FilteredTextBoxExtender16" runat="server" TargetControlID="txtCalidadDescuentoFinal"
                                                ValidChars=".1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </td>
                                        <td class="EncabezadoCell" style="width: 4px;">&#160;&nbsp;
                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadDescuentoFinalRebaja" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:TextBox ID="txtCalidadDescuentoFinalMerma" runat="server" CssClass="CssTextBox" Width="66px"></asp:TextBox>Kg

                                        </td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaDescuentoFinal" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>.</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="EncabezadoCell" style="">Grado</td>
                                        <td>
                                            <asp:DropDownList ID="cmbNobleGrado" runat="server" CssClass="CssCombo" Width="59px">
                                                <asp:ListItem>0</asp:ListItem>
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                        <td class="EncabezadoCell" style=""></td>
                                        <td class="EncabezadoCell" style=""></td>
                                        <td class="EncabezadoCell" style=""></td>
                                        <td class="EncabezadoCell" style="">
                                            <asp:DropDownList ID="cmbTipoMermaGrado" runat="server" CssClass="CssCombo" Width="100px">
                                                <asp:ListItem Value="0">Física</asp:ListItem>
                                                <asp:ListItem Value="1">Arbitrado</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>

                                    </tr>
                                    <tr>

                                        <td></td>
                                        <td class="EncabezadoCell" style="" colspan="5">
                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="Conforme (Solo soja)" ForeColor="White" />
                                            <asp:CheckBox ID="CheckBox2" runat="server" Text="A Camara" ForeColor="White" />
                                            <asp:CheckBox ID="CheckBox3" runat="server" Text="Fuera de estandar" ForeColor="White" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>.</td>

                                        <td class="EncabezadoCell" style="" colspan="2">
                                            <asp:DropDownList ID="cmbBonifRebajGeneral" runat="server" CssClass="CssCombo">
                                                <asp:ListItem>Bonifica todos</asp:ListItem>
                                                <asp:ListItem>Rebaja todos</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td>.</td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td class="EncabezadoCell" style="width: 215px;">Soja Sustentable (sincro BLD)
                                        </td>

                                        <td class="EncabezadoCell" style="" colspan="5">Condic.
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

            <cc1:TabPanel ID="TabPanel1" runat="server" BackColor="#6600FF">
                <HeaderTemplate>
                    <u>S</u>ituación
                </HeaderTemplate>
                <ContentTemplate>
                    <br />
                    <br />
                    <table style="padding: 0px; border: none #FFFFFF; width: 696px; height: 202px; margin-left: 5px; margin-right: 0px;"
                        cellpadding="1" cellspacing="1">
                        <tr>


                            <td class="EncabezadoCell" style="width: 150px;">Situación</td>
                            <td>
                                <asp:DropDownList ID="cmbSituacion" runat="server" CssClass="CssCombo" Width="100px" Enabled="false">
                                    <asp:ListItem Value="0">Autorizado</asp:ListItem>
                                    <asp:ListItem Value="1">Demorado</asp:ListItem>
                                    <asp:ListItem Value="2">Posicion</asp:ListItem>
                                    <asp:ListItem Value="3">Descargado</asp:ListItem>
                                    <asp:ListItem Value="4">A Descargar</asp:ListItem>
                                    <asp:ListItem Value="5">Rechazado</asp:ListItem>
                                    <asp:ListItem Value="6">Desviado</asp:ListItem>
                                    <asp:ListItem Value="7">CP p/cambiar</asp:ListItem>
                                    <asp:ListItem Value="8">Sin Cupo</asp:ListItem>
                                    <asp:ListItem Value="9">Calado</asp:ListItem>
                                </asp:DropDownList>
                            </td>


                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 150px;">Observaciones

                            </td>

                            <td class="EncabezadoCell" style="">
                                <asp:TextBox ID="txtObsSituacion" runat="server" CssClass="CssTextBox" Width="200px" TextMode="MultiLine"></asp:TextBox>

                            </td>

                        </tr>



                        <tr>

                            <td class="EncabezadoCell" style="width: 150px;">Fecha de actualizacion
                            </td>

                            <td class="EncabezadoCell" style="width: 15%">

                                <asp:TextBox ID="txtFechaActualizacion" runat="server" MaxLength="1" Width="150px" TabIndex="27"
                                    onchange="" AutoPostBack="false" Enabled="false"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell" style="width: 150px;">Campos Actualizados

                            </td>
                            <td class="EncabezadoCell" style="">
                                <asp:TextBox ID="txtLogSituacion" Enabled="false" runat="server" CssClass="CssTextBox" Width="200px" Height="100px" TextMode="MultiLine"></asp:TextBox>

                            </td>


                        </tr>


                        <tr>

                            <td class="EncabezadoCell" style="width: 150px;">Fecha de autorización
                            </td>

                            <td class="EncabezadoCell" style="width: 15%">

                                <asp:TextBox ID="txtFechaAutorizacion" runat="server" MaxLength="1" Width="150px" TabIndex="27" Enabled="false"
                                    onchange="" AutoPostBack="false"></asp:TextBox>&nbsp
                                            

                            </td>

                            <td class="EncabezadoCell" style="">
                                <asp:Button ID="btnAutorizarSituacion" runat="server" CssClass="butcancela" Text="Autorizar"
                                    CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px"></asp:Button>
                            </td>
                        </tr>


                    </table>
                </ContentTemplate>
            </cc1:TabPanel>


            <cc1:TabPanel ID="TabPanel5" runat="server" BackColor="#6600FF" Height="550px" OnClientPopulated="TabListo()">
                <HeaderTemplate>
                    C<u>h</u>at
                </HeaderTemplate>

                <ContentTemplate>
                    <style>
                        /*.ui-jqgrid tr.jqgrow td { height: 30px; }*/


                        .ui-jqgrid tr.jqgrow td {
                            white-space: normal !important; /* para el wrap*/
                        }

                        /* .ui-jqgrid {font-size:0.8em} */
                        .ui-jqgrid tr.jqgrow td {
                            font-size: 0.6em
                        }
                        /* esto sí funciona!! -sera por las unidades en "em"? */
                        /* .ui-jqgrid{position:relative;font-size:11px;} */


                        /* Bump up the font-size in the grid */
                        /*
                        .ui-jqgrid,
                        .ui-jqgrid .ui-jqgrid-view,
                        .ui-jqgrid .ui-jqgrid-pager,
                        .ui-jqgrid .ui-pg-input {
                            font-size: 12px;
                        }
                            */

                        /*.ui-jqgrid {
    font-family: Arial;
}
.ui-jqgrid  {
    font-size: 10px;
}
.ui-jqgrid .ui-jqgrid-hdiv .ui-jqgrid-labels .ui-th-column {
    color: blue;
}

.ui-jqgrid {font-size:0.4em}*/
                    </style>

                    <table id="Lista" class="scroll" cellpadding="0" cellspacing="0" style="font-size: 22px;" width="">
                    </table>

                    <div id="ListaPager" class="scroll" style="text-align: center; height: ;">
                    </div>


                    <div class="row-fluid">

                        <asp:TextBox ID="TextBox5" runat="server" CssClass=" span8" Width="250px" Height="50px" TextMode="MultiLine" Enabled="true" Text="" />


                        <input type="button" id="Button6" value="enviar" class="btn btn-primary" style="height: 50px; vertical-align: top;" />

                        <span>
                            <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload3" runat="server" OnClientUploadComplete="ClientUploadComplete3"
                                UploaderStyle="Modern" CssClass="AFU AFU3" FailedValidation="False" />

                            <input type="button" id="Button77" value="cerrar consulta" class="btn btn-primary" />
                        </span>

                        <script>


                            function ClientUploadComplete3(sender, args) {
                                $('#Lista').trigger('reloadGrid'); scrollToLastRow($('#Lista'));
                            }



                            $("#__tab_ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5").click(function () {
                                //alert('holis');
                                scrollToLastRow($("#Lista"))
                            })




                            $("#Button6").click(function () {
                                //alert("hola")

                                var d = {
                                    idCartaPorte: qs["Id"],
                                    sComentario: $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_TextBox5").val()
                                }


                                $.ajax({
                                    type: "POST",
                                    //method: "POST",
                                    url: "WebServiceCartas.asmx/GrabarComentario",
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",

                                    data: JSON.stringify(d),

                                    success: function (data) {
                                        //alert(data.d);
                                        //window.open(data.d);
                                        $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_TextBox5").val("")
                                        $("#Lista").trigger("reloadGrid");
                                        scrollToLastRow($("#Lista"))
                                    }


                                    ,
                                    beforeSend: function () {
                                        //$('.loading').html('some predefined loading img html');
                                        $("#loading").show();
                                        $('#grabar2').attr("disabled", true).val("Espere...");

                                    },
                                    complete: function () {
                                        $("#loading").hide();
                                    }


                                })


                            })





                            function getGridRowHeight(targetGrid) {
                                var height = null; // Default

                                try {
                                    height = jQuery(targetGrid).find('tbody').find('tr:first').outerHeight();
                                }
                                catch (e) {
                                    //catch and just suppress error
                                }

                                return height;
                            }

                            function scrollToRow(targetGrid, id) {
                                var rowHeight = getGridRowHeight(targetGrid) || 23; // Default height
                                var index = jQuery(targetGrid).getInd(id);
                                jQuery(targetGrid).closest(".ui-jqgrid-bdiv").scrollTop(rowHeight * index);
                            }


                            function scrollToLastRow(targetGrid) {
                                jQuery("#Lista").closest(".ui-jqgrid-bdiv").scrollTop(10000) //como no anda bien scrollToLastRow, lo hago cabeza -probablemete porq esta incluida en el tabpanel...
                                return;
                                var rows = $(targetGrid)[0].rows;
                                var lastRowDOM = rows[rows.length - 1];

                                scrollToRow(targetGrid, $(lastRowDOM).attr('id'));
                            }



                        </script>

                    </div>



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
                    <img src="../Imagenes/GmailAdjunto2.png" alt="" style="border-style: none; border-color: inherit; border-width: medium; vertical-align: middle; text-decoration: none; margin-left: 5px;" />
                    <asp:LinkButton ID="lnkAdjuntar" runat="server" Font-Bold="False" Font-Size="Small"
                        Font-Underline="True" ForeColor="White" Height="16px" Width="63px" ValidationGroup="Encabezado"
                        TabIndex="8" OnClientClick="BrowseFile()" CausesValidation="False" Visible="False"
                        Style="margin-right: 0px">Adjuntar</asp:LinkButton><asp:Button ID="btnAdjuntoSubir"
                            runat="server" Font-Bold="False" Height="19px" Style="margin-left: 0px; margin-right: 23px; text-align: left;"
                            Text="Adjuntar" Width="58px" CssClass="button-link" CausesValidation="False" />
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
                    <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
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

                            <%--si no graba, puede ser el problema del prefijo 'ctl00_' que no se usa más en asp.net 4.0--%>
                            <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" Width="100px"
                                OnClientClick=" $find('ctl00_ContentPlaceHolder1_TabContainer2').set_activeTabIndex(0);   if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                                UseSubmitBehavior="False" Style="margin-left: 0px" ValidationGroup="Encabezado"
                                TabIndex="39"></asp:Button>
                            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="Cancelar"
                                Width="88px" CssClass="butcancela" CausesValidation="False" UseSubmitBehavior="False"
                                Style="margin-left: 28px; margin-right: 0px" Font-Bold="False" TabIndex="40"></asp:Button>
                            <asp:Button ID="btnAnular" runat="server" CssClass="butcancela" Text="Rechazar" CausesValidation="False"
                                UseSubmitBehavior="False" Style="margin-left: 28px" TabIndex="41" Width="88px"></asp:Button>
                            <asp:Button ID="btnDesfacturar" runat="server" CssClass="butcancela" Text="Desfacturar"
                                CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px;"
                                TabIndex="41"></asp:Button>
                            <asp:Button ID="btnDuplicarEscondido" runat="server" CssClass="butcancela" Text="Duplicar escondido"
                                CausesValidation="False" UseSubmitBehavior="False" Style="margin-left: 28px"
                                Visible="false" TabIndex="41"></asp:Button>
                            <asp:HyperLink ID="btnDuplicar" Target='_blank' runat="server" NavigateUrl='' onclick="jj()"
                                CssClass="butcancela" Width="88px" Height="14px" Font-Size="12px" Style="margin-left: 28px; vertical-align: top; padding: 8px; text-align: center;"
                                Text='Duplicar' Font-Underline="false"> </asp:HyperLink>
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
                            <asp:Label ID="Label1" Width="600px" runat="server" Font-Bold="true" ForeColor="LightGreen" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:LinkButton ID="lnkRepetirUltimaCDP" runat="server" Font-Bold="False" Font-Underline="false"
                        ForeColor="White" CausesValidation="False" Font-Size="Small" BorderStyle="None"
                        Visible="true" Style="margin-right: 0px; margin-left: 28px;" BorderWidth="5px"
                        TabIndex="41">Copiar la última que edité</asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel runat="server" ID="upLog" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="lblLog" Width="" runat="server" ForeColor="White"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
        Style="vertical-align: bottom; margin-top: 5px; margin-bottom: 6px; visibility: hidden;"
        CausesValidation="False" TabIndex="39" Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none; text-decoration: none;" />
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
            //PESTAÑA POSICION
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
            //PESTAÑA DESCARGA
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

            ActualizarDiferencia();

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
                            Información
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="height: 37px;" align="center">
                            <span style="color: #ffffff">
                                <br />
                                <asp:Label ID="LblPreRedirectMsgbox" runat="server" Text="Hay clientes que no existen en la base. Desea crearlos como provisorios?"
                                    ForeColor="White"></asp:Label><br />
                                <br />
                                <asp:Button ID="ButMsgboxSI" runat="server" CssClass="but" Text="Sí" />
                                <asp:Button ID="ButMsgboxNO" runat="server" CssClass="butcancela" Text="No" /><br />
                            </span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="PanelInfo" runat="server" Height="87px" Visible="false" Width="395px">
                <table style="" class="t1">
                    <tr>
                        <td align="center" style="font-weight: bold; color: white; background-color: red; height: 14px;">Información
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
            <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden; display: none;"
                Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel5" runat="server" Height="172px" Style="vertical-align: middle; text-align: center; display: none;"
                Width="220px" BorderColor="Transparent" ForeColor="White"
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
                            Width="174px" Style="text-align: center;" TextMode="MultiLine"></asp:TextBox>
                    </div>
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
                <%-- OkControlID se lo saqué porque no estaba llamando al codigo del servidor--%>
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
        <ContentTemplate>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button3" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden; display: none;"
                Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel6" runat="server" Height="" Style="vertical-align: middle; text-align: center; display: none;"
                Width="220px" BorderColor="Transparent" ForeColor="White" CssClass="modalPopup">
                <div align="center" style="height: ;">
                    Advertencia:
                    <br />
                    <br />
                    <asp:Label ID="Label2225" runat="server" />
                    <br />
                    <br />
                    Desea continuar?
                    <br />
                    <br />
                    <asp:Button ID="btnObviarAdvertencias" runat="server" Text="Sí" Width="80px" CausesValidation="false" />
                    <asp:Button ID="Button8" runat="server" Text="No" Width="72px" />
                </div>
                <asp:HiddenField ID="HiddenObviarAdvertencias" runat="server" />
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupObviarAdvertencias" runat="server" TargetControlID="Button3"
                PopupControlID="Panel6" BackgroundCssClass="modalBackground" DropShadow="false"
                OkControlID=""
                CancelControlID="Button8">
                <%-- OkControlID se lo saqué porque no estaba llamando al codigo del servidor--%>
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelLiberar" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Button ID="Button5" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden; display: none"
                Height="16px" Width="66px" />
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
    <asp:HiddenField ID="HFSC" runat="server" />



    <style>
        .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            /* add padding to account for vertical scrollbar */
            padding-right: 20px;
        }
    </style>

    <script>



        function ActualizarDiferencia() {

            $('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_lblDiferenciaKilos').text(
                "DIF de KG " +
                (parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga').val())
                - parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNetoPosicion').val()))
            );
        }



        function reasignarAutocomplete() {

            // al hacer una llamada a un updatepanel, los controles de jquery se pierden, y hay que volver a declararlos
            // http://stackoverflow.com/questions/256195/jquery-document-ready-and-updatepanels


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino").change(function () {
                //alert('asdasd');
            });

            //alert(jQuery.fn.jquery);

            //var j = jQuery.noConflict();

            // $(document).on('change', '#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino', function() {...});

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        // http://stackoverflow.com/questions/1678101/how-to-return-json-from-asp-net-asmx
                        //Your service code looks okay. Since you aren't showing how you're calling it, I'll bet that's 
                        //where your problem lies. One requirement for getting JSON out of ASMX "ScriptServices" is 
                        //    that you must call them with the correct content-type header and you 
                        //    must use a POST request. Scott Guthrie has a good post about the reasoning behind those requirements.
                        contentType: "application/json",
                        url: "WebServiceClientes.asmx/DestinosPorPuntoVenta",
                        dataType: "json",//                        datatype: "xml",
                        data: "{" +
                        "'term':'" + $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino").val() + "'," +
                        "'puntoventa':'" +
                          addslashes($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbPuntoVenta").val()) +
                        "', 'SC':'" +
                        "" // addslashes($("#ctl00_ContentPlaceHolder1_HFSC").val()) 

                        + "' }"

                        //data: {
                        //    puntoventa: addslashes($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_cmbPuntoVenta").val()),
                        //    SC: $("#ctl00_ContentPlaceHolder1_HFSC").val()
                        //}


                        ,
                        success: function (data) {
                            var arr = $.parseJSON(data.d)

                            if (!arr) {
                                var result = [
                                 {
                                     label: 'No se encontraron resultados',
                                     value: response.term
                                 }
                                ];
                                response(result);
                            }

                            if (!arr.length || arr.length == 0) {
                                var result = [
                                 {
                                     label: 'No se encontraron resultados',
                                     value: response.term
                                 }
                                ];
                                response(result);
                            }
                            else {
                                // normal response
                                response($.map(arr, function (item) {
                                    return {
                                        label: item.Descripcion,
                                        value: item.Descripcion,
                                        id: item.IdWilliamsDestino,
                                        // extra fields go here
                                        //address: item.CustomerAddress
                                    }
                                }));
                            }
                        }





                    });
                },
                minLength: 0,
                messages: { noResults: "", results: function () { } },
                select: function (event, ui) {
                    //$("#IdDestino").val(ui.item.id);
                    //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino").val(ui.item.Descripcion);
                    //event.preventDefault();
                }
            });



        }



























        function sumarTotalOtrasMerma() {

            return;

            var tot = parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosExtranosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosDanadosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPuntaSombreadaMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHectolitricoMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadCarbonMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPanzaBlancaMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPicadosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadVerdesMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuemadosMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTierraMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadZarandeoMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecadaMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatilMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNideraMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenidaMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentinMerma').val()) +
                        parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinalMerma').val())



            //alert(tot);


            $('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtMerma').val(tot);

            $('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoFinalTotalMenosMermas').val(
                    parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga').val())
                    - parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtHumedadTotal').val())
                    - parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtMerma').val())
                );



        }



        function jsRebajaRubro(rubroDescripcion, textboxResultado, textboxRebaja, textboxMerma, dropdownTipo) {

            //var $txttitular = $("#" + textbox.id + "")
            //var $select = $("#" + combo.id + "")



            //var myJSONString = JSON.stringify($("#ctl00_ContentPlaceHolder1_HFSC").val());
            //var myEscapedJSONString = myJSONString.escapeSpecialChars();

            //var aaa = addslashes($("#ctl00_ContentPlaceHolder1_HFSC").val())


            var dat = {
                SC: "",
                rubrodesc: rubroDescripcion,
                resultado: textboxResultado.val(),
                articulodesc: $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txt_AC_Articulo").val(),
                destinodesc: $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtDestino").val()
            }





            $.ajax({
                url: "WebServiceClientes.asmx/RebajaCalculo",
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //dataType: "xml",


                //data: "{'NombreCliente':'" +
                //       addslashes($txttitular.val()) +
                //     "', 'SC':'" + aaa + "' }",
                data: JSON.stringify(dat),





                //data: {
                //    NombreCliente: 'asdfasdf',
                //    SC:  'asdfsadfsa' // $("#HFSC").val()
                //},
                success: function (data) {

                    var rebaja = data.d;

                    //alert(x);


                    //callback(rebaja);
                    textboxRebaja.val(rebaja);
                    merma = Math.round(rebaja * Number(parseFloat($('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga').val())) / 100);

                    if (dropdownTipo.val() == 0) {
                        textboxMerma.val(merma);
                    }
                    else {
                        textboxMerma.val(0);
                    }

                    sumarTotalOtrasMerma();


                },
                error: function (xhr) {
                    // alert("Something seems Wrong");
                }
            });

        }


        $(function () {
            reasignarAutocomplete();





            $('#MenuPrincipal').hide();




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox26").on('input', function (e) {

                jsRebajaRubro("Materias Extrañas",
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox26"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosExtranosRebaja"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosExtranosMerma"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGranosExtranos")
                    );
            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosResultado").on('input', function (e) {

                jsRebajaRubro("Quebrados partidos",
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosResultado"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosRebaja"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosMerma"),
                                $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuebrados")
                    );

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox29").on('input', function (e) {

                jsRebajaRubro("Dañados",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox29"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosDanadosRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosDanadosMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDaniados")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoResultado").on('input', function (e) {

                jsRebajaRubro("Semilla de chamico",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaChamico")
                  );

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoResultado").on('input', function (e) {

                jsRebajaRubro("Revolcado en tierra",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaRevolcado")
                  );

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesResultado").on('input', function (e) {

                jsRebajaRubro("Olores objetables",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaObjetables")
                  );

            });






            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosResultado").on('input', function (e) {

                jsRebajaRubro("Granos amohosados",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaAmohosados")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtPuntaSombreada").on('input', function (e) {

                jsRebajaRubro("Punta sombreada",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtPuntaSombreada"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPuntaSombreadaRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPuntaSombreadaMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPuntaSombreada")
                  );

            });






            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox35").on('input', function (e) {

                jsRebajaRubro("Peso hectolítrico",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox35"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHectolitricoRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHectolitricoMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHectolitrico")
                  );

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox36").on('input', function (e) {

                jsRebajaRubro("Granos con carbón",
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox36"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadCarbonRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadCarbonMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaCarbon")
                  );

            });












            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox37").on('input', function (e) {

                jsRebajaRubro('Panza blanca',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox37"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPanzaBlancaRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPanzaBlancaMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPanzaBlanca")
                  );

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox38").on('input', function (e) {

                jsRebajaRubro('Picados',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox38"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPicadosRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPicadosMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPicados")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox41").on('input', function (e) {

                jsRebajaRubro('Granos verdes',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox41"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadVerdesRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadVerdesMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVerdes")
                  );

            });









            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox1").on('input', function (e) {

                jsRebajaRubro('Granos Quemados o de Avería',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox1"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuemadosRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuemadosMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuemados")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox2").on('input', function (e) {

                jsRebajaRubro('Tierra',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox2"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTierraRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTierraMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTierra")
                  );

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox4").on('input', function (e) {

                jsRebajaRubro('Mermas por Zarandeo',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_TextBox4"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadZarandeoRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadZarandeoMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaZarandeo")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadResultado").on('input', function (e) {

                jsRebajaRubro("Humedad",
                                   $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHumedad")
                  );

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionResultado").on('input', function (e) {

                jsRebajaRubro('Gastos de fumigación',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionResultado"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFumigacion")
                  );

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecada").on('input', function (e) {

                jsRebajaRubro('Gastos de Secada',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecada"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecadaRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecadaMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGastoDeSecada")
                  );

            });







            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatil").on('input', function (e) {

                jsRebajaRubro('Merma Volatil',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatil"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatilRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatilMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVolatil")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNidera").on('input', function (e) {

                jsRebajaRubro('Fondo Nidera',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNidera"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNideraRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNideraMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFondoNidera")
                  );

            });



            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenida").on('input', function (e) {

                jsRebajaRubro('Merma Convenida',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenida"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenidaRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenidaMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaConvenida")
                  );

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentin").on('input', function (e) {

                jsRebajaRubro('Tal Cual Vicentin',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentin"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentinRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentinMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTalCualVicentin")
                  );

            });






            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinal").on('input', function (e) {

                jsRebajaRubro('Descuento Final',
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinal"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinalRebaja"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinalMerma"),
                              $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDescuentoFinal")
                  );

            });





            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////










            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGranosExtranos").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosExtranosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGranosExtranos").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuebrados").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuebrados").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDaniados").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosDanadosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDaniados").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaChamico").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaChamico").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });







            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaRevolcado").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaRevolcado").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaObjetables").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaObjetables").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaAmohosados").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaAmohosados").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPuntaSombreada").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPuntaSombreadaMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPuntaSombreada").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });





            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHectolitrico").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHectolitricoMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHectolitrico").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });



            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaCarbon").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadCarbonMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaCarbon").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPanzaBlanca").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPanzaBlancaMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPanzaBlanca").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPicados").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPicadosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaPicados").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVerdes").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadVerdesMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVerdes").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuemados").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuemadosMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaQuemados").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTierra").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTierraMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTierra").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });



            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaZarandeo").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadZarandeoMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaZarandeo").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHumedad").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaHumedad").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });


            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFumigacion").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFumigacion").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGastoDeSecada").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecadaMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaGastoDeSecada").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVolatil").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatilMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaVolatil").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFondoNidera").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNideraMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaFondoNidera").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });



            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaConvenida").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenidaMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaConvenida").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTalCualVicentin").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentinMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaTalCualVicentin").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDescuentoFinal").on('input', function (e) {

                var textboxMerma = $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinalMerma")

                if ($("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_cmbTipoMermaDescuentoFinal").val() == 0) {
                    //textboxMerma.val(merma);
                    //textboxMerma.prop('disabled', false);
                }
                else {
                    textboxMerma.val(0);
                    //textboxMerma.prop('disabled', true);
                }

                sumarTotalOtrasMerma();

            });

            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////




            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosExtranosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuebradosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGranosDanadosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadChamicoMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadRevolcadoMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadObjetablesMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadAmohosadosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPuntaSombreadaMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHectolitricoMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadCarbonMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPanzaBlancaMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadPicadosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadVerdesMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadQuemadosMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTierraMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadZarandeoMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadHumedadMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastosFumigacionMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadGastoDeSecadaMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaVolatilMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadFondoNideraMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadMermaConvenidaMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });
            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadTalCualVicentinMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });
            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel4_txtCalidadDescuentoFinalMerma").on('input', function (e) {
                sumarTotalOtrasMerma();
            });

















            ActualizarDiferencia();

            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga").change(function (e) {
            //    ActualizarDiferencia();
            //});

            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNetoPosicion").change(function (e) {
            //    ActualizarDiferencia();
            //});

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtNetoDescarga").on('input', function (e) {
                ActualizarDiferencia();
            });

            $("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtNetoPosicion").on('input', function (e) {
                ActualizarDiferencia();
            });

            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtBrutoPosicion ").on('input', function (e) {
            //    ActualizarDiferencia();
            //});
            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTaraPosicion").on('input', function (e) {
            //    ActualizarDiferencia();
            //});
            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtBrutoDescarga").on('input', function (e) {
            //    ActualizarDiferencia();
            //});
            //$("#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel3_txtTaraDescarga").on('input', function (e) {
            //    ActualizarDiferencia();
            //});












            var prm = Sys.WebForms.PageRequestManager.getInstance();

            prm.add_endRequest(function () {
                // al hacer una llamada a un updatepanel, los controles de jquery se pierden, y hay que volver a declararlos
                // http://stackoverflow.com/questions/256195/jquery-document-ready-and-updatepanels

                reasignarAutocomplete();
                // re-bind your jQuery events here
            });





            function pageLoad() {
                ActualizarDiferencia();
            }















            $('#Lista').jqGrid({
                //url: ROOT + 'CotizacionWilliamsDestino/Cotizaciones/',
                url: 'HandlerReclamos.ashx',
                //postData: {},
                postData: {
                    'FechaInicial': function () { return $("#txtFechaDesde").val(); },
                    'FechaFinal': function () { return $("#txtFechaHasta").val(); },
                    'destino': function () { return $("txtDestino").val(); },
                    'puntovent': function () { return $("#cmbPuntoVenta").val(); },
                    'idcarta': qs["Id"]
                },
                datatype: 'json',
                mtype: 'POST',




                // CP	TURNO	SITUACION	MERC	TITULAR_CP	INTERMEDIARIO	RTE CIAL	CORREDOR	DESTINATARIO	DESTINO	ENTREGADOR	PROC	KILOS	OBSERVACION


                colNames: ['', 'IdReclamoComentario', 'IdReclamo', 'Empleado', 'Comentario', 'Comentario2'
                                , 'Fecha', 'ArchivoAdjunto'
                    , 'nrocarta'
                ],





                colModel: [
                    {
                        name: 'act', index: 'act', align: 'center', width: 60, editable: false, hidden: true, sortable: false, search: false
                    },

                    { name: 'IdReclamoComentario', index: 'IdReclamoComentario', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'IdReclamo', index: 'IdReclamo', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'Empleado', index: 'Empleado', align: 'left', width: 80, hidden: false },
                    { name: 'Comentario', index: 'Comentario', align: 'left', width: 200, hidden: true },
                    { name: 'Comentario', index: 'Comentario', align: 'left', width: 220, hidden: false },

                    { name: 'Fecha', index: 'Fecha', align: 'left', width: 100, editable: true, hidden: true, sortable: false },


                    { name: 'ArchivoAdjunto', index: 'ArchivoAdjunto', align: 'left', width: 100, editable: true, hidden: true, sortable: false },
            { name: 'ArchivoAdjunto', index: 'ArchivoAdjunto', align: 'left', width: 100, editable: true, hidden: true, sortable: false },










                ],

                gridComplete: function () {
                    //    var ids = jQuery("#Lista").jqGrid('getDataIDs');
                    //    for (var i = 0; i < ids.length; i++) {
                    //        var cl = ids[i];
                    //        var se = "<input style='height:22px;width:20px;' type='button' value='G' onclick=\"GrabarFila('" + cl + "'); \"  />";
                    //        jQuery("#Lista").jqGrid('setRowData', ids[i], { act: se });
                    //    }
                    //jQuery("#Lista").jqGrid('addRowData', Id, data, "last");
                    //AgregarItemVacio(grid)

                    scrollToLastRow($("#Lista"))

                },





                loadComplete: function () {
                    var grid = $("#Lista"),
                        ids = grid.getDataIDs();

                    for (var i = 0; i < ids.length; i++) {
                        grid.setRowData(ids[i], false, {
                            height: 60  //20 + (i * 2)
                        });
                    }


                    scrollToLastRow($("#Lista"))

                    scrollToLastRow($("#Lista"))
                    // grid.setGridHeight('auto');
                },


                subGridRowExpanded: function (subgrid_id, row_id) {
                    //var html = "<span>Some HTML text which corresponds the row with id=" +
                    //    row_id + "</span><br/>";

                    //var html = '<ul data-dtr-index="0" class="dtr-details"><li data-dtr-index="4" data-dt-row="0" data-dt-column="4"><span class="dtr-title"><a href="">Titular</a></span> <span class="dtr-data"><span>Martignone Adolfo Y Cia  S C A </span></span></li><li data-dtr-index="5" data-dt-row="0" data-dt-column="5"><span class="dtr-title">Intermed.</span> <span class="dtr-data"><span></span></span></li><li data-dtr-index="6" data-dt-row="0" data-dt-column="6"><span class="dtr-title">Remitente Comercial</span> <span class="dtr-data"><span>Granos Olavarria S A </span></span></li><li data-dtr-index="7" data-dt-row="0" data-dt-column="7"><span class="dtr-title"><a href="">Corredor</a></span> <span class="dtr-data"><span>Futuros Y Opciones Com S A </span></span></li><li data-dtr-index="8" data-dt-row="0" data-dt-column="8"><span class="dtr-title">Esp.</span> <span class="dtr-data"><span>Soja Sustentable Usa</span></span></li><li data-dtr-index="9" data-dt-row="0" data-dt-column="9"><span class="dtr-title"><a href="">Destino</a><img title="Orden:Asc" src="/WebResource.axd?d=olQ67zyJIM4n9M_oCjYGRrTv0D-PJFdyCfA8P30v3DAazZ2pPF9qhxbM3BGjwDU_sj9fOg-6w-QRXWlBrrBXHMoHlpC6GPd2JFlMFkPtMfvCFUjqHNl-emkH6wLPSw2q0&amp;t=636426523640000000" alt="Orden:Asc" align="absbottom"></span> <span class="dtr-data">FCA VICENTIN</span></li><li data-dtr-index="10" data-dt-row="0" data-dt-column="10"><span class="dtr-title">Destinat.</span> <span class="dtr-data"><span>Vicentin S A I C</span></span></li><li data-dtr-index="11" data-dt-row="0" data-dt-column="11"><span class="dtr-title">Analisis</span> <span class="dtr-data"><span>DÑ:12.00% HD:13.20%  </span></span></li><li data-dtr-index="12" data-dt-row="0" data-dt-column="12"><span class="dtr-title">Patente</span> <span class="dtr-data">ERT783</span></li><li data-dtr-index="13" data-dt-row="0" data-dt-column="13"><span class="dtr-title">Obs Pto</span> <span class="dtr-data">&nbsp;</span></li><li data-dtr-index="14" data-dt-row="0" data-dt-column="14"><span class="dtr-title">Procedencia</span> <span class="dtr-data"><span>Villa Lila</span></span></li><li data-dtr-index="15" data-dt-row="0" data-dt-column="15"><span class="dtr-title">Entreg</span> <span class="dtr-data"><span>Wil</span></span></li><li data-dtr-index="16" data-dt-row="0" data-dt-column="16"><span class="dtr-title">Entreg CP</span> <span class="dtr-data"><span></span></span></li></ul>'





                    var a = $("#Lista").jqGrid('getRowData', row_id);



                    //$("#" + subgrid_id).append(dataFromTheRow.infohtml);
                    //$("#" + subgrid_id).append(dataFromTheRow.Producto);



                    // value: "0:Autorizado; 1:Demorado; 2:Posición; 3:Descargado; 4:A Descargar; 5:Rechazado;6:Desviado;7:CP p/cambiar;8:Sin Cupo;9:Calado"

                    //alert(a.Situacion);

                    var situacionDesc = "";
                    switch (parseInt(a.Situacion)) {
                        case 0:
                            situacionDesc = "Autorizado";
                            break;
                        case 1:
                            situacionDesc = "Demorado";
                            break;
                        case 2:
                            situacionDesc = "Posición";
                            break;
                        case 3:
                            situacionDesc = "Descargado";
                            break;
                        case 4:
                            situacionDesc = "A Descargar";
                            break;
                        case 5:
                            situacionDesc = "Rechazado";
                            break;
                        case 6:
                            situacionDesc = "Desviado";
                            break;
                        case 7:
                            situacionDesc = "CP p/cambiar";
                            break;
                        case 8:
                            situacionDesc = "Sin Cupo";
                            break;
                        case 9:
                            situacionDesc = "Calado";
                            break;
                        default:
                            situacionDesc = "";

                    }




                    var html = "<span style='font-size: 14px'> " +
                        "<br/><b>Situación</b>      " + situacionDesc +
                        "<br/><b>Observaciones</b>            " + a.ObservacionesSituacion +
                        "<br/><b>Producto</b>       " + a.Producto +
                        "<br/><b>Titular</b>            " + a.TitularDesc +
                        "<br/><b>Intermediario</b>            " + a.IntermediarioDesc +
                        "<br/><b>R.Comercial</b>            " + a.RComercialDesc +
                        "<br/><b>Corredor</b>            " + a.CorredorDesc +
                        "<br/><b>Destinatario</b>            " + a.DestinatarioDesc +
                        "<br/><b>Destino</b>  " + a.DestinoDesc +
                        "<br/><b>Patente</b>  " + a.Patente +
                        "<br/><b>Neto</b>  " + a.NetoPto +
                        "<br/><b>Arribo</b>  " + a.FechaArribo +
                        "<br/><b>Descarga</b>  " + a.FechaDescarga +
                        "<br/><br/><a href=\"CartaDePorte.aspx?Id=" + a.IdCartaDePorte + "\"  target=\"_blank\" > ver carta </>" +
                        "<span/>";

                    $("#" + subgrid_id).append(html);


                },

                onSelectRow: function (rowId) {
                    //$("#Lista").jqGrid('toggleSubGridRow', rowId);
                },

                //onSelectRow: function (id) { 
                //    //dobleclic = true;
                //    EditarItem(id);
                //},

                //ondblClickRow: function (id) {
                //    //sacarDeEditMode();
                //    dobleclic = true;
                //    EditarItem(id);
                //},





                //onCellSelect: function (rowid, iCol, cellcontent, e) {
                //    var $this = $(this);
                //    var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
                //    lastSelectedId = rowid;
                //    lastSelectediCol = iCol;
                //    lastSelectediRow = iRow;
                //},
                //afterEditCell: function (id, name, val, iRow, iCol) {
                //    //if (name == 'Fecha') {
                //    //    jQuery("#" + iRow + "_Fecha", "#Lista").datepicker({ dateFormat: "dd/mm/yy" });
                //    //}
                //    var se = "<input style='height:22px;width:55px;' type='button' value='Grabar' onclick=\"GrabarFila('" + id + "');\"  />";
                //    jQuery("#Lista").jqGrid('setRowData', id, { act: se });
                //},
                //beforeSelectRow: function (rowid, e) {
                //var $this = $(this),
                //    $td = $(e.target).closest('td'),
                //    $tr = $td.closest('tr'),
                //    iRow = $tr[0].rowIndex,
                //    iCol = $.jgrid.getCellIndex($td);

                //if (typeof lastSelectediRow !== "undefined" && typeof lastSelectediCol !== "undefined" &&
                //        (iRow !== lastSelectediRow || iCol !== lastSelectediCol)) {
                //    $this.jqGrid('setGridParam', {cellEdit: true});
                //    $this.jqGrid('restoreCell', lastSelectediRow, lastSelectediCol, true);
                //    $this.jqGrid('setGridParam', {cellEdit: false});
                //    $(this.rows[lastSelectediRow].cells[lastSelectediCol])
                //        .removeClass("ui-state-highlight");
                //}
                //return true;
                //},



                rowNum: 100,
                //rowList: [10, 20, 50, 100, 500, 1000],
                sortname: 'Fecha',  //'FechaDescarga', //'NumeroCartaDePorte',
                sortorder: 'asc',
                viewrecords: true,

                shrinkToFit: false,

                width: 260, //$(window).width() - 4, // 310, //'auto',
                height: 320, //'auto', // '100%', //$(window).height() - 260, // '100%'

                altRows: false,
                footerrow: false,
                userDataOnFooter: true,
                //caption: '<b>Control de Descargas</b>',
                cellEdit: false, // si usas frozencolumns, estas obligado a sacar el cellEdit!!!
                cellsubmit: 'clientArray',
                dataUrl: "WebServiceClientes.asmx/EmpleadoEditGridData",



                //pager: $('#ListaPager'),
                //toppager: true,
                recordtext: "{2} cartas</span>",
                pgtext: "Pag. {0} de {1}",
                //subGrid: true,
                multiselect: false,
                multiselectWidth: 40,
                subGridWidth: 40,


                gridview: true
                , multiboxonly: true
                , multipleSearch: true




            });





            jQuery('#Lista').jqGrid('gridResize');

            jQuery("#Lista").jqGrid('bindKeys');

            jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
                { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
                {
                    //sopt: ["cn"]
                    //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
                    zIndex: 50,
                    width: 250, // $(window).width() - 4, 
                    closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false

                }
                // http://stackoverflow.com/questions/11228764/jqgrid-setting-zindex-for-alertmod
            );

            //jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
            //    { search: false, refresh: false, add: false, edit: false, del: false }, {}, {}, {}, {});



            //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
            //                                {
            //                                    caption: "", buttonicon: "ui-icon-plus", title: "Agregar",
            //                                    onClickButton: function () {
            //                                        AgregarItemVacio(jQuery("#Lista"));
            //                                    },
            //                                });
            //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
            //                                {
            //                                    caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
            //                                    onClickButton: function () {
            //                                        MarcarSeleccionadosParaEliminar(jQuery("#Lista"));
            //                                    },
            //                                });



            //jQuery("#Lista").filterToolbar({
            //    stringResult: true, searchOnEnter: true,
            //    defaultSearch: 'cn',
            //    enableClear: false
            //});



        });

        $(document).ready(function () {
            scrollToLastRow($("#Lista"))
        });

    </script>
</asp:Content>
