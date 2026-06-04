using SmartCourierApp.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Invoices
{
    public interface IInvoiceGenerator
    {
        void GenerateInvoice(CourierBooking booking);
    }
}
