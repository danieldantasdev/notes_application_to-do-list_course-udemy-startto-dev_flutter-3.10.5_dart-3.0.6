class MethodsGlobal {
  String convertDate(DateTime dateTime) {
    return '${dateTime.toLocal().day < 10 ? ('0${dateTime.toLocal().day}') : dateTime.toLocal().day}/'
        '${dateTime.toLocal().month < 10 ? ('0${dateTime.toLocal().month}') : dateTime.toLocal().month}/'
        '${dateTime.toLocal().year} - '
        '${dateTime.toLocal().hour < 10 ? ('0${dateTime.toLocal().hour}') : dateTime.toLocal().hour}:'
        '${dateTime.toLocal().minute < 10 ? ('0${dateTime.toLocal().minute}') : dateTime.toLocal().minute}';
  }
}
