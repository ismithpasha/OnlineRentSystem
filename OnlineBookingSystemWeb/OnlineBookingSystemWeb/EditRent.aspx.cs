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
    public partial class EditRent : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        string rentId="0";
        protected void Page_Load(object sender, EventArgs e)
        {
          
                rentId = Request.QueryString["RentId"];
                if (String.IsNullOrEmpty(rentId))
                {
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        GetDetails(rentId);
                    }
                }
            
            
        }

        protected void UpdateRentButton_Click(object sender, EventArgs e)
        {
            UpdateRentNow();
        }

        protected void ButtonNewPost_Click(object sender, EventArgs e)
        {

        }

        private void GetDetails(string id)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_Get_Rent_Details", conn);

                cmd.Parameters.AddWithValue("@RentId", id.Trim());
                cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
                cmd.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                using (var da = new SqlDataAdapter(cmd))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        RentTitleTextBox.Text = dt.Rows[0]["RentTitle"].ToString();
                        AddressTextBox.Text = dt.Rows[0]["Address"].ToString();

                        FareTextBox.Text = dt.Rows[0]["Fare"].ToString();
                        DescriptionTextBox.Text = dt.Rows[0]["Description"].ToString();

                    }
                }
                conn.Close();
            }
            catch(Exception ex)
            {

            }
           

        }
        void UpdateRentNow() 
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_Rent_Insert_Update", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RentId", rentId);
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
                  
                }

                conn.Close();
                GetDetails(rentId);
            }
            catch (Exception ex)
            {

            }


        }


    }
}