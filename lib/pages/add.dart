import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final String title;

  const AddPage(this.title, {super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
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
            SingleChildScrollView(
              child: Container(
                height: 676,
                decoration: BoxDecoration(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .error, // Use card color from theme
                    ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFieldRow("Name", _nameController),
                    const Divider(),
                    const SizedBox(height: 12),
                    _buildTextFieldRow("Mobile ", _mobileController),
                    const Divider(),
                    const SizedBox(height: 12),
                    _buildTextFieldRow("Office (optional)", _workController),
                    const Divider(),
                    const SizedBox(height: 12),
                    _buildTextFieldRow("Home (optional)", _homeController),
                    const Divider(),
                    const SizedBox(height: 38),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, String> nums = Map();
                          nums['home'] = _homeController.text;
                          nums['work'] = _workController.text;
                          nums['mobile'] = _mobileController.text;
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
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
            Theme.of(context).colorScheme.onPrimary,
        // Use theme's input decoration color
        hintText: label,
        hintTextDirection: TextDirection.ltr, // Ensure hint is also LTR
      ),
      validator: validator,
      keyboardType: keyboardType, // Use the passed validator function
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources when the widget is destroyed
    _nameController.dispose();
    _homeController.dispose();
    _workController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
