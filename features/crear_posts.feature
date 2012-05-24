# coding: utf-8
# language: es
Característica: Crear Posts
  
  Como estudiante
  Para compartir información con mis compañeros
  Quiero crear posts en mis grupos

  Antecedentes:
    Dado que los grupos [Cálculo II, OAC, Programación I] han sido creados
    Y que los usuarios [fulano@utp.ac.pa, mengano@utp.ac.pa] han sido creados y confirmados
    Y que las siguientes matrículas han sido creadas:
      | grupo           | usuarios                            |
      | Cálculo II      | fulano@utp.ac.pa, mengano@utp.ac.pa |
      | OAC             | mengano@utp.ac.pa                   |
      | Programación I  | fulano@utp.ac.pa                    |

  @javascript @wip
  Escenario: Crear un post público
    Dado que el usuario "mengano@utp.ac.pa" ha iniciado sesión
    Y está viendo el muro "Todos"
    Cuando escriba un post
    Entonces el post aparecerá en el muro "Todos"
    Pero el post no aparecerá en el muro "Cálculo II"
    Y el post no aparecerá en el muro "OAC"

  @javascript
  Escenario: Crear un post dentro de un grupo
    Dado que el usuario "fulano@utp.ac.pa" ha iniciado sesión
    Y está viendo el muro "Cálculo II"
    Cuando escriba un post
    Entonces el post aparecerá en el muro "Cálculo II"
    Y el post aparecerá en el muro "Todos"
    Pero el post no aparecerá en el muro "Programación I"