import 'package:flutter/material.dart';
import 'package:shop_app_start/modules/todo/bmi.dart';

class validLogin extends StatefulWidget {
  @override
  State<validLogin> createState() => _validLoginState();
}

class _validLoginState extends State<validLogin> {
  var emailcon = TextEditingController();
  var passcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool ispass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('images/fir.jpg'),
            width: double.infinity,
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadiusDirectional.circular(20.0),
              ),
              height: 500.0,
              width: 500.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(200.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                image: AssetImage('images/bigRamy.jpg'),
                                fit: BoxFit.cover,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: emailcon,
                              enableSuggestions: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'not allowed empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              obscureText: ispass,
                              controller: passcon,
                              enableSuggestions: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'not allowed empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                suffixIcon: IconButton(
                                  icon: ispass
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      ispass = !ispass;
                                    });
                                  },
                                ),
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                              ),
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (context) => bmis(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
