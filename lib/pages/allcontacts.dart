import 'package:flutter/material.dart';
import 'package:flutter_application_sample/pages/contact_detail.dart';
import 'package:flutter_application_sample/providers/contacts.dart';
import 'package:provider/provider.dart';

class AllContacts extends StatefulWidget {
  final String title;
  // Add this property

  const AllContacts(
    this.title, {
    super.key,
  });

  @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  @override
  Widget build(BuildContext context) {
    var allcontacts = context.watch<ContactsProvider>().allcontacts;
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Search...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: allcontacts.length,
                itemBuilder: (context, index) {
                  var item = allcontacts[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      if (!favcontacts.contains(item)) {
                        context.read<ContactsProvider>().addToFav(item);
                      } else {
                        context.read<ContactsProvider>().removeFromList(item);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade300, // Light grey border
                            width: 1.0, // Border thickness
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4), //
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                if (allcontacts[index].isfav)
                                  const Icon(Icons.favorite, color: Colors.red),
                              ]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactDetail(
                                        title: 'Contant Detail',
                                      )),
                            );
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
