import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../repositories/note_respository.dart';
import '../repositories/profile_repository.dart';
import '../screens/create_note_screen.dart';
import 'menu_item.dart';
import 'package:provider/provider.dart';

class BottomMenus {
  static Future<void> showResult(BuildContext context,String type) {
    return showModalBottomSheet<void>(
        backgroundColor: Colors.white,
       // isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider.value(
              value: NoteRepository.instance(),
              child:
                  Consumer(builder: (_, NoteRepository noteRepository, child) {
                return

                         Container(
                           height: 250,
                           child: SingleChildScrollView(
                              child:  Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Column(
                                      children: [
                                        Container(
                                          color: Colors.black,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: TextFormField(
                                                  controller: noteRepository.questionController,
                                                  style: TextStyle(fontSize: 17,color: Colors.white),
                                                  maxLines: 2,
                                                  decoration: const InputDecoration(
                                                    filled: true,
                                                      fillColor: Colors.black,
                                                      border: InputBorder.none,
                                                      hintText: 'ask a question',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey, fontSize: 20)),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Color(0xFFd62976),
                                                        Color(0xFF962fbf),
                                                        // Color(0XFFfee140)
                                                      ],
                                                    ),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: noteRepository.loadingSuggestions ? const CircularProgressIndicator(
                                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd62976))
                                                  ) : noteRepository.documentResponse.isNotEmpty ?  IconButton(
                                                      icon: Icon(Icons.copy),
                                                      onPressed: () async{
                                                        Navigator.of(context).pop();
                                                        await Clipboard.setData(ClipboardData(text: noteRepository.documentResponse));
                                                      }

                                                  ): IconButton(
                                                      icon: Icon(Icons.arrow_forward),
                                                      onPressed: () =>
                           type =="query"? noteRepository.queryDocument(noteRepository.questionController.text) :
                           noteRepository.enhanceNote(noteRepository.questionController.text)
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        noteRepository.documentResponse.isNotEmpty ?  Container(

                                          padding:   const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                          child:


                                              Text(
                                                noteRepository.documentResponse,

                                                style: const TextStyle(
                                                    fontSize: 17, color: Colors.black,height: 2.5),
                                              ),

                                        ) : SizedBox()

                                      ],

                                  ),
                                 ],
                              ),
                            ),
                         );





              }));
        });
  }

  static Future<void> showMainMenu(BuildContext context,String userId,String email ){
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(create: (BuildContext context)=> ProfileRepository.instance()),
                                  ChangeNotifierProvider(create: (BuildContext context)=> NoteRepository.instance()),

                                ],
                                child:CreateNoteScreen(email:email,userId:userId ,)
                            ),
                      ),
                    );
                  },
                  child: MenuItem(
                    icon: 'assets/document.svg',
                    title: 'Create New Document',
                    subTitle: 'Write down your thoughts in a details',
                    color: Color(0xFFd62976),
                  ),
                ),
                MenuItem(
                  icon: 'assets/create_note.svg',
                  title: 'Create Quick Note',
                  subTitle: 'Quickly spell out your thoughts',
                  color: Color(0xFF962fbf),
                ),
                MenuItem(
                  icon: 'assets/folder.svg',
                  title: 'Create New Folder',
                  subTitle: 'Organize your notes',
                  color: Color(0xFFfa7e1e),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
