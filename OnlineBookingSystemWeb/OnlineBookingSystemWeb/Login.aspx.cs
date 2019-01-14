using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookingSystemWeb
{
    public partial class Login : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SessionUserEmail"] == null)
            {

            }
            else
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            ValidateLogin();

        }

        private void ValidateLogin()
        {

            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_User_Login", conn);
            
            cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", PasswordTextBox.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    Session["SessionUserEmail"] = EmailTextBox.Text.ToString().Trim();
                    Session["SessionUserUserId"] = dt.Rows[0]["UserId"].ToString();
                    Session["SessionUserFirstName"] = dt.Rows[0]["FirstName"].ToString();
                    Session["SessionUserFullName"] = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString() + " " + dt.Rows[0]["NickName"].ToString();
                    Session["SessionUserPhone"] = dt.Rows[0]["Phone"].ToString();
                    Session["SessionUserUserType"] = dt.Rows[0]["UserType"].ToString();
                    Session["SessionUserBirthDate"] = dt.Rows[0]["BirthDate"].ToString().Replace("12:00:00 AM", "");
                    Session["SessionUserGender"] = dt.Rows[0]["Gender"].ToString();
    
                    Response.Redirect("~/Home.aspx");
                }
            }
          
        }
    

    }
}