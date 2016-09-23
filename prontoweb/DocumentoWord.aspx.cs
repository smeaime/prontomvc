using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using EntityFactory;

public partial class DocumentoWord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (PreviousPage == null && !IsPostBack)
            Response.Redirect("Login.aspx");
        
        if (PreviousPage != null)
           pedido.Value = PreviousPage.Pedido.Trim();
    }


    private string GetFila(string contenido)
    {
        int comienzaFila = contenido.IndexOf("#COMIENZAFILA") + "#COMIENZAFILA".Length;
        int finFila = contenido.IndexOf("#FINFILA");
        string fila = contenido.Substring(comienzaFila, (finFila - comienzaFila));
        return fila;
    }
    
    private void ReemplazaFilas(ref string contenido, string contenidoFilas)
    {
        int comienzaFila = contenido.IndexOf("#COMIENZAFILA");
        int finFila = contenido.IndexOf("#FINFILA") + "#FINFILA".Length;
        string fila = contenido.Substring(comienzaFila, (finFila - comienzaFila));
        contenido = contenido.Replace(fila, contenidoFilas);
    }

    private void SaltoLínea(ref string contenido, string str1, string str2, List<string> valores)
    {
        int finSalto = contenido.IndexOf(str2);
        int iniSalto = contenido.IndexOf(str1) + str1.Length;
        string salto = contenido.Substring(iniSalto, (finSalto - iniSalto));
        int iniOld = iniSalto - str1.Length;
        int lenOld = (finSalto + str1.Length) - iniOld;
        string oldStr = contenido.Substring(iniOld, lenOld);
        StringBuilder sb = new StringBuilder();

        foreach (string valor in valores)
        {
            if (sb.Length > 0)
                sb.Append(salto);
            sb.Append(valor);
        }
        contenido = contenido.Replace(oldStr, sb.ToString());
    }

    private string SelectDetallesPedido(int idPedido)
    {
        return
            @"SELECT 
             DetPed.FechaEntrega, 
             DetPed.NumeroItem, 
             DetPed.OrigenDescripcion, 
             DetPed.IdArticulo, 
             Articulos.Codigo as [Codigo], 
             Articulos.Descripcion as [Material],
             DetPed.Cantidad, 
             Unidades.Descripcion Unidad, 
             DetPed.Precio, 
             IsNull(Monedas.Abreviatura,Monedas.Nombre) as [Moneda], 
             DetPed.Cantidad1, 
             DetPed.Cantidad2, 
             DetPed.PorcentajeIVA Iva, 
             DetPed.PorcentajeBonificacion Bon, 
             DetPed.ImporteBonificacion, 
             DetPed.ImporteIva, 
             DetPed.ImporteTotalItem, 
             DetPed.FechaEntrega, 
             DetPed.IdControlCalidad, 
             Requerimientos.IdObra as [IdObra], 
             Obras.Descripcion as [Obra], 
             Requerimientos.NumeroRequerimiento, 
             DetalleRequerimientos.NumeroItem as [NumeroItemRM], 
             DetPed.Observaciones, 
             DetPed.Adjunto
            FROM DetallePedidos DetPed 
            LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido 
            LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda = Monedas.IdMoneda 
            LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento 
            LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento 
            LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra 
            LEFT OUTER JOIN Articulos ON DetPed.IdArticulo=Articulos.IdArticulo 
            LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=DetPed.IdUnidad " + "\r\n" +
            String.Format("Where DetPed.IdPedido={0} ", idPedido) +
            "Order By DetPed.NumeroItem";
    }

    private string SelectPedido(string numeroPedido)
    {
        string select =
            @"SELECT 
            Pedidos.IdPedido, 
            Pedidos.CodigoControl,
            Pedidos.NumeroPedido, 
            Empresa.Nombre as Empresa,
            Empresa.DetalleNombre as DetalleEmpresa,
            Empresa.Direccion as DireccionCentral,
            Empresa.DatosAdicionales1 as DireccionPlanta,
            Empresa.Telefono1 + ' / ' + Empresa.Telefono2 as TelefonosEmpresa,
            Proveedores.RazonSocial as Proveedor,
            Proveedores.Direccion as Direccion,
            Localidades.Nombre as Localidad,
            Proveedores.Contacto as Contacto,
            Proveedores.Telefono1 as Telefono,
            DescripcionIva.Descripcion as CondicionIva,
            [Condiciones Compra].Descripcion as AclaracionCondicion,
            Proveedores.Email as EmailProveedor,
            Proveedores.Fax as Fax,
            Proveedores.Cuit as CuitProveedor,
            Empleados.Nombre as Comprador, 
            Empleados.Email as EmailComprador, 
            Pedidos.NumeroComparativa as NumeroComparativa,
            Empleados.Interno as TelefonoComprador,
            (Select Top 1 Emp.Nombre From Empleados Emp Where Emp.IdEmpleado=Pedidos.Aprobo) as Aprobo,
            Pedidos.Importante,
            Pedidos.ImprimeImportante,
            Pedidos.PlazoEntrega,
            Pedidos.ImprimePlazoEntrega,
            Pedidos.LugarEntrega,
            Pedidos.ImprimeLugarEntrega,
            Pedidos.FormaPago,
            Pedidos.ImprimeFormaPago,
            Pedidos.Garantia,
            Pedidos.ImprimeGarantia,
            Pedidos.Documentacion,
            Pedidos.ImprimeDocumentacion,
            Pedidos.Observaciones,
            'SI' as ImprimeObservaciones,

            (Select Top 1 E.Iniciales 
             From AutorizacionesPorComprobante apc 
             Left Outer Join Empleados E On E.IdEmpleado=apc.IdAutorizo
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=1 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Firma1],
            (Select Top 1 apc.FechaAutorizacion 
             From AutorizacionesPorComprobante apc 
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=1 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Fecha1],

            (Select Top 1 E.Iniciales 
             From AutorizacionesPorComprobante apc 
             Left Outer Join Empleados E On E.IdEmpleado=apc.IdAutorizo
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=2 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Firma2],
            (Select Top 1 apc.FechaAutorizacion 
             From AutorizacionesPorComprobante apc 
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=2 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Fecha2],

            (Select Top 1 E.Iniciales 
             From AutorizacionesPorComprobante apc 
             Left Outer Join Empleados E On E.IdEmpleado=apc.IdAutorizo
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=3 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Firma3],
            (Select Top 1 apc.FechaAutorizacion 
             From AutorizacionesPorComprobante apc 
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=3 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Fecha3],

            (Select Top 1 E.Iniciales 
             From AutorizacionesPorComprobante apc 
             Left Outer Join Empleados E On E.IdEmpleado=apc.IdAutorizo
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=4 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Firma4],
            (Select Top 1 apc.FechaAutorizacion 
             From AutorizacionesPorComprobante apc 
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=4 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Fecha4],

            (Select Top 1 E.Iniciales 
             From AutorizacionesPorComprobante apc 
             Left Outer Join Empleados E On E.IdEmpleado=apc.IdAutorizo
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=5 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Firma5],
            (Select Top 1 apc.FechaAutorizacion 
             From AutorizacionesPorComprobante apc 
             Where apc.IdFormulario=4 and apc.OrdenAutorizacion=5 and 
                apc.IdComprobante=Pedidos.IdPedido) as [Fecha5]

            FROM Pedidos
            LEFT OUTER JOIN Empresa ON Empresa.IdEmpresa=1
            LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = Pedidos.IdComprador 
            LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor 
            LEFT OUTER JOIN Localidades ON Localidades.IdLocalidad = Proveedores.IdLocalidad 
            LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva = Proveedores.IdCodigoIva 
            LEFT OUTER JOIN [Condiciones Compra] ON [Condiciones Compra].IdCondicionCompra = Proveedores.IdCondicionCompra ";
        return select + String.Format(" Where NumeroPedido = {0} ", numeroPedido);
    }

    private void Reemplaza(ref string contenido, string prefix, string id, DataRow row)
    {
        contenido = contenido.Replace(prefix + id, row[id].ToString());
    }

    private void Reemplaza(ref string contenido, string prefix, string id, string val)
    {
        contenido = contenido.Replace(prefix + id, val);
    }

    private void AgregaLineaAdicional(DataRow row, string fieldName, string titulo, ref int nroLinea, ref string contenido)
    {
        if (row["Imprime" + fieldName].ToString() == "SI" &&
            row[fieldName].ToString() != "")
        {
            Reemplaza(ref contenido, "#", "Titulo" + nroLinea.ToString(), (nroLinea-1).ToString() + " - " + titulo + ":");
            Reemplaza(ref contenido, "#", "Contenido" + nroLinea.ToString(), row[fieldName].ToString());
            nroLinea++;
        }
    }

    private void CargaDatosDocumento(ref string contenido)
    {
        Database db = new Database("Empresa" + Session["EmpresaSeleccionada"]);
        SelectPedido(pedido.Value);

        DataSet dsPedido = db.GetDataSet(SelectPedido(pedido.Value));
        int idPedido = (int)(dsPedido.Tables[0].Rows[0]["IdPedido"]);
        long codigoControl = Convert.ToInt64(dsPedido.Tables[0].Rows[0]["CodigoControl"]);
        DataSet dsDetalles = db.GetDataSet(SelectDetallesPedido(idPedido));


        DataRow row = dsPedido.Tables[0].Rows[0];
        // Proveedor
        Reemplaza(ref contenido, "#", "Empresa", row);
        Reemplaza(ref contenido, "#", "DetalleEmpresa", row);
        Reemplaza(ref contenido, "#", "Proveedor", row);
        Reemplaza(ref contenido, "#", "Contacto", row);
        Reemplaza(ref contenido, "#", "DireccionCentral", row);
        Reemplaza(ref contenido, "#", "Telefono", row);
        Reemplaza(ref contenido, "#", "Proveedor", row);
        Reemplaza(ref contenido, "#", "Fax", row);
        Reemplaza(ref contenido, "#", "DireccionPlanta", row);
        Reemplaza(ref contenido, "#", "TelefonosEmpresa", row);
        Reemplaza(ref contenido, "#", "Direccion", row);
        Reemplaza(ref contenido, "#", "Localidad", row);
        Reemplaza(ref contenido, "#", "EmailProveedor", row);
        Reemplaza(ref contenido, "#", "CuitProveedor", row);
        Reemplaza(ref contenido, "#", "CondicionIva", row);
        Reemplaza(ref contenido, "#", "AclaracionCondicion", row);
        Reemplaza(ref contenido, "#", "NumeroPedido", row);
        Reemplaza(ref contenido, "#", "Fecha1", row);
        Reemplaza(ref contenido, "#", "Firma1", row);
        Reemplaza(ref contenido, "#", "Fecha2", row);
        Reemplaza(ref contenido, "#", "Firma2", row);
        Reemplaza(ref contenido, "#", "Fecha3", row);
        Reemplaza(ref contenido, "#", "Firma3", row);
        Reemplaza(ref contenido, "#", "Fecha4", row);
        Reemplaza(ref contenido, "#", "Firma4", row);
        Reemplaza(ref contenido, "#", "Fecha5", row);
        Reemplaza(ref contenido, "#", "Firma5", row);

        int lineaAdicional = 1;
        AgregaLineaAdicional(row, "Importante", "Importante", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "PlazoEntrega", "Plazo de entrega", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "LugarEntrega", "Lugar de entrega", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "FormaPago", "Forma de pago", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "Garantia", "Garantía", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "Documentacion", "Documentación", ref lineaAdicional, ref contenido);
        AgregaLineaAdicional(row, "Observaciones", "Observaciones", ref lineaAdicional, ref contenido);

        for (int i = lineaAdicional; i <= 7; i++)
        {
            Reemplaza(ref contenido, "#", "Titulo" + i.ToString(), "");
            Reemplaza(ref contenido, "#", "Contenido" + i.ToString(), "");
        }

        //Codigo de barras
        Reemplaza(ref contenido, "#", "CODIGOBARRAS",
            "<w:pict><v:shapetype id=\"_x0000_t75\" coordsize=\"21600,21600\" o:spt=\"75\" o:preferrelative=\"t\" path=\"m@4@5l@4@11@9@11@9@5xe\" filled=\"f\" stroked=\"f\"><v:stroke joinstyle=\"miter\"/><v:formulas><v:f eqn=\"if lineDrawn pixelLineWidth 0\"/><v:f eqn=\"sum @0 1 0\"/><v:f eqn=\"sum 0 0 @1\"/><v:f eqn=\"prod @2 1 2\"/><v:f eqn=\"prod @3 21600 pixelWidth\"/><v:f eqn=\"prod @3 21600 pixelHeight\"/><v:f eqn=\"sum @0 0 1\"/><v:f eqn=\"prod @6 1 2\"/><v:f eqn=\"prod @7 21600 pixelWidth\"/><v:f eqn=\"sum @8 21600 0\"/><v:f eqn=\"prod @7 21600 pixelHeight\"/><v:f eqn=\"sum @10 21600 0\"/></v:formulas><v:path o:extrusionok=\"f\" gradientshapeok=\"t\" o:connecttype=\"rect\"/><o:lock v:ext=\"edit\" aspectratio=\"t\"/></v:shapetype>" +
            "<w:binData w:name=\"wordml://02000002.jpg\">" + "\r\n" +
            GeneraCodigoBarras(codigoControl.ToString()) + "\r\n" +
            String.Format("</w:binData><v:shape id=\"_x0000_i1025\" type=\"#_x0000_t75\" style=\"{0}\"><v:imagedata src=\"wordml://02000002.jpg\" o:title=\"CodigoBarras\"/></v:shape></w:pict>",
            "width:112.5pt;height:37.5pt"));

        // Empleados
        Reemplaza(ref contenido, "#", "Comprador", row);
        Reemplaza(ref contenido, "#", "TelefonoComprador", row);
        Reemplaza(ref contenido, "#", "EmailComprador", row);
        Reemplaza(ref contenido, "#", "NumeroComparativa", row);

        string fila = GetFila(contenido);
        string contenidoFilas = "";
        decimal total = 0;
        decimal totalIva = 0;
        foreach (DataRow rowD in dsDetalles.Tables[0].Rows)
        {
            string filaActual = fila;
            decimal precio = ((decimal)rowD["Precio"]);
            decimal cantidad = ((decimal)rowD["Cantidad"]);
            decimal bonificacion = (rowD["ImporteBonificacion"] == DBNull.Value)? 0: ((decimal)rowD["ImporteBonificacion"]);
            decimal iva = (rowD["ImporteIva"] == DBNull.Value) ? 0 : ((decimal)rowD["ImporteIva"]);
            decimal totalParcial = (precio * cantidad) - bonificacion;
            total += totalParcial;
            totalIva += iva;
            Reemplaza(ref filaActual, "", "NumeroItem", rowD);
            Reemplaza(ref filaActual, "", "Cantidad", rowD);
            Reemplaza(ref filaActual, "", "Precio", precio.ToString("c"));
            Reemplaza(ref filaActual, "", "Unidad", rowD);
            Reemplaza(ref filaActual, "Dato", "Total", totalParcial.ToString("c"));
            Reemplaza(ref filaActual, "Dato", "Obra", rowD);
            Reemplaza(ref filaActual, "Dato", "Bon", rowD);
            Reemplaza(ref filaActual, "Dato", "Iva", rowD);
            Reemplaza(ref filaActual, "Dato", "Codigo", rowD);
            Reemplaza(ref filaActual, "Dato", "Rm", "?");
            Reemplaza(ref filaActual, "Dato", "Material", rowD);
            //Reemplaza(ref filaActual, "", "EquipoDestino", rowD);
            contenidoFilas += filaActual;
        }

        Reemplaza(ref contenido, "#", "SubtotalPedido", total.ToString("c"));
        Reemplaza(ref contenido, "#", "TotalIva", totalIva.ToString("c"));
        Reemplaza(ref contenido, "#", "TotalPedido", (total + totalIva).ToString("c"));

        ReemplazaFilas(ref contenido, contenidoFilas);
    }

    private string GeneraCodigoBarras(string codigo)
    {
        const int ancho = 300;
        const int alto = 100;

        System.Drawing.Image img = new Bitmap(ancho, alto);
        Graphics g = Graphics.FromImage(img);

        Font font = new Font("Code 128AB Tall", 52, FontStyle.Regular);
        SizeF size = g.MeasureString(codigo, font);

        float x = (ancho - size.Width) / 2;
        float y = (alto - size.Height) / 2;

        g.FillRectangle(Brushes.White, 0, 0, ancho, alto);
        g.DrawString(codigo, font, Brushes.Black, x, y);

        MemoryStream memStream = new MemoryStream();
        img.Save(memStream, ImageFormat.Jpeg);
        //img.Save(GetPathDoc(GetNombrePedido() + ".jpg"), ImageFormat.Jpeg);
        return Convert.ToBase64String(memStream.ToArray());
    }

    public string GetUrlDoc(string docName)
    {
        string path = Request.Url.GetLeftPart(UriPartial.Path);
        int posBarra = path.LastIndexOf("/");
        return path.Remove(posBarra, path.Length - posBarra) + "/Documentos/" + docName;
    }

    public string GetPathDoc(string docName)
    {
        string path = Server.MapPath("");
        return path + "\\Documentos\\" + docName;
    }

    private void GeneraDocumento()
    {
        
        
        string contenido;

        try
        {
            contenido = Utils.ReadTextFile(GetPathDoc(String.Format("Pedido_{0}.xml",
            Session["EmpresaSeleccionada"])));
            CargaDatosDocumento(ref contenido);
            Utils.WriteTextFile(GetPathDoc(GetDocName()), contenido);
        }
        catch { }
        

          
    }

    public string GetUrlDoc()
    {
        GeneraDocumento();
        return GetUrlDoc(GetDocName()); 
    }

    private string GetNombrePedido()
    {
        return pedido.Value.PadLeft(8, '0');
    }

    public string GetDocName()
    {
        return "Pedido" + GetNombrePedido() + ".xml";
    }
}
