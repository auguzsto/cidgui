import 'package:cidgui/src/repository/domain_repository.dart';

class DomainController {
  final domainRepository = DomainRepository();

  //Add domain
  Future<void> add(String name) async {
    await domainRepository.add(name);
  }

  //Remove domain
  Future<void> deleteByName(String name) async {
    await domainRepository.deleteByName(name);
  }

  //List
  Future<List<Map<String, dynamic>>> all() async {
    return await domainRepository.all();
  }
}
