using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EntityFactory;

public partial class NotasDePedido : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();



        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////
        // El objeto Database es de la biblioteca de fido. No lo uses
        String SC;
        Usuario u;
        u = (Usuario)Session["USUARIO"];
        SC = u.StringConnection;

        if (!(Session["glbWebIdProveedor"] != null)) return; //el usuario tiene que ser un proveedor

        DataSet ds = new DataSet();
        SqlConnection myConnection = new SqlConnection(ProntoFuncionesUIWeb.EncriptarParaCSharp(SC));

        SqlCommand myCommand = new SqlCommand(String.Format(
        @"SELECT 
         Pedidos.IdPedido,
         Case When Pedidos.SubNumero is not null and Pedidos.SubNumero<>0 
	        Then str(Pedidos.NumeroPedido,8)+' /'+str(Pedidos.SubNumero,2)
	        Else str(Pedidos.NumeroPedido,8)
         End as [Pedido],
         FechaPedido [Fecha],
         Bonificacion,
         (TotalPedido - TotalIva1) as NetoGravado,
         TotalIva1 as TotalIva,
         TotalIva2,
         TotalPedido,
         Monedas.Nombre as Moneda,
         count(*) as Items
        FROM Pedidos
        LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
        LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Pedidos.IdMoneda
        WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN'and 
	        IsNull(Pedidos.Cumplido,'NO')<>'SI' and 
	        /*  Cómo funcionaba esto? Lo saqué para la demo
            IsNull((Select Count(*) From DetalleAutorizaciones da 
		        Left Outer Join Autorizaciones On Autorizaciones.IdAutorizacion=da.IdAutorizacion
		        Where Autorizaciones.IdFormulario=4),0)<=
	        IsNull((Select Count(*) From AutorizacionesPorComprobante apc 
		        Where apc.IdFormulario=4 and apc.IdComprobante=Pedidos.IdPedido),0) and 
	        */
            Pedidos.IdProveedor={0}
        group by
         Pedidos.IdPedido,
         Pedidos.SubNumero,
         Pedidos.NumeroPedido,
         FechaPedido,
         Bonificacion,
         TotalIva1,
         TotalIva2,
         TotalPedido,
         Monedas.Nombre
        ORDER BY FechaPedido DESC, NumeroPedido DESC,SubNumero DESC"
        , Session["glbWebIdProveedor"]),myConnection); 
        myCommand.CommandType = CommandType.Text;
        //myCommand.Parameters.AddWithValue("@IdPresupuesto", -2);
        myConnection.Open();
        SqlDataAdapter DA = new SqlDataAdapter(myCommand);
        DA.Fill(ds);

        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////


        gridComprobantes.DataSource = ds.Tables[0];
        gridComprobantes.DataBind();
        Label1.Text = Session["glbWebRazonSocial"].ToString(); 
    }
    
    protected void gridComprobantes_Sorted(object sender, EventArgs e)
    {
        // Clear selected index
        gridComprobantes.SelectedIndex = -1;
    }

    protected void gridComprobantes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (gridComprobantes.SelectedIndex != -1)
        {
            ViewState["SelectedValue"] = gridComprobantes.SelectedValue.ToString();
        }
    }

    protected void gridComprobantes_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable m_DataTable = gridComprobantes.DataSource as DataTable;

        if (m_DataTable != null)
        {
            DataView m_DataView = new DataView(m_DataTable);
            m_DataView.Sort = e.SortExpression + " " + GetSortDirection();

            gridComprobantes.DataSource = m_DataView;
            gridComprobantes.DataBind();
        }
    }

    private string GridViewSortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "DESC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private string GetSortDirection()
    {
        switch (GridViewSortDirection)
        {
            case "ASC":
                GridViewSortDirection = "DESC";
                break;

            case "DESC":
                GridViewSortDirection = "ASC";
                break;
        }

        return GridViewSortDirection;
    }

    protected void gridComprobantes_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridComprobantes.PageIndex = e.NewPageIndex;
        gridComprobantes.DataBind();
    }

    protected void lbPedido_Command(object sender, CommandEventArgs e)
    {
        pedido.Value = (string)e.CommandArgument;
    }

    public string Pedido
    {
        get { return pedido.Value; }
    }

}

