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
    public partial class RentDetails : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);
        string data;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                data = Request.QueryString["RentId"];
                if (String.IsNullOrEmpty(data))
                {
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    GetDetails(data);
                }
            }
        }

        private void GetDetails(string id) 
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
                    RentIdTxt.Text = dt.Rows[0]["RentId"].ToString();
                    RentTitleLabel.Text = dt.Rows[0]["RentTitle"].ToString();
                    AddressLabel.Text = dt.Rows[0]["Address"].ToString();
                    OwnerNameLabel.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString() + " " + dt.Rows[0]["NickName"].ToString();
                    PostedOnLabel.Text = dt.Rows[0]["PostedOn"].ToString();
                    FareLabel.Text = dt.Rows[0]["Fare"].ToString();
                    DescriptionLabel.Text = dt.Rows[0]["Description"].ToString();
                  //  RentStatusLabel.Text = dt.Rows[0]["RentStatus"].ToString();
                    EmailLabel.Text = dt.Rows[0]["Email"].ToString();
                    PhoneLabel.Text = dt.Rows[0]["Phone"].ToString();

                    string ownerId = dt.Rows[0]["OwnerId"].ToString();
                    string bookingStatus = dt.Rows[0]["BookingStatus"].ToString();
                    
                  
                    if (ownerId.Trim() == Session["SessionUserUserId"].ToString().Trim())
                    {
                        ConfirmRentButton.Visible = false;
                        EditRentButton.Visible = true;
                        DeleteRentButton.Visible = true;
                        CancelRentButton.Text = "Back";
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(bookingStatus))
                        {
                            ConfirmRentButton.Visible = true;
                            EditRentButton.Visible = false;
                            DeleteRentButton.Visible = false;
                            CancelRentButton.Text = "Back";
                        }
                        else
                        {
                            if(bookingStatus.Trim().ToUpper()=="P")
                            {
                                AlreadyBookedLabel.Text = "This rent is already booked by you.";
                                ConfirmRentButton.Visible = false;
                                EditRentButton.Visible = false;
                                DeleteRentButton.Visible = false;
                                CancelRentButton.Text = "Cancel Booking";
                            }
                            else if (bookingStatus.Trim().ToLower() == "confirmed")
                            {
                                AlreadyBookedLabel.Text = "Your Booking is Confirmed by the House Owner.";

                                ConfirmRentButton.Visible = false;
                                EditRentButton.Visible = false;
                                DeleteRentButton.Visible = false;
                                CancelRentButton.Text = "Back";
                            }
                            else if (bookingStatus.Trim().ToLower() == "rejected")
                            {
                                AlreadyBookedLabel.Text = "Your Booking is Rejected by the House Owner.";

                                ConfirmRentButton.Visible = false;
                                EditRentButton.Visible = false;
                                DeleteRentButton.Visible = false;
                                CancelRentButton.Text = "Back";
                            }
                            



                        }

                       
                    }
                }
            }

        }

        protected void ConfirmRentButton_Click(object sender, EventArgs e)
        {
            BookNow();
        }

        private void BookNow()
        { 

            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_Booking_Insert_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@BookingId", "0");
            cmd.Parameters.AddWithValue("@RentId", RentIdTxt.Text.ToString().Trim());
            cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
            cmd.Parameters.AddWithValue("@BookingStatus", "P");
            cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();

            string mCode = cmd.Parameters["@msg_code"].Value.ToString();
            string msg = cmd.Parameters["@MSG"].Value.ToString();
            ConfirmBookingTxt.Text = msg;

            if (mCode == "Y")
            {
                PanelRent.Visible = false;
                PanelConfirm.Visible = true;
            }
            conn.Close();

        }


        protected void CancelRentButton_Click(object sender, EventArgs e)
        {
            if(CancelRentButton.Text.Trim()== "Cancel Booking")
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("sp_Booking_Insert_Update", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BookingId", "1");
                    cmd.Parameters.AddWithValue("@RentId", RentIdTxt.Text.ToString().Trim());
                    cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
                    cmd.Parameters.AddWithValue("@BookingStatus", "");
                    cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();

                    string mCode = cmd.Parameters["@msg_code"].Value.ToString();
                    string msg = cmd.Parameters["@MSG"].Value.ToString();
                    ConfirmBookingTxt.Text = msg;

                    if (mCode == "Y")
                    {
                        PanelRent.Visible = false;
                        PanelConfirm.Visible = true;
                    }
                    conn.Close();
                }
                catch(Exception ex)
                {

                }
                
            }
            else
            {
                Response.Redirect("Home.aspx");
            }
           
        }

      

        protected void DeleteRentButton_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_Rent_Delete", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RentId", RentIdTxt.Text.ToString().Trim());
                cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                string mCode = cmd.Parameters["@msg_code"].Value.ToString();
                string msg = cmd.Parameters["@MSG"].Value.ToString();
                ConfirmBookingTxt.Text = msg;

                if (mCode == "Y")
                {
                    PanelRent.Visible = false;
                    PanelConfirm.Visible = true;
                }
                conn.Close();
            }
            catch (Exception ex)
            {

            }
        }

        protected void EditRentButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditRent.aspx?RentId=" + RentIdTxt.Text.Trim());
            
        }

        protected void ButtonHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}