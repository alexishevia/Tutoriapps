# coding: utf-8
# language: es
Característica: Administrar Grupos (Evil)
  
  Como hacker
  Para pasarle por alto a las restricciones de Tutoriapps
  Quiero poder modificar los grupos mediante http

  Antecedentes: Estudiante ha iniciado sesión
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" ha sido creado
    Y que el estudiante "hacker@utp.ac.pa" ha sido creado y confirmado
    Y que el estudiante "hacker@utp.ac.pa" ha iniciado sesión mediante http

  Escenario: Estudiante crea un grupo mediante http
    Cuando intente crear un grupo nuevo mediante http
    Entonces recibirá el status 403
    Y el grupo no quedará registrado en el sistema

  Escenario: Estudiante agrega a otro estudiante a un grupo mediante http
    Dado que el estudiante está matriculado en la materia "Cálculo II"
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el estudiante "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II" en el sistema

  Escenario: Estudiante se auto-agrega a un grupo mediante http    
    Cuando intente agregarse al grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y no aparecerá dentro del grupo "Cálculo II" en el sistema

  Escenario: Estudiante elimina a otro estudiante de un grupo mediante http
    Dado PENDING