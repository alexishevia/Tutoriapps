# coding: utf-8
# language: es
Característica: Compartir Información Pizarra

  Como estudiante
  Para ayudar a mis compañeros que no asistieron o que no copian rápido
  Quiero poder compartir una foto de la pizarra

  Antecedentes:
    Dado que los grupos [Cálculo II, OAC, Programación I] han sido creados
    Y que los usuarios [fulano@utp.ac.pa, mengano@utp.ac.pa] han sido creados y confirmados
    Y que las siguientes matrículas han sido creadas:
      | grupo           | usuarios                            |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |
    Y que el usuario "fulano@utp.ac.pa" ha iniciado sesión
    Y que está viendo el muro "Cálculo II"
    Y eligió la opción de mostrar sólo "Pizarra"

  @javascript
  Escenario: Compartir pizarra
    Cuando intente compartir una pizarra
    Entonces la pizarra será compartida

  @javascript
  Escenario: Dejar fecha en blanco
    Cuando intente compartir una pizarra sin colocarle fecha
    Entonces no podrá compartir la pizarra

  @javascript
  Escenario: Archivo no seleccionado
    Cuando intente compartir una pizarra sin seleccionar el archivo
    Entonces no podrá compartir la pizarra