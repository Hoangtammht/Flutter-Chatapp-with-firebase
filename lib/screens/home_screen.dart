import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_2023/api/apis.dart';
import 'package:we_chat_2023/auth/profile_screen.dart';
import 'package:we_chat_2023/helper/dialogs.dart';
import 'package:we_chat_2023/main.dart';
import 'package:we_chat_2023/models/chat_user.dart';
import 'package:we_chat_2023/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSetInfo();



    SystemChannels.lifecycle.setMessageHandler((message) {
      print("Message: $message");
      if(APIs.auth.currentUser != null){
        if(message.toString().contains('pause')){
          APIs.updateActiveStatus(false);
        }
        if(message.toString().contains('resume')){
          APIs.updateActiveStatus(true);
        }
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.home),
            title: _isSearching
                ? TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Name, Email, ...',
              ),
              autofocus: true,
              style: const TextStyle(
                fontSize: 17,
                letterSpacing: 0.5,
              ),
              onChanged: (val) {
                _searchList.clear();
                for (var i in list) {
                  if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                      i.email.toLowerCase().contains(val.toLowerCase())) {
                    _searchList.add(i);
                  }
                  setState(() {
                    _searchList;
                  });
                }
              },
            )
                : Text("We Chat"),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching ? Icons.search_off : Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(user: APIs.me)));
                  },
                  icon: Icon(Icons.more_vert)),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () async {
                _addChatUserDialog();
              },
              child: Icon(Icons.add_comment_rounded),
            ),
          ),
          body: StreamBuilder(
            stream: APIs.getMyUsersId(),
            builder: (context, snapshot){
              switch (snapshot.connectionState) {
              //if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

              //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                    stream: APIs.getAllUsers(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                      }

                      final data = snapshot.data?.docs;
                      list =
                          data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

                      if (list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: _isSearching ? _searchList.length : list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatUserCard(
                                  user:
                                  _isSearching ? _searchList[index] : list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text(
                            'No Connections Found!',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                    },
                  );
              }
            },),
        ),
      ),
    );
  }

  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.only(
              left: 24, right: 24, top: 20, bottom: 10),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),

          //title
          title: Row(
            children: const [
              Icon(
                Icons.person_add,
                color: Colors.blue,
                size: 28,
              ),
              Text('  Add User')
            ],
          ),

          //content
          content: TextFormField(
            maxLines: null,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
                hintText: 'Email Id',
                prefixIcon: const Icon(Icons.email, color: Colors.blue),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),

          //actions
          actions: [
            //cancel button
            MaterialButton(
                onPressed: () {
                  //hide alert dialog
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 16))),

            //add button
            MaterialButton(
                onPressed: () async {
                  //hide alert dialog
                  Navigator.pop(context);
                  if (email.isNotEmpty) {
                    await APIs.addChatUser(email).then((value) {
                      if (!value) {
                        Dialogs.showSnackbar(
                            context, 'User does not Exists!');
                      }
                    });
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ))
          ],
        ));
  }

}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<ChatUser> list = [];
//   final List<ChatUser> _searchList = [];
//   bool _isSearching = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     APIs.getSetInfo();
//
//
//
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       print("Message: $message");
//       if(APIs.auth.currentUser != null){
//         if(message.toString().contains('pause')){
//           APIs.updateActiveStatus(false);
//         }
//         if(message.toString().contains('resume')){
//           APIs.updateActiveStatus(true);
//         }
//       }
//       return Future.value(message);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
//         onWillPop: () {
//           if (_isSearching) {
//             setState(() {
//               _isSearching = !_isSearching;
//             });
//             return Future.value(false);
//           } else {
//             return Future.value(true);
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             leading: Icon(Icons.home),
//             title: _isSearching
//                 ? TextField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Name, Email, ...',
//                     ),
//                     autofocus: true,
//                     style: const TextStyle(
//                       fontSize: 17,
//                       letterSpacing: 0.5,
//                     ),
//                     onChanged: (val) {
//                       _searchList.clear();
//                       for (var i in list) {
//                         if (i.name.toLowerCase().contains(val.toLowerCase()) ||
//                             i.email.toLowerCase().contains(val.toLowerCase())) {
//                           _searchList.add(i);
//                         }
//                         setState(() {
//                           _searchList;
//                         });
//                       }
//                     },
//                   )
//                 : Text("We Chat"),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _isSearching = !_isSearching;
//                     });
//                   },
//                   icon: Icon(_isSearching ? Icons.search_off : Icons.search)),
//               IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 ProfileScreen(user: APIs.me)));
//                   },
//                   icon: Icon(Icons.more_vert)),
//             ],
//           ),
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: FloatingActionButton(
//               onPressed: () async {
//                 await APIs.auth.signOut();
//                 await GoogleSignIn().signOut();
//               },
//               child: Icon(Icons.add_comment_rounded),
//             ),
//           ),
//           body: StreamBuilder(
//             stream: APIs.getAllUser(),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                 case ConnectionState.none:
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 case ConnectionState.active:
//                 case ConnectionState.done:
//               }
//
//               final data = snapshot.data?.docs;
//               list =
//                   data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
//
//               if (list.isNotEmpty) {
//                 return ListView.builder(
//                     itemCount: _isSearching ? _searchList.length : list.length,
//                     padding: EdgeInsets.only(top: mq.height * .01),
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ChatUserCard(
//                           user:
//                               _isSearching ? _searchList[index] : list[index]);
//                     });
//               } else {
//                 return const Center(
//                   child: Text(
//                     'No Connections Found!',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


