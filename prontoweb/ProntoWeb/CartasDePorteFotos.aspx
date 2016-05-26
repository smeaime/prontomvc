<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CartasDePorteFotos.aspx.vb" Inherits="CartasDePorteImportador" Title="Importar Imágenes" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
        cellpadding="3" cellspacing="3">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF; font-size: medium; height: 37px;"
                align="left" valign="top">
                <asp:Label ID="lblTitulo" ForeColor="" runat="server" Text="Imágenes de Carta Porte"
                    Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>
            </td>
            <td style="height: 37px;" valign="top" align="right">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                        <asp:Label ID="lblUpdateProgress" ForeColor="" runat="server" Text="Actualizando datos ..."
                            Font-Size="Small"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <%--    http://forums.asp.net/p/1463338/3369115.aspx--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>
    <div style="color: White; font-size: medium">
        Podes subir las imágenes individualmente o en un .ZIP
        <br />
        Las imágenes se adjuntan dependiendo el nombre que les ponés
        <br />
        Poniendo "CP" o "TK" en el nombre se ubica como cartaporte o como ticket. Si no, se pone en el primer espacio libre
        <br />
        <br />
        Ejemplos:
        <br />
        "20034555.jpg"  será adjuntada a la carta 20034555 en el primer espacio libre
        <br />
        "20649977 34.gif" será adjuntada a la carta 20649977, vagón 34
        <br />
        "20649977 34 CP.gif" será adjuntada a la carta 20649977, vagón 34, como imagen de carta
        <br />
        "20649977 TK.gif" será adjuntada a la carta 20649977 como imagen de ticket
        <br />
    </div>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <div style="visibility: hidden">
                Formato del archivo
                <asp:DropDownList ID="cmbFormato" runat="server" Style="text-align: right; margin-left: 0px;"
                    Width="200px" Height="22px" AutoPostBack="true">
                    <asp:ListItem Text="Autodetectar formato" />
                    <asp:ListItem Text="Puerto ACA (formato CSV)" Value="PuertoACA" />
                    <asp:ListItem Text="BungeRamallo" Value="BungeRamallo" />
                    <asp:ListItem Text="CargillPlantaQuebracho" Value="CargillPlantaQuebracho" />
                    <asp:ListItem Text="CargillPtaAlvear" Value="CargillPtaAlvear" />
                    <asp:ListItem Text="LDCGralLagos" Value="LDCGralLagos" />
                    <asp:ListItem Text="LDCPlantaTimbues" Value="LDCPlantaTimbues" />
                    <asp:ListItem Text="MuellePampa" Value="MuellePampa" />
                    <asp:ListItem Text="NobleLima" Value="NobleLima" />
                    <asp:ListItem Text="Terminal6" Value="Terminal6" />
                    <asp:ListItem Text="ToepferPtoElTransito" Value="ToepferPtoElTransito" />
                    <asp:ListItem Text="Toepfer" Value="Toepfer" />
                    <asp:ListItem Text="VICENTIN" Value="VICENTIN" />
                    <asp:ListItem Text="VICENTIN (reemplazando columna Remitente con Titular)" Value="VICENTIN_ExcepcionTagRemitenteConflictivo"
                        visible="false" />
                    <asp:ListItem Text="Reyser" Value="Reyser" />
                    <asp:ListItem Text="ReyserAnalisis" Value="ReyserAnalisis" />
                    <%--            <asp:ListItem Text="AdmServPortuarios" Value="AdmServPortuarios" />--%>
                </asp:DropDownList>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Panel runat="server">
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


        <script>
            function AjaxUploadComplete() {
                var btnClick = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia");
                btnClick.click();
                __doPostBack();
            }
        </script>


        <asp:UpdatePanel ID="UpdatePanelAFU" runat="server" UpdateMode="Always">




            <%--     <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnVistaPrevia" EventName="Click" />
            </Triggers>--%>
            <ContentTemplate>



                <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete="AjaxUploadComplete"
                    CompleteBackColor="Lime" ErrorBackColor="Red" />
                <asp:Button runat="server" ID="btnClick" Text="Update grid" Style="display: none" />
                <asp:Button ID="btnVistaPrevia" runat="server" Text="cargar grilla" CssClass="Oculto" />

                <%--no es facil filtrar por extension--%>
                <%--puse AutoID por los problemas de Server Response Error. No se cuales son las consecuencias--%>
                <%--     
          OnClientUploadError="uploadError" OnClientUploadStarted="StartUpload" 

                --%>


                <br />
                <div style="color: White">Información </div>
                <hr />
                <asp:Label ID="txtLogErrores" runat="server" Width="1000px" Height="150px" Enabled="false"
                    Wrap="false" TextMode="MultiLine" ForeColor="White" />


            </ContentTemplate>
        </asp:UpdatePanel>


    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <br />
            <asp:Panel ID="PanelAnexo" runat="server" Visible="false">
                Anexo calidades
                <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload2" runat="server" OnClientUploadComplete="ClientUploadComplete2"
                    CompleteBackColor="Lime" ErrorBackColor="Red" />
                <asp:Button ID="btnVistaPrevia2" runat="server" Visible="true" Width="0px" />
            </asp:Panel>
            <script type="text/javascript" language="javascript">


                function ClientUploadComplete2(sender, args) {

                    var f = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia2");
                    //var f = $find('ctl00_ContentPlaceHolder1_btnVistaPrevia');

                    f.click();
                }

            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
    <hr />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <%--<asp:Button ID="Button1" runat="server" Text="Convertir en grilla" Visible="False" />
            <asp:Button ID="Button2" runat="server" Text="Validar" Visible="False" />
            <asp:Button ID="Button3" runat="server" Text="Grabar en la base" Visible="False" />
            <asp:Button ID="Button5" runat="server" Text="Copiar en el Portapapeles" Visible="False" />
            <asp:Button ID="Button4" runat="server" Text="Convertir grilla modificada en EXCEL y bajarlo"
                Visible="False" />
            <asp:CheckBox ID="chkFiltrarErrores" runat="server" Text="Ver solo filas con errores"
                Checked="true" Visible="False" />--%>
            <%--    Tolerancia:
            --%>
            <br />
            <br />
            <div style="color: ; visibility: hidden">
                Valores por default:
                <br />
                Punto de venta
                <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="44px"
                    Height="22px" AutoPostBack="True" ToolTip="Puntos de Venta" />
                <asp:TextBox ID="txtTolerancia" runat="server" Style="text-align: right; margin-left: 0px; margin-top: 10px;"
                    Text="0" Visible="false" Height="22px" Width="25px"></asp:TextBox>
                &nbsp; Fecha de Arribo
                <asp:TextBox ID="txtFechaArribo" runat="server" Width="72px" MaxLength="1" autocomplete="off"
                    TabIndex="2" AutoPostBack="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaArribo"
                    Enabled="True">
                </cc1:CalendarExtender>
                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaArribo" CultureAMPMPlaceholder=""
                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                    Enabled="True">
                </cc1:MaskedEditExtender>
                &nbsp; Destino
                <asp:TextBox ID="txtDestino" runat="server" autocomplete="off" AutoCompleteType="None"
                    Width="180px" TabIndex="20" AutoPostBack="false"></asp:TextBox><cc1:AutoCompleteExtender
                        ID="AutoCompleteExtender8" runat="server" CompletionSetCount="12" EnableCaching="true"
                        MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                        TargetControlID="txtDestino" UseContextKey="true" CompletionListCssClass="AutoCompleteScroll"
                        FirstRowSelected="true" CompletionInterval="100">
                    </cc1:AutoCompleteExtender>
                &nbsp; Destinatario
                <asp:TextBox ID="txtDestinatario" runat="server" autocomplete="off" Width="180px"
                    TabIndex="10"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                    TargetControlID="txtDestinatario" UseContextKey="True" FirstRowSelected="false"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
            </div>
            <br />
            <br />
            <asp:Label ID="lblVistaPrevia" runat="server" Text="VISTA PREVIA - primeros 6 items"
                ForeColor="" Font-Bold="True" Font-Size="Medium">
                                        
            </asp:Label>
            <br />
            <br />
            <%--
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>
            <%--columnas fijas--%>
            <div style="overflow: auto; width: 700px">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>


    <asp:Button ID="btnEmpezarImportacion" runat="server" Text="Comenzar importación"
        Visible="true" Height="50px" />

    <asp:HiddenField ID="HFSC" runat="server" />
    <%--
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>
    <%--
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server" Visible="False">
        <ContentTemplate>
            <%--boton de agregar--%>
            <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="False" ForeColor=""
                Font-Size="Small" Height="20px" Width="122px" ValidationGroup="Encabezado" BorderStyle="None"
                Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px; display: none"
                TabIndex="10" Font-Underline="False" Enabled="False">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none; text-decoration: none;" />
                <asp:Label ID="Label31" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button6" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;" />
            <%--style="visibility:hidden;"/>--%>
            <%----------------------------------------------%>
            <asp:Panel ID="PanelDetalle" runat="server" Height="347px" Width="636px" CssClass="modalPopup"
                Visible="False">
                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                <%--            style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
                --%>
                <%--cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
                --%>
                <table style="height: 97px; width: 632px">
                    <%----fecha               ----%>
                    <tr>
                        <td style="width: 100px">
                            <asp:Label ID="lblFechaNecesidad" runat="server" ForeColor="" Text="Fecha de Entrega"></asp:Label>
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
                        <td style="width: 100px; height: 16px;">Ir a proxima linea con errores
                            <asp:Label ID="Label2" runat="server" ForeColor="" Text="Observacion"></asp:Label>
                        </td>
                        <td style="height: 16px;">
                            <asp:TextBox ID="txtDetObservaciones" runat="server" Width="400px" Height="48px"
                                TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 46px;"></td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="Detalle" />
                            <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px" Font-Bold="False"
                                Height="25px" CausesValidation="False" Width="78px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="Button6"
                PopupControlID="PanelDetalle" CancelControlID="btnCancelItem" DropShadow="False"
                BackgroundCssClass="modalBackground" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
