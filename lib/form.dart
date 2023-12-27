import 'package:flutter/material.dart';
import './expo.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({super.key});
  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  late Future getClientv;

  @override
  void initState() {
    setState(() {
      getClientv = getClients();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CLIENTS",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SizedBox(
        height: fullHeight(context),
        width: fullWidth(context),
        child: FutureBuilder(
            future: getClientv,
            builder: (context, AsyncSnapshot client) {
              if (client.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (client.connectionState == ConnectionState.done) {
                if (client.hasData) {
                  List listClient = client.data;

                  return ListView.builder(
                      itemCount: listClient.length,
                      itemBuilder: ((context, index) {
                        if (listClient.isNotEmpty) {
                          return GestureDetector(
                            onTap: () => goTo(
                                context,
                                Details(
                                  client: listClient[index],
                                )),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 4, bottom: 4),
                              padding: const EdgeInsets.all(15),
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listClient[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        listClient[index]['email'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        deleteClients(listClient[index]['id'])
                                            .then((clientrespose) {
                                          print(clientrespose.toString());
                                          setState(() {
                                            getClientv = getClients();
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red))
                                ],
                              ),
                            ),
                          );
                        }
                      }));
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          addClient().then((client) {
            setState(() {
              getClientv = getClients();
            });
          });
        },
      ),
    );
  }
}
