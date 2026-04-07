-- Enunciado 1 - Base de dados e criação de tabela
CREATE TABLE titanic (
    passengerid SERIAL PRIMARY KEY,
    survived INT,
    pclass INT,
    sex VARCHAR(10),
    fare DECIMAL(10,2),
    embarked VARCHAR(1)
);