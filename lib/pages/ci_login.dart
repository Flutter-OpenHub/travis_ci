/*
 * ci_login.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../init/init.dart';
import '../store/form_store/form_store.dart';
import '../store/token_store/token_store.dart';
import '../utils/open_url.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final _formKey = GlobalKey<FormState>();
  final FormStore store = FormStore();

  bool _obscurePassword = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) =>
          Scaffold(
              //backgroundColor: Colors.white,
              key: _scaffoldKey,
              appBar:
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile
                      ? AppBar(title: Text("Login"), centerTitle: true)
                      : null,
              bottomNavigationBar:
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile
                      ? BottomAppBar(
                          child: ListTile(
                            leading: Icon(Icons.help_outline),
                            title: Text('How to generate access token?',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            onTap: _showInstructions,
                          ),
                        )
                      : null,
              body: _buildUI(sizingInformation)),
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

  _buildForm(SizingInformation sizingInformation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile)
                  ? 24.0
                  : 32.0),
          child: Hero(
              tag: isOrg ? 'org' : 'com',
              child: Image.asset(
                'assets/TravisCI-Mascot-${isOrg ? "1" : "2"}.png',
                width: 80.0,
                height: 80.0,
              )),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Text(
              '${isOrg ? 'Org' : 'Com'} Server',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
            )),
        Text(
          'https://travis-ci.${isOrg ? "org" : "com"}',
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
                            onSubmitted: (value) {
                              store.validateAll();
                              if (!store.errorState.hasErrors) {
                                kTokenStore = TokenStore();
                                kTokenStore.token = store.token;
                                store.authUser();
                              }
                            },
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
                                  kTokenStore = TokenStore();
                                  kTokenStore.token = store.token;
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
    );
  }

  _buildInstructionsUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To authenticate against the Travis CI API, you need an API access token generated by the Travis CI command line client.',
          style: TextStyle(),
        ),
        ActionChip(
          label: Text('Command line client'),
          onPressed: () {
            OpenUrl.launchURL(
                'https://github.com/travis-ci/travis.rb#installation');
          },
        ),
        SizedBox(
          height: 16.0,
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
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
              ),
            )
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(
          'Tokens for open source projects, private projects and enterprise installations of Travis CI are not interchangeable.',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  _buildUI(SizingInformation sizingInformation) {
    return sizingInformation.deviceScreenType == DeviceScreenType.mobile
        ? SingleChildScrollView(child: _buildForm(sizingInformation))
        : Center(
            child: SizedBox(
              width: 500.0,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppBar(
                          title: Text(
                            "Login",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color),
                          ),
                          centerTitle: false,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).iconTheme.color),
                          backgroundColor: Theme.of(context).cardColor,
                          elevation: 0.0,
                        ),
                        _buildForm(sizingInformation),
                        SizedBox(
                          height: 32.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.help_outline),
                          title: Text('How to generate access token?',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          onTap: _showInstructionsDialog,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  _navigate() {
    // Init TokenStore
    kTokenStore = TokenStore();
    kTokenStore.token = store.token;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(store: store)));
  }

  _showError() {
    //TODO Snackbar is not visible if bottomsheet is active
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(store.errorMessage),
      behavior: SnackBarBehavior.floating,
    ));
    store.errorMessage = '';
  }

  _showInstructions() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        builder: (_) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: _buildInstructionsUI(),
            ));
  }

  _showInstructionsDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: Text(
                'How to generate access token?',
              ),
              content: _buildInstructionsUI(),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CLOSE")),
              ],
            ));
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}
