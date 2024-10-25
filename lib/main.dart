import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  List<Item> items = [];

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        items.add(Item(name: _controller.text, isChecked: false));
        _controller.clear();
      });
    }
  }

  void _toggleCheckbox(int index) {
    setState(() {
      items[index].isChecked = !items[index].isChecked;
    });
  }

  void _deleteCheckedItems() {
    setState(() {
      items.removeWhere((item) => item.isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.check_circle, color: Colors.white),
            onPressed: () {},
          ),
          title: Text(
            'Shopping List',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.delete_sweep, color: Colors.white),
              onPressed: _deleteCheckedItems,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter item',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addItem,
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(items[index].name),
                        trailing: Checkbox(
                          value: items[index].isChecked,
                          onChanged: (bool? value) {
                            _toggleCheckbox(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  String name;
  bool isChecked;

  Item({required this.name, this.isChecked = false});
}
