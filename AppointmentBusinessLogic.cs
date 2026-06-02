using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp1
{
    public partial class Appointment
    {
        public string GetDetails()
        {
            return $"ID: {AppointmentId}, Patient: {PatientName}, " +
                   $"Department: {Department}, Date: {AppointmentDate.ToShortDateString()}, " +
                   $"Status: {Status}, Fee: {ConsultationFee}";
        }
    }
}
