import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:crux_induc/Screens/Main_screens/widgets/transaction_card.dart';
import 'package:crux_induc/main.dart';



class RecentsPage extends StatefulWidget {

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {

  final user = FirebaseAuth.instance.currentUser;
  String? uid;

  List<List<QueryDocumentSnapshot<Object?>>> groupTransactionsByDate(List<QueryDocumentSnapshot<Object?>> transactions) { 
    Map<String, List<QueryDocumentSnapshot<Object?>>> grouped = {};

    for (var transaction in transactions) { 
      final date = (transaction['date'] as Timestamp).toDate(); 
      final formattedDate = DateFormat('yyyy-MM-dd').format(date); 
      
      if (!grouped.containsKey(formattedDate)) { 
        grouped[formattedDate] = []; 
      } grouped[formattedDate]!.add(transaction); 
    }

    var sortedGroupedTransactions = grouped.values.toList(); 
    sortedGroupedTransactions.sort((a, b) { 
      var dateA = (a[0]['date'] as Timestamp).toDate(); 
      var dateB = (b[0]['date'] as Timestamp).toDate(); 
      return dateB.compareTo(dateA);
    });

  return sortedGroupedTransactions;

  }

  @override
  void initState() {
    uid = user?.uid;
    super.initState();
    // fetchSmsMessages();
  }

  String formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    if (date.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat('d MMMM yy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  RecentsPage(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,    
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Recents',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'inter',
            ),
          ),
          actions: [
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              const Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'OVERVIEW',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('transactions')
                        .where('userId', isEqualTo: uid)  // Add this line to filter by user id
                        .snapshots(),  
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasData) {
                          var groupedTransactions = groupTransactionsByDate(snapshot.data.docs);
                          // groupedTransactions.addAll(_messages);

                          return Column(
                            children: groupedTransactions.map((group) {
                              final date = (group[0]['date'] as Timestamp).toDate();
                              final formattedDate = formatTransactionDate(date);
                              double totalAmount = group.fold(0.0, (sum, transaction) => sum + (transaction['price'] as double));

                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: theme.colorScheme.secondary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'inter',
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text('RS.${totalAmount.toStringAsFixed(2)}'),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: group.map((transaction) {
                                              return transactionsCard(context, transaction);
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              );
                            }).toList(),
                          );
                        }
                        return const Center(
                          child: Text('No recent transactions found'),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
                  


                      
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: messages.length,
                    //     itemBuilder: (BuildContext context, int i) {
                    //       var message = messages[i];
                    //       return ListTile(
                    //         title: Text('${message.sender} [${message.date}]'),
                    //         subtitle: Text('${message.body}'),
                    //       );
                    //     },
                    //   ),
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance.collection('transactions').snapshots(),
                    //   builder: (context, AsyncSnapshot snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }

                    //     if (snapshot.hasData) {
                    //       // Convert Firestore documents to Map
                    //       List<QueryDocumentSnapshot<Object?>> firestoreTransactions = snapshot.data.docs;

                    //       var firestoreData = firestoreTransactions.map((doc) => doc.data()).toList();

                    //       var smsTransactions = _messages.map((message) {
                    //         return {
                    //           'id': message.id,  // Or generate a unique ID
                    //           'data': {
                    //             'date': message.date,
                    //             'category_name' : message.sender,
                    //             'body': message.body,
                    //             'price': message.body!.split(' ')[0],  // Extract price from message body
                    //             // Add other fields as necessary
                    //           },
                    //           'reference': null,  // Or provide a reference if possible
                    //         };
                    //       }).toList();

                    //       // Combine Firestore transactions and SMS transactions
                    //       var allTransactions = [...firestoreData, ...smsTransactions];

                    //       // Group transactions by date
                    //       var groupedTransactions = groupTransactionsByDate(allTransactions);   // Implement this function

                    //       return Column(
                    //         children: groupedTransactions.map((group) {
                    //           final date = (group[0]['date'] as Timestamp).toDate();
                    //           final formattedDate = formatTransactionDate(date);
                    //           double totalAmount = group.fold(0.0, (sum, transaction) => sum + (transaction['price'] as double));

                    //           return Column(
                    //             children: [
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                     color: theme.colorScheme.secondary,
                    //                     width: 2.0,
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 width: double.infinity,
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Padding(
                    //                         padding: EdgeInsets.only(bottom: 10),
                    //                         child: Row(
                    //                           children: [
                    //                             Text(
                    //                               formattedDate,
                    //                               style: TextStyle(
                    //                                 color: Colors.black,
                    //                                 fontSize: 16,
                    //                                 fontFamily: 'inter',
                    //                               ),
                    //                             ),
                    //                             const Spacer(),
                    //                             Text('RS.${totalAmount.toStringAsFixed(2)}'),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       ListView.builder(
                    //                         shrinkWrap: true,
                    //                         itemCount: messages.length,
                    //                         itemBuilder: (BuildContext context, int i) {
                    //                           var message = messages[i];

                    //                           return ListTile(
                    //                             title: Text('${message.sender} [${message.date}]'),
                    //                             subtitle: Text('${message.body}'),
                    //                           );
                    //                         },
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 10)
                    //             ],
                    //           );
                    //         }).toList(),
                    //       );
                    //     }
                    //     return const Center(
                    //       child: Text('No recent transactions found'),
                    //     );
                    //   },
                    // )

//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             var permission = await Permission.sms.status;
//             if (permission.isGranted) {
//               final messages = await _query.querySms(
//                 kinds: [
//                   SmsQueryKind.inbox,
//                   SmsQueryKind.sent,
//                 ],
//                 count: 10000,
//               );
//               debugPrint('sms inbox messages: ${messages.length}');

//               // Filter transactional messages based on keywords and exclude certain messages
//               final transactionalMessages = _filterTransactionalMessages(
//                 messages,
//                 exclusionKeywords: [
//                   'added to your zepto wallet', 
//                   'promo', 
//                   'balance inquiry', 
//                   'service alert', 
//                   'non-transactional',
//                   'failed',
//                   'declined',
//                   'reversed',
//                   'credited',
//                   'credited to your account',
//                 ],
//               );
//               setState(() => _messages = transactionalMessages);
//             } else {  
//               await Permission.sms.request();
//             }
//           },
//           child: const Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }
