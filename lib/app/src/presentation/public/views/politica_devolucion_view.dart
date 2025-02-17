import 'package:bot_dashboard/app/export_app.dart';

class PoliticaDevolucionView extends StatelessWidget {
  const PoliticaDevolucionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 8.0,
        backgroundColor: AppConfig().appBarColor,
        title: const Text('Política de devoluciones y reembolsos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Visión general',
              'Tenga en cuenta: Ponemos a nuestros clientes en primer lugar y haremos todo lo posible para ayudarlo a resolver cualquier problema. Nuestros clientes nunca están solos y nos enorgullecemos de un servicio de soporte de 5 estrellas. Haremos todo lo posible para resolver cualquier problema con nuestros productos, servicios o sus necesidades de su membresía en general.\n\n'
                  'Recomendamos a todos los clientes que se comuniquen con el soporte de Biosónica la Terapia a través del chat en vivo, el ticket técnico o en soporte@biosonicalaterapia.com, para cualquier asistencia, aclaración, comentarios, problemas, desafíos o ayuda.\n\n'
                  'Resolveremos las cosas y nos aseguraremos de que esté 100% satisfecho y feliz con nuestro servicio.',
            ),
            _buildSection(
              'Reembolsos',
              'Antes de que se otorgue un reembolso, debe permitirnos intentar ayudarlo. Póngase en contacto con nuestro soporte a través de chat, ticket técnico o en soporte@biosonicalaterapia.com y espere de 24 a 72 horas para que nuestro equipo de soporte se comunique con usted. Hacemos todo lo posible para responder mucho más rápido a sus solicitudes.\n\n'
                  'La naturaleza de los medios digitales (Audiovisual) que se pueden descargar al instante hace que no sea reembolsable. No hay «prueba» o «período de gracia» después de suscribirte en cualquier programa biosonica, lo que significa que todas las suscripciones son definitivas. Una vez que se ha suscrito a un servicio de programa biosonica, no hay forma de "devolverlo". Como tal, no se pueden proporcionar reembolsos, podrá tener acceso a su suscripción hasta que finalice su plan de membresía.\n\n'
                  'No se otorgarán reembolsos si simplemente decide no utilizar el programa biosónico al que se suscribe, puede continuar teniendo acceso hasta finalizar su membresía.',
            ),
            _buildSection(
              'No se prevén reembolsos por',
              '• Suscripciones de Membresía VIP Biosónica la Terapia, ya que es un conjunto completo de productos a un precio muy conveniente, que puede cancelar en cualquier momento. Le recomendamos que no compre la Membresía VIP con fines de prueba.\n\n'
                  '• Las renovaciones son estrictamente no reembolsables.\n\n'
                  '• Las ofertas y los descuentos son válidos solo para pedidos futuros y no se pueden utilizar para solicitar reembolsos o reembolsos parciales de compras existentes.',
            ),
            _buildSection(
              'Resumen',
              'Para resumir y aclarar: No se ofrecerán devoluciones/reembolsos por el programa biosónica digital.\n\n'
                  'Consideramos los reembolsos caso por caso.\n\n'
                  'De acuerdo con la legislación de la UE, puede cancelar la compra y recibir un reembolso por cualquier contenido (o servicio) digital comprado en el sitio durante 14 días. Una vez que se ha descargado un producto digital y/o ha comenzado un servicio comprado, los clientes pierden inmediatamente su derecho de desistimiento.',
            ),
            _buildSection(
              'Situaciones de rechazo de reembolso',
              '• Ha cambiado de opinión sobre un artículo/suscripción.\n'
                  '• Compraste un artículo por error y los productos ya fueron enviados o descargados por ti.\n'
                  '• El producto fue comprado por su empleado o asociado a través de su cuenta de PayPal a la que tenía acceso legal.\n'
                  '• El producto no funciona como usted quería.',
            ),
            _buildSection(
              'Notas adicionales',
              'Puede cancelar su suscripción en cualquier momento, sin embargo, no hay reembolsos por cancelación.\n\n'
                  'Independientemente de lo anterior, ponemos a nuestros clientes primero y trabajaremos para ayudarlo con cualquier problema, con nuestros productos, servicios o sus necesidades del Programa Biosónica en general. Recomendamos a todos los clientes que se comuniquen con el soporte de Biosónica la Terapia a través del chat en vivo, el ticket técnico o en soporte@biosonicalaterapia.com, para cualquier asistencia, aclaración, comentarios, problemas, desafíos o ayuda. Resolveremos las cosas y nos aseguraremos de que esté 100% satisfecho y feliz con nuestro servicio.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
