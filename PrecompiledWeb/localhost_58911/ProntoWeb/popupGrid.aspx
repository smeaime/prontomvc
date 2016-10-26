<%@ page language="VB" autoeventwireup="false" inherits="popupGrid, App_Web_ybmx5aia" theme="Azul" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link id="Link1" href="../Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />
</head>
<body style="width: 99%; height: 95%">
    <%--class="bodyMasterPage">--%>
    <%--style="margin: 0; background-color: #507CBB; height: 100%; width: 100%; background-repeat: repeat-x;
    background-attachment: scroll;">--%>
    <form id="form1" runat="server" style="width: 99%; height: 99%; overflow: auto">
    <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
        EnablePageMethods="False" AsyncPostBackTimeout="360000">
        <Services>
            <%--COMBINAR EN UN SOLO SCRIPT?--%>
            <%--http://p2p.wrox.com/content/articles/aspnet-35-ajax-script-combining--%>
            <%--para usarlo en con Master/Content, usa <asp:ScriptManagerProxy>--%>
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceArticulos.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceProveedores.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceClientes.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceLocalidades.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceChoferes.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceTransportistas.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceVendedores.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceWilliamsDestinos.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceCalidades.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceSuperbuscador.asmx" />
        </Services>
        <%--                        <CompositeScript>
                            <Scripts>
                                <asp:ScriptReference Name="”MicrosoftAjax.js”" />
                                <asp:ScriptReference Name="”MicrosoftAjaxWebForms.js”" />
                            </Scripts>
                        </CompositeScript>--%>
    </ajaxToolkit:ToolkitScriptManager>
    <script language="javascript">
        function GetRowValue(val) {

            // Esto se encarga de devolverle el dato a la ventana que lo abrió

            // http: //wiki.asp.net/page.aspx/282/passing-value-from-popup-window-to-parent-form39s-textbox/
            // hardcoded value used to minimize the code.
            // ControlID can instead be passed as query string to the popup window
            window.opener.document.getElementById("ctl00_ContentPlaceHolder1_txtPopupRetorno").value = val;

            //var o=window.opener.document.getElementById("ctl00_ContentPlaceHolder1_txtPopupRetorno");
            //alert('ss');

            window.opener.__doPostBack('ctl00_ContentPlaceHolder1_txtPopupRetorno', '');


            window.close();

        }
    </script>
    <div style="width: 99%; height: 100%; overflow: auto">
        <asp:Panel ID="PopupGrillaSolicitudes" runat="server" Height="85%" Width="100%">
            <%-- CssClass="modalPopup">--%>
            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                <ContentTemplate>
                    <asp:TextBox ID="txtBuscaGrillaImputaciones" runat="server" CssClass="txtBuscar"
                        Text="" AutoPostBack="true"></asp:TextBox>
                    <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtBuscaGrillaImputaciones"
                        WatermarkText="Buscar" WatermarkCssClass="watermarkedBuscar" />
                    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                        margin-left: 0px;" Width="119px" Height="26px">
                        <asp:ListItem Text="Numero" Value="NumeroRequerimiento" />
                        <asp:ListItem Text="Cant.Items" Value="[Cant_Items]" />
                        <asp:ListItem Text="Artículo" Value="Articulo" />
                        <asp:ListItem Text="Recibido" Value="[Recibido]" />
                        <asp:ListItem Text="Fecha" Value="F_entrega" />
                        <asp:ListItem Text="Entregado" Value="[Entregado]" />
                        <asp:ListItem Text="Impresa" Value="[Impresa]" />
                        <asp:ListItem Text="Liberada por" Value="[Liberada por]" />
                        <asp:ListItem Text="Solicitada por" Value="[Solicitada por]" />
                        <asp:ListItem Text="Obra" Value="[Obra]" />
                        <asp:ListItem Text="Sector" Value="[Sector]" />
                        <asp:ListItem Text="Origen" Value="[Origen]" />
                        <asp:ListItem Text="Equipo destino" Value="[Equipo destino]" />
                        <asp:ListItem Text="Anulo" Value="[Anulo]" />
                        <asp:ListItem Text="Fecha anulacion" Value="[Fecha anulacion]" />
                        <asp:ListItem Text="Motivo anulacion" Value="[Motivo anulacion]" />
                        <asp:ListItem Text="Tipo compra" Value="[Tipo compra]" />
                        <asp:ListItem Text="2da.Firma" Value="[2da_Firma]" />
                        <asp:ListItem Text="Fecha 2da.Firma" Value="[Fecha 2da_Firma]" />
                        <asp:ListItem Text="Comprador" Value="[Comprador]" />
                        <asp:ListItem Text="Importada por" Value="[Importada por]" />
                        <asp:ListItem Text="Fec.llego SAT" Value="[Fec_llego SAT]" />
                        <asp:ListItem Text="Fechas de liberacion" Value="[Fechas de liberacion para compras por item]" />
                        <asp:ListItem Text="Detalle imputacion" Value="[Detalle imputacion]" />
                        <asp:ListItem Text="Observaciones" Value="[Observaciones]" />
                        <asp:ListItem Text="Elim.Firmas" Value="[Elim_Firmas]" />
                    </asp:DropDownList>
                    <asp:DropDownList ID="ListBox2" runat="server" Height="26px" CssClass="cssComboBox"
                        Visible="false">
                        <asp:ListItem>Detallado RM</asp:ListItem>
                        <asp:ListItem>Resumido RM</asp:ListItem>
                        <asp:ListItem>Detallado LA</asp:ListItem>
                        <asp:ListItem>Resumido LA</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ListBox1" runat="server" Height="26px" CssClass="cssComboBox">
                        <asp:ListItem>Pendiente </asp:ListItem>
                        <asp:ListItem>Todos</asp:ListItem>
                        <asp:ListItem>A la firma</asp:ListItem>
                    </asp:DropDownList>
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 16px" />
                            <asp:Label ID="Label342" runat="server" Text="Cargando..." Visible="true"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <br />
                    <br />
                    <div id="columns">
                        <div class="column" draggable="true">
                            <header>A</header>
                        </div>
                        <div class="column" draggable="true">
                            <header>B</header>
                        </div>
                        <div class="column" draggable="true">
                            <header>C</header>
                        </div>
                    </div>
                    <div style="width: 100%; height: 70%; overflow: auto" align="">
                        <asp:GridView ID="gvAuxPendientesImputar" runat="server" AutoGenerateColumns="false"
                            BackColor="White" BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px"
                            CellPadding="3" DataSourceID="ObjectDataSource2" GridLines="Horizontal" AllowPaging="True"
                            Height="68%" CssClass="grillaListado" Width="95%" PageSize="8" RowStyle-Wrap="False"
                            DataKeyNames="Id">
                            <%--    <FooterStyle CssClass="FooterStyle" Wrap="False" />--%>
                            <Columns>
                                <%--<asp:CommandField ShowSelectButton="true" />--%>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                                    SortExpression="Id" Visible="False" />
                                <asp:TemplateField HeaderText="" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <div class="column" draggable="true">
                                            <header>::</header>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-Wrap="false">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" />
                                        <%--Text='<%# Bind("ColumnaTilde") %>'>    no usar columnatilde, uso el keepselection   --%>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" />
                                        <%--Checked='<%# Eval("ColumnaTilde") %>' no usar columnatilde, uso el keepselection--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="NumeroRequerimiento" HeaderText="n° req" />
                                <asp:BoundField DataField="Item" HeaderText="item" />
                                <asp:BoundField DataField="Cant_" HeaderText="Cant." />
                                <asp:BoundField DataField="Unidad_en" HeaderText="Un." />
                                <asp:BoundField DataField="Articulo" HeaderText="" />
                                <asp:BoundField DataField="CantidadRecibida" HeaderText="Recibido" />
                                <asp:BoundField DataField="F_entrega" HeaderText="F.entrega" />
                                <asp:BoundField DataField="Cump" HeaderText="Cump." />
                                <asp:BoundField DataField="Obra" HeaderText="Obra" />
                                <%--<asp:BoundField  DataField="CantidadPedida" HeaderText="Cant.Ped." />
                                 <asp:BoundField DataField="CantidadVales" HeaderText="Vales" />--%>
                                <asp:BoundField DataField="MontoPrevisto" HeaderText="Monto prev." />
                                <asp:BoundField DataField="MontoParaCompra" HeaderText="Monto comp." />
                                <asp:BoundField DataField="Comprador" HeaderText="Comprador" />
                                <asp:BoundField DataField="NumeroLMateriales" HeaderText="L.Mat." />
                                <asp:BoundField DataField="NumeroOrden" HeaderText="Itm.LM" />
                                <asp:BoundField DataField="CantidadEnStock" HeaderText="En stock" />
                                <%--   <asp:BoundField DataField="StockMinimo" HeaderText="Stk.min." />--%>
                                <asp:BoundField DataField="F_entrega" HeaderText="F.entrega" />
                                <asp:BoundField DataField="Solicitada_por" HeaderText="Solicito" />
                                <asp:BoundField DataField="Equipo_destino" HeaderText="Equipo" />
                                <%-- <asp:BoundField DataField="Descripcion" HeaderText="Cuenta contable" />--%>
                                <asp:BoundField DataField="Observaciones" HeaderText="Observaciones item" />
                                <asp:BoundField DataField="FechaAsignacionComprador" HeaderText="[Fec.Asig.Comprador]" />
                                <asp:BoundField DataField="Observaciones" HeaderText="Tipo compra" />
                                <asp:BoundField DataField="_2da_Firma" HeaderText="[2da.Firma" />
                                <%--   <asp:BoundField DataField="Nombre" HeaderText="Fecha 2da.Firma" />
                                <asp:BoundField DataField="Descripcion" HeaderText="Sector" />
                                <asp:BoundField DataField="Item" HeaderText="OT/OP" />--%>
                                <%--            
                                <asp:BoundField DataField="Tipo valor"  HeaderText="Id" />	
                                                                <asp:BoundField DataField="Nro_Int_"  HeaderText="n°Int" />	
                                <asp:BoundField DataField="Numero" HeaderText="Numer"  />	
                                <asp:BoundField DataField="Fecha Vto_"  HeaderText="Vence" />	
                                <asp:BoundField DataField="Mon_" HeaderText=""   ItemStyle-HorizontalAlign=Right/>
                                <asp:BoundField DataField="Importe"  HeaderText="Importe"  ItemStyle-HorizontalAlign=Right/>
                                <asp:BoundField DataField="Banco origen" HeaderText="Banco"  />	
                                <asp:BoundField DataField="Comp_" HeaderText="Cmpbte"  />	
                                <asp:BoundField DataField="Nro_Comp_"  HeaderText="n°Cmpbte" />	
                                <asp:BoundField DataField="Fec_Comp_"  HeaderText="Fecha Cmpbte" />	
                                <asp:BoundField DataField="Cliente" HeaderText="Cliente"  />--%>
                            </Columns>
                            <%--     <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" Wrap="False" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />--%>
                        </asp:GridView>
                        <asp:HiddenField ID="HiddenIdGrillaPopup" runat="server" />
                        <%--//////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////--%>
                        <%--    datasource de grilla principal--%>
                        <%-- TypeName="Pronto.ERP.Bll.PedidoManager" 
                            SelectMethod="GetListDataset"
                            SelectCountMethod="GetTotalNumberOfPedidos"--%>
                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                            DeleteMethod="Delete" UpdateMethod="Save" EnableViewState="False" StartRowIndexParameterName="startRowIndex"
                            EnablePaging="true" MaximumRowsParameterName="maximumRows">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                                <asp:ControlParameter ControlID="txtBuscaGrillaImputaciones" Name="txtBuscar" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="cmbBuscarEsteCampo" Name="cmbBuscarEsteCampo" PropertyName="Text"
                                    Type="String" />
                                <asp:Parameter Name="fDesde" Type="DateTime" />
                                <asp:Parameter Name="fHasta" Type="DateTime" />
                                <asp:ControlParameter ControlID="ListBox1" Name="param1" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="ListBox2" Name="param2" PropertyName="Text" Type="String" />
                                <%--         <asp:ControlParameter ControlID="HFIdObra" Name="IdObra" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HFTipoFiltro" Name="TipoFiltro" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="cmbCuenta" Name="IdProveedor" PropertyName="SelectedValue" Type="Int32" />--%>
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myPedido" Type="Object" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="SC" Type="String" />
                                <asp:Parameter Name="myPedido" Type="Object" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:HiddenField ID="HFIdObra" runat="server" />
                        <asp:HiddenField ID="HFTipoFiltro" runat="server" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <asp:Button ID="btnSaveItemImputacionAux" runat="server" Font-Size="Small" Text="Aceptar"
                CssClass="but" UseSubmitBehavior="False" Width="82px" Height="25px" CausesValidation="False" />
            <asp:Button ID="Button4" runat="server" Font-Size="Small" Text="Cancelar" CssClass="butcancela"
                UseSubmitBehavior="False" Style="margin-left: 28px; margin-right: 14px" Font-Bold="False"
                Height="25px" CausesValidation="False" Width="78px" Visible="false" />
        </asp:Panel>
        <asp:HiddenField ID="HFSC" runat="server" />
    </div>
    </form>
    <script>

        //    drag and drop
        //    http://www.html5rocks.com/en/tutorials/dnd/basics/

        //        if (Modernizr.draganddrop) {
        //            // Browser supports HTML5 DnD.
        //        } else {
        //            // Fallback to a library solution.
        //        }



        function handleDragStart(e) {
            // Target (this) element is the source node.
            this.style.opacity = '0.4';

            //this.opener.dragSrcEl = this;
            dragSrcEl = this;

            e.dataTransfer.effectAllowed = 'move';
            e.dataTransfer.setData('text/html', this.innerHTML);
        }

        function handleDragOver(e) {
            if (e.preventDefault) {
                e.preventDefault(); // Necessary. Allows us to drop.
            }

            e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.

            return false;
        }

        function handleDragEnter(e) {
            // this / e.target is the current hover target.
            this.classList.add('over');
        }

        function handleDragLeave(e) {
            this.classList.remove('over');  // this / e.target is previous target element.
        }





        function handleDrop(e) {
            // this/e.target is current target element.

            if (e.stopPropagation) {
                e.stopPropagation(); // Stops some browsers from redirecting.
            }

            // Don't do anything if dropping the same column we're dragging.
            if (dragSrcEl != this) {
                // Set the source column's HTML to the HTML of the column we dropped on.
                dragSrcEl.innerHTML = this.innerHTML;
                this.innerHTML = e.dataTransfer.getData('text/html');
            }

            return false;
        }


        function handleDragEnd(e) {
            // this/e.target is the source node.

            [ ].forEach.call(cols, function (col) {
                col.classList.remove('over');
            });
        }

        var cols = document.querySelectorAll('#columns .column');
        [ ].forEach.call(cols, function (col) {
            col.addEventListener('dragstart', handleDragStart, false);
            col.addEventListener('dragenter', handleDragEnter, false)
            col.addEventListener('dragover', handleDragOver, false);
            col.addEventListener('dragleave', handleDragLeave, false);
            col.addEventListener('drop', handleDrop, false);
            col.addEventListener('dragend', handleDragEnd, false);
        });


    </script>
</body>
</html>
