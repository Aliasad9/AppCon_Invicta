import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiauth/heading.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  Widget _buildScreenUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Heading("Cheers For Awais Qamar!"),
          _buildSubHeading('Preview'),
          _buildTextField(),
          _buildSubHeading('Select Desired Color'),

          Row(
            children: [
              _buildColoredContainer(Colors.blue, Colors.blue),
              _buildColoredContainer(Colors.tealAccent, Colors.tealAccent),
              _buildColoredContainer(Colors.redAccent, Colors.redAccent),
              _buildColoredContainer(Colors.yellow, Colors.yellow),
              _buildColoredContainer(Colors.purple, Colors.purple)
            ],
          ),
          SizedBox(height: 10,),
          _buildSubHeading("Select the Label"),
          _buildContainer(Colors.purple, Colors.blueGrey, Colors.yellowAccent[100]),
          _buildSubHeading('Select a Category'),
          _buildDropDown(),
          _buildSubHeading('Ready to Send?'),
          _buildButton(),
        ],
      ),
    );
  }



  _buildSubHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1.merge(
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7))),
      ),
    );
  }

  _buildTextField({Color fillColor}) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blue.withOpacity(0.35),
        hintText: 'Type a Super Nice Message...',

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 4,
            )),
      ),
    );
  }
      _buildContainer(Color color,Color color2, Color color3){
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child:Row(
          children: [
            Container(

              child: Center(
                child: Text(" Cheers",style: TextStyle(
                  fontFamily: "Oswald",
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),),
              ),
                width:100,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color:color3,
                )),
            Container(

                child: Center(
                  child: Text(" Birthdays",style: TextStyle(
                    fontFamily: "Oswald",
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),),
                ),
                width:100,
                height: 30,
                decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(8),
              color:color2,
            )),
            Container(
                child: Center(
                  child: Text(" Kudos",style: TextStyle(
                    fontFamily: "Oswald",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),),
                ),
              width:100,
              height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)
                  ),
                  color: color,
                )),
          ],
        ),
          );
      }
    _buildColoredContainer(Color color, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          setState(() {
            _buildTextField(fillColor: Colors.yellowAccent);
          });
        },
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor.withOpacity(0.35), width: 2,style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(40),
              color: color.withOpacity(0.35)),

        ),
      ),
    );
  }

  _buildDropDown() {
    return Card(
      elevation: 3,
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
    return RaisedButton(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.red,
      onPressed: () {
        Navigator.pushNamed(context,"/admin");
      },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invicta',
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(left: 140, right: 10),
              width: 65,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                backgroundImage: ExactAssetImage('images/a.jpg'),
              ),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(
                  color: Colors.blueAccent,
                  width: 4.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: _buildScreenUI(context)
    );
  }
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Hardwork'),
      Company(2, 'Dedication'),
      Company(3, 'Teamwork'),
      Company(4, 'Friendliness'),
      Company(5, 'Management'),
    ];
  }
}
