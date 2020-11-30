
Ruby versión: 2.6.3

Rails versión: 6.0.3 

Nota: Si clona este repositorio en su máquina reemplace lo siguiente:  

 - BASE_URL: localhost

- PUERTO: puerto que use, por defecto Rails usa 3000

- HOST: dominio que desea buscar

- URL_COMPLETA: Pasar la URL

- url_corta: se encuentra en la respuesta de listar

# Generar URL corta

-   método http usado: POST 

curl -d '{"url": "URL_COMPLETA"}' -H "Accept: application/json" -X POST "BSE_URL:PUERTO/v1/shorteners"  

**EJEMPLO RESPUESTA**

{

  response: {

    url_corta: "http:localhost:3000/v1/3cdc4f50"

  }

}

# Listar detalle del dominio

-   Método http usado: GET  

curl -H "Accept: application/json" "BASE_URL/v1/shorteners?domain=HOST"  

**EJEMPLO RESPUESTA**

{

"response": [

{

"url": "https://www.google.com",

"url_corta": "http://localhost:3000/v1/3cdc4f50",

"counter": 2,

"ranking": 1

}

]

}  

# Visitar URL

curl url_corta
