import 'package:flutter/material.dart';
import 'package:pixri/src/model/application.dart';
import 'package:pixri/src/api/application_api_service.dart';
import 'package:pixri/src/views/application/application_list_view.dart';
import 'package:pixri/src/views/application/application_page.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ApplicationForm extends StatefulWidget {
  Application application;

  ApplicationForm({this.application});

  @override
  ApplicationFromState createState() => ApplicationFromState();
}

class ApplicationFromState extends State<ApplicationForm> {
  bool _isLoading = false;
  ApplicationApiService _apiService = ApplicationApiService();
  bool _isFieldNameValid;
  TextEditingController _controllerName = TextEditingController();
  bool _isFieldDescriptionValid;
  TextEditingController _controllerDescription = TextEditingController();
  bool _isFieldPurposeValid;
  TextEditingController _controllerPurpose = TextEditingController();
  bool _isFieldBaseUrlValid;
  TextEditingController _controllerBaseUrl = TextEditingController();
  TextEditingController _controllerCompany = TextEditingController();

  @override
  void initState() {
    if (widget.application != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.application.name.toString();
      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.application.description.toString();
      _isFieldPurposeValid = true;
      _controllerPurpose.text = widget.application.purpose.toString();
      _isFieldBaseUrlValid = true;
      _controllerBaseUrl.text = widget.application.baseURL.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
            widget.application == null
                ? "Create new Application"
                : "Edit Application",
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
                  _buildTextFieldPurpose(),
                  _buildTextFieldBaseUrl(),
                  _buildTextFieldCompany(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      child: Text(
                        widget.application == null
                            ? "Create Applicaton"
                            : "Update Application ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_isFieldNameValid == null ||
                            !_isFieldNameValid ||
                            _isFieldDescriptionValid == null ||
                            !_isFieldDescriptionValid) {
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
                        String purpose = _controllerPurpose.text.toString();
                        String base_url = _controllerBaseUrl.text.toString();
                        String company = _controllerCompany.text.toString();

                        Application application = Application(
                          name: name,
                          description: description,
                          purpose: purpose,
                          baseURL: base_url,
                          company: company,
                        );
                        if (widget.application == null) {
                          _apiService
                              .createApplication(application)
                              .then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplicationPage()));
                            } else {
                              _scaffoldState.currentState.showSnackBar(SnackBar(
                                content: Text("Submit data failed"),
                              ));
                            }
                          });
                        } else {
                          application.id = widget.application.id;

                          _apiService
                              .updateApplication(application)
                              .then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ApplicationListView()));
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
        labelText: "Application Name",
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
        errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescriptionValid) {
          setState(() => _isFieldDescriptionValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPurpose() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _controllerPurpose,
//      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Purpose",
        errorText: _isFieldPurposeValid == null || _isFieldPurposeValid
            ? null
            : "Purpose is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPurposeValid) {
          setState(() => _isFieldPurposeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldBaseUrl() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _controllerBaseUrl,
//      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Base URL",
        errorText: _isFieldBaseUrlValid == null || _isFieldBaseUrlValid
            ? null
            : "Base URL is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldBaseUrlValid) {
          setState(() => _isFieldBaseUrlValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldCompany() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        labelText: "Company",
      ),
      controller: _controllerCompany,
    );
  }
}
