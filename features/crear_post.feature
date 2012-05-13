# coding: utf-8
# language: es
Característica: Crear Post
  
  Como estudiante
  Para compartir información con mis compañeros
  Quiero crear posts en mis grupos

  Antecedentes:
    Dado que los grupos [Cálculo II, OAC, Programación I] han sido creados
    Y que los usuarios [fulano@utp.ac.pa, mengano@utp.ac.pa] han sido creados
    Y que las siguientes matrículas han sido creadas:
      | materia         | estudiantes                         |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |

  Escenario: Crear un post público
    Cuando "mengano@utp.ac.pa" escriba un post público
    Entonces el post aparecerá en el muro de "mengano@utp.ac.pa"

  Escenario: Crear un post en un grupo
    Dado que "fulano@utp.ac.pa" ha iniciado sesión
    Cuando intente crear un post en el muro de "Cálculo II"
    Entonces el post aparecerá en el muro de "Cálculo II"
    Pero el post no aparecerá en el muro de "Programación I"