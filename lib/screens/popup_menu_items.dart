import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_ai/repositories/profile_repository.dart';
import 'package:notes_ai/utils/bottom_menus.dart';
import 'package:provider/provider.dart';

import '../repositories/note_respository.dart';
class PopUpMenuItems extends StatelessWidget {
  const PopUpMenuItems({super.key, required this.userId});
  final String userId;


  @override
  Widget build(BuildContext context) {
    ProfileRepository profileRepository = context.watch<ProfileRepository>();
    NoteRepository noteRepository = context.watch<NoteRepository>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              profileRepository.uploadFileToS3(userId);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1.0, color: Colors.white.withOpacity(0.4))

              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/upload.svg', height: 20,
                    width: 20,
                    color: Color(0xFF962fbf),),
                  Container(
                    padding: const EdgeInsets.only(left: 10),

                    child: const Text(
                      'upload document', style: TextStyle(color: Colors
                        .white),),

                  )
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              BottomMenus.showResult(context,"query");





            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1.0, color: Colors.white.withOpacity(0.4))

              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/suggestions.svg', height: 20,
                    width: 20,
                    color: Color(0xFF962fbf),),
                  Container(
                    padding: const EdgeInsets.only(left: 10),

                    child: noteRepository.loadingSuggestions?

                    const Text(
                      'Generating.....', style: TextStyle(color: Colors
                        .white),) :
                    const Text(
                      'Generate questions', style: TextStyle(color: Colors
                        .white),),

                  )
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: ()=> BottomMenus.showResult(context,"translate"),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 1.0, color: Colors.white.withOpacity(0.4))

              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/translate.svg', height: 20,
                    width: 20,
                    color: Color(0xFFd62976),),
                  Container(
                    padding: const EdgeInsets.only(left: 10),

                    child: const Text(
                      'translate to french', style: TextStyle(color: Colors
                        .white),),

                  )
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}