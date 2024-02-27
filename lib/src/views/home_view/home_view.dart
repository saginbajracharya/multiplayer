import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/models/user_model.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeCon = Get.put(HomeController());
  final LoginoutController loginoutCon = Get.put(LoginoutController());

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
        extendBody: false,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: (){
                loginoutCon.logout();
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
            :FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').where('isOnline', isEqualTo: true).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final onlineUsers = snapshot.data!.docs.map((doc) => User.fromFirestore(doc)).toList();

                return GridView.builder(
                  itemCount: onlineUsers.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    final user = onlineUsers[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Flexible(
                              child: Image.network(
                                'https://picsum.photos/200?random=${Random().nextInt(100)}',
                                fit: BoxFit.fill,
                              )
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: transparent.withOpacity(0.5),
                              ),
                              child: Text(user.email),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
            // GridView.builder(
            //   itemCount: homeCon.userList.length,
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.all(10.0),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 5,
            //     crossAxisSpacing: 5.0,
            //     mainAxisSpacing: 5.0,
            //   ),
            //   itemBuilder: (context, index) {
            //     final user = homeCon.userList[index];
            //     return ListTile(
            //       title: Text(user.name),
            //       subtitle: Text(user.email),
            //       tileColor: grey
            //     );
            //   },
            // );
          }
        ),
      ),
    );
  }
}