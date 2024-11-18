import 'package:flutter/material.dart';

class BusinessDashboard extends StatelessWidget {
  // Sample data for Customer Details, Sales Information, and Reports
  final String customerName = "John Doe";
  final String customerMobile = "+1 234 567 890";
  final String customerAddress = "1234 Elm Street, Springfield";
  final int totalOrders = 12;
  final double totalInvoiceValue = 12000;
  final int pendingOrders = 2;
  final double totalOutstanding = 1500;

  final List<Order> outstandingOrders = [
    Order(orderNumber: "#1234", orderDate: "2024-10-20", outstanding: 200),
    Order(orderNumber: "#1235", orderDate: "2024-10-22", outstanding: 300),
  ];

  final int targetSales = 50000;
  final int achievedSales = 45000;
  final int newPartiesVisited = 5;
  final int oldPartiesVisited = 10;
  final int totalOrdersQuantity = 500;
  final int totalCancelledOrders = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Detail Page
            buildCustomerInfoCard(),
            SizedBox(height: 16),
            buildSalesInfoCard(),
            SizedBox(height: 16),
            buildOutstandingOrdersCard(),
            SizedBox(height: 16),

            // Target vs Achievements
            buildTargetVsAchievementCard(),
            SizedBox(height: 16),

            // Daily Reports
            buildDailyReportsCard(),
          ],
        ),
      ),
    );
  }

  // Widget for Customer Info Card
  Widget buildCustomerInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Name: $customerName"),
            Text("Mobile: $customerMobile"),
            Text("Address: $customerAddress"),
          ],
        ),
      ),
    );
  }

  // Widget for Sales Info Card
  Widget buildSalesInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sales Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Total Orders Placed: $totalOrders"),
            Text(
                "Total Invoice Value: ₹${totalInvoiceValue.toStringAsFixed(2)}"),
            Text("Pending Orders: $pendingOrders"),
          ],
        ),
      ),
    );
  }

  // Widget for Outstanding Orders Card
  Widget buildOutstandingOrdersCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Outstanding Orders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Total Outstanding: ₹${totalOutstanding.toStringAsFixed(2)}"),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: outstandingOrders.length,
              itemBuilder: (context, index) {
                final order = outstandingOrders[index];
                return ListTile(
                  title: Text("Order ${order.orderNumber}"),
                  subtitle: Text(
                      "Outstanding: ₹${order.outstanding.toStringAsFixed(2)}"),
                  trailing: Text("Date: ${order.orderDate}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Target vs Achievements Card
  Widget buildTargetVsAchievementCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Target vs Achievements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Sales Target: ₹$targetSales"),
            Text("Achieved Sales: ₹$achievedSales"),
          ],
        ),
      ),
    );
  }

  // Widget for Daily Reports Card
  Widget buildDailyReportsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daily Reports",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Visited Parties - New: $newPartiesVisited"),
            Text("Visited Parties - Old: $oldPartiesVisited"),
            Text("Total Orders Quantity: $totalOrdersQuantity"),
            Text("Total Cancelled Orders: $totalCancelledOrders"),
          ],
        ),
      ),
    );
  }
}

// Data model for an Order
class Order {
  final String orderNumber;
  final String orderDate;
  final double outstanding;

  Order({
    required this.orderNumber,
    required this.orderDate,
    required this.outstanding,
  });
}
