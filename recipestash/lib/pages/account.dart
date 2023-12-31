// Import necessary packages and modules
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:recipestash/classes/recipe_model.dart';
import 'package:recipestash/main.dart';

// Account class representing the Account screen in the Recipe app
class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  // Asynchronous method to sign out the user
  Future<void> signOut() async {
    await Authentication().signOut();
  }

  // Method to delete all recipes
  void deleteAllRecipe() async {
    await RecipeModel().deleteAllRecipe();
  }

  // Build method to create the UI for the Account screen
  @override
  Widget build(BuildContext context) {
    final User? user = Authentication().currentUser;
    bool isGoogleUser = user?.providerData[0].providerId == "google.com";

    return Scaffold(
      backgroundColor: preferences.darkMode == 1 ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor:
            Color.fromARGB(255, preferences.r!, preferences.g!, preferences.b!),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isGoogleUser
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user?.photoURL ?? ''),
                        radius: 40)
                    : Icon(Icons.account_circle,
                        size: 80,
                        color: preferences.darkMode == 1
                            ? Colors.white
                            : Colors.black),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user!.displayName!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: preferences.darkMode == 1
                                ? Colors.white
                                : Colors.black)),
                    Text(user.email!,
                        style: TextStyle(
                            fontSize: 15,
                            color: preferences.darkMode == 1
                                ? Colors.white
                                : Colors.black))
                  ],
                )
              ],
            ),
          ),
          // Button to delete all recipes
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: preferences.darkMode == 1
                          ? Colors.black
                          : Colors.white,
                      title: Text("Delete all recipes?",
                          style: TextStyle(
                              color: preferences.darkMode == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      content: Text("This action cannot be undone.",
                          style: TextStyle(
                            color: preferences.darkMode == 1
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No",
                                style: TextStyle(
                                    color: preferences.darkMode == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        TextButton(
                            onPressed: () {
                              deleteAllRecipe();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Deleted all recipes!")));
                            },
                            child: Text("Yes",
                                style: TextStyle(
                                    color: preferences.darkMode == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)))
                      ],
                    );
                  });
            },
            style: TextButton.styleFrom(alignment: Alignment.centerLeft),
            child: const Text('Delete all recipes'),
          ),
          // Button to sign out
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: preferences.darkMode == 1
                            ? Colors.black
                            : Colors.white,
                        title: Text("Sign out",
                            style: TextStyle(
                                color: preferences.darkMode == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        content: Text("Are you sure you want to sign out?",
                            style: TextStyle(
                              color: preferences.darkMode == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                            )),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      color: preferences.darkMode == 1
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          TextButton(
                              onPressed: () {
                                signOut();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Signed out successfully!")));
                              },
                              child: Text("Yes",
                                  style: TextStyle(
                                      color: preferences.darkMode == 1
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)))
                        ],
                      );
                    });
              },
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              child: const Text('Sign out')),
        ],
      ),
    );
  }
}
