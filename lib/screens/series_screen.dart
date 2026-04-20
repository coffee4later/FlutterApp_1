import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api_catholic.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  ApiCatholic? apiCatholic;

  @override
  void initState() {
    super.initState();
    apiCatholic = ApiCatholic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Series"),
      ),
      body: FutureBuilder(
        future: apiCatholic!.getAllCategories(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Center(child: Text("Error al cargar las series"));
          }

          final series = snapshot.data!;

          return ListView.builder(
            itemCount: series.length,
            itemBuilder: (context, index) {
              final category = series[index];
              return ExpansionTile(
                title: Text("Categoría ${index + 1}"),
                children: category.map((series) => ListTile(
                  title: Text(series.title),
                )).toList(),
              );
        }
      )
    );
  }
}


