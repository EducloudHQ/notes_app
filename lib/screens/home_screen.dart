import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_ai/repositories/profile_repository.dart';
import 'package:notes_ai/screens/notes_item.dart';
import 'package:notes_ai/utils/bottom_menus.dart';
import '../repositories/note_respository.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'create_note_screen.dart';
import 'menu_list_view.dart';
import 'package:provider/provider.dart';

import 'model/notes.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.userId,required this.email});
  final String userId;
  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

 late final Stream<GraphQLResponse<String>> operation;
 late final Stream<GraphQLResponse<String>> createNoteStream;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

NoteRepository notesRepo = context.read<NoteRepository>();
    subscribeToNewNotes(notesRepo);
    notesRepo.getAllNotes(widget.userId);
    super.initState();
  }

  Future<void> subscribeToNewNotes(NoteRepository notesRepo) async {

    //  sendMessageStream;
    const graphQLDocument = '''
subscription onCreateNote {
  createdNote {
    createdOn
    id
    note
    status
    title
    username
  }
}

    ''';

    Stream<GraphQLResponse<String>>  createNoteStream = Amplify.API.subscribe(
      GraphQLRequest<String>(
        document: graphQLDocument,
        apiName: "NotesAIAPI",
      ),
      onEstablished: () => print('Subscription established'),
    );

    try {
      await for (var event in createNoteStream) {

        print("event data is ${event.data}");

        var incomingNote = json.decode(event.data!);

        Note noteItemModel =  Note.fromJson(incomingNote['createdNote']);



        if (kDebugMode) {
          print("event message data is ${noteItemModel.note}");
        }
        if (notesRepo.noteList.isNotEmpty) {
          if (notesRepo.noteList[0].id! != noteItemModel.id) {

            notesRepo.noteItem =  noteItemModel;


          }
        } else {
          notesRepo.noteItem = noteItemModel;

        }
        if (kDebugMode) {
          //  print("all list messages are $chatMessagesList");
          print('Subscription event data received: ${event.data}');
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error in subscription stream: $e');
      }
    }
  }


  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {

    NoteRepository noteRepository = context.watch<NoteRepository>();
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: Color(0xFF131313),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity1,
                 child:
                 Container(
                   padding: EdgeInsets.symmetric(vertical: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           ClipRRect(
                               borderRadius:
                               BorderRadius.circular(100),
                               child:Image.asset('assets/rosius.jpg',fit: BoxFit.cover,
                                 height: 30,width: 30,)
                           ),
                           Container(
                             padding: EdgeInsets.only(left: 5),
                             child: Row(
                               children: [
                                 Text("morning,",style: TextStyle(color:
                                 Color(0xFFf5f5f5).withOpacity(0.6)),),
                                 const Text("Rosius",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                               ],
                             ),
                           )
                         ],
                       ),
                       IconButton(onPressed: ()=> BottomMenus.showMainMenu(context,widget.userId,widget.email)
                           , icon: const Icon(Icons.add,color: Colors.white,))
                     ],
                   ),
                 )),
                      const Divider(color: Colors.white,),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity2,
                      child:
                      const Text("your",style: TextStyle(fontSize: 50,color: Colors.white,fontFamily: 'Ultra-Regular'),),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: const Text("notes",style: TextStyle(fontSize: 50,color: Colors.white,fontFamily: 'Ultra-Regular'),)),),


                     MenuListView(
                         callBack: (){
                           Navigator.of(context).pop();
                           Navigator.push<dynamic>(
                             context,
                             MaterialPageRoute<dynamic>(
                               builder: (BuildContext context) =>
                               MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(create: (BuildContext context)=> ProfileRepository.instance()),
                                  ChangeNotifierProvider(create: (BuildContext context)=> NoteRepository.instance()),

                                ],
                                 child:CreateNoteScreen(email:widget.email,userId:widget.userId ,)
                               ),
                             ),
                           );
                         },

                     )
                    ],
                  )
                ),
              ),
            ),

          ),

               SliverList(delegate: SliverChildBuilderDelegate((BuildContext context,int index){

                return NotesItem(note: noteRepository.noteList[index], index: index, closedChild: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Colors.white,thickness: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text("$index/",style: TextStyle(fontSize: 15,color: Colors.white),)),
                          Expanded(

                              child: Column(
                                children: [
                                  Text(noteRepository.noteList[index].title!,style: TextStyle(color: Colors.white,fontSize: 25),),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(noteRepository.noteList[index].note!,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white.withOpacity(0.4)),),
                                  ),

                                ],
                              )),
                          IconButton(onPressed: (){}, icon: Icon(Icons.double_arrow_sharp,color: Colors.white,))
                        ],
                      ),


                    ],
                  ),
                ),);
              },
    childCount: noteRepository.noteList.length))



        ],
      ),
    );
  }
}
