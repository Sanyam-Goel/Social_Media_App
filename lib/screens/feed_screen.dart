

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<int> data1 = [];
  int currentLength = 0;
  final int increment = 2;
  bool isLoading = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    if (!mounted) {
    // This check ensures that the widget is still part of the widget tree.
    return;
  }
    setState(() {
      isLoading = true;
    });

    // Dummy delay
    await Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data1.add(i);
    }
    if(mounted){
      setState(() {
      isLoading = false;
      currentLength = data1.length;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/instagram_logo.svg',
                // ignore: deprecated_member_use
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: LazyLoadScrollView(
        isLoading: isLoading,
        onEndOfPage: () => _loadMore(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: data1.length,
              itemBuilder: (ctx, index) {
                if (index < snapshot.data!.docs.length) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width > webScreenSize ? width * 0.3 : 0,
                      vertical: width > webScreenSize ? 15 : 0,
                    ),
                    child: PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                } else {
                  // Handle the case where index is out of range
                  return Container(); // or some other appropriate widget
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../utils/colors.dart';
// import '../utils/global_variables.dart';
// import '../widgets/post_card.dart';

// class FeedScreen extends StatefulWidget {
//   const FeedScreen({Key? key}) : super(key: key);

//   @override
//   State<FeedScreen> createState() => _FeedScreenState();
// }

// class _FeedScreenState extends State<FeedScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor:
//           width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
//       appBar: width > webScreenSize
//           ? null
//           : AppBar(
//               backgroundColor: mobileBackgroundColor,
//               centerTitle: false,
//               title: SvgPicture.asset(
//                 'assets/instagram_logo.svg',
//                 // ignore: deprecated_member_use
//                 color: primaryColor,
//                 height: 32,
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.messenger_outline,
//                     color: primaryColor,
//                   ),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (ctx, index) => Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: width > webScreenSize ? width * 0.3 : 0,
//                 vertical: width > webScreenSize ? 15 : 0,
//               ),
//               child: PostCard(
//                 snap: snapshot.data!.docs[index].data(),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//}
