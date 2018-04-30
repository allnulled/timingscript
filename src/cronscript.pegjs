Lenguaje = s:Sentencia_completa* {return s}
Sentencia_completa = s:Sentencia Fin_de_sentencia {return s}
Sentencia = f:Fecha_cron c:Contenido {return {date:f,content:c}}
Fecha_cron = mes:cron_fecha SEP dia:cron_fecha SEP2 hora:cron_fecha SEP minuto:cron_fecha SEP segundo:cron_fecha {return [segundo, minuto, hora, dia, mes].join(" ") + " *"}
cron_fecha = cron_item (("," " "*) cron_item)* {return text()}
cron_item = cron_rango / cron_frecuencia / cron_numero / cron_todos
cron_numero = numero
cron_frecuencia = "*/" numero
cron_rango = numero "-" numero 
cron_todos = "*"
numero = [0-9]+
Contenido = " "* c:Contenido_item {return c}
Contenido_item = " "* titulo:("{" [^\}]* "}")? " "* mensaje:[^\n]+ {return {title: titulo ? titulo[1].join("") : "",message: mensaje.join("") + "\n"}}
Fin_de_sentencia = "\n"*
SEP = "|"
SEP2 = " "