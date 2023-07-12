class MethodsGlobal {
  String convertDate(DateTime dateTime) {
    return '${dateTime.toLocal().day}/'
        '${dateTime.toLocal().month < 10 ? ('0${dateTime.toLocal().month}') : dateTime.toLocal().month}/'
        '${dateTime.toLocal().year} - ${dateTime.toLocal().hour}:${dateTime.toLocal().minute}';
  }
}
