import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  Camera({Key key, this.callback, this.isEnabled = true, this.image}) : super(key: key);

  var image;
  final Function callback;
  final bool isEnabled;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void initState() {
    super.initState();
  }

  getImageFile() async {
    try {
      final result = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      print(result.path);
      if (result != null && result.path != null) {
        setState(() {
          widget.image = result.path;
          widget.callback(result.path);
        });
      } else
        throw "result $result or path null";
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Stack(children: <Widget>[
          Container(
            height: widget.image == null ? 150 : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12),
              color: Colors.black12,
            ),
            child: (widget.image == null)
                ? Center(child: IconButton(icon: Icon(Icons.photo_library), onPressed: () => {if (widget.isEnabled) getImageFile()}))
                : widget.image is NetworkImage
                    ? Image(
                        image: widget.image,
                        fit: BoxFit.fitWidth,
                      )
                    : widget.image is String ? Image(image: NetworkImage(widget.image), fit: BoxFit.cover) : Image(image: MemoryImage(widget.image), fit: BoxFit.fitWidth),
          ),
          if (widget.image != null && widget.isEnabled)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.black12),
                  child: IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.refresh,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.callback(null);
                          widget.image = null;
                        });
                      })),
            )
        ]));
  }
}
