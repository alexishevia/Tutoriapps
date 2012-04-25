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

  Escenario: Estudiante crea un grupo
    Dado que un estudiante ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo no quedará registrado en el sistema

  Escenario: Administrador agrega un estudiante a un grupo

  Escenario: Acceder a un grupo que pertenezco
    Dado que un estudiante ha iniciado sesión
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Cuando intente acceder al grupo "Cálculo II"
    Entonces podrá ver la información del grupo "Cálculo II"

  Escenario: Acceder a un grupo que no pertenezco
    Dado que un estudiante ha iniciado sesión
    Y la clase "Cálculo II" ha sido creada
    Pero el estudiante no está matriculado en la materia "Cálculo II"
    Cuando intente acceder al grupo "Cálculo II"
    Entonces no podrá ver la información del grupo

  Escenario: Ver mis grupos