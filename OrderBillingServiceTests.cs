using NUnit.Framework;
using ECommerceApp.Services;
using System;

namespace ECommerceApp.Tests
{
    [TestFixture]
    public class OrderBillingServiceTests
    {
        private OrderBillingService _service;

        [SetUp]
        public void SetUp()
        {
            _service = new OrderBillingService();
        }

        [Test]
        public void When_ValidPriceAndQuantity_ReturnsSubTotal()
        {
            decimal result =
                _service.CalculateSubTotal(1000, 2);

            Assert.That(result, Is.EqualTo(2000));
        }

        [Test]
        public void When_ProductPriceIsZero_ThrowsException()
        {
            ArgumentException ex =
                Assert.Throws<ArgumentException>(() =>
                _service.CalculateSubTotal(0, 2));

            Assert.That(ex.Message,
                Is.EqualTo("Product price must be greater than 0."));
        }

        [Test]
        public void When_QuantityIsZero_ThrowsException()
        {
            ArgumentException ex =
                Assert.Throws<ArgumentException>(() =>
                _service.CalculateSubTotal(1000, 0));

            Assert.That(ex.Message,
                Is.EqualTo("Quantity must be greater than 0."));
        }

        [Test]
        public void When_SubTotalGreaterThan5000_Returns10PercentDiscount()
        {
            decimal discount =
                _service.CalculateDiscount(6000);

            Assert.That(discount, Is.EqualTo(600));
        }

        [Test]
        public void When_SubTotalBetween2000And4999_Returns5PercentDiscount()
        {
            decimal discount =
                _service.CalculateDiscount(3000);

            Assert.That(discount, Is.EqualTo(150));
        }

        [Test]
        public void When_SubTotalLessThan2000_ReturnsNoDiscount()
        {
            decimal discount =
                _service.CalculateDiscount(1500);

            Assert.That(discount, Is.EqualTo(0));
        }

        [Test]
        public void When_AmountLessThan1000_ReturnsDeliveryCharge()
        {
            decimal charge =
                _service.CalculateDeliveryCharge(900);

            Assert.That(charge, Is.EqualTo(100));
        }

        [Test]
        public void When_AmountGreaterThan1000_ReturnsFreeDelivery()
        {
            decimal charge =
                _service.CalculateDeliveryCharge(2000);

            Assert.That(charge, Is.EqualTo(0));
        }

        [Test]
        public void When_CalculateFinalAmount_ReturnsCorrectBill()
        {
            decimal finalAmount =
                _service.CalculateFinalAmount(1000, 6);

            Assert.That(finalAmount, Is.EqualTo(5400));
        }
    }
}