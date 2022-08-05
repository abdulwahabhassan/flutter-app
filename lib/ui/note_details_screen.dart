import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/note.dart';
import 'new_note_bottom_sheet.dart';

//WIDGET
class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({
    Key? key,
    required this.note,
    required this.onNoteUpdated,
  }) : super(key: key);

  final Note note;
  final ValueChanged<Note> onNoteUpdated;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

//STATE
class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          widget.note.title,
          style: const TextStyle(inherit: true, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (builder) {
                    return NewNoteBottomSheetWidget(
                      initialTitleText: widget.note.title,
                      initialBodyText: widget.note.body,
                      onSaveButtonClicked: (Note value) {
                        widget.onNoteUpdated(Note(
                            id: widget.note.id,
                            title: value.title,
                            body: value.body,
                            date: widget.note.date));
                      },
                    );
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0))),
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _handleImagePickerPressed(ImageSource.gallery,
                    context: context, isMultiImage: true);
              },
              icon: const Icon(Icons.add_a_photo_rounded))
        ],
        // bottom: TabBar(tabs: ),
        elevation: 0.0,
        scrolledUnderElevation: 2.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100, child: _handlePreview()),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.note.title,
                  style: const TextStyle(
                      inherit: true, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12.0),
                child: Text(widget.note.body,
                    style: const TextStyle(inherit: true, fontSize: 15)),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  widget.note.date ?? "",
                  style: const TextStyle(
                      inherit: true, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _handleImagePickerPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final List<XFile>? pickedFileList = await _picker.pickMultiImage();
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(
            source: source, maxWidth: 100, maxHeight: 100);
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return GridView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(_imageFileList![index].path),
                fit: BoxFit.cover,
              ));
        },
        itemCount: _imageFileList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, crossAxisSpacing: 8, mainAxisSpacing: 8),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        style: const TextStyle(inherit: true, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const Text(
          'You can add images to this note',
          textAlign: TextAlign.center,
          style: TextStyle(inherit: true, fontStyle: FontStyle.italic),
        ),
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
