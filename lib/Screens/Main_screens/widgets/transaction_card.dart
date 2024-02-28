import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/Screens/Main_screens/bottom_sheet/edit_expense_bottom_sheet.dart';


Widget transactionsCard(BuildContext context, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => EditExpenseBtn(doc.id),
      );
    },
    child: Padding(
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
            doc['category_name'],
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'inter',
            ),
          ),
          Spacer(),
          Text(
            doc['price'].toString(),
          ),
        ],
      ),
    ),
  );
}