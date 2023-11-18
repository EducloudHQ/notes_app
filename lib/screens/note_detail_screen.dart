import 'package:flutter/material.dart';

import 'model/notes.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key,required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
   String formattedNote =  note.note!.replaceAll("\n\n", " ");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            expandedHeight: 70.0,
            floating: true,
            pinned: true,
            snap: false,


            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: false,
              title: Text(note.title!,style: TextStyle(color: Colors.white,fontSize: 14)),


            ),

          ),
          SliverToBoxAdapter(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                  //  Text(note.title!,style: TextStyle(color: Colors.white,fontSize: 25),),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(note.note!,


                        style: TextStyle(color: Colors.white,fontSize: 15,height: 2.0),),
                    ),

                  ],
                )
            ),
          )
        ],

      ));
  }
}
