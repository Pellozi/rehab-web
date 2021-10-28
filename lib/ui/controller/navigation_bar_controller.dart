import 'package:get/get.dart';
import 'package:rehab_web/ui/data/datas.dart';

class NavigationBarController extends GetxController with StateMixin {
  var index = 0.obs;
  var password = ''.obs;
  var medicines = <Item>[].obs;
  var generalItems = <Item>[].obs;
  var nutritionalItems = <Item>[].obs;
  var workoutItems = <Item>[].obs;
  var doctors = <Item>[].obs;
  @override
  void onInit() {
    doctors.add(new Item('João da silva', value: 'Médico'));
    doctors.add(new Item('Amanda', value: 'Enfermeira'));
    doctors.add(new Item('Ana Paula', value: 'Nutricionista'));
    doctors.add(new Item('Joana Rocha', value: 'Educadora física'));

    medicines.add(new Item('Ibupofreno', value: '8h'));
    medicines.add(new Item('Paracetamol', value: '8h'));

    nutritionalItems.add(new Item('Arroz', value: '300g'));
    nutritionalItems.add(new Item('Feijão', value: '250g'));

    workoutItems.add(new Item('Caminhar', value: '500m'));
    workoutItems.add(new Item('Polichinelo', value: '10x3'));

    generalItems.add(new Item('Trocar o curativo todos os dias'));
    generalItems.add(new Item('Medir glicose'));
    generalItems.add(new Item('Medir pressão arterial'));
    generalItems.add(new Item('Medir o nivel de bem-estar'));

    super.onInit();
  }
}
