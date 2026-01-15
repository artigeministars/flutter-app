import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app2/data/models/photo_model.dart';
import 'package:flutter_app2/ui/processes_viewmodel.dart';
import 'package:flutter_image_converter/flutter_image_converter.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';


class PhotoGallery extends StatelessWidget {

      PhotoGallery({super.key});
  

  final List<PhotoM> images = [
  PhotoM(
    title: 'Product 1',
    subtitle: 'Subtitle 1',
    imageUrl: 'https://picsum.photos/250?image=237',
  ),
  PhotoM(
    title: 'Product 2',
    subtitle: 'Subtitle 2',
    imageUrl: 'https://picsum.photos/250?image=238',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=239',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=240',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=241',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=242',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=243',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=244',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=265',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=266',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=247',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=248',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=249',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=250',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=251',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=252',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=253',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=254',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=255',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=256',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=257',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=258',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=259',
  ),
  PhotoM(
    title: 'Product 3',
    subtitle: 'Subtitle 3',
    imageUrl: 'https://picsum.photos/250?image=260',
  ),
];

Widget b64Touint8List(String  base64) {
Uint8List myImage;
  if(base64 != null){
   return Image.memory(
    base64Decode(base64),
    width: double.infinity,
    // height: 400,
    fit: BoxFit.cover,      // cover, contain, fill, fitWidth, fitHeight, none, scaleDown
    alignment: Alignment.center,
   );
/*
final firstPass = utf8.decode(base64Decode(base64.trim()));
    final cleaned = firstPass.contains(',')
        ? firstPass.split(',').last.trim()
        : firstPass.trim();
    return base64Decode(cleaned);
*/
  
  //  String a = base64.replaceAll("\n", "").replaceAll(" ", "");
  //  final String pureBase64String = a.split(",").last;

  //  Uint8List imageBytes = base64Decode((base64.replaceAll(RegExp(r'\s'), '')));
  //  Uint8List _bytes = base64Decode(base64.split(',').last);
  //   Uint8List b = base64Decode(a);
   // final UriData? data = Uri.parse(imageBytes).data;
   // myImage = data!.contentAsBytes();
 
    
    //  return b;
  
  }
        
        // print(base64);
        // print(" base64 ");
        // Uint8List base64String = base64Decode(base64);
        // Uint8List base64String = base64Decode(base64.replaceAll("\n", ""));
        // final readme = String.fromCharCodes(base64String);
        // print(" base64 2 ");
        // UriData? data = Uri.parse(base64String).data;
        // print(" base64 3 ");
        // print(data!.isBase64); 
         //  var bytes = Uint8List.fromList(base64String);
        // Uint8List myImage = data!.contentAsBytes();

        

}

@override
Widget build(BuildContext context) {

final ProcessesViewmodel processesViewmodel = Provider.of<ProcessesViewmodel>(context,listen: false);
// var photos = await processesViewmodel.getAllPhotos();


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
                ), // Number of columns
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
                
                return SingleChildScrollView(
                  // clipBehavior: Clip.hardEdge,
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
                                                  // Image.memory(base64Decode(snapshot.data![index].photo)),
                                                    // Image.memory(Uint8List.fromList(b64Touint8List(snapshot.data![index].photo))),
                                                    // Image.memory(base64.decode(snapshot.data![index].photo.toString())),
                                                    // Image.memory(b64Touint8List(snapshot.data![index].photo)),
                                                    // Image.memory(base64.decode(snapshot.data![index].photo)),
                                                    // base64.decode(snapshot.data![index].photo).widgetImageSync
                                                    // Image.memory(b64Touint8List(snapshot.data![index].photo)),
                                                    // Text(images[index].title),
                                                    // Text(images[index].subtitle),
                                                    // b64Touint8List(snapshot.data![index].photo),
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