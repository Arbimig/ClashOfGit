import 'package:clashofclans/data/bloc/switch_th_lvl_cubit.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/internal/base_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../internal/apps_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

class MapsPage extends StatelessWidget {
  final GetBasePlans getBasePlans = GetBasePlans();
  final String state;
  MapsPage(this.state);
  @override
  Widget build(BuildContext context) {
    var base = getBasePlans.getBase();
    return TabBarView(children: [
      body(base[state]['farm']),
      body(base[state]['war']),
      body(base[state]['defence']),
    ]);
  }

  Widget body(var base) {
    return GridView.builder(
        cacheExtent: 1000,
        itemCount: base.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                mediaQueryData.orientation == Orientation.portrait ? 2 : 4),
        itemBuilder: (context, i) {
          var data = base;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              splashColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(data[i], i)));
              },
              child: Container(
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          color: Colors.grey[700]!,
                          spreadRadius: 0.0)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Hero(
                    tag: 'imageHero$i',
                    child:
                        // Image.network(
                        //   '${data[i]['imageUrl']}',
                        //   fit: BoxFit.fitHeight,
                        // ),
                        CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "${data[i]['imageUrl']}",
                      // placeholder: (context, url) =>
                      //     CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class MapPage extends StatelessWidget {
  final dynamic data;
  final int i;
  MapPage(this.data, this.i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    height: deviceHeight * 0.3,
                    decoration: BoxDecoration(),
                    child: Hero(
                      tag: 'imageHero$i',
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "${data['imageUrl']}",
                        // placeholder: (context, url) =>
                        //     CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(themeData.accentColor)),
                  onPressed: () {
                    launch(
                      '${data['baseUrl']}',
                      forceWebView: false,
                    );
                  },
                  child: Text('Copy base in game'))
            ],
          ),
        ),
      ),
    );
  }
}

class MapsPageAppBar extends StatelessWidget with PrefAppBar {
  final String thlvlstate;
  MapsPageAppBar(this.thlvlstate);
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
  Widget build(BuildContext context) {
    var theLevel = context.read<ThLevlel>();
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      bottom: TabBar(
        tabs: [
          Tab(
            child: Text('Farm',
                style: themeData.textTheme.subtitle1,
                softWrap: false,
                overflow: TextOverflow.fade),
          ),
          Tab(
            child: Text('War',
                style: themeData.textTheme.subtitle1,
                softWrap: false,
                overflow: TextOverflow.fade),
          ),
          Tab(
            child: Text(
              'Defence',
              style: themeData.textTheme.subtitle1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
      title: Text(
        'Maps ' + thlvlstate,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 4',
                  style: themeData.textTheme.headline2,
                ),
                value: '4th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 5',
                  style: themeData.textTheme.headline2,
                ),
                value: '5th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 6',
                  style: themeData.textTheme.headline2,
                ),
                value: '6th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 7',
                  style: themeData.textTheme.headline2,
                ),
                value: '7th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 8',
                  style: themeData.textTheme.headline2,
                ),
                value: '8th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 9',
                  style: themeData.textTheme.headline2,
                ),
                value: '9th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 10',
                  style: themeData.textTheme.headline2,
                ),
                value: '10th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 11',
                  style: themeData.textTheme.headline2,
                ),
                value: '11th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 12',
                  style: themeData.textTheme.headline2,
                ),
                value: '12th'),
            PopupMenuItem<String>(
                child: Text(
                  'TownHall 13',
                  style: themeData.textTheme.headline2,
                ),
                value: '13th'),
          ],
          onSelected: (value) {
            theLevel.getLevel(value);
          },
        ),
      ],
      centerTitle: true,
    );
  }
}
