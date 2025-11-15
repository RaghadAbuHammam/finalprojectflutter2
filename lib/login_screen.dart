// import 'package:finalproject/widgets/custom_bottom_nav.dart';
import 'package:finalprojectflutter2/home_screen.dart';
import 'package:finalprojectflutter2/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<String> logIn(String email , String password)async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
  final credential = await firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'invalid-email') {
    return('invalid email');
  } else if (e.code == 'invalid-credential') {
    return('invalid credential');
  }
}
return 'error';
  }

  @override

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Form(
            key: formKey,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Lottie.network(
                      'https://lottie.host/0498fd41-11e5-4680-884f-857276883652/K7tSiWlDP0.json',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.abc,
                        ),
                        label: Text(
                          'Your Name :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        hintText: 'EX:Raghad',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                        ),
                        label: Text(
                          'Your Password :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        hintText: 'example123@@',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        String result = await logIn(
                          emailController.text,
                          passwordController.text,
                        );
                        if (result == 'done') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(result)));
                        }

                        emailController.clear();
                        passwordController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.3,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: (){

                  }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.network( 
                      height: 30,
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJg75LWB1zIJt1VTZO7O68yKciaDSkk3KMdw&s')
                  ],
                  ),
                  style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.3,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.2,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            'Go Back',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
