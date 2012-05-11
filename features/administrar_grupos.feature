# coding: utf-8
# language: es
Característica: Administrar Grupos
  
  Como administrador de Tutoriapps
  Para asignar los usuarios a los grupos correctos
  Quiero poder administrar los grupos

  Antecedentes: Administrador ha iniciado sesión
    Dado que el grupo "Cálculo II" ha sido creado
    Y que el usuario "fulano@utp.ac.pa" ha sido creado y confirmado
    Y que el usuario "admin@utp.ac.pa" ha sido creado, confirmado y concedido permisos de administrador
    Y que el usuario "admin@utp.ac.pa" ha iniciado sesión

  @javascript
  Escenario: Administrador crea un grupo
    Cuando intente crear un grupo nuevo
    Entonces el grupo quedará registrado en el sistema

  @javascript
  Escenario: Administrador agrega un usuario registrado a un grupo
    Cuando intente agregar el usuario "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el usuario "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un usuario no registrado a un grupo
    Cuando intente agregar el usuario "mengano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el usuario "mengano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un usuario inválido a un grupo
    Cuando intente agregar el usuario "foo@bar.com" al grupo "Cálculo II"
    Entonces el usuario "foo@bar.com" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega dos veces un usuario registrado a un grupo
    Dado que el usuario "fulano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente agregar el usuario "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el usuario "fulano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega dos veces un usuario no registrado a un grupo
    Dado que el usuario "mengano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente agregar el usuario "mengano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el usuario "mengano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  @javascript
  Escenario: Administrador saca un usuario registrado de un grupo
    Dado que el usuario "fulano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente sacar al usuario "fulano@utp.ac.pa" del grupo "Cálculo II"
    Entonces el usuario "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega y saca un usuario registrado de un grupo
    Cuando intente agregar el usuario "fulano@utp.ac.pa" al grupo "Cálculo II"
    Cuando intente sacar al usuario "fulano@utp.ac.pa" del grupo "Cálculo II"
    Entonces el usuario "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador saca un usuario no registrado de un grupo
    Dado que el usuario "mengano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente sacar al usuario "mengano@utp.ac.pa" del grupo "Cálculo II"
    Entonces el usuario "mengano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"