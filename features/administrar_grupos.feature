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

  @javascript @wip
  Escenario: Administrador crea un grupo
    Cuando intente crear el grupo "Física I"
    Entonces el grupo "Física I" aparecerá 1 vez en la lista de grupos

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
    Y cierre el popup con el mensaje de error
    Entonces el usuario "foo@bar.com" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega dos veces un usuario registrado a un grupo
    Dado que el usuario "fulano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente agregar el usuario "fulano@utp.ac.pa" al grupo "Cálculo II"
    Y cierre el popup con el mensaje de error
    Entonces el usuario "fulano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega dos veces un usuario no registrado a un grupo
    Dado que el usuario "mengano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente agregar el usuario "mengano@utp.ac.pa" al grupo "Cálculo II"
    Y cierre el popup con el mensaje de error
    Entonces el usuario "mengano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  @javascript
  Escenario: Administrador saca un usuario registrado de un grupo
    Dado que el usuario "fulano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente sacar al usuario "fulano@utp.ac.pa" del grupo "Cálculo II"
    Y confirme el popup con el mensaje de advertencia
    Entonces el usuario "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador saca un usuario no registrado de un grupo
    Dado que el usuario "mengano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente sacar al usuario "mengano@utp.ac.pa" del grupo "Cálculo II"
    Y confirme el popup con el mensaje de advertencia
    Entonces el usuario "mengano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador edita el nombre de un grupo
    Cuando intente cambiar el nombre del grupo "Cálculo II" a "Mecánica"
    Entonces el grupo "Mecánica" aparecerá 1 vez en la lista de grupos
    Y el grupo "Cálculo II" no aparecerá en la lista de grupos

  @javascript
  Escenario: Administrador elimina un grupo
    Cuando intente eliminar el grupo "Cálculo II"
    Y confirme el popup con el mensaje de advertencia
    Entonces el grupo "Cálculo II" no aparecerá en la lista de grupos