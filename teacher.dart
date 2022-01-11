class Teacher {
  static List teacherlogin = ["Abror"];
  static List teacherpassword = ["4905072a"];
  static List teacherlesson = ["English"];
  static final String pass = "school-245";

  void addAccount({
    required String login,
    required String password,
    required String lessonname,
  }) {
    teacherlogin.add(login);
    teacherpassword.add(password);
    teacherlesson.add(lessonname);
  }
}
