import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/model/users_model.dart';
import 'package:localstorage/repo/permission_handler.dart';
import 'package:localstorage/repo/services.dart';
import 'package:localstorage/repo/user_simple_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  File? image;
  Future<List<UserModel>> userListFuture = Service.apiCall();
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Pick Image'),
              onTap: () async {
                image = await Service.pickImage();

                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              title: const Text('Scan barcode'),
              onTap: () {
                Navigator.pushNamed(context, '/barcode_scanner_screen');
              },
            ),
            ListTile(title: Text('Map'),onTap: (){
              Navigator.pushNamed(context, '/MapScreen');
            },)
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Text('${data['email']} successful '),
          ElevatedButton(
              onPressed: () async {
                String? result = UserSimplePreference.getEmail('');
                Service.apiCall();
              },
              child: const Text('get users from api')),
          // Container(
          //   color: Colors.white70,
          //   width: size.width * 0.8,
          //   height: size.height * 0.5,
          //   child: (image != null)
          //       ? Image.file(
          //           image!,
          //           fit: BoxFit.fill,
          //         )
          //       : const SizedBox(),
          // )
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: userListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          leading: Text('${snapshot.data![index].id}'),
                        );
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
