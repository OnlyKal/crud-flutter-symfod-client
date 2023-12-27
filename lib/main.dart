import 'package:flutter/material.dart';
import './form.dart';
import 'expo.dart';

void main() {
   getClients();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Formulaire(),
  ));
}


