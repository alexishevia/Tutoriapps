# coding: utf-8
# language: es
Característica: Administrar Grupos
  
  Como administrador de Tutoriapps
  Para asignar estudiantes a los grupos correctos
  Quiero poder administrar los grupos

  Escenario: Administrador crea un grupo
    Dado que un administrador ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo quedará registrado en el sistema

  Escenario: Estudiante crea un grupo
    Dado que un estudiante ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo no quedará registrado en el sistema

  Escenario: Administrador agrega un estudiante existente a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" ya está registrado
    Y que el estudiante "fulano@utp.ac.pa" no está matriculado en la materia "Cálculo II"
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el estudiante "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  @wip
  Escenario: Administrador agrega un estudiante no existente a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" no está registrado
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el email "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  Escenario: Estudiante se agrega a un grupo
   Dado PENDING