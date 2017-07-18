<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="ListasPrecios.aspx.vb" Inherits="ListasPrecios" Title="Listas de precios" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="padding: 0px; border: none #FFFFFF; width: 696px; margin-right: 0px;"
        cellpadding="1" cellspacing="1">
        <tr>
            <td colspan="3" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF; font-size: large; height: 34px;"
                align="left" valign="top">LISTAS DE PRECIOS
                <asp:Label ID="lblAnulado0" runat="server" BackColor="#CC3300" BorderColor="White"
                    BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="Large" ForeColor="White"
                    Style="text-align: center; margin-left: 0px; vertical-align: top" Text=" ANULADO "
                    Visible="False" Width="120px"></asp:Label>
            </td>
            <td class="EncabezadoCell" style="height: 34px;" valign="top" align="right" colspan="3">
                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                        <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="true"></asp:Label>
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
    <%--/////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////////        
        GRILLA GENERICA DE EDICION DIRECTA!!!!
        http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    /////////////////////////////////////////////////////////////////////////        
    /////////////////////////////////////////////////////////////////////--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                Visible="False"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;&nbsp;     &nbsp;&nbsp;&nbsp;&nbsp;    
            <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True" Width="300px"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscar"
                WatermarkText="Buscar cliente" WatermarkCssClass="watermarked" />
            <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right; margin-left: 0px;"
                Width="119px" Height="22px" Visible="False">
                <asp:ListItem Text="Numero" Value="Numero" />
                <asp:ListItem Text="Fecha" Value="[Fecha]" />
                <asp:ListItem Text="Recibido" Value="[Recibido]" />
                <asp:ListItem Text="Entregado" Value="[Entregado]" />
                <asp:ListItem Text="Impresa" Value="[Impresa]" />
                <asp:ListItem Text="Detalle" Value="[Detalle]" />
                <asp:ListItem Text="Cant.Items" Value="[Cant_Items]" />
                <asp:ListItem Text="Liberada por" Value="[Liberada por]" />
            </asp:DropDownList>

            <br />
            <asp:GridView ID="gvMaestro" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                DataKeyNames="IdListaPrecios" AllowPaging="True" PageSize="6" Font-Size="Medium">
                <%--                OnRowDataBound="gvDetalle_RowDataBound" 
                OnRowCancelingEdit="gvDetalle_RowCancelingEdit"
                OnRowEditing="gvDetalle_RowEditing" 
                OnRowUpdating="gvDetalle_RowUpdating" 
                OnRowCommand="gvDetalle_RowCommand"
                OnRowDeleting="gvDetalle_RowDeleting" 
                --%>
                <Columns>

                    <asp:TemplateField Visible="false">
                        <HeaderTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </HeaderTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                            --%>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--                    <asp:CommandField ShowEditButton="True" />
                    --%>
                    <asp:CommandField HeaderText="" ShowSelectButton="True" ShowHeader="True" SelectText="Elegir" DeleteText="Borrar" />
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Aplicar"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="AddNew"
                                Text="Agregar"></asp:LinkButton>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Editar"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Lista">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Eval("Descripcion") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewDescripcion" runat="server">
                            </asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Vigencia">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFechaVigencia" runat="server" Text='<%# Eval("FechaVigencia")%>'></asp:TextBox>

                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaVigencia"
                                Enabled="True">
                            </cc1:CalendarExtender>


                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFechaVigencia" runat="server" Text='<%# Eval("FechaVigencia")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewFechaVigencia" runat="server">
                            </asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>



                    <%-- --%>
                    <%-- --%>
                    <%-- --%>
                    <asp:CommandField HeaderText="" ShowDeleteButton="True" ShowHeader="True" DeleteText="Borrar" />
                    <asp:BoundField DataField="IdListaPrecios" HeaderText="Código" />
                    <%--                    <asp:ButtonField ButtonType="Link" CommandName="Excel" Text="Excel" ItemStyle-HorizontalAlign="Center"
                        ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                        <ControlStyle Font-Size="Small" Font-Underline="True" />
                        <ItemStyle Font-Size="X-Small" />
                        <HeaderStyle Width="40px" />
                    </asp:ButtonField>--%>
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <br />
            <asp:Label ID="lblAlerta" runat="server" CssClass="Alerta" Font-Size="small"></asp:Label>


            <br />
            <br />
            <div style="color: White">
                <%--Detalle de precios--%>
            </div>


            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
            <asp:TextBox ID="txtBuscarDetalleDestino" runat="server" Style="text-align: right;" Text="" AutoPostBack="True" Width="300px"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtBuscarDetalleDestino"
                WatermarkText="Buscar destino" WatermarkCssClass="watermarked" />

            <asp:TextBox ID="txtBuscarDetalleArticulo" runat="server" Style="text-align: right;" Text="" AutoPostBack="True" Width="300px"></asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtBuscarDetalleArticulo"
                WatermarkText="Buscar producto" WatermarkCssClass="watermarked" />

            <br />


            <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False" ShowFooter="True"
                DataKeyNames="IdListaPreciosDetalle" Width="900px" Font-Size="10">
                <%--                OnRowDataBound="gvDetalle_RowDataBound" 
                OnRowCancelingEdit="gvDetalle_RowCancelingEdit"
                OnRowEditing="gvDetalle_RowEditing" 
                OnRowUpdating="gvDetalle_RowUpdating" 
                OnRowCommand="gvDetalle_RowCommand"
                OnRowDeleting="gvDetalle_RowDeleting" 
                --%>
                <Columns>
                    <asp:TemplateField Visible="false">
                        <HeaderTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </HeaderTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="hCheckBox1" runat="server" />
                            <%--                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ColumnaTilde") %>'></asp:TextBox>
                            --%>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            <%--Checked='<%# Eval("ColumnaTilde") %>' />--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--                    <asp:CommandField ShowEditButton="True" />
                    --%>
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Aplicar"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="AddNew"
                                Text="Agregar"></asp:LinkButton>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Editar"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lista" Visible="false">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbLista" runat="server">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLista" runat="server" Text='<%# Eval("IdListaPrecios") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewLista" runat="server">
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Destino">

                
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDestino" runat="server" autocomplete="off" CssClass="CssTextBox"
                                Text='<%# Bind("DestinoDesc") %>' TabIndex="23" Width="300px"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender28" runat="server"
                                CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDestinoDeCartaDePorte" runat="server" Width="300px" Text='<%# Eval("DestinoDesc") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewDestino" runat="server" autocomplete="off" CssClass="CssTextBox"
                                TabIndex="23" Width="300px"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender8" runat="server"
                                CompletionSetCount="12" TargetControlID="txtNewDestino" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Producto">

                        <%--         <HeaderTemplate>
                            <asp:TextBox ID="txtBuscarDetalleArticulo" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"></asp:TextBox>

                        </HeaderTemplate>--%>

                        <EditItemTemplate>
                            <asp:DropDownList ID="cmbArticulo" runat="server" Width="150px">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblArticulo" runat="server" Width="150px" Text='<%# Eval("Producto") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="cmbNewArticulo" runat="server" Width="150px">
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>

                    
                       <asp:TemplateField HeaderText="Cliente">

                
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCliente" runat="server" autocomplete="off" CssClass="CssTextBox"
                                Text='<%# Bind("RazonSocial")%>' TabIndex="23" Width="300px"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender29" runat="server"
                                CompletionSetCount="12" TargetControlID="txtCliente" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblClienteDeCartaDePorte" runat="server" Width="300px" Text='<%# Eval("RazonSocial")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewCliente" runat="server" autocomplete="off" CssClass="CssTextBox"
                                TabIndex="23" Width="300px"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender9" runat="server"
                                CompletionSetCount="12" TargetControlID="txtNewCliente" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceClientes.asmx"
                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </FooterTemplate>
                    </asp:TemplateField>




                    <asp:TemplateField HeaderText="Precio">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecio" Width="40px" runat="server" Text='<%# Bind("PrecioRepetidoPeroConPrecision","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecio" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecio" Width="40px" runat="server" Text='<%# Bind("PrecioRepetidoPeroConPrecision","{0:F3}")  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Export">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioExportacion","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioExportacion" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioExportacion","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Buques">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioEmbarque" Width="40px" runat="server" Text='<%# Bind("PrecioEmbarque","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioEmbarque" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioEmbarque" Width="40px" runat="server" Text='<%# Bind("PrecioEmbarque","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Precio Buques despues de corte">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioEmbarque2" Width="40px" runat="server" Text='<%# Bind("PrecioEmbarque2","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioEmbarque2" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioEmbarque2" Width="40px" runat="server" Text='<%# Bind("PrecioEmbarque2","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Corte Buques">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMaximaCantidadParaPrecioEmbarque" Width="40px" runat="server" Text='<%# Bind("MaximaCantidadParaPrecioEmbarque","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewMaximaCantidadParaPrecioEmbarque" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMaximaCantidadParaPrecioEmbarque" Width="40px" runat="server" Text='<%# Bind("MaximaCantidadParaPrecioEmbarque","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

            

                    <asp:TemplateField HeaderText="Calada Buques">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioCaladaBuques" Width="40px" runat="server" Text='<%# Bind("PrecioBuquesCalada", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioCaladaBuques" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioCaladaBuques" Width="40px" runat="server" Text='<%# Bind("PrecioBuquesCalada", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Calada Local">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioCaladaLocal" Width="40px" runat="server" Text='<%# Bind("PrecioCaladaLocal","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioCaladaLocal" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioCaladaLocal" Width="40px" runat="server" Text='<%# Bind("PrecioCaladaLocal","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Calada Exp">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioCaladaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioCaladaExportacion","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioCaladaExportacion" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioCaladaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioCaladaExportacion","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descarga Local">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioDescargaLocal" Width="40px" runat="server" Text='<%# Bind("PrecioDescargaLocal","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioDescargaLocal" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioDescargaLocal" Width="40px" runat="server" Text='<%# Bind("PrecioDescargaLocal","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Descarga Exp">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioDescargaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioDescargaExportacion","{0:F3}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioDescargaExportacion" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioDescargaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioDescargaExportacion","{0:F3}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>







                    <asp:TemplateField HeaderText="Calada Vagón">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioVagonesCalada" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesCalada", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioVagonesCalada" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioVagonesCalada" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesCalada", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Descarga Vagón">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioVagonesBalanza" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesBalanza", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioVagonesBalanza" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioVagonesBalanza" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesBalanza", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Calada Vagón Export">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioVagonesCaladaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesCaladaExportacion", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioVagonesCaladaExportacion" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioVagonesCaladaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesCaladaExportacion", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Descarga Vagón Export">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioVagonesBalanzaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesBalanzaExportacion", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioVagonesBalanzaExportacion" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioVagonesBalanzaExportacion" Width="40px" runat="server" Text='<%# Bind("PrecioVagonesBalanzaExportacion", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Calada + Descarga">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrecioComboCaladaMasBalanza" Width="40px" runat="server" Text='<%# Bind("PrecioComboCaladaMasBalanza", "{0:F3}")%>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNewPrecioComboCaladaMasBalanza" Width="40px" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrecioComboCaladaMasBalanza" Width="40px" runat="server" Text='<%# Bind("PrecioComboCaladaMasBalanza", "{0:F3}")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                                        

                    <%-- --%>
                    <%-- --%>
                    <%-- --%>
                    <asp:CommandField HeaderText="" ShowDeleteButton="true" ShowHeader="True" />
                    <%--                    <asp:ButtonField ButtonType="Link" CommandName="Excel" Text="Excel" ItemStyle-HorizontalAlign="Center"
                        ImageUrl="~/Imagenes/action_delete.png" CausesValidation="true" ValidationGroup="Encabezado">
                        <ControlStyle Font-Size="Small" Font-Underline="True" />
                        <ItemStyle Font-Size="X-Small" />
                        <HeaderStyle Width="40px" />
                    </asp:ButtonField>--%>
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <FooterStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
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
    <br />
    <br />
    <asp:Panel ID="Panel1" runat="server">
        Importar excel
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

                //var f = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia");
                //f.click();
            }

        </script>
        <hr />
    </asp:Panel>
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
