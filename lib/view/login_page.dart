import 'package:flutter/material.dart';
import 'package:localstorage/repo/user_simple_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text('Title'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (val) => email = val,
                decoration:  InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)
                
                  ),
                  hintText: "Enter Email"),
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (val) => password = val,
                decoration:  InputDecoration(
                   labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
                
                  ),
                  hintText: "Enter Password"),
              ),
            ),

            ElevatedButton(
                onPressed: () async {
                  await UserSimplePreference.setEmail(email);
                  Navigator.of(context)
                      .pushNamed('/home_screen', arguments: {'email':email});
                },
                child: const Text('Submit'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)))
          ],
        ),
      )),
    );
  }
}
