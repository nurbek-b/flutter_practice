import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/info_page/info_page.dart';
import 'package:shop_app/utils/CustomTextStyle.dart';


class EditProfilePage extends StatefulWidget {
  static String routeName = "/edit_profile";
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState(){
    name = Provider.of<Auth>(context, listen: false).name;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }),
        title: Text(
            AppLocalizations.of(context).translate("editProfile"),
          style: CustomTextStyle.textFormFieldBlack.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Container(
              child: TextFormField(
                initialValue: auth.name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: AppLocalizations.of(context).translate("yourName"),
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Color(0xFF1B5E20))),
                ),
                onSaved: (value) =>name = value,
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 48, right: 48),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: RaisedButton(
                  color: Color(0xFF1B5E20),
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState.save();
                    auth.name = name;
                  },
                  child: Text(
                    AppLocalizations.of(context).translate("save"),
                    style: CustomTextStyle.textFormFieldBlack
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}