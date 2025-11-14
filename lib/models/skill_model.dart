import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillModel {
  final String name;
  final IconData icon;
  final double level;

  SkillModel({required this.name, required this.icon, required this.level});

  static List<SkillModel> getSkills() {
    return [
      SkillModel(name: 'Flutter', icon: FontAwesomeIcons.mobile, level: 0.9),
      SkillModel(name: 'Dart', icon: FontAwesomeIcons.code, level: 0.9),
      SkillModel(
        name: 'Web Development',
        icon: FontAwesomeIcons.globe,
        level: 0.85,
      ),
      SkillModel(name: 'JavaScript', icon: FontAwesomeIcons.js, level: 0.8),
      SkillModel(name: 'React', icon: FontAwesomeIcons.react, level: 0.75),
      SkillModel(name: 'Python', icon: FontAwesomeIcons.python, level: 0.8),
      SkillModel(
        name: 'Git & GitHub',
        icon: FontAwesomeIcons.github,
        level: 0.85,
      ),
      SkillModel(
        name: 'UI/UX Design',
        icon: FontAwesomeIcons.figma,
        level: 0.75,
      ),
    ];
  }
}
