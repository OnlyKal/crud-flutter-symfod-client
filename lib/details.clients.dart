import 'package:flutter/material.dart';

import 'expo.dart';

class Details extends StatefulWidget {
  final client;
  const Details({super.key, this.client});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Future getClientv;

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  initialisation() {
    setState(() {
      getClientv = getClientsBy(widget.client['id']);
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                nameController.text = widget.client['name'];
                emailController.text = widget.client['email'];
                phoneController.text = widget.client['phone'];
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("AlertDialog"),
                    content: Container(
                        height: 300,
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration:
                                  const InputDecoration(label: Text("Name")),
                            ),
                            TextField(
                              controller: emailController,
                              decoration:
                                  const InputDecoration(label: Text("email")),
                            ),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("phone")),
                              controller: phoneController,
                            )
                          ],
                        )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Annuler")),
                      TextButton(
                          onPressed: () {
                            updateClient(
                                    widget.client['id'],
                                    nameController.text,
                                    emailController.text,
                                    phoneController.text)
                                .then((value) {
                              setState(() {
                                getClientv = getClientsBy(widget.client['id']);
                              });
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text("Update")),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: FutureBuilder(
          future: getClientv,
          builder: (context, AsyncSnapshot client) {
            if (client.hasData) {
              return ListView(
                children: [
                  Text(client.data['name']),
                  Text(client.data['email']),
                  Text(client.data['phone'])
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
