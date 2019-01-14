using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookingSystemWeb
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["SessionUserEmail"] = null;
            Session["SessionUserUserId"] = null;
            Session["SessionUserFirstName"] = null;
            Session["SessionUserFullName"] = null;
            Session["SessionUserPhone"] = null;
            Session["SessionUserUserType"] = null;
            Session["SessionUserBirthDate"] = null;
            Session["SessionUserGender"] = null;
            Session.Clear();
            Session.RemoveAll();
            Response.Redirect("~/Login.aspx");

        }
    }
}