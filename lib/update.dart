import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updateproduct extends StatefulWidget {
  const Updateproduct({super.key});

  @override
  State<Updateproduct> createState() => _UpdateproductState();
}

class _UpdateproductState extends State<Updateproduct> {
  @override
  Widget build(BuildContext context) {
    CollectionReference donorbase =
        FirebaseFirestore.instance.collection('donor');
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    TextEditingController namecontroller =
        TextEditingController(text: args['name']);
    TextEditingController phonecontroller =
        TextEditingController(text: args['phone']);
    String? selectedbloodgroup = args['group'];
    String docid = args['id'];
    final bloodgroups = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];

    void updatedonor() {
      final data = {
        'name': namecontroller.text,
        'phone': phonecontroller.text,
        'group': selectedbloodgroup,
      };
      donorbase.doc(docid).update(data);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Update Donor"),
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Name of Donor",
                      labelStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: phonecontroller,
                    cursorColor: Colors.red,
                    style: const TextStyle(color: Colors.red),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Contact Number",
                      labelStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(
                        Icons.call,
                        color: Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  DropdownButtonFormField(
                    value: selectedbloodgroup,
                    decoration: InputDecoration(
                      labelText: "Select Blood Group",
                      labelStyle: const TextStyle(color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: bloodgroups.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedbloodgroup = val;
                      });
                    },
                  ),
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
                        updatedonor();
                        // print(args);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update",
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
