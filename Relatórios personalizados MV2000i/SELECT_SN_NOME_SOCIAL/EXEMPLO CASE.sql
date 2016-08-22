SELECT CASE
  WHEN to_char(sysdate, 'MM') >= 1 AND to_char(sysdate, 'MM') <= 3 THEN
    'Primeiro Trimestre'
  WHEN to_char(sysdate, 'MM') >= 4 AND to_char(sysdate, 'MM') <= 6 THEN
    'Segundo Trimestre'
  WHEN to_char(sysdate, 'MM') >= 7 AND to_char(sysdate, 'MM') <= 9 THEN
    'Terceiro Trimestre'
  WHEN to_char(sysdate, 'MM') >= 10 AND to_char(sysdate, 'MM') <= 12 THEN
    'Quarto Trimestre'
  ELSE
    'Apareceu um mês novo no ano'
  END AS Trimestre
FROM dual