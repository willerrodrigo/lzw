clc;
clear all;
close all;

entrada = input('Entre com a string a ser convertida (A string deve estar entre �spas simples): ');
tamanhoEntrada = length(entrada);
dicionario = input('Entre com o dicionario (A string deve estar entre �spas simples): ');
tamanhoDicionario = length(dicionario);
novoDicionario = cellstr(dicionario);
saida = ones(1, tamanhoEntrada * 2);

% Passa 'abc' para {'a''b''c'}
for i = 1:tamanhoDicionario
  novoDicionario(i) = {dicionario(i)};
end

p = entrada(1);% Primeiro caracter
s = p;% Caracter atual
k = 1; % Usado para gerar a saida
j = 1;

for i=1:tamanhoEntrada-1 % Percorre toda entrada
    c = entrada(i + 1);
    if strcmp(novoDicionario, strcat(s,c)) == 0
        novoDicionario(j + tamanhoDicionario) = {strcat(s, c)}; % Coloca a string que n�o tinha no dicionario

        check = ismember(novoDicionario, s);

        for l = 1:length(check)
            if check(l) == 1
              saida(k) = l;
              k = k + 1;
              break;
            end
        end

        s = c;
        j = j + 1;
    else
        s = strcat(s, c);
    end
    
    if i == tamanhoEntrada-1 % s = �ltimo caracter da string
        check = ismember(novoDicionario, s);

        for l = 1:length(check)
          if check(l) == 1
            saida(k) = l;
            break;
          end
        end
    end
end

saida = saida(1:k); % Pegando apenas os index que foram usados
disp('Dicion�rio gerado na codifica��o: ');
disp(novoDicionario);
disp('String codificada: ');
disp(saida);


% Decodifica��o
tamanhoSaida = length(saida);
index = length(dicionario);
string = '';

% Passar cell array para char array
dicgen = cellstr(dicionario);

for i = 1:tamanhoDicionario
  dicgen(i)={dicionario(i)};
end

g = 1;
entry = char(dicionario(saida(g))); % Primeiro s�mbolo
g = g + 1; % Pr�ximo s�mbolo

while tamanhoSaida >= g % Enquanto n�o acabar a string
  if numel(dicgen) >= saida(g)
    s = entry;
    entry = char(dicgen(saida(g)));
    string = strcat(string, s); % String encontrada
    index = index + 1;
    dicgen(index) = {strcat(s, entry(1))}; % Atualiza o dicionario
  else
    dicgen(saida(g)) = {strcat(entry, entry(1))}; % Adiciona o novo alfabeto no dicion�rio
    g = g - 1;
  end
  g = g + 1; % Pr�ximo index
end

string = strcat(string, entry);
disp('Dicion�rio gerado na decodifica��o: ');
disp(dicgen);
disp('String original ap�s decodificar: ');
disp(string);

disp('Taxa de compress�o: ');
disp(tamanhoEntrada/tamanhoSaida);