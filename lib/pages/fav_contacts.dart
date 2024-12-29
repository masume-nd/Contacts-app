import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_sample/providers/contacts.dart';

// We can use only one class with an input list of items instead of separate classes for favorites and all contacts
class ContactsPage extends StatefulWidget {
  final String title;
  final List<String> items;

  const ContactsPage(this.title, {required this.items, super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    var favcontacts = context.watch<ContactsProvider>().favcontacts;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180, // Height of the AppBar section
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 244, 49, 114), // Pink
                      Color.fromARGB(255, 251, 163, 214), // Lighter pink
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const SafeArea(
                  child: Center(
                    child: Text(
                      'Sara',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Body background color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5), // Slight shadow for elevation
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: ListView.builder(
                itemCount: favcontacts.length,
                itemBuilder: (context, index) {
                  var item = favcontacts[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(
                              255, 210, 210, 210), // Light grey border
                          width: 1.0, // Border thickness
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
