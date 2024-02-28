import 'package:crux_induc/Screens/Main_screens/components/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/Screens/Main_screens/profile_page.dart';
import 'package:crux_induc/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:crux_induc/providers/piecolorsProvider.dart';




class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime selectedDate = DateTime.now();
  Stream<Map<String, double>>? categorySumsStream;
  Timer? _timer;

  final user = FirebaseAuth.instance.currentUser;
  String? uid;

  
  
  @override
  void initState() {
    uid = user?.uid;

    super.initState();
    // Call getCategorySums when the page loadssetState(() {
      DateTime now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);            
    categorySumsStream = getCategorySums(selectedDate);

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Fetch the data and update the state
      setState(() {
        categorySumsStream = getCategorySums(selectedDate);
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  String formatTransactionDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final tomorrow = today.add(Duration(days: 1));

  if (date.isAtSameMomentAs(today)) {
    return 'Today';
  } else if (date.isAtSameMomentAs(yesterday)) {
    return 'Yesterday';
  } else if (date.isAtSameMomentAs(tomorrow)) {
    return 'Day After';
  } else {
    return DateFormat('d MMMM yy').format(date);
  }
}
  

 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Stream<Map<String, double>> getCategorySums(DateTime date) async* {
    Map<String, double> categorySums = {};

    // Format the date to yyyy-MM-dd using DateFormat
    Timestamp timestamp = Timestamp.fromDate(date);

    await for (var snapshot in _firestore.collection('users')
      .doc(uid)
      .collection('transactions')
      .where('date', isEqualTo: timestamp)
      .snapshots()) {

      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          String category = data['category_name'];
          double price = data['price'];

          if (categorySums.containsKey(category)) {
            categorySums[category] = categorySums[category]! + price;
          } else {
            categorySums[category] = price;
          }
        }
      }

      yield categorySums;
    }
  }



  var tabIndex = 0;
  void ChangeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swipe Right
          setState(() {
            selectedDate = selectedDate.subtract(Duration(days: 1));
            categorySumsStream = getCategorySums(selectedDate);
          });
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swipe Left
          setState(() {
            selectedDate = selectedDate.add(Duration(days: 1));
            categorySumsStream = getCategorySums(selectedDate);
          });
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        appBar: AppBar(
          automaticallyImplyLeading: false,    
          backgroundColor: theme.colorScheme.tertiary,
          elevation: 0,
          title: Text(
            'Statistics',
            style: TextStyle(
              color: theme.colorScheme.surface,
              fontSize: 20,
              fontFamily: 'inter',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.person_rounded,
                color: theme.colorScheme.surface,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiary,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_rounded),
                            onPressed: () {
                              setState(() {
                                selectedDate = selectedDate.subtract(Duration(days: 1));
                                categorySumsStream = getCategorySums(selectedDate);
                                Provider.of<PieChartColors>(context, listen: false).initializeColors();
                              });
                            },
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: theme.colorScheme.primary,
                                      colorScheme: ColorScheme.light(primary: theme.colorScheme.primary),
                                      buttonTheme: ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary
                                      ),
                                    ),
                                    child: child as Widget,
                                  );
                                },
                              );
                              if (picked != null && picked != selectedDate)
                                setState(() {
                                  selectedDate = picked;
                                  categorySumsStream = getCategorySums(selectedDate);
                                });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: theme.colorScheme.scrim,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat('d MMMM').format(selectedDate.toLocal()),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                              setState(() {
                                selectedDate = selectedDate.add(Duration(days: 1));
                                categorySumsStream = getCategorySums(selectedDate);
                                Provider.of<PieChartColors>(context, listen: false).initializeColors();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'OVERVIEW',
                            style: TextStyle(
                              color: theme.colorScheme.background,
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
                      StreamBuilder<Map<String, double>>(
                        stream: categorySumsStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Map<String, double> categorySums = snapshot.data!;
                            double totalSum = categorySums.values.fold(0, (a, b) => a + b);
                            final pieColors = Provider.of<PieChartColors>(context).colors;

                            return Column(
                              children: [
                                Container(height: 230, child: UserPieChart(data: categorySums, categoryColors: pieColors,)),
                                const SizedBox(height: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: theme.colorScheme.secondary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              formatTransactionDate(selectedDate),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'inter',
                                              ),
                                            ),
                                            const Spacer(),
                                            Text('RS. $totalSum'),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: categorySums.length,
                                        itemBuilder: (context, index) {
                                          String category = categorySums.keys.elementAt(index);
                                          double? total = categorySums[category];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 42, // Set the diameter of the circle
                                                  height: 42, // Set the diameter of the circle
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(255, 200, 230, 201),
                                                    // Set the background color of the circle
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .access_alarm, // Replace with your actual logo or icon
                                                    color: Colors.black, // Set the color of the logo
                                                    size: 22, // Set the size of the logo
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  category.toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'inter',
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(total.toString())
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: TextButton(
                    onPressed: () {
                      // Handle button press here
                    },
                    child: Text(
                      'Advanced options',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
