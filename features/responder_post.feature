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
  Escenario: Ver post sin comentarios
    Dado que un post no ha recibido comentarios
    Cuando aparezca en el muro
    Entonces se podrá observar que aún no tiene comentarios

  @javascript
  Escenario: Ver post con 1 o 2 comentarios
    Dado que un post ha recibido 1 comentario
    Cuando aparezca en el muro
    Entonces se podrá leer el comentario

  @javascript
  Escenario: Ver post con más de 2 comentarios
    Dado que un post ha recibido 5 comentarios
    Cuando aparezca en el muro
    Entonces se podrán leer los últimos 2 comentarios
    Y aparecerá la opción de ver todos los comentarios

  @javascript
  Escenario: Responder a un post que no tiene comentarios
    Dado que un post no ha recibido comentarios
    Cuando intente agregar el primer comentario
    Entonces el comentario quedará publicado

  @javascript
  Escenario: Responder a un post que tiene comentarios
    Dado que un post ha recibido 2 comentarios
    Cuando intente agregar un comentario
    Entonces el comentario quedará publicado

  @javascript
  Escenario: Responder mensaje en blanco
    Dado que un post ha recibido 2 comentarios
    Cuando intente agregar un comentario en blanco
    Entonces no podrá enviar la respuesta