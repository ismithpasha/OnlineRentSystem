using OnlineBookingSystemWeb.Models;
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
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadProfileInfo();
            GetRentInfo();
        }

        void LoadProfileInfo() 
        {
           UserEmail.Text = Session["SessionUserEmail"].ToString();
     
            UserFullName.Text = Session["SessionUserFullName"].ToString();
            UserPhone.Text = Session["SessionUserPhone"].ToString();
            UserBirthDate.Text = Session["SessionUserBirthDate"].ToString();

        }

        private void GetRentInfo()
        {
            RentInfoModel rentInfo = new RentInfoModel();
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_Get_Rent_List_by_Id", conn);
            cmd.Parameters.AddWithValue("@OwnerId", Session["SessionUserUserId"].ToString().Trim());
            cmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(dt);

                lvCustomers.DataSource = dt;
                lvCustomers.DataBind();
              
            }
            conn.Close();

        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCustomers.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.GetRentInfo();
        }

        protected void EditProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditProfile.aspx");
        }
    }
}