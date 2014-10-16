using System.Collections.Generic;
using System.Web.Security;

namespace ProntoMVC.Areas.MvcMembership.Models.UserAdministration
{
	public class EmpresaViewModel
	{
		public string Empresa { get; set; }
		public IDictionary<string, MembershipUser> Users { get; set; }
	}
}
