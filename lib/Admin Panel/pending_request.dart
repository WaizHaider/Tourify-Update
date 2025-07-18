import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pending extends StatefulWidget {
  Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final collectionReference =
  FirebaseFirestore.instance.collection('Company');
  final CollectionReference Approved =
  FirebaseFirestore.instance.collection('ApprovedRequest');

  Future getData() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
    if (querySnapshot.docs.isEmpty) {
      debugPrint('no data');
    }
    querySnapshot.docs.forEach((Element) {
      debugPrint(Element.data().toString());
    });
    return querySnapshot.docs;
  }

  bool isvisible = true;

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {

                                    await Approved.add(
                                        snapshot.data[index].data());

                                    await collectionReference
                                        .doc(snapshot.data[index].id)
                                        .delete();
                                    setState(() {
                                      isvisible = false;
                                    });
                                  },
                                  child: const Text('Accept')),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () async{
                                    await collectionReference
                                        .doc(snapshot.data[index].id)
                                        .delete();
                                    setState(() {
                                      isvisible = false;
                                    });
                                  },
                                  child: const Text('Reject')),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }));
  }
}
