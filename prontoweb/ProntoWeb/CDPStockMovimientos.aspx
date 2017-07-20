<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="CDPStockMovimientos.aspx.vb" Inherits="CDPStockMovimientos" Title="Movimientos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <%--/////////////////////////////////////////////////////////////--%>
    <%--//////////       jquery    /////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     bootstrap    /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--////////////    jqgrid     //////////////////////////////////--%>
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.4/i18n/grid.locale-es.js"></script>
    <link href="//cdn.jsdelivr.net/jqgrid/4.5.2/css/ui.jqgrid.css" rel="stylesheet">
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.2/jquery.jqGrid.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <br />
    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel  runat="server" Wrap="False">
                <div style="vertical-align: middle; height: 100%; margin-top: 15px;">
                    <asp:LinkButton ID="lnkNuevo" runat="server"  Font-Underline="False"  CssClass="butCrear but"
                        ForeColor="White" CausesValidation="true" Font-Size="Small" 

                        Visible="true">+   Nuevo</asp:LinkButton>
                    <input type="button" id="btnExportarGrillaAjax2" value="Excel" class="btn btn-primary" />
                   



                    <asp:Button ID="Button1" Text="exportar" runat="server" Visible="false" Height="27" />

                    <asp:Label ID="Label12" runat="server" Text="Buscar " ForeColor="White" Style="text-align: right"
                        Visible="False"></asp:Label>
                    <asp:TextBox ID="txtBuscar" runat="server" Style="text-align: right;" Text="" AutoPostBack="True"  Visible="false" ></asp:TextBox>
                    <asp:DropDownList ID="cmbBuscarEsteCampo" runat="server" Style="text-align: right;
                        margin-left: 0px;" Width="119px" Height="22px"  Visible="false" >
                        <asp:ListItem Text="Numero" Value="IdCDPMovimiento" />
                        <asp:ListItem Text="Fecha" Value="[FechaIngreso]" />
                        <asp:ListItem Text="de Exportador" Value="ExportadorOrigen" />
                        <asp:ListItem Text="a Exportador" Value="ExportadorDestino" />
                        <asp:ListItem Text="Tipo" Value="Tipo" />
                        <asp:ListItem Text="Contrato" Value="Contrato" />
                        <asp:ListItem Text="Puerto" Value="MovDestinoDesc" />
                        <asp:ListItem Text="Vapor" Value="Vapor" />
                    </asp:DropDownList>
                    <cc1:TextBoxWatermarkExtender ID="TBWE1" runat="server" TargetControlID="txtBuscar"
                        WatermarkText="buscar" WatermarkCssClass="watermarkedbuscar" />
                    <asp:TextBox ID="txtFechaDesde" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"  Visible="false" 
                        AutoPostBack="True" />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                        TargetControlID="txtFechaDesde" />
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtFechaDesde" />
                    <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                        WatermarkText="desde" WatermarkCssClass="watermarkedbuscar" />
                    <asp:TextBox ID="txtFechaHasta" runat="server" Width="80px" MaxLength="1" Style="margin-left: 10px"  Visible="false" 
                        AutoPostBack="True" />
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy"
                        TargetControlID="txtFechaHasta" />
                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                        DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtFechaHasta" />
                    <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                        WatermarkText="hasta" WatermarkCssClass="watermarkedbuscar" />
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img src="Imagenes/25-1.gif" alt="" style="height: 26px" />
                            <asp:Label ID="Label342" runat="server" Text="Actualizando datos..." ForeColor="White"
                                Visible="true"></asp:Label>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
            
            
            

                       <br />

            
        <table id="Lista" class="scroll" cellpadding="0" cellspacing="0" style="font-size: 12px;" width="700px">
        </table>
        <div id="ListaPager" class="scroll" style="text-align: center; height: 30px">
        </div>

                        

            
            </asp:Panel>
               <br />
    
            <%--<hr style="border-color: #FFFFFF; width: 160px; color: #FFFFFF;" align="left" size="1" />--%>
            <table width="700">
                <tr>
                    <td align="left">
                        <div style="width: 700px; overflow: auto; margin-top: 4px;">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCDPMovimiento"
                                DataSourceID="SqlDataSource1" GridLines="none" AllowPaging="True" Width="700px" Visible="false"
                                PageSize="8" EnableModelValidation="True">
                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                <Columns>
                                    <%--<asp:CommandField ShowEditButton="True" EditText="Ver" />--%>
                                    <asp:BoundField DataField="IdCDPMovimiento" HeaderText="Número" InsertVisible="False"
                                        ReadOnly="True" Visible="true" SortExpression="IdCDPMovimiento" />
                                    <%--   <asp:BoundField DataField="NumeroCDPMovimiento" 
                                        HeaderText="Numero" SortExpression="NumeroCDPMovimiento" Visible="false" />
                                    --%>
                                    <asp:TemplateField HeaderText="Fecha" HeaderStyle-HorizontalAlign="Right">
                                        <%--<ItemStyle Width="120px" HorizontalAlign="right" />--%>
                                        <ItemTemplate>
                                            <asp:Label ID="Fecha" Text='<%#   Eval( "FechaIngreso", "{0:d MMM}" )  %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="MovProductoDesc" HeaderText="Destino" SortExpression="MovProductoDesc" />
                                    <asp:BoundField DataField="ExportadorOrigen" HeaderText="  " SortExpression="ExportadorOrigen" />
                                    <asp:BoundField DataField="ExportadorDestino" HeaderText="Origen" SortExpression="ExportadorDestino" />
                                    <%--<asp:BoundField DataField="Tipo" HeaderText="Tipo" SortExpression="Tipo" />--%>
                                    <asp:BoundField DataField="Contrato" HeaderText="Contrato" SortExpression="Contrato" />
                                    <asp:BoundField DataField="MovDestinoDesc" HeaderText="Producto" SortExpression="Puerto" />
                                    <asp:BoundField DataField="Vapor" HeaderText="Vapor" SortExpression="Vapor" />
                                       <asp:BoundField DataField="IdStock" HeaderText="PVenta" SortExpression="IdStock" />
                                    <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" />
                                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" />
                                    <asp:BoundField DataField="IdUsuarioIngreso" HeaderText="IdUsuarioIngreso" Visible="false"
                                        SortExpression="IdUsuarioIngreso" />
                                    <%--Eval("A/B/E") & " "& "-" &--%>
                                    <%--& Eval("[]") --%>
                                    <asp:BoundField DataField="Anulada" HeaderText="Anulada" Visible="false" SortExpression="Anulada" />
                                    <asp:BoundField DataField="IdUsuarioAnulo" HeaderText="IdUsuarioAnulo" Visible="false"
                                        SortExpression="IdUsuarioAnulo" />
                                
                                    <asp:BoundField DataField="FechaAnulacion" HeaderText="FechaAnulacion" SortExpression="FechaAnulacion"
                                        Visible="false" />
                                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" SortExpression="Obs."
                                        Visible="false" />
                                    <asp:BoundField DataField="IdAjusteStock" HeaderText="IdAjusteStock" SortExpression="IdAjusteStock"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdCartaDePorte" HeaderText="IdCartaDePorte" SortExpression="IdCartaDePorte"
                                        Visible="false" />
                                    <%--            <asp:BoundField DataField="Ordenes de compra" HeaderText="Ordenes de compra" />--%>
                                    <%--            <asp:BoundField DataField="Remitos" HeaderText="Remitos" />--%>
                                    <%--  <asp:BoundField DataField="Neto gravado" HeaderText="Neto gravado" />--%>
                                    <asp:BoundField DataField="IdStock" HeaderText="IdStock" SortExpression="IdStock"
                                        Visible="false" />
                                    <asp:BoundField DataField="Partida" HeaderText="Partida" SortExpression="Partida"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdUnidad" HeaderText="IdUnidad" SortExpression="IdUnidad"
                                        Visible="false" />
                                    <asp:BoundField DataField="IdUbicacion" HeaderText="IdUbicacion" SortExpression="IdUbicacion"
                                        Visible="false" />
                                    <%--            <asp:BoundField DataField="Grupo CDPStockMovimientocion automatica" HeaderText="Grupo CDPStockMovimientocion automatica" />
            <asp:BoundField DataField="Act_Rec_Gtos_" HeaderText="Act_Rec_Gtos_" />
            <asp:BoundField DataField="Fecha Contab_" HeaderText="Fecha Contab_" />--%>
                                </Columns>
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="false" ForeColor="#F7F7F7" Wrap="False" />
                                <AlternatingRowStyle BackColor="#F7F7F7" />
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListDataset" TypeName="Pronto.ERP.Bll.CDPStockMovimientoManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListItems" TypeName="Pronto.ERP.Bll.CDPStockMovimientoManager"
                DeleteMethod="Delete" UpdateMethod="Save">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HFSC" Name="SC" PropertyName="Value" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SC" Type="String" />
                    <asp:Parameter Name="myCDPStockMovimiento" Type="Object" />
                </UpdateParameters>
            </asp:ObjectDataSource>








            <asp:HiddenField ID="HFSC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    <%--    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" ProcessingMode="Remote" Width="770px">
        <ServerReport ReportServerUrl="http://nanopc:81/ReportServer" 
            ReportPath="/CDPStockMovimientos" />
    </rsweb:ReportViewer>
    <br />
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="299px" Width="770px">
        <LocalReport ReportPath="ProntoWeb\Informes\CDPStockMovimientos.rdl">
        </LocalReport>

    </rsweb:ReportViewer>--%>


    
<script>

    
    $('#btnExportarGrillaAjax2').click(function () {

        var d = {
            filters: jQuery('#Lista').getGridParam("postData").filters,  // si viene en undefined es porque no se puso ningun filtro
            fechadesde: "" , //$("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(),
            fechahasta: "" , // $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(),
            destino: "" // $("#ctl00_ContentPlaceHolder1_txtDestino").val()
        }

        if (typeof d.filters === "undefined") d.filters = "";

        $.ajax({
            type: "POST",
            //method: "POST",
            url: "CDPStockMovimientos.aspx/ExportarGrillaNormal",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(d),

            success: function (data) {
                //alert(data.d);
                window.open(data.d);
            }


            ,
            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");

            },
            complete: function () {
                $("#loading").hide();
            }


        })


    })

    
    $().ready(function () {
        'use strict';

        var UltimoIdArticulo;














        $('#Lista').jqGrid({
            //url: ROOT + 'CotizacionWilliamsDestino/Cotizaciones/',
            url: 'HandlerMovimientos.ashx',
            //postData: {},
            //postData: {
            //    'FechaInicial': function () { return $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(); },
            //    'FechaFinal': function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); },
            //    'puntovent': function () { return $("#ctl00_ContentPlaceHolder1_cmbPuntoVenta").val(); },
            //    'destino': function () { return $("#ctl00_ContentPlaceHolder1_txtDestino").val(); }
            //},
            datatype: 'json',
            mtype: 'POST',




            // CP	TURNO	SITUACION	MERC	TITULAR_CP	INTERMEDIARIO	RTE CIAL	CORREDOR	DESTINATARIO	DESTINO	ENTREGADOR	PROC	KILOS	OBSERVACION


            colNames: ['', 'Id', 'Nro', 'Fecha', 'Puerto',
                        'Producto', 'Kilos','Vapor','Factura','Cliente Fac.','Sucursal','Fecha Fac.','Origen','Destino'
            ],

            colModel: [

{
    name: 'act', index: 'act', align: 'center', width: 50, editable: false, hidden: false, sortable: false,
    search: false,
},

{ name: ' IdCDPMovimiento', index: ' IdCDPMovimiento', align: 'left', width: 150, editable: false, hidden: true },

{ name: 'IdCDPMovimiento', index: ' IdCDPMovimiento', align: 'left', width: 60, editable: false, hidden: false, edittype: 'text', searchoptions: { sopt: ['bw', 'cn', 'eq'] }, },

{
    name: 'FechaIngreso', index: 'FechaIngreso', width: 100, sortable: true, align: 'right', editable: false, sortable: false,
    editoptions: {
        size: 10,
        maxlengh: 10,
        dataInit: function (element) {
            $(element).datepicker({
                dateFormat: 'dd/mm/yy',
                constrainInput: false,
                showOn: 'button',
                buttonText: '...'
            });
        }
    },
    formatoptions: { newformat: "dd/mm/yy" }, datefmt: 'dd/mm/yy'
    //, formatter: 'date'
    , sorttype: 'date'


    , searchoptions: {
        sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'],
        dataInit: function (elem) {
            $(elem).datepicker({
                dateFormat: 'dd/mm/yy',
                showButtonPanel: true
            })
        }
    }
},

{ name: 'MovDestinoDesc', index: 'MovDestinoDesc', align: 'left', width: 150, hidden: false, editable: false, edittype: 'text', sortable: false },




{ name: 'MovProductoDesc', index: 'MovProductoDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false },

{ name: 'NetoFinal', index: 'NetoFinal', align: 'left', width: 60, hidden: false, editable: false, edittype: 'text', sortable: false },


            { name: 'Vapor', index: 'Vapor', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false },

{ name: 'Factura', index: 'Factura', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false },

            { name: 'ClienteFacturado', index: 'ClienteFacturado', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false },

{ name: 'IdStock', index: 'IdStock', align: 'left', width: 50, hidden: false, editable: false, edittype: 'text', sortable: false },
            { name: 'fechafactura', index: 'fechafactura', align: 'left', width: 50, hidden: false, editable: false, edittype: 'text', sortable: false },

{ name: 'ExportadorOrigen', index: 'ExportadorOrigen', align: 'left', width: 150, hidden: false, editable: false, edittype: 'text', sortable: false },
{ name: 'ExportadorDestino', index: 'ExportadorDestino', align: 'left', width: 150, hidden: false, editable: false, edittype: 'text', sortable: false },
            ],

            gridComplete: function () {
                //    var ids = jQuery("#Lista").jqGrid('getDataIDs');
                //    for (var i = 0; i < ids.length; i++) {
                //        var cl = ids[i];
                //        var se = "<input style='height:22px;width:20px;' type='button' value='G' onclick=\"GrabarFila('" + cl + "'); \"  />";
                //        jQuery("#Lista").jqGrid('setRowData', ids[i], { act: se });
                //    }
                //jQuery("#Lista").jqGrid('addRowData', Id, data, "last");
                //AgregarItemVacio(grid)


            },



            loadComplete: function () {
                // http://stackoverflow.com/questions/6575192/jqgrid-change-background-color-of-row-based-on-row-cell-value-by-column-name

                //RefrescarFondoRenglon(this);



            },




            onCellSelect: function (rowid, iCol, cellcontent, e) {
                var $this = $(this);
                var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
                lastSelectedId = rowid;
                lastSelectediCol = iCol;
                lastSelectediRow = iRow;
            },
            afterEditCell: function (id, name, val, iRow, iCol) {
                //if (name == 'Fecha') {
                //    jQuery("#" + iRow + "_Fecha", "#Lista").datepicker({ dateFormat: "dd/mm/yy" });
                //}
                var se = "<input style='height:22px;width:55px;' type='button' value='Grabar' onclick=\"GrabarFila('" + id + "');\"  />";
                jQuery("#Lista").jqGrid('setRowData', id, { act: se });
            },
            //beforeSelectRow: function (rowid, e) {
            //var $this = $(this),
            //    $td = $(e.target).closest('td'),
            //    $tr = $td.closest('tr'),
            //    iRow = $tr[0].rowIndex,
            //    iCol = $.jgrid.getCellIndex($td);

            //if (typeof lastSelectediRow !== "undefined" && typeof lastSelectediCol !== "undefined" &&
            //        (iRow !== lastSelectediRow || iCol !== lastSelectediCol)) {
            //    $this.jqGrid('setGridParam', {cellEdit: true});
            //    $this.jqGrid('restoreCell', lastSelectediRow, lastSelectediCol, true);
            //    $this.jqGrid('setGridParam', {cellEdit: false});
            //    $(this.rows[lastSelectediRow].cells[lastSelectediCol])
            //        .removeClass("ui-state-highlight");
            //}
            //return true;
            //},

            pager: $('#ListaPager'),
            rowNum: 10,
            rowList: [10, 20, 50, 100],
            sortname: 'IdCDPMovimiento',  //'FechaDescarga', //'NumeroCartaDePorte',
            sortorder: 'desc',
            viewrecords: true,
            multiselect: false,
            shrinkToFit: false,
            width: 'auto',
            height: 460, // $(window).height() - 250, // '100%'
            altRows: false,
            footerrow: false,
            userDataOnFooter: true,
            //caption: '<b>Control de Descargas</b>',
            cellEdit: true,
            cellsubmit: 'clientArray',
            dataUrl: "WebServiceClientes.asmx/EmpleadoEditGridData",

            toppager: true,

            gridview: true
    , multiboxonly: true
    , multipleSearch: true

        });


        jQuery('#Lista').jqGrid('gridResize');

        jQuery("#Lista").jqGrid('bindKeys');

        jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
         { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
         {
             //sopt: ["cn"]
             //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
             zIndex: 50, width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false

         }
            // http://stackoverflow.com/questions/11228764/jqgrid-setting-zindex-for-alertmod
        );

        //jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
        //    { search: false, refresh: false, add: false, edit: false, del: false }, {}, {}, {}, {});



        //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
        //                                {
        //                                    caption: "", buttonicon: "ui-icon-plus", title: "Agregar",
        //                                    onClickButton: function () {
        //                                        AgregarItemVacio(jQuery("#Lista"));
        //                                    },
        //                                });
        //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
        //                                {
        //                                    caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
        //                                    onClickButton: function () {
        //                                        MarcarSeleccionadosParaEliminar(jQuery("#Lista"));
        //                                    },
        //                                });



        jQuery("#Lista").filterToolbar({
            stringResult: true, searchOnEnter: true,
            defaultSearch: 'cn',
            enableClear: false
        }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/


        //$('#Lista').jqGrid('setGridWidth', '1000');
        $('#Lista').jqGrid('setGridWidth', $(window).width() - 300);

    });


</script>
</asp:Content>



