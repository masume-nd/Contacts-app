import 'package:url_launcher/url_launcher.dart';

import 'contact.dart';

// TODO: read from DataBase
List<contact> contacts = [
  contact(name: "ali", numbers: {"home": "051", "work": "051", "mob": "0915"}),
  contact(name: "reza", numbers: {"home": "071", "work": "081", "mob": "0917"}),
  contact(name: "sara", numbers: {"home": "021", "work": "021", "mob": "0912"}),
  contact(name: "zah", numbers: {"home": "051", "work": "051", "mob": "0915"}),
  contact(name: "omid", numbers: {"home": "011", "work": "011", "mob": "0911"}),
];

List<contact> favcontacts = [];

void makePhoneCall(String phoneNumber) async {
  try {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    print(telUri);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  } catch (e) {
    print('Error launching phone call: $e');
  }
}

void sendEmail(String email, {String subject = '', String body = ''}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query:
        'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}

void sendSMS(String phoneNumber, String message) async {
  final Uri smsUri =
      Uri(scheme: 'sms', path: phoneNumber, queryParameters: {'body': message});
  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    throw 'Could not launch $smsUri';
  }
}
