import 'package:flutter/material.dart';
import 'package:flutter_application_sample/pages/contact_detail.dart';
import 'package:flutter_application_sample/providers/contacts.dart';
import 'package:flutter_application_sample/providers/font.dart';
import 'package:flutter_application_sample/providers/theme.dart';
import 'package:flutter_application_sample/utils/data_base.dart';
import 'package:provider/provider.dart';
import 'pages/setting.dart';
import 'pages/add.dart';
import 'pages/allcontacts.dart';
import 'pages/fav_contacts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // Initializes the database
  runApp(const ContactsProject());
}

class ContactsProject extends StatefulWidget {
  const ContactsProject({super.key});

  @override
  State<ContactsProject> createState() => _ContactsProjectState();
}

class _ContactsProjectState extends State<ContactsProject> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    // Access both ThemeProvider and FontProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ContactsProvider()), // Existing provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (_) => FontProvider()) // FontProvider added
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Consumer<FontProvider>(
            builder: (context, fontProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.grey[200],
                  textTheme: TextTheme(
                    bodyMedium: fontProvider
                        .getFontStyle(16), // Apply Google Font to bodyText1
                    bodySmall: fontProvider
                        .getFontStyle(14), // Apply Google Font to bodyText2
                    // You can add more text styles here based on your design needs
                  ),
                ),
                darkTheme: ThemeData.dark(),
                themeMode: themeProvider.isDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode
                        .light, // Use ThemeProvider to manage dark/light theme
                home: MainPage(
                  toggleTheme: themeProvider
                      .toggleTheme, // Pass toggleTheme from ThemeProvider
                  isDarkTheme: themeProvider
                      .isDarkTheme, // Pass isDarkTheme from ThemeProvider
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final void Function() toggleTheme;
  final bool isDarkTheme;

  const MainPage(
      {super.key, required this.toggleTheme, required this.isDarkTheme});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Four tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
        child: SizedBox(
          height: 100, // Adjust the height as needed
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.all(0),
            indicatorWeight: 2.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
            tabs: const [
              Tab(icon: Icon(Icons.list), text: 'All Contacts'),
              Tab(icon: Icon(Icons.add), text: 'Add  '),
              Tab(icon: Icon(Icons.star), text: 'Favorites'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllContacts(
            "All Contacts",
          ),
          AddPage(
            "Add",
          ),
          ContactsPage(
            "Show Favorite Contacts",
            items: [],
          ),
          SettingPage(
            'Settings',
          ),
        ],
      ),
    );
  }
}
