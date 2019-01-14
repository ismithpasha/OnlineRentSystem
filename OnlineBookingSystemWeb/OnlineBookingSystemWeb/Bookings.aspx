﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="OnlineBookingSystemWeb.Bookings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Bookings</title>
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
                     <li class="active"><a href="Bookings.aspx">Bookings</a></li>
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
    <div class="col-sm-12 ">
          
         <div style="background-color:#ffffff; padding:40px; margin-top:60px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
         
          
            <form id="form1" runat="server" class="row">
                  
             
                      <asp:Panel ID="PanelList" runat="server">

                    <div class="col-sm-12"> 
                         <h2>My Bookings</h2>
                        <hr />
                       
                        <asp:ListView ID="lvCustomers" runat="server" GroupPlaceholderID="groupPlaceHolder1"
ItemPlaceholderID="itemPlaceHolder1" OnPagePropertiesChanging="OnPagePropertiesChanging">
<LayoutTemplate>
    
        <asp:PlaceHolder runat="server" ID="groupPlaceHolder1"></asp:PlaceHolder>

    
        <center>
           
            <h3 >
                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="lvCustomers" PageSize="5" >
                   
                    <Fields >
                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="false" ShowPreviousPageButton="true"
                            ShowNextPageButton="false" />
                        <asp:NumericPagerField ButtonType="Link" />
                        <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowLastPageButton="false" ShowPreviousPageButton = "false" />
                    </Fields>
                </asp:DataPager>
            </h3>
        </center>
    
</LayoutTemplate>
<GroupTemplate>
   
        <asp:PlaceHolder runat="server" ID="itemPlaceHolder1"></asp:PlaceHolder>
  
</GroupTemplate>
<ItemTemplate>

    <div class="col-sm-12">
        <div style="background-color:#ffffff; padding:20px; margin:5px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
           
            <a href="RentDetails.aspx?RentId=<%# Eval("RentId") %>">
            <h3><%# Eval("RentTitle") %></h3>
                </a>
        <h5><b>Fare:</b> <%# Eval("Fare") %> ,  <b>Posted on:</b> <%# Eval("PostedOn") %>   </h5>
            <h5> <b>Booked on:</b> <%# Eval("RequestTime") %> </h5>
            <label>Details:</label>
            <p> <%# (Eval("Description").ToString().Length > 200) ? (Eval("Description").ToString().Substring(0, 200) + " ...") : Eval("Description") %></p>

            <h4 class="text-center" style="width:100%; background-color:floralwhite; padding:15px;">
                 <b class="text-success"><%# (Eval("BookingStatus").ToString().ToLower().Trim()=="confirmed") ? ("Booking Confirmed") : "" %> </b>
                 <b class="text-danger"><%# (Eval("BookingStatus").ToString().ToLower().Trim()=="rejected") ? ("Booking Rejected") : "" %> </b>
                <b class="text-warning"><%# (Eval("BookingStatus").ToString().ToLower().Trim()=="p") ? ("Pending Request") : "" %> </b>
            </h4>
    </div>

    </div>
  
</ItemTemplate>
                
</asp:ListView>
                     
                    </div>
                      
           
                 

                 </asp:Panel>

           
            </form>
             <br /> 
            </div>

    </div>
</div>
      
        <br /> <br /> <br />

        
        <footer class="footer navbar-fixed-bottom" style="background-color:#e6e6e6; padding:10px;" >
            <p>&copy; 2018 - My ASP.NET Application</p>
        </footer>
    </div>

</body>
</html>
