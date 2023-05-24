# pokedex

Aplicativo de desafio para Snapfi.

Implementação de uma Pokédex, o layout e a documentação da api foram definidos em https://github.com/snapfi/mobile-code-challenge.

Por escolha, decidi por desenvolver o app usando a versão 1.20.4 (sem nullsafe) apenas para demonstrar o conhecimento em arquitetura limpa e TDD, (por isso as bibliotecas externas estão com versões travadas também) mas havendo mais tempo é perfeitamente possível uma atualização na versão do projeto. Sugiro ao revisor utilizar o FVM (https://fvm.app)

Pelo fato de ter sido feito com TDD a cobertura de teste está em **100%**, como pode ser visto em <a href="coverage/html/index.html">**coverage/html/index.html**</a> ou rodando seguintes comandos:

`flutter test --coverage` recomendo rodar com o `fvm` no início 

`genhtml coverage/lcov.info -o coverage/html`

`open coverage/html/index.html`

<img src="/screenshots/show_tests.png" width="400" title="Detalhes de Testes na IDE"/>
<img src="/screenshots/show_tests_2.png" width="400" title="Detalhes de Testes no navegador"/>

## Observações:
1. A busca e a ordenação é feita localmente com os dados que já estão na lista.

2. Na tela de listagem de Pokemon não vem as informações de ID e de url da foto, apenas o nome de cada Pokemon (pelo menos, no tempo que tive para estudar a API,não encontrei um endpoint que retornasse a lista de Pokemon que é apresentado na Home do protótipo). Por este motivo para cada Pokemon desenhado na tela, tive que chamar o endpoint de detalhes, mesmo que esse mesmo endpoint de detalhes  seja chamado ao entrar em Pokemon. Decidi por manter as duas chamadas (mesmo q talvez a segunda seja desnecessária) pois em algum momento no futuro eu posso encontrar um endpoint melhor para popular a Home e assim a minha tela de Detalhes continuaria funcionando da forma que foi projetada.

3. Não encontrei no endpoint de detalhes de um Pokemon a informação a respeito da cor predominante dele. Decidi por manter as cores fixas em verde, pois calcular por meio de uma biblioteca externa qual a cor predominante de uma imagem da internet faria a cobertura de testes cair.

4. Por padrão as IDEs executam a main.dart de um app Flutter localizado na pasta lib. Para executar esse projeto é necessário dizer para a IDE que a main que ela deve usar é a que está no seguinte local: lib/main/main.dart.

5. O tamanho escolhido para a página é 30 elementos.
6. Por facilidade, a hierarquia da pasta de testes segue a mesma hierarquia da pasta lib. 

## Preview

Na pasta screenshots existem alguns prints tirados do app rodando no Simulador do iPhone e um vídeo com um overview.
### Pokemons
<img src="/screenshots/pokemons_page.png" width="400" title="Home"/>

### Detalhes de um Pokemon
<img src="/screenshots/pokemon_details_page.png" width="400" title="Detalhes"/>

## Testes com dispositivos:
O projeto foi testado nos seguintes dispositivos:
- Samsung J5 (Real)
- Samsung A20s (Real)
- iPhone 8 (Simulador)
