import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  "Sign In",
                  style: GoogleFonts.lato(
                    color: const Color(0xFF01e90ff),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
                Wrap(
                  runSpacing: 10,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Color(0XFF455A64),
                          fontSize: 20,
                        ),
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Color(0XFF455A64),
                          fontSize: 20,
                        ),
                        hintText: "Enter your password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "HomeScreen");
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 19, 48, 62),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      backgroundColor: const Color(0xFF01e90ff),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = emailController.text.toString();
                        final password = passwordController.text.toString();

                        try {
                          UserCredential userCredential =
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // User signed in successfully, proceed to retrieve additional details
                          Map<String, dynamic>? userDetails = await getUserDetails(email);

                          if (userDetails != null) {
                            // TODO: Add your authentication logic here if needed
                            print("User details: $userDetails");

                            // Navigate to the MainScreen or display details as needed
                            Navigator.pushNamed(context, "MainScreen");
                          } else {
                            // Show a message indicating that the user data is not available
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('User data not available'),
                              ),
                            );
                          }
                        } catch (e) {
                          print("Authentication failed: $e");
                          // Handle authentication failure, show error message, etc.
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "SignUpScreen");
                      },
                      child: const Text(
                        "Sign-Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 19, 48, 62),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      // Query the users collection based on the email
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      // Check if any documents match the query
      if (snapshot.docs.isNotEmpty) {
        // Retrieve the data of the first document
        Map<String, dynamic> userData = snapshot.docs[0].data()!;
        print("User details retrieved: $userData");
        return userData;
      } else {
        print("User does not exist");
        return null;
      }
    } catch (e) {
      print("Error retrieving user details: $e");
      return null;
    }
  }
}
