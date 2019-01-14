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
    public partial class Bookings : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetBookingInfo();
            }
        }

        private void GetBookingInfo() 
        {
            RentInfoModel rentInfo = new RentInfoModel();
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_Get_Booking_List_by_Id", conn);
            cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
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
            this.GetBookingInfo();
        }
    }
}