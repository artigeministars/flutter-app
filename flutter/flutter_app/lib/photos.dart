import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app2/data/models/photo_model.dart';
import 'package:flutter_app2/ui/processes_viewmodel.dart';
import 'package:provider/provider.dart';



class PhotoGallery extends StatelessWidget {

     const PhotoGallery({super.key});
  

Widget b64Touint8List(String  base64) {
Uint8List myImage;
  if(base64 != null){
   return Image.memory(
    base64Decode(base64),
    width: double.infinity,
    // height: 400,
    fit: BoxFit.cover,
    alignment: Alignment.center,
   );
  
  }  

}

@override
Widget build(BuildContext context) {

final ProcessesViewmodel processesViewmodel = Provider.of<ProcessesViewmodel>(context,listen: false);

return 

FutureBuilder<List<Photo>> (
        future: processesViewmodel.getAllPhotos(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                // mainAxisExtent: 150,
                ), 
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
                
                return SingleChildScrollView(
                 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          // height: 300,
                          // width: 300,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withValues(alpha:0.5,red:0.6,green:0.5,blue: 0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                            
                          ),
                          child: InkWell(
                                                    splashColor: const Color.fromARGB(255, 5, 106, 188).withAlpha(30),
                                                    onTap: () {
                                                      debugPrint('Photo tapped.');
                                                    },
                                                    child: 
                                                    AspectRatio(
                                                      aspectRatio: 1 / 1,
                              child: b64Touint8List(snapshot.data![index].photo),
                              
                              )
                            ),
  ),
                           
                   ],
                  ),
                  );
                
            },
          )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(width: 60, height: 60, child: CircularProgressIndicator()),
              Padding(padding: EdgeInsets.only(top: 16), child: Text('Awaiting result...')),
            ];
          }
          return SingleChildScrollView(
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: children),
           );
        },
      );

}

}


class PhotoM {
  final String title;
  final String subtitle;
  final String imageUrl;

  PhotoM({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}