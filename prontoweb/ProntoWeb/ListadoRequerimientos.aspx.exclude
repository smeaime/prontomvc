<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="ListadoRequerimientos.aspx.vb" Inherits="ProntoWeb_ListadoRequerimientos"
    Title="BDL" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center">
        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server">
        </ajaxToolkit:ToolkitScriptManager>
        &nbsp;<br />
        &nbsp;&nbsp;&nbsp;
        <asp:ObjectDataSource ID="ObjDSListadoRequerimentos" runat="server" DeleteMethod="Delete"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetListByEmployee"
            TypeName="Pronto.ERP.Bll.RequerimientoManager" UpdateMethod="Save">
            <DeleteParameters>
                <asp:Parameter Name="SC" Type="String" />
                <asp:Parameter Name="myRequerimiento" Type="Object" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="SC" Type="String" />
                <asp:Parameter Name="myRequerimiento" Type="Object" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                <asp:SessionParameter Name="IdSolicito" SessionField="IdEmpleado" Type="String" />
                <asp:ControlParameter ControlID="order" DefaultValue="Id" Name="orderBy" PropertyName="Value"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        &nbsp; &nbsp;&nbsp; &nbsp;
        <asp:HiddenField ID="HFSC" runat="server" />
        <asp:HiddenField ID="HFIdArticulo" runat="server" />
        <table width="700">
            <tr>
                <td align="left">
                    <asp:Button ID="ButNuevoRequerimimiento" runat="server" CssClass="but" Text="Agregar requerimiento"
                        PostBackUrl="~/ProntoWeb/NuevoRequerimiento.aspx" />
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        &nbsp; &nbsp;&nbsp;<br />
        <asp:DataList ID="DLListReq" runat="server" Width="700px" DataSourceID="ObjDSListadoRequerimentos"
            ShowFooter="False" EnableViewState="False" DataKeyField="Id">
            <ItemTemplate>
                <asp:UpdatePanel ID="UpdatePanel" runat="server" EnableViewState="False" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table id="TABLE1" class="t1" cellspacing="0" cellpadding="0" width="100%" border="1">
                            <tbody>
                                <tr>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 10%" valign="middle">
                                        <asp:Label ID="Numero" runat="server" Text='<%# Eval("Numero") %>' __designer:wfdid="w19"
                                            Font-Bold="True" ForeColor="Black"></asp:Label>
                                    </td>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 12%" valign="middle">
                                        <asp:Label ID="Fecha" runat="server" Text='<%# Eval("Fecha", "{0:d}") %>' __designer:wfdid="w20"
                                            Font-Bold="True" ForeColor="Black"></asp:Label>
                                    </td>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 64px" valign="middle"
                                        align="center">
                                        <asp:Label ID="Obra" runat="server" Text='<%# Eval("Obra") %>' __designer:wfdid="w21"
                                            Font-Bold="True" ForeColor="Black"></asp:Label>
                                    </td>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 15%" valign="top">
                                        <asp:Button ID="ButList" runat="server" Width="70px" Text="Detalle" CssClass="but"
                                            __designer:wfdid="w22" CommandArgument='<%# Eval("Id") %>'></asp:Button>
                                    </td>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 69px" valign="top">
                                        <asp:Button ID="ButEdit" runat="server" Width="60px" PostBackUrl="~/ProntoWeb/NuevoRequerimiento.aspx"
                                            Text="Editar" CssClass="but" __designer:wfdid="w23" CommandArgument='<%# String.Format("{0}#{1}", Eval("Id"), Eval("Numero")) %>'
                                            OnCommand="ButEdit_Command" CommandName="cmd"></asp:Button>
                                    </td>
                                    <td style="background-image: url(../Imagenes/captionbckg.gif); width: 69px" valign="top">
                                        <asp:Button ID="ButEliminar" runat="server" Width="70px" Text="Eliminar" CssClass="but"
                                            __designer:wfdid="w24" CommandArgument='<%# Eval("Id") %>' OnCommand="ButEliminar_Command"
                                            OnClientClick="javascript:return confirm('Desea elimiar el requerimiento?');">
                                        </asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: Gray" valign="middle" align="center" colspan="2">
                                        <asp:Label ID="Solicito" runat="server" Text='<%# Eval("Solicito") %>' __designer:wfdid="w25"
                                            Font-Bold="True" ForeColor="Black"></asp:Label>
                                    </td>
                                    <td style="width: 64px; background-color: Gray" valign="middle" align="center">
                                        <strong>Sector: </strong>
                                        <asp:Label ID="Sector" runat="server" Text='<%# Eval("Sector") %>' __designer:wfdid="w26"
                                            Font-Bold="True" ForeColor="Black"></asp:Label>
                                    </td>
                                    <td style="width: 70px; background-color: Gray" valign="top">
                                    </td>
                                    <td style="width: 69px; background-color: Gray" valign="top">
                                    </td>
                                    <td style="width: 69px; background-color: Gray" valign="top" align="right">
                                        <a onclick="EmisionReq('<%# Eval("Id") %>',1);return false;" href="#">
                                            <img height="25" alt="Obtener MSWord" src="../Imagenes/word_icon.gif" width="25"
                                                border="0" /></a><a onclick="EmisionReq('<%# Eval("Id") %>',2);return false;"
                                                    href="#"><img height="25" alt="Obtener PDF" src="../Imagenes/acrobat_pdf_icon.gif"
                                                        width="24" border="0" /></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="center" colspan="6">
                                        <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtenderItems" runat="server" __designer:wfdid="w27"
                                            SuppressPostBack="false" Collapsed="true" TargetControlID="PanelListData" CollapseControlID="ButList"
                                            ExpandControlID="ButList">
                                        </cc1:CollapsiblePanelExtender>
                                        <asp:Panel ID="PanelListData" runat="server" Width="100%" __designer:wfdid="w28">
                                            <asp:GridView ID="GVListItems" runat="server" Width="100%" CssClass="t1" EnableViewState="False"
                                                __designer:wfdid="w29" AutoGenerateColumns="False" DataKeyNames="Id,Cantidad">
                                                <RowStyle Font-Bold="True" ForeColor="Black"></RowStyle>
                                                <EmptyDataRowStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True"
                                                    ForeColor="Black"></EmptyDataRowStyle>
                                                <Columns>
                                                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False"
                                                        SortExpression="Id" Visible="False">
                                                        <ItemStyle Width="10%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Fecha">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TBFecha" runat="server" Width="86px" Text='<%# Bind("FechaEntrega") %>'
                                                                CssClass="imp"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="CalendarExtender" runat="server" TargetControlID="TBFecha"
                                                                Format="dd/MM/yyyy">
                                                            </cc1:CalendarExtender>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("FechaEntrega", "{0:dd/MM/yyyy}") %>'
                                                                __designer:wfdid="w17"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Art&#237;culo">
                                                        <EditItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Articulo") %>'></asp:Label>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Articulo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="80%"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Observaciones">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Height="50px" Text='<%# Bind("Observaciones") %>'
                                                                CssClass="imp" TextMode="MultiLine" Font-Size="10pt"></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Observaciones") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Cantidad" HeaderText="Cant.">
                                                        <ControlStyle CssClass="imp"></ControlStyle>
                                                        <ItemStyle Width="10%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle CssClass="header"></HeaderStyle>
                                            </asp:GridView>
                                        </asp:Panel>
                                        <asp:ObjectDataSource ID="ObjDsListItems" runat="server" __designer:wfdid="w30">
                                        </asp:ObjectDataSource>
                                        <asp:UpdateProgress ID="UpdateProgress" runat="server" __designer:wfdid="w31" AssociatedUpdatePanelID="UpdatePanel">
                                            <ProgressTemplate>
                                                <asp:Image ID="ImageSpinner" runat="server" __designer:wfdid="w32" ImageUrl="~/Imagenes/spinner.gif">
                                                </asp:Image>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                &nbsp;&nbsp;
                <asp:HiddenField ID="HFIdReq" runat="server" />
                &nbsp;&nbsp;&nbsp;&nbsp;
            </ItemTemplate>
            <HeaderTemplate>
                <table width="100%">
                    <tr>
                        <td align="right" style="background-image: url(../Imagenes/captionbckg.gif);" colspan="6">
                            Ordenar por:
                            <asp:DropDownList ID="DDLOrden" runat="server" CssClass="header" OnSelectedIndexChanged="DDLOrden_SelectedIndexChanged"
                                AutoPostBack="True" OnDataBound="DDLOrden_DataBound">
                                <asp:ListItem>Numero</asp:ListItem>
                                <asp:ListItem>Fecha</asp:ListItem>
                                <asp:ListItem>Obra</asp:ListItem>
                                <asp:ListItem>Solicito</asp:ListItem>
                                <asp:ListItem>Sector</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-image: url(../Imagenes/captionbckg.gif); width: 8%; color: #c00000;"
                            align="center">
                            Nro
                        </td>
                        <td style="background-image: url(../Imagenes/captionbckg.gif); width: 11%; color: #c00000;"
                            align="center">
                            Fecha
                        </td>
                        <td style="background-image: url(../Imagenes/captionbckg.gif); color: #c00000;" align="center">
                            Obra
                        </td>
                        <td style="background-image: url(../Imagenes/captionbckg.gif); width: 10%; color: #c00000;"
                            align="center">
                            Detalle
                        </td>
                        <td style="background-image: url(../Imagenes/captionbckg.gif); width: 9%; color: #c00000;"
                            align="center">
                            Editar
                        </td>
                        <td align="center" style="background-image: url(../Imagenes/captionbckg.gif); width: 70px;
                            color: #c00000">
                            Eliminar
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gray; color: #c00000;" align="center" colspan="2">
                            Usuario
                        </td>
                        <td style="background-color: Gray; color: #c00000;" align="center">
                            Sector
                        </td>
                        <td style="background-color: Gray">
                        </td>
                        <td style="background-color: Gray">
                        </td>
                        <td style="background-color: Gray">
                        </td>
                    </tr>
                </table>
            </HeaderTemplate>
        </asp:DataList>
        <asp:HiddenField ID="order" runat="server" />
        &nbsp;
        <br />
    </div>
</asp:Content>
