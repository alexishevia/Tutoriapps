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
    Entonces el usuario no quedará registrado en el sistema

  Escenario: Link de confirmación
    Dado que un usuario se registró
    Y se le envió un link de confirmación
    Cuando el usuario haga clic en el link de confirmación
    Entonces aparecerá como verificado

  Escenario: Iniciar sesión con correo verificado
    Dado que un usuario ha sido verificado
    Cuando intente iniciar sesión
    Entonces iniciará sesión sin problemas

  Escenario: Iniciar sesión con correo no verificado
    Dado que un usuario se registró
    Pero aún no ha sido verificado
    Cuando intente iniciar sesión
    Entonces no podrá iniciar sesión