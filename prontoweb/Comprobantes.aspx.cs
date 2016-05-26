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
using System.Data.SqlClient;
using EntityFactory;

public partial class Comprobantes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     
        
        if (!Page.IsPostBack)
        {


            //Database db = new Database("testConnection");
            //Database db = new Database(  "Empresa" + Session["EmpresaSeleccionada"]);


            //////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////
            // El objeto Database es de la biblioteca de fido. No lo uses
            String SC;
            Usuario u;
            u = (Usuario)Session["USUARIO"];
            SC = u.StringConnection;

            if (!(Session["glbWebIdProveedor"] != null)) return; //el usuario tiene que ser un proveedor

                       
            DataSet ds=new DataSet();
            SqlConnection myConnection = new SqlConnection(ProntoFuncionesUIWeb.EncriptarParaCSharp(SC));

            SqlCommand myCommand = new SqlCommand(String.Format("exec wCtasCtesA_TXPorMayorParaInfoProv {0}", Session["glbWebIdProveedor"]), myConnection);
            myCommand.CommandType = CommandType.Text;
            //myCommand.Parameters.AddWithValue("@IdPresupuesto", -2);
            myConnection.Open();
            SqlDataAdapter DA = new SqlDataAdapter(myCommand);
            DA.Fill(ds);

            //////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////


            

            //DataSet ds = db.GetDataSetSP("ProntoWeb_DebeHaberSaldo", new System.Data.Common.DbParameter[] { db.NewParameter("IdProveedor", DbType.Int32, Session["glbWebIdProveedor"]) });

            //DataSet ds = db.GetDataSet(String.Format(
            //    "select TipoComprobante, NumeroComprobante, CONVERT(CHAR(10),Fecha,103) AS Fecha, Debe, Haber, (CASE WHEN Debe IS NULL THEN -Haber WHEN Haber IS NULL THEN Debe ELSE Debe-Haber END) AS Saldo, CONVERT(CHAR(10),FechaComprobante,103) AS FechaComprobante from Comprobantes where IdProveedor = {0} ORDER BY FechaComprobante DESC", p.IdProveedor));
            //DataView dv = new DataView(ds.Tables[0]);
            gridComprobantes.DataSource = ds.Tables[0];
            gridComprobantes.DataBind();
            Label1.Text = Session["glbWebRazonSocial"].ToString(); 

                    


  


        }
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
        //gridComprobantes.PageIndex = e.NewPageIndex;
        //gridComprobantes.DataBind();
    }
}

