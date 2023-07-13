part of 'buttons.dart';

class TekLink extends StatelessWidget {
  const TekLink({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TekButtonGD(
      type: TekButtonGDType.text,
      text: text,
      onPressed: onPressed,
    );
  }
}
