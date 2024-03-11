import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:providerdemo/add.dart';
import 'package:providerdemo/firebase_options.dart';

import 'update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/addProduct': (context) => const Addproduct(),
        '/updateProduct': (context) => const Updateproduct(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(Icons.search),
        //   )
        // ],
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.home),
        ),
        title: const Text("Blood Donation App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addProduct');
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donor').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final docid = doc.id;
              return ListTile(
                title: Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 20,
                                      spreadRadius: 8)
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 30,
                                      child: Text(
                                        doc['group'].toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        doc['name'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        doc['phone'],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/updateProduct',
                                              arguments: {
                                                'name': doc['name'],
                                                'phone': doc['phone'],
                                                'group': doc['group'],
                                                'id': doc.id,
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 28,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deletedata(context, docid);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> deletedata(BuildContext context, String docid) async {
  try {
    await FirebaseFirestore.instance.collection('donor').doc(docid).delete();
  } catch (e) {
    print('Error deleting document: $e');
  }
}
