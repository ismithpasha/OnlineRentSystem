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
    public partial class Home : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

            GetRentInfo();
        }

        private void GetRentInfo()
        {
            RentInfoModel rentInfo = new RentInfoModel();
            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_Get_Rent_List", conn);

            cmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(dt);

                lvCustomers.DataSource = dt;
                lvCustomers.DataBind();
                //foreach (DataRow dr in dt.Rows)
                //{


                //    //noticeInfo.NoticeId = dr["NoticeId"].ToString().Trim();
                //    //noticeInfo.PostedBy = dr["PostedByFN"].ToString().Trim() + " " + dr["PostedByLN"].ToString().Trim();
                //    //noticeInfo.GroupId = "";
                //    //noticeInfo.NoticeTitle = dr["NoticeTitle"].ToString().Trim();
                //    //noticeInfo.NoticeDetails = dr["NoticeDetails"].ToString().Trim();
                //    //noticeInfo.PostedOn = dr["PostedOn"].ToString().Trim();
                //    //noticeInfo.UpdatedOn = dr["UpdatedOn"].ToString().Trim();
                //    //noticeInfo.NoticeStatus = "";
                //    //noticeInfo.Remarks = dr["NoticeId"].ToString().Trim();


                //    //noticeInfoList.Add(noticeInfo);

                //}
            }
            conn.Close();

        }

        protected void OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (lvCustomers.FindControl("DataPager1") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.GetRentInfo();
        }
    }
}