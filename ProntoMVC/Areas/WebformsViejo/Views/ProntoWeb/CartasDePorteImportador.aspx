<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CartasDePorteImportador.aspx.vb" Inherits="CartasDePorteImportador"
    Title="Importar Excel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div style="color: White">
    <br />
    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
        cellpadding="3" cellspacing="3">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                font-size: medium; height: 37px;" align="left" valign="top">
                <asp:Label ID="lblTitulo" ForeColor="" runat="server" Text="Importador de Excels (Pegatina)"
                    Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>
            </td>
            <td style="height: 37px;" valign="top" align="right">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                        <asp:Label ID="lblUpdateProgress" ForeColor="" runat="server" Text="Actualizando datos ..."
                            Font-Size="Small"></asp:Label></ProgressTemplate>
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
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <div style="">
                Formato del archivo
                <asp:DropDownList ID="cmbFormato" runat="server" Style="text-align: right; margin-left: 0px;"
                    Width="200px" Height="22px" AutoPostBack="true" Font-Names="Courier New, monospace"  >
                    <asp:ListItem Text="Autodetectar formato" />
                    <asp:ListItem Text="texto Puerto ACA (formato CSV)" Value="PuertoACA" />
                    <asp:ListItem Text="excel BungeRamallo" Value="BungeRamallo" />
                    <asp:ListItem Text="excel CargillPlantaQuebracho" Value="CargillPlantaQuebracho" />
                    <asp:ListItem Text="excel CargillPtaAlvear" Value="CargillPtaAlvear" />
                    <asp:ListItem Text="excel LDCGralLagos" Value="LDCGralLagos" />
                    <asp:ListItem Text="excel LDCPlantaTimbues" Value="LDCPlantaTimbues" />
                    <asp:ListItem Text="excel MuellePampa" Value="MuellePampa" />
                    <asp:ListItem Text="excel NobleLima" Value="NobleLima" />
                    <asp:ListItem Text="excel Ramallo" Value="BungeRamallo" />
                    <asp:ListItem Text="excel Renova" Value="Renova" />
                    <asp:ListItem Text="excel Terminal6" Value="Terminal6" />
                    <asp:ListItem Text="excel ToepferPtoElTransito" Value="ToepferPtoElTransito" />
                    <asp:ListItem Text="excel Toepfer" Value="Toepfer" />
                    <asp:ListItem Text="excel VICENTIN" Value="VICENTIN" />
                    <asp:ListItem Text="excel VICENTIN (reemplazando columna Remitente con Titular)" Value="VICENTIN_ExcepcionTagRemitenteConflictivo"                        visible="false" />
                    <asp:ListItem Text="texto Reyser (formato Cerealnet)" Value="Reyser" />
                    <asp:ListItem Text="texto ReyserAnalisis" Value="ReyserAnalisis" />
                    
                    
                    
                    
                    <asp:ListItem Text="texto Unidad6 Descargas..........(formato original..: PREFIJO-NROCARTA-etc)" Value="Unidad6PlayaPerez" />
                    <asp:ListItem Text="texto Unidad6 Posicion...........(formato PlayaPerez: CUITTIT-CUITCORR-etc)" Value="Unidad6" />
                    
                    
                    
                    <asp:ListItem Text="texto Unidad6Analisis" Value="Unidad6Analisis" />
                    <%--            <asp:ListItem Text="AdmServPortuarios" Value="AdmServPortuarios" />--%>
                </asp:DropDownList>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Panel runat="server">
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
            <div style="color: ;">
                Valores por default:
                <br />
                Punto de venta
                <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="44px"
                    Height="22px" AutoPostBack="True" ToolTip="Puntos de Venta" />
                <asp:TextBox ID="txtTolerancia" runat="server" Style="text-align: right; margin-left: 0px;
                    margin-top: 10px;" Text="0" Visible="false" Height="22px" Width="25px"></asp:TextBox>
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
            <div style="overflow: auto; width: 60%px">
                <asp:GridView ID="gvExcel" runat="server" AutoGenerateColumns="False" CellPadding="2"
                    CellSpacing="0" GridLines="Both" BorderStyle="none" BorderWidth="0" ForeColor=""
                    BorderColor="" Font-Size="Small" AllowPaging="True" PageSize="1" Height="80">
                    <%--                OnRowCancelingEdit="gvExcel_RowCancelingEdit" OnRowEditing="gvExcel_RowEditing"
                OnRowUpdating="gvExcel_RowUpdating" OnRowDeleting="gvExcel_RowDeleting" --%>
                    <%--                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    --%>
                    <RowStyle Wrap="true" />
                    <%-- ACA ESTA LO DEL WRAPPPPPPPPPPP!!!!!!!!!!!!!!!!!!!!!!!!!!!!11--%>
                    <%--                http://forums.asp.net/p/1546446/3781165.aspx
                COMO HACER PARA QUE EL TAMAÑO DE LAS CELDAS EN EDICION SEA EL MISMO QUE EN LECTURA--%>
                    <Columns>
                        <%--                    <asp:TemplateField HeaderText="" ShowHeader="False" Visible="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkPopupEditar" runat="server" CausesValidation="False" CommandName="EditPopup"
                                Visible="false" Text="Pop"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ir a" ShowHeader="False" ControlStyle-Width="30px"
                        Visible="False">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" NavigateUrl='<%#Eval("URLgenerada")%>'
                                Text="Ir a"></asp:HyperLink>
                        </ItemTemplate>
                        <ControlStyle Width="30px" />
                    </asp:TemplateField>--%>
                        <asp:CommandField ShowEditButton="true" UpdateText="Acepta" CancelText="Canc." ControlStyle-Width="50px"
                            Visible="False">
                            <ControlStyle Width="50px" />
                            <ItemStyle Width="30px" Wrap="true" />
                        </asp:CommandField>
                        <asp:BoundField DataField="Estado" HeaderText="Estado" Visible="false" />
                        <asp:CheckBoxField DataField="check1" Text="" HeaderText="" Visible="false" />
                        <asp:TemplateField HeaderText="Producto">
                            <ItemTemplate>
                                <asp:Label ID="lblName1" Text='<%#Eval("Producto")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName1" Text='<%#Eval("Producto")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" Width="90%" Height="90%" />
                            </EditItemTemplate>
                            <HeaderStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Titular" HeaderStyle-Width="80%">
                            <ItemTemplate>
                                <%--                            <asp:TextBox ID="txtName2" Text='<%#Eval("Titular")%>' runat="server"    Wrap="true"              Eval("IdTitular") Is DBNull.Value/>--%>
                                <asp:Label ID="lblName2" runat="server" Text='<%#Eval("Titular")%>' BackColor='<%# ColorCode_CMBRET_SL(Container.DataItem,Eval("IdTitular"))%>'>
                            <%--http://aspadvice.com/forums/thread/25659.aspx--%>
                                </asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName2" Text='<%#Eval("Titular")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" Width="90%" Height="90%" />
                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                                    EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                    ServicePath="WebServiceClientesCUIT.asmx" TargetControlID="txtName2" UseContextKey="true" />
                            </EditItemTemplate>
                            <HeaderStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Intermediario" HeaderStyle-Width="80%">
                            <ItemTemplate>
                                <asp:Label ID="lblName3" Text='<%#Eval("Intermediario")%>' runat="server" Wrap="true"
                                    BackColor='<%# ColorCode_CMBRET_SL(Container.DataItem,Eval("IdIntermediario"))%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName3" Text='<%#Eval("Intermediario")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" Width="90%" Height="90%" />
                            </EditItemTemplate>
                            <HeaderStyle Height="80%" Width="80%" />
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="R.Comercial" HeaderStyle-Width="80%">
                            <ItemTemplate>
                                <asp:Label ID="lblName4" Text='<%#Eval("RComercial")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName4" Text='<%#Eval("RComercial")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" BackColor='<%# ColorCode_CMBRET_SL(Container.DataItem,Eval("IdRComercial"))%>' />
                            </EditItemTemplate>
                            <HeaderStyle Height="80%" Width="80%" />
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Corredor" HeaderStyle-Width="80%">
                            <ItemTemplate>
                                <asp:Label ID="lblName5" Text='<%#Eval("Corredor")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" BackColor='<%# ColorCode_CMBRET_SL(Container.DataItem,Eval("IdCorredor"))%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName5" Text='<%#Eval("Corredor")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </EditItemTemplate>
                            <HeaderStyle Height="80%" Width="80%" />
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Destinatario">
                            <ItemTemplate>
                                <asp:Label ID="txComprador" Text='<%#Eval("Comprador")%>' runat="server" Wrap="true"
                                    BackColor='<%# ColorCode_CMBRET_SL(Container.DataItem,Eval("IdDestinatario"))%>' />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Procedencia">
                            <ItemTemplate>
                                <asp:Label ID="lblName6" Text='<%#Eval("Procedencia")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName6" Text='<%#Eval("Procedencia")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </EditItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Carta Porte">
                            <ItemTemplate>
                                <asp:Label ID="lblName7" Text='<%#Eval("NumeroCDP")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName7" Text='<%#Eval("NumeroCDP")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </EditItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patente">
                            <ItemTemplate>
                                <asp:Label ID="lblName8" Text='<%#Eval("Patente")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName8" Text='<%#Eval("Patente")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </EditItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acoplado">
                            <ItemTemplate>
                                <asp:Label ID="lblName9" Text='<%#Eval("Acoplado")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName9" Text='<%#Eval("Acoplado")%>' runat="server" Wrap="true" />
                            </EditItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Neto proc">
                            <ItemTemplate>
                                <asp:Label ID="txtName10" Text='<%#Eval("NetoProc")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Calidad">
                            <ItemTemplate>
                                <asp:Label ID="txtName11" Text='<%#Eval("Calidad")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Subcontratista 1">
                            <ItemTemplate>
                                <asp:Label ID="txtSub1" Text='<%#Eval("Subcontratista1")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Subcontratista 2">
                            <ItemTemplate>
                                <asp:Label ID="txtSub2" Text='<%#Eval("Subcontratista2")%>' runat="server" Wrap="true"
                                    TextMode="MultiLine" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Destino">
                            <ItemTemplate>
                                <asp:Label ID="txtDestino" Text='<%#Eval("Destino")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bruto Pto">
                            <ItemTemplate>
                                <asp:Label ID="txtName12" Text='<%#Eval("column12")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tara pto">
                            <ItemTemplate>
                                <asp:Label ID="txtName13" Text='<%#Eval("column13")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Neto pto">
                            <ItemTemplate>
                                <asp:Label ID="txtName14" Text='<%#Eval("column14")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Humedad">
                            <ItemTemplate>
                                <asp:Label ID="txtName15" Text='<%#Eval("column15")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Merma por humedad">
                            <ItemTemplate>
                                <asp:Label ID="txtName16" Text='<%#Eval("column16")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Otras Mermas">
                            <ItemTemplate>
                                <asp:Label ID="txtNameAux5" Text='<%#Eval("Auxiliar5")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Neto Final">
                            <ItemTemplate>
                                <asp:Label ID="txtName17" Text='<%#Eval("column17")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="F. de carga">
                            <ItemTemplate>
                                <asp:Label ID="txtName18" Text='<%#Eval("column18")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fecha vto.">
                            <ItemTemplate>
                                <asp:Label ID="txtName19" Text='<%#Eval("column19")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="F. de descarga">
                            <ItemTemplate>
                                <asp:Label ID="txtFechaDescarga" Text='<%#Eval("FechaDescarga")%>' runat="server"
                                    Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="C.E.E">
                            <ItemTemplate>
                                <asp:Label ID="txtName20" Text='<%#Eval("column20")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Transportista">
                            <ItemTemplate>
                                <asp:Label ID="txtName21" Text='<%#Eval("column21")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cuit">
                            <ItemTemplate>
                                <asp:Label ID="txtName22" Text='<%#Eval("column22")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Chofer">
                            <ItemTemplate>
                                <asp:Label ID="txtName23" Text='<%#Eval("column23")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cuit">
                            <ItemTemplate>
                                <asp:Label ID="txtName24" Text='<%#Eval("column24")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Observaciones">
                            <ItemTemplate>
                                <asp:Label ID="txtName25" Text='<%#Eval("column25")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CTG">
                            <ItemTemplate>
                                <asp:Label ID="txtCTG" Text='<%#Eval("CTG")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Km">
                            <ItemTemplate>
                                <asp:Label ID="txtKmARecorrer" Text='<%#Eval("KmARecorrer")%>' runat="server" Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tarifa">
                            <ItemTemplate>
                                <asp:Label ID="txtTarifaTransportista" Text='<%#Eval("TarifaTransportista")%>' runat="server"
                                    Wrap="true" />
                            </ItemTemplate>
                            <ItemStyle BorderStyle="Solid" BorderWidth="1px" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle Wrap="True" />
                    <%--//////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////--%>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" Height="55" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="false" ForeColor="#F7F7F7" Font-Size="x-Small" />
                    <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <AlternatingRowStyle BackColor="#F7F7F7" Height="55" />
                </asp:GridView>
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
    <br />
    <asp:Button ID="btnEmpezarImportacion" runat="server" Text="Comenzar importación"
        Visible="true" Height="50px" />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="panelEquivalencias" runat="server" DefaultButton="Button8">
                <%--http://forums.asp.net/t/985791.aspx--%>
                <div style="height: 70px;">
                    <br />
                    <br />
                    <asp:Label ID="lblUbicacion" Text="Buscar equivalencia " runat="server" ForeColor="" /><br />
                    <asp:Label ID="lblPalabraNueva" runat="server" Font-Size="Large" Font-Bold="True"
                        ForeColor="" Height="30" />
                    <br />
                </div>
                <asp:TextBox ID="txtBuscarCliente" runat="server" autocomplete="off" Width="300px"
                    TabIndex="8" />
                <%--http://forums.asp.net/t/985791.aspx--%>
                <script language="javascript">
                    //pones onkeypress="Detect()" en el boton
                    function Detect() {

                        if (window.event.keyCode == 13) {
                            //alert('Enter is click');

                            //__doPostBack('Button8', 'OnClick');

                            var f = document.getElementById("ctl00_ContentPlaceHolder1_Button8");
                            f.click();
                            //                        return false;

                        }

                    } 

                </script>
                <cc1:AutoCompleteExtender ID="acClientes" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceClientesCUIT.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acVendedores" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceVendedores.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acArticulos" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceArticulos.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acLocalidades" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceLocalidades.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acDestinos" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acTransportistas" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceTransportistas.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acChoferes" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceChoferes.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <cc1:AutoCompleteExtender ID="acCalidades" runat="server" CompletionSetCount="12"
                    MinimumPrefixLength="1" ServiceMethod="GetCompletionList" ServicePath="WebServiceCalidades.asmx"
                    TargetControlID="txtBuscarCliente" UseContextKey="True" FirstRowSelected="True"
                    CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters="" Enabled="True"
                    CompletionInterval="100">
                </cc1:AutoCompleteExtender>
                <asp:Button ID="Button7" runat="server" Text="<<" Visible="false" />
                <asp:Button ID="Button8" runat="server" Text=">>" Visible="true" TabIndex="8" />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                        <asp:Label ID="lblUpdateProgress2" ForeColor="" runat="server" Text="Actualizando datos ..."
                            Font-Size="Small"></asp:Label></ProgressTemplate>
                </asp:UpdateProgress>
                <asp:GridView ID="gvClientes" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    BackColor="" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                    DataKeyNames="Id" DataSourceID="ObjectDataSource1" GridLines="Horizontal" EnableSortingAndPagingCallbacks="True"
                    PageSize="20" Visible="false">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                            SortExpression="Id" />
                        <asp:BoundField DataField="Razon Social" HeaderText="RazonSocial" SortExpression="Razon Social">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Localidad" HeaderText="Localidad" SortExpression="Localidad">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Provincia" HeaderText="Provincia" SortExpression="Provincia">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ClienteManager">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:HiddenField ID="HFSC" runat="server" />
                <br />
                <br />
                <br />
                <br />
                <br />
                <asp:TextBox ID="txtLogErrores" runat="server" Width="700px" Height="150px" Enabled="false"
                    Wrap="false" TextMode="MultiLine"></asp:TextBox>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
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
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label31" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True"> </asp:Label></asp:LinkButton>
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
                        <td style="width: 100px; height: 16px;">
                            Ir a proxima linea con errores
                            <asp:Label ID="Label2" runat="server" ForeColor="" Text="Observacion"></asp:Label>
                        </td>
                        <td style="height: 16px;">
                            <asp:TextBox ID="txtDetObservaciones" runat="server" Width="400px" Height="48px"
                                TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 46px;">
                        </td>
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
    </div>
</asp:Content>
