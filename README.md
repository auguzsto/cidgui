# CID FLUTTER.

Readme in progress...

## About (Sobre)
Português.

Este é um projeto para facilitar o uso do CID (https://cid-doc.github.io/). O CID já conta com uma versão com interface gráfica construída em GTK, porém falta alguns recursos. Utilizo o CID para administrar um servidor de arquivos no Linux no meu atual trabalho, fiz algumas modificações e construí o CID-GUI-WEB em PHP. Esta versão do CID baseado em Flutter tem o objeto de construir uma interface gráfica nativa para todas as distribuições Linux.

#

English.

This is a project to make CID easier to use (https://cid-doc.github.io/). CID already has a version with a graphical interface built in GTK, but it lacks some features. I use CID to administer a file server on Linux at my current job, I made some modifications and built CID-GUI-WEB (https://github.com/auguzsto/cid-gui) in PHP. This version of CID based on Flutter aims to build a native GUI for all Linux distributions.

## Installation (Instalação).
### Instale o CID.
1. Faça instalação do CID. (https://cid-doc.github.io/#Installation)

### Editar arquivo sudoers.
1. Será necessário alterar requisição de senha para usuários sudoers.

$ sudo nano /etc/sudoers

Alterar linha %sudo... para %sudo ALL=(ALL) NOPASSWD: ALL

Imagem de exemplo:
<div align="center"><img src="https://i.imgur.com/6B7RcMR.png"></div>

Reinicie a máquina após alteração.

# Tasks
- [x] Enter in domain.
- [x] Leave the domain.
- [x] Add folder shared.
     - [x] Add user permission.
     - [x] Add group permission.
     - [ ] Vetos samba files.
     - [x] Choose read or read and write.
- [x] Remove folder shared.
- [ ] Update folder shared.
     - [ ] Add user permission.
     - [ ] Add group permission
     - [ ] Remove user permission.
     - [ ] Remove group permission.
- [ ] Database (SQLite)
     - [ ] Entities: Folder, domain.
- [ ] SQLite methods.
     - [ ] Enter application data.
     - [ ] See my domain.
     - [ ] List folders shareds.


## Screenshots.

### Check domain screen.
<div align="center"><img src="https://i.imgur.com/LpTd58r.png"></div>

### Home screen.
<div align="center"><img src="https://i.imgur.com/YQeuQ22.png"></div>

### Enter domain screen.
<div align="center"><img src="https://i.imgur.com/81gGv4X.png"></div>

## Leave domain screen.
<div align="center"><img src="https://i.imgur.com/qezk77T.png"></div>

### Shared folder screen.
<div align="center"><img src="https://i.imgur.com/I8BWjMj.png"></div>

### Remove folder screen.
<div align="center"><img src="https://i.imgur.com/BqwSbuM.png"></div>
