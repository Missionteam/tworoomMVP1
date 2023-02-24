import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/pages/reply_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/post.dart';
import '../../models/room.dart';

class PostWidget extends ConsumerWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> updatePost(String text) async {
      post.reference.update({'stamps': text});
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              post.posterImageUrl,
              //'https://d.kuku.lu/cce856f22'
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'まさと',
                      // post.posterName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Color.fromARGB(199, 213, 212, 212)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('MM/dd HH:mm').format(post.createdAt.toDate()),
                      style: const TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(127, 126, 126, 126)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 330,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () => updatePost('🤗'),
                                              child: Text('🤗',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  updatePost('🙆‍♂️'),
                                              child: Text('🙆‍♂️',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () => updatePost('🥺'),
                                              child: Text('🥺',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () => updatePost('❤️'),
                                              child: Text('❤️',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () => updatePost('🤔'),
                                              child: Text('🤔',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () => null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'メッセージを編集する',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '未読にする',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '後でリマインドする',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => null,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'ブックマークに登録する',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        ReplyPage(
                                                            post: post))));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'スレッドで返信する',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        post.text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(227, 200, 200, 200),
                          height: 1,
                        ),
                      ),
                    ),

                    // if (FirebaseAuth.instance.currentUser!.uid == post.posterId)
                    //   IconButton(
                    //       onPressed: () {
                    //         post.reference.delete();
                    //       },
                    //       icon: const Icon(Icons.delete)),
                  ],
                ),
                SizedBox(
                  height: (post.stamps == '') ? 0 : 30,
                  child: ElevatedButton(
                    onPressed: (() => null),
                    child: Text(post.stamps ?? ''),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Color.fromARGB(61, 94, 94, 94),
                      shadowColor: Color.fromARGB(255, 194, 194, 194),
                      elevation: 0,
                      padding: EdgeInsets.all(0),
                      // maximumSize: Size(0.1, 0.1)
                      // (post.stamps == null) ? Size(0, 0) : Size(40, 40),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoomWidget extends StatelessWidget {
  const RoomWidget({
    Key? key,
    required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        room.roomname,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
  // if (FirebaseAuth.instance.currentUser!.uid == post.posterId)
  //   IconButton(
  //       onPressed: () {
  //         post.reference.delete();
  //       },
  //       icon: const Icon(Icons.delete)),

}
