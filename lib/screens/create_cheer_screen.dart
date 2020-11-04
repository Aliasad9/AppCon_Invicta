import 'package:Invicta/data/cheer.dart';
import 'package:Invicta/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/heading.dart';

class CreateCheerScreen extends StatefulWidget {
  final List<CustomUser> teamList;
  final employee;

  CreateCheerScreen({this.teamList, this.employee});

  @override
  _CreateCheerScreenState createState() => _CreateCheerScreenState();
}

class _CreateCheerScreenState extends State<CreateCheerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController _messageTextController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;

  List<Category> _companies = Category.getCategory();
  List<DropdownMenuItem<Category>> _dropdownMenuItemsCategory;
  Category _selectedCompany;

  List<CustomUser> _employees;
  List<DropdownMenuItem<CustomUser>> _dropdownMenuItemsEmployee;
  CustomUser _selectedEmployee;

  bool _isBlueChecked = true;
  bool _isRedChecked = false;
  bool _isTealChecked = false;
  bool _isOrangeChecked = false;
  bool _isPurpleChecked = false;
  Color textFieldColor = Colors.blue;
  int cheerType = 1;

  @override
  void dispose() {

    _formKey.currentState.dispose();
    _messageTextController.dispose();
    _titleController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if (this.widget.teamList != null) {
      _employees = this.widget.teamList;
      _dropdownMenuItemsEmployee = buildDropdownMenuItemsEmployee(_employees);
      _selectedEmployee = _dropdownMenuItemsEmployee[0].value;
    }
    _dropdownMenuItemsCategory = buildDropdownMenuItemsCategory(_companies);
    _selectedCompany = _dropdownMenuItemsCategory[0].value;

    super.initState();
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItemsCategory(
      List companies) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              company.name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                fontSize: 13,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<CustomUser>> buildDropdownMenuItemsEmployee(employees) {
    List<DropdownMenuItem<CustomUser>> items = [];
    for (CustomUser employee in employees) {
      items.add(
        DropdownMenuItem(
          value: employee,
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 18,
                backgroundImage: employee.imgUrl != null
                    ? NetworkImage(employee.imgUrl)
                    : AssetImage('assets/images/profile.jpg'),
              ),
              title: Text(
                employee.name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    fontSize: 13),
              ),
              subtitle: Text(employee.email),
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemCategory(Category selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  onChangeDropdownItemEmployee(CustomUser selectedEmployee) {
    setState(() {
      _selectedEmployee = selectedEmployee;
    });
  }

  Widget _buildScreenUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14, top: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading("Cheers For Your Peer!"),
            SizedBox(
              height: 5,
            ),
            this.widget.teamList != null
                ? _buildDropDownEmployee()
                : Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: this.widget.employee.imgUrl != null
                              ? NetworkImage(this.widget.employee.imgUrl)
                              : AssetImage('assets/images/profile.jpg'),
                        ),
                        title: Text(
                          this.widget.employee.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                              fontSize: 13),
                        ),
                        subtitle: Text(this.widget.employee.email),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:16.0),
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ("Field cannot be empty");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Title',
                          contentPadding: EdgeInsets.only(left: 16),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid, width: 1)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid, width: 1)

                          ),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    _buildTextField(this.textFieldColor),
                  ],
                ),
              ),
            ),

            _buildSubHeading('Select Desired Color'),
            Row(
              children: [
                _buildColoredContainer(Colors.blue, _isBlueChecked),
                _buildColoredContainer(Colors.teal, _isTealChecked),
                _buildColoredContainer(Colors.redAccent, _isRedChecked),
                _buildColoredContainer(Colors.orange, _isOrangeChecked),
                _buildColoredContainer(Colors.purple, _isPurpleChecked)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _buildSubHeading("Select the Label"),
            _buildContainer(),
            cheerType == 1
                ? _buildSubHeading('Select a Category')
                : Container(),
            cheerType == 1 ? _buildDropDownCategory() : Container(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  _buildSubHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  _buildTextField(fillColor) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return ("Field cannot be empty");
        }
        return null;
      },
      controller: _messageTextController,
      maxLines: 4,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor.withOpacity(0.32),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: fillColor, width: 0),
        ),
        hintText: 'Type a Super Nice Message...',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: fillColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  _buildContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                this.cheerType = 1;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Cheers",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  border: Border.all(
                      color: Colors.green,
                      style: cheerType == 1
                          ? BorderStyle.solid
                          : BorderStyle.none),
                  color: Colors.green.withOpacity(0.32),
                )),
          ),
          InkWell(
            onTap: () {
              setState(() {
                this.cheerType = 2;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Birthday",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.red,
                      style: cheerType == 2
                          ? BorderStyle.solid
                          : BorderStyle.none),
                  color: Colors.red.withOpacity(0.32),
                )),
          ),
          InkWell(
            onTap: () {
              setState(() {
                this.cheerType = 3;
              });
            },
            child: Container(
                child: Center(
                  child: Text(
                    " Kudos",
                    style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Theme.of(context).primaryColor.withOpacity(0.32),
                  border: Border.all(
                      color: Theme.of(context).primaryColor,
                      style: cheerType == 3
                          ? BorderStyle.solid
                          : BorderStyle.none),
                )),
          ),
        ],
      ),
    );
  }

  _buildColoredContainer(Color color, bool visibility) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          setState(() {
            if (color == Colors.redAccent) {
              _isRedChecked = true;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.redAccent;
            } else if (color == Colors.blue) {
              _isRedChecked = false;
              _isBlueChecked = true;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.blue;
            } else if (color == Colors.teal) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = false;
              _isTealChecked = true;
              this.textFieldColor = Colors.teal;
            } else if (color == Colors.orange) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = true;
              _isPurpleChecked = false;
              _isTealChecked = false;
              this.textFieldColor = Colors.orange;
            } else if (color == Colors.purple) {
              _isRedChecked = false;
              _isBlueChecked = false;
              _isOrangeChecked = false;
              _isPurpleChecked = true;
              _isTealChecked = false;
              this.textFieldColor = Colors.purple;
            }
          });
        },
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            border: Border.all(
                color: color.withOpacity(0.32),
                width: 2,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(40),
            color: color.withOpacity(0.35),
          ),
          child: Visibility(
            visible: visibility,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildDropDownCategory() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: _selectedCompany,
          items: _dropdownMenuItemsCategory,
          onChanged: onChangeDropdownItemCategory,
        ),
      ),
    );
  }

  _buildDropDownEmployee() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          itemHeight: 60,
          value: _selectedEmployee,
          items: _dropdownMenuItemsEmployee,
          onChanged: onChangeDropdownItemEmployee,
        ),
      ),
    );
  }

  _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: FlatButton(
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            SharedPreferences prefs = await _prefs;
            var color;
            if (this.textFieldColor == Colors.blue) {
              color = 1;
            } else if (this.textFieldColor == Colors.teal) {
              color = 2;
            } else if (this.textFieldColor == Colors.redAccent) {
              color = 3;
            } else if (this.textFieldColor == Colors.orange) {
              color = 4;
            } else if (this.textFieldColor == Colors.purple) {
              color = 5;
            } else {
              color = 1;
            }
            var recvEmail = this.widget.employee != null
                ? this.widget.employee.email
                : this._selectedEmployee.email;
            var pointsToAdd = 0;
            if (cheerType == 1) {
              //Cheeer
              pointsToAdd += 5;
            } else if (cheerType == 2) {
              //Bday
              pointsToAdd += 2;
            } else if (cheerType == 3) {
              //Kudos
              pointsToAdd += 10;
              //target_points = current_level *50

            }

            var userRef = databaseReference.collection('users');
            await userRef
                .where('email', isEqualTo: recvEmail)
                .get()
                .then((value) => value.docs.forEach((element) {
                      var userOldData = CustomUser.fromJson(element.data());
                      var newPoints = userOldData.points + pointsToAdd;
                      var _currentLevel = userOldData.level;
                      var targetPoints = _currentLevel * 50;
                      if (userOldData.points < targetPoints &&
                          newPoints >= targetPoints) {
                        _currentLevel += 1;
                      }

                      userRef.doc(element.id).update({
                        'points': userOldData.points + pointsToAdd,
                        'level': _currentLevel,
                        'category1': _selectedCompany.id == 1
                            ? userOldData.category1 += 2
                            : userOldData.category1,
                        'category2': _selectedCompany.id == 2
                            ? userOldData.category2 += 2
                            : userOldData.category2,
                        'category3': _selectedCompany.id == 3
                            ? userOldData.category3 += 2
                            : userOldData.category3,
                        'category4': _selectedCompany.id == 4
                            ? userOldData.category4 += 2
                            : userOldData.category4,
                        'category5': _selectedCompany.id == 5
                            ? userOldData.category5 += 2
                            : userOldData.category5
                      });
                    }));
            //TODO: show alert dialog
            //TODO: show notifications
            Cheer cheer = Cheer.name(
              _titleController.text,
              prefs.getString('email'),
              prefs.getString('name'),
              prefs.getString('imgUrl'),
              this.widget.employee != null
                  ? this.widget.employee.name
                  : this._selectedEmployee.name,
              prefs.getString('role'),
              this.widget.employee != null
                  ? this.widget.employee.email
                  : this._selectedEmployee.email,
              _messageTextController.text,
              color,
              cheerType,
              _selectedCompany.name,
              DateTime.now(),
            );
            await databaseReference.collection("cheers").add(cheer.toJson());

            Navigator.pop(context);
          }
        },
        child: Container(
          width: 140,
          height: 39,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Send with Love.",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.favorite,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _buildScreenUI(context),
        ],
      )),
    );
  }
}

class Category {
  int id;
  String name;

  Category(this.id, this.name);

  static List<Category> getCategory() {
    return <Category>[
      Category(1, 'Hardwork'),
      Category(2, 'Dedication'),
      Category(3, 'Teamwork'),
      Category(4, 'Friendliness'),
      Category(5, 'Management'),
    ];
  }
}
