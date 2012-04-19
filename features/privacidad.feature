# coding: utf-8
# language: es
Característica: Privacidad

  Como estudiante
  Para expresarme con seguridad
  Quiero que mis compañeros de clase sean los únicos que puedan ver lo que comparta

  Escenario: Registrarse con correo de la UTP
    Cuando un usuario intente registrarse usando un correo de la UTP
    Entonces se le enviará un link de confirmación a su correo
    Y quedará registrado en el sistema
    Pero no aparecerá como verificado

  Escenario: Registrarse con otro correo 
    Cuando un usuario intente registrarse usando un correo que no es de la UTP
    Entonces recibirá un mensaje de error
    Y no quedará registrado en el sistema

  Escenario: Link de confirmación
    Dado que un usuario se registró
    Y se le envió un link de confirmación
    Cuando el usuario haga clic en el link de confirmación
    Entonces aparecerá como verificado

  @wip
  Escenario: Iniciar sesión con correo verificado
    Dado que un usuario ha sido verificado
    Cuando intente iniciar sesión
    Entonces iniciará sesión sin problemas

  Escenario: Iniciar sesión con correo no verificado
    Dado que un usuario aún no ha sido verificado
    Cuando intente iniciar sesión
    Entonces no podrá iniciar sesión

  Escenario: Acceder a un grupo que pertenezco
    Dado que un usuario ha iniciado sesión
    Y que el usuario está matriculado en la materia "Cálculo II"
    Cuando intente acceder al grupo de "Cálculo II"
    Entonces podrá ver toda la información del grupo

  Escenario: Acceder a un grupo que no pertenezco
    Dado que un usuario ha iniciado sesión
    Pero el usuario no está matriculado en la clase "Cálculo II"
    Entonces no podrá ver la información del grupo