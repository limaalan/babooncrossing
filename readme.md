# Documentação do Código: Problema de Concorrência Baboon Crossing

Este código simula o problema clássico de concorrência conhecido como **Baboon Crossing**, onde babuínos precisam atravessar uma corda entre dois penhascos. A corda só suporta até 5 babuínos por vez, e todos devem estar indo na mesma direção (norte ou sul).

## Funcionamento do Código

- **Babuínos**: Representados por threads, cada babuíno tenta atravessar a corda em uma direção aleatória (norte ou sul).
- **Corda**: A corda é um recurso compartilhado, controlado por um **mutex** para garantir que apenas um babuíno por vez tente acessá-la.
- **Regras**:
  - A corda só pode ser usada por babuínos indo na mesma direção.
  - O primeiro babuíno a entrar define a direção da corda.
  - No máximo 5 babuínos podem estar na corda ao mesmo tempo.

## Funções Principais

1. **_ready()**: Inicializa a simulação, criando threads para cada babuíno.
2. **baboon_thread()**: Define a direção de cada babuíno e inicia o processo de travessia.
3. **_cross_north() / _cross_south()**: Controlam a travessia na direção norte ou sul.
4. **_enter_rope()**: Gerencia a entrada na corda, garantindo que as regras sejam seguidas.
5. **_exit_rope()**: Gerencia a saída da corda, atualizando a contagem de babuínos.

## Problema de Concorrência

O problema de concorrência aqui é garantir que:
- A corda não seja usada por babuínos em direções opostas ao mesmo tempo.
- A corda não exceda o limite de 5 babuínos.
- A direção da corda seja respeitada após ser definida pelo primeiro babuíno.

O uso de **mutex** garante que apenas uma thread por vez acesse a corda, evitando condições de corrida.

---
## Como executar 
Execute os aquivos `babooncrossing.exe` para windows e `babooncrossing_linux.sh` para linux, ou abra o projeto em um editor da godot e execute o script da cena principal.