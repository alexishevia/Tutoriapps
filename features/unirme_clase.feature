# coding: utf-8
# language: es
Característica: Unirme a una Clase
  
  Como estudiante
  Para saber quién está conmigo en una clase
  Y poder solicitar ayuda a las personas adecuadas
  Quiero poder unirme al grupo de una clase específica

  Escenario: Administrador crea un grupo
    Dado que un administrador ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo quedará registrado en el sistema

  @wip
  Escenario: Estudiante crea un grupo
    Dado que un estudiante ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo no quedará registrado en el sistema