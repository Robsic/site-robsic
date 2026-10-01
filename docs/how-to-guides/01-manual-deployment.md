# 🛠️ Guia Prático: Deploy Manual em Produção (Servidor UNIFEI)

> **Finalidade:** Instruções operacionais detalhadas para compilar a versão de produção do frontend e publicá-la no servidor web NGINX do laboratório RobSIC.
> **Destino:** Servidor `robotica@robsic.unifei.edu.br`
> **Diretório Web:** `/var/www/web/`

---

## 1. Visão Geral do Processo

O deploy manual é composto por 4 etapas sequenciais:
1. **Compilação** da aplicação Flutter Web para arquivos estáticos (`HTML`, `JS`, `CSS`, `Wasm/CanvasKit`).
2. **Compactação** dos artefatos em arquivo `.zip`.
3. **Transferência** segura via SCP para o servidor.
4. **Implantação e backup** via SSH com atualização de permissões do NGINX.

---

## 2. Passo 1 — Gerar o Build de Produção

Na sua máquina local, dentro da pasta raiz do projeto (`SiteLab`), execute:

```bash
flutter build web --release --base-href "/" --dart-define=BASE_URL=https://robsic.unifei.edu.br
```

> [!IMPORTANT]
> - `--base-href "/"`: Garante que os caminhos dos assets e rotas funcionem na raiz do domínio.
> - `--dart-define=BASE_URL=https://robsic.unifei.edu.br`: Informa ao cliente HTTP Dio o endereço público da API Strapi em produção.

---

## 3. Passo 2 — Empacotar os Arquivos

Entre no diretório de saída e gere o pacote `.zip`:

```bash
cd build/web && zip -r ../../web_prod.zip . && cd ../..
```

*(O arquivo `web_prod.zip` será gerado na raiz do projeto e é ignorado pelo `.gitignore`).*

---

## 4. Passo 3 — Enviar para o Servidor via SCP

Transfira o arquivo para a pasta inicial (`home`) do usuário `robotica`:

```bash
scp web_prod.zip robotica@robsic.unifei.edu.br:~/
```
*Insira a senha do usuário `robotica` quando solicitado.*

---

## 5. Passo 4 — Conectar e Implantar via SSH

Acesse o servidor:

```bash
ssh robotica@robsic.unifei.edu.br
```

No terminal do servidor, execute os seguintes comandos em ordem:

```bash
# 1. Cria um backup datado da versão atualmente em produção
sudo cp -r /var/www/web /var/www/web_backup_$(date +%F_%H-%M-%S)

# 2. Limpa o diretório de produção antigo
sudo rm -rf /var/www/web/*

# 3. Descompacta a nova versão diretamente no diretório do servidor
sudo unzip -o ~/web_prod.zip -d /var/www/web/

# 4. Ajusta as permissões de propriedade para o usuário do NGINX
sudo chown -R www-data:www-data /var/www/web/

# 5. Remove o pacote zip temporário da home
rm ~/web_prod.zip

# 6. Finaliza a sessão SSH
exit
```

---

## 6. Procedimento de Rollback (Em caso de emergência)

Se a nova versão apresentar problemas em produção, você pode restaurar o backup anterior imediatamente:

1. Acesse o servidor via SSH:
   ```bash
   ssh robotica@robsic.unifei.edu.br
   ```
2. Liste os backups disponíveis:
   ```bash
   ls -ld /var/www/web_backup_*
   ```
3. Restaure o backup mais recente:
   ```bash
   sudo rm -rf /var/www/web/*
   sudo cp -r /var/www/web_backup_NOME_DO_BACKUP/* /var/www/web/
   sudo chown -R www-data:www-data /var/www/web/
   ```
4. Recarregue a página no navegador com `Ctrl + F5` para limpar o cache.
