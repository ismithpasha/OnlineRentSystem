<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmRent.aspx.cs" Inherits="OnlineBookingSystemWeb.ConfirmRent" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Rent Details</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

      <style>
        body {
           background-color:white;

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
                     <li ><a href="Rents.aspx">Rents</a></li>
                     <li><a href="Profile.aspx">Profile</a></li>
                    
                      <li class=""><a href="Logout.aspx">Logout</a></li>

                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">
    
<div class="container">
    <br />
    <div class="col-sm-10 col-sm-offset-1 ">
          
         <div style="background-color:#ffffff; padding:40px; margin-top:60px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
         
          
            <form id="form1" runat="server" class="row">
                  <asp:Panel ID="PanelRent" runat="server">

                 <h3><asp:Label ID="RentTitleLabel" runat="server" Text=""></asp:Label></h3> 
                      <asp:Label ID="RentIdTxt" Visible="false" runat="server" Text=""></asp:Label>
                      <div class="col-sm-6"> 
             <p><b>Address: </b>      <asp:Label ID="AddressLabel" runat="server" Text="Label"></asp:Label></p>
                   
       <p><b>Posted On: </b>  <asp:Label ID="PostedOnLabel" runat="server" Text="Label"></asp:Label> </p>
             <p><b>Fare: </b>  <asp:Label ID="FareLabel" runat="server" Text="Label"></asp:Label>    </p>                  
       
                      </div>
                      <div class="col-sm-6"> 
                           <p><b>Booked By: <asp:Label ID="OwnerNameLabel" runat="server" Text="Label"></asp:Label> </b> </p>
                          
                          <p><b>Email: </b>   <asp:Label ID="EmailLabel" runat="server" Text="Label"></asp:Label>   </p>
                          <p><b>Phone: </b>   <asp:Label ID="PhoneLabel" runat="server" Text="Label"></asp:Label>  </p>
                         
                          </div>
                    <div class="col-sm-12"> 
                       <p><b>Description: </b>   <asp:Label ID="DescriptionLabel" runat="server" Text="Label"></asp:Label>    </p>
                        <br />
                      <p><b>  <asp:Label ID="AlreadyBookedLabel" runat="server" Text=""></asp:Label> </b></p>
            </div>
                      
           
                     
                  <div class="form-group text-center">
                
                      <asp:Button class="btn btn-success pull-right" ID="ConfirmRentButton" runat="server" style="margin-left:10px;" Text="Confirm Booking" OnClick="ConfirmRentButton_Click"  />
                    
                      <asp:Button class="btn btn-danger pull-right" ID="DeleteRentButton" runat="server" style="margin-left:10px;" Text="Reject Booking" OnClick="DeleteRentButton_Click"  />
                      
                       
                      <asp:Button class="btn btn-primary pull-right" ID="CancelRentButton" runat="server" style="margin-left:10px;" Text="Cancel" OnClick="CancelRentButton_Click"  />
                 </div>

                 </asp:Panel>
                   <asp:Panel ID="PanelConfirm" runat="server" Visible="false">
                <asp:Label ID="ConfirmBookingTxt" Font-Bold="true" CssClass="text-center" Font-Size="Medium" runat="server" Text=""></asp:Label> <br />
                <asp:Button ID="ButtonHome" runat="server" CssClass="btn btn-success" Text="Back to Home" OnClick="ButtonHome_Click" />
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

