import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Firestoreservices _firestoreservices = Firestoreservices();
  final TextEditingController _textController = TextEditingController();
  void opennotebox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _textController,
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                //add a new data
                _firestoreservices.addnote(_textController.text);
                //clear a text feild
                _textController.clear();
                //close a box
                Navigator.pop(context);
              },
              child: Text("add data"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("crud operation"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: opennotebox,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreservices.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List dataList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = dataList[index];
                String doc_id = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String dataText = data['note'];
                return ListTile(
                  title: Text(dataText),
                );
              },
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}
