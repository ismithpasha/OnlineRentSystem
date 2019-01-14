<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="OnlineBookingSystemWeb.SignUp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Sign Up</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

      <style>
        body {
            background-image: url('Images/tiles_bg.jpg');

        }
    </style>



</head>
<body>
     <div class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Online Booking System</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                   
                      
                   <li> <a href="Login.aspx">Login</a></li>
                  

                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">
   

<div class="container">
    <br />
    <div class="col-sm-10 col-sm-offset-1 ">
        <div style="background-color:#ffffff; padding:10px; margin-top:60px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
            
            <asp:Label ID="SignUpTitle" Font-Bold="true" CssClass="text-center" Font-Size="Medium" runat="server" Text="Sign up"></asp:Label>
           
            <hr>
           
            <form id="form1" runat="server">
                 <asp:Panel ID="PanelSignUp" runat="server">
              <div class="form-group col-sm-6">
              <label for="email">First Name: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="FirstNameTextBox" runat="server" required></asp:TextBox>
      
            </div>
              
             <div class="form-group col-sm-6">
              <label for="email">Last Name: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="LastNameTextBox" runat="server" required></asp:TextBox>
      
            </div>

             <div class="form-group col-sm-6">
              <label for="email">Nick Name:</label>
                  <asp:TextBox  class="form-control" ID="NickNameTextBox" runat="server" ></asp:TextBox>
      
            </div>

            <div class="form-group row col-sm-6">
                 <div class="col-sm-6">
                  <label for="email">Date of Birth: <span class="text-danger">*</span></label>
                      <asp:TextBox TextMode="Date" class="form-control" ID="BirthDate" runat="server" required></asp:TextBox>
      
                </div> 
                <div class="col-sm-6">
              <label for="email">Gender: <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="GenderDropDown" class="form-control" required runat="server">
                        <asp:ListItem Selected="True" Value="">Select your gender</asp:ListItem>
                        <asp:ListItem Value="male">Male</asp:ListItem>
                        <asp:ListItem Value="female">Female</asp:ListItem>
                        <asp:ListItem Value="other">Other</asp:ListItem>
                    </asp:DropDownList>
                   

                 </div> 
            </div> 
                
               <div class="form-group col-sm-6">
              <label for="email">Phone: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="PhoneTextBox" runat="server" required></asp:TextBox>
      
            </div>
              <div class="form-group col-sm-6">
              <label for="email">Email: <span class="text-danger">*</span></label>
                  <asp:TextBox TextMode="Email"  class="form-control" ID="EmailTextBox" runat="server" required></asp:TextBox>
      
            </div>

            <div class="form-group col-sm-6">
              <label for="pwd">Password: <span class="text-danger">*</span></label>
               <asp:TextBox TextMode="Password" class="form-control" ID="PasswordTextBox" runat="server" required></asp:TextBox>
            </div>

                <div class="form-group col-sm-6">
              <label for="pwd">Re-type Password: <span class="text-danger">*</span></label>
               <asp:TextBox TextMode="Password" class="form-control" ID="RePasswordTextBox" runat="server" required></asp:TextBox>
            </div>

              <div class="form-group text-center">
                <asp:Button ID="SignUpButton" CssClass="btn btn-info" runat="server" Text="Sign Up" OnClick="SignUpButton_Click" />
                 </div>
                       </asp:Panel>
                  <asp:Panel ID="PanelSignUpConfirm" runat="server" Visible="false">
                <asp:Label ID="SignUpConfirmTxt" Font-Bold="true" CssClass="text-center" Font-Size="Medium" runat="server" Text="Please Log in to enter."></asp:Label> <br />
                <asp:Button ID="ButtonGoToLogin" runat="server" CssClass="btn btn-success" Text="Login" OnClick="ButtonGoToLogin_Click" />
            </asp:Panel>
            </form>
             
            
          

        </div>
    </div>
</div>

        <br /><br /><br />
        
        <footer class="footer navbar-fixed-bottom" style="background-color:#e6e6e6; padding:10px;" >
            <p>&copy; 2018 - My ASP.NET Application</p>
        </footer>
    </div>

</body>
</html>
