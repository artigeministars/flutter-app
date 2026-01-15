

import 'package:flutter/material.dart';
import 'package:flutter_app2/data/models/note_model.dart';
import 'package:flutter_app2/ui/processes_viewmodel.dart';
import 'package:provider/provider.dart';


class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {

ProcessesViewmodel? processesViewmodel;
List<Note> notes = [];

@override
@mustCallSuper 
void initState() {
  processesViewmodel = Provider.of<ProcessesViewmodel>(context,listen: false);
  fetchData();
  super.initState();
}
// final List<Note> _data = notes;
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(child: Container(child: _buildPanel()));
  }

  Widget _buildPanel() {

    return ExpansionPanelList(
                dividerColor: Colors.blue.shade100,
                elevation: 6,
                expandIconColor: Colors.blue.shade400,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    notes![index].isExpanded = isExpanded;
                  });
                },
                children:  notes.map<ExpansionPanel>((Note note) {
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
                           notes!.removeWhere((Note currentItem) => note == currentItem);
                        });
                      },
                    ),
                    isExpanded: note.isExpanded,
        );
      }).toList(),
      );
      
  }

  Future<void> fetchData() async {
  final notes_ = await processesViewmodel!.getAllNotes();
  setState(() {
    notes = notes_;
  });
}

}