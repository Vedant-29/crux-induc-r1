import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:crux_induc/main.dart';
import 'package:crux_induc/Screens/Main_screens/widgets/submit_btn.dart';
import 'package:crux_induc/Screens/Main_screens/widgets/delete_btn.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:crux_induc/Screens/Main_screens/widgets/amount_pill.dart';




class EditExpenseBtn extends StatefulWidget {
final String? documentId; // Document ID for editing, null for adding

  const EditExpenseBtn( 
    this.documentId, 
    {super.key}
  );

  @override
  State<EditExpenseBtn> createState() => _EditExpenseBtnState();
}

class _EditExpenseBtnState extends State<EditExpenseBtn> {

  final user = FirebaseAuth.instance.currentUser;
  String? uid;
  

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  final List<String> categories = ['Food', 'Transport', 'Entertainment', 'Others'];
  double keyboardHeight = 0.0;
  bool categorySelected = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  int divisionFactor = 1;

    @override
    void initState() {
      super.initState();

      // If in edit mode, load existing data
      if (widget.documentId != null) {
        FirebaseFirestore.instance.collection('users').doc(uid).collection('transactions').doc(widget.documentId).get().then((DocumentSnapshot document) {
          if (document.exists) {
            setState(() {
              amountController.text = (document['price'] ?? 0.0).toString();
              selectedDate = document['date'].toDate();
              selectedCategory = document['category_name'];
              descriptionController.text = document['note_name'] ?? '';
            });
          }
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)
            )
        ),

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Edit/Delete Expense',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'inter',
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.documentId != null) {
                          FirebaseFirestore.instance.collection('users').doc(uid).collection('transactions').doc(widget.documentId).get().then((DocumentSnapshot document) {
                            if (document.exists) {
                              setState(() {
                                amountController.text = (document['price'] ?? 0.0).toString();
                                selectedDate = document['date'].toDate();
                                selectedCategory = document['category_name'];
                                descriptionController.text = document['note_name'] ?? '';
                              });
                            }
                          });
                        }
                      },
                      child: const Text('Reset'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.onBackground,
                        foregroundColor: theme.colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How much ?',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: '300',
                        labelStyle: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSecondary,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            color: theme.colorScheme.onPrimary,
                            size: 30,
                            Icons.currency_rupee,
                          ),
                        ),
                      ),
                      cursorColor: theme.colorScheme.onSecondary,
                      cursorErrorColor: theme.colorScheme.onSecondary,
                    ),
                  ],
                ),

                Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              AmountPill(
                                onTap: () {
                                  setState(() {
                                    divisionFactor = 1;
                                  });
                                },
                                pillText: 'None',
                                backgroundColor: divisionFactor == 1 ? Color.fromARGB(255, 195, 206, 211) : Colors.white,
                              ),
                              AmountPill(
                                onTap: () {
                                  setState(() {
                                    divisionFactor = 2;
                                  });
                                },
                                pillText: '2',
                                backgroundColor: divisionFactor == 2 ? Color.fromARGB(255, 195, 206, 211) : Colors.white,
                              ),
                              AmountPill(
                                onTap: () { 
                                  setState(() {
                                    divisionFactor = 4;
                                  });
                                },
                                pillText: '4',
                                backgroundColor: divisionFactor == 4 ? Color.fromARGB(255, 195, 206, 211) : Colors.white,
                              ),
                              AmountPill(
                                onTap: () {
                                  setState(() {
                                    divisionFactor = 5;
                                  });
                                },
                                pillText: '5',
                                backgroundColor: divisionFactor == 5 ? Color.fromARGB(255, 195, 206, 211) : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      child: Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: theme.colorScheme.primary,
                          colorScheme: ColorScheme.light(primary: theme.colorScheme.primary),
                          buttonTheme: ButtonThemeData(
                            textTheme: ButtonTextTheme.primary
                          ),
                        ),
                        child: DateTimeField(
                          decoration: InputDecoration(
                            labelText: 'Enter Date',
                            floatingLabelStyle: TextStyle(
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 15,
                            ),
                            helperText: 'DD//MM//YYYY',
                            border: InputBorder.none,
                          ),
                          value: selectedDate,
                          dateFormat: DateFormat.yMd(),
                          mode: DateTimeFieldPickerMode.date,
                          onChanged: (DateTime? value) {
                            setState(() {
                              selectedDate = value ?? DateTime.now();
                            });
                          },
                        
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onTertiary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: theme.colorScheme.onTertiary,
                          icon: Icon(
                              Icons.arrow_drop_down,
                              color: theme.colorScheme.onBackground,
                              size: 30,
                            ),
                          validator: (value) {
                            if (!categorySelected) {
                              return 'Please choose a category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            hintText: selectedCategory ?? 'Select a category',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontSize: 15,
                            ),
                          ),
                          value: selectedCategory,
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                              categorySelected = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Enter your note..',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RedBtn(
                      SubmitText: widget.documentId != null ? 'Delete expense' : 'Add expense',
                      onPressed: () async {
                        if (widget.documentId != null) {
                          // Deleting existing entry
                          await FirebaseFirestore.instance
                              .collection('transactions')
                              .doc(widget.documentId)
                              .delete();
                          Navigator.pop(context); // Close the form
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BlueBtn(
                      SubmitText: widget.documentId != null ? 'Edit expense' : 'Add expense',
                      onPressed: () async {
                        if (widget.documentId != null) {

                          double amount = double.tryParse(amountController.text) ?? 0.0;
                          // Editing existing entry
                          await FirebaseFirestore.instance.collection('users')
                          .doc(uid).collection('transactions')
                          .doc(widget.documentId).update({
                            'price': amount,
                            'date': selectedDate,
                            'category_name': selectedCategory,
                            'note_name': descriptionController.text,
                            'userId': uid,  // Add this line to include the user id in the transaction
                          });
                        } else {
                          double amount = double.tryParse(amountController.text) ?? 0.0;
                          // Adding new entry
                          await FirebaseFirestore.instance.collection('transactions').add({
                            'price': amount,
                            'date': selectedDate,
                            'category_name': selectedCategory,
                            'note_name': descriptionController.text,
                          });
                        }
                        Navigator.pop(context); // Close the form
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
} 