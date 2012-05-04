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
  Escenario: Ver todos los posts
    Dado PENDING
    Dado que las clases ["Cálculo II", "OAC"] han sido creadas
    Y que los estudiantes ["fulano@utp.ac.pa", "mengano@utp.ac.pa"] aparecen como registrados en el sistema
    
    Y "fulano@utp.ac.pa" ha escrito 2 posts públicos
    Y "mengano@utp.ac.pa" ha escrito 1 post público
    Y "mengano@utp.ac.pa" ha escrito 1 post en "Cálculo II"
    Y "mengano@utp.ac.pa" ha escrito 2 post en "Cálculo II"

    Dado que un estudiante ha iniciado sesión
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Y que el estudiante está matriculado en la materia "OAC"
    Pero el estudiante no está matriculado en la materia "Programación IV"
    Y que "Cálculo II" tiene 3 posts en el muro
    Y que "OAC" tiene 2 posts en el muro
    Y que "Programación IV" tiene 4 posts en el muro
    Cuando acceda a la página de inicio
    Entonces podrá ver todos los posts que se han creado en el muro de "Cálculo II"
    Y podrá ver todos los posts que se han creado en el muro de "OAC"
    Pero no podrá ver los posts que se han creado en el muro de "Programación IV"

  Escenario: Crear un post en mi grupo
    Dado PENDING
    Dado que un estudiante ha iniciado sesión
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Cuando intente crear un post en el muro de "Cálculo II"
    Entonces el post quedará grabado en el sistema

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