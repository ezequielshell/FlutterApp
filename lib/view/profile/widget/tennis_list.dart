import 'package:flutter/material.dart';
import 'package:sneakers_app/view/profile/widget/tennis_page.dart';

class TennisListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Tennis>>(
      valueListenable: TennisRepository.tennisListNotifier,
      builder: (context, tennisList, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TennisPage(),
                  ),
                );
              },
            ),
            title: const Text("Lista de Tênis"),
          ),
          body: ListView.builder(
            itemCount: tennisList.length,
            itemBuilder: (context, index) {
              Tennis tennis = tennisList[index];
              return ListTile(
                title: Text(tennis.name),
                subtitle: Text("${tennis.brand} - ${tennis.color}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TennisPage(tennis: tennis),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    tennisList.removeAt(index);
                    TennisRepository.tennisListNotifier.value =
                        List.from(tennisList);
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TennisPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
