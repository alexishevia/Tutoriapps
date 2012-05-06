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

  Escenario: Crear un post en mi grupo
    Dado que "fulano@utp.ac.pa" ha iniciado sesión
    Cuando intente crear un post en el muro de "Cálculo II"
    Entonces el post aparecerá en el muro de "Cálculo II"
    Pero el post no aparecerá en el muro de "Programación I"

  Escenario: Crear un post en otro grupo mediante http
    Dado que "mengano@utp.ac.pa" ha iniciado sesión mediante http
    Cuando intente crear un post en el muro de "Programación I" mediante http
    Entonces recibirá el status 403
    Y el post no quedará grabado en el sistema

  Escenario: Ver todos los posts
    Dado que "Cálculo II" tiene 4 posts en el muro
    Y que "OAC" tiene 2 posts en el muro
    Y que "Programación I" tiene 1 psot en el muro
    Y que "fulano@utp.ac.pa" escribió 2 posts públicos
    Cuando "mengano@utp.ac.pa" inicie sesión
    Y visite el grupo "Todos"
    Entonces verá 9 posts 