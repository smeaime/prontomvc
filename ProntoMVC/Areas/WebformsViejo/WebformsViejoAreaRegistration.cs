using System.Web.Mvc;

namespace ProntoMVC.Areas.WebformsViejo
{
    public class WebformsViejoAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "WebformsViejo";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "WebformsViejo_default",
                "WebformsViejo/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
