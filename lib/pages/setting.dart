import 'package:flutter/material.dart';
import 'package:flutter_application_sample/providers/font.dart';
import 'package:flutter_application_sample/providers/theme.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  final String title;

  const SettingPage(this.title, {super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool theme;

  @override
  @override
  Widget build(BuildContext context) {
    var theme = context.watch<ThemeProvider>().isDarkTheme;
    return Scaffold(
        body: Column(children: [
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: theme,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      theme = value;
                      // Call the parent's toggleTheme to change the global theme
                      context.read<ThemeProvider>().toggleTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Font",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: context.watch<FontProvider>().fontFamily,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.pink),
                    underline: Container(
                      height: 2,
                      color: Colors.pink,
                    ),
                    onChanged: (String? newValue) {
                      newValue = newValue!;
                      context.read<FontProvider>().changeFont(newValue);
                    },
                    items: <String>[
                      'Lato',
                      'Poppins',
                      'Montserrat',
                      'Open Sans',
                      'Roboto'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
