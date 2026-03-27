import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/cast_db.dart';
import 'package:flutter_application_1/listeners/value_listener.dart';
import 'package:intl/intl.dart';

class CastlistScreen extends StatefulWidget {
  const CastlistScreen({super.key});

  @override
  State<CastlistScreen> createState() => _CastlistScreenState();
}

class _CastlistScreenState extends State<CastlistScreen> {
  CastDb? castDb = CastDb();
  final space = SizedBox(height: 5);
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    castDb = CastDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de actores"),
        actions: [IconButton(onPressed: showAlert, icon: Icon(Icons.add))],
      ),
      body: ValueListenableBuilder(
        valueListenable: ValueListener.refreshList,
        builder: (context, value, child) {
          return FutureBuilder(
            future: castDb!.select(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        children: [
                          Expanded(child: Text(snapshot.data![index].name!)),
                          InkWell(
                            onTap: () {
                              nameController.text = snapshot.data![index].name!;
                              genderController.text =
                                  snapshot.data![index].gender!;
                              birthController.text =
                                  snapshot.data![index].birth_date!;
                              showAlert(
                                id_cast: snapshot.data![index].id_cast!,
                              );
                            },
                            child: Image.asset(
                              "assets/edit.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var alert = AlertDialog(
                                title: Text(
                                  "Are you sure you want to delete this actor?",
                                ),
                                content: Text("This action cannot be undone"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      castDb!
                                          .delete(
                                            snapshot.data![index].id_cast!,
                                          )
                                          .then((value) {
                                            if (value > 0) {
                                              ValueListener.refreshList.value =
                                                  !ValueListener
                                                      .refreshList
                                                      .value;
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Actor deleted successfully",
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Failed to delete actor",
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                    },
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alert,
                              );
                            },
                            child: Image.asset(
                              "assets/delete.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                if (snapshot.hasError) {
                  return Text("Something went wrong :(");
                } else {
                  return Center(child: CircularProgressIndicator());
                }
                // return Text("No actors found");
              }
            },
          );
        },
      ),
    );
  }

  void showAlert({int? id_cast}) {
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
              controller: genderController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            space,
            TextFormField(
              readOnly: true,
              controller: birthController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              onTap: () async {
                DateTime? birth_date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (birth_date != null) {
                  String formattedDate = DateFormat(
                    'yyyy-MM-dd',
                  ).format(birth_date);
                  setState(() {
                    birthController.text = formattedDate;
                  });
                }
              },
            ),
            space,
            ElevatedButton(
              onPressed: () {
                var data = {
                  "name": nameController.text,
                  "gender": genderController.text,
                  "birth_date": birthController.text,
                };
                if (id_cast == null) {
                  castDb!.insert(data).then((value) {
                    if (value > 0) {
                      print("Actor added successfully");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Actor added successfully")),
                      );
                      ValueListener.refreshList.value =
                          !ValueListener.refreshList.value;
                    } else {
                      print("Failed to add actor");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add actor")),
                      );
                    }
                    Navigator.pop(context);
                  });
                } else {
                  data["id_cast"] = id_cast.toString();
                  castDb!.update(data).then(
                    (value){
                      if (value>0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Actor updated successfully")),
                        );
                        ValueListener.refreshList.value = !ValueListener.refreshList.value;
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to update actor")),
                        );
                        
                      }
                    }
                  );
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
