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
    public partial class EditProfile : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadData();
            }
            
        }

        protected void BackToProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void UpdateProfileButton_Click(object sender, EventArgs e)
        {
            UpdateNow();
        }

        private void LoadData()
        {

            conn.Open(); 
            SqlCommand cmd = new SqlCommand("sp_Get_User_Info", conn);

            cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            
            DataTable dt = new DataTable();
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    FirstNameTextBox.Text = dt.Rows[0]["FirstName"].ToString();
                    LastNameTextBox.Text = dt.Rows[0]["LastName"].ToString();
                    NickNameTextBox.Text = dt.Rows[0]["NickName"].ToString();
                    GenderDropDown.SelectedValue = dt.Rows[0]["Gender"].ToString();
                    EmailTextBox.Text = dt.Rows[0]["Email"].ToString();
                    PhoneTextBox.Text = dt.Rows[0]["Phone"].ToString();
                   
                }
            }
            conn.Close();

        }

        void UpdateNow() 
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_User_Sign_Up_Update", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", Session["SessionUserUserId"].ToString().Trim());
                cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@NickName", NickNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@BirthDate", Session["SessionUserBirthDate"].ToString().Trim());
                cmd.Parameters.AddWithValue("@Gender", GenderDropDown.SelectedValue.ToString().Trim());
                cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", "");
                cmd.Parameters.AddWithValue("@Phone", PhoneTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@UserType", "user");
                cmd.Parameters.AddWithValue("@UserStatus", "Y");

                cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;


                cmd.ExecuteNonQuery();

                string mCode = cmd.Parameters["@msg_code"].Value.ToString();
                string msg = cmd.Parameters["@MSG"].Value.ToString();
                SignUpTitle.Text = msg;

                if (mCode == "Y")
                {
                    Session["SessionUserEmail"] = EmailTextBox.Text.ToString().Trim();
                    Session["SessionUserFirstName"] = FirstNameTextBox.Text.Trim();
                    Session["SessionUserFullName"] = FirstNameTextBox.Text.Trim() + " " + LastNameTextBox.Text.Trim() + " " + NickNameTextBox.Text.Trim();
                    Session["SessionUserPhone"] = PhoneTextBox.Text.Trim();
                    Session["SessionUserGender"] = GenderDropDown.SelectedValue.ToString().Trim();

                    PanelSignUp.Visible = false;
                    PanelSignUpConfirm.Visible = true;
                }
                conn.Close();
                
            }
            catch (Exception ex)
            {

            }
           

        }

    }
}