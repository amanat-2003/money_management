import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.purple,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              // button: TextStyle(
              //   color: Colors.white,
              // ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline4: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Mobile Phone 1',
      amount: 231,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Mobile Phone 2',
      amount: 231,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Mobile Phone 3',
      amount: 231,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Mobile Phone',
    //   amount: 231,
    //   date: DateTime.now(),
    // ),
    Transaction(
      id: 't4',
      title: 'Laptop 1',
      amount: 504,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Laptop 2',
      amount: 504,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return ((element.id == id) ? true : false);
      });
    });
  }

  List<Widget> _buildLandscapeContent({
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  }) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent({
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  }) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  AppBar _generateAppBar() {
    return AppBar(
      title: Text('Flutter App', style: TextStyle(fontFamily: 'OpenSans')),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = (mediaQuery.orientation == Orientation.landscape);
    final appBar = _generateAppBar();
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: _generateAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Landscape Mode
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaQuery: mediaQuery,
                appBar: appBar,
                txListWidget: txListWidget,
              ),

            // Portrait Mode
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery: mediaQuery,
                appBar: appBar,
                txListWidget: txListWidget,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
