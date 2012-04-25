# coding: utf-8
# language: es
Característica: Administrar Grupos
  
  Como administrador
  Para asignar estudiantes a sus respectivos grupos
  Quiero poder administrar los grupos

  Escenario: Administrador crea un grupo
    Dado que un administrador ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo quedará registrado en el sistema

  Escenario: Estudiante crea un grupo
    Dado que un estudiante ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo no quedará registrado en el sistema

  Escenario: Administrador agrega un estudiante a un grupo
    Dado PENDIENTE