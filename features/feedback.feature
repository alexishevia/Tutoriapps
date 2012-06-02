# coding: utf-8
# language: es
Característica: Feedback

  Como programador
  Para mejorar la plataforma
  Quiero recibir información de los usuarios

  Antecedentes:
    Dado que el usuario "fulano@utp.ac.pa" ha sido creado y confirmado
    Y que el usuario "fulano@utp.ac.pa" ha iniciado sesión

  @javascript
  Escenario: Dejar un mensaje de feedback
    Cuando intente mandar un mensaje de feedback
    Entonces el mensaje será enviado

  @javascript
  Escenario: Enviar mensaje en blanco
    Cuando intente mandar un mensaje de feedback en blanco
    Entonces no podrá mandar el mensaje