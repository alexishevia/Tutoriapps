# coding: utf-8
# language: es
Característica: Responder a un post

  Como estudiante
  Para ayudar a mis compañeros con sus dudas
  Quiero poder responder a sus preguntas en los post

  Antecedentes:
    Dado que los grupos [Cálculo II, OAC, Programación I] han sido creados
    Y que los usuarios [fulano@utp.ac.pa, mengano@utp.ac.pa] han sido creados y confirmados
    Y que las siguientes matrículas han sido creadas:
      | grupo           | usuarios                            |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |
    Y se ha creado 1 post en el grupo "Cálculo II"
    Y que el usuario "mengano@utp.ac.pa" ha iniciado sesión


  @javascript
  Escenario: Responder un post
    Cuando intente responder un post
    Entonces la respuesta será enviada

  @javascript
  Escenario: Responder mensaje en blanco
    Cuando intente responder con un mensaje en blanco
    Entonces no podrá enviar la respuesta