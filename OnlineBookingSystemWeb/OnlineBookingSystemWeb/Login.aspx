<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineBookingSystemWeb.Login" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Login</title>
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
                   
                    
                      <li><a href="SignUp.aspx">Sign Up</a></li>

                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">
   
<div class="container">
    <br />
    <div class="col-sm-4 col-sm-offset-4 ">
        <div style="background-color:#ffffff; padding:15px; margin-top:60px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
            <div class="col-sm-12">

            </div>

            <h2 class="text-center">Login</h2>
            <hr>

    <form id="form1" runat="server">
      <div class="form-group">
      <label for="email">Email:</label>
          <asp:TextBox TextMode="Email" class="form-control" ID="EmailTextBox" runat="server" required></asp:TextBox>
      
    </div>
    <div class="form-group">
      <label for="pwd">Password:</label>
       <asp:TextBox TextMode="Password" class="form-control" ID="PasswordTextBox" runat="server" required></asp:TextBox>
    </div>

         <div class="form-group text-center">
                <asp:Button class="btn btn-primary" ID="LoginButton" runat="server" Text="Login" OnClick="LoginButton_Click" />
       </div>
    
    </form>
            
        </div>
    </div>
</div>


        
        <footer class="footer navbar-fixed-bottom" style="background-color:#e6e6e6; padding:10px;" >
            <p>&copy; 2018 - My ASP.NET Application</p>
        </footer>
    </div>

</body>
</html>
