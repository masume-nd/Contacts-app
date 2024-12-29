import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final String title;
// Add this property

  const EditContact({required this.title, super.key});

  @override
  State<EditContact> createState() => _EditContact();
}

class _EditContact extends State<EditContact> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _phoneControllers = [];
  final _formKey = GlobalKey<FormState>();
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
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Done',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), // Spacing
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.camera_alt, size: 30),
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
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Body background color
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: const [
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
                  // Example Contact Fields
                  _buildTextFieldRow(
                    'first name',
                    _firstnameController,
                  ),
                  const Divider(),
                  _buildTextFieldRow('last name', _lastnameController),

                  const Divider(),
                  _buildTextFieldRow(
                    'Email',
                    _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Divider(),
                  _buildTextFieldRow(
                    'Phone',
                    _mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      final mobilephone = RegExp(r'^09\d{9}$');
                      if (!mobilephone.hasMatch(value)) {
                        return 'Please enter a valid mobile phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const Divider(),
                  _buildTextFieldRow(
                    'Home',
                    _homeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      final homePhone = RegExp(
                          r'^(?:\+98|0)(21|22|23|24|25|26|31|32|33|34|41|42|43|44|51|52|53|61|62|63|64|71|72|73|74|81|82|83|84|85|86)\d{7}$');
                      if (!homePhone.hasMatch(value)) {
                        return 'Please enter a valid mobile phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const Divider(),
                  _buildTextFieldRow(
                    'Work',
                    _workController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      final mobilephone = RegExp(r'^09\d{9}$');
                      if (!mobilephone.hasMatch(value)) {
                        return 'Please enter a valid mobile phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildTextFieldRow(
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
    keyboardType, // Accept a validator function
  }) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.ltr, // Ensure LTR for input text
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor ??
            Colors.white, // Use theme's input decoration color
        hintText: label,
        hintTextDirection: TextDirection.ltr, // Ensure hint is also LTR
      ),
      validator: validator,
      keyboardType: keyboardType, // Use the passed validator function
    );
  }

// Helper Widget for Action Buttons
  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color.fromARGB(102, 244, 164, 211),
          child: Icon(icon,
              color: const Color.fromARGB(255, 244, 49, 114), size: 25),
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

  @override
  void dispose() {
    // Dispose controllers to free up resources when the widget is destroyed
    _firstnameController.dispose();
    _lastnameController.dispose();
    _homeController.dispose();
    _workController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
