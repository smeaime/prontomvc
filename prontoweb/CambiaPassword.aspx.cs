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

public partial class CambiaPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ChangePassword1.MailDefinition.CC = Utils.EmailCC;

        // ChangePassword1.MailDefinition.From = "soporte@bdlconsultores.com.ar"; Utils.EmailFrom;





    }



    protected void ChangePassword1_ChangedPassword(object sender, EventArgs e)
    {

       Pronto.ERP.Bll.ErrHandler2.WriteError(ChangePassword1.UserName + ' ' + ChangePassword1.NewPassword);

    }
}

