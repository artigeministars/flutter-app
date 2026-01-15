import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_app2/ui/processes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/notes.dart';
import 'package:flutter_app2/photos.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardDetails extends StatefulWidget {

     const DashboardDetails({super.key});

@override
State<DashboardDetails> createState() => _DashboardDetailsState();

}

enum Menu { addPhoto, addNote, likes }

class _DashboardDetailsState extends State<DashboardDetails> with ListContainer, Dialogs, CheckUser {
  
  int _selectedIndex = 0;
  bool userStat = true;
  
  @override
  Widget build(BuildContext context) {
  
  AnimationStyle? animationStyle = const AnimationStyle(
                            curve: Easing.emphasizedDecelerate,
                            duration: Duration(seconds: 3),
                          );

    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            minExtendedWidth: 3,
            backgroundColor: Colors.lightBlue.shade100,
            indicatorColor: Colors.cyan.shade200,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _selectedIndex = index;
                if(_selectedIndex == 0) {
                  if (context != null && context.mounted) {
                    prefs.setString('user_id','0');
                    context.go('/'); 
                    
                  }
                } 
              });
              userStat = await checkUser();
              if(!userStat) {
                if (context != null && context.mounted) {
                  prefs.setString('user_id','0');
                context.go("/");
                }
              }
            },
            labelType: NavigationRailLabelType.selected,
            leading: PopupMenuButton<Menu>(
                  popUpAnimationStyle: animationStyle,
                  icon: const Icon(Icons.add_box_rounded),
                  onSelected: (Menu item) {
                    
                    if( item == Menu.addPhoto ) {
                      _addPhotoDialogBuilder(context);
                    } else if(item == Menu.addNote ) {
                      _addNoteDialogBuilder(context);
                    } else if(item == Menu.likes) {
                      _addLikesDialogBuilder(context);
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    const PopupMenuItem<Menu>(
                      value: Menu.addPhoto,
                      child: ListTile(
                        leading: Icon(Icons.add_a_photo_rounded),
                        title: Text('Add Photo'),
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<Menu>(
                      value: Menu.addNote,
                      child: ListTile(leading: Icon(Icons.note_add_rounded), title: Text('Add Note')),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<Menu>(
                      value: Menu.likes,
                      child: ListTile(leading: Icon(Icons.star_border_outlined), title: Text('Likes')),
                    ),
                  ],
                ),
            destinations: [
              /*
              NavigationRailDestination(
                icon: Icon(Icons.add_box_outlined),
                selectedIcon: Icon(Icons.add_box_rounded),
                label: Text('Add'),  // popup çıkacak photo ve note için
              ), 
              */
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_a_photo_outlined),
                selectedIcon: Icon(Icons.add_a_photo_rounded),
                label: Text('Photos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.note_add_outlined),
                selectedIcon: Icon(Icons.note_add_rounded),
                label: Text('Notes'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('Likes'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: screens[_selectedIndex]
            ),
          )
        ],
      ),
    );
  }
}


mixin ListContainer {

  List<Widget> get screens => _screens;

  final List<Widget> _screens = [
      Container(
        color: Colors.brown.shade100,
        alignment: Alignment.center,
        child: const Text
        ('Home',
        style: TextStyle(fontSize: 40),),
      ),
      Container(
        color: Colors.amber.shade100,
        alignment: Alignment.center,
        child: PhotoGallery()
      ),
      Container(
        color: Colors.green.shade100,
        alignment: Alignment.topCenter,
        child: NotesList(),
      ),
      Container(
        color: Colors.red.shade50,
        alignment: Alignment.center,
        child: const Text
        ('Likes',
        style: TextStyle(fontSize: 40),),
      ),
  ];
}

mixin Dialogs {

  Future<void> _addPhotoDialogBuilder(BuildContext context) {

    File? file;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Photo'),
          content: const Text(
            'Select an image to upload your personal gallery.',
          ),
          actions: [
                          TextButton(
                          style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                          child: const Text('Choose Image'),
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();

                            final XFile? result = await picker.pickImage(source: ImageSource.gallery);

                            // final result = await image.pickImage(source: ImageSource.gallery);
                              if( result == null){
                          
                                file = null;
                                if (context != null && context.mounted) {
                                 
                                        Navigator.of(context).pop();
                                }
                                
                              } else {
                               
                                file = File(result.path);
                                 if (context != null && context.mounted) {
                                  
                                        Navigator.of(context).pop();
                                        return _secondPhotoDialog(context,file);
                                }
                                
                              }
                          },
                        ),
                          TextButton(
                            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                         
          ],
        );

      },
    );
  }

  Future<void> _secondPhotoDialog(BuildContext context,File? fileM) {

    final scaffoldMessenger = ScaffoldMessenger.of(context);

      if(fileM == null) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text("A image could not loaded !")));
      }

      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
          title: const Text('Add Photo'),
          content: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    child: Image.file(fileM!),
                  ),
            ),
          actions: [
            TextButton(
                          style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                          child: const Text('Add'),
                          onPressed: () async {
                           await _saveImage(context,fileM);
                           if (context != null && context.mounted) {
                               Navigator.of(context).pop();
                            }
                          },
                        ),
                        TextButton(
                            style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
          ]
        );
          }
      );

  }


Future<void> _addNoteDialogBuilder(BuildContext context) {
  String? hValue;
  String? eValue;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: Container(
            alignment: Alignment.center,
            child: Column(children:
            [
              Padding(
                padding: EdgeInsets.all(2.0),
                child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.topic_outlined,color: Colors.blue,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), 
                  labelText: 'Header'),
                onChanged: (text) {
                  if(text.isNotEmpty) {
                    hValue = text;
                  }
                }
              ),
              ),
              SizedBox(height: 2,),
              Padding(
                padding: EdgeInsets.all(2.0),
                child:  TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),  
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.note_add_sharp,color: Colors.blue,),
                  hintText: 'note',
                  helperText: 'Enter your note',
                  ),
                keyboardType: TextInputType.multiline,
                minLines: 1, // Normal textInputField will be displayed
                maxLines: 5, 
                onChanged: (text) {
                  if(text.isNotEmpty) {
                    eValue = text;
                  }
                  // print('First text field: $text (${text.characters.length})');
                }
                ),
              ),
              
            ]
             
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Add'),
              onPressed: () async {
                await _saveNote(context,hValue,eValue);
                if (context != null && context.mounted) {
                    Navigator.of(context).pop();
                 }
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<void> _addLikesDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Likes'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    Future<void> _saveImage(BuildContext context,File? fileN) async {
    String? message;
    final processesViewmodel = Provider.of<ProcessesViewmodel>(context,listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    
    try {
      if(fileN != null && userId != null){
        final Uint8List bytes =  File(fileN.path).readAsBytesSync();
        // String _base64String = base64.encode(bytes); // added
        final String imaege64 = uint8ListTob64(bytes);
        final r = processesViewmodel.addingPhoto(photo: imaege64, user_id: userId);
        if (r != null) {
        message = 'Image saved to db';
      }
      }
      
      
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }


  Future<void> _saveNote(BuildContext context,String? headerValue, String? expandedValue) async {
    String? message;
    final processesViewmodel = Provider.of<ProcessesViewmodel>(context,listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    try {
      if(headerValue != null && userId != null && expandedValue != null
       && headerValue.trim() != '' && expandedValue.trim() != ''){
        
        final r = processesViewmodel.addingNote(headerValue: headerValue, expandedValue: expandedValue ,user_id: userId);
        if (r != null) {
        message = 'Note saved to db';
      }
      } else {
        message = 'User not found or header or description is empty';
      }
      
    } catch (e) {
      message = 'An error occurred while saving the note';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

String uint8ListTob64(Uint8List uint8list) {
  String base64String = base64Encode(uint8list);
  // String header = "data:image/png;base64,";
  // return header + base64String;
  return base64String;
}

Uint8List b64Touint8List(var  base64) {
  Uint8List base64String = base64Decode(base64);
  var bytes = Uint8List.fromList(base64String);
  return bytes;
}

}

mixin CheckUser {
  Future<bool> checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    if(userId != '0') {
      return true;
    } 
    return false;
  }
  
}
