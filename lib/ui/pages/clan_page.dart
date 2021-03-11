import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';

class ClanPage extends StatelessWidget {
  const ClanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text('clan'),),
    );
  }
}

class ClanPageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('ClanPageAppBar'));
  }
}
// class ClanStatistics extends StatelessWidget {
//   final PlayerInfo data;
//   ClanStatistics({this.data});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         clanStateCard(),
//       ],
//     );
//   }

//   Widget clanStateCard() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       elevation: 3.0,
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     height: 50,
//                     width: 50,
//                     child: Image.network(data.clan.badgeUrls.medium),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     children: [
//                       Text(
//                         '${data.clan.name}',
//                         style: themeData.textTheme.headline2,
//                       ),
//                       Text(
//                         '${data.clan.tag}',
//                         style: themeData.textTheme.headline3,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: IconButton(
//                       splashRadius: 20,
//                       splashColor: themeData.accentColor,
//                       icon: Icon(Icons.share_outlined),
//                       iconSize: 18,
//                       color: themeData.primaryColor.withOpacity(0.8),
//                       onPressed: () {
//                         Clipboard.setData(
//                             new ClipboardData(text: data.clan.tag));
//                       }),
//                 ),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               // child: Text('${data.clan.}'),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }