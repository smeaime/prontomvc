<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="CartasDePorteReasignarImagenListado, App_Web_inm4yq2m" title="Imagenes pendientes" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table style="padding: 0px; border: none #FFFFFF; width: 700px; height: 62px; margin-right: 0px;"
        cellpadding="3" cellspacing="3">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF; font-size: medium; height: 37px;"
                align="left" valign="top">

                 <div class="titulos">
                    Imágenes de Carta Porte
                </div>

                <%--<asp:Label ID="lblTitulo" ForeColor="" runat="server" Text=""
                    Font-Size="Large" Height="22px" Width="356px" Font-Bold="True"></asp:Label>--%>
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

    <asp:LinkButton ID="LinkAgregarRenglon" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Width="95px"
        Style="margin-top: 0px" Visible="False">+   Nuevo</asp:LinkButton>
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="false" Font-Underline="True"
        ForeColor="White" CausesValidation="true" Font-Size="Small" Height="30px" Visible="False">Exportar a Excel</asp:LinkButton>
    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right; margin-left: 50px; margin-top: 10px;"
        Text="" AutoPostBack="True" Visible="false"></asp:TextBox>
    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right; margin-left: 0px;"
        Width="119px" Height="22px" Visible="false">
        <asp:ListItem Text="Destino" Value="Descripcion" />
        <asp:ListItem Text="Sub 1" Value="Subcontratista1Desc" />
        <asp:ListItem Text="Sub 2" Value="Subcontratista2Desc" />
    </asp:DropDownList>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <div style="color: White; font-size: medium">

    </div>
    
<%--    Formato multipágina--%>
     <asp:DropDownList ID="cmbFormatoMultipagina" runat="server" Style="text-align: right; margin-left: 0px;"
        Width="119px" Height="22px" Visible="false" >
        <asp:ListItem Text="CP-TK" Value="" Selected="True" />
        <asp:ListItem Text="CP-CP" Value="" />
    </asp:DropDownList>
    <br />
    <asp:FileUpload ID="FileUpload1" runat="server" Font-Size="22" BackColor="White" ForeColor="black" />
    <asp:Button ID="Button1" runat="server" Text="Subir como CP-TK" OnClick="Button1_Click" Font-Size="22" />
    <asp:Button ID="Button6" runat="server" Text="Subir sin orden" OnClick="Button6_Click" Font-Size="22" />

    <script>
        $(document).ready(
        function () {
            //http://stackoverflow.com/questions/4056336/disable-submit-button-until-file-selected-for-upload
            $('ctl00_ContentPlaceHolder1_FileUpload1').change(
                function () {
                    if ($(this).val()) {
                        $('ctl00_ContentPlaceHolder1_Button1').attr('disabled', false);
                        $('ctl00_ContentPlaceHolder1_Button6').attr('disabled', false);
                        // or, as has been pointed out elsewhere:
                        // $('input:submit').removeAttr('disabled'); 
                    }
                }
                );
        });

    </script>

    <hr />

    <br />
    <br />
    <br />
    <br />


    <asp:Button ID="Button4" runat="server" Text="Descargar Pegatina generada" Visible="false" />

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>


            <asp:Button ID="Button3" runat="server" Text="Refrescar" Font-Size="18" />
            &nbsp;&nbsp;&nbsp;
            Punto de venta <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="60px" />
            <br />
            <asp:Label ID="lblCantidad" runat="server" Font-Size="14"></asp:Label>
            <asp:Button ID="Button5" runat="server" Text="parar servicio" Font-Size="14" Visible="false" />
            
            <br /><br />
            <table>

                <tr>

                    <td valign="top">
                        <asp:GridView ID="grillaProcesadas" runat="server" AutoGenerateColumns="False" ShowFooter="false"
                            AllowPaging="True" AllowSorting="True" PageSize="100"
                            HeaderStyle-Wrap="true">

                            <Columns>

                                <asp:TemplateField HeaderText="VÁLIDAS">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCodigoPostal" Width="" runat="server" Text='<%# Bind("FullName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtNewCodigoPostal" Width="" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCartaDePorte")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>



                                <asp:TemplateField HeaderText="usuario">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink1133" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("UsuarioModifico")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="hora">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCodigoPosta222l" Width="" runat="server" Text='<%# Bind("LastWriteTime")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtNewCodigoPos222tal" Width="" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemTemplate>


                                              <asp:HyperLink ID="HyperLink3522" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("FechaModificacion", "{0:HH:mm ddd d}")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>

                                        
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>




                            </Columns>
                            <EmptyDataTemplate>Ninguna carta procesada</EmptyDataTemplate>
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                    </td>
                    <td></td>
                    <td valign="top">
                        <asp:GridView ID="grillaIrreconocibles" runat="server" AutoGenerateColumns="False" ShowFooter="false"
                            AllowPaging="True" AllowSorting="True" PageSize="100"
                            HeaderStyle-Wrap="true">

                            <Columns>

                                <asp:TemplateField HeaderText="INVÁLIDAS">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCodigoPostal" Width="" runat="server" Text='<%# Bind("FullName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtNewCodigoPostal" Width="" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCarta")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>

                                
                                <asp:TemplateField HeaderText="titular" Visible="false">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink145451" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCarta")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="chofer" Visible="false">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink13451" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCarta")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>

                                  <asp:TemplateField HeaderText="numero" Visible="false">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink158701" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCarta")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="subida por" Visible="false">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink58611" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("NumeroCarta")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>


                                
                                <asp:TemplateField HeaderText="usuario">
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink1133" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("TextoAux1")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="hora">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCodigoPosta222l" Width="" runat="server" Text='<%# Bind("LastWriteTime")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtNewCodigoPos222tal" Width="" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLi222nk1" Target='_blank' runat="server" NavigateUrl='<%# "CartaDePorte.aspx?Id=" & Eval("IdCartaDePorte")%>'
                                            Text='<%# Eval("Fecha", "{0:HH:mm ddd d}")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>




                            </Columns>
                            <EmptyDataTemplate>sin datos</EmptyDataTemplate>

                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>

                    </td>
                    <td></td>
                    <td valign="top">
                        <asp:GridView ID="grillaEncoladas" runat="server" AutoGenerateColumns="False" ShowFooter="false"
                            AllowPaging="True" AllowSorting="True" PageSize="100"
                            HeaderStyle-Wrap="true">

                            <Columns>

                                <asp:TemplateField HeaderText="EN COLA">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCodigoPostal" Width="" runat="server" Text='<%# Bind("FullName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtNewCodigoPostal" Width="" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemTemplate>

                                        <asp:HyperLink ID="HyperLink1" Target='_blank' runat="server" NavigateUrl='<%# "CartasDePorteReasignarImagen.aspx?Id=" & Eval("nombre")%>'
                                            Text='<%# Eval("nombre")%>' Font-Size="Small" Font-Bold="True"
                                            Font-Underline="false" Style="vertical-align: middle;"> </asp:HyperLink>
                                        <br />

                                    </ItemTemplate>
                                </asp:TemplateField>







                            </Columns>
                            <EmptyDataTemplate>Ninguna carta en cola</EmptyDataTemplate>

                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                    </td>
                    <td></td><td></td><td></td>
                    <td valign="top">Lotes procesados<br />
                        <asp:Label ID="Pegatinas" runat="server" Font-Size="12"></asp:Label>
                        <br />
                    </td>
                </tr>

            </table>
            <br />
            <br />



            <%--//////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
            <%--    datasource de grilla principal--%>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.ComparativaManager" DeleteMethod="Delete"
                UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <%--            <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="cmbCuenta" Name="IdProveedor" PropertyName="SelectedValue" Type="Int32" />--%>
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <%--    esta es el datasource de la grilla que está adentro de la primera? -sí --%>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItemsParaGrilla" TypeName="Pronto.ERP.Bll.ComparativaManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myComparativa" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:Button ID="Button2" runat="server" Text="Mandar factura electronica" Visible="False" />
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <%--    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////--%>
    <span>
        <%--<div>--%>
        <%--botones de alta y excel--%>
        <%--</div>--%>
    </span>
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
    RESUMEN DE SALDO
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <%--combo para filtrar cuenta--%>
    <table style="width: 503px; margin-right: 0px; height: 122px; visibility: hidden;">
        <tr>
            <td style="width: 132px; height: 32px;">
                <asp:Label ID="Label15" runat="server" Text="Filtrar por Cuenta" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 32px;">
                <asp:DropDownList ID="cmbCuenta" runat="server" Width="218px" AutoPostBack="True"
                    Height="22px" Style="margin-left: 0px" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label2" runat="server" Text="Reposicion Solicitada" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtReposicionSolicitada" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label4" runat="server" Text="Fondos asignados" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtTotalAsignados" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 132px">
                <asp:Label ID="Label5" runat="server" Text="Pendientes de reintegrar" ForeColor="White"
                    Width="145px" Height="16px"></asp:Label>
            </td>
            <td style="width: 197px">
                <asp:Label ID="txtPendientesReintegrar" runat="server" Width="80px" ForeColor="White" />
            </td>
        </tr>
        <tr>
            <td style="width: 132px; height: 20px;">
                <asp:Label ID="Label6" runat="server" Text="SALDO" ForeColor="White"></asp:Label>
            </td>
            <td style="width: 197px; height: 20px;">
                <asp:Label ID="txtSaldo" runat="server" Width="80px" ForeColor="White"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 27px" />
        </tr>
    </table>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
