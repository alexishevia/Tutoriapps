# coding: utf-8
# language: es
Característica: Unirme a una Clase
  
  Como estudiante
  Para saber quién está conmigo en una clase
  Y poder solicitar ayuda a las personas adecuadas
  Quiero poder unirme al grupo de una clase específica

  @wip
  Escenario: Administrador crea un grupo
    Dado que un administrador ha iniciado sesión
    Cuando intenta crear un grupo nuevo
    Entonces el grupo queda registrado en el sistema

  Escenario: Estudiante crea un grupo
    Dado que un estudiante ha iniciado sesión
    Cuando intenta crear un grupo nuevo
    Entonces recibirá un mensaje de error
    Y el grupo no quedará registrado en el sistema