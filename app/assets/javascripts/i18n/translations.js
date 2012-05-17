var I18n = I18n || {};
I18n.translations = {"en":{"date":{"formats":{"default":"%Y-%m-%d","short":"%b %d","long":"%B %d, %Y"},"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"order":["year","month","day"]},"time":{"formats":{"default":"%a, %d %b %Y %H:%M:%S %z","short":"%d %b %H:%M","long":"%B %d, %Y %H:%M"},"am":"am","pm":"pm"},"support":{"array":{"words_connector":", ","two_words_connector":" and ","last_word_connector":", and "}},"errors":{"format":"%{attribute} %{message}","messages":{"inclusion":"is not included in the list","exclusion":"is reserved","invalid":"is invalid","confirmation":"doesn't match confirmation","accepted":"must be accepted","empty":"can't be empty","blank":"can't be blank","too_long":"is too long (maximum is %{count} characters)","too_short":"is too short (minimum is %{count} characters)","wrong_length":"is the wrong length (should be %{count} characters)","not_a_number":"is not a number","not_an_integer":"must be an integer","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","equal_to":"must be equal to %{count}","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","odd":"must be odd","even":"must be even","expired":"has expired, please request a new one","not_found":"not found","already_confirmed":"was already confirmed, please try signing in","not_locked":"was not locked","not_saved":{"one":"1 error prohibited this %{resource} from being saved:","other":"%{count} errors prohibited this %{resource} from being saved:"}}},"activerecord":{"errors":{"messages":{"taken":"has already been taken","record_invalid":"Validation failed: %{errors}"}}},"number":{"format":{"separator":".","delimiter":",","precision":3,"significant":false,"strip_insignificant_zeros":false},"currency":{"format":{"format":"%u%n","unit":"$","separator":".","delimiter":",","precision":2,"significant":false,"strip_insignificant_zeros":false}},"percentage":{"format":{"delimiter":""}},"precision":{"format":{"delimiter":""}},"human":{"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"kb":"KB","mb":"MB","gb":"GB","tb":"TB"}},"decimal_units":{"format":"%n %u","units":{"unit":"","thousand":"Thousand","million":"Million","billion":"Billion","trillion":"Trillion","quadrillion":"Quadrillion"}}}},"datetime":{"distance_in_words":{"half_a_minute":"half a minute","less_than_x_seconds":{"one":"less than 1 second","other":"less than %{count} seconds"},"x_seconds":{"one":"1 second","other":"%{count} seconds"},"less_than_x_minutes":{"one":"less than a minute","other":"less than %{count} minutes"},"x_minutes":{"one":"1 minute","other":"%{count} minutes"},"about_x_hours":{"one":"about 1 hour","other":"about %{count} hours"},"x_days":{"one":"1 day","other":"%{count} days"},"about_x_months":{"one":"about 1 month","other":"about %{count} months"},"x_months":{"one":"1 month","other":"%{count} months"},"about_x_years":{"one":"about 1 year","other":"about %{count} years"},"over_x_years":{"one":"over 1 year","other":"over %{count} years"},"almost_x_years":{"one":"almost 1 year","other":"almost %{count} years"}},"prompts":{"year":"Year","month":"Month","day":"Day","hour":"Hour","minute":"Minute","second":"Seconds"}},"helpers":{"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","update":"Update %{model}","submit":"Save %{model}"},"button":{"create":"Create %{model}","update":"Update %{model}","submit":"Save %{model}"}},"devise":{"failure":{"already_authenticated":"You are already signed in.","unauthenticated":"You need to sign in or sign up before continuing.","unconfirmed":"You have to confirm your account before continuing.","locked":"Your account is locked.","invalid":"Invalid email or password.","invalid_token":"Invalid authentication token.","timeout":"Your session expired, please sign in again to continue.","inactive":"Your account was not activated yet."},"sessions":{"signed_in":"Signed in successfully.","signed_out":"Signed out successfully."},"passwords":{"send_instructions":"You will receive an email with instructions about how to reset your password in a few minutes.","updated":"Your password was changed successfully. You are now signed in.","updated_not_active":"Your password was changed successfully.","send_paranoid_instructions":"If your e-mail exists on our database, you will receive a password recovery link on your e-mail"},"confirmations":{"send_instructions":"You will receive an email with instructions about how to confirm your account in a few minutes.","send_paranoid_instructions":"If your e-mail exists on our database, you will receive an email with instructions about how to confirm your account in a few minutes.","confirmed":"Your account was successfully confirmed. You are now signed in."},"registrations":{"signed_up":"Welcome! You have signed up successfully.","signed_up_but_unconfirmed":"A message with a confirmation link has been sent to your email address. Please open the link to activate your account.","signed_up_but_inactive":"You have signed up successfully. However, we could not sign you in because your account is not yet activated.","signed_up_but_locked":"You have signed up successfully. However, we could not sign you in because your account is locked.","updated":"You updated your account successfully.","update_needs_confirmation":"You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.","destroyed":"Bye! Your account was successfully cancelled. We hope to see you again soon."},"unlocks":{"send_instructions":"You will receive an email with instructions about how to unlock your account in a few minutes.","unlocked":"Your account has been unlocked successfully. Please sign in to continue.","send_paranoid_instructions":"If your account exists, you will receive an email with instructions about how to unlock it in a few minutes."},"omniauth_callbacks":{"success":"Successfully authorized from %{kind} account.","failure":"Could not authorize you from %{kind} because \"%{reason}\"."},"mailer":{"confirmation_instructions":{"subject":"Confirmation instructions"},"reset_password_instructions":{"subject":"Reset password instructions"},"unlock_instructions":{"subject":"Unlock Instructions"}}},"hello":"Hello world","simple_form":{"yes":"Yes","no":"No","required":{"text":"required","mark":"*"},"error_notification":{"default_message":"Some errors were found, please take a look:"}}},"es":{"errors":{"messages":{"expired":"ha expirado, por favor pide una nueva","not_found":"no encontrado","already_confirmed":"ya fue confirmada. Intenta ingresar.","not_locked":"no ha sido bloqueada","not_saved":{"one":"Ha habido 1 error:","other":"Han habido %{count} errores:"},"accepted":"debe ser aceptado","blank":"no puede estar en blanco","confirmation":"no coincide con la confirmaci\u00f3n","empty":"no puede estar vac\u00edo","equal_to":"debe ser igual a %{count}","even":"debe ser par","exclusion":"est\u00e1 reservado","greater_than":"debe ser mayor que %{count}","greater_than_or_equal_to":"debe ser mayor que o igual a %{count}","inclusion":"no est\u00e1 incluido en la lista","invalid":"no es v\u00e1lido","less_than":"debe ser menor que %{count}","less_than_or_equal_to":"debe ser menor que o igual a %{count}","not_a_number":"no es un n\u00famero","not_an_integer":"debe ser un entero","odd":"debe ser impar","record_invalid":"La validaci\u00f3n fall\u00f3: %{errors}","taken":"ya est\u00e1 en uso","too_long":"es demasiado largo (%{count} caracteres m\u00e1ximo)","too_short":"es demasiado corto (%{count} caracteres m\u00ednimo)","wrong_length":"no tiene la longitud correcta (%{count} caracteres exactos)"},"format":"%{attribute} %{message}","template":{"body":"Se encontraron problemas con los siguientes campos:","header":{"one":"No se pudo guardar este/a %{model} porque se encontr\u00f3 1 error","other":"No se pudo guardar este/a %{model} porque se encontraron %{count} errores"}}},"devise":{"sign_up":"Crear Cuenta","sign_in":"Iniciar Sesi\u00f3n","sign_up_you":"Reg\u00edstrate","sign_up_message":"Es f\u00e1cil y r\u00e1pido","failure":{"already_authenticated":"Ya iniciaste sesi\u00f3n.","unauthenticated":"Tienes que registrarte o iniciar sesi\u00f3n antes de continuar.","unconfirmed":"Tienes que confirmar tu cuenta antes de continuar.","locked":"Tu cuente est\u00e1 bloqueada.","invalid":"Email o contrase\u00f1a inv\u00e1lidos.","invalid_token":"Token de autentificaci\u00f3n inv\u00e1lido.","timeout":"Tu sesi\u00f3n ha expirado. Inicia sesi\u00f3n nuevamente.","inactive":"Tu cuenta aun no ha sido activada."},"sessions":{"signed_in":"Iniciaste sesi\u00f3n correctamente.","signed_out":"Cerraste sesi\u00f3n correctamente."},"passwords":{"forgot?":"\u00bfOlvidaste tu contrase\u00f1a?","send_instructions":"Recibir\u00e1s un email con instrucciones para reiniciar tu contrase\u00f1a en unos minutos.","updated":"Tu contrase\u00f1a fue cambiada correctamente. Has iniciado sesi\u00f3n.","updated_not_active":"Tu contrase\u00f1a fue cambiada correctamente.","send_paranoid_instructions":"Si tu email existe en el sistema, recibir\u00e1s instrucciones para recuperar tu contrase\u00f1a en \u00e9l"},"confirmations":{"didnt_receive?":"\u00bfNo recibiste el email de confirmaci\u00f3n?","send_email":"Enviar email de confirmaci\u00f3n","send_instructions":"Recibir\u00e1s instrucciones para confirmar tu cuenta en tu email en unos minutos.","send_paranoid_instructions":"Si tu email existe en el sistema, recibir\u00e1s instrucciones para confirmar tu cuenta en tu email en unos minutos.","confirmed":"Tu cuenta fue confirmada. Has iniciado sesi\u00f3n."},"registrations":{"signed_up":"Bienvenido! Te has registrado correctamente.","signed_up_but_unconfirmed":"Te hemos enviado un email con instrucciones para que confirmes tu cuenta.","signed_up_but_inactive":"Te has registrado correctamente, pero tu cuenta aun no ha sido activada.","signed_up_but_locked":"Te has registrado correctamente, pero tu cuenta est\u00e1 bloqueada.","updated":"Actualizaste tu cuenta correctamente.","update_needs_confirmation":"Actualizaste tu cuenta correctamente, pero tenemos que revalidar tu email. Revisa tu correo para confirmar la direcci\u00f3n.","destroyed":"Adi\u00f3s, tu cuenta ha sido eliminada. Esperamos verte de vuelta pronto!"},"unlocks":{"send_instructions":"Recibir\u00e1s un email con instrucciones para desbloquear tu cuenta en unos minutos","unlocked":"Tu cuenta ha sido desbloqueada. Inicia sesi\u00f3n para continuar.","send_paranoid_instructions":"Si tu cuenta existe, recibir\u00e1s instrucciones para desbloquear tu cuenta en unos minutos"},"omniauth_callbacks":{"success":"Te autentificaste correctamente con tu cuenta de %{kind}.","failure":"No pudimos autentificar tu cuenta de %{kind} por la siguiente raz\u00f3n: %{reason}."},"mailer":{"confirmation_instructions":{"subject":"Instrucciones de confirmaci\u00f3n"},"reset_password_instructions":{"subject":"Instrucciones de cambio de contrase\u00f1a"},"unlock_instructions":{"subject":"Instrucciones de desbloqueo"}}},"slogan":"Aprende \u00b7 Comparte \u00b7 Ense\u00f1a","error":"Error","fix_and_try_again":"Por favor corrija estos errores y vu\u00e9lvalo a intentar","date":{"abbr_day_names":["dom","lun","mar","mi\u00e9","jue","vie","s\u00e1b"],"abbr_month_names":[null,"ene","feb","mar","abr","may","jun","jul","ago","sep","oct","nov","dic"],"day_names":["domingo","lunes","martes","mi\u00e9rcoles","jueves","viernes","s\u00e1bado"],"formats":{"default":"%d/%m/%Y","long":"%d de %B de %Y","short":"%d de %b"},"month_names":[null,"enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"],"order":["day","month","year"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"alrededor de 1 hora","other":"alrededor de %{count} horas"},"about_x_months":{"one":"alrededor de 1 mes","other":"alrededor de %{count} meses"},"about_x_years":{"one":"alrededor de 1 a\u00f1o","other":"alrededor de %{count} a\u00f1os"},"almost_x_years":{"one":"casi 1 a\u00f1o","other":"casi %{count} a\u00f1os"},"half_a_minute":"medio minuto","less_than_x_minutes":{"one":"menos de 1 minuto","other":"menos de %{count} minutos"},"less_than_x_seconds":{"one":"menos de 1 segundo","other":"menos de %{count} segundos"},"over_x_years":{"one":"m\u00e1s de 1 a\u00f1o","other":"m\u00e1s de %{count} a\u00f1os"},"x_days":{"one":"1 d\u00eda","other":"%{count} d\u00edas"},"x_minutes":{"one":"1 minuto","other":"%{count} minutos"},"x_months":{"one":"1 mes","other":"%{count} meses"},"x_seconds":{"one":"1 segundo","other":"%{count} segundos"}},"prompts":{"day":"D\u00eda","hour":"Hora","minute":"Minutos","month":"Mes","second":"Segundos","year":"A\u00f1o"}},"helpers":{"select":{"prompt":"Por favor seleccione"},"confirm_delete":{"enrollment":"\u00bfEst\u00e1 seguro que desea sacar a %{user_name} del grupo %{group_name}?","group":"\u00bfEst\u00e1 seguro que desea eliminar el grupo %{group_name}? Esta acci\u00f3n no se puede deshacer."},"submit":{"create":"Crear %{model}","submit":"Guardar %{model}","update":"Actualizar %{model}","add":"A\u00f1adir %{model}","send":"Enviar"},"messages":{"created":"%{model} creado exitosamente.","added":"%{model} a\u00f1adido exitosamente."}},"number":{"currency":{"format":{"delimiter":".","format":"%n %u","precision":2,"separator":",","significant":false,"strip_insignificant_zeros":false,"unit":"\u20ac"}},"format":{"delimiter":".","precision":3,"separator":",","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"mil millones","million":"mill\u00f3n","quadrillion":"mil billones","thousand":"mil","trillion":"bill\u00f3n","unit":""}},"format":{"delimiter":"","precision":1,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"gb":"GB","kb":"KB","mb":"MB","tb":"TB"}}},"percentage":{"format":{"delimiter":""}},"precision":{"format":{"delimiter":""}}},"support":{"array":{"last_word_connector":", y ","two_words_connector":" y ","words_connector":", "}},"time":{"am":"am","formats":{"default":"%A, %d de %B de %Y %H:%M:%S %z","long":"%d de %B de %Y %H:%M","short":"%d de %b %H:%M"},"pm":"pm"},"activemodel":{"errors":{"format":"%{attribute} %{message}","messages":{"accepted":"debe ser aceptado","blank":"no puede estar en blanco","confirmation":"no coincide con la confirmaci\u00f3n","empty":"no puede estar vac\u00edo","equal_to":"debe ser igual a %{count}","even":"debe ser par","exclusion":"est\u00e1 reservado","greater_than":"debe ser mayor que %{count}","greater_than_or_equal_to":"debe ser mayor que o igual a %{count}","inclusion":"no est\u00e1 incluido en la lista","invalid":"no es v\u00e1lido","less_than":"debe ser menor que %{count}","less_than_or_equal_to":"debe ser menor que o igual a %{count}","not_a_number":"no es un n\u00famero","not_an_integer":"debe ser un entero","odd":"debe ser impar","record_invalid":"La validaci\u00f3n fall\u00f3: %{errors}","taken":"ya est\u00e1 en uso","too_long":"es demasiado largo (%{count} caracteres m\u00e1ximo)","too_short":"es demasiado corto (%{count} caracteres m\u00ednimo)","wrong_length":"no tiene la longitud correcta (%{count} caracteres exactos)"},"template":{"body":"Se encontraron problemas con los siguientes campos:","header":{"one":"No se pudo guardar este/a %{model} porque se encontr\u00f3 1 error","other":"No se pudo guardar este/a %{model} porque se encontraron %{count} errores"}}}},"activerecord":{"models":{"group":"Grupo","groups":"Grupos","post":"Post","user":"Usuario"},"attributes":{"user":{"name":"Nombre","email":"Email","password":"Contrase\u00f1a","password_confirmation":"Repetir contrase\u00f1a","current_password":"Contrase\u00f1a actual","remember_me":"No cerrar sesi\u00f3n"},"group":{"name":"Nombre","public":"P\u00fablico","all":"Todos"},"enrollment":{"user_id":"Usuario","user_email":"Email","group":"Grupo"}},"errors":{"user":{"email":{"only_utp":"Solo se permiten correos de la UTP (@utp.ac.pa)"}}}},"simple_form":{"yes":"S\u00ed","no":"No","required":{"text":"requerido","mark":"*"},"error_notification":{"default_message":"Por favor corrije los siguientes errores:"}}}};