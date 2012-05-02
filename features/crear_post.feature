# coding: utf-8
# language: es
Característica: Crear Post
  
  Como estudiante
  Para compartir información con mis compañeros
  Quiero crear posts en mis grupos

  Escenario: Crear un post en mi grupo
    Dado que un estudiante ha iniciado sesión
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Cuando intente crear un post en el muro de "Cálculo II"
    Entonces el post quedará grabado en el sistema

  Escenario: Crear un post en otro grupo mediante http
    Dado que un estudiante ha iniciado sesión mediante http
    Y que la clase "Cálculo II" ha sido creada
    Pero el estudiante no está matriculado en la materia "Cálculo II"
    Cuando intente crear un post en el muro de "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el post no quedará grabado en el sistema

  Escenario: Ver posts
    Dado que un estudiante ha iniciado sesión
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Y que "Cálculo II" tiene 3 posts en el muro
    Cuando el estudiante acceda al muro de "Cálculo II"
    Entonces podrá ver todos los posts que se han creado en el muro de "Cálculo II"