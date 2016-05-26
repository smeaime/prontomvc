<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Asiento.aspx.vb" Inherits="AsientoABM" Title="Asiento" %>

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

    <div style="border: thin solid #FFFFFF; width: 700px; margin-top: 5px;">
        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server">
            <ContentTemplate>
                <table style="padding: 0px; border: none #FFFFFF; width: 699px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="2" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                            font-size: large;" align="left" valign="top">
                            ASIENTO CONTABLE
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
                    <%--        <tr>
                <td class= "EncabezadoCell" style=" visibility: hidden;" colspan="4">
                </td>
                
          
        </tr>--%>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 10px;">
                            Número
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 10px;">
                            <asp:TextBox ID="txtNumeroReferencia" runat="server" CssClass="CssTextBox" Enabled="false" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px;" visible="false">
                            Fecha
                        </td>
                        <td class="EncabezadoCell" style="" visible="false">
                            <asp:TextBox ID="txtFecha" runat="server" Width="70px"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFecha">
                            </cc1:CalendarExtender>
                          <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtFecha">
                            </cc1:MaskedEditExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFecha"
                                ErrorMessage="* Ingrese fecha" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                ValidationGroup="Encabezado" Style="display: none" />
                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" Enabled="True"
                                TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            Concepto
                        </td>
                        <td class="EncabezadoCell" style="width: 220px;">
                            <asp:TextBox ID="txtConcepto" runat="server" TextMode="MultiLine" Width="180px" Height="52px"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px;">
                            &nbsp;
                        </td>
                        <td style="" class="EncabezadoCell">
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 53px;">
                            <asp:Label ID="Label1" runat="server" Text="Asiento de apertura de ejercicio" ForeColor="White"
                                Font-Size="Small" Visible="true"></asp:Label>
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 53px;">
                            <asp:CheckBox ID="chkAperturaEjercicio" runat="server" ForeColor="White" Text=""
                                TextAlign="right" Font-Size="Small" Visible="true" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px; height: 53px;">
                            <asp:Label ID="Label344" runat="server" Text="Asignar a presupuesto de obra" ForeColor="White"
                                Font-Size="Small" Visible="true"></asp:Label>
                        </td>
                        <td style="height: 53px" class="EncabezadoCell">
                            <asp:CheckBox ID="chkAsignarAPresupuesto" runat="server" ForeColor="White" Text=""
                                TextAlign="right" Font-Size="Small" Visible="true" />
                        </td>
                    </tr>
                </table>
                <br />
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
        </asp:Panel>
    </div>
    <br />
    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto; width: 702px">
                <asp:GridView ID="gvAsiento" runat="server" AutoGenerateColumns="False" BackColor="Transparent"
                    BorderColor="#4A3C8C" BorderWidth="1px" DataKeyNames="Id" GridLines="Both"
                    ShowFooter="true" Width="702px"  CellPadding="1" 
                    BorderStyle="Inset">
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Right" Font-Bold="True" Font-Size="Small"
                        ForeColor="#CC0000" BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="NumeroItem" HeaderText="" HeaderStyle-Width="20px" >
                            <HeaderStyle Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CodigoCuenta" HeaderText="Cuenta" />
                        <asp:TemplateField HeaderText="" SortExpression="Cuenta" HeaderStyle-HorizontalAlign="Left">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Wrap="True" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Cuenta" runat="server" Text='<%# Eval("DescripcionCuenta") %>'
                                    Width="100%" AutoPostBack="true" Enabled="true"  BorderStyle="None" Height="100%" />
                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender200" runat="server"
                                    CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                    ServicePath="WebServiceCuentas.asmx" TargetControlID="txtGrillaDetAC_Cuenta"
                                    UseContextKey="true" CompletionListElementID='ListDivisor' CompletionListCssClass="AutoCompleteScroll" />
                                   
                                    
                            </ItemTemplate>
                        </asp:TemplateField>
                                                  <asp:ButtonField ButtonType="Link" CommandName="BuscaCuentas" Text="..." ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado"
                            Visible="true">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="XX-Small" />
                            <HeaderStyle Width="20px" />
                        </asp:ButtonField>

                        <%-- <asp:TemplateField HeaderText="Importe" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Importe" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("Importe")  %>' Width="100" Enabled="false" />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla" runat="server" TargetControlID="txtGrillaDetAC_Importe"
                                    ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Obra">
                            <ItemTemplate>
                                <cc1:ComboBox RenderMode="Block" ID="cmbObra" runat="server" Width="100%" Height="100%" BorderStyle=None />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="60px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Debe" ItemStyle-HorizontalAlign="Right" FooterText="0.00">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Debe" runat="server" Style="text-align: right;" Text='<%# Eval("Debe")  %>'
                                    Width="100%" Enabled="true"  BorderStyle=None />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla" runat="server" TargetControlID="txtGrillaDetAC_Debe"
                                    ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="70px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Haber" ItemStyle-HorizontalAlign="Right" FooterText="0.00">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAC_Haber" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("Haber")  %>' Width="70" Enabled="true"  BorderStyle=None />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla43" runat="server"
                                    TargetControlID="txtGrillaDetAC_Haber" ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="70px" />
                        </asp:TemplateField>
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
                        <%--  <asp:BoundField DataField="costo unit_" HeaderText="" />
                        <asp:BoundField DataField="remito" HeaderText="" />
                        <asp:BoundField DataField="fecha rec" HeaderText="" />--%>
                        <%--                <asp:BoundField DataField="remito" HeaderText="" />--%>
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                    <%--<AlternatingRowStyle BackColor="#F7F7F7" />--%>
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
            <%--boton que dispara la actualizacion de la grilla--%>
            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%--boton de agregar--%>
            <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                Font-Underline="False" Enabled="true">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label2" runat="server" ForeColor="White" Text="Agregar item" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkAgregarCaja" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="X-Small" Height="20px" Width="122px" ValidationGroup="Encabezado"
                BorderStyle="None" Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 11px;"
                Font-Underline="False" Enabled="true" Visible="false">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Agregar caja" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button1" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" />
            <%--style="visibility:hidden;"/>--%>
            <%----------------------------------------------%>

            <script type="text/javascript">
                function checkFocusOnExtender() {
                    //check if focus is on productcode extender

                    var AutoCompleteExtender = $find('<%=AutoCompleteExtender20.ClientID%>');

                    if (AutoCompleteExtender == null) return false; //para que IE6 no explote por un null

                    if (AutoCompleteExtender._flyoutHasFocus)
                        return false;
                    else
                        return true;

                }
            </script>

            <asp:Panel ID="PanelAsiento" runat="server" Width="560px" CssClass="modalPopup">
                <asp:UpdatePanel ID="UpdatePanel16" runat="server">
                    <ContentTemplate>
                        <table style="margin: 0px; padding: 0px; color: #FFFFFF;">
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
                                    <asp:Button ID="butLimpiaCuentaGasto" runat="server"  Text="x" ToolTip="Resetear cuentas"
                                        ForeColor="#FF3300" Font-Bold="True" CausesValidation="False" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 16px;">
                                    Cuenta banco
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetAsientoCuentaBanco" runat="server" Width="400px" Enabled="False">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 16px;">
                                    Caja
                                </td>
                                <td style="height: 16px;">
                                    <asp:DropDownList ID="cmbDetAsientoCaja" runat="server" Width="400px" Enabled="False">
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
                                    Cotiz.
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetCotizacion" runat="server" Width="72px" AutoPostBack="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Importe moneda destino
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetImporteMonedaDestino" runat="server" Width="72px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 16px;">
                                    Debe
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetAsientoDebe" runat="server" Width="72px" AutoPostBack="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Haber
                                </td>
                                <td style="height: 16px;">
                                    <asp:TextBox ID="txtDetAsientoHaber" runat="server" Width="72px" AutoPostBack="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Registrar en analítico
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkDetAnalitico" runat="server" ForeColor="White" Text="" TextAlign="right"
                                        Visible="true" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 16px;">
                                    El pase es
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="optDetAsientoPase" runat="server">
                                        <asp:ListItem Text="IVA" Selected=True  Value="I" />
                                        <asp:ListItem Text="gravado"  Value="G" />
                                        <asp:ListItem Text="no gravado" Value="N"  />
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%; height: 16px;">
                                    Libro IVA
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="optDetAsientoLibro" runat="server">
                                        <asp:ListItem Text="NO enviar a los libros"  Selected=True Value="" />
                                        <asp:ListItem Text="Enviar a libro IVA ventas" Value="V" />
                                        <asp:ListItem Text="Enviar a libro compras" Value="C"/>
                                    </asp:RadioButtonList>
                                </td>
                                                                 
            
            
                                
                            </tr>
                            <tr>
                                <td>
                                    N° comprobante
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetNumeroComprobante" runat="server" Style="text-align: right;"   Width="70px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Fecha
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetAsientoFecha" runat="server" Style="text-align: right;"   Width="70px" />
                                    
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtDetAsientoFecha">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtDetAsientoFecha">
                            </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Porcent. IVA
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDetAsientoIVA"  Width="70px" runat="server" Style="text-align: right;" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 20%; height: 46px;">
                        </td>
                        <td align="right" style="height: 46px">
                            <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="" />
                            <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="but"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 0px" Font-Bold="False"
                                Height="25px" CausesValidation="False" Width="78px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderAsiento" runat="server" TargetControlID="Button1"
                PopupControlID="PanelAsiento" CancelControlID="btnCancelItem" DropShadow="False"
                BackgroundCssClass="modalBackground" />
            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="overflow: auto; width: 702px">
                <asp:GridView ID="gvAnticipos" runat="server" AutoGenerateColumns="False" BackColor="Transparent"
                    BorderColor="White" BorderWidth="1px" DataKeyNames="Id" GridLines="Horizontal"
                    ShowFooter="true" Width="702px" class="DetalleGrilla" CellPadding="3" BorderStyle="None"
                    EmptyDataText="Sin anticipos">
                    <FooterStyle CssClass="FooterStyle" HorizontalAlign="Right" Font-Bold="True" Font-Size="Small"
                        ForeColor="#CC0000" />
                    <Columns>
                        <asp:TemplateField HeaderText="Legajo/Empleado" SortExpression="Cuenta" HeaderStyle-HorizontalAlign="Left">
                            <ItemStyle Wrap="True" />
                            <ItemTemplate>
                                <cc1:ComboBox RenderMode="Block" ID="cmbEmpleado" runat="server" CssClass="CssCombo" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="left" Width="80" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Importe" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAnticipo_Importe" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("Importe")  %>' Width="100" Enabled="true" />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla1" runat="server" TargetControlID="txtGrillaDetAnticipo_Importe"
                                    ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cuotas" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAnticipo_Cuotas" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("CantidadCuotas")  %>' Width="40" Enabled="true" />
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderGrilla2" runat="server" TargetControlID="txtGrillaDetAnticipo_Cuotas"
                                    ValidChars=".1234567890">
                                </cc1:FilteredTextBoxExtender>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="40px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Detalle">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrillaDetAnticipo_Detalle" runat="server" Style="text-align: right;"
                                    Text='<%# Eval("Detalle")  %>' Width="200" Enabled="true" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" Width="200" />
                        </asp:TemplateField>
                        <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                            Visible="true" HeaderStyle-Font-Size="X-Small">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Deshacer" ItemStyle-HorizontalAlign="Center"
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
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </div>
            <asp:LinkButton ID="LinkButton3" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="X-Small" Width="122px" ValidationGroup="Encabezado" BorderStyle="None"
                Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 5px;" Font-Underline="False"
                Enabled="true">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label3" runat="server" ForeColor="White" Text="Agregar anticipo" Font-Underline="True"> </asp:Label>
            </asp:LinkButton>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%----fecha               ----%>
    <div style="border: none; width: 700px; margin-top: 5px; display: none">
        <table width="100%">
            <tr>
                <td valign="top">
                    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
                        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
                        Style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px; display: none;
                        visibility: hidden;" CausesValidation="False" Font-Underline="False">
                        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
                            text-decoration: none;" />
                        <asp:Label ID="Label29" runat="server" ForeColor="White" Text="Imprimir" Font-Underline="True"></asp:Label></asp:LinkButton>
                    <%-- revisar odsRemitosPendientes_Selecting para pasar parametros--%>
                    <asp:UpdatePanel ID="UpdatePanelGrillaConsulta" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="White" CausesValidation="False" Font-Size="X-Small" ValidationGroup="Encabezado"
                                Visible="true"> Agregar item ya recibido</asp:LinkButton>
                            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
                            <asp:Button ID="Button5" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                                display: none" />
                            <%--style="visibility:hidden;"/>--%>
                            <br />
                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button5"
                                PopupControlID="PopUpGrillaConsulta" OkControlID="btnAceptarPopupGrilla" CancelControlID="btnCancelarPopupGrilla"
                                DropShadow="False" BackgroundCssClass="modalBackground" />
                            <asp:Panel ID="PopUpGrillaConsulta" runat="server" Height="443px" Width="770px" CssClass="modalPopup">
                                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" onfocus="select();"
                                            AutoPostBack="true"></asp:TextBox>
                                        <div style="width: 99%; height: 85%; overflow: auto">
                                            <asp:GridView ID="GVGrillaConsulta" DataSourceID="ObjGrillaConsulta" runat="server"
                                                AutoGenerateColumns="False" Height="123px" Width="700px" CssClass="t1" DataKeyNames="IdRecepcion"
                                                AllowPaging="True" PageSize="8" EmptyDataText="No se encontraron recepciones">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Nro_recep_alm_" HeaderText="n°Recep" />
                                                    <asp:BoundField DataField="Comprobante" HeaderText="Comprobante" />
                                                    <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                                                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" />
                                                    <asp:BoundField DataField="Pedido" HeaderText="Pedido" />
                                                    <asp:BoundField DataField="RM" HeaderText="RM" />
                                                    <asp:BoundField DataField="Numero LA" HeaderText="LA n°" />
                                                    <asp:BoundField DataField="Nombre LA" HeaderText="Nombre" />
                                                    <asp:BoundField DataField="Realizo" HeaderText="Realizo" />
                                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" />
                                                </Columns>
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                            <asp:ObjectDataSource ID="ObjGrillaConsulta" runat="server" DeleteMethod="Delete"
                                                InsertMethod="SaveBlock" OldValuesParameterFormatString="original_{0}" SelectMethod="GetListTXDetallesPendientes"
                                                TypeName="Pronto.ERP.Bll.RecepcionManager">
                                                <SelectParameters>
                                                    <asp:Parameter Name="IdProveedor" DefaultValue="-1" />
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
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <br />
                                <asp:RadioButton ID="RadioButtonPendientes" runat="server" Text="Pendientes" Visible="False" />
                                <asp:RadioButton ID="RadioButtonAlaFirma" runat="server" Text="a la Firma" Visible="False" />
                                <asp:UpdateProgress ID="UpdateProgress111" runat="server">
                                    <ProgressTemplate>
                                        <img src="Imagenes/25-1.gif" alt="" />
                                        <asp:Label ID="Label34112" runat="server" Text="Actualizando datos..." ForeColor="White"
                                            Visible="False"></asp:Label>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <asp:Button ID="btnAceptarPopupGrilla" runat="server" Font-Size="Small" Text="Aceptar"
                                    CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                                <asp:Button ID="btnCancelarPopupGrilla" runat="server" Font-Size="Small" Text="Cancelar"
                                    CssClass="but" UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px"
                                    Font-Bold="False" Height="25px" CausesValidation="False" Width="78px" />
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
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="False" Font-Underline="True"
                                ForeColor="White" CausesValidation="False" Font-Size="X-Small" ValidationGroup="Encabezado"> Anticipar pago de pedido al proveedor</asp:LinkButton>
                            <asp:Button ID="Button6" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                                display: none" />
                            <br />
                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="Button6"
                                PopupControlID="PopupGrillaSolicitudes" OkControlID="Button3" CancelControlID="Button4"
                                DropShadow="False" BackgroundCssClass="modalBackground" />
                            <asp:Panel ID="PopupGrillaSolicitudes" runat="server" Height="480px" Width="720px"
                                CssClass="modalPopup" ForeColor="White">
                                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>
                                        <div style="width: 720px; height: 370px; overflow: auto" align="center">
                                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Aux0"
                                                DataSourceID="ObjectDataSource2" GridLines="Horizontal" AllowPaging="True" Height="80%"
                                                CssClass="t1" Width="700px" EmptyDataText="No se encontraron pedidos">
                                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="true" />
                                                    <asp:BoundField DataField="Aux0" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                                        Visible="False" />
                                                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                                                    <asp:BoundField DataField="Numero" HeaderText="Numero" />
                                                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                                                    <asp:BoundField DataField="Cump_" HeaderText="Cump" />
                                                    <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                                                    <asp:BoundField DataField="Importe Antic_" HeaderText="Importe Anticipado" />
                                                    <asp:BoundField DataField="Importe Certif_" HeaderText="Importe Certif." />
                                                    <asp:BoundField DataField="% Certif_" HeaderText="%Certif." />
                                                    <asp:BoundField DataField="Comparativa" HeaderText="Comparat." />
                                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id"
                                                        ItemStyle-Width="300">
                                                        <ItemTemplate>
                                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="Articulo" HeaderText="Artículo" ItemStyle-Wrap="False">
                                                                        <ItemStyle Font-Size="X-Small" Wrap="false" />
                                                                        <HeaderStyle Font-Size="X-Small" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad">
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
                                                    <asp:BoundField DataField="Total pedido" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                                                        DataFormatString="{0:F2}" HeaderStyle-Wrap="False">
                                                        <HeaderStyle Wrap="False" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Observaciones" SortExpression="Obs.">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("[Observaciones pedido]") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("[Observaciones pedido]") %>'></asp:Label>
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
                                                SelectMethod="GetListTXAnticiposAProveedor" TypeName="Pronto.ERP.Bll.PedidoManager"
                                                DeleteMethod="Delete" UpdateMethod="Save">
                                                <SelectParameters>
                                                    <%--            <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:Parameter Name="IdProveedor"  DefaultValue="-1" Type="Int32" />--%>
                                                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                                    <asp:ControlParameter ControlID="HFIdProveedor" Name="IdProveedor" PropertyName="Value"
                                                        Type="Int32" />
                                                    <%--            <asp:Parameter  Name="Parametros"  DefaultValue=""  />--%>
                                                    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
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
                                            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
                                            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.PedidoManager" DeleteMethod="Delete"
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
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                            <asp:HiddenField ID="HFIdObra" runat="server" />
                                            <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                                            <asp:HiddenField ID="HFIdProveedor" runat="server" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                </div>
                                <br />
                                Anticipo
                                <asp:TextBox runat="server" ID="txtGvAuxPorcentajeAnticipo" Width="60" Text="100" />%
                                <br />
                                <br />
                                <asp:UpdateProgress runat="server">
                                    <ProgressTemplate>
                                        <img src="Imagenes/25-1.gif" alt="" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
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
                </td>
                <td align="right" style="display: none;">
                    <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <table style="padding: 0px; border-style: none; border-width: thin; border-spacing: 0px;
                                color: #FFFFFF;" id="TablaResumen" cellpadding="2" cellspacing="3">
                                <tr>
                                    <td style="">
                                        SUBTOTAL
                                    </td>
                                    <td align="right" style="width: 100px;">
                                        <asp:Label ID="txtSubtotal" runat="server" ForeColor="White" Width="80px"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="visibility: hidden; display: none">
                                    <td style="">
                                        Bonif
                                        <asp:TextBox ID="txtTotBonif" runat="server" AutoPostBack="true" OnTextChanged="RecalcularTotalComprobante"
                                            Style="text-align: right;" Width="40px" Font-Size="X-Small"></asp:TextBox>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtTotBonif"
                                            ValidChars=".1234567890">
                                        </cc1:FilteredTextBoxExtender>
                                        <asp:Label ID="Label28" runat="server" ForeColor="White" Text="%"></asp:Label>
                                    </td>
                                    <td align="right" style="">
                                        <asp:Label ID="lblTotBonif" runat="server" ForeColor="White" Width="84px" Height="16px"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        IVA
                                    </td>
                                    <td align="right" style="">
                                        <asp:TextBox ID="txtIVA1" runat="server" AutoPostBack="true" Style="text-align: right;"
                                            Width="50px" Font-Size="X-Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="visibility: hidden; display: none;">
                                    <td style="">
                                        IVA 2
                                    </td>
                                    <td align="right" style="">
                                        <asp:TextBox ID="txtIVA2" runat="server" AutoPostBack="true" Style="text-align: right;"
                                            Width="50px" Font-Size="X-Small" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        Ajuste IVA
                                    </td>
                                    <td align="right" style="">
                                        <asp:TextBox ID="txtAjusteIVA" runat="server" AutoPostBack="true" Style="text-align: right;"
                                            autocomplete="off" Width="50px" Font-Size="X-Small"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="">
                                        TOTAL
                                    </td>
                                    <td align="right" style="">
                                        <asp:Label ID="txtTotal" runat="server" ForeColor="White" Width="80px" Style="margin-left: 6px"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div style="border: none; width: 700px; margin-top: 5px;">
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
                <%--ni los ComprobanteProveedors ni las comparativas se anulan--%>
                <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                    UseSubmitBehavior="False" Width="63px" Font-Bold="False" Style="" Font-Size="Small">
                </asp:Button>
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
                <asp:Panel ID="Panel3" runat="server" Height="87px" Visible="false">
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
                <asp:Panel ID="Panel5" runat="server" Height="182px" Style="vertical-align: middle;
                    text-align: center" Width="220px" BorderColor="Transparent" ForeColor="White"
                    CssClass="modalPopup">
                    <div align="center" style="height: 180px; width: 220px">
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
                        <asp:CheckBox runat="server" ID="chkLiberarCDPs" Text="Liberar CDPs incluidas" />
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
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
