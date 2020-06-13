import 'dart:io';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:bloggie/providers/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';


class AddArticlePage extends StatefulWidget {
  final String name;
  const AddArticlePage({@required this.name});
  @override
  _AddArticlePageState createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  String uploadTime;
  File _selectedFile;
  final List<String> categories = [
    'All',
    'Business',
    'DIY',
    'Fashion',
    'Food',
    'Finance',
    'Fitness',
    'Gaming',
    'LifeStyle',
    'Movie',
    'Music',
    'Politics',
    'Sports',
    'Travel'
  ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey3 = GlobalKey<FormState>();


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final progress = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false);
    _selectedFile = Provider.of<ArticleProvider>(context).selectedImage;
    final String selectedCategory =
        Provider.of<ArticleProvider>(context, listen: true).selectedCategory;
    bool _isSubmitting = Provider.of<ArticleProvider>(context).isUploaded;
    return
//      key: _scaffoldKey,
        SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey3,
              autovalidate: false,
              child: Column(
                children: <Widget>[
                  AddArticleField(
                    maxLines: 1,
                    maxLength: 20,
                    controller: _nameController,
                    hinttext: 'Author Name',
                    obstext: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AddArticleField(
                    maxLines: 1,
                    maxLength: 45,
                    controller: _titleController,
                    hinttext: 'Title of the article',
                    obstext: false,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    child: Text(selectedCategory),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      SelectDialog.showModal<String>(context,
                          label: 'Select a Category',
                          titleStyle: TextStyle(color: Color(0xff3f38dd)),
                          showSearchBox: false,
                          items: categories,
                          selectedValue: selectedCategory,
                          onChange: (String selected) {
                        Provider.of<ArticleProvider>(context, listen: false)
                            .changeCategory(selected);
                        print(selectedCategory);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  AddArticleField(
                    maxLines: 10,
                    maxLength: 500,
                    controller: _descriptionController,
                    hinttext: 'Description of the article',
                    obstext: false,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      'Select an image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<ArticleProvider>(context, listen: false)
                          .selectImage();
                    },
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Container(
                    height: 160,
                    width: 340,
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: _selectedFile == null
                        ? Center(child: Text('No Image Selected'))
                        : Image.file(
                            _selectedFile,
                            fit: BoxFit.cover,
                          ),
                  ),

                  RaisedButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if(_isSubmitting){
                              await progress.hide();
                            }else{
                              await progress.show();
                              uploadTime =
                                  DateFormat('dd-MM-yyyy').format(DateTime.now());
                              print(uploadTime);
                              if(_formKey3.currentState.validate() && _selectedFile != null){
                                Provider.of<ArticleProvider>(context,listen: false).startUpload(
                                    _titleController.text,
                                    _descriptionController.text,
                                    selectedCategory,
                                    _nameController.text,
                                    uploadTime);
                              }
                            }
                          },
                        ),
                  SizedBox(
                    height: 80.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddArticleField extends StatefulWidget {
  @override
  _AddArticleFieldState createState() => _AddArticleFieldState();

  final TextEditingController controller;
  final String hinttext;
  final bool obstext;
  final int maxLines;
  final int maxLength;
  const AddArticleField(
      {Key key,
      @required this.maxLength,
      @required this.maxLines,
      @required this.controller,
      @required this.hinttext,
      @required this.obstext})
      : super(key: key);
}

class _AddArticleFieldState extends State<AddArticleField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 14.0,
          ),
          SizedBox(
            width: 14.0,
          ),
          Expanded(
              child: TextFormField(validator: (value){return value.isEmpty ? 'This Field can\'t be empty' : null;},
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            obscureText: widget.obstext,
            controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hinttext, border: InputBorder.none),
          )),
          SizedBox(
            width: 14.0,
          ),
        ],
      ),
    );
  }
}
