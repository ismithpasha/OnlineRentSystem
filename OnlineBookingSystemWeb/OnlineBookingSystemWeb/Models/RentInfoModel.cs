using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineBookingSystemWeb.Models
{
    public class RentInfoModel
    {
        public string RentId { get; set; }
        public string OwnerId { get; set; }
        public string RentTitle { get; set; }
        public string Address { get; set; }
        public string Fare { get; set; }
        public string Description { get; set; }
        public string PostedOn { get; set; }
        public string RentStatus { get; set; }
        public string OwnerName { get; set; }
        public string OwnerEmail { get; set; }
        public string OwnerPhone { get; set; }


    }
}