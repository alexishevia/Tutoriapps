# coding: utf-8
# language: es
Característica: Administrar Grupos
  
  Como administrador de Tutoriapps
  Para asignar los estudiantes a los grupos correctos
  Quiero poder administrar los grupos

  @javascript
  Escenario: Administrador crea un grupo
    Dado que un administrador ha iniciado sesión
    Cuando intente crear un grupo nuevo
    Entonces el grupo quedará registrado en el sistema

  Escenario: Estudiante crea un grupo mediante http
    Dado que un estudiante ha iniciado sesión mediante http
    Cuando intente crear un grupo nuevo mediante http
    Entonces recibirá el status 403
    Y el grupo no quedará registrado en el sistema

  @javascript
  Escenario: Administrador agrega un estudiante existente a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" ya está registrado
    Y que el estudiante "fulano@utp.ac.pa" no está matriculado en la materia "Cálculo II"
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el estudiante "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un estudiante no existente a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" no está registrado
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el email "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un email inválido a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "foo@bar.com" al grupo "Cálculo II"
    Entonces el email "foo@bar.com" no aparecerá dentro del grupo "Cálculo II"

  Escenario: Estudiante agrega a otro estudiante a un grupo mediante http
    Dado que un estudiante ha iniciado sesión mediante http
    Y que la clase "Cálculo II" ha sido creada
    Y que el estudiante está matriculado en la materia "Cálculo II"
    Y que el estudiante "fulano@utp.ac.pa" ya está registrado
    Pero que el estudiante "fulano@utp.ac.pa" no está matriculado en la materia "Cálculo II"
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el estudiante "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II"

  Escenario: Estudiante se auto-agrega a un grupo mediante http
    Dado que un estudiante ha iniciado sesión mediante http
    Y que la clase "Cálculo II" ha sido creada
    Pero el estudiante no está matriculado en la materia "Cálculo II"
    Cuando intente agregarse al grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y no aparecerá dentro del grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un usuario repetido a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" ya está registrado
    Y que el estudiante "fulano@utp.ac.pa" está matriculado en la materia "Cálculo II"
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el estudiante "fulano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  @javascript
  Escenario: Administrador agrega un usuario no existente repetido a un grupo
    Dado que la clase "Cálculo II" ha sido creada
    Y que el estudiante "fulano@utp.ac.pa" no está registrado
    Y que el email "fulano@utp.ac.pa" se agregó al grupo "Cálculo II"
    Y que un administrador ha iniciado sesión
    Cuando intente agregar al estudiante "fulano@utp.ac.pa" al grupo "Cálculo II"
    Entonces el email "fulano@utp.ac.pa" aparecerá 1 vez en el grupo "Cálculo II"

  Escenario: Administrador elimina un usuario de un grupo
    Dado PENDING

  Escenario: Administrador elimina un email de un grupo
    Dado PENDING

  Escenario: Estudiante elimina a otro estudiante de un grupo mediante http
    Dado PENDING