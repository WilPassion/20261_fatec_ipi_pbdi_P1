-- Enunciado 1 - Base de dados e criação de tabela
CREATE TABLE titanic (
    passengerid SERIAL PRIMARY KEY,
    survived INT,
    pclass INT,
    sex VARCHAR(10),
    fare DECIMAL(10,2),
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