import 'package:flutter/material.dart';
import 'package:random_words_listview/random_word_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appTittle = "Home Page";
  String buttonTittle = "Liste sayfasına git";
  TextStyle buttonStyle = const TextStyle(fontSize: 20);
  TextStyle titleStyle = const TextStyle(fontSize: 23);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppbar(),
      body: centerButton(context),
    );
  }

  Center centerButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          onPrimary: Colors.black,
          primary: Colors.lime,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RandomWordPage(),
            ),
          );
        },
        child: Text(
          buttonTittle,
          style: buttonStyle,
        ),
      ),
    );
  }

  AppBar homeAppbar() => AppBar(
        title: Text(
          appTittle,
          style: titleStyle,
        ),
        centerTitle: true,
      );
}
