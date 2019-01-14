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
    public partial class ConfirmRent : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);
        string bookingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            bookingId = Request.QueryString["BookingId"];
            if (!IsPostBack)
            {
                
                if (String.IsNullOrEmpty(bookingId))
                {
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    GetDetails(bookingId); 
                }
            }
        }

        private void GetDetails(string id)
        {

            conn.Open();
            SqlCommand cmd = new SqlCommand("sp_Get_Booking_Details", conn);

            cmd.Parameters.AddWithValue("@BookingId", id.Trim());
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

                    bookingId = dt.Rows[0]["BookingId"].ToString();
                    string ownerId = dt.Rows[0]["OwnerId"].ToString();
                    string bookingStatus = dt.Rows[0]["BookingStatus"].ToString();
                    string rentStatus = dt.Rows[0]["RentStatus"].ToString().Trim();
                    

                    if (String.IsNullOrEmpty(rentStatus))
                        {

                        }
                        else if (rentStatus.ToLower() == "confirmed")
                        {
                          
                           if (bookingStatus.Trim().ToLower() == "confirmed")
                                {
                                    AlreadyBookedLabel.Text = "Your Booking is Confirmed by the House Owner.";

                                    ConfirmRentButton.Visible = false;
                                    DeleteRentButton.Visible = false;
                                    CancelRentButton.Text = "Back";

                                    if (ownerId.Trim() == Session["SessionUserUserId"].ToString().Trim())
                                        {
                                            AlreadyBookedLabel.Text = "This Rent is confirmed to: "+ OwnerNameLabel.Text.ToString();
                                            DeleteRentButton.Visible = true;
                                            DeleteRentButton.Text = "Reject and Re-open Rent";
                                            CancelRentButton.Text = "Back";
                                        }

                                 }
                                else if (bookingStatus.Trim().ToLower() == "rejected")
                                {
                                        AlreadyBookedLabel.Text = "Your Rent is Rejected by the House Owner.";

                                        ConfirmRentButton.Visible = false;
                                        DeleteRentButton.Visible = false;
                                        CancelRentButton.Text = "Back";
                                    if (ownerId.Trim() == Session["SessionUserUserId"].ToString().Trim())
                                    {
                                        AlreadyBookedLabel.Text = "This Rent is confirmed to another user.";
                                        DeleteRentButton.Visible = true;
                                        DeleteRentButton.Text = "Reject and Re-open Rent";
                                        CancelRentButton.Text = "Back";
                                    }
                                 }
                                else
                                {
                                    AlreadyBookedLabel.Text = "Your Rent confirmed to another user.";
                                     ConfirmRentButton.Visible = false;
                                    DeleteRentButton.Visible = false;
                                    CancelRentButton.Text = "Back";
                                    if (ownerId.Trim() == Session["SessionUserUserId"].ToString().Trim())
                                    {
                                        AlreadyBookedLabel.Text = "This Rent is confirmed to another user.";
                                        DeleteRentButton.Visible = true;
                                        DeleteRentButton.Text = "Reject and Re-open Rent";
                                        CancelRentButton.Text = "Back";
                                    }
                        }

                            
                        }
                        else if (rentStatus.ToLower() == "removed")
                        {

                        }
                        else
                        {
                            ConfirmRentButton.Visible = true;
                            DeleteRentButton.Visible = true;
                            CancelRentButton.Text = "Back";
                        }
                        
                    
                }
            }

        }

        protected void ConfirmRentButton_Click(object sender, EventArgs e)
        {
            ConfirmOrCancelBooking(0,"confirmed");
        }

        private void ConfirmOrCancelBooking(int BookingAction, string bookingStatus)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_Booking_Confirm_Cancel", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@BookingAction", BookingAction);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);
                cmd.Parameters.AddWithValue("@RentId", RentIdTxt.Text.ToString().Trim());
                cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
                cmd.Parameters.AddWithValue("@BookingStatus", bookingStatus);
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
            catch
            {

            }
        }


        protected void CancelRentButton_Click(object sender, EventArgs e)
        {
            if (CancelRentButton.Text.Trim() == "Reject Booking")
            {
                try
                {
                    ConfirmOrCancelBooking(1, "rejected");
                }
                catch (Exception ex)
                {

                }
            }
            else
            {
                Response.Redirect("Rents.aspx");
            }

        }



        protected void DeleteRentButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (DeleteRentButton.Text.Trim() == "Reject and Re-open Rent")
                {
                    ConfirmOrCancelBooking(2, "rejected");
                }
                else
                {
                    ConfirmOrCancelBooking(1, "rejected");
                }
            }
            catch (Exception ex)
            {

            }
        }


        protected void ButtonHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

    }
}