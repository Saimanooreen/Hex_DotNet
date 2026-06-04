using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.DeliveryCalculators
{
    public class InternationalDeliveryCalculator : IDeliveryChargeCalculator
    {
        public double CalculateCharge(double weight)
        {
            return (weight * 150) + 500;
        }
    }
}
