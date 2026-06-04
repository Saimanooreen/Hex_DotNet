using SmartCourierApp.Models;
using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Notifications;
using SmartCourierApp.Invoices;
using SmartCourierApp.Services;

Console.WriteLine("===== SMART COURIER SYSTEM =====");

Customer customer = new Customer();

Console.Write("Customer Name : ");
customer.Name = Console.ReadLine();

Console.Write("Customer Email : ");
customer.Email = Console.ReadLine();

Console.Write("Mobile Number : ");
customer.MobileNumber = Console.ReadLine();

Parcel parcel = new Parcel();

Console.Write("Parcel Weight (KG): ");
parcel.Weight = Convert.ToDouble(Console.ReadLine());

Console.Write("Source City : ");
parcel.SourceCity = Console.ReadLine();

Console.Write("Destination City : ");
parcel.DestinationCity = Console.ReadLine();

Console.WriteLine();
Console.WriteLine("1. Standard");
Console.WriteLine("2. Express");
Console.WriteLine("3. International");

Console.Write("Choose Delivery Type : ");
int deliveryChoice = Convert.ToInt32(Console.ReadLine());

IDeliveryChargeCalculator calculator;

string deliveryType;

switch (deliveryChoice)
{
    case 1:
        calculator = new StandardDeliveryCalculator();
        deliveryType = "Standard Delivery";
        break;

    case 2:
        calculator = new ExpressDeliveryCalculator();
        deliveryType = "Express Delivery";
        break;

    case 3:
        calculator = new InternationalDeliveryCalculator();
        deliveryType = "International Delivery";
        break;

    default:
        calculator = new StandardDeliveryCalculator();
        deliveryType = "Standard Delivery";
        break;
}

Console.WriteLine();
Console.WriteLine("1. Email");
Console.WriteLine("2. SMS");
Console.WriteLine("3. WhatsApp");

Console.Write("Choose Notification Type : ");
int notificationChoice = Convert.ToInt32(Console.ReadLine());

INotificationService notification;

switch (notificationChoice)
{
    case 1:
        notification = new EmailNotificationService();
        break;

    case 2:
        notification = new SmsNotificationService();
        break;

    case 3:
        notification = new WhatsAppNotificationService();
        break;

    default:
        notification = new EmailNotificationService();
        break;
}

CourierBooking booking = new CourierBooking
{
    Customer = customer,
    Parcel = parcel,
    DeliveryType = deliveryType
};

IInvoiceGenerator invoiceGenerator =
    new ConsoleInvoiceGenerator();

CourierBookingService bookingService =
    new CourierBookingService(
        calculator,
        notification,
        invoiceGenerator);

bookingService.BookCourier(booking);

Console.ReadLine();
