import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: HomeController(),
        builder: (context) {
          return   homeCon.isProcessingAllUsers.value
          ?const Center(child: CircularProgressIndicator())
          :ListView.builder(
            itemCount: homeCon.userList.length,
            shrinkWrap:  true,
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
    );
  }
}