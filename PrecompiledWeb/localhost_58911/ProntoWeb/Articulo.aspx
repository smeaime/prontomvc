<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="ArticuloABM, App_Web_w1oacxob" title="Artículo" theme="Azul" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="EncabezadoComprobante">
        <table style="padding: 0px; border: none; width: 700px; height: 62px; margin-right: 0px;"
            cellpadding="3" cellspacing="3" class="EncabezadoCell">
            <tr>
                <td colspan="3" style="border: thin none; font-weight: bold; font-size: large; height: 34px;"
                    align="left" valign="top">
                    ARTICULO
                    <asp:label id="lblAnulado0" runat="server" backcolor="#CC3300" bordercolor="White"
                        borderstyle="Solid" borderwidth="1px" font-bold="True" font-size="Large" forecolor="White"
                        style="text-align: center; margin-left: 0px; vertical-align: top" text=" ANULADO "
                        visible="False" width="120px"></asp:label>
                </td>
                <td class="EncabezadoCell" style="height: 34px;" valign="top" align="right" colspan="3">
                    <asp:updateprogress id="UpdateProgress2" runat="server">
                        <progresstemplate>
                        <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="true"></asp:Label>
                    </progresstemplate>
                    </asp:updateprogress>
                </td>
            </tr>
            <tr>
                <td class="EncabezadoCell" style="width: 100px; height: 21px">
                    Descripcion
                </td>
                <td colspan="3" style="height: 21px">
                    <asp:textbox id="txtDescripcion" runat="server" width="296px">
                    </asp:textbox>
                    <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" controltovalidate="txtDescripcion"
                        errormessage="Ingrese una descripción" font-size="Small" forecolor="#FF3300"
                        font-bold="True" validationgroup="Encabezado" style="display: none">
                    </asp:requiredfieldvalidator>
                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                        Enabled="True" TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                </td>
            </tr>
            <tr>
                <td class="EncabezadoCell" style="width: 100px">
                    Rubro
                </td>
                <td class="EncabezadoCell" style="width: 116px">
                    <asp:dropdownlist id="cmbRubro" runat="server" width="100px" autopostback=true>
                    </asp:dropdownlist>
                </td>
                <td class="EncabezadoCell" style="width: 65px">
                    Subrubro
                </td>
                <td class="EncabezadoCell" style="width: 100px">
                    <asp:dropdownlist id="cmbSubrubro" runat="server" width="100px "  autopostback=true>
                    </asp:dropdownlist>
                </td>
            </tr>
            <tr style="display: none">
                <td class="EncabezadoCell" style="width: 65px">
                    Usuario alta
                </td>
                <td class="EncabezadoCell" style="width: 100px">
                </td>
                <td>
                    fecha alta
                </td>
            </tr>
        </table>
        <br />
        <asp:updatepanel id="UpdatePanelEncabezado" runat="server">
            <contenttemplate>
            <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Height="264px"
                CssClass="NewsTab"  Width="700px">
                <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="TabPanel1">
                    <ContentTemplate>

                        <asp:TextBox ID="TextBox1" runat="server" Width="40px" Visible="False"></asp:TextBox>
                        <br />
                        <div style="text-align: left">
                        <table class="tabcontenido" id="TablaDinamica" runat="server" >
                          <%--  <tr>
                                <td class="EncabezadoCell" valign="top">
                                </td>
                                <td colspan="3" style="height: 18px">
                                </td>
                            </tr>--%>
                           <%-- <tr >
                             <td class="EncabezadoCell" valign="top">
                                    <asp:label id="label1" runat="server" />
                                </td>
                                <td colspan="3" style="height: 18px">
                                    <asp:DropDownList ID="combo1" runat="server" />
                                    <asp:TextBox ID="textbox10" runat="server" />
                                </td></tr>--%>
                        </table>
                
                            <table class="tabcontenido" id="Tabla2" runat="server" visible=false >
                                             <tr>
                                <td class="EncabezadoCell" valign="top">
                                    Observaciones
                                </td>
                                <td colspan="3" style="height: 18px">
                                    <asp:TextBox ID="txtObservaciones" runat="server" Height="70px" TextMode="MultiLine"
                                        Width="296px"></asp:TextBox>
                                </td>
                            </tr>
           <tr>
                <td class="EncabezadoCell" style="width: 100px">
                    Unidad
                </td>
                <td class="EncabezadoCell" style="width: 116px">
                    <asp:dropdownlist id="cmbUnidad" runat="server" width="100px">
                    </asp:dropdownlist>
                </td>
                <td class="EncabezadoCell" style="width: 100px; height: 30px;">
                    Tipo de obra
                </td>
                <td class="EncabezadoCell" style="width: 220px; height: 30px;">
                    <asp:dropdownlist id="cmbObra" runat="server" cssclass="CssCombo" tabindex="3" validationgroup="Encabezado"
                        height="19px">
                    </asp:dropdownlist>
                    <asp:requiredfieldvalidator id="RequiredFieldValidator3" runat="server" controltovalidate="cmbObra"
                        errormessage="Elija una Obra" font-bold="True" font-size="Small" forecolor="#FF3300"
                        initialvalue="-1" style="display: none" validationgroup="Encabezado" />
                    <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" Enabled="True"
                        TargetControlID="RequiredFieldValidator3" CssClass="CustomValidatorCalloutStyle" />
                    &nbsp;
                </td>
            </tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Codigo
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                        Forma de registrar stock
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario22" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Registrar stock
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo123" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                        Color
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario25723" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Stock de reposicion
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo36573" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                        % de IVA
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario34673" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Es un kit?
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo3657356" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                        Es activo fijo?
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario36767" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Costo PPP
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo34563" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                       NCM
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario346" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                              <tr>
                                 <td class="EncabezadoCell" style="width: 65px">
                                        Ubicacion
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCodigo2345" runat="server" Width="88px"></asp:TextBox>
                                    </td>
                         <td class="EncabezadoCell" style="width: 65px">
                                        Nro.Inventario
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtNumeroInventario" runat="server" Width="88px"></asp:TextBox>
                                    </td></tr>
                             
                            </table>
                        </div>
                        <br />
                        &nbsp;&nbsp;
                    </ContentTemplate>
                    <HeaderTemplate>
                        Sección 1
                    </HeaderTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="TabPanel2" Visible=false>
                    <HeaderTemplate>
                        Accesorios
                    </HeaderTemplate>
                    <ContentTemplate>
                        <div style="text-align: left">
                            <table  class="tabcontenido" >
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        Alicuota IVA
                                    </td>
                                    <td class="EncabezadoCell" style="width: 92px">
                                        <asp:TextBox ID="txtAlicuotaIVA" runat="server" Width="30px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 105px">
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                    </td>
                                </tr>
                                <tr style="display:none">
                                    <td class="EncabezadoCell" style="width: 100px; height: 40px">
                                        Costo PPP $
                                    </td>
                                    <td class="EncabezadoCell" style="width: 92px; height: 40px">
                                        <asp:TextBox ID="txtCostoPPP" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 105px; height: 40px">
                                        Costo PPP u$s
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px; height: 40px">
                                        <asp:TextBox ID="txtCostoPPPDolar" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                                           <tr style="display:none">

                                    <td class="EncabezadoCell" style="width: 100px">
                                        Costo Rep. $
                                    </td>
                                    <td class="EncabezadoCell" style="width: 92px">
                                        <asp:TextBox ID="txtCostoReposicion" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 105px">
                                        Costo Rep. u$s
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        <asp:TextBox ID="txtCostoReposicionDolar" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        Codigo AlgoritmoHouse/LosGrobo
                                    </td>
                                    <td class="EncabezadoCell" style="width: 92px">
                                        <asp:TextBox ID="txtEspecieONCAA" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 105px">
                                    </td>
                                    <td class="EncabezadoCell" style="width: 100px">
                                    </td>
                                </tr>

                                <tr>
                                    <td class="EncabezadoCell" style="width: 100px">
                                        Codigo SAGPyA/ONCCA
                                    </td>
                                    <td class="EncabezadoCell" style="width: 92px">
                                        <asp:TextBox ID="txtCodigoSagypa" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                    <td class="EncabezadoCell" style="width: 105px">
                                        Codigo BLD
                                    </td>
                                    
                                    <td class="EncabezadoCell" style="width: 100px">
                                    <asp:TextBox ID="txtCodigoZeni" runat="server" Width="50px"></asp:TextBox>
                                    </td>
                                </tr>


                            </table>
                        </div>
                    </ContentTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel1" visible=false>
                 <HeaderTemplate>
                        Seccion 1
                    </HeaderTemplate> <ContentTemplate>
                    <br />
                    <br />
                    <br />
                    </ContentTemplate>
                </cc1:TabPanel>

            </cc1:TabContainer>
        </contenttemplate>
        </asp:updatepanel>
    </div>
    <asp:updatepanel id="UpdatePanelGrilla" runat="server" updatemode="Conditional">
        <contenttemplate>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor=""
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="IdUnidad"
                    GridLines="Horizontal" Width="200px" 
                    RowStyle-CssClass="renglonSoloVisibleEnHover" 
                    CellPadding="3" TabIndex="8"  visible=false>
                    <Columns>
                        <asp:BoundField DataField="NumeroItem" HeaderText="Unidades" visible=false >
                            <ItemStyle Wrap="True" Width="20" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Artículo" SortExpression="Unidades">
                            <ItemStyle Wrap="True" Width="" />
                            <ItemTemplate>
                                <asp:textbox ID="txtUnidad" runat="server" Text='<%#  Bind("IdUnidad") %>'>
                                </asp:textbox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender21" runat="server"
                                CompletionSetCount="12" TargetControlID="txtUnidad" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceUnidades.asmx" UseContextKey="True"
                                FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll" DelimiterCharacters=""
                                Enabled="True">
                            </cc1:AutoCompleteExtender>

                            </ItemTemplate>
                        </asp:TemplateField>
                       <%-- <asp:BoundField DataField="Cantidad" HeaderText="Equivalencia" HeaderStyle-HorizontalAlign="right"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}">
                            <HeaderStyle Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unidad" HeaderText="" HeaderStyle-HorizontalAlign="Center"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:F2}" visible=false>
                            <HeaderStyle Width="30px" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>--%>
                        <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar" ItemStyle-HorizontalAlign="Center"
                            HeaderStyle-Font-Size="X-Small">
                            <ControlStyle Font-Size="Small" />
                            <ItemStyle Font-Size="Small" />
                            <HeaderStyle Width="40px" />
                        </asp:ButtonField>
                        <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado"       >
                            <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" /></asp:ButtonField>

                        <asp:ButtonField ButtonType="Link"  CommandName="NuevoRenglon" Text="+" ItemStyle-HorizontalAlign="Center"
                            ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado"       >
                            <ControlStyle Font-Size="Small" Font-Underline="True"  />
                            <ItemStyle Font-Size="X-Small" />          
                            <HeaderStyle Width="40px"  />
                        

                        </asp:ButtonField>

                        

                    </Columns>
                   <%-- <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />--%>
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7"  />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                   <%--<AlternatingRowStyle BackColor="#000000" />--%>
                </asp:GridView>
               
            </div>
            <div style="overflow: auto;">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor=""
                    BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" DataKeyNames="IdUnidad"
                    GridLines="Horizontal" Width="702px" Style="margin-bottom: 9px; margin-top: 0px;"
                    CellPadding="3" TabIndex="8" visible=false>
                    <Columns>
                      <%--   <asp:BoundField DataField="NumeroItem" HeaderText="Recepciones provisorias">
                            <ItemStyle Wrap="True" Width="20" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Artículo" SortExpression="Articulo">
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
                        </asp:BoundField>--%>
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
               
            </div>
        </contenttemplate>
        <triggers>
            <%--boton que dispara la actualizacion de la grilla--%>
          <%--  <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />--%>
        </triggers>
    </asp:updatepanel>
    <br />
    <br />
    <asp:updateprogress id="UpdateProgress100" runat="server">
        <progresstemplate>
            <img src="Imagenes/25-1.gif" alt="" />
            <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                Visible="False"></asp:Label>
        </progresstemplate>
    </asp:updateprogress>
    <asp:button id="btnSave" runat="server" onclick="btnSave_Click" text="Aceptar" usesubmitbehavior="False"
        cssclass="but" width="82px" style="margin-right: 30px" />
    <asp:button id="btnCancel" runat="server" causesvalidation="False" onclick="btnCancel_Click"
        cssclass="butcancela" font-bold="False" text="Cancelar" usesubmitbehavior="False"
        width="79px" style="margin-right: 30px" font-size="Small" />
    <br />
    <br />
</asp:content>
