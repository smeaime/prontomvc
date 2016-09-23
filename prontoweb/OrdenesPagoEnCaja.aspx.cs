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
using Pronto.ERP.BO;

public partial class OrdenesPagoEnCaja : System.Web.UI.Page
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
        "exec wOrdenesPago_TX_EnCajaPorProveedor {0} ", Session["glbWebIdProveedor"]),myConnection);
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

    protected void lbRetencion_Command(object sender, CommandEventArgs e)
    {
        idOrdenPago.Value = (string)e.CommandArgument;
    }

    public string IdOrdenPago
    {
        get { return idOrdenPago.Value; }
    }

    protected bool GetVisibility(object value)
    {
        if (value == null || value == DBNull.Value)
            return false;
        double val = Convert.ToDouble(value);
        return true; // MARIANO DEBUG : TO DO TODO : estoy forzando que aparezca el link de impresion de certificado
        return val > 0.0000000000001 || val < -0.000000000000000000001;

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
}






