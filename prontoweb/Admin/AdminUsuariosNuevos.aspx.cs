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
using System.IO;
using System.Net;
using System.Net.Mail;
using System.ComponentModel;
using System.Text.RegularExpressions;
using EntityFactory;

public partial class AdminUsuariosNuevos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        grdUsuariosNuevos.DataSource = Membership.GetAllUsers();
        grdUsuariosNuevos.DataBind();
    }

    private void SendMail(string userName, string adminMail, string email, string password, bool sendMailToUser)
    {
        string from = adminMail;
        string to;
        string Cc = "";
        if (sendMailToUser)
        {
            to = email;
            Cc = adminMail;
        }
        else
            to = adminMail;
        string subject = "Su Empresa - Consulta de pagos via WEB";



        string body = String.Format(

@"Estimado proveedor, Ud. ya posee una cuenta ProntoWeb asociada al mail {2}, puede consultar sus pagos a trav�s de la web en:

http://suempresa.com.ar/infoprov

Los datos para ingresar al sistema son los siguientes:

Nombre de usuario: {0}
Contrasena: {1}", 
                 
                 userName, password, email);


        MailMessage objMsg = new MailMessage(from, to, subject, body);

        if (Cc != "")
           objMsg.CC.Add(Cc);

        SmtpClient SmtpMail = new SmtpClient();
        //SmtpMail.DeliveryMethod = SmtpDeliveryMethod.
        //SmtpMail.PickupDirectoryLocation
        //SmtpMail.Credentials = 
        //SmtpMail.ClientCertificates = new System.Security.Cryptography.X509Certificates.X509CertificateCollection()
        //SmtpMail.UseDefaultCredentials
        //SmtpMail.ServicePoint = new ServicePoint
        //SmtpMail.Credentials = new System.Net.NetworkCredential("usuario", "password");

        SmtpMail.Send(objMsg);
    }

    public bool ValidateEmail(string sEmail)
    {
        Regex exp = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");

        Match m = exp.Match(sEmail);
        if (m.Success && m.Value.Equals(sEmail)) 
            return true;
        else 
            return false;
    }
	private string EscapaComillaSQL(string str)
	{
		return str.Replace("'","'+CHAR(39)+'");
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

    private static string ReadTextFile(string fileName)
    {
        string result = "";
        TextReader tr = new StreamReader(fileName);
        try
        {
            result = tr.ReadToEnd();
        }
        finally
        {
            tr.Close();
        }
        return result;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Database db = new Database();

        string trace = "";
        string ultimoDato = "";

        try
        {
            if (CheckBox2.Checked)
            {
                trace += "Previo a Borrar\r\n";
                MembershipUserCollection users = Membership.GetAllUsers();
                foreach (MembershipUser u in users)
                {
                    if(u.UserName.ToLower() != "administrador")
                    {
                       Membership.DeleteUser(u.UserName);
                    }
                }
            }

            trace += "Previo al GetDataSet\r\n";

            //DataSet ds = db.GetDataSet(
            //"select Email, Cuit, IdProveedor from Proveedores where (NOT (Email IS NULL)) AND (NOT (Cuit IS NULL)) AND (NOT (IdProveedor IS NULL)) AND (NOT (Email = '')) AND (NOT (Cuit = ''))");

            DataSet ds = db.GetDataSetSP("ProntoWeb_TodosLosUsuarios");
            trace += "Previo al foreach\r\n";

            string lastCuit = "";
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                object oCuit = row["Cuit"];
                if (oCuit == null || oCuit == DBNull.Value)
                    continue;

                string cuit = oCuit.ToString();

                if (cuit == lastCuit)
                    continue;

                lastCuit = cuit;

                if (cuit.Trim() == "")
                    continue;

                string email = row["Email"].ToString();
                string idProveedor = row["IdProveedor"].ToString();
                string razonSocial = row["RazonSocial"].ToString();


                ultimoDato = idProveedor;

                /*
                if (CheckBox2.Checked && Membership.GetUser(cuit) != null)
                    Membership.DeleteUser(cuit);
                */

                if (Membership.GetUser(cuit) == null)
                {
                    if (!ValidateEmail(email))
                        continue;

                    string password = Membership.GeneratePassword(12, 6);
                    password = password.Replace('@','&');

                    ultimoDato += " : " + password;

                    MembershipCreateStatus status;
                    MembershipUser user =
                        Membership.CreateUser(
                                          cuit,
                                          "administrador!",
                                          email,
                                          "Pregunte al administrador del sistema la respuesta",
                                          cuit, // respuesta (cambiado por krasel, antes era password)
                                          true,
                                          out status);

                    ultimoDato += " : " + user.Email;

                    if (status != MembershipCreateStatus.Success)
                            throw new Exception("La creaci�n de un usuario fall� debido al siguiente estado: " + status.ToString());

                    ultimoDato += " : va a AddUserToRole";
                    Roles.AddUserToRole(user.UserName, "UsuarioFinal");

                    ultimoDato += " : volvio de AddUserToRole";

					string sqlSentence = String.Format(
						"delete from UsuariosWeb where UserName = '{0}'; Insert into UsuariosWeb (UserId,UserName,IdProveedor,RazonSocial) values ('{1}','{0}',{2},'{3}')",
						user.UserName,
						user.ProviderUserKey.ToString(),
						idProveedor,
						EscapaComillaSQL(razonSocial));


                    try
                    {
                        db.Execute(sqlSentence);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Error en query: " + sqlSentence, ex);
                    }

                    ultimoDato += " : " + "va a buscar Utils.EmailAdmin";

                    /*
                     * MARIANO
                    string adminEmail = Utils.EmailAdmin;
                    */

                    ultimoDato += " : " + "va a send mail";

                    /*SendMail(user.UserName,
                             adminEmail, 
                             user.Email.ToLower(), 
                             password, 
                             CheckBox1.Checked);*/
                   }
            }
        }
        catch (Exception ex)
        {
            //Utils.WriteToEventLog(ex.ToString + "\r\n" + ex.InnerException, System.Diagnostics.EventLogEntryType.Error);
            throw new Exception (trace + " / " + ultimoDato,ex);
        }
    }

    protected void grdUsuariosNuevos_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdUsuariosNuevos.PageIndex = e.NewPageIndex;
        grdUsuariosNuevos.DataBind();
    }

    protected void grdUsuariosNuevos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (grdUsuariosNuevos.SelectedIndex != -1)
        {
            ViewState["SelectedValue"] = grdUsuariosNuevos.SelectedValue.ToString();
        }
    }

    protected void grdUsuariosNuevos_Sorted(object sender, EventArgs e)
    {
        grdUsuariosNuevos.SelectedIndex = -1;
    }

    protected void grdUsuariosNuevos_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable m_DataTable = grdUsuariosNuevos.DataSource as DataTable;

        if (m_DataTable != null)
        {
            DataView m_DataView = new DataView(m_DataTable);
            m_DataView.Sort = e.SortExpression + " " + GetSortDirection();

            grdUsuariosNuevos.DataSource = m_DataView;
            grdUsuariosNuevos.DataBind();
        }
    }
}
