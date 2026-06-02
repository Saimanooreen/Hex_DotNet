using ConsoleApp1;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ConsoleApp1 
{
    class Program
    {
        static void Main(string[] args)
        {
            List<Appointment> appointments = new List<Appointment>()
            {
                new Appointment
                {
                    AppointmentId = 1,
                    PatientName = "John",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(2),
                    Status = "Scheduled",
                    ConsultationFee = 600
                },

                new Appointment
                {
                    AppointmentId = 2,
                    PatientName = "David",
                    Department = "Neurology",
                    AppointmentDate = DateTime.Now.AddDays(-1),
                    Status = "Completed",
                    ConsultationFee = 700
                },

                new Appointment
                {
                    AppointmentId = 3,
                    PatientName = "Sam",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(5),
                    Status = "Scheduled",
                    ConsultationFee = 400
                },

                new Appointment
                {
                    AppointmentId = 4,
                    PatientName = "Mary",
                    Department = "Orthopedics",
                    AppointmentDate = DateTime.Now.AddDays(-3),
                    Status = "Completed",
                    ConsultationFee = 900
                },

                new Appointment
                {
                    AppointmentId = 5,
                    PatientName = "Alex",
                    Department = "Cardiology",
                    AppointmentDate = DateTime.Now.AddDays(1),
                    Status = "Scheduled",
                    ConsultationFee = 800
                }
            };

            // 6. Display all appointments
            Console.WriteLine("ALL APPOINTMENTS");
            appointments.ForEach(a => Console.WriteLine(a.GetDetails()));

            // 7. Scheduled appointments
            Console.WriteLine("\nSCHEDULED APPOINTMENTS");
            var scheduled = appointments.Where(a => a.Status == "Scheduled");

            foreach (var item in scheduled)
                Console.WriteLine(item.GetDetails());

            // 8. Completed appointments
            Console.WriteLine("\nCOMPLETED APPOINTMENTS");
            var completed = appointments.Where(a => a.Status == "Completed");

            foreach (var item in completed)
                Console.WriteLine(item.GetDetails());

            // 9. Cardiology appointments
            Console.WriteLine("\nCARDIOLOGY APPOINTMENTS");
            var cardio = appointments.Where(a => a.Department == "Cardiology");

            foreach (var item in cardio)
                Console.WriteLine(item.GetDetails());

            // 10. Fee > 500
            Console.WriteLine("\nFEE GREATER THAN 500");
            var fee = appointments.Where(a => a.ConsultationFee > 500);

            foreach (var item in fee)
                Console.WriteLine(item.GetDetails());

            // 11. Sort by Date
            Console.WriteLine("\nSORT BY APPOINTMENT DATE");
            var sorted = appointments.OrderBy(a => a.AppointmentDate);

            foreach (var item in sorted)
                Console.WriteLine(item.GetDetails());

            // 12. Search by Patient Name
            Console.WriteLine("\nSEARCH PATIENT NAME = JOHN");

            var patient = appointments
                .Where(a => a.PatientName.Equals("John",
                 StringComparison.OrdinalIgnoreCase));

            foreach (var item in patient)
                Console.WriteLine(item.GetDetails());

            // 13. Group by Department
            Console.WriteLine("\nGROUP BY DEPARTMENT");

            var groups = appointments.GroupBy(a => a.Department);

            foreach (var grp in groups)
            {
                Console.WriteLine($"\nDepartment: {grp.Key}");

                foreach (var item in grp)
                {
                    Console.WriteLine(item.GetDetails());
                }
            }

            // 14. Count by Status
            Console.WriteLine("\nCOUNT BY STATUS");

            var statusCount = appointments
                .GroupBy(a => a.Status)
                .Select(g => new
                {
                    Status = g.Key,
                    Count = g.Count()
                });

            foreach (var item in statusCount)
            {
                Console.WriteLine($"{item.Status} : {item.Count}");
            }

            // 15. Total Revenue from Completed Appointments
            Console.WriteLine("\nTOTAL REVENUE");

            double revenue = appointments
                .Where(a => a.Status == "Completed")
                .Sum(a => a.ConsultationFee);

            Console.WriteLine(revenue);

            // 16. Average Consultation Fee
            Console.WriteLine("\nAVERAGE CONSULTATION FEE");

            double avgFee = appointments
                .Average(a => a.ConsultationFee);

            Console.WriteLine(avgFee);

            // 17. Upcoming Appointments
            Console.WriteLine("\nUPCOMING APPOINTMENTS");

            var upcoming = appointments
                .Where(a => a.AppointmentDate > DateTime.Now);

            foreach (var item in upcoming)
            {
                Console.WriteLine(item.GetDetails());
            }

            Console.ReadLine();
        }
    }
}
