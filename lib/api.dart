import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

double fullHeight(context) {
  return MediaQuery.of(context).size.height;
}

double fullWidth(context) {
  return MediaQuery.of(context).size.width;
}

double topHeight(context) {
  return MediaQuery.of(context).padding.top;
}

void goTo(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

var server = "http://192.168.0.102:8000";

Future getClients() async {
  var response = await http.get(Uri.parse("$server/api/client/get"));
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}

Future getClientsBy(id) async {
  var response = await http.get(Uri.parse("$server/api/client/getby/$id"));
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}

Future deleteClients(id) async {
  var response = await http.delete(Uri.parse("$server/api/client/delete/$id"));
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}

Future addClient() async {
  var rng = Random();
  var response = await http.post(Uri.parse("$server/api/client/add"), body: {
    "name": "ETUDIANT ${rng.nextInt(100)}",
    "email": "enai@gmai.com",
    "phone": "09827355237732",
  });
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}

Future updateClient(id, name, email, phone) async {
  var rng = Random();
  var response =
      await http.post(Uri.parse("$server/api/client/update/$id"), body: {
    "name": name,
    "email": email,
    "phone": phone,
  });
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}
