import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/data/model/sesion.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/ui/pages/add_sesion_page.dart';

class SesionWidget extends StatelessWidget {
  SesionWidget({Key? key}) : super(key: key);
  final FirestoreController firebaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => ListView.builder(
              itemCount: firebaseController.sesions.length,
              padding: EdgeInsets.only(top: 20.0),
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, firebaseController.sesions[index]);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          key: const ValueKey("addSesionAction"),
          child: const Icon(Icons.add),
          onPressed: () {
            if (firebaseController.groupIds().isNotEmpty) {
              //Get.to(AddSesionPage());
              Get.to(() => const AddSesionPage());
            } else {
              Get.snackbar("Aun no has creado ningun grupo",
                  "Crea un grupo para continuar...");
            }
          },
        ));
  }

  Widget _buildItem(BuildContext context, Sesion sesion) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        key: const ValueKey("sesionCard"),
        elevation: 2,
        child: ListTile(
          leading: Icon(
            Icons.access_time_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            sesion.groupId.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            sesion.date.toDate().toString(),
            textAlign: TextAlign.center,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(sesion.student1.toString()),
              Text(sesion.student2.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
