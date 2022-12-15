import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required Function() action,
    required String labelText,
    TextStyle? style,
  }) : _action = action, _labelText = labelText, _style = style;

  final Function() _action;
  final String _labelText;
  final TextStyle? _style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _action,
      child: Text(
        _labelText,
        style: _style ?? defaultStyle,
      ),
    );
  }

  static TextStyle get defaultStyle {
    return TextStyle(
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.fade,
      color: Colors.blue,
    );
  }
}

class BorderedButton extends StatelessWidget {
  const BorderedButton({
    super.key,
    required Function() onPressed,
    required Widget child,
  }) : _onPressed = onPressed, _child = child;

  final Widget _child;
  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: _onPressed,
        color: Colors.black,
        textColor: Colors.white,
        child: _child,
      ),
    );
  }
}