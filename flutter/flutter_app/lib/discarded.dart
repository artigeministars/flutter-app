/*
    return FutureBuilder<List<Note>> (
        future: processesViewmodel!.getAllNotes(), 
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              ExpansionPanelList(
                dividerColor: Colors.blue.shade100,
                elevation: 6,
                expandIconColor: Colors.blue.shade400,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    snapshot.data![index].isExpanded = isExpanded;
                  });
                },
                children:  snapshot.data!.map<ExpansionPanel>((Note note) {
                  return ExpansionPanel(
                    
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                      leading: const Icon(Icons.list), // Icon on the left side of the ListTile.
                      title: Text(note.headerValue), // Main title text that shows item index.
                    );
                    },
                    body: ListTile(
                      title: Text(note.expandedValue),
                      subtitle: null,
                      trailing: const Icon(Icons.delete),
                      onTap: () {
                        setState(() {
                           snapshot.data!.removeWhere((Note currentItem) => note == currentItem);
                        });
                      },
                    ),
                    isExpanded: note.isExpanded,
        );
      }).toList(),
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
    ?/
  
  }

}


/*

class NotesListE extends StatelessWidget {
  
  NotesListE({super.key});

  List<Note> notes = [  
      Note(headerValue: "What is Lorem Ipsum?" , expandedValue: ''' Lorem Ipsum is simply dummy text of 
      the printing and typesetting industry. 
      Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
      when an unknown printer took a galley of type and scrambled 
      it to make a type specimen book. 
      It has survived not only five centuries, 
      but also the leap into electronic typesetting, 
      remaining essentially unchanged. 
      It was popularised in the 1960s with the release of Letraset sheets 
      containing Lorem Ipsum passages, and more recently 
      with desktop publishing software like Aldus 
      PageMaker including versions of Lorem Ipsum.''' 
      ),
      Note(headerValue: "Why do we use it?" , expandedValue: ''' It is a long established fact that a reader will be 
      distracted by the readable content of a page when looking at its layout. 
      The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, 
      sometimes by accident, sometimes on purpose (injected humour and the like).''' 
      ),
      Note(headerValue: "Where does it come from?" , expandedValue: ''' Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
      The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.''' 
      ),
      Note(headerValue: "Where can I get some?" , expandedValue: ''' There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc. '''  ),
      Note(headerValue: "The standard Lorem Ipsum passage, used since the 1500s" , expandedValue: ''' 
       Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
       '''  ),
      Note(headerValue: "Section 1.10.32 of de Finibus Bonorum et Malorum, written by Cicero in 45 BC" , expandedValue: ''' 
      Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?  
      '''  ), 
      Note(headerValue: "1914 translation by H. Rackham 2" , expandedValue: ''' 
      Lorem ipsum dolor sit amet consectetur adipiscing, elit dapibus mollis a habitasse dui, sed mi auctor neque molestie. Donec non id ultricies sagittis senectus erat euismod sem, vehicula commodo ligula odio venenatis nibh volutpat eget, neque diam himenaeos facilisis feugiat convallis varius. Tellus montes aptent nunc facilisis metus euismod arcu eleifend rutrum id sociis, est dictum netus platea porta interdum posuere vivamus enim integer mattis justo, commodo velit fringilla iaculis eu porttitor fames vitae nisl pretium.
      '''  ),
      Note(headerValue: "1914 translation by H. Rackham" , expandedValue: ''' 
      On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains
      '''  ),
      Note(headerValue: "History of Lorem Ipsum" , expandedValue: ''' 
      Lorem ipsum was conceived as filler text, formatted in a certain way to enable the presentation of graphic elements in documents, without the need for formal copy. Using Lorem Ipsum allows designers to put together layouts and the form of the content before the content has been created, giving the design and production process more freedom.
      It is widely believed that the history of Lorem Ipsum originates with Cicero in the 1st Century BC and his text De Finibus bonorum et malorum. This philosophical work, also known as On the Ends of Good and Evil, was split into five books. The Lorem Ipsum we know today is derived from parts of the first book Liber Primus and its discussion on hedonism, the words of which had been altered, added and removed to make it nonsensical and improper Latin. It is not known exactly when the text gained its current traditional form. However references to the phrase "lorem ipsum" can be found in the 1914 Loeb Classical Library Edition of the De Finibus in sections 32 and 33.
      '''  ),
  ];

@override
Widget build( BuildContext context) {
  

  return ListView.builder(
        itemCount: notes.length, // Number of items to display in the list.
        
        // Builds each item in the list dynamically based on the index.
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.list), // Icon on the left side of the ListTile.
            trailing: const Text(
              "GFG", // Text shown on the right side.
              style: TextStyle(color: Colors.green, fontSize: 15), // Styling the trailing text.
            ),
            title: Text("List item $index"), // Main title text that shows item index.
          );
        },
      );
      
}



}


class Note {

  String headerValue;
  String expandedValue;
  bool isExpanded;

  Note({ required this.headerValue, required this.expandedValue, this.isExpanded = false });

}
*/