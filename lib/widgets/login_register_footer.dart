import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginRegisterFooter extends StatelessWidget {
  final String normalText;
  final String linkText;
  final Function()? onClick;

  const LoginRegisterFooter({
    super.key,
    required this.normalText,
    required this.linkText,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          children: [
            TextSpan(
              text: linkText,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.blue, fontSize: 14),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onClick?.call();
                },
            ),
          ],
        ),
      ),
    );
  }
}
