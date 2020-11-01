import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewTeam extends StatefulWidget {
  @override
  _CreateNewTeamState createState() => _CreateNewTeamState();
}

class _CreateNewTeamState extends State<CreateNewTeam> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  final databaseReference = FirebaseFirestore.instance;

  Map<int, TextEditingController> controllers = {};

  // Map<int, GlobalKey> subtractBtn = {};
  int _fieldsCount = 0;
  var listOfFields;

  void addNewField() {
    setState(() {
      _fieldsCount += 1;
      var controller =
          controllers.putIfAbsent(_fieldsCount, () => TextEditingController());
      listOfFields.add(TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: 'role name'),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    listOfFields = <Widget>[
      TextFormField(
        controller: _nameController,
        decoration: InputDecoration(hintText: 'title'),
      ),
      TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(hintText: 'description'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          title: Text(
            "Create New Team",
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: listOfFields,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (listOfFields.length > 2) {
                            listOfFields.removeAt(listOfFields.length - 1);
                            _fieldsCount -= 1;
                          }
                        });
                      }),
                  IconButton(
                    color: Colors.green,
                    onPressed: () {
                      addNewField();
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              ),
              FlatButton(
                  onPressed: () async {
                    var companyName = _nameController.text;
                    await databaseReference.collection('Companies').add({
                      'companyName': companyName,
                      'description': _descriptionController.text,
                    });
                    var batch = databaseReference.batch();
                    for (var i = 1; i < controllers.length + 1; i++) {
                      var ref = databaseReference.collection('Roles').doc();
                      batch.set(ref, {
                        'companyName': companyName,
                        'roleName': controllers[i].text
                      });
                    }
                    await batch.commit();
                    print('Done');
                    Navigator.pop(context);
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
