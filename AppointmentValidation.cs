using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp1
{
    public partial class Appointment
    {
        public bool Validate()
        {
            return !string.IsNullOrEmpty(PatientName)
                   && !string.IsNullOrEmpty(Department)
                   && ConsultationFee > 0;
        }
    }
}
