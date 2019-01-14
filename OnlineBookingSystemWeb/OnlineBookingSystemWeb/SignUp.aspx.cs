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
    public partial class SignUp : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineBookingConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SessionUserEmail"] == null)
            {

            }
            else
            {
                Response.Redirect("~/Home.aspx");
            }
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            if(PasswordTextBox.Text.Trim()== RePasswordTextBox.Text.Trim())
            {
                SignUpNow();
            }
            else
            {
                SignUpTitle.Text = "Password did not matched.";
            }
            
        }

        void SignUpNow()
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_User_Sign_Up_Update", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", 0);
                cmd.Parameters.AddWithValue("@FirstName", FirstNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", LastNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@NickName", NickNameTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@BirthDate", BirthDate.Text.Trim());
                cmd.Parameters.AddWithValue("@Gender", GenderDropDown.SelectedValue.ToString().Trim());
                cmd.Parameters.AddWithValue("@Email", EmailTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", PasswordTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", PhoneTextBox.Text.Trim());
               
                cmd.Parameters.AddWithValue("@UserType", "user");
                cmd.Parameters.AddWithValue("@UserStatus", "Y");
                cmd.Parameters.Add("@msg_code", SqlDbType.VarChar, 5).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@MSG", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;


                cmd.ExecuteNonQuery();

                string mCode = cmd.Parameters["@msg_code"].Value.ToString();
                string msg = cmd.Parameters["@MSG"].Value.ToString();
                SignUpTitle.Text = msg;

                if(mCode=="Y")
                {
                    PanelSignUp.Visible = false;
                    PanelSignUpConfirm.Visible = true;
                }
                
        

            }
            catch(Exception ex)
            {

            }
         

        }

        protected void ButtonGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}