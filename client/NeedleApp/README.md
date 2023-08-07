# Para rodar o App com servidor local:
1. Use o Xcode para criar um arquivo do tipo `Configuration Settings File` com o nome Debug dentro da pasta Config
2. Dentro do arquivo `Debug.xcconfig`, insira o seguintes atributos:
```
SLASH = /
API_URL = http:$(SLASH)/localhost:3010/
```
3. Rode o app enquanto o servidor e conteiner do Docker (onde fica a database) estão sendo executados