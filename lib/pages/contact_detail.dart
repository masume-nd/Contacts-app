import 'package:flutter/material.dart';
import 'edit_contact.dart';
import 'package:flutter_application_sample/utils/index.dart';

class ContactDetail extends StatefulWidget {
  final String title;
// Add this property

  const ContactDetail({required this.title, super.key});

  @override
  State<ContactDetail> createState() => _ContactDetail();
}

class _ContactDetail extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            // Gradient AppBar Section
            Container(
              height: 310, // Height of the AppBar section
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
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      // Top Row: Back Icon, Title, and Edit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                          const Text(
                            'Sara',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditContact(
                                          title: 'Edit Contact',
                                        )),
                              );
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Spacing
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Text(
                          'A',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Main Content Section
            Positioned(
              top: 280,
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
        SingleChildScrollView(
          child: Container(
            height: 646,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16), // Spacing
                  // Example Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        Icons.message,
                        'Message',
                        onTap: () => sendSMS('+1-555-010-999', 'Hello!'),
                      ),
                      _buildActionButton(Icons.phone, 'Call', onTap: () {
                        makePhoneCall('+1-555-010-999');
                      }),
                      _buildActionButton(Icons.videocam, 'Video'),
                      _buildActionButton(Icons.email, 'Email',
                          onTap: () => sendEmail('LjDZQ@example.com',
                              subject: 'Hello', body: 'How are you?')),
                    ],
                  ),
                  const Divider(height: 32),
                  // Contact Photo Section
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(102, 244, 164, 211),
                      child: Text('S'),
                    ),
                    title: Text('Contact Photo & Poster'),
                  ),
                  const Divider(),
                  // Example Contact Fields
                  _buildContactField('Phone', '0513 843 3157'),
                  const Divider(),
                  _buildContactField('Notes', 'No notes available'),
                  const Divider(),
                  // Additional Options
                  _buildOption('Send Message'),
                  _buildOption('Share Contact'),
                  _buildOption('Add to Favorites'),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildContactField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16), // Optional padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color.fromARGB(255, 244, 49, 114)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

// Helper Widget for Action Buttons
  Widget _buildActionButton(IconData icon, String label, {Function()? onTap}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color.fromARGB(102, 244, 164, 211),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: label == 'Video'
                  ? const Color.fromARGB(255, 244, 140, 175)
                  : const Color.fromARGB(255, 244, 49, 114),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

// Helper Widget for Options
  Widget _buildOption(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Color.fromARGB(255, 244, 49, 114)),
      ),
      onTap: () {},
    );
  }
}
