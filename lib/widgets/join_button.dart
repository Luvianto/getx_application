import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/alumni_in_trainings/alumni_in_trainings_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';

class JoinButton extends StatefulWidget {
  final bool isJoined;

  const JoinButton({
    super.key,
    required this.isJoined,
  });

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  final AlumniInTrainingsController controller =
      Get.put(AlumniInTrainingsController());
  late bool _isJoined;

  @override
  void initState() {
    super.initState();
    _isJoined = widget.isJoined;
  }

  void _handleJoin() {
    setState(() {
      _isJoined = true;
    });
    controller.createAlumniInTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return _isJoined
        ? const SizedBox()
        : Column(
            children: [
              const SizedBox(height: 10),
              CustomButton(
                text: 'Daftar Pelatihan',
                onTap: _handleJoin,
              ),
            ],
          );
  }
}
