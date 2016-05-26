using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EntityFactory;

public partial class CertificadoSUSS : System.Web.UI.Page
{
    private string idOP;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (PreviousPage == null && !IsPostBack)
            Response.Redirect("Login.aspx");
        idOP = Request.QueryString["IdOP"];
        //idOrdenPago.Value = PreviousPage.IdOrdenPago.Trim();
    }

    private void Reemplaza(ref string contenido, string prefix, string id, DataRow row)
    {
        contenido = contenido.Replace(prefix + id, row[id].ToString());
    }

    private void Reemplaza(ref string contenido, string prefix, string id, string val)
    {
        contenido = contenido.Replace(prefix + id, val);
    }

    private void CargaDatosDocumento(ref string contenido)
    {
        //Database db = new Database("Empresa" + Session["EmpresaSeleccionada"]);
        //System.Data.Common.DbParameter[] parameters = new System.Data.Common.DbParameter[] { db.NewParameter("IdOrdenPago", DbType.Int32, Convert.ToInt32(idOP/*idOrdenPago.Value*/)) };
        //DataSet ds = db.GetDataSetSP("ProntoWeb_CertificadoSUSS_DatosPorIdOrdenPago", parameters);


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
        "exec ProntoWeb_CertificadoGanancias_DatosPorIdOrdenPago {0} ", idOP), myConnection);
        myCommand.CommandType = CommandType.Text;
        //myCommand.Parameters.AddWithValue("@IdPresupuesto", -2);
        myConnection.Open();
        SqlDataAdapter DA = new SqlDataAdapter(myCommand);
        DA.Fill(ds);

        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////

        if (ds.Tables[0].Rows.Count == 0) return;

        DataRow row = ds.Tables[0].Rows[0];

        Reemplaza(ref contenido, "#", "NumeroCertificado", row);
        Reemplaza(ref contenido, "#", "Fecha", DateTime.Today.ToString("dd/MM/yyyy"));
        Reemplaza(ref contenido, "#", "NombreAgente", row);
        Reemplaza(ref contenido, "#", "CuitAgente", row);
        Reemplaza(ref contenido, "#", "DomicilioAgente", row);
        Reemplaza(ref contenido, "#", "NombreSujeto", row);
        Reemplaza(ref contenido, "#", "CuitSujeto", row);
        Reemplaza(ref contenido, "#", "DomicilioSujeto", row);
        Reemplaza(ref contenido, "#", "Comprobante", row);
        Reemplaza(ref contenido, "#", "MontoComprobante", row);
        Reemplaza(ref contenido, "#", "%Aplicado", row);
        Reemplaza(ref contenido, "#", "Retenido", row);
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
        string contenido = Utils.ReadTextFile(GetPathDoc("CertificadoSUSS.xml"));
        CargaDatosDocumento(ref contenido);
        Utils.WriteTextFile(GetPathDoc(GetDocName()), contenido);
    }

    public string GetUrlDoc()
    {
        GeneraDocumento();
        return GetUrlDoc(GetDocName());
    }

    private string GetNombreDocumento()
    {
        return /*idOrdenPago.Value*/idOP.PadLeft(10, '0');
    }

    public string GetDocName()
    {
        return "SUSS" + GetNombreDocumento() + ".xml";
    }
}
