import 'package:flutter/material.dart';
import 'package:pixri/src/model/field.dart';
import 'package:pixri/src/model/entity.dart';
import 'package:pixri/src/api/field_api_service.dart';
import 'package:pixri/src/model/application.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FieldForm extends StatefulWidget {
  Field field;
  Entity entity;

  FieldForm({this.entity});
  FieldForm.fromField({this.field});

  @override
  FieldFromState createState() => FieldFromState();
}

class FieldFromState extends State<FieldForm> {
  bool _isLoading = false;
  FieldApiService _apiService = FieldApiService();
  bool _isFieldNameValid;
  TextEditingController _controllerName = TextEditingController();
  bool _isFieldUINameValid;
  TextEditingController _controllerUIName = TextEditingController();
  var _types = ["Text","Number","Float","Date "];
  var _currentItemSelected = "Text";


  @override
  void initState() {
    if (widget.entity != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.field.name.toString();
      _controllerUIName.text = widget.field.uiName.toString();
      _currentItemSelected = widget.field.type.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.entity == null ? "Create new Field" : "Edit Field", style: TextStyle(color: Colors.white)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextFieldName(),
                  _buildDropDownType(),
                  _buildTextFieldUIName(),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      child: Text(
                        widget.entity == null ? "Create Field": "Update Field ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_isFieldNameValid == null ||
                            !_isFieldNameValid ) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all fields"),
                            ),
                          );
                          return;
                        }
                        setState(() => _isLoading = true);
                        String name = _controllerName.text.toString();
                        String uiName = _controllerUIName.text.toString();
                        String type = _currentItemSelected.toString();

                        Field field = Field(
                            name: name,
                            type: type,
                            uiName : uiName,
                            entityId: widget.entity.id

                        );
                        if (widget.entity == null) {
                          _apiService.createField(field).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pop(_scaffoldState.currentState.context);
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Submit data failed"),
                              ));
                            }
                          });
                        } else {
                          field.id = widget.field.id;

                          _apiService.updateField(field).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pop(_scaffoldState.currentState.context);
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Update data failed"),
                              ));
                            }
                          });
                        }
                      },
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
            ),
            _isLoading
                ? Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _controllerName,
//      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Field Name",
        errorText: _isFieldNameValid == null || _isFieldNameValid ? null : "Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldUIName() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _controllerUIName,
//      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Field UI-Name",
        errorText: _isFieldUINameValid == null || _isFieldUINameValid ? null : "UI-Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldUINameValid) {
          setState(() => _isFieldUINameValid = isFieldValid);
        }
      },
    );
  }


 Widget _buildDropDownType() {
    return DropdownButton<String>(
      items: _types.map((String dropDownItem){
          return DropdownMenuItem<String>(value: dropDownItem,child: Text(dropDownItem),);
      }).toList(),
      onChanged: (String newValueSelected){
        setState(() {
          this._currentItemSelected = newValueSelected;
        });
      },value: _currentItemSelected,
    );
 }

}
