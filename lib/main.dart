import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/screens/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setEnabledSystemUIOverlays([]);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,

    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: App(),
      locale: Locale('th', 'TH'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
