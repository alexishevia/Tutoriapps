# coding: utf-8
# language: es
Característica: Unirse a un grupo 

  Como estudiante
  Para saber quién está conmigo en una clase
  Y poder solicitar ayuda a las personas adecuadas
  Quiero unirme al grupo de una clase específica

  Escenario: Ver Grupos
    Dado que Carlos está inscrito en Calculo II y OAC
    Y que María está inscrita en Calculo II
    Y que Rodolfo no tiene materias inscritas
    Cuando Carlos ingresa a su página principal
    Entonces debe ver Calculo II y OAC entre sus grupos.