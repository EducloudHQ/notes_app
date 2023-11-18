import 'package:flutter/material.dart';
import 'package:notes_ai/screens/model/notes.dart';
import 'package:animations/animations.dart';
import 'package:notes_ai/screens/note_detail_screen.dart';
class NotesItem extends StatelessWidget {
  const NotesItem({super.key,required this.note,required this.index,   required this.closedChild,});
  final Note note;
  final int index;
  final Widget closedChild;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        openBuilder: (context, closedContainer) {
      return NoteDetailScreen(note: note,);
    },
    openColor:Color(0xFF131313),
    closedShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0)),
    ),
    closedElevation: 0,
    closedColor: Color(0xFF131313),
    closedBuilder: (context, openContainer) {
return InkWell(
  onTap: (){
    openContainer();
  },
  child: closedChild,
);
    });


  }
}
