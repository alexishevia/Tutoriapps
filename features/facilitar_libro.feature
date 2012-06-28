# coding: utf-8
# language: es
Característica: Facilitar un Libro

  Como dueño de un libro que ya no utilizo
  Para que el libro no se pierda
  Quiero poder facilitarlo a otra persona

  Antecedentes:
    Dado que los grupos [Cálculo II, Programación I] han sido creados
    Y que el usuario "fulano@utp.ac.pa" ha sido creado y confirmado
    Y que las siguientes matrículas han sido creadas:
      | grupo           | usuarios          |
      | Cálculo II      | fulano@utp.ac.pa  |
      | Programación I  | fulano@utp.ac.pa  |

  @javascript
  Escenario: Facilitar un libro públicamente
    Dado que el usuario "fulano@utp.ac.pa" ha iniciado sesión
    Y que está viendo el muro "Inicio"
    Y eligió la opción de mostrar sólo "Libros"
    Cuando facilite un libro
    Entonces el libro aparecerá en el muro "Inicio"
    Pero el libro no aparecerá en el muro "Cálculo II"
    Y el libro no aparecerá en el muro "Programación I"

  @javascript
  Escenario: Facilitar un libro dentro de un grupo
    Dado que el usuario "fulano@utp.ac.pa" ha iniciado sesión
    Y que está viendo el muro "Cálculo II"
    Y eligió la opción de mostrar sólo "Libros"
    Cuando facilite un libro
    Entonces el libro aparecerá en el muro "Cálculo II"
    Y el libro aparecerá en el muro "Inicio"
    Pero el libro no aparecerá en el muro "Programación I"