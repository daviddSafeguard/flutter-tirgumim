import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tirgumim/AppStore/appStore.dart';
import 'package:tirgumim/UI/fullTable.dart';
import 'package:tirgumim/UI/serverDataTable/paginatedDataTable.dart';
import 'package:tirgumim/UI/translatePage.dart';
import 'package:tirgumim/UI/workerDataTable/workersDataTable.dart';
import 'package:tirgumim/api/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppStore(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('he'), // Hebrew
          ],
          locale: Locale('he'),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage('אפליקצית שפות'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isinit = true;

  AppStore appStore;
  @override
  void didChangeDependencies() async {
    if (isinit) {
      await Api.login(email: "arnonm", password: "arnon123");
      setState(() {
        isinit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // appStore.getAllUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isinit
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[700],
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'פר תמונה'),
                    Tab(text: 'טבלה כוללת'),
                    Tab(text: 'טבלת שרת'),
                    Tab(text: 'עובדים'),
                  ],
                ),
                title: Text(widget.title),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TranslatePage(),
                  FullTable(),
                  ServerDataTable(),
                  WorkerDataTable(),
                ],
              ),
            ),
          );
  }
}
