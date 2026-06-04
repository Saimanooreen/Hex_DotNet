using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.DeliveryCalculators
{
    public class ExpressDeliveryCalculator : IDeliveryChargeCalculator
    {
        public double CalculateCharge(double weight)
        {
            return (weight * 80) + 100;
        }
    }
}
