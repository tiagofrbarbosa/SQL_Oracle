SELECT

    Count(*)
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '05-09-2014' AND '05-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central(+)
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'


SELECT CD_ESPECIALID FROM ATENDIME WHERE CD_PRESTADOR = 77

SELECT * FROM atendime WHERE DT_ATENDIMENTO BETWEEN '08-09-2014' AND '08-09-2014'

SELECT * FROM IT_AGENDA_CENTRAL