// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sneakers_app/view/profile/widget/tennis_list.dart';

class TennisPage extends StatefulWidget {
  final Tennis? tennis;

  TennisPage({Key? key, this.tennis}) : super(key: key);
  @override
  _TennisPageState createState() => _TennisPageState();
}

class _TennisPageState extends State<TennisPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tennis != null) {
      nameController.text = widget.tennis!.name;
      brandController.text = widget.tennis!.brand;
      colorController.text = widget.tennis!.color;
    }
  }

  //Tennis? editingTennis; // Tênis sendo editado (se houver)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.tennis == null ? "Cadastro de Tênis" : "Editar Tênis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: brandController,
              decoration: const InputDecoration(labelText: "Marca"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: colorController,
              decoration: const InputDecoration(labelText: "Cor"),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.tennis != null) {
                  // Está editando um tênis existente
                  widget.tennis!.name = nameController.text;
                  widget.tennis!.brand = brandController.text;
                  widget.tennis!.color = colorController.text;
                } else {
                  // Está adicionando um novo tênis
                  Tennis newTennis = Tennis(
                    name: nameController.text,
                    brand: brandController.text,
                    color: colorController.text,
                  );
                  TennisRepository.tennisList.add(newTennis);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TennisListPage(),
                  ),
                );
              },
              child: Text(widget.tennis == null ? "Salvar" : "Atualizar"),
            ),
          ],
        ),
      ),
    );
  }
}

class Tennis {
  String name;
  String brand;
  String color;

  Tennis({required this.name, required this.brand, required this.color});
}

class TennisRepository {
  static ValueNotifier<List<Tennis>> tennisListNotifier =
      ValueNotifier<List<Tennis>>([]);

  static List<Tennis> get tennisList => tennisListNotifier.value;
}
