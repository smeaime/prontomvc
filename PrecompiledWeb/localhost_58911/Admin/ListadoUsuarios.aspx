<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Admin_Roles, App_Web_ea4s2r0n" title="Pronto Web" validaterequest="false" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
        rel="stylesheet" type="text/css" />
    <%--   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>--%>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
    <div>
        <br />
        <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div>
                    <asp:Button ID="lnkNuevo" runat="server" Font-Bold="false" Font-Underline="False"
                        Width="120" Height="30" CssClass="but" ForeColor="White" CausesValidation="true"
                        Font-Size="Small" Style="vertical-align: middle" Text="+ Nuevo" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: left;" Text="" Font-Size="Small"
                        Width="200" Height="20px" AutoPostBack="True" CssClass="txtBuscar"></asp:TextBox>
                    <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                        WatermarkText="Buscar usuarios" WatermarkCssClass="watermarkedBuscar" />
                </div>
                <br />
                <br />
                <asp:GridView ID="GVUsuarios" runat="server" CellPadding="3" GridLines="Horizontal"
                    BorderColor="#507CBB" BorderStyle="None" AutoGenerateColumns="False" ForeColor="Black"
                    AllowPaging="true" PageSize="100">
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="Usuario" ItemStyle-Wrap="False">
                            <ItemStyle />
                        </asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Wrap="False">
                            <ControlStyle Font-Bold="True" ForeColor="Red" />
                            <ItemStyle />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Rol">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LblRol" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="IsOnline" HeaderText="Online" />
                        <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Bloqueado" />
                        <asp:TemplateField ShowHeader="False" Visible="false">
                            <ItemTemplate>
                                <asp:Button ID="ButAssign" runat="server" CausesValidation="False" CommandArgument='<%# Bind("UserName") %>'
                                    CssClass="button-link" OnCommand="ButAssign_Command" PostBackUrl="~/Admin/AsignarEmpresa.aspx"
                                    Text="Asignar" />
                            </ItemTemplate>
                            <ControlStyle CssClass="but" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Editar">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Button ID="ButEditar" runat="server" CommandArgument='<%# Bind("UserName") %>'
                                    CssClass="but" OnCommand="ButEditar_Command" Text="Editar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Eliminar">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Button ID="ButEliminar" runat="server" CausesValidation="False" CommandArgument='<%# Bind("UserName") %>'
                                    CssClass="but" OnClientClick="javascript: return confirm('Desea eliminar el usuario?')"
                                    OnCommand="ButEliminar_Command" Text="Eliminar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Desbloquear">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Button ID="ButDesbloquear" runat="server" CommandArgument='<%# Bind("UserName") %>'
                                    CssClass="but" OnCommand="ButDesbloquear_Command" Text="Desbloquear" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="ButResetearPass" runat="server" CommandArgument='<%# Bind("UserName") %>'
                                    CssClass="but" OnCommand="ButResetearPass_Command" Text="Resetear contraseña" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="header" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <script>
            //            $(".selector").dialog({ modal: true });
            // http: //docs.jquery.com/UI/API/1.8/Dialog
            $(document).ready(function () {
                // $("#dialog").dialog();
            });


            function ClickSaveButton() {
                $("#Button3").click();
                //                var _id = $('a[id$="Button3"]').attr("ID");
                //                __doPostBack(_id.replace("_", "$"), '');
            }

        </script>
        <asp:Button ID="Button2" runat="server" Visible="true" Style="visibility: hidden" />
        <asp:Panel ID="Panel1" runat="server" Height="" Width="" BorderColor="Transparent"
            DefaultButton="btnOk" CssClass="modalPopup" Style="vertical-align: middle; text-align: center"
            ForeColor="">
            Nueva contraseña
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="CssTextBox"
                TabIndex="1" Width="">
            </asp:TextBox><br /><br />
            Confirmar contraseña
            <asp:TextBox ID="txtPassConfirmar" runat="server" TextMode="Password" CssClass="CssTextBox"
                TabIndex="1" Width="">
            </asp:TextBox><br /><br />
            <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" CausesValidation="False"
                CssClass="but" />
            <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" CssClass="butcancela" />
        </asp:Panel>
        <%-- (podes sacar los updatepanel. lo importante para que haga postback es sacar el OkControlID--%>
        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button2"
            BehaviorID="myMPEBID" PopupControlID="Panel1" BackgroundCssClass="modalBackground"
            DropShadow="false" PopupDragHandleControlID="Panel1" CancelControlID="btnCancelarLibero">
        </cc1:ModalPopupExtender>
        <div style="text-align: right; visibility: hidden">
            Contraseña default
            <asp:TextBox runat="server" ID="txtPassReset" TextMode="Password"></asp:TextBox>
            <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                TargetControlID="txtPassReset" WatermarkText="Contraseña" WatermarkCssClass="" />
        </div>
        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
            <ProgressTemplate>
                <img src="../ProntoWeb/Imagenes/25-1.gif" alt="" style="height: 26px" />
                <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                    Visible="true"></asp:Label>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>
