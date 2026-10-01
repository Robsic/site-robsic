class RegexUtils {
  const RegexUtils._internal();

  static RegExp fullNameRegex =
      RegExp(r"^([A-Za-zÀ-ú]+([ ]?[a-z]*['-]?[A-Za-zÀ-ú]+)*)$");

  static RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-]?[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}$');
}
