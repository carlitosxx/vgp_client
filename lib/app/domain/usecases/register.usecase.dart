import 'package:vgp_cliente/app/domain/repositories/register.repository.dart';

class GetRegisterUC {
  GetRegisterUC(this.registerRepository);
  final RegisterRepository registerRepository;
  GetRegisterFuture call(
      String firstName, String lastName, String email, String password) async {
    return registerRepository.getRegister(firstName, lastName, email, password);
  }
}
