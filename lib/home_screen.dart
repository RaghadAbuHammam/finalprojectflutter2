import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference taskcollection = firebaseFirestore.collection('task');
  final TextEditingController addController = TextEditingController();
class _HomeScreenState extends State<HomeScreen> {
    


  //add fun
  addFun(String id){
    taskcollection.add({
      'task name' : addController.text,
      'status ' : false,
      'id': id
    });
    setState(() {
      getFun();
    });
  }
  //get function
  List<QueryDocumentSnapshot> data = [];
  getFun() async {
    data.clear();
    QuerySnapshot querySnapshot = await taskcollection
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      data.addAll(querySnapshot.docs);
    });
  }

deleteFunction(String id) {
    taskcollection.doc(id).delete();
    getFun();
  }

  //update
  updateFunction(String id, bool newStatus) {
    taskcollection.doc(id).update({'status': newStatus});
    getFun();
  }

  @override
  void initState() {
    getFun();
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
          Text('Hello ${firebaseAuth.currentUser!.email}'),
          SizedBox(height: 20,),
          Text('Your Task : '),
          SizedBox(height: 30),

          //tasks
          data.isEmpty
                ? Center(child: Icon(Icons.hourglass_empty, size: 90))
                : ListView.builder(itemBuilder: (context , index){
            return cardClass(
                  txt: data[index]['taskName'],
                  status: data[index]['status'],
                  onTapDelete: () {
                    setState(() {
                      deleteFunction(data[index].id);
                    });
                  },
                  onTapUpdate: () {
                    setState(() {
                      updateFunction(data[index].id, !(data[index]['status']));
                    });
                  },
                );
              },
              itemCount: data.length,
            ),

        ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Add Task : '),
            content: TextField(
              controller: addController,
            ),
            actions: [
              TextButton(onPressed: (){
                setState(() {
                  addFun(FirebaseAuth.instance.currentUser!.uid);
                  addController.clear();
                });
              }, child: Text('ADD')),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              
            ],
          );
        }
        );

      },
      child: Icon(Icons.add),
      ),

      drawer: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.person, size: 100, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Hello ${firebaseAuth.currentUser!.email}')
                ],
              ),

              ListTile(
                leading: Icon(Icons.settings, color: Colors.grey[700]),
                title: Text(
                  'Settings'),
                onTap: () {
                  // Add navigation or functionality
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.grey[700]),
                title: Text(
                  'Logout',
                ),
                onTap: () {
                  firebaseAuth.signOut();
                },
              ),

              Spacer(),
              Center(
                child: Text(
                  '© 2025 Your App',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class cardClass extends StatelessWidget {
  String txt;
  bool status;
  void Function()? onTapDelete;
  void Function()? onTapUpdate;
  cardClass({
    required this.txt,
    required this.status,
    required this.onTapDelete,
    required this.onTapUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: const EdgeInsets.all(15.0), child: Text(txt)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: onTapUpdate,
                          child: status
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank_outlined),
                        ),
                        SizedBox(width: 20),
                        InkWell(onTap: onTapDelete, child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
