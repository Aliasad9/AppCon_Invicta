import 'package:Invicta/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/heading.dart';

class CreateCheerScreen extends StatefulWidget {
  final teamList;
  final employee;

  CreateCheerScreen({this.teamList, this.employee});

  @override
  _CreateCheerScreenState createState() => _CreateCheerScreenState();
}

class _CreateCheerScreenState extends State<CreateCheerScreen> {
  TextEditingController _messageTextController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  List<Category> _companies = Category.getCategory();
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedCompany;
  bool _isBlueChecked = true;
  bool _isRedChecked = false;
  bool _isTealChecked = false;
  bool _isOrangeChecked = false;
  bool _isPurpleChecked = false;
  Color textFieldColor = Colors.blue;
  int cheerType = 1;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List companies) {
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

  onChangeDropdownItem(Category selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 32),
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
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                //keyboardType: TextInputType.emailAddress,
              ),
            ),
            _buildTextField(this.textFieldColor),
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
            cheerType == 1 ? _buildDropDown() : Container(),
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

  _buildDropDown() {
    return Card(
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: _selectedCompany,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
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
        onPressed: () {
          Navigator.pushNamed(context, "/admin");
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
