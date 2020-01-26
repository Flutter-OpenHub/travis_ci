import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/pages/home_page.dart';
import 'package:travis_ci/store/form_store.dart';
import 'package:travis_ci/utils/open_url.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final _formKey = GlobalKey<FormState>();
  final FormStore store = FormStore();

  bool _obscurePassword = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (BuildContext context) {
            return Container(
              child: ExpansionTile(
                leading: Icon(Icons.help_outline),
                title: Text('How to generate access token?',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'To authenticate against the Travis CI API, you need an API access token generated by the Travis CI command line client.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        ActionChip(
                          label: Text('Command line client'),
                          onPressed: () {
                            OpenUrl.launchURL(
                                'https://github.com/travis-ci/travis.rb#installation');
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'For more details ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {
                                OpenUrl.launchURL(
                                    'https://developer.travis-ci.com/authentication');
                              },
                              child: Text(
                                'click here',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Tokens for open source projects, private projects and enterprise installations of Travis CI are not interchangeable.',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  )
                ],
              ),
            );
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Hero(
                  tag: 'org',
                  child: Image.asset(
                    'assets/TravisCI-Mascot-1.png',
                    width: 80.0,
                    height: 80.0,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                child: Text(
                  'Org Server',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
                )),
            Text(
              'https://travis-ci.org',
              style: TextStyle(color: Colors.blue),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Observer(
                          builder: (_) => TextField(
                                maxLength: 22,
                                onChanged: (value) => store.token = value,
                                decoration: InputDecoration(
                                    labelText: 'Enter access token',
                                    errorText: store.errorState.token,
                                    suffix: IconButton(
                                      icon: _obscurePassword
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: _toggle,
                                      padding: EdgeInsets.all(0.0),
                                    ),
                                    filled: true),
                                keyboardType: TextInputType.text,
                                obscureText: _obscurePassword,
                              )),
                      SizedBox(
                        height: 16.0,
                      ),
                      Observer(
                          builder: (_) => store.authUserFuture != null &&
                                  store.authUserFuture.status ==
                                      FutureStatus.pending
                              ? CircularProgressIndicator()
                              : FloatingActionButton(
                                  onPressed: () {
                                    store.validateAll();
                                    if (!store.errorState.hasErrors) {
                                      store.authUser();
                                    }
                                  },
                                  child: Icon(Icons.check),
                                  tooltip: 'Login',
                                ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposer();
    store.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    store.setupValidations();
    _disposer = reaction(
      (_) => store.authUserFuture.status,
      (result) =>
          store.authUserFuture.status == FutureStatus.rejected && store.hasError
              ? _showError()
              : store.authUserFuture.status == FutureStatus.fulfilled &&
                      !store.hasError
                  ? _navigate()
                  : null,
    );
  }

  _navigate() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
              store: store,
            )));
  }

  _showError() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(store.errorMessage),
      behavior: SnackBarBehavior.floating,
    ));
    store.errorMessage = '';
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}