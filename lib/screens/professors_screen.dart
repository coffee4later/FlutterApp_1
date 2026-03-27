import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/profesores.dart';
import 'package:intl/intl.dart';

class ProfessorsScreen extends StatefulWidget {
  const ProfessorsScreen({super.key});

  @override
  State<ProfessorsScreen> createState() => _ProfessorsScreenState();
}

class _ProfessorsScreenState extends State<ProfessorsScreen> {
  ProfesorDAO profesorDAO = ProfesorDAO();

  final space = SizedBox(height: 5);
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing:25.0,
          children: [
            const Text('Profesores'),
            IconButton(onPressed: showAlert, icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: profesorDAO.getProfesores(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No hay profesores registrados.'));
          }

          return GridView.builder(
            itemCount: docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final doc = docs[index].data();
              final nombre =
                  (doc['nombre'] as String?) ?? 'Nombre no disponible';
              final edad = (doc['edad']?.toString()) ?? 'Edad no disponible';
              final id = docs[index].id;

              return Container(
                padding: EdgeInsets.all(15),
                color: Color.fromARGB(255, 245, 245, 245),
                margin: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(doc['foto']),
                    ),
                    ListTile(title: Text(nombre), subtitle: Text(edad)),
                    Row(
                      // mainAxisAlignment:  ,
                      children: [
                        IconButton(
                          onPressed: () => showAlert(id: id),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            final alert = AlertDialog(
                              title: Text(
                                'Seguro que deseas borrar este elemento?',
                              ),
                              content: Text("Esta acción no se puede deshacer"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    profesorDAO.deleteProfesor(docs[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Eliminar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancelar"),
                                ),
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (context) => alert,
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showAlert({String? id}) {
    var alertDialog = AlertDialog(
      title: Text("Add actor"),
      content: Container(
        height: 280,
        width: 200,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            space,
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            space,
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            space,
            ElevatedButton(
              onPressed: () {
                var data = {
                  "nombre": nameController.text,
                  "apellido": lastNameController.text,
                  "edad": ageController.text,
                  "foto": "",
                };
                if (id == null) {
                  profesorDAO!.insertProfesor(data).then((value) {
                    if (value > 0) {
                      print("Actor added successfully");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Actor added successfully")),
                      );
                    } else {
                      print("Failed to add actor");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add actor")),
                      );
                    }
                    Navigator.pop(context);
                  });
                } else {
                  data["id"] = id.toString();
                  profesorDAO!.updateProfesor(id.toString(), data).then((
                    value,
                  ) {
                    if (value > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Actor updated successfully")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update actor")),
                      );
                    }
                  });
                }
              },
              child: Text("Add actor"),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }
}
