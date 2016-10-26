<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Resolucion1361, App_Web_55qckufu" title="Resolución 1361" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Style="margin-right: 32px"
        Visible="False">Exportar a Excel</asp:LinkButton>
    <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar como en Pronto</asp:LinkButton>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--<asp:UpdatePanel ID="UpdatePanelResumen" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
--%>
    <%--combo para filtrar cuenta--%>
    <%--    En Pronto: Contabilidad, Resolucion 
    1361--%>
    <%--   </ContentTemplate>
</asp:UpdatePanel>
--%>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA, grilla anidada y datasources
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
        cellpadding="3" cellspacing="3">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                font-size: medium; height: 37px;" align="left" valign="top">
                <asp:Label ID="lblTitulo" ForeColor="White" runat="server" Text="Resolucion 1361"
                    Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>
            </td>
            <td style="height: 37px;" valign="top" align="right">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" style="height: 19px; width: 19px" />
                        <asp:Label ID="lblUpdateProgress" ForeColor="White" runat="server" Text="Actualizando datos ..."
                            Font-Size="Small"></asp:Label></ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right; margin-left: 357px;
        margin-top: 10px;" Text="" Visible="False"></asp:TextBox>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <%--    <div style="OVERFLOW: auto;width:100%">
--%>
            <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
                cellpadding="3" cellspacing="3">
                <tr>
                    <td class="EncabezadoCell">
                        Desde
                    </td>
                    <td style="width: 197px;">
                        <asp:TextBox ID="txtFechaDesde" runat="server" MaxLength="1" TabIndex="2" Width="72px"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaDesde">
                        </cc1:MaskedEditExtender>
                    </td>
                    <td class="EncabezadoCell" rowspan="2" style="width: 92px">
                        Tipo de Comprobante
                    </td>
                    <td class="EncabezadoCell" rowspan="2">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" ForeColor="White"
                            Height="88px" Style="margin-left: 0px" TabIndex="105" Width="215px">
                            <asp:ListItem Selected="True" Value="1">Cabecera FA</asp:ListItem>
                            <asp:ListItem Value="2">Detalle FA</asp:ListItem>
                            <asp:ListItem Value="3">Ventas</asp:ListItem>
                            <asp:ListItem Value="4">Compras</asp:ListItem>
                            <asp:ListItem Value="5">Otras percep.</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td class="EncabezadoCell" style="height: 8px">
                        Hasta
                    </td>
                    <td style="width: 197px; height: 8px;">
                        <asp:TextBox ID="txtFechaHasta" runat="server" MaxLength="1" TabIndex="2" Width="72px"></asp:TextBox>
                        &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaHasta">
                        </cc1:MaskedEditExtender>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <asp:Panel ID="PopUpGrillaConsulta" runat="server" Height="300px" Width="700px">
                <div style="width: 100%; height: 100%; overflow: auto" align="left">
                    <asp:GridView ID="GridView1" runat="server" 
                    AutoGenerateColumns="true" 
                    PageSize="8" AllowPaging="false"
                    BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal"
                        Width="700px" AllowSorting="False" EnableSortingAndPagingCallbacks="True" >
                        <%-- <Columns>
                                               <asp:BoundField DataField="Tipo reg." HeaderText="Tipo reg." />
                    <asp:BoundField DataField="Fecha comp." HeaderText="Fecha comp." />
                    <asp:BoundField DataField="Tipo comp." HeaderText="Tipo comp." />
                    <asp:BoundField DataField="C.fiscal" HeaderText="C.fiscal" />
                    <asp:BoundField DataField="Pto_vta_" HeaderText="Pto.vta." />
                    <asp:BoundField DataField="Nro.comp." HeaderText="Nro.comp." />
                    <asp:BoundField DataField="Nro.comp.reg." HeaderText="Nro.comp.reg." />
                    <asp:BoundField DataField="Hojas" HeaderText="Hojas" />
                    <asp:BoundField DataField="Tipo doc." HeaderText="Tipo doc." />
                    <asp:BoundField DataField="Nro.doc." HeaderText="Nro.doc." />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="Imp.total" HeaderText="Imp.total" />
                    <asp:BoundField DataField="Imp no grav." HeaderText="Imp no grav." />
                    <asp:BoundField DataField="Imp grav." HeaderText="Imp grav." />
                    <asp:BoundField DataField="IVA" HeaderText="IVA" />
                    <asp:BoundField DataField="IVA acr." HeaderText="IVA acr." />
                    <asp:BoundField DataField="Imp.exento" HeaderText="Imp.exento" />
                        </Columns>--%>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                </div>
            </asp:Panel>
            <br />
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Filtrar" CssClass="but" Width="145px" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="Button2" runat="server" Text="Exportar TXT" CssClass="but" Width="145px" />
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <span>
        <%--<div>--%>
        <%--botones de alta y excel--%>
        <%--</div>--%>
    </span>
    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
