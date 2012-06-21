# coding: utf-8
# language: es
Característica: Compartir Información Tablero

  Como estudiante
  Para ayudar a mis compañeros que no asistieron o que no copian rápido
  Quiero poder compartir una foto del tablero

  Antecedentes:
    Dado que los grupos [Cálculo II, OAC, Programación I] han sido creados
    Y que los usuarios [fulano@utp.ac.pa, mengano@utp.ac.pa] han sido creados y confirmados
    Y que las siguientes matrículas han sido creadas:
      | grupo           | usuarios                            |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |
    Y que el usuario "fulano@utp.ac.pa" ha iniciado sesión

  @javascript @wip
  Escenario: Compartir foto
    Dado que está viendo el muro "Cálculo II"
    Y eligió la opción de mostrar solo "Pizarra"
    Cuando intente compartir una foto
    Entonces la foto será compartida