# catalogo_filmes

CATÁLOGO DE FILMES
Projeto da Disciplina IMD0509 UFRN 2022.1 em Flutter.

## :octocat: Grupo
- [Hilton Thallyson](https://github.com/HiltonThallyson)
- [João Paulo Braz](https://github.com/jpbraz)
- [Ocenildo Junior](https://github.com/OcenildoJunior)
- [Cleverton Inácio](https://github.com/clevinacio)

## Executando o Projeto do Repositório
1. Crie um projeto novo no diretório de seus projetos com o comando ```flutter create <nome_do_projeto>``` ;
2. Baixe ou clone um projeto deste repositório. Mova os arquivos baixados para a pasta do novo projeto do passo 1. Você deve substituir todos os arquivos. Recomendo que você delete os arquivos do novo projeto criado e depois mova os arquivos baixados para dentro da pasta.
3. Quando mover os arquivos, acesse o diretório do projeto via terminal ou com o terminal do VSCode aberto no seu projeto. Utilize o comando ```flutter pub get``` para atualizar os pacotes de acordo com os arquivos baixados;
4. Configure um novo projeto no [Firebase] (https://console.firebase.google.com/) com o ```Realtime Database``` e ```Authentication```. 
5. Configure o projeto flutter para uso do Firebase usando o [FlutterFire CLI](https://firebase.flutter.dev/docs/overview). 
```
# Install the CLI if not already done so
dart pub global activate flutterfire_cli
# Run the `configure` command, select a Firebase project and platforms
flutterfire configure
```
O App será registrado automaticamente no Firebase, os arquivos android/build.gradle & android/app/build.gradle serão atualizados no projeto, e os arquivos 'firebase_options.dart' e 'google-services.json' serão criados com a chaves do projeto firebase; 

