import 'package:employee/utils/app_extension.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 21)),
        backgroundColor:
            MaterialStateProperty.all(widget.buttonColor ?? AppColors.primary),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          fontSize: 16,
          color: widget.textColor ?? AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
