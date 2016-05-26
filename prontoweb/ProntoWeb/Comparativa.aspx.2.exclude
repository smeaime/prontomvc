<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Comparativa.aspx.vb" Inherits="Comparativa"
    MasterPageFile="~/MasterPage.master" Title="Comparativa" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="border: thin solid #FFFFFF; width: 700px; margin-top: 5px;">
        <table style="padding: 0px; border: none #FFFFFF; width: 687px;  margin-right: 0px;"
            cellpadding="3" cellspacing="3">
            <tr>
                <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                    font-size: large;" align="left" height="38" valign="top">
                    COMPARATIVA
                </td>
                <td style="height: 37px;" valign="top" align="right">
                    <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="White"
                        BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                        Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                        Visible="False" Width="120px"></asp:Label>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 26px; width: 35px" />
                            <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                Visible="true"></asp:Label>
                            <%--            <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
--%>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td class="EncabezadoCell" style="width: 90px;">
                    <asp:Label ID="Label3" runat="server" Text="Número" ForeColor="White" Font-Size="Small"></asp:Label>
                </td>
                <td class="EncabezadoCell" style="width: 200px;">
                    <asp:TextBox ID="txtNumeroComparativa2" runat="server" Width="70px" Style="text-align: right;"
                        CssClass="CssTextBox" Enabled="False"></asp:TextBox>
                    <cc1:MaskedEditExtender ID="MaskedEditExtender8" runat="server" TargetControlID="txtNumeroComparativa2"
                        Mask="99999999" MaskType="Number" InputDirection="RightToLeft" AutoCompleteValue="0">
                    </cc1:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNumeroComparativa2"
                        ErrorMessage="* Ingrese el número del comprobante" Font-Size="Small" ForeColor="#FF3300"
                        Font-Bold="True" />
                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                        Enabled="True" TargetControlID="RequiredFieldValidator9" CssClass="CustomValidatorCalloutStyle" />
                </td>
                <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                <td class="EncabezadoCell" style="width: 90px;">
                    <asp:Label ID="Label17" runat="server" Text="Ingreso" ForeColor="White" Font-Size="Small"></asp:Label>
                </td>
                <td style="" class="EncabezadoCell">
                    <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="CssTextBox" MaxLength="1"
                        Style="margin-left: 0px"></asp:TextBox>&nbsp;&nbsp;
                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaIngreso">
                    </cc1:CalendarExtender>
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtFechaIngreso">
                    </cc1:MaskedEditExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtFechaIngreso"
                        ErrorMessage="* Ingrese la fecha de ingreso" Font-Size="Small" ForeColor="#FF3300"
                        Font-Bold="True" Style="display: none" ValidationGroup="Encabezado" />
                    <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" Enabled="True"
                        TargetControlID="RequiredFieldValidator5" CssClass="CustomValidatorCalloutStyle" />
                    &nbsp;
                </td>
                </td>
            </tr>
            <tr>
                <td class="EncabezadoCell" style="width: 90px;">
                    <asp:Label ID="Label15" runat="server" Text="Monto Previsto" ForeColor="White" Font-Size="Small"></asp:Label>
                </td>
                <td style="width: 200px" class="EncabezadoCell">
                    <asp:TextBox ID="TextBox8" runat="server" Width="70px" Style="margin-left: 0px; text-align: right;"></asp:TextBox>
                </td>
                <td class="EncabezadoCell" style="width: 90px;">
                    <asp:Label ID="Label18" runat="server" Text="Confeccionó" ForeColor="White" Font-Size="Small"
                        Width="50px" Style="margin-top: 0px; margin-bottom: 0px; margin-right: 0px;"
                        Height="16px"></asp:Label>
                </td>
                <td style="" class="EncabezadoCell">
                    <asp:DropDownList ID="cmbConfecciono" runat="server" Style="margin-left: 0px" CssClass="CssCombo" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cmbConfecciono"
                        ErrorMessage="Elija un usuario" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                        InitialValue="-1" Style="display: none" ValidationGroup="Encabezado" />
                    <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" Enabled="True"
                        TargetControlID="RequiredFieldValidator4" CssClass="CustomValidatorCalloutStyle" />
                </td>
            </tr>
            <tr>
                <td class="EncabezadoCell" style="width: 90px; height: 26px;">
                    <asp:Label ID="Label13" runat="server" Text="Monto para Compra" ForeColor="White"
                        Font-Size="Small"></asp:Label>
                </td>
                <td class="EncabezadoCell" style="width: 200px; height: 26px;">
                    <asp:TextBox ID="TextBox7" runat="server" Width="70px" Style="text-align: right;"></asp:TextBox>
                </td>
                <td class="EncabezadoCell" style="width: 90px; height: 26px;">
                    <asp:Label ID="Label4" runat="server" Font-Size="Small" ForeColor="White" Height="16px"
                        Text="Liberó" Width="50px"></asp:Label>
                </td>
                <td style="height: 26px;" class="EncabezadoCell">
                    <asp:DropDownList ID="cmbAprobo" runat="server" Style="margin-left: 0px; margin-top: 5px;"
                        Enabled="False" CssClass="CssCombo" />
                    <asp:LinkButton ID="btnAprobar" runat="server" Font-Bold="False" Font-Underline="True"
                        ForeColor="White" Font-Size="Small" Height="16px" Width="51px" Style="margin-left: 9px;
                        margin-top: 0px; margin-bottom: 0px" ValidationGroup="Encabezado">Liberar</asp:LinkButton>
                    <br />
                    <br />
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:LinkButton ID="LinkButton7" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="White" CausesValidation="False" Font-Size="Small" Height="20px" BorderStyle="None"
                    Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                    BorderWidth="5px" Width="127px">Más información</asp:LinkButton>
                <asp:Panel ID="Panel3" runat="server">
                    <table style="padding: 0px; border: none #FFFFFF; width: 687px; height: 86px; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" style="width: 90px;">
                                <asp:Label ID="Label12" runat="server" Font-Size="Small" ForeColor="White" Text="Observ."></asp:Label>
                            </td>
                            <td class="EncabezadoCell" colspan="3" style="width: 200px;">
                                <asp:TextBox ID="txtObservaciones" runat="server" Height="30px" TextMode="MultiLine"
                                    Width="416px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="display: none; visibility: hidden;">
                                <asp:Label ID="Label21" runat="server" Font-Size="Small" ForeColor="White" Text="Plazo de Entrega"></asp:Label>
                            </td>
                            <td class="EncabezadoCell" style="display: none; visibility: hidden;">
                                <asp:DropDownList ID="cmbPlazo" runat="server" CssClass="CssCombo" Enabled="False" />
                            </td>
                            <td class="EncabezadoCell" style="display: none; visibility: hidden;">
                                <asp:Label ID="Label22" runat="server" Font-Size="Small" ForeColor="White" Text="Validez"></asp:Label>
                            </td>
                            <td class="EncabezadoCell" style="display: none; visibility: hidden">
                                <asp:TextBox ID="txtValidezOferta" runat="server" Enabled="False" Width="110px"></asp:TextBox>
                            </td>
                        </tr>
                        <%--style="visibility:hidden;"/>--%>
                        <tr style="display: none; visibility: hidden;">
                            <td class="EncabezadoCell" style="width: 90px;">
                                <asp:Label ID="Label1" runat="server" Text="Obras" ForeColor="White" Font-Size="Small"></asp:Label>
                            </td>
                            <td class="EncabezadoCell" style="width: 200px">
                                <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="160px" Height="53px"
                                    Enabled="False"></asp:TextBox>
                            </td>
                            <td class="EncabezadoCell" style="width: 76px;">
                                &nbsp;
                            </td>
                            <td style="" class="EncabezadoCell">
                                &nbsp;
                            </td>
                        </tr>
                        <%--boton de agregar--%>
                        <%----------------------------------------------%>
                        <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
                    </table>
                </asp:Panel>
                <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    TargetControlID="Panel3" ExpandControlID="LinkButton7" CollapseControlID="LinkButton7"
                    CollapsedText="Más información" ExpandedText="Ocultar" TextLabelID="LinkButton7"
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
                Font-Underline="True" ForeColor="White" Height="16px" Width="63px" ValidationGroup="Encabezado"
                TabIndex="8" OnClientClick="BrowseFile()" CausesValidation="False" Visible="False"
                Style="margin-right: 0px">Adjuntar</asp:LinkButton>
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
    <%--//////////////////////////////////--%>
    <%--            <asp:BoundField DataField="Precio2" HeaderText="Precio2"  ItemStyle-HorizontalAlign="Right" dataformatstring="{0:c}">
                <HeaderStyle Width="60px" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
 
            <asp:BoundField DataField="Total2" HeaderText="Total2"  ItemStyle-HorizontalAlign="Right" dataformatstring="{0:c}">
                <HeaderStyle Width="60px" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            

            <asp:TemplateField HeaderText=" 2">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("M2") %>' Width="10"></asp:TextBox></EditItemTemplate><ItemTemplate>
                    <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# IIf(Eval("M2") Is DBNull.Value, False, Eval("M2")) %>' Enabled="True" />
                </ItemTemplate>
            </asp:TemplateField>--%>
    <%--boton que dispara la actualizacion de la grilla--%>
    <%--            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
--%>

    <script src="../JavaScript/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript">
        //    http: //stackoverflow.com/questions/2420513/how-to-align-columns-in-multiple-gridviews


        $(function() {
            var maxWidth = 0;
            $('TBODY TR:first TD.col1').each(function() {
                maxWidth = $(this).width > maxWidth ? $(this).width : maxWidth;
            });
            $('TBODY TR:first TD.col1').width(maxWidth);
        });

    </script>

    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div style="overflow: auto;">
                <asp:Label ID="Label23" runat="server" Text="Seleccionar:" ForeColor="White" Style="margin-left: 5px"
                    Visible="False"></asp:Label>
                <asp:GridView ID="gvCompara" runat="server" BackColor="White" BorderColor="#507CBB"
                    BorderStyle="Solid" BorderWidth="1px" CellPadding="3" Style="margin-bottom: 0px;
                    margin-top: 9px;" AutoGenerateColumns="false" DataKeyNames="Id,Cantidad" 
                    EmptyDataText="Elija presupuestos para mostrarlos en pantalla">
                    <FooterStyle BackColor="#507CBB" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                        <asp:BoundField DataField="Producto" HeaderText="Producto">
                            <ItemStyle Wrap="True" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Cant.">
                            <ItemStyle Wrap="True" />
                            <ItemTemplate>
                                <asp:Label ID="Cantidad" runat="server" Text='<%# Eval("Cantidad") & " " & Eval("Unidad") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 1" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo1" runat="server"  Font-Size="Smaller"   Text="Proveedor 1" />
                                <asp:CheckBox runat="server" ID="cboxhead1" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M1") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "1" , true , false) %>' />
                                <%--<asp:Label ID="TextBox3431" runat="server" 
                        Text='<%# Eval("Precio1") & " " & Eval("Total1") %>' />--%>
                                <%--<asp:Label ID="Label27" runat="server"
                        Text='<%# Eval("Total1") %>' /> --%>
                                <asp:Label ID="Label29" runat="server" Text='<%# Eval("Precio1") %>' />
                                <asp:CheckBox ID="check1" runat="server" Checked='<%# IIf(Eval("M1") Is DBNull.Value, False, Eval("M1")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 2" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo2" runat="server"  Font-Size="Smaller"  Text="Proveedor 2" />
                                <asp:CheckBox runat="server" ID="cboxhead2" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M2") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image2" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "2" , true , false) %>' />
                                <%--                    <asp:Label ID="TextBox3433" runat="server" 
                        Text='<%# Eval("Precio2") & " " & Eval("Total2") %>' />
--%>
                                <asp:Label ID="Label622" runat="server" Text='<%# Eval("Precio2") %>' />
                                <asp:CheckBox ID="check2" runat="server" Checked='<%# IIf(Eval("M2") Is DBNull.Value, False, Eval("M2")) %>'
                                    Enabled="True" OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 3" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo3" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead3" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox654" runat="server" Text='<%# Bind("M3") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image3" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "3" , true , false) %>' />
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Precio3") %>' />
                                <%--                    <asp:Label ID="TextBox24" runat="server" 
                        Text='<%# Eval("Precio3")  & " " & Eval("Total3") %>' />
--%>
                                <asp:CheckBox ID="check3" runat="server" Checked='<%# IIf(Eval("M3") Is DBNull.Value, False, Eval("M3")) %>'
                                    Enabled="True" OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 4" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo4" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead4" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("M4") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image4" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "4" , true , false) %>' />
                                <%-- <asp:Label ID="Label16"  runat="server" 
                        Text='<%# Eval("Precio4")  & " " & Eval("Total4") %>' />--%>
                                <asp:Label ID="Label19" runat="server" Text='<%# Eval("Precio4")  %>' />
                                <asp:CheckBox ID="check4" runat="server" Checked='<%# IIf(Eval("M4") Is DBNull.Value, False, Eval("M4")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 5" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo5" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead5" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("M5") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image5" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "5" , true , false) %>' />
                                <%--                    <asp:Label ID="Label16"  runat="server" 
                        Text='<%# Eval("Precio5")  & " " & Eval("Total5")%>' />
--%>
                                <asp:Label ID="Label20" runat="server" Text='<%# Eval("Precio5") %>' />
                                <asp:CheckBox ID="check5" runat="server" Checked='<%# IIf(Eval("M5") Is DBNull.Value, False, Eval("M5")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 6" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo6" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead6" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M6") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image6" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "6" , true , false) %>' />
                                <%--<asp:Label  runat="server" 
                        Text='<%# Eval("Precio6")  & " " & Eval("Total6") %>' />--%>
                                <asp:Label ID="Label16" runat="server" Text='<%# Eval("Precio6")  %>' />
                                <asp:CheckBox ID="check6" runat="server" Checked='<%# IIf(Eval("M6") Is DBNull.Value, False, Eval("M6")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 7" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo7" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead7" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M7") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image7" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "7" , true , false) %>' />
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Precio7") %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio7")  & " " & Eval("Total7") %>' />
--%>
                                <asp:CheckBox ID="check7" runat="server" Checked='<%# IIf(Eval("M7") Is DBNull.Value, False, Eval("M7")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 8" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo8" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead8" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M8") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image8" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "8" , true , false) %>' />
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Precio8")  %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio8")  & " " & Eval("Total8") %>' />
--%>
                                <asp:CheckBox ID="check8" runat="server" Checked='<%# IIf(Eval("M8") Is DBNull.Value, False, Eval("M8")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 9" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo9" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead9" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M9") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image9" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "9" , true , false) %>' />
                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("Precio9") %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio9")  & " " & Eval("Total9") %>' />
--%>
                                <asp:CheckBox ID="check9" runat="server" Checked='<%# IIf(Eval("M9") Is DBNull.Value, False, Eval("M9")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 10" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo10" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead10" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M10") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image10" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "10" , true , false) %>' />
                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("Precio10") %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio10")  & " " & Eval("Total10") %>' />
--%>
                                <asp:CheckBox ID="check10" runat="server" Checked='<%# IIf(Eval("M10") Is DBNull.Value, False, Eval("M10")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 11" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo11" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead11" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M11") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image11" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "11" , true , false) %>' />
                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("Precio11") %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio11")  & " " & Eval("Total11") %>' />
--%>
                                <asp:CheckBox ID="check11" runat="server" Checked='<%# IIf(Eval("M11") Is DBNull.Value, False, Eval("M11")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" 12" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="right">
                            <HeaderTemplate>
                                <asp:Label ID="Titulo12" runat="server"  Font-Size="Smaller"  Text="Proveedor 3" />
                                <asp:CheckBox runat="server" ID="cboxhead12" AutoPostBack="true" OnCheckedChanged="HeaderCheckedChanged" />
                            </HeaderTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M12") %>'></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image12" runat="server" ImageUrl="Imagenes/barato2.png" Visible='<%# IIf(Eval("ColumnaConMenorPrecioDeLaFila").ToString() = "12" , true , false) %>' />
                                <asp:Label ID="Label14" runat="server" Text='<%# Eval("Precio12")  %>' />
                                <%--                    <asp:Label ID="Label24"  runat="server" 
                        Text='<%# Eval("Precio12")  & " " & Eval("Total12") %>' />--%>
                                <asp:CheckBox ID="check12" runat="server" Checked='<%# IIf(Eval("M12") Is DBNull.Value, False, Eval("M12")) %>'
                                    Enabled="True"  OnCheckedChanged="ItemCheckedChanged" AutoPostBack="True" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="false" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:GridView ID="gvPie" runat="server" BackColor="White" BorderColor="#507CBB" BorderStyle="Solid"
                    BorderWidth="1px"  CellPadding="3" Style="margin-bottom: 9px; margin-top: 0px;"
                    AutoGenerateColumns="true" EmptyDataText="Elija presupuestos para mostrarlos en pantalla"
                    Height="105px" ShowHeader="False">
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
            <%--            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
--%>
        </Triggers>
    </asp:UpdatePanel>
    <asp:LinkButton ID="LinkImprimir" runat="server" Font-Bold="False" ForeColor="White"
        Font-Size="Small" Height="20px" Width="101px" ValidationGroup="Encabezado" BorderStyle="None"
        Style="vertical-align: bottom; margin-top: 5px; margin-bottom: 6px;" CausesValidation="False"
        TabIndex="10" Font-Underline="False">
        <img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" />
        <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Imprimir" Font-Underline="True"></asp:Label></asp:LinkButton>
    <asp:UpdatePanel ID="UpdatePanelGrillaConsulta" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" ForeColor="White"
                Font-Size="Small" Width="247px" ValidationGroup="Encabezado" BorderStyle="None"
                Style="vertical-align: bottom; margin-top: 4px; margin-bottom: 11px;" TabIndex="10"
                Font-Underline="False">
                <img src="../Imagenes/Agregar.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label31" runat="server" ForeColor="White" Text="Agregar presupuestos"
                    Font-Underline="True"> </asp:Label></asp:LinkButton>
            <br />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="LinkButton1"
                PopupControlID="PopUpGrillaConsulta" OkControlID="" CancelControlID="btnCancelarPopupGrilla"
                DropShadow="false" BackgroundCssClass="modalBackground" />
            <asp:Panel ID="PopUpGrillaConsulta" runat="server" Height="551px" Width="791px" CssClass="modalPopup"
                DefaultButton="btnHidden">
                <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!
                      style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
cuando copias y pegas esto, tambien tenes que copiar y pegar el codebehind del click del boton que 
llama explicitamente al show y update (acordate que este panel es condicional)
--%>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="buscar"
                            AutoPostBack="True"></asp:TextBox>
                        <asp:Button ID="btnHidden" runat="server" Style="display: none" UseSubmitBehavior="False"
                            Text="defaultbutton para que no cierre el panel" />
                        <asp:Panel runat="server" ScrollBars="Auto" Height="450" Width="100%">
                            <asp:GridView ID="GVGrillaConsulta" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdPresupuesto"
                                DataSourceID="ObjGrillaConsulta" GridLines="Horizontal" AllowPaging="True" Width="90%"
                                PageSize="5" Height="85%">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <%--                                                     <asp:CommandField    ShowSelectButton="true" />
                                <asp:BoundField DataField="IdPresupuesto" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" Visible="False" />
--%>
                                    <asp:TemplateField HeaderText="">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("ColumnaTilde") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IdPresupuesto" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                        SortExpression="Id" Visible="False" />
                                    <asp:TemplateField HeaderText="Número" SortExpression="Numero" ItemStyle-Width="50">
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
                                    <asp:TemplateField HeaderText="Detalle" InsertVisible="False" SortExpression="Id"
                                        ItemStyle-Width="300">
                                        <ItemTemplate>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <Columns>
                                                    <asp:BoundField DataField="Articulo" HeaderText="Producto" ItemStyle-Wrap="False">
                                                        <ItemStyle Font-Size="X-Small" Wrap="false" />
                                                        <%--Wrap!!!!!--%>
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
                                    <asp:BoundField DataField="ImporteTotal" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                                        DataFormatString="{0:F2}" HeaderStyle-Wrap="False">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
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
                        </asp:Panel>
                        <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
                        <%--    datasource de grilla principal--%>
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
    //////////////////////////////////////////////////////////////////////////--%>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:RadioButton ID="RadioButtonPendientes" runat="server" Text="Pendientes" Visible="False" />
                <asp:RadioButton ID="RadioButtonAlaFirma" runat="server" Text="a la Firma" Visible="False" />
                <asp:Button ID="btnAceptarPopupGrilla" runat="server" Font-Size="Small" Text="Aceptar"
                    CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
                <asp:Button ID="btnCancelarPopupGrilla" runat="server" Font-Size="Small" Text="Cancelar"
                    CssClass="but" UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px;
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
            <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" />
                    <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="False"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Button ID="btnSave" runat="server" CssClass="but" Font-Size="Small" OnClientClick="if (Page_ClientValidate()) this.disabled = true;"
                Style="margin-left: 0px; margin-top: 16px;" Text="Aceptar" UseSubmitBehavior="False"
                Width="100px" />
            <%--le saqué el CssClass="but"--%>
            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="but"
                Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Width="79px"
                Font-Bold="False" Style="margin-left: 30px" Height="23px" Font-Size="Small">
            </asp:Button>
            <%--ni los presupuestos ni las comparativas se anulan--%>
            <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                UseSubmitBehavior="False" Width="63px" Font-Bold="False" Style="margin-left: 0px;
                display: none" Height="23px" Font-Size="X-Small" TabIndex="13"></asp:Button>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
    <br />
    <%--Guarda con los parametros que le mete de prepo el ObjGrillaConsulta_Selecting--%>
    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
    <asp:UpdatePanel ID="UpdatePanelTotales" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table style="width: 196px; height: 59px; margin-left: 477px;" id="TablaResumen">
                <tr>
                    <td style="width: 184px; height: 26px;">
                        <asp:Label ID="Label32" runat="server" Text="SUBTOTAL" ForeColor="White" Visible="False"></asp:Label>
                    </td>
                    <td style="width: 200px; height: 26px;" align="right">
                        <asp:Label ID="txtSubtotal" runat="server" Width="80px" ForeColor="White" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 184px">
                        <asp:Label ID="Label35" runat="server" Text="TOTAL" ForeColor="White" Visible="False"></asp:Label>
                    </td>
                    <td style="width: 200px; height: 26px;" align="right">
                        <asp:Label ID="txtTotal" runat="server" Width="80px" ForeColor="White" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--  campos hidden --%>
    <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
    <%--    <ajaxToolkit:ConfirmButtonExtender ID="PreRedirectConfirmButtonExtender" runat="server">
    </ajaxToolkit:ConfirmButtonExtender>--%>
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
                                <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="Volver al listado" /><br />
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
    <asp:Panel ID="Panel2" runat="server" Height="119px" Width="221px" BorderColor="Transparent"
        CssClass="modalPopup" Style="vertical-align: middle; text-align: center; display: none"
        ForeColor="White">
        <div align="center">
            Ingrese usuario y password
            <br />
            <br />
            <asp:DropDownList ID="cmbLibero" runat="server" CssClass="CssCombo">
            </asp:DropDownList>
            &nbsp;
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                Width="177px"></asp:TextBox><br />
            <br />
            <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False" />
            <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />
        </div>
    </asp:Panel>
    <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="btnAprobar"
        PopupControlID="Panel2" BackgroundCssClass="modalBackground" OkControlID="btnOk"
        DropShadow="false">
    </cc1:ModalPopupExtender>
    <asp:UpdatePanel ID="UpdatePanelAnulacion" runat="server">
        <ContentTemplate>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel1" runat="server" Height="172px" Style="vertical-align: middle;
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAnularMotivo"
                        ErrorMessage="* Ingrese motivo" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                        ValidationGroup="Anulacion" Enabled="true" />
                    <br />
                    <asp:Button ID="btnAnularOk" runat="server" Text="Ok" Width="80px" ValidationGroup="Anulacion" />
                    <asp:Button ID="btnAnularCancel" runat="server" Text="Cancelar" Width="72px" />
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupAnular" runat="server" TargetControlID="Button7"
                PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="" DropShadow="false"
                CancelControlID="btnAnularCancel">
                <%-- OkControlID se lo saqué porque no estaba llamando al codigo del servidor--%>
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>

    <script type="text/javascript">

        function fnClickOK(sender, e) {
            __doPostBack(sender, e)
        }
    </script>

    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--  campos hidden --%>
    <asp:TextBox ID="TextBox1" runat="server" Width="48px" Enabled="False" Visible="False"
        Height="27px"></asp:TextBox>
</asp:Content>
