//import 'package:finalproject/widgets/custom_bottom_nav.dart';
import 'package:finalprojectflutter2/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Future<String> signUp(String email , String pass)async{
    FirebaseAuth firebaseAuth =FirebaseAuth.instance;
    try {
  final credential = await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: pass,
  );
  return 'done';
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    return('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    return('The account already exists for that email.');
  }
} catch (e) {
  return(e.toString());
}
return 'erroe';
  }

  @override

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Lottie.network(
                    'https://lottie.host/58613afb-f768-41a6-a0ec-984dae1fdff0/UOJV49fHVl.json',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.abc),
                      labelText: 'Your Email :',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'EX:Raghad@gmail.com',
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
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 3,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                      ),
                      labelText: 'Your Password :',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
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
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          width: 3,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
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
                    onPressed: ()async{
                      String result = await signUp(emailController.text , passwordController.text);
                      if(result=='done'){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      }
                      else{
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(result)));
                      }
                      
                      emailController.clear();
                      passwordController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, top: 30),
                  child: Row(
                    children: [
                      Text(
                        'Already have an account ? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
