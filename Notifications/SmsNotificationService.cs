using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Notifications
{

    public class SmsNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"SMS Sent : {message}");
        }
    }
}
