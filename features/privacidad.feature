# coding: utf-8
# language: es
Característica: Privacidad

  Como estudiante
  Para expresarme con seguridad
  Quiero que mis compañeros de clase sean los únicos que puedan ver lo que comparta

  @javascript
  Escenario: Registrarse con correo de la UTP
    Cuando un usuario intente registrarse usando un correo de la UTP
    Entonces se le enviará un link de confirmación a su correo
    Y quedará registrado en el sistema
    Pero no aparecerá como verificado

  @javascript
  Escenario: Registrarse con otro correo
    Cuando un usuario intente registrarse usando un correo que no es de la UTP
    Entonces el usuario no quedará registrado en el sistema

  @javascript
  Escenario: Link de confirmación
    Dado que un usuario se registró
    Y se le envió un link de confirmación
    Cuando el usuario haga clic en el link de confirmación
    Entonces aparecerá como verificado

  @javascript
  Escenario: Iniciar sesión con correo verificado
    Dado que un usuario ha sido verificado
    Cuando intente iniciar sesión
    Entonces iniciará sesión sin problemas

  @javascript
  Escenario: Iniciar sesión con correo no verificado
    Dado que un usuario se registró
    Pero aún no ha sido verificado
    Cuando intente iniciar sesión
    Entonces no podrá iniciar sesión

  @javascript
  Escenario: Ver mis grupos
    Dado que un usuario ha iniciado sesión
    Y que el usuario ya fue agregado a 3 grupos
    Cuando visite la página de inicio
    Entonces podrá ver los 3 grupos a los que pertenece

  @javascript @wip
  Escenario: Usuario con grupos creados se registra
    Dado que los grupos [Cálculo II, OAC] han sido creados
    Y que el usuario "fulano@utp.ac.pa" ya fue agregado a los grupos [Cálculo II, OAC]
    Cuando el usuario "fulano@utp.ac.pa" llene y envíe el formulario de registro
    Y el usuario haga clic en el link de confirmación
    Y visite la página de inicio
    Entonces podrá ver los 2 grupos a los que pertenece