import 'dart:convert';
import 'dart:io';


import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../screens/model/notes.dart';



class NoteRepository extends ChangeNotifier{

  NoteRepository.instance();

  bool _loading = false;

  bool _loadingSuggestions = false;

  String _documentResponse = '';

  String? _noteId;


  String get documentResponse => _documentResponse;


  String? get noteId => _noteId;

  set noteId(String? value) {
    _noteId = value;
    notifyListeners();
  }

  set documentResponse(String value) {
    _documentResponse = value;
    notifyListeners();
  }



  List<Note> _noteList = [];

  List<Note> get noteList => _noteList;

  set noteList(List<Note> value) {
    _noteList = value;
    notifyListeners();
  }

  set noteItem(Note value) {

    noteList.insert(0, value);
    notifyListeners();
  }

  bool get loadingSuggestions => _loadingSuggestions;

  set loadingSuggestions(bool value) {
    _loadingSuggestions = value;
    notifyListeners();
  }

  bool get loading => _loading;



  final List<TextEditingController> _controllers = [];
   final TextEditingController _controller = TextEditingController();
  final List<TextField> _fields = [];
final TextField _field = TextField();


  List<TextField> get fields => _fields;


  TextEditingController get controller => _controller;

  set controller(TextEditingController value) {
    _controllers.add(value);
    notifyListeners();
  }
  TextField get field => _field;

  set field(TextField value) {
    _fields.add(_field);
    notifyListeners();

  }


  List<TextEditingController> get controllers => _controllers;

  set controllers(List<TextEditingController> value) {
    _controllers.addAll(value);
    notifyListeners();
  }




  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final questionController = TextEditingController();


  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle( fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }

  Future<String> queryDocument(String input) async{
    loadingSuggestions = true;
    String graphQLDocument =
    '''query queryDocument(\$input: String!) {
  queryDocument(input: \$input) {
   result
  }
}
''';

    var operation = Amplify.API.query(


        request: GraphQLRequest<String>(document: graphQLDocument, apiName: "NotesAIAPI",
          variables: {
            "input": input

          },));



    var response = await operation.response;

    final responseJson = json.decode(response.data!);
    if (kDebugMode) {
      print("here${responseJson['queryDocument']['result']}");
    }
    loadingSuggestions = false;
    documentResponse = responseJson['queryDocument']['result'];
    return responseJson['queryDocument']['result'];

  }
  Future<String> enhanceNote(String input) async{
    String assistant ="You are an exceptional French translator. You'll return the french translation of all texts";
    String prompt = "Human:$input "
        "  Assistant:$assistant";
    loadingSuggestions = true;
    String graphQLDocument =
    '''query enhanceNote(\$input: String!) {
  enhanceNote(input: \$input) {
   result
  }
}
''';

    var operation = Amplify.API.query(


        request: GraphQLRequest<String>(document: graphQLDocument, apiName: "NotesAIAPI",
          variables: {
            "input":prompt

          },));



    var response = await operation.response;

    final responseJson = json.decode(response.data!);
    if (kDebugMode) {
      print("here${responseJson['enhanceNote']['result']}");
    }
    loadingSuggestions = false;
    documentResponse = responseJson['enhanceNote']['result'];
    return responseJson['enhanceNote']['result'];

  }

  Future<String?> createNote(String title,String note,bool status,String username) async {
    try {
      String graphQLDocument =
      '''mutation createNote(\$title:String!,\$note:String!,\$status:Boolean!,\$username:String!) {
  createNote(notesInput: {title:\$title,note:\$note,status:\$status,username:\$username}) {
    createdOn
    id
    note
    title
    status
    username
  }
}
''';

      var operation = Amplify.API.mutate(


          request: GraphQLRequest<String>(
            document: graphQLDocument, apiName: "NotesAIAPI",
            variables: {
              "note": note,
              "title":title,
              "status": status,
              "username": username
            },));


      var response = await operation.response;
      if(response.data != null){
        final responseJson = json.decode(response.data!);
        if (kDebugMode) {
          print("here${responseJson['createNote']}");
        }
        loading = false;


        noteId = responseJson['createNote']['id'];

        print("note id ${noteId}");
        return responseJson['createNote'];
      }else{
        print("something happened");
        return null;
      }


    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      loading = false;
      return null;
    }
  }

  Future<void> updateNote(String id,String title,String note,bool status,String username) async {

    try {
      String graphQLDocument =
      '''mutation updateNote(\$id:String!,\$title:String!,\$note:String!,\$status:Boolean!,\$username:String!) {
  updateNote(notesInput: {id:\$id,title:\$title,note:\$note,status:\$status,username:\$username}) {
    createdOn
    id
    note
    title
    status
    updatedOn
    username
  }
}
''';

      var operation = Amplify.API.mutate(


          request: GraphQLRequest<String>(
            document: graphQLDocument, apiName: "NotesAIAPI",
            variables: {
              "id":id,
              "note": note,
              "title":title,
              "status": status,
              "username": username
            },));


      var response = await operation.response;
      if(response.data != null) {
        final responseJson = json.decode(response.data!);
        if (kDebugMode) {
          print("here${responseJson['updateNote']}");
        }
        loading = false;

        return responseJson['updateNote'];
      }else{
        print("something went wrong while updating note");
        return;

      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      loading = false;
      return;
    }
  }

  Future<void> getAllNotes(String userId) async{

    String graphQLDocument = '''query getAllNotes(\$userId:String!) {
  getAllNotes(userId: \$userId) {
    createdOn
    id
    note
    status
    title
    username
  }
}
''';


    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
          apiName: "NotesAIAPI",
          variables: {
            "userId": userId

          },
        ));

    var response = await operation.response;

    final responseJson = json.decode(response.data!);
    if (kDebugMode) {
      print("here$responseJson");
    }

    Notes notesList = Notes.fromJson(responseJson);
    noteList = notesList.listNotes!;


   // return Notes.fromJson(responseJson);
  }



  Future<void> addText() async {
    descriptionController.text = documentResponse;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (final controller in _controllers) {
      controller.dispose();
    }
    titleController.dispose();
    descriptionController.dispose();
    questionController.dispose();
    super.dispose();


  }


}