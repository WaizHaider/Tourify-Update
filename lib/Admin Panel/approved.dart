import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Approved extends StatefulWidget {
  const Approved({super.key});

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  final CollectionReference Approved =
      FirebaseFirestore.instance.collection('ApprovedRequest');

Future getData() async {
    QuerySnapshot querySnapshot = await Approved.get();
    if (querySnapshot.docs.isEmpty) {
      debugPrint('no data');
    }
    querySnapshot.docs.forEach((Element) {
      debugPrint(Element.data().toString());
    });
    return querySnapshot.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      shadowColor: Colors.blueGrey,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                snapshot.data[index].data()['Company name']),
                            subtitle:
                                Text(snapshot.data[index].data()['Email']),
                            trailing: Text(
                                snapshot.data[index].data()['PhoneNumber']),
                          ),
                      
                        ],
                      ),
                    );
                  });
            }));
  }
}