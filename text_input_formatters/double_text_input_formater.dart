class DoubleQuantityTextInputFormater extends TextInputFormatter {
  String? text;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print(newValue.text);
    List list = newValue.text.split('');
    list.remove(',');
    bool isFirstZero = list.first == '0';
    bool isAllZero = list.every((element) => element == '0');
    int? lastDigitIsNumber;
    try {
      lastDigitIsNumber = int.parse(list.last);
    } catch (e) {
      // print(e);
    }
    if (lastDigitIsNumber != null) {
      if (oldValue.text.isEmpty) {
        text = '0,00';
      } else if (oldValue.text.length > newValue.text.length) {
        if (!isAllZero) {
          if (list.length < 3) {
            list.insert(0, '0');
          }
          list.insert(list.length - 2, ',');
          text = list.join();
        } else {
          text = '0,00';
        }
      } else {
        if (isFirstZero) {
          list.removeAt(0);
        }
        list.insert(list.length - 2, ',');
        text = list.join();
      }
    } else {
      text = oldValue.text;
    }

    return TextEditingValue(
        text: text!,
        selection: TextSelection.collapsed(offset: text?.length ?? 0));
  }
}
