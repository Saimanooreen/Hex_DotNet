using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Models
{
    public class Parcel
    {
        public double Weight { get; set; }
        public string SourceCity { get; set; }
        public string DestinationCity { get; set; }
    }
}
