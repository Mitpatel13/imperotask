import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:impero_task/screen/searchscreen/search_ctrl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key,});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchPageController controller =Get.put(SearchPageController());


  @override
  void initState() {
    super.initState();
    controller.scrollController.addListener(controller.scrollListener);
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar:
      AppBar(foregroundColor: Colors.deepPurple,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border:Border.all(color: Colors.grey)),
            child: Icon(Icons.search),
          )
        ],
        title:Text('My Team',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border:Border.all(color: Colors.grey)),
            child: Icon(Icons.menu),
          )),
      body:
      Column(
        children: [
          TextField(
            controller: controller.searchController,
            onChanged: (value) {
              if (controller.searchController.text.isEmpty) {
                controller.userList.clear();
                controller.page.value=1;
              }
              controller.searchController.text = value;
              controller.searchUsers();
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    final userName = user['name'];
                    final spaceIndex = userName.indexOf(' ');
                    final firstLetter = userName[0];
                    final secondLetter = spaceIndex != -1 && spaceIndex + 1 < userName.length ? userName[spaceIndex + 1] : '';
                    return Card(
                      key: UniqueKey(),
                      child: ListTile(
                        leading: CircleAvatar
                          (backgroundColor: Colors.deepPurpleAccent,child:
                        Text(
                          '${firstLetter}${secondLetter}', // Extracting first letters
                          style: TextStyle(fontSize: 20),
                        ),),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: user['present'] == 'no' ? Colors.red.shade200 :Colors.greenAccent.shade200 ),
                              child:
                              user['present'] == 'no' ?
                              Text('Absent')
                                  :Text('Present') ,
                            ),
                          ],
                        ),

                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('Visit',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(user['total_visits_count'].toString())
                        ],),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      )

    );
  }
}
