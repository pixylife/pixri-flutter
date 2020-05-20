import 'package:flutter/material.dart';
import 'package:pixri/src/model/entity.dart';
import 'package:pixri/src/api/entity_api_service.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/views/entity/entity_page.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class EntityForm extends StatefulWidget {
  Entity entity = new Entity();
  Application application = new Application();

  EntityForm(this.application);
  EntityForm.fromEntity(this.entity, this.application);

  @override
  EntityFromState createState() => EntityFromState();
}

class EntityFromState extends State<EntityForm> {
  bool _isLoading = false;
  EntityApiService _apiService = EntityApiService();
  bool _isFieldNameValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  void initState() {
    if (widget.entity != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.entity.name.toString();
      _controllerDescription.text = widget.entity.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.entity == null ? "Create new Entity" : "Edit Entity",
            style: TextStyle(color: Colors.white)),
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
                  _buildTextFieldDescription(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      child: Text(
                        widget.entity == null
                            ? "Create Entity"
                            : "Update Entity ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_isFieldNameValid == null || !_isFieldNameValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all fields"),
                            ),
                          );
                          return;
                        }
                        setState(() => _isLoading = true);
                        String name = _controllerName.text.toString();
                        String description =
                            _controllerDescription.text.toString();

                        Entity entity = Entity(
                            name: name,
                            description: description,
                            applicationId: widget.application.id);
                        if (widget.entity == null) {
                          _apiService.createEntity(entity).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EntityPage(widget.application)));
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Submit data failed"),
                              ));
                            }
                          });
                        } else {
                          entity.id = widget.entity.id;

                          _apiService.updateEntity(entity).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EntityPage(widget.application)));
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
        labelText: "Entity Name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDescription() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _controllerDescription,
//      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Description",
      ),
    );
  }
}
