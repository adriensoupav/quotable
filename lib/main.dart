import 'package:flutter/material.dart';

void main() {
  runApp(ImageOverlayApp());
}

class ImageOverlayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotable',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  String? _backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotable'),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildTextField(_textController, 'Enter quote', 'Quote'),
              SizedBox(height: 8),
              buildTextField(_authorController, 'Enter author', 'Author'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _generateImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue.shade600,
                  onPrimary: Colors.white,
                ),
                child: Text('Generate'),
              ),
              if (_backgroundImageUrl != null) ...[
                SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.network(
                      _backgroundImageUrl!,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '"${_textController.text}"\n- ${_authorController.text}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _changeImage,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue.shade400,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Change Image'),
                    ),
                    ElevatedButton(
                      onPressed: _changeText,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue.shade300,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Change Text'),
                    ),
                    ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade400,
                        onPrimary: Colors.white,
                      ),
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.lightBlue.shade50,
      ),
    );
  }

  void _generateImage() {
    setState(() {
      if (_backgroundImageUrl == null) {
        _backgroundImageUrl = 'https://source.unsplash.com/random/800x600';
      }
    });
  }

  void _changeImage() {
    setState(() {
      // Use a different random seed for the image URL to fetch a new image
      _backgroundImageUrl = 'https://source.unsplash.com/random/800x600?sig=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  void _changeText() {
    // Clear text fields without affecting the image
    _textController.clear();
    _authorController.clear();
  }

  void _reset() {
    // Clear both text fields and image
    _textController.clear();
    _authorController.clear();
    setState(() {
      _backgroundImageUrl = null;
    });
  }
}
