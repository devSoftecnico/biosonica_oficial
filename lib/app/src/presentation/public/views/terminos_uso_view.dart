import 'package:bot_dashboard/app/export_app.dart';

class TerminosUsoView extends StatelessWidget {
  const TerminosUsoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 8.0,
        backgroundColor: AppConfig().appBarColor,
        title: const Text('Términos de uso'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Términos de uso Biosónica la terapia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSection(
              'Introducción',
              'Lea atentamente los Términos de uso, ya que rigen el uso de los servicios personalizados, (incluido el acceso a los mismos) para escuchar los programas musicales y otros contenidos, incluidos todos los sitios web y aplicaciones de software que incorporan los Términos o se vinculan a ellos (en conjunto, el «Servicio de Biosónica la terapia»)\n\nAl registrarse en el Servicio de Biosonica la terapia, o utilizarlo, usted acepta los Términos. Si no está de acuerdo con los Términos, no debe utilizar el Servicio ni acceder a cualquier Contenido.',
            ),
            _buildSection(
              'Proveedor de servicios',
              'Los Términos son simples y sencillos.',
            ),
            _buildSection(
              'Edad y requisitos de idoneidad',
              'Para utilizar el Servicio y acceder a cualquier Contenido, usted debe:\n\n1.- tener al menos 15 años (o la edad mínima equivalente en su país),\n\n2.- contar con el consentimiento de un padre, madre o tutor si en su país se lo considera menor de edad,\n\n3.- residir en un país en el cual esté disponible el Servicio. Además, usted promete que toda la información de registro que le entregue a Biosónica la terapia, es verdadera, precisa y completa, y se compromete a que esto se mantenga así. Si es menor de edad en su país, su padre, madre o tutor debe aceptar estos Términos en su nombre',
            ),
            _buildSection(
              'El Servicio de Biosónica la terapia',
              'Opciones del Servicio\n\nLe proporcionamos varias opciones en el Servicio. Algunas opciones del Servicio se proporcionan de manera gratuita, mientras que para otras se debe pagar antes de poder acceder a las «Suscripciones pagas». Además, es posible que le ofrezcamos planes promocionales, membresías o servicios especiales, incluidos productos y servicios de terceros. No nos hacemos responsables de los productos y servicios proporcionados por terceros.\n\nEl Servicio ilimitado puede no estar disponible para todos los usuarios. Le explicaremos qué servicios están disponibles para usted en el momento en que se registre en dichos servicios. Si cancela su suscripción al Servicio ilimitado, o si su suscripción se ve interrumpida (por ejemplo, si cambia sus detalles de pago), es posible que no se pueda volver a suscribir al Servicio ilimitado. Tenga en cuenta que es posible que el Servicio ilimitado deje de proporcionarse en el futuro; si esto es así, no se le seguirá cobrando el Servicio.',
            ),
            _buildSection(
              'Aplicaciones, dispositivos y software de código abierto',
              'Es posible que el Servicio se integre en sus aplicaciones personales y también en computadoras personales, teléfonos celulares, tabletas, dispositivos portátiles, bocinas y otros dispositivos o que interactúe con ellos.',
            ),
            _buildSection(
              'Limitaciones y modificaciones del Servicio',
              'Realizamos todos los esfuerzos razonables para mantener el Servicio en funcionamiento y proporcionarle una experiencia de audio personalizada y envolvente. Sin embargo, las ofertas de nuestro servicio y su disponibilidad pueden cambiar de vez en cuando, hacia usted, por ejemplo:\n\nEs posible que los Servicios, experimenten interrupciones temporales debido a dificultades técnicas, mantenimiento, pruebas o actualizaciones, incluidas las necesarias para reflejar los cambios en las leyes y los requisitos normativos pertinentes.\n\nNuestro objetivo es evolucionar y mejorar nuestros Servicios de forma constante, por lo que es posible que modifiquemos el Servicio en parte o su totalidad (incluidas funciones características, planes de suscripción y ofertas promocionales en particular), lo suspendamos o dejemos de proporcionarlo (de manera temporal o permanente es caso necesario).\n\nBiosónica la terapia, no está obligado a proporcionar ningún contenido específico mediante el Servicio y es posible que se eliminen o se agreguen programas, videos, podcasts y otros Contenidos en particular sin previo aviso.\n\nBiosónica la terapia, no tiene ninguna responsabilidad ante usted, ni ninguna obligación de proporcionarle un reembolso en relación con cortes o fallas de internet u otros servicios, causados por las acciones de las autoridades gubernamentales, de otros terceros o de eventos que escapen a nuestro control.',
            ),
            _buildSection(
              'Cuenta y contraseña',
              'Es posible crear una cuenta para el Servicio de forma parcial o total. Su nombre de usuario y contraseña son únicamente para su uso personal y deben ser confidenciales. Usted comprende que es responsable de todo uso (incluido el uso no autorizado) de su nombre de usuario y contraseña. Notifique de forma inmediata a nuestro equipo de servicio de atención al cliente si perdió o le robaron su nombre de usuario o contraseña, o si piensa que alguien ingresó a su cuenta sin autorización.',
            ),
            _buildSection(
              'Sus derechos de uso del Servicio',
              'Las aplicaciones de software de Biosónica la terapia, el Contenido tienen licencia, no se venden ni transfieren a usted, Biosónica la terapia retiene la propiedad de todas las copias en las aplicaciones de software de y el Contenido, incluso después de instalarlos en sus Dispositivos.',
            ),
            _buildSection(
              'Derechos de propiedad de Biosónica la terapia',
              'El Servicio y su Contenido son propiedad de Biosónica la terapia. Todas las marcas comerciales, las marcas de servicio, los nombres registrados, los logotipos, las portadas, los nombres de dominio, los programas musicales (reediciones registradas ante indautor México), cualquier otra música que sea de dominio, y cualquier otra función de la marca, son propiedad exclusiva de Biosónica la terapia, no podrá descargar ninguno de nuestros materiales, son exclusivamente para escucharlos por el tiempo pagado. Los Términos no le otorgan ningún derecho para utilizar ninguna de las Funciones de la marca, ya sea para uso comercial o no comercial.',
            ),
            _buildSection(
              'Pagos',
              'Pagos\n\npagando una tarifa de suscripción adelantada de forma mensual o mediante otro intervalo recurrente establecido antes de su compra;\n\nmediante un prepago que le otorgue acceso al Servicio durante un período específico («Período pre pagado»).\nLas tarifas de impuestos se calculan en función de la información que proporcione y la tarifa pertinente en el momento de su cobro mensual.\n\nCambios de precios y tarifas\n\nEs posible que Biosónica la terapia cambie de vez en cuando el precio de las Suscripciones pagadas, incluidos las tarifas de suscripción recurrentes, los Períodos pre pagados cambios de precio comenzarán a tener vigencia a principios del próximo período de suscripción, después de la fecha del cambio de precio. Si sigue utilizando el Servicio, después de que el cambio de precio comience a tener vigencia, usted acepta el nuevo precio, sujeto a las leyes pertinentes. Si no está de acuerdo con el cambio de precio, puede rechazarlo mediante la cancelación de su suscripción a la Suscripción pagada correspondiente, antes de que el cambio de precio comience a tener vigencia.\n\nLas tarifas de impuestos se basan en las tarifas pertinentes en el momento de su cobro mensual. Estas cantidades pueden cambiar a través del tiempo según los requisitos de impuestos locales de su país, estado, territorio o incluso ciudad. Cualquier cambio en las tarifas de impuestos se aplicará de forma automática de acuerdo con la información de cuenta que usted proporcione.\n\nSi compra una Suscripción pagada sin Prueba, usted acepta que tiene siete (7) días a partir de la compra para revocarla por cualquier motivo y debe pagarnos por los servicios que le proporcionamos hasta el momento en que nos notifique que cambió de opinión. Usted nos otorga su consentimiento de forma expresa para que le proporcionemos el servicio inmediatamente después de la compra, para que pierda su derecho de revocación y autoriza a Biosónica la terapia a cobrarle de forma automática cada mes hasta que cancele el servicio.',
            ),
            _buildSection(
              'Pautas del usuario',
              'Establecimos pautas de uso del Servicio, para asegurar que todos puedan disfrutar el Servicio. Cuando utiliza el Servicio de Biosónica la terapia debe cumplir con las Pautas de usuario, así como con las leyes, normas y regulaciones pertinentes, y respetar la propiedad intelectual, la privacidad y otros derechos de terceros.',
            ),
            _buildSection(
              'El contenido que usted publica en el servicio',
              'Los usuarios, pueden publicar resultados, subir o aportar contenido al Servicio de («Contenido de usuario»). Para evitar dudas, el término «Contenido de usuario» incluye toda la información, que se le solicite personal, para el registro de su persona y sus avances terapéuticos para uso de investigación en las ciencias nuevas de la salud y el desarrollo (incluida a la Comunidad de soporte de Biosónica la terapia).\n\nUsted promete que, con respecto al Contenido de usuario que publica en,\n\nes propietario y responsable de dicho Contenido de usuario o tiene el derecho de publicarlo\ndicho Contenido de usuario o el uso que le da NSZ es confidencial, y es para llevar un control y avances de los programas trabajados.',
            ),
            _buildSection(
              'Su dispositivo',
              'También nos otorga el derecho de permitir al Servicio de Biosónica la terapia, usar el procesador, ancho de banda y hardware en su Dispositivo para facilitar el funcionamiento del Servicio.',
            ),
            _buildSection(
              'Experiencia de contenido',
              'Todo el contenido publicado en la plataforma está debidamente registrado en indautor, instancia de registro de autoría en México, y posteriormente en USA.\n\nNo puede disponer de el sin el permiso correspondiente por escrito del autor.',
            ),
            _buildSection(
              'Comunidad de soporte',
              'La Comunidad de soporte, ofrece un lugar para el debate y el intercambio de información, consejos y otros materiales relacionados con el Servicio. Al usar la Comunidad de soporte, usted acepta los Términos de la comunidad.',
            ),
            _buildSection(
              'Servicio de atención al cliente, información, preguntas, quejas',
              'Para obtener asistencia con preguntas relacionadas con la cuenta o los pagos («Consultas de atención al cliente»), utilice los recursos del Servicio de atención al cliente enumerados en la sección de nuestro sitio web.\n\nSi tiene preguntas acerca del Servicio de Biosónica la terapia o los Términos (incluido cualquier término y condición adicional incorporados en este acuerdo), comuníquese con el Servicio de atención al cliente en la correspondiente de nuestro sitio web.',
            ),
            _buildSection(
              'Descargos de responsabilidad de garantía',
              'Biosónica la terapia, realizará todos los esfuerzos razonables para proporcionar el Servicio de acuerdo con las especificaciones del Servicio que proporcione; sin embargo, sujeto a eso, el Servicio se proporciona «tal cual» y «según esté disponible», sin garantías de ningún tipo, ya sean explícitas, implícitas o legales. Además, todos los dueños del contenido renuncian a cualquier garantía explícita, implícita y legal en relación con el contenido, incluidas las garantías de calidad satisfactoria, la máxima medida posible según las leyes pertinentes.\n\nA modo de aclaración, los términos no limitan la responsabilidad de por fraude, tergiversación fraudulenta, muerte o heridas personales en la medida que las leyes pertinentes prohíban tal limitación o cualquier responsabilidad que, según las leyes pertinentes, pueda no estar limitada o excluida.',
            ),
            _buildSection(
              'Indemnización',
              'Usted acepta indemnizar y evitar que Biosónica la terapia reciba daños de y contra cualquier pérdida, daños y gastos razonables, directos y esperables (incluidos los honorarios y costos razonables de abogados) que sufra o incurra provenientes de lo siguiente: 1.- su infracción de cualquiera de los Términos (incluidos los términos y condiciones adicionales incorporados en este acuerdo); 2.- cualquier Contenido de usuario que usted publique o contribuya de otra manera; 3.- cualquier actividad en la que usted interactúe en el Servicio o a través del mismo; y 4.- s',
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
