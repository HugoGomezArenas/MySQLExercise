
-- create
CREATE TABLE ClienteNivel (
  Id INTEGER PRIMARY KEY,
  clienteId INT NOT NULL,
  nivelTipoId INT NOT NULL,
  Creado DATE , 
  Expirado DATE NULL
);

-- insert
INSERT INTO ClienteNivel VALUES (1,1020,10,'2021-01-01','2022-01-01');
INSERT INTO ClienteNivel VALUES (2,1021,10,'2022-01-01',NULL);
INSERT INTO ClienteNivel VALUES (3,1022,10,'2022-01-01',NULL);
INSERT INTO ClienteNivel VALUES (4,1022,11,'2023-01-01',NULL);

-- fetch 
SELECT 
  CNR.Id,CNR.clienteId,CNR.nivelTipoId,CNR.Creado,CNR.Expirado
FROM LATERAL(
  SELECT 
    clienteId 
  FROM 
    ClienteNivel
  WHERE 
    Expirado IS NULL 
  GROUP BY clienteID 
) AS CN,
LATERAL (
  SELECT 
      id,clienteId,nivelTipoId,Creado,Expirado
  FROM 
    ClienteNivel CN2
  WHERE 
    CN.clienteId = CN2.clienteId AND CN2.Expirado IS NULL 
  ORDER BY Creado DESC 
  LIMIT 1
) CNR