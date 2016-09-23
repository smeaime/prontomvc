using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //ComDocumentos.Documentos doc = new ComDocumentos.Documentos();
        //doc.StringConexion = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=sa;Initial Catalog=Pronto;Data Source=localhost;Connect Timeout=45";
        //short mResult = doc.Documentos("Ganancias", "1635", 
        //          @"C:\Pronto\Plantillas\CertificadoRetencionGanancias.dot",
        //          "Word", "",
        //          @"C:\Pronto\Plantillas\CertificadoRetencionGanancias.doc");

            /*
   Dim Aplicacion As ComDocumentos.Documentos
   Dim mResul As Integer
   
   Set Aplicacion = CreateObject("ComDocumentos.Documentos")
   Aplicacion.StringConexion = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=sa;Initial Catalog=Pronto;Data Source=localhost;Connect Timeout=45"
   mResul = Aplicacion.Documentos("Ganancias", 3421, _
                  "C:\Pronto\Plantillas\CertificadoRetencionGanancias.dot", _
                  "Word", "")
   mResul = Aplicacion.Documentos("IIBB", 3421, _
                  "C:\Pronto\Plantillas\CertificadoRetencionIIBB.dot", _
                  "Word", "")
   mResul = Aplicacion.Documentos("IVA", 3421, _
                  "C:\Pronto\Plantillas\CertificadoRetencionIVA.dot", _
                  "Word", "")
   mResul = Aplicacion.Documentos("SUSS", 3421, _
                  "C:\Pronto\Plantillas\CertificadoRetencionSUSS.dot", _
                  "Word", "")
   
   Set Aplicacion = Nothing
             * */

    }
}
