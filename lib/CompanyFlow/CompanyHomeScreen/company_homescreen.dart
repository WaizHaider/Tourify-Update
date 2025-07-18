import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourify/CompanyFlow/CompanyHomeScreen/CompanyHomeScreenComponents/HomeScreenCard.dart';
import 'package:tourify/CompanyFlow/bookings.dart';
import 'package:tourify/Utilities/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class CompanyHomeScreen extends StatefulWidget {
  final String? currentUserEmail;

  const CompanyHomeScreen({Key? key, this.currentUserEmail}) : super(key: key);

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  String? category;
  DateTime? selectedDate;
  DateTime? initialDate = DateTime.now();
  final DiscriptionController = TextEditingController();
  final BudgetController = TextEditingController();
  final DurationController = TextEditingController();
  final DepartureController = TextEditingController();
  final titleController = TextEditingController();
  final CompanyNameController = TextEditingController();
  final companyIDController = TextEditingController();
  final companyEmailController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String? currentUserEmail;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref().child('Tours');
  }

  String? currentUserId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    currentUserEmail = widget.currentUserEmail;

    // Get current user ID using the provided email
    if (currentUserEmail != null) {
      getCurrentUserId(currentUserEmail!);
    } else {
      print('Error: Company email not provided.');
    }
  }

  Future<void> getCurrentUserId(String email) async {
    try {
      User? user = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email)
          .then((value) async {
        if (value.isNotEmpty) {
          // User exists, fetch user data to get UID
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: 'temporary_password', // Provide a temporary password
          );
          return userCredential.user;
        }
        return null;
      });

      if (user != null) {
        setState(() {
          currentUserId = user.uid;
        });
      } else {
        print('Error: Current user ID is null');
      }
    } catch (error) {
      print('Error getting current user ID: $error');
    }
  }


  Future<void> getGalleryImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }
  Future<String?> getCurrentUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.email;
    } catch (error) {
      print('Error getting current user email: $error');
      return null;
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      print("No image selected");
      return;
    }

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference storageReference =
      storage.ref().child('$fileName');

      await storageReference.putFile(_image!);
      String downloadURL = await storageReference.getDownloadURL();

      var random = Random();
      var randomRating = random.nextInt(6);
      var formattedDate =
          "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}";

      // Use the selected category as a key instead of generating a new push key
      var newTourRef = databaseReference.child(category!).push();
      await newTourRef.set({
        'Discription': DiscriptionController.text,
        'Budget': BudgetController.text,
        'Duration': DurationController.text,
        'Departure': DepartureController.text,
        'Date': formattedDate.toString(),
        'Category': category.toString(),
        'Rating': randomRating,
        'Title': titleController.text,
        'Company': CompanyNameController.text,
        'CompanyEmail': companyEmailController.text,
        'CompanyID': companyIDController.text,
        'ImageURL': downloadURL,
      });

      Utilities().show_Message('Your Tour has been Shared Successfully');
    } catch (error) {
      print("Error uploading image: $error");
      Utilities().show_Message('Error uploading image. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
debugPrint('$currentUserEmail');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Tourify"),
        centerTitle: true,
        backgroundColor: const Color(0xff1034A6),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xff1034A6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: GestureDetector(
                    onTap: () async {
                      if (currentUserEmail != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bookings(currentUserEmail: currentUserEmail),
                          ),
                        );
                      } else {
                        // Handle the case where you couldn't get the current user's email
                        print('Error: Could not get the current user\'s email.');
                      }
                    },
                    child: Text(
                      'Click To See Bookings',
                      style: GoogleFonts.abel(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  child: Text(
                    "Share your Tours",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: GestureDetector(
                    onTap: () {
                      getGalleryImage();
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: _image == null
                          ? Icon(
                        Icons.add_photo_alternate,
                        size: 40,
                        color: Color(0xff1034A6),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    "Select your tour category type : ",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              category = 'Adventure';
                            });
                            debugPrint(category.toString());
                          },
                          child: const HomeCard(
                            imagetitle: 'assets/pageone.jpeg',
                            title: 'Adventure',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              category = 'Religious';
                            });
                            debugPrint(category.toString());
                          },
                          child: const HomeCard(
                            imagetitle: 'assets/religious.jpeg',
                            title: 'Religious',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              category = 'Historical';
                            });
                            debugPrint(category.toString());
                          },
                          child: const HomeCard(
                            imagetitle: 'assets/historical.jpeg',
                            title: 'Historical',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              category = 'SightSeeing';
                            });
                            debugPrint(category.toString());
                          },
                          child: const HomeCard(
                            imagetitle: 'assets/sights.jpg',
                            title: 'SightSeing',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              category = 'FriendsNFamily';
                            });
                            debugPrint(category.toString());
                          },
                          child: const HomeCard(
                            imagetitle: 'assets/familyfriends.jpg',
                            title: 'Family and Friends',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: const Text('Title'),
                      prefixIcon: const Icon(Icons.place),
                      hintText: 'Enter Tour Destination point',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: companyIDController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Company ID'),
                      prefixIcon: const Icon(Icons.perm_identity),
                      hintText: 'Enter Company ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: companyEmailController,
                    decoration: InputDecoration(
                      label: const Text('Company Email'),
                      prefixIcon: const Icon(Icons.email_rounded),
                      hintText: 'Enter Company Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: DiscriptionController,
                    decoration: InputDecoration(
                      label: const Text('Discription'),
                      prefixIcon: const Icon(Icons.description),
                      hintText: 'Enter Tour Discription',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: BudgetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Budget '),
                      prefixIcon: const Icon(Icons.currency_rupee),
                      hintText: 'Enter Tour Budget',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: DurationController,
                    decoration: InputDecoration(
                      label: const Text('Duration'),
                      prefixIcon: const Icon(Icons.timer),
                      hintText: 'Enter Tour Duration',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: DepartureController,
                    decoration: InputDecoration(
                      label: const Text('Departure Location'),
                      prefixIcon: const Icon(Icons.place),
                      hintText: 'Enter Tour departure point',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: CompanyNameController,
                    decoration: InputDecoration(
                      label: const Text('Company Name'),
                      prefixIcon: const Icon(Icons.place),
                      hintText: 'Enter Company Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff01e90ff),
                      elevation: 20,
                      shadowColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDate!,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025),
                      );
                      debugPrint(selectedDate.toString());
                    },
                    child: Text(
                      'Choose Date',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1034A6),
                      elevation: 20,
                      shadowColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      await uploadImage();
                      var random = Random();
                      var randomRating = random.nextInt(6);
                      var formattedDate =
                          "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}";
                      var newTourRef = databaseReference.push();
                      Utilities().show_Message(
                        'Your Tour has been Shared Successfully',
                      );
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
