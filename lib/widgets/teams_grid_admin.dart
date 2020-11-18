import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamGridAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Companies").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {


            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var name = snapshot.data.docs[index].data()['companyName'];
                  var description = snapshot.data.docs[index].data()['description'];

                  return ListTile(
                    title: Text(name),
                    subtitle: Text(description),
                  );
                },
              ),
            );
          } else {
            return Container(
              width: 250,
              height: 100,
              child: Text('No Team found'),
            );
          }
        },
      ),
    );
  }
}
//
// class TeamContainer extends StatelessWidget {
//   final name;
//
//   TeamContainer(this.name);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.green.withOpacity(0.32),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.green)),
//         width: MediaQuery.of(context).size.width * 0.45,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.star_border,
//                         color: Colors.white,
//                       )),
//                 ),
//                 Text(
//                   '$name',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: 'OpenSans',
//                       fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
//               child: Text(
//                 'Web Dev Compnay',
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontFamily: 'OpenSans',
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {},
//                 child: Text(
//                   'View Full Team',
//                   style: TextStyle(
//                       color: Colors.black45,
//                       fontSize: 9,
//                       fontFamily: 'OpenSans',
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
