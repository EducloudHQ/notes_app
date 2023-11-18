import 'package:flutter/material.dart';
import 'package:notes_ai/repositories/profile_repository.dart';
import 'package:notes_ai/screens/popup_menu_items.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

import '../repositories/note_respository.dart';

class BedrockButton extends StatelessWidget {
  const BedrockButton({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
      onTap: (){
        showPopover(
          context: context,
          bodyBuilder: (context) =>  MultiProvider(providers: [
              ChangeNotifierProvider(create:(_)=>ProfileRepository.instance()),
              ChangeNotifierProvider(create:(_)=>NoteRepository.instance())
          ],child:  PopUpMenuItems(userId:userId),),


          backgroundColor: Colors.black,
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.left,
          width: 250,
          height: 180,

          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: Container(

        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,

          gradient: LinearGradient(
            begin: Alignment(0.0, 0.5),
            end: Alignment(0.0, 0.0),
            colors: <Color>[
              Color(0xFFd62976),
              Color(0xFF962fbf),
            ],
          ),
        ),
        child: Image.asset('assets/bedrock.png',height: 40,width: 40,color: Colors.white,),
      ),

    );
  }
}