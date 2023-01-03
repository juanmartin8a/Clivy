import 'package:flutter/material.dart';

class EditProfileField extends StatelessWidget {
  final TextEditingController? controller;
  final String fieldName;
  final Function checkOnChange;
  final String? fieldError;
  EditProfileField({
    this.controller,
    required this.fieldName,
    required this.checkOnChange,
    required this.fieldError,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxis
        children: [
          Container(
            width: 78,
            // color: Colors.red,
            height: 44,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fieldName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  // height: 1.2
                ),
              ),
            )
          ),
          Expanded(
            child: Container(
              // height: 40,
              margin: EdgeInsets.only(left: 12),
              // color: Colors.green,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // color: Colors.red,
                    child: TextField(
                      maxLength: 30,
                      // expands: true,
                      maxLines: fieldName == "Bio" ? null : 1,
                      keyboardType: fieldName == "Bio" ? TextInputType.multiline : null,
                      // textInputAction: TextInputAction.go,
                      controller: controller,
                      textInputAction: TextInputAction.done,
                      cursorColor: Color(0xff00ff03),
                      keyboardAppearance: Brightness.dark,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.25
                      ),
                      
                      decoration: InputDecoration(
                        counterText: "",
                        isCollapsed: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
                          // borderRadius: BorderRadius.circular(12.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
                          // borderRadius: BorderRadius.circular(12.5),
                        ),
                        
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.25
                        ),
                      ),
                      onChanged: (values) {
                        checkOnChange();
                      },
                    ),
                  ),
                  if (fieldError != null)
                  SizedBox(height: 6),
                  if (fieldError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // color: Colors.red,
                      // width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        fieldError!,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2
                        ),
                      )
                    ),
                  ),
                ],
              )
            ),
          )
        ],
      )
    );
  }
}