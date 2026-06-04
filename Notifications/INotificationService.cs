using System;
using System.Collections.Generic;
using System.Text;

namespace SmartCourierApp.Notifications
{
    public interface INotificationService
    {
        void SendNotification(string message);
    }
}
