import 'package:flutter/material.dart';

class InvetoryPage extends StatefulWidget {
  static const path = '/inventory-page';
  const InvetoryPage({super.key});

  @override
  State<InvetoryPage> createState() => _InvetoryPageState();
}

class _InvetoryPageState extends State<InvetoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("data"));
  }
}
