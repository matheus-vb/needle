# Para rodar o server:
- Tenha o Node instalado: https://nodejs.org/en
- Tenha o Docker instalado: https://www.docker.com
  
1. Crie um arquivo chamado `.env` na raiz da pasta 'server' e coloque os atributos:
```
   DATABASE_URL="postgresql://docker:docker@localhost:5432/needleapi?schema=public"
PORT=3010
```
2. Na raiz do servidor, rode o comando `docker compose up -d`
3. Ainda na raiz do servidor, rode o comando `npm ci && npx prisma generate && npx prisma migrate deploy`
4. Para acessar a API do servidor, faça requisicoes para a URL `http://localhost:3010/` enquanto o servidor e conteiner do Docker estiverem sendo executados