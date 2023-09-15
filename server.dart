import 'dart:io';

const hostName = "localhost";

SecurityContext serverContext = SecurityContext()
  ..useCertificateChain('server_chain.pem')
  ..usePrivateKey('server_key.pem', password: 'dartdart')
  ..setTrustedCertificates('client_authority.pem')
  ..setClientAuthorities('client_authority.pem');

void main() {
  HttpServer.bindSecure(hostName, 8081, serverContext,
          backlog: 5, requestClientCertificate: true)
      .then((server) {
    server.listen((HttpRequest request) {
      // Expect.isNotNull(request.certificate);
      // Expect.equals('/CN=user1', request.certificate!.subject);
      request.response.write("Hello");
      request.response.close();
    });
  });
}
