using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.DeliveryCalculators
{
    public interface IDeliveryChargeCalculator
    {
        double CalculateCharge(double weight);
    }
}
