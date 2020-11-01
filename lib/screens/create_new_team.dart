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

  int _fieldsCount = 0;
  var listOfFields;

  void addNewField() {
    setState(() {
      _fieldsCount += 1;
      var controller =
          controllers.putIfAbsent(_fieldsCount, () => TextEditingController());
      listOfFields.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ("Please provide a valid role");
            }
            return null;
          },

          controller: controller,
          decoration: InputDecoration(labelText: 'role name',   filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    listOfFields = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ("Please provide a valid team name");
            }
            return null;
          },

          controller: _nameController,
          decoration: InputDecoration(

    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),


              labelText: 'title'), //TODO: put empty string validator
        ),
      ),
      SizedBox(height:5),
      Padding(
                padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ("Please provide a valid description");
            }
            return null;
          },
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'description',

            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),

          ),
        ),
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
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left:140,right: 4),
                    child: ClipOval(
                      child: Material(
                        color:  Colors.blue,
                        child: InkWell(
                          splashColor: Colors.red,
                          child: SizedBox(
                            child: Icon(Icons.remove),
                            width: 56,
                            height: 56,
                          ),
                            onTap: () {
                              setState(() {
                                if (listOfFields.length > 2) {
                                  listOfFields.removeAt(listOfFields.length - 1);
                                  _fieldsCount -= 1;
                                }
                              });
                            }
                        ),
                      ),



                       ),
                  ),
                  SizedBox(
                    width:5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: ClipOval(
                      child: Material(
                        color:  Colors.blue,
                        child: InkWell(
                            splashColor: Colors.green,
                            child: SizedBox(
                              child: Icon(Icons.add),
                              width: 56,
                              height: 56,
                            ),
                            onTap: () {
                             addNewField();
                            }
                        ),
                      ),



                    ),
                  ),

                ],
              ),
              SizedBox(height: 5,),
              Center(
                child: RaisedButton(
                  color: Colors.redAccent,
                    padding: const EdgeInsets.all(10),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),

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
                    child: Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
