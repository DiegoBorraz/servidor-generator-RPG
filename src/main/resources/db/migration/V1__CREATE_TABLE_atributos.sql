-- Table: public.atributo

-- DROP TABLE IF EXISTS public.atributo;

CREATE TABLE IF NOT EXISTS public.atributo
(
    id SERIAL PRIMARY KEY,
    nome_atributo character varying(255) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(255) COLLATE pg_catalog."default" NOT NULL
);



INSERT INTO atributo (id, nome_atributo, descricao) VALUES
(1, 'Força', 'A capacidade física de levantar, mover e destruir objetos.'),
(2, 'Destreza', 'A capacidade de realizar movimentos ágeis e precisos.'),
(3, 'Constituição', 'A capacidade física de resistir a danos e doenças.'),
(4, 'Inteligência', 'A capacidade de aprender e entender novas informações.'),
(5, 'Sabedoria', 'A capacidade de entender o mundo ao seu redor e tomar decisões sábias.'),
(6, 'Carisma', 'A capacidade de influenciar e persuadir os outros.'),
(7, 'Qualquer', 'A capacidade de influenciar e persuadir os outros.');



-- Table: public.tipo_criatura

-- DROP TABLE IF EXISTS public.tipo_criatura;

CREATE TABLE IF NOT EXISTS public.tipo_criatura
(
    id SERIAL PRIMARY KEY,
    nome character varying(50) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(255) COLLATE pg_catalog."default" NOT NULL,
    habilidades character varying(255) COLLATE pg_catalog."default" NOT NULL,
    idiomas character varying(255) COLLATE pg_catalog."default" NOT NULL
);



INSERT INTO tipo_criatura (id, nome, descricao, habilidades, idiomas)
VALUES
(1, 'Humanoide', 'Criaturas inteligentes e versáteis que podem usar uma variedade de armas e armaduras.', 'Visão noturna, resistência a veneno', 'Comum, Anão, Élfico, Gnomo, Meio-Orc, Orc'),
(2, 'Monstro', 'Criaturas inteligentes e perigosas que costumam ser hostis aos humanos.', 'Força, Constituição', 'Nenhuma'),
(3, 'Animal', 'Criaturas não inteligentes que podem ser domesticadas ou selvagens.', 'Destreza, Sabedoria', 'Nenhuma'),
(4, 'Elemental', 'Criaturas feitas de elementos naturais, como fogo, água, terra ou ar.', 'Inteligencia, Carisma', 'Nenhuma');


-- Table: public.idioma

-- DROP TABLE IF EXISTS public.idioma;

CREATE TABLE IF NOT EXISTS public.idioma (
  id SERIAL PRIMARY KEY,
  nome_idioma VARCHAR(100) NOT NULL,
  descricao_idioma VARCHAR(255) NOT NULL
);

INSERT INTO idioma (id, nome_idioma, descricao_idioma) VALUES
  (1, 'Comum', 'O idioma mais falado do mundo, falado por humanos, halflings, half-elves, half-orcs, e muitos outros povos.'),
  (2, 'Élfico', 'O idioma dos elfos, um idioma elegante e fluido.'),
  (3, 'Anão', 'O idioma dos anões, um idioma duro e guttural.'),
  (4, 'Halfling', 'O idioma dos halflings, um idioma brincalhão e animado.'),
  (5, 'Goblin', 'O idioma dos goblins, um idioma agressivo e hostil.'),
  (6, 'Draconiano', 'O idioma dos dragões, um idioma poderoso e imponente.'),
  (7, 'Orc', 'O idioma dos orcs, um idioma bruto e violento.'),
  (8, 'Auran', 'O idioma dos elementais do ar, um idioma suave e melodioso.'),
  (9, 'Aquan', 'O idioma dos elementais da água, um idioma fluido e ondulante.'),
  (10, 'Ignan', 'O idioma dos elementais do fogo, um idioma ardente e poderoso.'),
  (11, 'Terran', 'O idioma dos elementais da terra, um idioma sólido e resistente.'),
  (12, 'Sylvan', 'O idioma dos fey, um idioma belo e etéreo.');



-- Table: public.tamanho

-- DROP TABLE IF EXISTS public.tamanho;

CREATE TABLE IF NOT EXISTS public.tamanho
(
    id SERIAL PRIMARY KEY,
    nome_tamanho character varying(255) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(255) COLLATE pg_catalog."default" NOT NULL
);



INSERT INTO tamanho (id, nome_tamanho, descricao) VALUES
(1, 'Minúsculo', 'Até 1 metro de altura e 20 quilos de peso. Exemplo: rato, fada, goblin.'),
(2, 'Pequeno', '1 a 2 metros de altura e 20 a 40 quilos de peso. Exemplo: elfo, halfling, kobold.'),
(3, 'Médio', '2 a 4 metros de altura e 40 a 80 quilos de peso. Exemplo: humano, anão, half-orc.'),
(4, 'Grande', '4 a 8 metros de altura e 80 a 160 quilos de peso. Exemplo: orc, minotauro, dragão jovem.'),
(5, 'Enorme', '8 a 16 metros de altura e 160 a 320 quilos de peso. Exemplo: dragão adulto, troll.'),
(6, 'Colossal', 'Mais de 16 metros de altura e 320 quilos de peso. Exemplo: kraken, Tiamat.');


-- Table: public.raca

--DROP TABLE IF EXISTS public.raca;


CREATE TABLE IF NOT EXISTS public.raca
(
    id SERIAL PRIMARY KEY,
    nome_raca character varying(50) COLLATE pg_catalog."default" NOT NULL,
    descricao_raca text COLLATE pg_catalog."default" NOT NULL,
	deslocamento decimal(10, 2) NOT NULL,
	id_atributo_principal integer NOT NULL DEFAULT 1,
    id_atributo_secundario integer NOT NULL DEFAULT 3,
    valor_atributo_primario integer NOT NULL,
    valor_atributo_secundario integer NOT NULL,
	id_tipo_criatura integer NOT NULL DEFAULT 1,
	id_tamanho integer NOT NULL DEFAULT 1,
    CONSTRAINT raca_id_tipo_criatura_fkey FOREIGN KEY (id_tipo_criatura)
        REFERENCES public.tipo_criatura (id) MATCH SIMPLE
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT raca_id_atributo_principal FOREIGN KEY (id_atributo_principal)
		REFERENCES PUBLIC.atributo (id) MATCH SIMPLE
		ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT raca_id_atributo_secundario FOREIGN KEY (id_atributo_secundario)
		REFERENCES PUBLIC.atributo (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT raca_id_tamanho FOREIGN KEY (id_tamanho)
		REFERENCES PUBLIC.atributo (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO raca (id,nome_raca, descricao_raca, deslocamento, id_atributo_principal, id_atributo_secundario, valor_atributo_primario, valor_atributo_secundario, id_tipo_criatura, id_tamanho)
VALUES
    (1, 'Anão da Montanha', 'Anões da montanha são conhecidos por sua força e resistência. Eles possuem uma afinidade natural por viver em terrenos montanhosos.', 9, 3, 1, 2, 2, 1, 2),
    (2, 'Anão das Colinas', 'Anões das colinas são mais focados na resistência e na comunidade. Eles possuem habilidades em cura e bônus de pontos de vida.', 7, 3, 5, 2, 1, 1, 2),
    (3, 'Draconato (Dragonborn)', 'Os draconatos são humanoides escamosos com uma forte semelhança com dragões. Eles são tipicamente altos e musculosos, com peles de cores vibrantes e chifres ou cristas proeminentes. Os draconatos são frequentemente orgulhosos e independentes, e têm uma forte ligação com seus ancestrais dracônicos. Eles são encontrados em todo o mundo, mas são mais comuns em terras onde os dragões são abundantes.', 9, 1, 6, 2, 1, 1, 3),
	(4, 'Elfo Alto', 'Elfos altos são conhecidos por sua afinidade com a magia e com o arco e flecha. Eles possuem visão no escuro e habilidades mágicas.', 9, 2, 4, 2, 1, 1, 3),
    (5, 'Elfo da Floresta', 'Elfos da floresta são excelentes em furtividade e sobrevivência. Eles têm afinidade com a natureza e a habilidade de esconder-se em situações naturais.', 10 , 2, 5, 2, 1, 1, 3),
    (6, 'Elfo Negro (Drow)', 'Drows são elfos subterrâneos conhecidos por sua magia e sensibilidade à luz. Eles possuem visão no escuro superior e habilidades mágicas.', 9, 2, 6, 2, 1, 1, 3),
    (7, 'Halfling dos Pés Leves', 'Halflings dos pés leves são extremamente ágeis e esquivos. Eles têm bônus em esquivar e dificuldade em serem acertados.', 7, 2, 6, 2, 1, 1, 2),
    (8, 'Halfling Robusto', 'Halflings robustos têm resistência natural e um espírito determinado. Eles possuem bônus em resistência e força de vontade.', 7, 2, 3, 2, 1, 1, 2),
    (9, 'Humano Variante', 'Humanos variantes são diversos em suas habilidades e talentos. Eles possuem bônus em dois atributos e um talento adicional.', 9, 7, 7, 0, 0, 1, 3),
    (10, 'Meio-Elfo', 'Meio-elfos têm traços equilibrados de humanos e elfos. Eles possuem habilidades de persuasão e resistência ao encanto.', 9, 6, 7, 2, 1, 1, 3),
    (11, 'Meio-Orc', 'Meio-orcs são fortes e combativos. Eles possuem bônus em força e resistência natural para suportar ferimentos.', 9, 1, 3, 2, 1, 1, 3),
    (12, 'Tiefling Infernal', 'Tieflings infernais têm traços demoníacos mais intensos. Eles possuem habilidades mágicas infernais e características únicas.', 9, 6, 4, 2, 1, 1, 3),
	(13, 'Gnomo da Floresta', 'Como um gnomo da floresta, você possui um traquejo natural com ilusões e velocidade e furtividade naturais.', 9, 4, 2, 2, 1, 1, 2),
	(14, 'Gnomo das Rochas', 'Como um gnomo das rochas, você possui uma inventividade e resistência naturais acima dos outros gnomos.', 9, 4, 3, 2, 1, 1, 2);
	
	
	
CREATE TABLE IF NOT EXISTS public.raca_caracteristica (
  	id SERIAL primary key,
  	id_raca int not null,
  	nome_caracteristica varchar(255) not null,
  	descricao_caracteristica text COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT raca_caracteristica_id_raca_fkey FOREIGN KEY (id_raca)
        REFERENCES public.raca (id) MATCH SIMPLE
		ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


insert into raca_caracteristica (id, id_raca, nome_caracteristica, descricao_caracteristica) values
(1, 1, 'Resiliência Anã','Você possui vantagem em testes de resistência contra venenos e resistência contra dano de veneno.'),
(2, 2, 'Tenacidade Anã', 'Seu máximo de pontos de vida aumentam em 1, e cada vez que o anão da colina sobe um nível, ele recebe 1 ponto de vida adicional.'),
(3, 1, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(4, 2, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(5, 3, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(6, 3, 'Ancestral Feérico', 'Você tem vantagem nos testes de resistência para resistir a ser enfeitiçado e magias não podem colocá-lo para dormir.'),
(7, 4, 'Ancestral Feérico', 'Você tem vantagem nos testes de resistência para resistir a ser enfeitiçado e magias não podem colocá-lo para dormir.'),
(8, 5, 'Ancestral Feérico', 'Você tem vantagem nos testes de resistência para resistir a ser enfeitiçado e magias não podem colocá-lo para dormir.'),
(9, 3, 'Transe', 'Elfos não precisam dormir. Ao invés disso, eles meditam profundamente, permanecendo semiconscientes, durante 4 horas por dia.'),
(10, 4, 'Transe', 'Elfos não precisam dormir. Ao invés disso, eles meditam profundamente, permanecendo semiconscientes, durante 4 horas por dia.'),
(11, 5, 'Transe', 'Elfos não precisam dormir. Ao invés disso, eles meditam profundamente, permanecendo semiconscientes, durante 4 horas por dia.'),
(12, 4, 'Máscara da Natureza', 'Vantagem ao se esconder mesmo quando você está apenas levemente obscurecido por folhagem, chuva forte, neve caindo, névoa ou outro fenômeno natural.'),
(13, 5, 'Visão no Escuro Superior', 'Sua visão no escuro tem alcance de 36 metros de raio.'),
(14, 5, 'Sensibilidade à Luz Solar', 'Você possui desvantagem nas jogadas de ataque e testes de Sabedoria (Percepção) relacionados a visão quando você, o alvo do seu ataque, ou qualquer coisa que você está tentando perceber, esteja sob luz solar direta.'),
(15, 6, 'Sortudo', 'Quando você obtiver um 1 natural em uma jogada de ataque, teste de habilidade ou teste de resistência, você pode jogar de novo o dado e deve utilizar o novo resultado.'),
(16, 7, 'Sortudo', 'Quando você obtiver um 1 natural em uma jogada de ataque, teste de habilidade ou teste de resistência, você pode jogar de novo o dado e deve utilizar o novo resultado.'),
(17, 8, 'Sortudo', 'Quando você obtiver um 1 natural em uma jogada de ataque, teste de habilidade ou teste de resistência, você pode jogar de novo o dado e deve utilizar o novo resultado.'),
(18, 6, 'Bravura', 'Você tem vantagem em testes de resistência contra ficar amedrontado.'),
(19, 7, 'Bravura', 'Você tem vantagem em testes de resistência contra ficar amedrontado.'),
(20, 8, 'Bravura', 'Você tem vantagem em testes de resistência contra ficar amedrontado.'),
(21, 6, 'Agilidade Halfling', 'Você pode mover-se através do espaço de qualquer criatura que for de um tamanho maior que o seu.' ),
(22, 7, 'Agilidade Halfling', 'Você pode mover-se através do espaço de qualquer criatura que for de um tamanho maior que o seu.' ),
(23, 8, 'Agilidade Halfling', 'Você pode mover-se através do espaço de qualquer criatura que for de um tamanho maior que o seu.' ),
(24, 6, 'Furtividade Natural', 'Você pode tentar se esconder mesmo quando possuir apenas a cobertura de uma criatura que for no mínimo um tamanho maior que o seu.'),
(25, 7, 'Resiliência Anã','Você possui vantagem em testes de resistência contra venenos e resistência contra dano de veneno.' ),
(26, 12, 'Ancestral Dracônico', 'Você possui um ancestral dracônico. Escolha um tipo de dragão da tabela Ancestral Dracônico. Sua arma de sopro e resistência a dano são determinadas pelo tipo de dragão, como mostrado na tabela.'),
(27, 12, 'Arma de Sopro', 'Você pode usar uma ação para exalar energia destrutiva. Seu ancestral dracônico determina o tamanho, formado e tipo de dano que você expele. 
Quando você usa sua arma de sopro, cada criatura na área exalada deve realizar um teste de resistência, o tipo do teste é determinado pelo seu ancestral dracônico. A CD do teste de resistência é 8 + seu modificador de Constituição + seu bônus de proficiência. Uma criatura sofre 2d6 de dano num fracasso e metade desse dano num sucesso. O dano aumenta para 3d6 no 6° nível, 4d6 no 11° nível e 5d6 no 16° nível. 
Depois de usar sua arma de sopro, você não poderá utilizá-la novamente até completar um descanso curto ou longo.'),
(28, 12, 'Resistencia de Dano', 'Você possui resistência ao tipo de dano associado ao seu ancestral dracônico.'),
(29, 13, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(30, 14, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(31, 13, 'Esperteza Gnômica', 'Você possui vantagem em todos os testes de resistência de Inteligência, Sabedoria e Carisma contra magia.'),
(32, 14, 'Esperteza Gnômica', 'Você possui vantagem em todos os testes de resistência de Inteligência, Sabedoria e Carisma contra magia.'),
(33, 13, 'Falar com Bestas Pequenas','Através de sons e gestos, você pode comunicar ideias simples para Bestas pequenas ou menores.'),
(34, 14, 'Conhecimento de Artífice', 'Toda vez que você fizer um teste de Inteligência (História) relacionado a itens mágicos, objetos alquímicos ou mecanismos tecnológicos, você pode adicionar o dobro do seu bônus de proficiência, ao invés de qualquer bônus de proficiência que você normalmente use.'),
(35, 14, 'Engenhoqueiro', 'Você possui proficiência com ferramentas de artesão (ferramentas de engenhoqueiro). Usando essas ferramentas, você pode gastar 1 hora e 10 po em materiais para construir um mecanismo Miúdo (CA 5, 1 pv). O mecanismo para de funcionar após 24 horas (a não ser que você gaste 1 hora reparando-o para manter o mecanismo funcionando), ou quando você usa sua ação para desmantelá-lo; nesse momento, você pode recuperar o material usado para criá-lo. Você pode ter até trêsdesses mecanismos ativos ao mesmo tempo. 
Quando você criar um mecanismo, escolha uma das seguintes opções:
Brinquedo Mecânico. Esse brinquedo é um animal, monstro ou pessoa mecânica, como um sapo, rato, pássaro, dragão ou soldado. Quando colocado no chão, o brinquedo se move 1,5 metro pelo chão em cada umdos seus turnos em uma direção aleatória. Ele faz barulhos apropriados a criatura que ele representa. 
Isqueiro Mecânico. O mecanismo produz uma miniatura de chama, que você pode usar para acender uma vela, tocha ou fogueira. Usar o mecanismo requer sua ação. 
Caixa de Música. Quando aberta, essa caixa demúsica toca uma canção a um volume moderado. A caixa para de tocar quando alcança o fim da música ou quando é fechada.'),
(36, 9, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(37, 9, 'Ancestral Feérico', 'Você tem vantagem nos testes de resistência para resistir a ser enfeitiçado e magias não podem colocá-lo para dormir.'),
(38, 10, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(39, 10, 'Resistência Implacável', 'Quando você é reduzido a 0 pontos de vida mas não é completamente morto, você pode voltar para 1 ponto de vida. Você não pode usar essa característica novamente até completar um descanso longo.'),
(40, 10, 'Ataques Selvagens', 'Quando você atinge um ataque crítico com uma arma corpo-a-corpo, você pode rolar um dos dados de dano da arma mais uma vez e adicioná-lo ao dano extra causado pelo acerto crítico.'),
(41, 10, 'Visão no Escuro', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.'),
(42, 11, 'Resistência Infernal','Você possui resistência a dano de fogo.'),
(43, 11, 'Legado Infernal',' Você conhece o truque taumaturgia. Quando você atingir o 3° nível, você poderá conjurar a magia repreensão infernal como uma magia de 2° nível. Quando você atingir o 5° nível, você também poderá conjurar a magia escuridão. Você precisa terminar um descanso longo para poder usar as magias desse traço novamente. Sua habilidade de conjuração para essas magias é Carisma.');