import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';

String mapFailureToString(HttpRequestFailure failure) {
  return failure.when(
      network: () => 'Hubo un problema de red',
      notFound: () => 'No se encontro el recurso',
      server: () => 'Hubo un problema en el servidor',
      unauthorized: () => 'No estas autorizado',
      badRequest: () => 'La solicitud no puede ser procesado',
      local: () => 'Hubo un problema local o desconocido');
}
