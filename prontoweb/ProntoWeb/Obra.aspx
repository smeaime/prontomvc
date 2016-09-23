<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Obra.aspx.vb" Inherits="Obra" Title="Untitled Page" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div 
        class="EncabezadoComprobante">
        <%--                        http://forums.asp.net/t/1040191.aspx?PageIndex=2 el temita del scroll en el autocomplete
        --%>
        <%--
                            CompletionListCssClass="list" 
	CompletionListItemCssClass="listitem" 
	CompletionListHighlightedItemCssClass="hoverlistitem">--%>
        <asp:updatepanel id="UpdatePanelEncabezado" runat="server">
            <contenttemplate>
                <table style="padding: 0px; border: none; width: 700px; height: 62px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3"  class="EncabezadoCell" >
                    <tr>
                        <td colspan="3" style="border: thin none;  font-weight: bold; font-size: medium; height: 37px;"
                            align="left" valign="top">
                            <asp:Label ID="lblTitulo" ForeColor="" runat="server" Text="OBRA"
                                Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>
                        </td>
                        <td style="height: 37px;" valign="top" align="right">
                            <asp:Label ID="lblAnulado" runat="server" BackColor="#CC3300" BorderColor="" BorderStyle="Solid"
                                BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="" Style="text-align: center;
                                margin-left: 0px; vertical-align: top" Text=" ANULADO " Visible="False" Width="120px"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                                    <asp:Label ID="lblUpdateProgress" ForeColor="" runat="server" Text="Actualizando datos ..."
                                        Font-Size="Small"></asp:Label></ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">
                            Obra
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 18px;">
                            <asp:TextBox ID="txtNumeroObra" runat="server" Width="56px" Enabled="False"
                                TabIndex="1" Style="margin-right: 33px"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px; height: 18px;">
                            <asp:Label ID="Label1" runat="server" Text="Fecha" ForeColor="" Font-Size="Small"></asp:Label>
                        </td>
                        <td class="EncabezadoCell" style="height: 18px">
                            <asp:TextBox ID="txtFechaObra" runat="server" Width="72px" MaxLength="1"
                                TabIndex="2"></asp:TextBox>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaObra">
                            </cc1:CalendarExtender>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                                DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                TargetControlID="txtFechaObra">
                            </cc1:MaskedEditExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 30px;">
                            Tipo de obra
                        </td>
                        <td class="EncabezadoCell" style="width: 220px; height: 30px;" >
                            <asp:DropDownList ID="cmbObra" runat="server" CssClass="CssCombo" TabIndex="3" ValidationGroup="Encabezado"
                                Height="19px" >
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cmbObra"
                                ErrorMessage="Elija una Obra" Font-Bold="True" Font-Size="Small" ForeColor="#FF3300"
                                InitialValue="-1" Style="display: none" ValidationGroup="Encabezado" />
                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" Enabled="True"
                                TargetControlID="RequiredFieldValidator3" CssClass="CustomValidatorCalloutStyle" />
                            &nbsp;
                        </td>

                        <td>
                        fecha alta, fechentrega, fechafin
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 30px;">
                            Descripcion
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
                        <td class="EncabezadoCell" style="height: 30px; width: 90px;">
                            Observaciones
                        </td>
                        <td style="height: 30px">
                        
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            Cliente
                        </td>
                        <td class="EncabezadoCell" style="width: 220px">
                            <asp:CheckBox ID="chkConfirmadoDesdeWeb" runat="server" ForeColor="" Text="" Font-Size="Small"
                                Visible="False" Width="179px" Height="16px" />
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            
                        </td>
                        <td class="EncabezadoCell">
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 100px;">
                            Unidad operativa
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Width="" TabIndex="11"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px">
                            Grupo obra
                        </td>
                        <td class="EncabezadoCell">
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtLibero" runat="server" Enabled="False" Style="margin-left: 0px"
                                        CssClass="CssTextBox" TabIndex="6"></asp:TextBox>
                                    <asp:LinkButton ID="btnLiberar" runat="server" Font-Bold="False" Font-Size="Small"
                                        Font-Underline="True" ForeColor="" Height="16px" Width="46px" ValidationGroup="Encabezado"
                                        TabIndex="6" Style="margin-left: 7px">Liberar</asp:LinkButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="">
                            Jefe reg.
                                
                        </td>
                        <td class="EncabezadoCell">
                            <asp:TextBox ID="txtJefe" runat="server" TextMode="MultiLine" Height="35px"
                                TabIndex="10"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="">
                            Jefe
                        </td>
                        <td class="EncabezadoCell" style="">
                            <asp:DropDownList ID="cmbEmpleado" runat="server" CssClass="CssCombo" TabIndex="5"
                                AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                   <tr>
                        <td class="EncabezadoCell" style="">
                            Estado obra
                                
                        </td>
                        <td class="EncabezadoCell">
                            
                        </td>
                        <td class="EncabezadoCell" style="">
                            Jerarqu�a contable
                        </td>
                        <td class="EncabezadoCell" style="">
                            
                        </td>
                    </tr>
                </table>
            </contenttemplate>
        </asp:updatepanel>
        <asp:updatepanel id="UpdatePanel2" runat="server">
            <contenttemplate>
                <asp:LinkButton ID="LinkButton7" runat="server" Font-Bold="False" Font-Underline="True"
                    ForeColor="" CausesValidation="False" Font-Size="X-Small" Height="20px" BorderStyle="None"
                    Style="margin-right: 0px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px;"
                    BorderWidth="5px" Width="127px" TabIndex="7" visible=true>m�s...</asp:LinkButton>
                <asp:Panel ID="Panel3" runat="server">
                    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 86px; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" colspan="4" valign="middle">
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <%----------------------------------------------%>
                        <%--Guarda! le puse display:none a trav�s del codebehind para verlo en dise�o!--%>
                    </table>
                </asp:Panel>
                <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
                    TargetControlID="Panel3" ExpandControlID="LinkButton7" CollapseControlID="LinkButton7"
                    CollapsedText="m�s..." ExpandedText="ocultar" TextLabelID="LinkButton7" Collapsed="True">
                </ajaxToolkit:CollapsiblePanelExtender>
            </contenttemplate>
        </asp:updatepanel>
        <br />
        <asp:panel id="panelAdjunto" runat="server">
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
            <img src="../Imagenes/GmailAdjunto2Negro.png" alt="" style="border-style: none; border-color: inherit;
                border-width: medium; vertical-align: middle; text-decoration: none; margin-left: 5px;" />
            <asp:linkbutton id="lnkAdjuntar" runat="server" font-bold="False" font-size="Small"
                font-underline="True" forecolor="" height="16px" width="63px" validationgroup="Encabezado"
                tabindex="8" onclientclick="BrowseFile()" causesvalidation="False" visible="False"
                style="margin-right: 0px">Adjuntar</asp:linkbutton>
            <asp:button id="btnAdjuntoSubir" runat="server" font-bold="False" height="19px" style="margin-left: 0px;
                margin-right: 23px; text-align: left;" text="Adjuntar" width="58px" cssclass="button-link"
                causesvalidation="False" />
            <asp:linkbutton id="lnkAdjunto1" runat="server" forecolor="" visible="False">
            </asp:linkbutton>
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
            <asp:fileupload id="FileUpLoad2" runat="server" width="402px" height="22px" cssclass="button-link"
                font-underline="False" />
            <%--style="visibility:hidden"--%>
            <asp:linkbutton id="lnkBorrarAdjunto" runat="server" forecolor="">borrar</asp:linkbutton>
            <br />
            <br />
        </asp:panel>
    </div>
    <asp:updatepanel id="UpdatePanelGrilla" runat="server" updatemode="Conditional">
        <contenttemplate>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor=""
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                    GridLines="Horizontal" Width="702px" Style="margin-bottom: 9px; margin-top: 0px;"
                    CellPadding="3" TabIndex="8">
                    <Columns>
                        <asp:BoundField DataField="NumeroItem" HeaderText="Plizas para la obra">
                            <ItemStyle Wrap="True" Width="20" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Art�culo" SortExpression="Articulo">
                            <ItemStyle Wrap="True" Width="400" />
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>'>
                                </asp:Label>
                                <%--IIf(Eval("OrigenDescripcion")==1), Eval("Articulo"),""))--%>
                                <%--                    <asp:Label ID="Label2" runat="server" 
                    Text='<%# if (Eval("OrigenDescripcion")=1) Eval("Articulo") & "/" &  Eval("Observaciones");
                              else if (Eval("OrigenDescripcion")=0) Eval("Articulo");
                              else Eval("Observaciones");
                    %>'></asp:Label>
                                --%>
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
                            <ControlStyle Font-Size="Small" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                    </Columns>
                   <%-- <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />--%>
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                   <%--<AlternatingRowStyle BackColor="#000000" />--%>
                </asp:GridView>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="El comprobante no puede estar sin items"
                    Style="display: none" ValidationGroup="Encabezado"></asp:CustomValidator>
                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                    TargetControlID="CustomValidator1" CssClass="CustomValidatorCalloutStyle">
                </ajaxToolkit:ValidatorCalloutExtender>
            </div>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor=""
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="Id"
                    GridLines="Horizontal" Width="702px" Style="margin-bottom: 9px; margin-top: 0px;"
                    CellPadding="3" TabIndex="8">
                    <Columns>
                        <asp:BoundField DataField="NumeroItem" HeaderText="Recepciones provisorias">
                            <ItemStyle Wrap="True" Width="20" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Art�culo" SortExpression="Articulo">
                            <ItemStyle Wrap="True" Width="400" />
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Codigo") & " " & IIf(Eval("OrigenDescripcion")<>2, Eval("Articulo"),"") & " " & IIf(Eval("OrigenDescripcion")<>1, Eval("Observaciones"),"") %>'>
                                </asp:Label>
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
                            <ControlStyle Font-Size="Small" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                    </Columns>
                   <%-- <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />--%>
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                   <%--<AlternatingRowStyle BackColor="#000000" />--%>
                </asp:GridView>
                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                    TargetControlID="CustomValidator1" CssClass="CustomValidatorCalloutStyle">
                </ajaxToolkit:ValidatorCalloutExtender>
            </div>
        </contenttemplate>
        <triggers>
            <%--boton que dispara la actualizacion de la grilla--%>
            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
        </triggers>
    </asp:updatepanel>
    <asp:updatepanel id="UpdatePanelDetalle" runat="server" updatemode="Conditional">
        <contenttemplate>
            <asp:LinkButton ID="LinkButtonPopupDirectoCliente" runat="server" OnClientClick="AgregarItemDesdeCliente(); return false;"
                Font-Bold="False" ForeColor="" Font-Size="Small" Height="20px" Width="122px"
                ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
                margin-top: 0px; margin-bottom: 11px;" TabIndex="10" Font-Underline="False">
                <img src="../Imagenes/AgregarNegro.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" />
                <asp:Label ID="Label14" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True" />
            </asp:LinkButton>
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" ForeColor="" Font-Size="X-Small"
                Height="20px" Width="122px" ValidationGroup="Encabezado" BorderStyle="None" Style="vertical-align: bottom;
                margin-top: 0px; margin-bottom: 11px;" TabIndex="10" Font-Underline="False">
                <img src="../Imagenes/AgregarNegro.png" alt="" style="vertical-align: middle; border: none;
                    text-decoration: none;" width="16" height="16" />
                <asp:Label ID="Label13" runat="server" ForeColor="" Text="Agregar item" Font-Underline="True"></asp:Label>
            </asp:LinkButton>
            <asp:HiddenField runat="server" ID="hfIdItem" />
            <asp:HiddenField runat="server" ID="hfProxItem" />
            <asp:HiddenField runat="server" ID="hfFechaNecesidad" />
            <script type="text/javascript">



                function AgregarItemDesdeCliente() {


                    //$find('txt_AC_Articulo').value = '';

                    /*
                    ViewState("IdDetalleObra") = -1
        

                    txt_AC_Articulo.Text = ""
                    SelectedAutoCompleteIDArticulo.Value = 0
                    txtCodigo.Text = ""
                    txtCantidad.Text = 0
                    txtObservacionesItem.Text = ""
                    RadioButtonList1.SelectedIndex = 0
                    */

                    document.getElementById('<%= txt_AC_Articulo.ClientID %>').value = '';
                    document.getElementById('<%= SelectedAutoCompleteIDArticulo.ClientID %>').value = 0;
                    document.getElementById('<%= txtCodigo.ClientID %>').value = '';
                    document.getElementById('<%= txtCantidad.ClientID %>').value = 0;
                    document.getElementById('<%= txtObservacionesItem.ClientID %>').value = '';
                    document.getElementById('<%= RadioButtonList1.ClientID %>').value = 0;
                    //var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedAutoCompleteIDArticulo');
                    //id.value = s[0]; //le aviso a clearhidden que no me pise el dato
                    //alert('a');
                    document.getElementById('<%= hfIdItem.ClientID %>').value = -1; //es un alta
                    //document.getElementById('<%= txtItem.ClientID %>').value = document.getElementById('<%= hfProxItem.ClientID %>').value;
                    //alert(document.getElementById('<%= hfProxItem.ClientID %>').value);
                    document.getElementById('<%= txtFechaNecesidad.ClientID %>').value = document.getElementById('<%= hfFechaNecesidad.ClientID %>').value;

                    document.getElementById('<%= RequiredFieldtxtObservacionesItem.ClientID %>').EnableClientScript = false;
                    document.getElementById('<%= RequiredFieldtxtObservacionesItem.ClientID %>').Enabled = false;






                    //www.dreamincode.net/forums/topic/29891-ajax-modalpopupextender-activation/
                    var validated = Page_ClientValidate('Encabezado');
                    if (validated) {
                        $find('ModalPopupExtender3').show(); //pinta que es importante que est� puesto el BehaviorID en el ModalPopupExtender         
                    }

                    /*
                    'traigo el Obra, todo para ver el proximo item......
                    Dim myObra As Pronto.ERP.BO.Obra
                    If (Me.ViewState(mKey) IsNot Nothing) Then
                    myObra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
                    txtItem.Text = ObraManager.UltimoItemDetalle(myObra) + 1
                    Else
                    txtItem.Text = 1
                    End If

                    Dim mvarAux As String = BuscarClaveINI("Dias default para fecha necesidad en RM", SC, Session)
                    If Len(mvarAux) > 0 Then
                    txtFechaNecesidad.Text = DateAdd("d", Val(mvarAux), txtFechaObra.Text)
                    Else
                    txtFechaNecesidad.Text = Today.ToString
                    End If
                    */


                }                
                
            </script>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button4" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" OnClientClick="return false" CausesValidation="False" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="PanelDetalle" runat="server" Height="320px" Width="590px" CssClass="modalPopup"
                DefaultButton="btnSaveItem">
                <asp:UpdatePanel ID="UP5" runat="server">
                    <ContentTemplate>
                        <table style="height: 100px; width: 673px;">
                            <tr>
                                <td style="width: 80px; height: 32px; position: relative;">
                                    <asp:Label ID="Label11" ForeColor="" runat="server" Text="Item" Style="z-index: 1;"></asp:Label>
                                </td>
                                <td style="width: 159px">
                                    <asp:TextBox ID="txtItem" runat="server" Enabled="False" Height="22px" Width="31px"></asp:TextBox>
                                </td>
                                <td style="width: 146px">
                                    <asp:Label ID="lblFechaNecesidad" runat="server" ForeColor="" Text="Fecha necesidad"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFechaNecesidad" runat="server" Width="72px" Style="z-index: 1;
                                        position: relative;" TabIndex="100"></asp:TextBox><cc1:CalendarExtender ID="CalendarExtender2"
                                            runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaNecesidad">
                                        </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                        TargetControlID="txtFechaNecesidad">
                                    </cc1:MaskedEditExtender>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; width: 80px;">
                                    <asp:Label ID="Label10" runat="server" ForeColor="" Text="Art�culo"></asp:Label>
                                </td>
                                <td style="height: 30px" colspan="3">
                                    <asp:TextBox ID="txtCodigo" runat="server" Width="110px" Height="22px" AutoPostBack="True"
                                        TabIndex="101"></asp:TextBox>
                                    <asp:TextBox ID="txt_AC_Articulo" runat="server" autocomplete="off" AutoCompleteType="None"
                                        Width="359px" OnTextChanged="btnTraerDatos_Click" Style="margin-left: 0px" Height="22px"
                                        AutoPostBack="True" TabIndex="102"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_AC_Articulo"
                                        ErrorMessage="* Ingrese Art�culo" Font-Size="X-Small" ForeColor="#FF3300" Font-Bold="False"
                                        ValidationGroup="Detalle" Width="100" />
                                    <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                    <%--                        http://forums.asp.net/t/1040191.aspx?PageIndex=2 el temita del scroll en el autocomplete
                                    --%>
                                    <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender2" runat="server"
                                        CompletionSetCount="12" EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                                        ServicePath="WebServiceArticulos.asmx" TargetControlID="txt_AC_Articulo" UseContextKey="true"
                                        OnClientItemSelected="SetSelectedAutoCompleteIDArticulo" CompletionListElementID='ListDivisor'
                                        FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll">
                                        <%--
                            CompletionListCssClass="list" 
	CompletionListItemCssClass="listitem" 
	CompletionListHighlightedItemCssClass="hoverlistitem">--%></cc1:AutoCompleteExtender>
                                    <asp:Button ID="btnTraerDatos" runat="server" Text="YA" Width="30px" Height="22px"
                                        CausesValidation="False" Style="visibility: hidden; display: none;" Visible="False" />
                                    <%--http://aadreja.blogspot.com/2009/07/clicking-autocompleteextender-scrollbar.html--%>
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
                                            //comento esta linea pues el proveedor no tiene codigo.... -podr�as traer el CUIT... 
                                            //-uf,tambien podr�a traer la condicion de IVA...
                                            //var cod = document.getElementById('ctl00_ContentPlaceHolder1_txtCodigo');
                                            var s = new Array();
                                            s = a.split('^'); //separo la informacion que me pasa el web service
                                            id.value = s[0]; //le aviso a clearhidden que no me pise el dato
                                            //id.value = id.value + ' Che_ClearHiddenIDField_esto_es_nuevo'; //le aviso a clearhidden que no me pise el dato
                                            //cod.value = s[1];

                                            //var id = document.getElementById('ctl00_ContentPlaceHolder1_TextBox2');
                                            //id.value = s[0]; //le aviso a clearhidden que no me pise el dato

                                            ///////////////////////////////
                                            //deshabilitar el cuit y la condicion ..... (pues solo son editables si el alta se hace al vuelo)
                                            ///////////////////////////////
                                            //document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = true;
                                            //document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = true;

                                            //                            //.... , y llenarlos (debiera llamar al server?)
                                            ///////////////////////////////



                                            // opcional: fuerzo click al "go button (http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106)
                                            // si el boton no est� visible, getElementById devuelve null 
                                            var but = document.getElementById('ctl00_ContentPlaceHolder1_btnTraerDatos');
                                            but.click(); // .onclick();

                                            //alert(a);
                                            //alert(b.value);
                                        }

                                    </script>
                                    <%--forzar la seleccion del autocomplete--%>
                                    <%--http://www.experts-exchange.com/Programming/Languages/Scripting/JScript/Q_23217217.html--%>
                                    <script type="text/javascript">

                                        function ForzarSelectedAutoCompleteIDArticulo(source, eventArgs) {

                                            var AutoCompleteExtender = $find('<%=AutoCompleteExtender2.ClientID%>');
                                            var completionList = AutoCompleteExtender.getCompletionList();

                                            var firstItem;
                                            var newLineIndex = completionList.innerText.indexOf("\r\n");

                                            if (newLineIndex != -1) {
                                                firstItem = completionList.innerText.substring(0, newLineIndex);
                                            }
                                            else {
                                                firstItem = completionList.innerText;
                                            }

                                            var autoCompleteTextBox = $get('<%= txt_AC_Articulo.ClientID %>');
                                            autoCompleteTextBox.value = firstItem;

                                        }

                                    </script>
                                    <div id="ListDivisor">
                                    </div>
                                    <%-- Por si la lista se renderea atr�s   http://forums.asp.net/t/1079711.aspx--%>
                                    <input id="SelectedAutoCompleteIDArticulo" runat="server" type="hidden" />
                                    <%--el hidden que guarda el id--%>
                                    <%--el que trae los datos del proveedor--%>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="height: 38px; width: 673px;">
                    <tr>
                        <td style="width: 80px; height: 31px;">
                            <asp:Label ID="lblCantidad" ForeColor="" runat="server" Text="Cantidad"></asp:Label>
                        </td>
                        <td style="height: 31px; width: 70px;">
                            <asp:TextBox ID="txtCantidad" runat="server" Width="90px" TabIndex="103"></asp:TextBox><cc1:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtCantidad" ValidChars=".1234567890">
                            </cc1:FilteredTextBoxExtender>
                        </td>
                        <td style="height: 31px; width: 102px;">
                            <asp:UpdatePanel ID="Updatepanel11" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cmbDetUnidades" runat="server" AutoPostBack="True" Enabled="False"
                                        Width="90px" Height="22px">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td style="height: 31px">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCantidad"
                                ErrorMessage="* Ingrese Cantidad" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                Enabled="true" InitialValue="" Display="Dynamic" ValidationGroup="Detalle" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator"
                                ControlToValidate="txtCantidad" Font-Size="Small" ForeColor="#FF3300" Font-Bold="True"
                                Enabled="true" Operator="GreaterThan" ValueToCompare="0" Display="Dynamic" ValidationGroup="Detalle">* Debe ser mayor que 0</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr  class=Oculto>
                        <td>
                            Control de calidad
                        </td>
                        <td colspan=2>
                            <asp:DropDownList ID="cmbCalidad" runat="server" AutoPostBack="True" Enabled="true"  CssClass="CssCombo"  />
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="Updatepanel1" runat="server">
                    <ContentTemplate>
                        <table style="height: 100px; width: 671px;">
                            <tr>
                                <td style="width: 80px">
                                    <asp:Label ID="lblObservaciones" ForeColor="" runat="server" Text="Observ."></asp:Label>
                                </td>
                                <td valign="top" style="width: 281px">
                                    <asp:TextBox ID="txtObservacionesItem" runat="server" TextMode="MultiLine" Width="242px"
                                        Height="72px" TabIndex="104"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldtxtObservacionesItem" runat="server"
                                        ControlToValidate="txtObservacionesItem" ErrorMessage="* Ingrese Obs." Font-Size="Small"
                                        ForeColor="#FF3300" Font-Bold="True" ValidationGroup="Detalle" Enabled="False" />
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonList1" ForeColor="" runat="server" Style="margin-left: 0px"
                                        AutoPostBack="True" TabIndex="105">
                                        <asp:ListItem Value="1" Selected="True">Solo el material</asp:ListItem>
                                        <asp:ListItem Value="2">Solo las observaciones</asp:ListItem>
                                        <asp:ListItem Value="3">Material mas observaciones</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <table style="height: 18px; width: 671px;">
                    <tr>
                        <td style="height: 38px">
                        </td>
                        <td style="height: 38px; width: 281px;">
                        </td>
                        <td style="height: 38px" align="right">
                            <asp:Button ID="btnSaveItem" runat="server" Font-Size="Small" Text="Aceptar" CssClass="but"
                                UseSubmitBehavior="False" Width="82px" Height="25px" ValidationGroup="Detalle" />
                        </td>
                        <td style="height: 38px">
                            <asp:Button ID="btnCancelItem" runat="server" Font-Size="Small" Text="Cancelar" CssClass="butcancela"
                                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 20px" Font-Bold="False"
                                Height="25px" CausesValidation="False" Width="78px" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%--reemplac� TargetControlId="Button4" con  TargetControlId="LinkButtonPopupDirectoCliente" --%>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BehaviorID="ModalPopupExtender3"
                TargetControlID="Button4" PopupControlID="PanelDetalle" CancelControlID="btnCancelItem"
                DropShadow="False" BackgroundCssClass="modalBackground" />
            <%--no me funciona bien el dropshadow  -Ya est�, puse el BackgroundCssClass explicitamente!   --%></contenttemplate>
        <triggers>
            <%--el FileUpload y el de descarga no funcionan si no se refresca el UpdatePanel 
             http://forums.asp.net/t/1403316.aspx
             note that it is not an AsyncPostBackTrigger
             http://mobiledeveloper.wordpress.com/2007/05/15/file-upload-with-aspnet-ajax-updatepanel/
            --%>
            <%--            <asp:PostBackTrigger ControlID="lnkDetAdjunto1" />
            <asp:PostBackTrigger ControlID="lnkDetAdjunto2" />
            <asp:PostBackTrigger ControlID="btnRecalcularTotal" />
            --%></triggers>
    </asp:updatepanel>
    <asp:linkbutton id="LinkButtonOpenXML" runat="server" font-bold="False" forecolor=""
        font-size="Small" height="20px" width="101px" validationgroup="Encabezado" borderstyle="None"
        style="vertical-align: bottom; margin-top: 0px; margin-bottom: 6px;" causesvalidation="False"
        tabindex="10" font-underline="False">
        <img src="../Imagenes/GmailPrintNegro.png" alt="" style="vertical-align: middle;
            border: none; text-decoration: none;" />
        <asp:label id="Label15" runat="server" forecolor="" text="Word" font-underline="True" />
    </asp:linkbutton>
    <asp:linkbutton id="LinkImprimir" runat="server" font-bold="False" forecolor="" font-size="X-Small"
        height="20px" width="101px" validationgroup="Encabezado" borderstyle="None" style="vertical-align: bottom;
        margin-top: 0px; margin-bottom: 6px;" causesvalidation="False" tabindex="10"
        font-underline="False" visible="False">
        <%--<img src="../Imagenes/GmailPrint.png" alt="" style="vertical-align: middle; border: none;
            text-decoration: none;" width="16" height="16" />--%>
        <asp:label id="Label12" runat="server" forecolor="" text="Imprimir" font-underline="True"
            visible="False" />
    </asp:linkbutton>
    <br />
    <br />
    <br />
    <br />
    <asp:updatepanel id="UpdatePanelPreRedirectMsgbox" runat="server">
        <contenttemplate>
            <ajaxToolkit:ModalPopupExtender ID="PreRedirectMsgbox" runat="server" TargetControlID="btnPreRedirectMsgbox"
                PopupControlID="PanelInfoNum" DropShadow="false">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Button ID="btnPreRedirectMsgbox" runat="server" Text="invisible" Font-Bold="False"
                Style="visibility: hidden; display: none" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="PanelInfoNum" runat="server" Height="123px" Style="display: none;"
                CssClass="modalPopup" Width="387px">
                <table style="width: 368px; color: #FFFFFF;">
                    <tr>
                        <td align="center" style="height: 37px; font-weight: bold; background-color: green;">
                            Informaci�n
                        </td>
                    </tr>
                    <tr>
                        <td style="color: white;" align="center">
                            <span style="color: #ffffff">
                                <br />
                                <asp:Label ID="LblPreRedirectMsgbox" runat="server" ForeColor=""></asp:Label><br />
                                <br />
                                <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="S�" />
                                <asp:Button ID="ButVolverSinImprimir" runat="server" CssClass="imp" Text="No" />
                            </span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </contenttemplate>
    </asp:updatepanel>
    <asp:updatepanel id="UpdatePanel3" runat="server">
        <contenttemplate>
            <%--http://tim.tdaley.net/2008/12/c-onclientclick-breaks-validation.html--%><asp:Button
                ID="btnSave" runat="server" Text="Aceptar" CssClass="but" OnClientClick="if (Page_ClientValidate('Encabezado')) this.disabled = true;"
                UseSubmitBehavior="False" Width="82px" Style="margin-right: 30px" Font-Size="Small"
                ValidationGroup="Encabezado" TabIndex="11" Font-Bold="True"></asp:Button>
            <%--le saqu� el CssClass="but"--%>
            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" CssClass="butcancela"
                Text="Cancelar" CausesValidation="False" UseSubmitBehavior="False" Width="79px"
                Font-Bold="False" Style="margin-right: 30px" Font-Size="Small" TabIndex="12">
            </asp:Button>
            <asp:Button ID="btnAnular" runat="server" CssClass="but" Text="Anular" CausesValidation="False"
                UseSubmitBehavior="False" Width="79px" Font-Bold="False" Style="" Font-Size="Small"
                TabIndex="13"></asp:Button>
                            <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" />
                    <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor=""
                        Visible="False"></asp:Label></ProgressTemplate>
            </asp:UpdateProgress>

            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button2" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
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
                    &nbsp;
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                        Width="177px"></asp:TextBox><br />
                    <br />
                    <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False" />
                    <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />


                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button2"
                PopupControlID="Panel1" BackgroundCssClass="modalBackground" OkControlID="btnOk"
                DropShadow="false" PopupDragHandleControlID="Panel2" CancelControlID="btnCancelarLibero">
            </cc1:ModalPopupExtender>
        </contenttemplate>
    </asp:updatepanel>
    <asp:updatepanel id="UpdatePanelAnulacion" runat="server">
        <contenttemplate>
            <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>
            <asp:Button ID="Button7" runat="server" Text="invisible" Font-Bold="False" Style="visibility: hidden;
                display: none" Height="16px" Width="66px" />
            <%--style="visibility:hidden;"/>--%>
            <asp:Panel ID="Panel4" runat="server" Height="172px" Style="vertical-align: middle;
                text-align: center" Width="220px" BorderColor="Transparent" ForeColor="" CssClass="modalPopup">
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
                PopupControlID="Panel4" BackgroundCssClass="modalBackground" OkControlID="" DropShadow="false"
                CancelControlID="btnAnularCancel">
                <%-- OkControlID se lo saqu� porque no estaba llamando al codigo del servidor--%></cc1:ModalPopupExtender>
        </contenttemplate>
    </asp:updatepanel>
    <br />
    <%--para que si la pagina es larga, los botones de aceptar no queden contra la barra de abajo--%>
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
</asp:content>
