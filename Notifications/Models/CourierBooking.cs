using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Models
{
    public class CourierBooking
    {
        public Customer Customer { get; set; }
        public Parcel Parcel { get; set; }

        public string DeliveryType { get; set; }

        public double DeliveryCharge { get; set; }
    }
}
