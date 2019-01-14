using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookingSystemWeb
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SessionUserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Redirect("Home.aspx");
            }
        }
    }
}