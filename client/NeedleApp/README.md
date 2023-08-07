# Para rodar o App com servidor local:
1. Use o Xcode para criar um arquivo do tipo `Configuration Settings File` com o nome Debug dentro da pasta Config
2. Dentro do arquivo `Debug.xcconfig`, insira o seguintes atributos:
```
SLASH = /
API_URL = http:$(SLASH)/localhost:3010/
```

3. Vá em Project (o arquivo com ícone azul), e dentro de Project, mude a primeira configuracao do Debug para o arquivo criado (Debug)
   <img width="1440" alt="Screenshot 2023-08-07 at 14 18 19" src="https://github.com/matheus-vb/needle/assets/88170905/de8c11ad-2e4c-4a12-8f13-9e5b8127d2d0">
5. Rode o app enquanto o servidor e conteiner do Docker (onde fica a database) estão sendo executados
