// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  CollectionReference donorbase =
      FirebaseFirestore.instance.collection('donor');

  addbase() {
    donorbase
        .add({
          'name': namecontroller.text,
          'phone': phonecontroller.text,
          'group': selectedbloodgroup,
        })
        .then((value) => {
              print("Add Success"),
            })
        .catchError((e) => {print("error")});
  }

  final bloodgroups = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];

  String? selectedbloodgroup;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Icon(Icons.search),
          //   )
          // ],
          title: const Text("Add Donor"),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  TextField(
                    controller: namecontroller,
                    cursorColor: Colors.red,
                    style: const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Name of Donor",
                        labelStyle: TextStyle(color: Colors.red),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: phonecontroller,
                    cursorColor: Colors.red,
                    style: const TextStyle(color: Colors.red),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Contact Number",
                        labelStyle: TextStyle(color: Colors.red),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.red,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Select Blood Group",
                          labelStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      items: bloodgroups
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      value: selectedbloodgroup,
                      onChanged: (valueE) {
                        selectedbloodgroup = valueE;
                        // selectedbloodgroup ;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        addbase();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
