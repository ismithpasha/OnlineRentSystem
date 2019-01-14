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
    public partial class CreateRent : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SessionUserEmail"] == null)
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void CreateRentButton_Click(object sender, EventArgs e)
        {
            CreateRentNow();
        }

        void CreateRentNow()
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_Rent_Insert_Update", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RentId", 0);
                cmd.Parameters.AddWithValue("@OwnerId", Session["SessionUserUserId"].ToString().Trim());
                cmd.Parameters.AddWithValue("@RentTitle", RentTitleTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", AddressTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Fare", FareTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Description", DescriptionTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@RentStatus", "Y");
                cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;


                cmd.ExecuteNonQuery();

                string mCode = cmd.Parameters["@msg_code"].Value.ToString();
                string msg = cmd.Parameters["@MSG"].Value.ToString();
                CratePostTitle.Text = msg;
                if (mCode == "Y")
                {
                    PanelCratePost.Visible = false;
                    PanelCratePostConfirm.Visible = true;
                }



            }
            catch (Exception ex)
            {

            }


        }

        protected void ButtonNewPost_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CreateRent.aspx");
        }
    }
}