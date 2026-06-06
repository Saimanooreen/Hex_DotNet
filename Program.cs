using ECommerceApp.Services;

namespace ECommerceApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            OrderBillingService service = new OrderBillingService();

            decimal finalAmount = service.CalculateFinalAmount(1000, 6);

            Console.WriteLine($"Final Amount = {finalAmount}");
        }
    }
}