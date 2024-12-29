import 'package:flutter/material.dart';
import 'package:flutter_application_sample/utils/contact.dart';
import 'package:flutter_application_sample/utils/index.dart';

class ContactsProvider with ChangeNotifier {
  List<contact> allcontacts = contacts;
  List<contact> favcontacts = [];

  ContactsProvider() {}

  void addToList(contact newContact) {
    allcontacts.add(newContact);
    notifyListeners();
  }

  void removeFromList(contact newContact) {
    allcontacts.remove(newContact);

    notifyListeners();
  }

  void removeFromFav(contact newContact) {
    favcontacts.remove(newContact);
    notifyListeners();
  }

  void addToFav(contact newContact) {
    favcontacts.add(newContact);
    newContact.isfav = true;
    notifyListeners();
  }
}
