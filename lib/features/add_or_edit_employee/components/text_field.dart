import 'package:employee/main.dart';
import 'package:employee/utils/app_extension.dart';

class CustomTextField extends StatefulWidget {
  final String icon, hint;
  final TextEditingController controller;
  final bool enabled;
  const CustomTextField(
      {super.key,
      required this.icon,
      required this.hint,
      required this.controller,
      this.enabled = true});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      height: 40,
      child: Obx(
        () => TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset(
                  widget.icon,
                ),
              ),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.textFieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.textFieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.textFieldBorder),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: AppColors.textFieldBorder),
              ),
              hintText: widget.hint,
              hintStyle: _hintStyle(),
              contentPadding: const EdgeInsets.symmetric(vertical: 10)),
          style: (databaseManager.role.value == '' ||
                  databaseManager.toDate.value == '' ||
                  databaseManager.fromDate.value == '')
              ? _hintStyle().copyWith(color: AppColors.text)
              : _hintStyle().copyWith(color: AppColors.black),
        ),
      ),
    );
  }

  TextStyle _hintStyle() {
    return TextStyle(
        color: AppColors.hintText,
        fontSize: 16,
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontWeight: FontWeight.w500);
  }
}
