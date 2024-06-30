import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoreservices {
 // get collection of data
final CollectionReference notes=FirebaseFirestore.instance.collection("notes");

 //create insert/a new data
Future <void> addnote(String note){
  return notes.add({
    'note':note,
    'timestamp':Timestamp.now()
  });
}
 // read/ fetch all data
Stream<QuerySnapshot> getData(){
  final dataStream =notes.orderBy("timestamp" , descending:true).snapshots();
  return dataStream;
}
 //update / existing data

 // delete / existing data
}