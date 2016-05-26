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

using EntityFactory;

public partial class CreaUsuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList dropEmpresas = ((DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("IdProveedor"));
            Database db = new Database();
            dropEmpresas.DataSource = db.GetDataSet("select RazonSocial, IdProveedor from Proveedores");
            dropEmpresas.DataTextField = "RazonSocial";
            dropEmpresas.DataValueField = "IdProveedor";
            dropEmpresas.DataBind();
        }
        CreateUserWizard1.MailDefinition.CC = Utils.EmailCC;
        CreateUserWizard1.MailDefinition.From = Utils.EmailFrom;
    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        // MARIANO
        //// Create an empty Profile for the newly created user
        //ProfileCommon p = (ProfileCommon)ProfileCommon.Create(CreateUserWizard1.UserName, true);

        //// Populate some Profile properties off of the create user wizard
        //p.IdProveedor = Convert.ToInt32(((DropDownList)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("IdProveedor")).SelectedValue);

        //// Save profile - must be done since we explicitly created it
        //p.Save();

        //MembershipUser user = Membership.GetUser(CreateUserWizard1.UserName);

        //Database db = new Database();
        //string sentence = String.Format("insert into UsuariosWeb (UserId, UserName, IdProveedor) values ('{0}','{1}',{2})",
        //    user.ProviderUserKey.ToString(),
        //    user.UserName,
        //    p.IdProveedor);
        //db.Execute(sentence);
    }
}
