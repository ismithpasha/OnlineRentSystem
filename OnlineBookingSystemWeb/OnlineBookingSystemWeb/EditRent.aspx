<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditRent.aspx.cs" Inherits="OnlineBookingSystemWeb.EditRent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Edit Rent</title>
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
                <a class="navbar-brand" href="Home.aspx">Online Booking System</a>
            </div>
            <div class="navbar-collapse collapse">
                 <ul class="nav navbar-nav">
                   
                </ul>
 
                <ul class="nav navbar-nav navbar-right">
  
                    <li ><a href="Home.aspx">Home</a></li>
                    <li class=""><a href="CreateRent.aspx">Create Rent</a></li>
                     <li><a href="Bookings.aspx">Bookings</a></li>
                     <li><a href="Rents.aspx">Rents</a></li>
                     <li><a href="Profile.aspx">Profile</a></li>
                      <li><a href="Logout.aspx">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">
    
<div class="container">
    <br />
    <div class="col-sm-10 col-sm-offset-1 ">
        <div style="background-color:#ffffff; padding:40px; margin-top:60px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
            
              <asp:Label ID="CratePostTitle" Font-Bold="true" CssClass="text-center" Font-Size="Medium" runat="server" Text="Create a post to rent your home"></asp:Label>
             <hr>

          
            <form id="form1" runat="server">
                  <asp:Panel ID="PanelCratePost" runat="server">

              <div class="form-group">
              <label>Rent Title: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="RentTitleTextBox" runat="server" required></asp:TextBox>
      
            </div>
              
             <div class="form-group">
              <label>Address: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="AddressTextBox" runat="server" required></asp:TextBox>
      
            </div>

             <div class="form-group">
              <label>Fare: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="FareTextBox" runat="server" ></asp:TextBox>
            </div>

            <div class="form-group">
              <label>Description: <span class="text-danger">*</span></label>
                  <asp:TextBox  class="form-control" ID="DescriptionTextBox" runat="server" TextMode="MultiLine" ></asp:TextBox>
            </div>

             <div class="form-group text-center">
                <asp:Button class="btn btn-primary" ID="UpdateRentButton" runat="server" Text="Update Now" OnClick="UpdateRentButton_Click" />
                 </div>

                 </asp:Panel>

             <asp:Panel ID="PanelCratePostConfirm" runat="server" Visible="false">
                <asp:Label ID="CratePostTxt" Font-Bold="true" CssClass="text-center" Font-Size="Medium" runat="server" Text="Please Log in to enter."></asp:Label> <br />
                <asp:Button ID="ButtonNewPost" runat="server" CssClass="btn btn-success" Text="New Post" OnClick="ButtonNewPost_Click"/>
            </asp:Panel>
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
