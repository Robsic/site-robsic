# Acompanhamento de Ajustes — Página de Resultados

Este documento serve para acompanhar o andamento dos ajustes e melhorias implementadas na seção de Resultados do site do laboratório RobSIC.

---

## 🛠️ Status dos Ajustes

### 1. Organização e Exibição de Vídeos
- [x] **Agrupar Vídeos por Playlists:** Vídeos de experimentos organizados em grupos temáticos expansíveis.
- [x] **Agrupamento na Aba "Todos":** Playlists aplicadas também na exibição geral para evitar poluição visual.
- [x] **Remoção de Emojis:** Títulos das playlists padronizados com texto limpo.
- [x] **Correção de Playlist do Vídeo de Dissertação:** O vídeo *"Localização Topológica..."* foi movido da playlist de Visão Computacional para *"Outros Vídeos do Canal RobSIC"*, de acordo com o `.md`.
- [x] **Importação do 8º Vídeo do CAT793F:** Vídeo *"Protótipo de Hardware e Software para Simulação..."* importado e publicado no Strapi.
- [x] **Correção da Paginação (Erro do Limite de 100):** Datasource atualizado com busca recursiva de páginas, garantindo que o 8º vídeo (e novos cadastros futuros) apareça na tela (8 de 8 vídeos completos).

### 2. Comportamento dos Botões nos Cards
- [x] **Ocultar sem URL:** Botões verdes ocultados quando o item não tem link (evita links quebrados).
- [x] **Botão Exclusivo para Vídeos:** O botão *"ASSISTIR VÍDEO"* (e a abertura do player modal com play icon overlay) agora é exibido **estritamente** para itens de tipo `video`.
- [x] **Botão de Acesso para Protótipos/Demonstrações:** Itens que possuem link do YouTube mas são protótipos ou demonstrações agora exibem o botão padrão *"ACESSAR"* e abrem o link diretamente no navegador (não exibem o ícone de play overlay, eliminando a sensação de "vídeos soltos" em outras seções).

### 3. Ajuste do Player de Vídeo Modal
- [x] **Fim do Bug de Overflow:** Altura fixa removida do modal de vídeo e adicionada rolagem interna (`SingleChildScrollView`), impedindo o erro de *"bottom overflowed by 29 pixels"* em telas menores.

### 4. Organização da Aba "Todos"
- [x] **Estrutura por Seções:** A aba geral agora exibe os resultados divididos por categorias na ordem correta, cada uma com seu respectivo título (Ex: *Datasets*, *Softwares*, *Sistemas Web*...) e linhas divisórias.

### 5. Badges Interativos de Conexões (Mapeamento de Símbolos `§`)
- [x] **Badges Interativos de Conexões (Mapeamento de Símbolos `§`):** Referências textuais como `"§5 P2"`, `"PT3/PT4"` ou `"S4"` são detectadas no resumo e exibidas no card como botões/badges interativos de link (Ex: *"Protótipo P2"*, *"Patente PT3"*). Clicar no badge redefine os filtros de busca e localiza dinamicamente o item referenciado na aba "Todos"!

### 6. Herança Dinâmica de Links
- [x] **Herança Inteligente:** Configurar para que itens sem link próprio herdem links de itens associados (Ex: se uma patente não tem link do INPI, o botão "Acessar" herda o link da demonstração ou artigo associado).

---

## 🚀 Próximos Passos (Ajustes Pendentes)

### 7. Validação Final & Entrega
- [x] Rodar análise estática de código (`flutter analyze`).
- [x] Gerar build web de produção final e compactar pasta em `.zip`.
