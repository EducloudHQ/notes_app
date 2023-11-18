

import 'package:flutter/material.dart';
import 'package:notes_ai/repositories/profile_repository.dart';
import 'package:notes_ai/screens/bedrock_button.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:popover/popover.dart';
import '../repositories/note_respository.dart';

class CreateNoteScreen extends StatefulWidget {
  CreateNoteScreen({required this.email, required this.userId});
  final String email;
  final String userId;
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  List<TextEditingController> controller = [];
  Timer? _debounce;
  Widget _listView(NoteRepository noteRepository) {
    return  ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: noteRepository.fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: noteRepository.fields[index],
        );
      },
    );

  }



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();


  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProfileRepository profileRepository = context.watch<ProfileRepository>();
    NoteRepository noteRepository = context.watch<NoteRepository>();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor:  Color(0xFFF5F5F5),
        body:CustomScrollView(
          slivers: [
            SliverAppBar(

              expandedHeight: 70.0,
              floating: true,
              pinned: true,
              snap: false,
              leading: Container(),

              backgroundColor: Color(0xFFF5F5F5),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,


                background: SafeArea(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child:  Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.of(context).pop();
                              },icon: Icon(Icons.arrow_back),),


                               profileRepository.loading?  const SizedBox(
                                   height: 20,
                                   width: 20,
                                   child: CircularProgressIndicator(

                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
                                 ) :
                                 TextButton(onPressed: (){}, child: const Text("delete",
                                   style: TextStyle(color: Colors.black),)),



                            ],
                          ),

                          const Divider(color: Colors.black,),


                        ],
                      )
                  ),
                ),
              ),

            ),
            SliverToBoxAdapter(
              child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child:Column(
                      children: [
                        Container(


                          child: TextFormField(

                            controller: noteRepository.titleController,
                            style: TextStyle(fontSize: 30),
                            maxLines: 2,

                            decoration:  const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Title',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),


                          ),

                        ),

                        Container(

                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(

                            controller: noteRepository.descriptionController,


                            maxLines: null,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'start writing ',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                )),

                            onChanged: (String value){
                              if(value.isEmpty)
                                {


                                }else {



                                if (_debounce?.isActive ?? false) {
                                  _debounce
                                    ?.cancel();
                                }
                                _debounce = Timer(
                                    const Duration(milliseconds: 500), () {
                                  if (noteRepository.noteId != null) {
                                    noteRepository.updateNote(noteRepository.noteId!,noteRepository.titleController.text,
                                        noteRepository.descriptionController.text, true, widget.userId);

                                  } else {


                                    noteRepository.createNote(
                                        noteRepository.titleController.text,
                                        noteRepository.descriptionController
                                            .text, true, widget.userId);


                                  }
                                });
                              }
                            },

                          ),

                        ),



                      ],
                    )







                ),
              ),
            ),



          ],
        ),
        floatingActionButton: BedrockButton(userId: widget.userId,)
    );
  }
}