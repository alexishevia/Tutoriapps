# coding: utf-8
# language: es
Característica: Administrar Grupos (Evil)
  
  Como hacker
  Para pasarle por alto a las restricciones de Tutoriapps
  Quiero poder modificar los grupos mediante http

  Antecedentes: usuario ha iniciado sesión
    Dado que el grupo "Cálculo II" ha sido creado
    Y que el usuario "fulano@utp.ac.pa" ha sido creado y confirmado
    Y que el usuario "hacker@utp.ac.pa" ha sido creado y confirmado
    Y que el usuario "hacker@utp.ac.pa" ha iniciado sesión mediante http

  Escenario: usuario crea un grupo mediante http
    Cuando intente crear un grupo nuevo mediante http
    Entonces recibirá el status 403
    Y el grupo no quedará registrado en el sistema

  Escenario: usuario se auto-agrega a un grupo mediante http  
    Cuando intente agregar el usuario "hacker@utp.ac.pa" al grupo "Cálculo II" mediante http  
    Entonces recibirá el status 403
    Y el usuario "hacker@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II" en el sistema

  Escenario: usuario agrega otro usuario a un grupo mediante http
    Dado que el usuario "hacker@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente agregar el usuario "fulano@utp.ac.pa" al grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el usuario "fulano@utp.ac.pa" no aparecerá dentro del grupo "Cálculo II" en el sistema

  Escenario: usuario elimina a otro usuario de un grupo mediante http
    Dado que el usuario "fulano@utp.ac.pa" ya fue agregado al grupo "Cálculo II"
    Cuando intente sacar al usuario "fulano@utp.ac.pa" del grupo "Cálculo II" mediante http
    Entonces recibirá el status 403
    Y el usuario "fulano@utp.ac.pa" aparecerá dentro del grupo "Cálculo II" en el sistema