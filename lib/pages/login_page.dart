import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_sync/components/square.dart';
import 'package:todo_app_sync/services/auth_service.dart';
import '../components/custom_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //google sign
  void googleSign(){
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: CustomColors.bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 20,),

                //logo
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                    //color: CustomColors.primaryColorFade,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                                "lib/images/7495401.png"),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 16,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "S'organiser",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primaryColor,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: Colors.grey,
                                    offset: Offset(2.0, 2.0),
                                  )
                                ]
                              ),
                            ),
                            Text(
                              "Pour",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primaryColor,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.grey,
                                      offset: Offset(2.0, 2.0),
                                    )
                                  ]
                              ),
                            ),
                            Text(
                              "Réussir",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primaryColor,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.grey,
                                      offset: Offset(2.0, 2.0),
                                    )
                                  ]
                              ),
                            ),
                          ],
                        ),

                      )
                    ]
                  ),
                ),

                const SizedBox(height: 60,),

                const SizedBox(height: 25,),

                //ou se connecter avec
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Continuer avec",
                          style: TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                //login bouton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    SquareTile(imagePath:
                    'lib/images/icons8-google-96.png',
                      onTap: () => AuthService().signInWithGoogle() ,
                    ),
                    const SizedBox(width: 20,),
                    //apple
                    SquareTile(imagePath:
                    'lib/images/icons8-apple-logo-100.png',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 100,),

                //brand
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Itech-gabon 2023",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}