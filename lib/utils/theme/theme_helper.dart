import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeHelper {
  // InputDecoration textInputDecoration([
  //   String lableText = "",
  //   String hintText = "",
  // ]) {
  //   return InputDecoration(
  //     labelText: lableText,
  //     hintText: hintText,
  //     fillColor: Colors.white,
  //     filled: true,
  //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       borderSide: BorderSide(color: Colors.grey),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       borderSide: BorderSide(color: Colors.grey.shade400),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       borderSide: BorderSide(color: Colors.red, width: 2.0),
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       borderSide: BorderSide(color: Colors.red, width: 2.0),
  //     ),
  //   );
  // }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  BoxDecoration buttonBoxDecoration(
    BuildContext context, [
    String color1 = "",
    String color2 = "",
  ]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).colorScheme.secondary;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [c1, c2],
      ),
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      minimumSize: WidgetStateProperty.all(Size(50, 50)),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black38),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
