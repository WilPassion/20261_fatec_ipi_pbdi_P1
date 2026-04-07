-- Enunciado 1 - Base de dados e criação de tabela
CREATE TABLE titanic (
    passengerid SERIAL PRIMARY KEY,
    survived INT,
    pclass INT,
    sex VARCHAR(10),
    fare NUMERIC(10,2),
    embarked VARCHAR(1)
);

--Enunciado 2 - Sobrevivência em função da classe social
DO $$
DECLARE
    cur_titanic REFCURSOR;
    v_passengerid INT;
    total INT := 0;
BEGIN
    OPEN cur_titanic FOR
        SELECT passengerid
        FROM titanic
        WHERE pclass = 1 AND survived = 1;

    LOOP
        FETCH cur_titanic INTO v_passengerid;
        EXIT WHEN NOT FOUND;

        total := total + 1;
    END LOOP;

    CLOSE cur_titanic;

    RAISE NOTICE 'Total de sobreviventes na 1ª classe: %', total;
END $$;

-- Enunciado 3 - Sobrevivência em função do gênero
DO $$
DECLARE
    cur_survived REFCURSOR;
    v_passengerid INT;
    total INT := 0;
BEGIN
    OPEN cur_survived FOR EXECUTE
        'SELECT passengerid
         FROM titanic
         WHERE sex = ''female'' AND survived = 1';
 
    LOOP
        FETCH cur_survived INTO v_passengerid;
        EXIT WHEN NOT FOUND;
 
        total := total + 1;
    END LOOP;
 
    CLOSE cur_survived;
 
    IF total = 0 THEN
        RAISE NOTICE '%', -1;
    ELSE
        RAISE NOTICE 'Total de mulheres sobreviventes é de: %', total;
    END IF;
END $$;

--Enunciado 4 - Tarifa versus embarque
-- Enunciado 4 - Tarifa versus embarque
DO $$
DECLARE
    cur_cherbourg_fare CURSOR FOR
        SELECT passengerid
        FROM titanic
        WHERE fare > 50 AND embarked = 'C';
    passageiro INT;
    total INT := 0;
BEGIN
    OPEN cur_cherbourg_fare;

    LOOP
        FETCH cur_cherbourg_fare INTO passageiro;
        EXIT WHEN NOT FOUND;
        total := total + 1;
    END LOOP;

    CLOSE cur_cherbourg_fare;

    RAISE NOTICE 'O total de passageiros que pagaram mais de 50 é de: %', total;
END $$;