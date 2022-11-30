import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'list.dart';

class DashboardScreen extends StatefulWidget {

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: posts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('Images/profilePictures/${index+1}.jpg'),
                      ),
                    );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, bottom: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'Images/profilePictures/${index +
                                          1}.jpg'),
                                  radius: 20,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text('${posts[index].name}', style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.3,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'Images/posts/${index + 11}.jpg'),
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined, color: Colors.black, size: 21.0,),
                                SizedBox(width: 10.0,),
                                Icon(Icons.insert_comment_rounded, color: Colors.black, size: 21.0,),
                                SizedBox(width: 10.0,),
                                Icon(Icons.share, color: Colors.black, size: 21.0,),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}