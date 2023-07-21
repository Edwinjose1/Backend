
// import 'dart:developer';

// import 'package:adminsideofstage/screens/order_screen_ontap.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MyOrderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Order'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: MediaQuery.removePadding(
//         removeTop: true,
//         context: context,
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: readMyOrder(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }

//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               final data = doc.data();
//               return data['productId'] != null && data['totalamount'] != null;
//             }).toList();

//             if (filteredDocs.isEmpty) {
//               return Center(child: Text('No data'));
//             }

//             final bookingDataList =
//                 filteredDocs.map((doc) => doc.data()).toList();
//             log(bookingDataList.toString());

//             return ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: bookingDataList.length,
//               itemBuilder: (context, index) {
//                 final data = bookingDataList[index];

//                 String productid = data['productId'] ?? '';
//                 String totalamount = data['totalamount'] ?? '';
//                 String address = data['address'] ?? '';
//                 Timestamp dateTimestamp = data['date'];
//                 String date = _formatTimestamp(dateTimestamp); // Convert to String
//                 String paymethod = data['paymethod'] ?? '';
//                 String phoneNumber = data['phoneNumber'] ?? '';

//                 return Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => OrderScreenontap(
//                           address: address,
//                           date: date.toString(),
//                           paymethod: paymethod,
//                           phoneNumber: phoneNumber,
//                           productId: productid,
//                           totalamount: totalamount,
//                         ),
//                       ));
//                     },
//                     tileColor: Color.fromARGB(255, 70, 106, 150),
                  
//                     title: Text(
//                       productid,
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5),
//                         Text(
//                           'Total Amount: $totalamount',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Date: $date',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle the logic for canceling the order
//                             // You can use the 'data' to update the order status in Firestore
//                             // For example:
//                             // updateOrderStatus(data['orderId'], 'Canceled');
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.red,
//                           ),
//                           child: Text('Cancel Order'),
//                         ),
                    
                        
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   String _formatTimestamp(Timestamp timestamp) {
//     // Convert Timestamp to DateTime
//     DateTime dateTime = timestamp.toDate();

//     // Format DateTime to a readable date string (e.g., '2023-07-18 12:30:00')
//     return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
//   }
// }

// import 'package:adminsideofstage/screens/order_screen_ontap.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MyOrderScreen extends StatefulWidget {
//   @override
//   _MyOrderScreenState createState() => _MyOrderScreenState();
// }

// class _MyOrderScreenState extends State<MyOrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Order'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: MediaQuery.removePadding(
//         removeTop: true,
//         context: context,
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: readMyOrder(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }

//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               final data = doc.data();
//               return data['productId'] != null && data['totalamount'] != null;
//             }).toList();

//             if (filteredDocs.isEmpty) {
//               return Center(child: Text('No data'));
//             }

//             final bookingDataList =
//                 filteredDocs.map((doc) => doc.data()).toList();

//             return ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: bookingDataList.length,
//               itemBuilder: (context, index) {
//                 final data = bookingDataList[index];
//                 String productid = data['productId'] ?? '';
//                 String totalamount = data['totalamount'] ?? '';
//                 String address = data['address'] ?? '';
//                 Timestamp dateTimestamp = data['date'];
//                 String date = _formatTimestamp(dateTimestamp); // Convert to String
//                 String paymethod = data['paymethod'] ?? '';
//                 String phoneNumber = data['phoneNumber'] ?? '';
//                 bool isConfirmed = data['isConfirmed'] ?? false;
//                 print(".......$isConfirmed");

//                 return Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => OrderScreenontap(
//                           address: address,
//                           date: date.toString(),
//                           paymethod: paymethod,
//                           phoneNumber: phoneNumber,
//                           productId: productid,
//                           totalamount: totalamount,
//                         ),
//                       ));
//                     },
//                     tileColor: Color.fromARGB(255, 70, 106, 150),
//                     title: Text(
//                       productid,
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5),
//                         Text(
//                           'Total Amount: $totalamount',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Date: $date',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (!isConfirmed) // Show Confirm Order button only if not confirmed
//                           ElevatedButton(
//                             onPressed: () {
//                               // Handle the logic for confirming the order
//                               _onConfirmOrderPressed(data['productId']);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.green,
//                             ),
//                             child: Text('Confirm Order'),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   String _formatTimestamp(Timestamp timestamp) {
//     // Convert Timestamp to DateTime
//     DateTime dateTime = timestamp.toDate();

//     // Format DateTime to a readable date string (e.g., '2023-07-18 12:30:00')
//     return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> readMyOrder() =>
//       FirebaseFirestore.instance.collectionGroup('products').snapshots();

//   Future<void> updateOrderConfirmation(String productId) async {
//     final docRef = FirebaseFirestore.instance.collection('products').doc(productId);

//     try {
//       await docRef.update({
//         'isconfirm': true, // Set the isconfirm field to true when confirming the order.
//       });
//       print('Order confirmed successfully.');
//     } catch (e) {
//       print('Error confirming order: $e');
//     }
//   }

//   // Function to handle the "Confirm Order" button press
//   void _onConfirmOrderPressed(String productId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Order'),
//           content: Text('Do you want to confirm this order?'),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 updateOrderConfirmation(productId);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }




import 'package:adminsideofstage/screens/order_screen_ontap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
        backgroundColor: Colors.redAccent,
      ),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: readMyOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final filteredDocs = snapshot.data!.docs.where((doc) {
              final data = doc.data();
              return data['productId'] != null && data['totalamount'] != null;
            }).toList();

            if (filteredDocs.isEmpty) {
              return Center(child: Text('No data'));
            }

            final bookingDataList =
                filteredDocs.map((doc) => doc.data()).toList();

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: bookingDataList.length,
              itemBuilder: (context, index) {
                final data = bookingDataList[index];
                String productid = data['productId'] ?? '';
                String totalamount = data['totalamount'] ?? '';
                String address = data['address'] ?? '';
                Timestamp dateTimestamp = data['date'];
                String date = _formatTimestamp(dateTimestamp); // Convert to String
                String paymethod = data['paymethod'] ?? '';
                String phoneNumber = data['phoneNumber'] ?? '';
                String userId=data['userId']??'';
                String bookingId=data['bookingId']??'';
                bool isConfirmed = data['isConfirmed'] ?? false;
                print(".......$isConfirmed");

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderScreenontap(
                          isConfirmed: isConfirmed,
                          address: address,
                          date: date.toString(),
                          paymethod: paymethod,
                          phoneNumber: phoneNumber,
                          productId: productid,
                          totalamount: totalamount,
                          bookingId:bookingId,
                          userId:userId,
                        ),
                      ));
                    },
                    tileColor: Color.fromARGB(255, 70, 106, 150),
                    title: Text(
                      productid,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Total Amount: $totalamount',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Date: $date',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                         SizedBox(height: 5),
                        Text(
                          'UserId: $userId',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        
                      ],
                    ),
                    // trailing: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     if (!isConfirmed) // Show Confirm Order button only if not confirmed
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           // Handle the logic for confirming the order
                    //           _onConfirmOrderPressed(data['productId']);
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //           primary: Colors.green,
                    //         ),
                    //         child: Text('Confirm Order'),
                    //       ),
                    //   ],
                    // ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format DateTime to a readable date string (e.g., '2023-07-18 12:30:00')
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readMyOrder() =>
      FirebaseFirestore.instance.collectionGroup('products').snapshots();

  Future<void> updateOrderConfirmation(String productId) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId);

    try {
      await docRef.update({
        'isConfirmed': true, // Set the isConfirmed field to true when confirming the order.
      });
      print('Order confirmed successfully.');

      // Trigger a rebuild of the UI after updating the order confirmation
      setState(() {});
    } catch (e) {
      print('Error confirming order: $e');
    }
  }

  // Function to handle the "Confirm Order" button press
  void _onConfirmOrderPressed(String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Text('Do you want to confirm this order?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                updateOrderConfirmation(productId);
              },
            ),
          ],
        );
      },
    );
  }
}
