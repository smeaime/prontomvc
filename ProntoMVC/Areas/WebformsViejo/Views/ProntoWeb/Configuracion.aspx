<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="Configuracion.aspx.vb" Inherits="Configuracion" Title="Configuración" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <div style="border: none solid #FFFFFF; width: 80%; margin-top: 5px;">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <table style="padding: 0px; border: none #FFFFFF; width: 95%; height: 100%; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td colspan="2" style="border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF;
                            font-size: large;" align="left" valign="top">
                            PARAMETROS
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" ID="PanelSuperadmin" Visible="false">
                    <table style="padding: 0px; border: none #FFFFFF; width: 95%; height: 100%; margin-right: 0px;"
                        cellpadding="3" cellspacing="3">
                        <tr>
                            <td class="EncabezadoCell" style="width: 90px; height: 23px;" colspan="3">
                                Para todas las bases
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 90px; height: 23px;">
                                Logo del login
                            </td>
                            <td>
                                <asp:DropDownList ID="TextBox1" runat="server" AutoPostBack="True">
                                    <asp:ListItem Text="BDL" />
                                    <asp:ListItem Text="Williams" />
                                    <asp:ListItem Text="Esuco" />
                                    <asp:ListItem Text="Autotrol" />
                                </asp:DropDownList>
                            </td>
                            <td class="EncabezadoCell" style="width: 90px; height: 23px;">
                                CSS Theme
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbCSS" runat="server" AutoPostBack="True">
                                    <asp:ListItem Text="Azul" />
                                    <asp:ListItem Text="AzulBajoContraste" />
                                    <asp:ListItem Text="BlancoNegro" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell" style="width: 90px; height: 23px;" colspan="3">
                                Solo esta base
                            </td>
                        </tr>
                        <tr>
                            <td class="EncabezadoCell " style="width: 220px; height: 23px;">
                                Pronto.ini
                            </td>
                            <td>
                                <asp:DropDownList ID="txtEmpresaConfiguracion" runat="server" AutoPostBack="True">
                                    <asp:ListItem Text="BDL" />
                                    <asp:ListItem Text="Williams" />
                                    <asp:ListItem Text="Esuco" />
                                    <asp:ListItem Text="Autotrol" />
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnActualizarBase" runat="server" Text="Backup + Actualizacion de la base (Nuevas tablas + Alter Table + Nuevos SP)" />
                                <asp:Button ID="Button7" runat="server" Text="Backup + Actualizacion de la base con SMO" />
                                <br />
                                <asp:Button ID="btnGenerarScript" runat="server" Text="Exportar esquemas con SMO" />
                                verificar fecha de script con ultima modificacion de la base
                            </td>
                        </tr>
                        <tr>
                            <td>
                                *nombre del webserver *Cola de trabajos activada *numeradores rm y pedidos *otros
                                conceptos pedidos
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lblLog" runat="server" Width="600px" />
                   
                    <asp:HyperLink runat="server"  NavigateUrl="~\Prontoweb\bugtrack.aspx">Web de Consultas</asp:HyperLink>

                    DESCARGAR BASE - RESTAURAR BASE 
                    Sincronizar base de desarrollo
                    Ver trace de la aplicacion http://[server]/[application]/trace.axd
                    healthmonitoring enabled? debug enabled? asp.net admin tool (solo con el Cassini)
                    link al word de modificaciones store procs mas usados permisos de escritura en directorios
                    de error y generacion temporal de .docx


                    <asp:GridView runat="server" ID="gvEventlog">
                    </asp:GridView>
                    <div>
                        <strong>Performance Object:</strong><br />
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <strong>Performance Counter:</strong><br />
                        <asp:DropDownList ID="DropDownList2" runat="server">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <strong>Instances:</strong><br />
                        <asp:DropDownList ID="DropDownList3" runat="server">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <asp:Button ID="Button9" runat="server" OnClick="Button1_Click" Text="Retrieve Value" /><br />
                        <br />
                        <asp:Label ID="Label1" runat="server"></asp:Label></div>
                </asp:Panel>
                <hr />
                <table style="padding: 0px; border: none #FFFFFF; width: 95%; height: 100%; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
                    <tr>
                        <td class="EncabezadoCell" style="width: 90px; height: 23px;" colspan="3">
                            Solo esta base
                        </td>
                    </tr>
                    <tr>
                        <td class="EncabezadoCell" style="width: 90px; height: 23px;">
                            Notificaciones

                            De 12:00 a 12:20 se actualizará el sistema. Por favor, disculpen las molestias. BDL
                        </td>
                        <td class="EncabezadoCell" valign="bottom">
                            <asp:TextBox ID="TextNotificaciones" TextMode="MultiLine" runat="server" Width="300px"
                                Height="70" TabIndex="5"></asp:TextBox>
                        </td>
                        <td class="EncabezadoCell" style="width: 90px; height: 23px;">
                            Logo de esta base (directorio \Imagenes)
                        </td>
                        <td>
                            <asp:TextBox ID="txtLogoArchivo" runat="server" TabIndex="5"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <hr />
                <%--      
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <asp:ListView ID="ListView1" runat="server" ShowFooter="True" AllowPaging="True"
                    Visible="false" AllowSorting="True" PageSize="10" AutoGenerateColumns="false"
                    DataSourceID="LinqDataSource1" DataKeyNames="IdInformeWeb" EmptyDataText="There are no data records to display.">
                    <LayoutTemplate>
                        <table cellpadding="2" width="640px" border="1" id="tbl1" runat="server">
                            <tr id="Tr1" runat="server" style="background-color: #98FB98">
                                <th id="Th1" runat="server">
                                    ID
                                </th>
                                <th id="Th2" runat="server">
                                    Account Number
                                </th>
                                <th id="Th3" runat="server">
                                    Name
                                </th>
                                <th id="Th4" runat="server">
                                    Preferred Vendor
                                </th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder" />
                        </table>
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NumericPagerField />
                            </Fields>
                        </asp:DataPager>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="Tr2" runat="server">
                            <td>
                                <asp:Label ID="VendorIDLabel" runat="server" Text='<%# Eval("NombreUnico") %>' />
                            </td>
                            <td>
                                <asp:Label ID="AccountNumberLabel" runat="server" Text='<%# Eval("NombreUnico") %>' />
                            </td>
                            <td>
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("NombreUnico") %>' />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <%--
                # re: LINQ to SQL (Part 5 - Binding UI using the ASP:LinqDataSource Control)

Friday, August 03, 2007 4:09 AM by ScottGu
Hi ramon.duraes,

>>>>>>> New Gridview + LinqDasource  has option for insert data ?

The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.
The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.

The new Listview control does also support defining an insert template.

Hope this helps,

Scott
                --%>
                <asp:GridView ID="gvInformes" runat="server" ShowFooter="false" AllowPaging="True"
                    AllowSorting="True" PageSize="10" AutoGenerateColumns="false" DataSourceID="LinqDataSource1"
                    DataKeyNames="IdInformeWeb" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:CommandField ShowEditButton="true" ShowDeleteButton="false" ControlStyle-Width="40" />
                        <asp:BoundField DataField="NombreUnico" HeaderText="Informe" ControlStyle-Width="80" />
                        <asp:BoundField DataField="URL" HeaderText="URL" ControlStyle-Width="200" />
                        <asp:BoundField DataField="RolExigidoParaLectura" HeaderText="Rol exigido" ControlStyle-Width="80" />
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Wrap="False" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:LinkButton runat="server" Text="Agregar" ID="btnAgregarInforme" Width="40" Visible="false" />
                <asp:TextBox runat="server" ID="newNombre" Width="80" Visible="false" />
                <asp:TextBox runat="server" ID="newURL" Width="200" Visible="false" />
                <asp:TextBox runat="server" ID="newRol" Width="80" Visible="false" />
                <%--    'http://stackoverflow.com/questions/1188962/linq-to-sql-set-connection-string-dynamically-based-on-environment-variable--%>
                <%--      Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!!  --%>
                <%--      Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!!  --%>
                <%--      Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!!  --%>
                <%--      Mirá que tablename tiene que estar en plural!!!!!!!!!!!!!!  --%>
                <asp:LinqDataSource ID="LinqDataSource1" runat="server" TableName="InformesWebs"
                    EnableDelete="true" EnableInsert="true" EnableUpdate="true">
                    <%--<WhereParameters>
                        <asp:Parameter Name="Subject" />
                    </WhereParameters>--%>
                </asp:LinqDataSource>
                <%--
                # re: LINQ to SQL (Part 5 - Binding UI using the ASP:LinqDataSource Control)

Friday, August 03, 2007 4:09 AM by ScottGu
Hi ramon.duraes,

>>>>>>> New Gridview + LinqDasource  has option for insert data ?

The GridView doesnt' support insert directly - although you can use a detailsview control with it to enable this.

The new Listview control does also support defining an insert template.

Hope this helps,

Scott
                --%>
                <%--     /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                <%--puse AutoID por los problemas de Server Response Error. No se cuales son las consecuencias--%>
                <script type="text/javascript" language="javascript">
                    //         http: //www.codeproject.com/KB/ajax/AsyncFileUpload.aspx
                    function uploadError(sender, args) {
                        //document.getElementById('lblStatus').innerText = args.get_fileName(), 	"<span style='color:red;'>" + args.get_errorMessage() + "</span>";
                    }

                    function StartUpload(sender, args) {
                        //document.getElementById('lblStatus').innerText = 'Uploading Started.';
                    }

                    function ClientUploadComplete(sender, args) {
                        //alert('subido');
                        // var filename = args.get_fileName();
                        // var contentType = args.get_contentType();
                        // var text = "Size of " + filename + " is " + args.get_length() + " bytes";
                        // if (contentType.length > 0)
                        // {
                        //  text += " and content type is '" + contentType + "'.";
                        //}
                        //
                        //  document.getElementById('lblStatus').innerText = text;

                        //    document.getElementById('lblStatus')


                        var f = document.getElementById("ctl00_ContentPlaceHolder1_btnVistaPrevia");
                        //var f = $find('ctl00_ContentPlaceHolder1_btnVistaPrevia');

                        //f.click();
                    }

                </script>
                <hr />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="EncabezadoCell">
                            <table>
                                <tr>
                                    <td>
                                        Plantillas de venta
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Subir
                                        <asp:DropDownList ID="cmbPlantilla" runat="server" AutoPostBack="True">
                                            <asp:ListItem Text="FacturaA" />
                                            <asp:ListItem Text="FacturaB" />
                                            <asp:ListItem Text="FacturaX" />
                                            <asp:ListItem Text="NotaCreditoA" />
                                            <asp:ListItem Text="NotaCreditoB" />
                                            <asp:ListItem Text="NotaCreditoX" />
                                            <asp:ListItem Text="NotaDebitoA" />
                                            <asp:ListItem Text="NotaDebitoB" />
                                            <asp:ListItem Text="NotaDebitoX" />
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="3">
                                        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete=""
                                            CompleteBackColor="Lime" ErrorBackColor="Red" />
                                    </td>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td style="width: 200px">
                                        tipo "A"
                                    </td>
                                    <td style="width: 200px">
                                        tipo "B"
                                    </td>
                                    <td style="width: 200px">
                                        tipo "E"
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Facturas de venta
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkFacturaLetraA" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkFacturaLetraB" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkFacturaLetraE" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Notas de Crédito
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaCreditoLetraA" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaCreditoLetraB" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaCreditoLetraE" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Notas de Débito
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaDebitoLetraA" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaDebitoLetraB" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="lnkNotaDebitoLetraE" runat="server" ForeColor="White">Descargar Log</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <div style="visibility: hidden;">
                    <a href="Factura.aspx?Id=31408" target='_blank'>Factura 31408 (acá deberías llamar al
                        Openxml pasandole este ID)</a><br />
                    <a href="NotaDeCredito.aspx?Id=128" target='_blank'>NC 31408 </a>
                    <br />
                    <a href="NotaDeDebito.aspx?Id=17" target='_blank'>ND 17 </a>
                    <br />
                    <asp:Button ID="btnFacturaXML" runat="server" />
                    <asp:Button ID="btnNotaCreditoXML" runat="server" />
                    <asp:Button ID="btnNotaDebitoXML" runat="server" />
                </div>
                <hr />
                <br />
                <asp:DropDownList ID="cmbArchivoError" runat="server" AutoPostBack="True">
                </asp:DropDownList>
                <asp:LinkButton ID="LinkButton6" runat="server">Descargar Log</asp:LinkButton>
                <asp:HyperLink NavigateUrl="~/ProntoWeb/bugtrack.aspx" Text="ProntoSeguimiento" runat="server"
                    Visible="false" ID="lnkBDL"></asp:HyperLink>
                <br />
                <asp:TextBox runat="server" TextMode="MultiLine" ID="txtErrores" Height="200px" Width="95%"
                    Visible="false"></asp:TextBox>
                <%--http://www.bestbusinesssoftware.info/accounting-billing-software/microsoft-office-accounting-express-2008/--%>
                <%--                   Informes      <asp:DropDownList ID="DropDownList2" runat="server" >
                       <asp:ListItem>Almacen</asp:ListItem>
                       <asp:ListItem>Compras</asp:ListItem>
        </asp:DropDownList>
                   <asp:DropDownList ID="DropDownList1" runat="server" >
                       <asp:ListItem>Vales Emitidos no Retirados</asp:ListItem>
                       <asp:ListItem>Notas de Pedido Pendientes</asp:ListItem>
                       <asp:ListItem>Requerimientos y Listas de Acopio</asp:ListItem>
        </asp:DropDownList>--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                <ProgressTemplate>
                    <img src="Imagenes/25-1.gif" alt="" />
                    <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                        Visible="False"></asp:Label>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Button ID="btnSave" runat="server" Text="Aceptar" CssClass="but" UseSubmitBehavior="False"
                Style="margin-left: 0px" ValidationGroup="Encabezado" TabIndex="39"></asp:Button>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <table style="border-style: none; border-color: inherit; border-width: medium; width: 555px;
        height: 523px; display: none; visibility: hidden;" class="t1" cellpadding="4"
        cellspacing="5" align="center">
        <tr>
            <td style="width: 2049px; height: 5px;">
            </td>
            <td style="width: 6843px; height: 5px;">
            </td>
            <td style="height: 5px;" colspan="2">
            </td>
            <td style="height: 5px;" colspan="4">
            </td>
            <td style="height: 5px; width: 85px;">
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="White">Nueva RM</asp:LinkButton>
            </td>
            <td style="width: 6843px; height: 24px;">
            </td>
            <td style="border: thin groove #000000; height: 67px; width: 2193px;" align="center">
                <asp:LinkButton ID="LinkButton3" runat="server" ForeColor="White">Nueva Solicitud</asp:LinkButton>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="center" valign="bottom" colspan="2" style="height: 24px">
            </td>
            <td style="width: 243px; height: 24px;">
            </td>
            <td style="height: 24px;">
            </td>
            <td style="width: 85px; height: 24px;">
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 71px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 70px; height: 59px" />
            </td>
            <td style="height: 71px; width: 6843px;">
            </td>
            <td style="height: 71px;" align="right" colspan="2" class="style7">
                &nbsp;<img src="../Imagenes/Bottom-arrow-48-con%20derecha.png" style="width: 64px;
                    height: 55px" />
            </td>
            <td style="border: thin groove #000000; height: 71px; width: 672px;" align="center">
                <asp:LinkButton ID="LinkButton4" runat="server" ForeColor="White">Nueva Comparativa</asp:LinkButton>
            </td>
            <td style="height: 71px; width: 460px;">
            </td>
            <td class="style7" style="height: 71px;" colspan="2">
            </td>
            <td class="style7" style="height: 71px; width: 85px;">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: thin groove #000000; height: 94px;" align="center">
                <asp:LinkButton ID="LinkButton2" runat="server" ForeColor="White">Asignar Requerimientos Pendientes</asp:LinkButton>
            </td>
            <td colspan="4" style="height: 94px" align="center">
                <img src="../Imagenes/Right-arrow-48.png" style="width: 111px; height: 72px" />
            </td>
            <td colspan="3" style="border: thin groove #000000; height: 94px;" align="center">
                <asp:LinkButton ID="LinkButton5" runat="server" ForeColor="White">Nuevo Pedido</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 29px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 65px; height: 48px" alt="esq" />
            </td>
            <td style="height: 29px;" align="center" colspan="3">
                <img src="../Imagenes/Top-arrow-48%20esquina%20derecha.png" style="width: 75px; height: 43px"
                    alt="esq" />
            </td>
            <td style="border: thin groove #000000; height: 67px; width: 672px;" align="center">
                Nueva Recepcion
            </td>
            <td style="width: 460px" />
            <td colspan="2" style="height: 29px">
                <img src="../Imagenes/Top-arrow-48%20esquina%20derecha2.png" style="width: 51px;
                    height: 50px" />
            </td>
            <td style="height: 29px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 50px; height: 49px" />
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 67px;" align="center">
                Nuevo Vale
            </td>
            <td style="height: 67px;" colspan="4" align="center">
                &nbsp;
            </td>
            <td style="height: 67px; width: 460px;">
            </td>
            <td>
            </td>
            <td>
            </td>
            <td style="border: thin groove #000000; width: 85px; height: 67px;" align="center">
                Nuevo Comprobante de Proveedor
            </td>
        </tr>
        <tr>
            <td style="width: 2049px; height: 34px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 59px; height: 48px" />
            </td>
            <td style="width: 6843px; height: 34px;">
            </td>
            <td style="height: 34px;" colspan="2">
            </td>
            <td style="height: 34px;" colspan="4">
            </td>
            <td style="width: 85px; height: 34px;" align="center">
                <img src="../Imagenes/Bottom-arrow-48.png" style="width: 48px; height: 48px" />
            </td>
        </tr>
        <tr>
            <td style="border: thin groove #000000; width: 2049px; height: 51px;" align="center" />
            Nueva Salida de Material
            <td style="width: 6843px; height: 51px;">
                <td style="height: 51px;" colspan="2">
                </td>
                <td style="height: 51px;" align="center" colspan="4">
                </td>
                <td style="border: thin groove #000000; width: 85px; height: 51px; font-weight: bold;"
                    align="center">
                    Nueva Orden de Pago
                </td>
        </tr>
    </table>
    <br />
    <asp:Panel ID="panelcito" runat="server" Visible="false">
        <asp:Button ID="Button5" runat="server" Text="Importar Articulos" />
        <asp:Button ID="Button6" runat="server" Text="Importar Establecimientos Grobo" />
        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload2" runat="server" CompleteBackColor="Lime"
            ErrorBackColor="Red" />
    </asp:Panel>
    <div style="visibility: hidden; display: none;">
        <table style="width: 565px; height: 111px;" class="t1" cellpadding="5" cellspacing="5">
            <tr>
                <td style="width: 100px">
                    Nuevo Proveedor
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Buscar Proveedor
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <asp:Button ID="Button1" runat="server" Text="Test Firmas" />
        <asp:Button ID="Button2" runat="server" Text="Test FF" />
        <asp:Button ID="Button3" runat="server" Text="Test Cotiz" />
        <asp:Button ID="Button8" runat="server" Text="Todos" />
        <asp:Button ID="Button4" runat="server" Text="Importar Articulos" />
    </div>
    </center>
    <asp:HiddenField ID="HFSC" runat="server" />
</asp:Content>
