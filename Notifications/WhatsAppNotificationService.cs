using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Notifications
{
    public class WhatsAppNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"WhatsApp Message Sent : {message}");
        }
    }
}
