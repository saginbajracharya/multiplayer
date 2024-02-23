import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeCon = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeCon.getAllUsers();
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: (){
                Get.toNamed(LoginView.routeName);
              }, 
              icon: const Icon(Icons.logout_sharp),
            )
          ],
        ),
        body: GetBuilder(
          init: HomeController(),
          builder: (context) {
            return homeCon.isProcessingAllUsers.value
            ?const Center(child: CircularProgressIndicator())
            :ListView.builder(
              itemCount: homeCon.userList.length,
              shrinkWrap:  true,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                final user = homeCon.userList[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  tileColor: grey
                );
              },
            );
          }
        ),
      ),
    );
  }
}