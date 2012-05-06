# coding: utf-8
# language: es
Característica: Crear Post
  
  Como estudiante
  Para compartir información con mis compañeros
  Quiero crear posts en mis grupos

  Antecedentes:
    Dado que las clases [Cálculo II, OAC, Programación I] han sido creadas
    Y que los estudiantes [fulano@utp.ac.pa, mengano@utp.ac.pa] aparecen como registrados en el sistema
    Y que se han creado las siguientes matrículas:
      | materia         | estudiantes                         |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |

  Escenario: Crear un post público
    Dado que "mengano@utp.ac.pa" escribió un post público
    Cuando "fulano@utp.ac.pa" inicie sesión
    Entonces verá el post de "mengano@utp.ac.pa"

  @wip
  Escenario: Crear un post en mi grupo
    Dado que "fulano@utp.ac.pa" ha iniciado sesión
    Cuando intente crear un post en el muro de "Cálculo II"
    Entonces el post aparecerá en el muro de "Cálculo II"
    Pero no aparecerá en el muro de "Programación I"

  Escenario: Crear un post en otro grupo mediante http
    Dado PENDING
    Dado que un estudiante ha iniciado sesión mediante http
    Y que la clase "Cálculo II" ha sido creada
    Pero el estudiante no está matriculado en la materia "Cálculo II"
    Cuando intente crear un post en el muro de "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el post no quedará grabado en el sistema  

  Escenario: Ver posts de un grupo
    Dado PENDING