using System.Collections.Generic;
using System.Web.Security;
using PagedList;

namespace ProntoMVC.Areas.MvcMembership.Models.UserAdministration
{
    public class IndexViewModel
    {
        public string Search { get; set; }
//        public IPagedList<MembershipUser> Users { get; set; }
        public List<MembershipUser> Users { get; set; }
        public IEnumerable<string> Roles { get; set; }
        public IEnumerable<string> Empresas { get; set; }
        public bool IsRolesEnabled { get; set; }

        public IEnumerable<UsuarioPronto> UsuariosPronto { get; set; }

        //public Dictionary <string,string> EmpresaUsuario


        public List<ProntoMVC.Data.Models.Bases> BasesPronto { get; set; }


        public string BDLMaster { get; set; }
    }

    public class UsuarioPronto
    {
        public MembershipUser user;
        public string EmpresaDefault;
        public IEnumerable<string> Empresas { get; set; }
    }

}
