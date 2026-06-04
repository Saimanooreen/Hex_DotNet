using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Invoices;
using SmartCourierApp.Models;
using SmartCourierApp.Notifications;
using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Services
{
    public class CourierBookingService
    {
        private readonly IDeliveryChargeCalculator _calculator;
        private readonly INotificationService _notification;
        private readonly IInvoiceGenerator _invoice;

        public CourierBookingService(
            IDeliveryChargeCalculator calculator,
            INotificationService notification,
            IInvoiceGenerator invoice)
        {
            _calculator = calculator;
            _notification = notification;
            _invoice = invoice;
        }

        public void BookCourier(CourierBooking booking)
        {
            booking.DeliveryCharge =
                _calculator.CalculateCharge(booking.Parcel.Weight);

            _notification.SendNotification(
                "Courier booked successfully.");

            _invoice.GenerateInvoice(booking);
        }
    }
}
